-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

if not TotemTimers_Settings then TotemTimers_Settings = {} end
if not TotemTimers_SpecSettings then TotemTimers_SpecSettings = {[1] = {}, [2] = {}} end

local Default_Settings = {
	Version = 10.192,
    Show = true,
    Lock = false,
	FlashRed = true,
	ShowTimerBars = true,
    Tooltips = true,
    TooltipsAtButtons = true,
    TimeFont = "聊天",
    TimeColor = {r=1,g=1,b=1},
   	TimerBarTexture = "Minimalist",
    TimerBarColor = {r=0.5,g=0.5,b=1.0,a=1.0},
    HideInVehicle = true,

    Order = {2,1,3,4,},
    Arrange = "horizontal",
 	TimeStyle = "mm:ss",
    TimerTimePos = "BOTTOM",
	CastBarDirection = "auto",
	TimerSize = 32,
    TimerTimeHeight = 15,
	TimerSpacing = 5,
	TimerTimeSpacing = 0,
	TotemTimerBarWidth = 36,
    TotemMenuSpacing = 0,
    OpenOnRightclick = false,
    MenusAlwaysVisible = false,
    BarBindings = true,
    ReverseBarBindings = false,
    MiniIcons = true,
    ProcFlash = true,
    ColorTimerBars = false,
    ShowCooldowns = true,
    CheckPlayerRange = true,
    CheckRaidRange = true,
    ShowRaidRangeTooltip = true,
    CastButtonPosition = "AUTO",
    CastButtonSize = 0.5,
    StopPulse = true,

	TrackerArrange = "horizontal",
	TrackerTimePos = "BOTTOM",
	TrackerSize = 32,
	TrackerTimeHeight=15,
    TrackerSpacing = 5,
	TrackerTimeSpacing = 0,
    TrackerTimerBarWidth = 36,
    AnkhTracker = true,
    EarthShieldTracker = true,
    WeaponTracker = true,
    WeaponBarDirection = "auto",
    WeaponMenuOnRightclick = false,

	EarthShieldLeftButton = "target",
	EarthShieldRightButton = "player",
	EarthShieldMiddleButton = "recast",
	ShieldLeftButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.LightningShield],
	ShieldRightButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.WaterShield],
	ShieldMiddleButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.TotemicCall],


	Msg = "tt",
    ActivateHiddenTimers = false,

    Warnings = {
        TotemWarning = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Totem Expiring",
            enabled = false,
        },
        TotemExpiration = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Totem Expired",
            enabled = false,
        },
        TotemDestroyed = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Totem Destroyed",
            enabled = false,
        },
        Shield = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Shield removed",
            enabled = false,
        },
        EarthShield = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Shield removed",
            enabled = false,
        },
        Weapon = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Totem Expired",
            enabled = false,
        },
        Maelstrom = {
            r = 1,
            g = 0,
            b = 0,
            a = 1,
            sound = "",
            text = "Maelstrom Notifier",
            enabled = false,
        },
    },
	LastMainEnchants = {},
	LastOffEnchants = {},

	TotemOrder = {},
    TimerPositions = {
        [1] = {"CENTER", nil, "CENTER", -50,-40},
        [2] = {"CENTER", nil, "CENTER", -70,0},
        [3] = {"CENTER", nil, "CENTER", -30, 0},
        [4] = {"CENTER", nil, "CENTER", -50, 40},
    },
    TotemSets = {},

    Sink = {},

    FramePositions = {
        TotemTimersFrame = {"CENTER", nil, "CENTER", -200,0},
        TotemTimers_TrackerFrame = {"CENTER", nil, "CENTER", 50,0},
        TotemTimers_EnhanceCDsFrame = {"CENTER", nil, "CENTER", -30.5, -120},
        TotemTimers_MultiSpellFrame = {"CENTER", nil, "CENTER", -250,0},
        TotemTimers_CastBar1 = {"CENTER", nil, "CENTER", -200,-190},
        TotemTimers_CastBar2  = {"CENTER", nil, "CENTER", -200,-225},
        TotemTimers_CastBar3  = {"CENTER", nil, "CENTER", 50, -190},
        TotemTimers_CastBar4  = {"CENTER", nil, "CENTER", 50, -225},
    },

    LastMultiCastSpell = TotemTimers.SpellIDs.CallofElements,
    EnableMultiSpellButton = true,
    MultiSpellSize = 32,
    MultiSpellBarDirection = "sameastimers",
    HideDefaultTotemBar = true,
    MultiSpellBarOnRightclick = false,
    MultiSpellBarBinds = true,
    MultiSpellReverseBarBinds = false,

    RaidTotemsToCall = 66842,
    TimersOnButtons = false,
}


