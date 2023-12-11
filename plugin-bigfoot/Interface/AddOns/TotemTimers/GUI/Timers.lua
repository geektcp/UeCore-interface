-- Copyright © 2008 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local ElementValues = {
	[EARTH_TOTEM_SLOT] = L["Earth"],
	[FIRE_TOTEM_SLOT] = L["Fire"],
	[WATER_TOTEM_SLOT] = L["Water"],
	[AIR_TOTEM_SLOT] = L["Air"],
}

local function SetOrder(nr, value)
	local fromnr = 0;
	for i=1,4 do
		if TotemTimers_Settings.Order[i] == value then fromnr = i end
	end
	TotemTimers_Settings.Order[fromnr] = TotemTimers_Settings.Order[nr]
	TotemTimers_Settings.Order[nr] = value
	TotemTimers.ProcessSetting("Order")
end

TotemTimers.options.args.timers = {
    type = "group",
    name = "timers",
    args = {
         show = {
            order = 0,
            type = "toggle",
            name = L["Enable"],
            set = function(info, val) TotemTimers_Settings.Show = val  TotemTimers.ProcessSetting("Show") end,
            get = function(info) return TotemTimers_Settings.Show end,
        },
        h1 = {
            order = 1,
            type = "header",
            name = "",
        },
        arrange = {
            order = 6,
            type = "select",
            name = L["Arrangement"],
            values = {vertical = L["vertical"], horizontal = L["horizontal"],
                      box = L["box"], free = L["loose"],},
            set = function(info, val)
                        TotemTimers_Settings.Arrange = val
                        if not TotemTimers_Settings.MenusAlwaysVisible then
                            if val ~= "free" then
                                TotemTimers_Settings.CastBarDirection = "auto"
                            else
                                TotemTimers_Settings.CastBarDirection = "right"
                            end
                        end
                        TotemTimers_OrderTimers()
                        TotemTimers_PositionCastButtons()
                        for i=1,4 do
                            XiTimers.timers[i]:SetTimerBarPos(XiTimers.timers[i].timerBarPos, true)
                        end
                  end,
            get = function(info) return TotemTimers_Settings.Arrange end,
        },
        timepos = {
            order = 9,
            type = "select",
            name = L["Timer Bar Position"],
            desc = L["Timer Bar Position Desc"],
            values = {	["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"],},
            set = function(info, val)
                        TotemTimers_Settings.TimerTimePos = val  TotemTimers.ProcessSetting("TimerTimePos")
                  end,
            get = function(info) return TotemTimers_Settings.TimerTimePos end,
        },
        sizes = {
            order = 10,
            type = "header",
            name = L["Scaling"],
        },
        timerSize = {
            order = 11,
            type = "range",
            name = L["Button Size"],
            desc = L["Scales the timer buttons"],
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers_Settings.TimerSize = val  TotemTimers.ProcessSetting("TimerSize")
                  end,
            get = function(info) return TotemTimers_Settings.TimerSize end,
        },
        timerTimeHeight = {
            order = 12,
            type = "range",
            name = L["Time Size"],
            desc = L["Sets the font size of time strings"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers_Settings.TimerTimeHeight = val  TotemTimers.ProcessSetting("TimerTimeHeight")
                  end,
            get = function(info) return TotemTimers_Settings.TimerTimeHeight end,
        },
        spacing = {
            order = 13,
            type = "range",
            name = L["Spacing"] ,
            desc = L["Sets the space between timer buttons"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers_Settings.TimerSpacing = val  TotemTimers.ProcessSetting("TimerSpacing")
                  end,
            get = function(info) return TotemTimers_Settings.TimerSpacing end,
        },
        advanced = {
            order = 30,
            type = "header",
            name = L["Advanced Options"],
        },
        openright = {
            order = 31,
            type = "toggle",
            name = L["Open On Rightclick"],
            desc = L["Rightclick Desc"],
            set = function(info, val) TotemTimers_Settings.OpenOnRightclick = val  TotemTimers.ProcessSetting("OpenOnRightclick") end,
            get = function(info) return TotemTimers_Settings.OpenOnRightclick end,
        },
        miniicons = {
            order = 35,
            type = "toggle",
            name = L["Show Mini Icons"],
            desc = L["Mini Icons Desc"],
            set = function(info, val) TotemTimers_Settings.MiniIcons = val  TotemTimers.ProcessSetting("MiniIcons") end,
            get = function(info) return TotemTimers_Settings.MiniIcons end,
        },
        procflash = {
            order = 36,
            type = "toggle",
            name = L["Enable Pulse Bar"],
            desc = L["Pulse desc"],
            set = function(info, val) TotemTimers_Settings.ProcFlash = val  TotemTimers.ProcessSetting("ProcFlash") end,
            get = function(info) return TotemTimers_Settings.ProcFlash end,
        },
        ShowCooldowns = {
            order = 38,
            type = "toggle",
            name = L["Show Totem Cooldowns"],
            set = function(info, val) TotemTimers_Settings.ShowCooldowns = val  TotemTimers.ProcessSetting("ShowCooldowns") end,
            get = function(info) return TotemTimers_Settings.ShowCooldowns end,
        },
        PlayerRange = {
            order = 39,
            type = "toggle",
            name = L["Player Range"],
            desc = L["Player Range Desc"],
            set = function(info, val) TotemTimers_Settings.CheckPlayerRange = val  TotemTimers.ProcessSetting("CheckPlayerRange") end,
            get = function(info) return TotemTimers_Settings.CheckPlayerRange end,
        },
        RaidRange = {
            order = 40,
            type = "toggle",
            name = L["Raid Member Range"],
            desc = L["Range Desc"],
            set = function(info, val) TotemTimers_Settings.CheckRaidRange = val  TotemTimers.ProcessSetting("CheckRaidRange") end,
            get = function(info) return TotemTimers_Settings.CheckRaidRange end,
        },
        RaidRangeTooltip = {
            order = 41,
            type = "toggle",
            name = L["Raid Range Tooltip"],
            desc = L["RR Tooltip Desc"],
            set = function(info, val) TotemTimers_Settings.ShowRaidRangeTooltip = val  TotemTimers.ProcessSetting("ShowRaidRangeTooltip") end,
            get = function(info) return TotemTimers_Settings.ShowRaidRangeTooltip end,
        },
    },
}

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Timers"], "TotemTimers", "timers")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")