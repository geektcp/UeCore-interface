-----------------------------------
----- Core.lua
----- 使用Ace库创建插件 并提供开关
----- 2010 - 09 - 29 
----- Terry@ bf
-----------------------------------
TUF_Config = {}

local T = LibStub("AceAddon-3.0"):NewAddon("TUnitFrame")
if not T then return end
T:SetDefaultModuleLibraries("AceEvent-3.0")
T:SetDefaultModuleState(false)
local _debug = false

local function debug_print(addon , ...)
	if _debug and BigFoot_Print then
		BigFoot_Print(...)
	end
end

local party,target,player

function TUnitFrame_SwitchPartyTarget(flag)
	party = T:GetModule("Party")
	assert(party,"Party target module does not exist")
	party:ToggleTarget(flag)
end

function TUnitFrame_SwitchPartyCastBar(flag)
	party = T:GetModule("Party")
	assert(party,"Party target module does not exist")
	party:ToggleCastBar(flag)
end

function TUnitFrame_Switch3DPor(flag)
	party = T:GetModule("Party")
	target = T:GetModule("Target")
	player = T:GetModule("Player")
	party:Toggle3DPor(flag)
	target:Toggle3DPor(flag)
	player:Toggle3DPor(flag)
end

function TUnitFrame_SwitchClassInfo(flag)
	party = T:GetModule("Party")
	target = T:GetModule("Target")
	
	party:ToggleClass(flag)
	target:ToggleClass(flag)
end

function TUnitFrame_SwitchPlayerInfoPane(flag)
	player = T:GetModule("Player")
	player:ToggleInfoPane(flag)
end

function TUnitFrame_SwitchMemberInfoPane(flag)
	party = T:GetModule("Party")
	party:ToggleInfoPane(flag)
end

function TUnitFrame_SwitchColorize(flag)
	party = T:GetModule("Party")
	player = T:GetModule("Player")
	player:ToggleColorize(flag)
	party:ToggleColorize(flag)
end

function TUnitFrame_SwitchFormat(flag)
	party = T:GetModule("Party")
	player = T:GetModule("Player")
	player:ToggleFormattedText(flag)
	party:ToggleFormattedText(flag)
end

function TUnitFrame_SwitchExpBar(flag)
	player = T:GetModule("Player")
	if flag then
		player:ToggleInfoPane(flag)
		player:ToggleExpBar(flag)
	else
		player:ToggleExpBar(flag)
	end
end

function T:OnInitialize()
	self.Debug = debug_print
	self:Debug("TUnitFrame loaded")
end

function T:OnEnable()
	if TUF_Config.inited then return end
	SetCVar("statusTextPercentage","0")
	SetCVar("partyStatusText","0")
	SetCVar("playerStatusText","1")
	TUF_Config.inited = true
end

function T:OnDisable()
end