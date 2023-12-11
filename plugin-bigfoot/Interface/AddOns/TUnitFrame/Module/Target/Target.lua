--[[
	Player.lua
	实例化 模板并装载到TargetFrame上
	为其他子模块提供母模块
	Terry@bf
	2010 - 9 -30
	
]]
local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end 

local M = T:GetModule("Target",true) or T:NewModule("Target")
if not M then return end

local __3DPor = T.Templates and T.Templates.ThreeDportrait and T.Templates.ThreeDportrait:new()

local __ClassIcon = T.Templates and T.Templates.ClassIcon and T.Templates.ClassIcon:new()

function M:Toggle3DPor(flag)
	if flag then
		__3DPor:SetPoint("TOPLEFT", "TargetFrame", "TOPLEFT", 127, -17)
		__3DPor:Enable()
	else
		__3DPor:Disable()
	end
end

function M:ToggleClass(flag)
	if flag then
		__ClassIcon:Enable()
	else
		__ClassIcon:Disable()
	end
end

function M:OnInitialize()
	assert(__3DPor,"Target 3D template does not exist.")
	__3DPor:Create("Target",TargetFrame,TargetFramePortrait or TargetPortrait)

	assert(__ClassIcon,"Target class icon template does not exist.")
	__ClassIcon:Create(TargetFrame,"target")
	__ClassIcon:SetPoint("TOPLEFT",TargetFrame,"TOPLEFT",107,2)
	
	T:Debug("Target Module Initialized")	
end

function M:OnEnable()
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	T:Debug("Target Module Enabled")	
end

function M:OnDisable()
	T:Debug("Target Module Disabled")	
end