Default_SpecSettings = {
    LastWeaponEnchant = TotemTimers.SpellNames[TotemTimers.SpellIDs.RockbiterWeapon],
    LastWeaponEnchant2 = TotemTimers.SpellNames[TotemTimers.SpellIDs.FlametongueWeapon],
    HiddenTotems = {},
    CastButtons = {},
    ShieldTracker = true,
    EnhanceCDs_Spells = {
        ["melee"] = {
            [1] = true, --SpellIDs.StormStrike
            [2] = true, --SpellIDs.EarthShock
            [3] = true, --SpellIDs.LavaLash
            [4] = true, --SpellIDs.FireNova
            [5] = true, --SpellIDs.Magma
            [6] = true, --SpellIDs.ShamanisticRage
            [7] = true, --SpellIDs.WindShear
            [8] = true, --SpellIDs.LightningShield
            [9] = true, --SpellIDs.FlameShock
            [10] = true, --SpellIDs.FeralSpirit
            [11] = true, --SpellIDs.Maelstrom
        },
        ["ele"] = {
            [1] = true, --SpellIDs.FlameShock,
            [2] = true, --SpellIDs.LavaBurst,
            [3] = true, --SpellIDs.ChainLightning,
            [4] = true, --SpellIDs.Thunderstorm,
            [5] = true, --SpellIDs.ElementalMastery,
            [6] = true, --FireNova
            [7] = true, --FlameShock duration
        },
    },
    EnhanceCDs_Order = {
        ["melee"] = {
            [1] = 1, --SpellIDs.StormStrike
            [2] = 2, --SpellIDs.EarthShock
            [3] = 3, --SpellIDs.LavaLash
            [4] = 4, --SpellIDs.FireNova
            [5] = 5, --SpellIDs.Magma
            [6] = 6, --SpellIDs.ShamanisticRage
            [7] = 7, --SpellIDs.WindShear
            [8] = 8, --SpellIDs.LightningShield
        },
        ["ele"] = {
            [1] = 1, --SpellIDs.FlameShock,
            [2] = 2, --SpellIDs.LavaBurst,
            [3] = 3, --SpellIDs.ChainLightning,
            [4] = 4, --SpellIDs.Thunderstorm,
            [5] = 5, --SpellIDs.ElementalMastery,
            [6] = 6, --FireNova
        },
    },
    EnhanceCDs = true,
    EnhanceCDsSize = 30,
    EnhanceCDsTimeHeight = 12,
    EnhanceCDsMaelstromHeight = 14,
    ShowOmniCCOnEnhanceCDs = true,
    EnhanceCDsOOCAlpha = 0.1,
    CDTimersOnButtons = true,
}

local function copy(object)
    if type(object) ~= table then
        return object
    else
        local newtable = {}
        for k,v in pairs(object) do
            newtable[k] = copy(v)
        end
        return newtable
    end
end

TotemTimers.Default_Settings = Default_Settings
TotemTimers.Default_SpecSettings = Default_SpecSettings


local SettingsConverters = {
    [10.0] = function()
        TotemTimers_Settings.Version = 10.19
        if TotemTimers_SpecSettings then
            for i=1,2 do
                if TotemTimers_SpecSettings[i] then
                    if TotemTimers_SpecSettings[i].EnhanceCDs_Spells then
                        TotemTimers_SpecSettings[i].EnhanceCDs_Spells.ele = copy(Default_SpecSettings.EnhanceCDs_Spells.ele)
                    end
                    if TotemTimers_SpecSettings[i].EnhanceCDs_Order then
                        TotemTimers_SpecSettings[i].EnhanceCDs_Order.ele = copy(Default_SpecSettings.EnhanceCDs_Order.ele)
                    end
                end
            end
        end
    end,
    [10.19] = function()
        TotemTimers_Settings.Version = 10.191
        TotemTimers_SpecSettings[1].ShieldTracker = TotemTimers_Settings.ShieldTracker
        TotemTimers_SpecSettings[2].ShieldTracker = TotemTimers_Settings.ShieldTracker
        TotemTimers_Settings.ShieldTracker = nil
        for i = 1,2 do
            if TotemTimers_SpecSettings[i].EnhanceCDs_Spells then
                TotemTimers_SpecSettings[i].EnhanceCDs_Spells.melee[8] = true -- add lightning shield to enhance cds
            end
            if TotemTimers_SpecSettings[i].EnhanceCDs_Order then
                TotemTimers_SpecSettings[i].EnhanceCDs_Order.melee[8] = 8
            end
        end
    end,
    [10.191] = function()
        TotemTimers_Settings.Version = 10.192
        TotemTimers_Settings.Warnings = nil
    end,
}


function TotemTimers_LoadDefaultSettings()
	if not TotemTimers_Settings then
		TotemTimers_Settings = {}
	end

    if not TotemTimers_SpecSettings[1] then TotemTimers_SpecSettings[1] = {} end --needed if pressed "reset all"-button
    if not TotemTimers_SpecSettings[2] then TotemTimers_SpecSettings[2] = {} end

	if not TotemTimers_Settings.Version then
		--DEFAULT_CHAT_FRAME:AddMessage("TotemTimers: Pre-10.2 Beta2 or no saved settings found, loading defaults...")
		TotemTimers_Settings = {}
	elseif TotemTimers_Settings.Version ~= Default_Settings.Version then
        if not SettingsConverters[TotemTimers_Settings.Version] then
          --  DEFAULT_CHAT_FRAME:AddMessage("TotemTimers: Pre-10.0 settings found, loading defaults...")
            TotemTimers_Settings = {}
        else
            while SettingsConverters[TotemTimers_Settings.Version] do
                SettingsConverters[TotemTimers_Settings.Version]()
            end
        end
    end



	for k,v in pairs(Default_Settings) do
		if TotemTimers_Settings[k] == nil then
			TotemTimers_Settings[k] = copy(v)
		end
	end

    for k,v in pairs(Default_SpecSettings) do
        for i = 1,2 do
            if TotemTimers_SpecSettings[i][k] == nil then
                TotemTimers_SpecSettings[i][k] = copy(v)
            end
        end
        TotemTimers_Settings[k] = nil
    end

	if #TotemTimers_Settings.TotemOrder == 0 then
		for i=1,4 do
			TotemTimers_Settings.TotemOrder[i] = {}
		end
		for k,v in pairs(TotemData) do
			table.insert(TotemTimers_Settings.TotemOrder[v.element], k)
		end
	end
end
