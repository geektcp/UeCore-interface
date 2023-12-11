-- Copyright © 2008 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local nrfonts = 0

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local LSM = LibStub:GetLibrary("LibSharedMedia-3.0", true)

local function reset()
    TotemTimers_Settings = {}
    TotemTimers_SpecSettings = {}
    ReloadUI()
end

TotemTimers.options = {
    type = "group",
    args = {
        general = {
            type = "group",
            name = "general",
            args = {
                lock = {
                    order = 1,
                    type = "toggle",
                    name = L["Lock"],
                    desc = L["Locks the position of TotemTimers"],
                    set = function(info, val) TotemTimers_Settings.Lock = val TotemTimers.ProcessSetting("Lock") end,
                    get = function(info) return TotemTimers_Settings.Lock end,
                },
                flashred = {
                    order = 2,
                    type = "toggle",
                    name = L["Red Flash Color"],
                    desc = L["RedFlash Desc"],
                    set = function(info, val) TotemTimers_Settings.FlashRed = val TotemTimers.ProcessSetting("FlashRed") end,
                    get = function(info) return TotemTimers_Settings.FlashRed end,
                },
                stoppulse = {
                    order = 2,
                    type = "toggle",
                    name = L["Stop Pulse"],
                    desc = L["Stop Pulse Desc"],
                    set = function(info, val) TotemTimers_Settings.StopPulse = val TotemTimers.ProcessSetting("StopPulse") end,
                    get = function(info) return TotemTimers_Settings.StopPulse end,
                },
                showtimerbars = {
                    order = 2,
                    type = "toggle",
                    name = L["Show Timer Bars"],
                    desc = L["Displays timer bars underneath times"],
                    set = function(info, val) TotemTimers_Settings.ShowTimerBars = val TotemTimers.ProcessSetting("ShowTimerBars") end,
                    get = function(info) return TotemTimers_Settings.ShowTimerBars end,
                },
                hideblizztimers = {
                    order = 3,
                    type = "toggle",
                    name = L["Hide Blizzard Timers"],
                    set = function(info, val) TotemTimers_Settings.HideBlizzTimers = val TotemTimers.ProcessSetting("HideBlizzTimers") end,
                    get = function(info) return TotemTimers_Settings.HideBlizzTimers end,
                },
                hidedefaulttotembar = {
                    order = 3,
                    type = "toggle",
                    name = L["Hide Default Totem Bar"],
                    desc = L["Hide Default Totem Bar Desc"],
                    set = function(info, val) TotemTimers_Settings.HideDefaultTotemBar = val
                            TotemTimers.ProcessSetting("HideDefaultTotemBar") end,
                    get = function(info) return TotemTimers_Settings.HideDefaultTotemBar  end,
                },
                tooltips = {
                    order = 3,
                    type = "toggle",
                    name = L["Show Tooltips"],
                    desc = L["Shows tooltips on timer and totem buttons"],
                    set = function(info, val) TotemTimers_Settings.Tooltips = val TotemTimers.ProcessSetting("Tooltips") end,
                    get = function(info) return TotemTimers_Settings.Tooltips end,
                },
                HideInVehicle = {
                    order = 3,
                    type = "toggle",
                    name = L["Hide In Vehicles"],
                    desc = L["Hide In Vehicles Desc"],
                    set = function(info, val) TotemTimers_Settings.HideInVehicle = val TotemTimers.ProcessSetting("HideInVehicle") end,
                    get = function(info) return TotemTimers_Settings.HideInVehicle end,
                },
            },
        },
    },
}

ACR =	LibStub("AceConfigRegistry-3.0")
ACR:RegisterOptionsTable("TotemTimers", TotemTimers.options)
local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", "TotemTimers", nil, "general")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
TotemTimers.LastGUIPanel = frame



