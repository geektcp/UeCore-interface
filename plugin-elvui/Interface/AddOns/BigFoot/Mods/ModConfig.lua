
local L = BLocal("ModConfig")
if GetLocale()=='zhCN' then
	L["Recount"] = "伤害统计"
	L["DBM"] = "首领报警"
	L["Grid"] = "团队框架"
	L["GDKP"] = "金团助手"
	L["Omen"] = "仇恨统计"
	L["Trinkets"] = "饰品管理"
	L["DualGather"] = "双采"
	L["Search"] = "搜索..."
elseif GetLocale()=='zhTW' then
	L["Recount"] = "傷害統計"
	L["DBM"] = "首領報警"
	L["Grid"] = "團隊框架"
	L["GDKP"] = "金團助手"
	L["Omen"] = "仇恨統計"
	L["Trinkets"] = "飾品管理"
	L["DualGather"] = "雙采"
	L["Search"] = "搜索..."

end

local M = LibStub("AceAddon-3.0"):GetAddon("MBB")

local nextCheckIndex = 1
local function __CreateCheckBox(text,modName,variableName)
	local check = CreateFrame("CheckButton","MBBBottomPanel"..nextCheckIndex,UIParent,"OptionsSmallCheckButtonTemplate")
	check:SetFrameLevel(8)
	check:SetHeight(20)
	check:SetWidth(20)
	check:SetHitRectInsets(0, -60, 0,0)
	_G[check:GetName().."Text"]:SetFontObject("NumberFont_Shadow_Med");
	_G[check:GetName().."Text"]:SetTextHeight(12)
	_G[check:GetName().."Text"]:SetText(text)
	check:SetScript("OnShow",function()
		check:SetChecked(BigFoot_GetModVariable(modName,variableName))
	end)
	check:SetScript("OnClick",function()
		local __checked = check:GetChecked();
		if ( not __checked ) then
			__checked = 0;
		end
		BigFoot_SetModVariable(modName, variableName, __checked);
		local _,choice = ModManagement_GetDefaultValue(modName,variableName)
		local callback = choice and choice.callback
		callback(__checked)
		if (choice.adText) and __checked~=0 then
			print(string.format(MOD_MANAGEMENT_AD_TEXT,choice.adText))
		end
	end)
	nextCheckIndex = nextCheckIndex + 1
	return check
end

function IsLegalSearchText(text)
	if strlen(text)>=3 and  strlen(text)<20 then
		return true
	end
	return false
end

local function __CreateBigFootButtons()
	local bfButton = BLibrary("BFButton", M.panel, 80, 28);
	local logButton = BLibrary("BFButton", M.panel, 80, 28);
	local search = BLibrary("BFSearch", M.panel, 110, 27,L["Search"]);
	
	bfButton.OnClick = function(bn)
		if not ModManagementFrame:IsShown() then
			ShowUIPanel(ModManagementFrame)
		else
			HideUIPanel(ModManagementFrame)
		end
	end
	logButton.OnClick = function(bn)
		HideUIPanel(ModManagementFrame);
		BigFootReader_ShowBook(BF_CHANGELOG_TEXT);
	end
	search.peek = ModManageMentFrame_SearchPeek
	search.onEmpty = function() end
	search.callback = function(text)
		ShowUIPanel(ModManagementFrame)
		ModManagementFrame_SearchMod(text)
		ModManagementFrame_SearchEntries(text)
		ModManagementFrameSearchFrameEditBox:SetText(text)
		ModManagementFrameSearchFrameEditBox:SetFontObject("ChatFontNormal")
	end
	search.validation = IsLegalSearchText
	bfButton:SetText(MOD_MANAGEMENT_FRAME_TITLE)
	logButton:SetText(MOD_MANAGEMENT_DETAIL_TEXT)	
	bfButton:Show()
	logButton:Show()
	search:Show()
	return bfButton,logButton,search
end

local function __AddBigFootButtons()
	local bfButton, logButton ,search = __CreateBigFootButtons()
	M:AddFrame(bfButton,"TOPLEFT",M.panel,"TOPLEFT",12,-13)
	M:AddFrame(logButton,"TOPLEFT",M.panel,"TOPLEFT",97,-13)
	M:AddFrame(search,"TOPRIGHT",M.panel,"TOPRIGHT",-13,-15)
end

local function __AddBottomFrames()
	local check1 = __CreateCheckBox(L["Recount"], "RaidToolkit","EnableRecount")
	local check2 = __CreateCheckBox(L["DBM"],"RaidToolkit","EnableDBM")
	local check3 = __CreateCheckBox(L["Grid"],"RaidToolkit","EnableGrid")
	local check4 = __CreateCheckBox(L["GDKP"],"MiDKP","GDKPEnable")
	local check5 = __CreateCheckBox(L["Omen"],"RaidToolkit","EnableThreat")
	local check6 = __CreateCheckBox(L["Trinkets"],"TrinketMenu","EnableTrinketMenu")
	M:AddBottomButton(check1)
	M:AddBottomButton(check2)
	M:AddBottomButton(check3)
	M:AddBottomButton(check4)
	M:AddBottomButton(check5)
	M:AddBottomButton(check6)

end

local function __AddVolumeBar()
	local bar = _G["BFVolumeSlider"]
	bar:SetParent(M.panel)
	M.volumnBar = bar
	bar:SetPoint("TOPLEFT",M.panel,"TOPRIGHT", -29, -69)
	bar:SetPoint("BOTTOMLEFT",M.panel,"BOTTOMRIGHT", -29, 26)
	bar:Show()
	local mute = _G["BFVolumnMuteButton"]
	mute:SetParent(M.panel)
	mute:SetPoint("BOTTOMLEFT",M.panel,"BOTTOMRIGHT", -37, 5)
	mute:Show()
end

hooksecurefunc(M,"OnEnable",function(self)
	__AddBigFootButtons()
	__AddBottomFrames()
	__AddVolumeBar()
end)

	