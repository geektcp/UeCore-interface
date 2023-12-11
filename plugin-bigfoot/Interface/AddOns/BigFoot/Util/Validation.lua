if (GetLocale() == "zhCN") then
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的KK魔兽版本已过期，请用KK魔兽客户端更新，最新版本为:%s，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的KK魔兽版本错误，请重新用KK魔兽客户端更新，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"

elseif (GetLocale() == "zhTW") then
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的大腳版本已過期，請用大腳客戶端更新，最新版本為:%s，大腳插件由everwar开源魔兽(https://everwar.cn)制作。|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的KK魔兽版本錯誤，请重新用KK魔兽客户端更新，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"
else
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 Your BigFoot version is outdated, please upgrade to current version %s|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 Your BigFoot version is incorrect, please download again.|r"

end


StaticPopupDialogs["BFUPDATE"] ={
	button1 = TEXT(BIGFOOT_CONFIRM),
	OnAccept = function()
	end,
	showAlert = 1,
	timeout = 0,
};

BIGFOOT_VERSION_QUERY="BIGFOOT_VERSION_QUERY"



local e = BLibrary("BEvent")
local BMath = BLibrary("BMathClass")

local function sameLocale(a,b)
	local localea = a:match("[a-zA-Z]+")
	local localeb = b:match("[a-zA-Z]+")
	if not localea or not localeb then return true end
	--to be compatible with old version
	if localea ~= localeb then
		return false
	else
		return true
	end
end

local function larger(a,b)
	local adt={}
	local bdt={} 
	local ad,bd
	for ad in a:gmatch("%d+")  do
		tinsert(adt,ad)
	end
	for bd in b:gmatch("%d+")  do
		tinsert(bdt,bd)
	end
	
	for i=3,4 do
		if adt[i]>bdt[i] then return true end
		if adt[i]<bdt[i] then return false end
	end
	return false
end

local function printVersion(version)
	BigFoot_Print(format(BF_TEXT_UPDATETOVERSION,version))
	StaticPopupDialogs["BFUPDATE"].text=format(BF_TEXT_UPDATETOVERSION,version)
	StaticPopup_Show("BFUPDATE");
end

local function printWrongVersion()
	BigFoot_Print(BF_TEXT_WRONGVERSION)
	StaticPopupDialogs["BFUPDATE"].text=BF_TEXT_WRONGVERSION
	StaticPopup_Show("BFUPDATE");
end

local function checkVersion (message)
	if not BigFoot_Config["BIGFOOT_VERSION_NEW"] then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=BIGFOOT_VERSION
	elseif sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) and larger(BIGFOOT_VERSION,BigFoot_Config["BIGFOOT_VERSION_NEW"]) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=BIGFOOT_VERSION
	end
	if(sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],message) and larger(message,BigFoot_Config["BIGFOOT_VERSION_NEW"])) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=message
	end
end
	
local function isValid (message)
	local i = 1;
	local checksum,version
	for word in string.gmatch(message,"([^|]+)") do
		if i == 1 then checksum = word end
		if i == 2 then version = word end
		i = i + 1;
	end
	if checksum == BMath:LRC(version) then return true end
	return false
end

e:RegisterEvent("PLAYER_LOGIN");
e:RegisterEvent("CHAT_MSG_ADDON");
e:RegisterEvent("RAID_ROSTER_UPDATE")
e:RegisterEvent("PARTY_MEMBERS_CHANGED")
	
function e:PLAYER_LOGIN()
	if not isValid(BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION) then 
		printWrongVersion();
		return;
	end
	if not BigFoot_Config["BIGFOOT_VERSION_NEW"] then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=BIGFOOT_VERSION
	elseif not sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=BIGFOOT_VERSION
	elseif larger(BIGFOOT_VERSION,BigFoot_Config["BIGFOOT_VERSION_NEW"]) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"]=BIGFOOT_VERSION
	end
	if sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) and larger(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) then
		printVersion(BigFoot_Config["BIGFOOT_VERSION_NEW"])
	end
	BF_inraid=false
end

function e:CHAT_MSG_ADDON(...)
	local filter,message,_,sender =...
	if(filter == "BF")then
		if message ==BIGFOOT_VERSION_QUERY then
			if not isValid(BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION) then return end
			SendAddonMessage("BF",BIGFOOT_VERSION,'WHISPER',sender)
		end
	end
	if(filter =="BF_VERSION_WITH_CHECK") then
		if message ==BIGFOOT_VERSION_QUERY then
			SendAddonMessage("BF_VERSION_WITH_CHECK",BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION,'WHISPER',sender)
		else
			if not isValid(message)then return end
			local version = string.sub(message, string.find(message, "|(.+)")+1)
			checkVersion(version)
		end
	end
end

function e:RAID_ROSTER_UPDATE()
	local raidmember =GetNumRaidMembers()
	if raidmember <= 0 then 
		BF_inraid=false 
		return 
	end
	if not BF_inraid then
		BF_inraid=true
		local playername=UnitName('player')
		if not isValid(BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION) then return end
		for i=1, raidmember do
			local name = UnitName('raid'..i)
			if name ~= UNKNOWN and UnitIsConnected(name) and UnitIsSameServer("player",name) and name~=playername then
				SendAddonMessage("BF_VERSION_WITH_CHECK",BIGFOOT_VERSION_QUERY,'WHISPER',name)						
			end
		end
	end
