-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)

local buttonlocations = {
	{"BOTTOM", "TOP"},
	{"BOTTOMLEFT", "TOPRIGHT"},
	{"LEFT", "RIGHT"},
	{"TOPLEFT", "BOTTOMRIGHT"},
	{"TOP", "BOTTOM"},
	{"TOPRIGHT", "BOTTOMLEFT"},
	{"RIGHT", "LEFT"},
	{"BOTTOMRIGHT", "TOPLEFT"},
}

function TotemTimers_InitSetButtons()
    ankh = XiTimers.timers[5].button
    TotemTimers_ProgramSetButtons()
end

function TotemTimers_ProgramSetButtons()
    local Sets = TotemTimers_Settings.TotemSets
	
	local nr = 0
	for i=1,8 do
        local b = _G["TotemTimers_SetButton"..i]
        if not b then
            b = CreateFrame("Button", "TotemTimers_SetButton"..i, XiTimers.timers[5].button, "TotemTimers_SetButtonTemplate")
        end
        b:SetPoint(buttonlocations[i][1], XiTimers.timers[5].button, buttonlocations[i][2])
        if Sets[i] then
            for k = 1,4 do
                local icon = _G[b:GetName().."Icon"..k]
                if Sets[i][k] > 0 then
                    local _,_,texture = GetSpellInfo(Sets[i][k])				
                    TotemTimers.SetEmptyTexCoord(icon)
                    icon:SetTexture(texture)
                else
                    TotemTimers.SetEmptyTexCoord(icon,k)
                    icon:SetTexture(TotemTimers.emptyTotem)
                end     
            end
            b:SetAttribute("inactive", false)            
        else
            b:SetAttribute("inactive", true)
            b:Hide()
        end
	end
end

function TotemTimers_SetButton_OnClick(self, button)
    if InCombatLockdown() then return end
    XiTimers.timers[5].button:SetAttribute("hide", true)
	if button == "RightButton" then
		local popup = StaticPopup_Show("TOTEMTIMERS_DELETESET", self.nr)
		popup.data = self.nr
    elseif button == "LeftButton" then
        local ms = TotemTimers_MultiSpell:GetAttribute("*spell1")
        local set = TotemTimers_Settings.TotemSets[self.nr]
        if set and ms then 
            for i=1,4 do
                set[i] = TotemTimers.GetMaxRank(set[i]) or set[i]
                SetMultiCastSpell(TotemTimers.MultiCastActions[i][ms], set[i])
            end
            TotemTimers.SetupTotemButtons()
        end
	end
end

StaticPopupDialogs["TOTEMTIMERS_DELETESET"] = {
  text = L["Delete Set"],
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  whileDead = 1,
  hideOnEscape = 1,
  timeout = 0,
  OnAccept = TotemTimers_DeleteSet,
}