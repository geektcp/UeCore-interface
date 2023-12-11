-- Copyright © 2008 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)


TotemTimers.options.args.trackers = {
    type = "group",
    name = "trackers",
    args = {
        h1 = {
            order = 1,
            type = "header",
            name = "",
        },
        TrackerArrange = {
            order = 2,
            type = "select",
            name = L["Arrangement"],
            values ={vertical = L["vertical"], horizontal = L["horizontal"], free = L["loose"],},
            set = function(info, val) 
                TotemTimers_Settings.TrackerArrange = val
                TotemTimers_OrderTrackers()
                XiTimers.timers[5]:SetTimerBarPos(XiTimers.timers[5].timerBarPos, true)
            end,
            get = function(info) return TotemTimers_Settings.TrackerArrange end,
        },  
        trackertimepos = {
            order = 9,
            type = "select",
            name = L["Timer Bar Position"],
            desc = L["Timer Bar Position Desc"],
            values = {	["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["TOP"] = L["Top"], ["BOTTOM"] = L["Bottom"],},
            set = function(info, val)
                        TotemTimers_Settings.TrackerTimePos = val  TotemTimers.ProcessSetting("TrackerTimePos")	
                  end,
            get = function(info) return TotemTimers_Settings.TrackerTimePos end,
        },
        sizes = {
            order = 10,
            type = "header",
            name = L["Scaling"],
        },
        trackerSize = {
            order = 11,
            type = "range",
            name = L["Button Size"],
            desc = L["Scales the timer buttons"],
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers_Settings.TrackerSize = val  TotemTimers.ProcessSetting("TrackerSize")	
                  end,
            get = function(info) return TotemTimers_Settings.TrackerSize end,
        },
        trackerTimeHeight = {
            order = 12,
            type = "range",
            name = L["Time Size"],
            desc = L["Sets the font size of time strings"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers_Settings.TrackerTimeHeight = val  TotemTimers.ProcessSetting("TrackerTimeHeight")	
                  end,
            get = function(info) return TotemTimers_Settings.TrackerTimeHeight end,
        },
        trackertimespacing = {
            order = 13,
            type = "range",
            name = L["Spacing"] ,
            desc = L["Sets the space between timer buttons"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers_Settings.TrackerSpacing = val  TotemTimers.ProcessSetting("TrackerSpacing")	
                  end,
            get = function(info) return TotemTimers_Settings.TrackerSpacing end,
        },
        advanced = {
            order = 14,
            type = "header",
            name = L["Advanced Options"],
        },
        individual = {
            name = L["Trackers"] ,
            type = "group",
            order = 30,
            args = {
                ankh = {
                    order = 1,
                    name = L["Ankh Tracker"],
                    desc = L["Ankh Tracker Desc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers_Settings.AnkhTracker = val  TotemTimers.ProcessSetting("AnkhTracker") end,
                            get = function(info) return TotemTimers_Settings.AnkhTracker end,
                        },  
                    },
                },
                shield = {
                    order = 2,
                    name = L["Shield Tracker"],
                    desc = L["Shield Tracker Desc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveSpecSettings.ShieldTracker = val  TotemTimers.ProcessSpecSetting("ShieldTracker") end,
                            get = function(info) return TotemTimers.ActiveSpecSettings.ShieldTracker end,
                        },  
                        LeftButton = {
                            order = 2,
                            type = "select",
                            name = L["Leftclick"],
                            values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                                       [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                                       [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                                     },
                            set = function(info, val) TotemTimers_Settings.ShieldLeftButton = val  
                                     TotemTimers.ProcessSetting("ShieldLeftButton") end,
                            get = function(info) return TotemTimers_Settings.ShieldLeftButton end,
                        },  
                        RightButton = {
                            order = 3,
                            type = "select",
                            name = L["Rightclick"],
                            values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                                       [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                                       [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                                     },
                            set = function(info, val) TotemTimers_Settings.ShieldRightButton = val  
                                     TotemTimers.ProcessSetting("ShieldRightButton") end,
                            get = function(info) return TotemTimers_Settings.ShieldRightButton end,
                        },  
                        MiddleButton = {
                            order = 4,
                            type = "select",
                            name = L["Middle Button"],
                            values = { [SpellNames[SpellIDs.LightningShield]] = SpellNames[SpellIDs.LightningShield],
                                       [SpellNames[SpellIDs.WaterShield]] = SpellNames[SpellIDs.WaterShield],
                                       [SpellNames[SpellIDs.TotemicCall]] = SpellNames[SpellIDs.TotemicCall],
                                     },
                            set = function(info, val) TotemTimers_Settings.ShieldMiddleButton = val  
                                     TotemTimers.ProcessSetting("ShieldMiddleButton") end,
                            get = function(info) return TotemTimers_Settings.ShieldMiddleButton end,
                        },  
                    },
                },                
                earthshield = {
                    order = 3,
                    name = L["Earth Shield Tracker"],
                    desc = L["EarthShieldDesc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers_Settings.EarthShieldTracker = val 
                                    TotemTimers.ProcessSetting("EarthShieldTracker") end,
                            get = function(info) return TotemTimers_Settings.EarthShieldTracker end,
                        },  
                        LeftButton = {
                            order = 2,
                            type = "select",
                            name = L["Leftclick"],
                            values = { focus = L["focus"],
                                       target = L["target"],
                                       targettarget = L["targettarget"],
                                       player = L["player"],
                                       recast = L["esrecast"]
                                     },
                            set = function(info, val) TotemTimers_Settings.EarthShieldLeftButton = val  
                                     TotemTimers.ProcessSetting("EarthShieldLeftButton") end,
                            get = function(info) return TotemTimers_Settings.EarthShieldLeftButton end,
                        },  
                        RightButton = {
                            order = 3,
                            type = "select",
                            name = L["Rightclick"],
                            values = { focus = L["focus"],
                                       target = L["target"],
                                       targettarget = L["targettarget"],
                                       player = L["player"],
                                       recast = L["esrecast"]
                                     },
                            set = function(info, val) TotemTimers_Settings.EarthShieldRightButton = val  
                                     TotemTimers.ProcessSetting("EarthShieldRightButton") end,
                            get = function(info) return TotemTimers_Settings.EarthShieldRightButton end,
                        },  
                        MiddleButton = {
                            order = 4,
                            type = "select",
                            name = L["Middle Button"],
                            values = { focus = L["focus"],
                                       target = L["target"],
                                       targettarget = L["targettarget"],
                                       player = L["player"],
                                       recast = L["esrecast"]
                                     },
                            set = function(info, val) TotemTimers_Settings.EarthShieldMiddleButton = val  
                                     TotemTimers.ProcessSetting("EarthShieldMiddleButton") end,
                            get = function(info) return TotemTimers_Settings.EarthShieldMiddleButton end,
                        },
                    },
                },
                weapons = {
                    order = 4,
                    name = L["Weapon Buff Tracker"],
                    desc = L["WeaponDesc"],
                    type = "group",
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers_Settings.WeaponTracker = val 
                                    TotemTimers.ProcessSetting("WeaponTracker") end,
                            get = function(info) return TotemTimers_Settings.WeaponTracker end,
                        },
                         openright = {
                            order = 4,
                            type = "toggle",
                            name = L["Open On Rightclick"],
                            set = function(info, val)
                                    TotemTimers_Settings.WeaponMenuOnRightclick = val  TotemTimers.ProcessSetting("WeaponMenuOnRightclick")
                                end,
                            get = function(info) return TotemTimers_Settings.WeaponMenuOnRightclick end,
                        },  
                        menudirection = {
                            order = 5,
                            type = "select",
                            name = L["Menu Direction"],
                            values = function()
                                        if TotemTimers_Settings.TrackerArrange == "horizontal" then
                                            return {auto=L["Automatic"], up=L["Up"], down=L["Down"],}
                                        elseif TotemTimers_Settings.TrackerArrange == "vertical" then
                                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"],}
                                        else
                                            return {auto=L["Automatic"], left=L["Left"], right=L["Right"], up=L["Up"], down=L["Down"],}
                                        end
                                     end,
                            set = function(info, val)
                                        TotemTimers_Settings.WeaponBarDirection = val  TotemTimers.ProcessSetting("WeaponBarDirection")	
                                  end,
                            get = function(info) return TotemTimers_Settings.WeaponBarDirection end,
                        },  
                    },
                },
            },
        },
    },
}

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Trackers"], "TotemTimers", "trackers")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")