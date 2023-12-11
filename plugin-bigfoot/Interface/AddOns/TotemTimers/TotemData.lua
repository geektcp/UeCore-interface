-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
TotemTimers = {}

TotemTimers.AvailableSpells = {}
TotemTimers.AvailableSpellIDs = {}
TotemTimers.MaxSpellIDs = {}
TotemTimers.AvailableTalents = {}

TotemTimers.SpellIDs = {
    StoneSkin = 58753,
    StoneClaw = 58582,
    EarthBind = 2484,
    StrengthOfEarth = 58643,
    Tremor = 8143,
    EarthElemental = 2062,
    
    Searing = 58704,
    FireNova = 61657,
    Magma = 58734,
    FlameTongue = 58656,
    FrostResistance = 58745,
    Wrath = 30706,
    FireElemental = 2894,
    
    Cleansing = 8170,
    HealingStream = 58757,
    FireResistance = 58739,
    ManaSpring = 58774,
    ManaTide = 16190,
    
    Grounding = 8177,
    NatureResistance = 58749,
    Sentry = 6495,
    Windfury = 8512,
    WrathOfAir = 3738,
    
    Ankh = 20608,
    LightningShield = 49281,
    WaterShield = 57960,
    EarthShield = 974,
    TotemicCall = 36936,
    WindfuryWeapon = 58804,
    RockbiterWeapon = 10399,
    FlametongueWeapon = 58790,
    FrostbrandWeapon = 58796,
    EarthlivingWeapon = 51994,
    
    StormStrike = 17364,
    EarthShock = 49231,
    FrostShock = 49236,
    FlameShock = 49233,
    LavaLash = 60103,
    Maelstrom = 51532,
    LightningBolt = 49238,
    ChainLightning = 49271,
    LavaBurst = 60043,
    Maelstrom = 53819,
    WindShear = 57994,
    ShamanisticRage = 30823,
    FeralSpirit = 51533,
    ElementalMastery = 64701,
    Thunderstorm = 51490,
    
    CallofSpirits = 66844,
    CallofElements = 66842,
    CallofAncestors = 66843,
}

TotemTimers.BuffIDs = {
    StoneSkin = 58754,
    StrengthOfEarth = 58646,
    FlameTongue = 58654,
    FrostResistance = 58744,
    Wrath = 57663,
    FireResistance = 58740,
    ManaSpring = 58777,
    ManaTide = 16191,
    Grounding = 8178,
    NatureResistance = 58750,
    Windfury = 8515,
    WrathOfAir = 2895,
        
    FrostResistancePala = 48945,
    FireResistancePala = 48947,
    NatureResistanceHunter = 49071,
    IcyTalons = 55789,
    IcyTalonsSelf1 = 50887,
    IcyTalonsSelf2 = 50886,
    HornOfWinter = 57623,
    DemonicPact = 47240,
    BoW = 48936,
    GBoW = 48938,
}

TotemTimers.SpellTextures = {}
TotemTimers.SpellNames = {}

for k,v in pairs(TotemTimers.SpellIDs) do
    local n,_,t = GetSpellInfo(v)
    TotemTimers.SpellTextures[v] = t
    TotemTimers.SpellNames[v] = n
end

TotemTimers.BuffNames = {}
for k,v in pairs(TotemTimers.BuffIDs) do
    local n = GetSpellInfo(v)
    TotemTimers.BuffNames[v] = n
end

--[[
1 - Melee
2 - Ranged
3 - Caster
4 - Healer
5 - Hybrid (mostly Enh. Shaman)
]]


TotemData = {
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StoneSkin]] = {
		element = EARTH_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.StoneSkin,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StrengthOfEarth]] = {
		element = EARTH_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.StrengthOfEarth,
        needed = {[1]=true,[2]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.HornOfWinter}
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.StoneClaw]] = {
		element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Tremor]] = {
		element = EARTH_TOTEM_SLOT,
		flashInterval = 3,
		flashDelay = 2.5,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.EarthBind]] = {
		element = EARTH_TOTEM_SLOT,
		flashInterval = 3,
		flashDelay = 1.7,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.EarthElemental]] = {
		element = EARTH_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Searing]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Magma]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FlameTongue]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FlameTongue,
        needed={[3]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.DemonicPact, TotemTimers.BuffIDs.Wrath},
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FrostResistance]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FrostResistance,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.FrostResistancePala},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Wrath]] = {
		element = FIRE_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.Wrath,
        needed = {[3]=true,[5]=true,}
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FireElemental]] = {
		element = FIRE_TOTEM_SLOT,
        noRangeCheck = true,
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Cleansing]] = {
		element = WATER_TOTEM_SLOT,
		flashInterval = 3,
		flashDelay = 0,
        partyOnly = true,
	},	
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.HealingStream]] = {
		element = WATER_TOTEM_SLOT,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.FireResistance]] = {
		element = WATER_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.FireResistance,
		needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.FireResistancePala},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.ManaSpring]] = {
		element = WATER_TOTEM_SLOT,
		hasBuff = TotemTimers.BuffIDs.ManaSpring,
		needed = {[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.BoW, TotemTimers.BuffIDs.GBoW},
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.ManaTide]] = {
		element = WATER_TOTEM_SLOT,
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Grounding]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.Grounding,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        partyOnly = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.NatureResistance]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.NatureResistance,
        needed = {[1]=true,[2]=true,[3]=true,[4]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.NatureResistanceHunter},
    },
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Sentry]] = {
		element = AIR_TOTEM_SLOT,
        noRangeCheck = true,
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.Windfury]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.Windfury,
        needed = {[1]=true,[5]=true,},
        moreBuffs = {TotemTimers.BuffIDs.IcyTalons,TotemTimers.BuffIDs.IcyTalonsSelf1,TotemTimers.BuffIDs.IcyTalonsSelf2}
	},
	[TotemTimers.SpellNames[TotemTimers.SpellIDs.WrathOfAir]] = {
		element = AIR_TOTEM_SLOT,
        hasBuff = TotemTimers.BuffIDs.WrathOfAir,
        needed = {[3]=true,[4]=true,},
	},
}

TotemTimers_Spells = {}

TotemTimers.TextureToName = {}
for k,v in pairs(TotemTimers.SpellIDs) do
    if TotemData[TotemTimers.SpellNames[v]] then
        TotemTimers.TextureToName[TotemTimers.SpellTextures[v]] = TotemTimers.SpellNames[v]
    end
end
TT_EMPTY_ICON = "Spell_Totem_WardOfDraining"