end

function e:PARTY_MEMBERS_CHANGED()
	if GetNumRaidMembers() > 0 then return end

	local partymember =GetNumPartyMembers()
	if partymember >= 1 then
		if not BF_inraid then
			BF_inraid=true
			if not isValid(BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION) then return end
			for i=1, partymember do
				local name = UnitName('party'..i)
				if name ~= UNKNOWN and UnitIsConnected(name) and UnitIsSameServer("player",name) then
					SendAddonMessage("BF_VERSION_WITH_CHECK",BIGFOOT_VERSION_QUERY,'WHISPER',name)
				end
			end
		end
	else
		BF_inraid=false
	end
end

----also put ace validation here
local _LibStubVersion = 2

local __AceVersionTable = {
	["AceLibrary"] = 91091,
	["AceOO-2.0"] = 91091,
	["AceEvent-2.0"] = 91097,
	["AceDB-2.0"] = 91094,
	["AceDebug-2.0"] = 91091,
	["AceLocale-2.2"] = 91094,
	["AceConsole-2.0"] = 91094,
	["AceAddon-2.0"] = 91100,
	["AceHook-2.1"] = 91091,
	["AceModuleCore-2.0"] = 91091,
	["CallbackHandler-1.0"] = 5,

	["AceAddon-3.0"] = 5,
	["AceEvent-3.0"] = 3,
	["AceTimer-3.0"] = 5,
	["AceBucket-3.0"] = 3,
	["AceHook-3.0"] = 5,
	["AceDB-3.0"] = 21,
	["AceDBOptions-3.0"] = 12,
	["AceLocale-3.0"] = 2,
	["AceConsole-3.0"] = 7,
	["AceGUI-3.0"] = 33,
	["AceConfig-3.0"] = 2,
	["AceConfigRegistry-3.0"] = 12,
	["AceConfigTab-3.0"] = 1,
	["AceConfigCmd-3.0"] = 12,
	["AceConfigDialog-3.0"] = 49,
	["AceComm-3.0"] = 6,
	["AceTab-3.0"] = 8,
	["AceSerializer-3.0"] = 3,
	["AceGUISharedMediaWidgets-1.0"] = 32,

	
	["Abacus-2.0"] = 92247000,
	["LibCrayon-3.0"] = 91800,
	["LibQuixote-2.0"] = 90180,
	["LibBossIDs-1.0"] = 44,
	["Dewdrop-2.0"] = 90320,
	["FuBarPlugin-MinimapContainer-2.0"] = 90003,
	["LibAboutPanel"] = 1,
	["Roster-2.1"] = 90092,
	["LibBabble-Boss-3.0"] = 90298,
	["LibBabble-Class-3.0"] = 90050,
	["LibBabble-3.0"] = 2,
	["LibBabble-Inventory-3.0"] = 90101,
	["LibDBIcon-1.0"] = 11,
	["LibAbacus-3.0"] = 92247,
	["Waterfall-1.0"] = 90130,
	
	["Gratuity-2.0"] = 70090039,
	["CandyBar-2.0"] = 90154,
	["LibGraph-2.0"] = 90041,
	["Tablet-2.0"] = 90216,
	["LibStatLogic-1.1"] = 92,
	["LibGratuity-3.0"] = 90039,
	["LibDualSpec-1.0"] = 4,
	["LibPeriodicTable-3.1"] = 90006,
	["LibBabble-Zone-3.0"] = 90279,
	["LibTourist-3.0"] = 90098,
	["LibSink-2.0"] = 90063,
	["LibDataBroker-1.1"] = 4,
	["LibBabble-Spell-3.0"] = 90123,
	["LibSimpleFrame-1.0"] = 90046,
	["LibSharedMedia-3.0"] = 90058,
	["Window-1.0"] = 90034,
	["LibBanzai-2.0"] = 90040,
	["LibTipHooker-1.1"] = 11,
	["LibHealComm-4.0"] = 66,
	["Crayon-2.0"] = 91800000,
	["FuBarPlugin-2.0"] = 90003,

}

local function existAssert(_libName)
	if _G[_libName] or LibStub:GetLibrary(_libName,true) then return true end
	print(("|cffff0000<Version Check>|r%s does not exist!"):format(_libName))
	return false
end

local function versionAssert(_exp,_act,_libName)
	if not _exp == _act then
		print (("|cffff0000<Version Check>|r %s version incorrect! expect: %s, found: %s !"):format(_libName,_exp,_act))
	end
end

function ValidateAceLibs()
	local _versionExp,_versionAct

	--check LibStub
	if not existAssert("LibStub") then return end
	versionAssert(_LibStubVersion,LibStub.minor,"LibStub")
	
	for _major,minorExp in pairs(__AceVersionTable) do
		if existAssert(_major) then 
			local _,_minorAct = LibStub:GetLibrary(_major,true);
			versionAssert(_minorAct,minorExp,_major)
		end
	end
	print("|cff00FF00<Version Check>|r Validation passed, All AceLibs are in correct versions!")
end
