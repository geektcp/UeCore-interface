----------------------------------------------------------------
--	Library
----------------------------------------------------------------
local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()

----------------------------------------------------------------
--	Local Variables
----------------------------------------------------------------
local GetSpellInfo = GetSpellInfo
local fmt = string.format
local bit_band = bit.band
local MemberStatuses = {}

local debuffColorText = {
	[1] = "|cff3f8fff",
	[2] = "|cff008f00",
	[3] = "|cff8f5f00",
	[4] = "|cff8f00ff"
}

local zone
local db
----------------------------------------------------------------
--	Localization
----------------------------------------------------------------
local L = AceLibrary("AceLocale-2.2"):new("GridStatusRaidDebuff")
L:RegisterTranslations("enUS", function()
	return {
		["Raid Debuff"] = true,
		["Option for %s"] = true,
		["Color"] = true,
		["Color for %s"] = true,
		["Color Mode"] = true,
		["Normal Debuff"] = true,
		["Normal debuff is prior"] = true,
		["Stackable Debuff"] = true,
		["Stackable debuff is prior"] = true,
		["Stack Text Mode"] = true,
		["Ignore Current Icon & Show Stackable Debuff"] = true,
		["Current Icon"] = true,
		["Current Debuff is prior"] = true,

		["Zone Name"] = true,
		["Enable %s"] = true,
		["Debuff Color"] = true,
		["Add"] = true,
		["Add debuff color"] = true,
		["Add debuff color for %s"] = true,
		["Modify"] = true,
		["Modify debuff color"] = true,
		["Modify debuff color for %s"] = true,
		["Remove"] = true,
		["Remove debuff color"] = true,
		["Remove debuff color for %s"] = true,

	}
end)

L:RegisterTranslations("koKR", function()
	return {
		["Raid Debuff"] = "레이드 디버프",
		["Option for %s"] = "%s의 설정",
		["Color"] = "색상",
		["Color for %s"] = "%s의 색상",
		["Color Mode"] = "색상",
		["Normal Debuff"] = "일반 디버프",
		["Normal debuff is prior"] = "일반 디버프 우선",
		["Stackable Debuff"] = "중첩 디버프",
		["Stackable debuff is prior"] = "중첩 디버프 우선",
		["Stack Text Mode"] = "중첩 문자",
		["Ignore Current Icon & Show Stackable Debuff"] = "현재아이콘을 무시하고 중첩디버프를 표시합니다",
		["Current Icon"] = "현재 아이콘",
		["Current Debuff is prior"] = "현재 표시되는 아이콘을 우선합니다",

		["Zone Name"] = "지역 이름",
		["Enable %s"] = "%s 활성화",

		["Debuff Color"] = "디버프 색상",
		["Add"] = "추가",
		["Add debuff color"] = "디버프 색상을 추가합니다.",
		["Add debuff color for %s"] = "%s|r의 디버프 색상을 추가합니다.",
		["Modify"] = "변경",
		["Modify debuff color"] = "디버프 색상을 변경합니다.",
		["Modify debuff color for %s"] = "%s|r의 디버프 색상을 변경합니다.",
		["Remove"] = "제거",
		["Remove debuff color"] = "디버프 색상을 제거 합니다.",
		["Remove debuff color for %s"] = "%s|r의 디버프 색상을 제거합니다.",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Raid Debuff"] = "团队减益",
		["Option for %s"] = "%s 设置",
		["Color"] = "颜色",
		["Color for %s"] = "%s 颜色",
		["Color Mode"] = "颜色模式",
		["Normal Debuff"] = "普通debuff",
		["Normal debuff is prior"] = "普通debuff优先",
		["Stackable Debuff"] = "可叠加debuff",
		["Stackable debuff is prior"] = "可叠加debuff优先",
		["Stack Text Mode"] = "叠加计数文字模式",
		["Ignore Current Icon & Show Stackable Debuff"] = "不显示当前debuff图标而显示叠加计数文字",
		["Current Icon"] = "当前debuff",
		["Current Debuff is prior"] = "当前debuff优先",

		["Zone Name"] = "区域名称",
		["Enable %s"] = "开启 %s",
		["Debuff Color"] = "边角提示器颜色",
		["Add"] = "团队减益列表",
		["Add debuff color"] = "可以在此选择debuff使其支持边角提示器输出",
		["Add debuff color for %s"] = "添加 %s ",
		["Modify"] = "修改颜色",
		["Modify debuff color"] = "修改各debuff输出到边角提示器的颜色",
		["Modify debuff color for %s"] = "修改 %s 的颜色",
		["Remove"] = "移除",
		["Remove debuff color"] = "移除debuff边角提示器支持",
		["Remove debuff color for %s"] = "移除 %s 的边角提示器支持",
	}
end)

L:RegisterTranslations("zhTW", function()
	return {
		["Raid Debuff"] = "團隊減益",
		["Option for %s"] = "%s 選項",
		["Color"] = "顏色",
		["Color for %s"] = "%s 的顏色",
		["Color Mode"] = "顏色模式",
		["Normal Debuff"] = "一般減益",
		["Normal debuff is prior"] = "優先顯示一般減益",
		["Stackable Debuff"] = "可堆疊減益",
		["Stackable debuff is prior"] = "優先顯示可堆疊減益",
		["Stack Text Mode"] = "堆疊文字模式",
		["Ignore Current Icon & Show Stackable Debuff"] = "忽略目前圖示並顯示可堆疊減益",
		["Current Icon"] = "目前圖示",
		["Current Debuff is prior"] = "優先顯示目前減益",

		["Zone Name"] = "地區名稱",
		["Enable %s"] = "啟用%s",
		["Debuff Color"] = "減益顏色",
		["Add"] = "加入",
		["Add debuff color"] = "加入減益顏色",
		["Add debuff color for %s"] = "加入 %s 的減益顏色",
		["Modify"] = "修改",
		["Modify debuff color"] = "修改減益顏色",
		["Modify debuff color for %s"] = "修改 %s 的減益顏色",
		["Remove"] = "移除",
		["Remove debuff color"] = "移除減益顏色",
		["Remove debuff color for %s"] = "移除 %s 的減益顏色",

	}
end)

L:RegisterTranslations("ruRU", function()
	return {
		["Raid Debuff"] = "Дебаффы рейда",
		["Option for %s"] = "Опции %s",
		["Color"] = "Окраска",
		["Color for %s"] = "Окраска %s",
		["Color Mode"] = "Режим окраски",
		["Normal Debuff"] = "Обычный дебафф",
		["Normal debuff is prior"] = "Приоритет обычным дебаффам",
		["Stackable Debuff"] = "Суммирующийся дебафф",
		["Stackable debuff is prior"] = "Приоритет суммирующимся дебаффам",
		["Stack Text Mode"] = "Режим сумм. текста",
		["Ignore Current Icon & Show Stackable Debuff"] = "Игнор текущей иконки и показ сумм. дебафф",
		["Current Icon"] = "Текущая иконка",
		["Current Debuff is prior"] = "Приоритет текущему дебаффу",

		["Zone Name"] = "Название зоны",
		["Enable %s"] = "Включить %s",
		["Debuff Color"] = "Цвет дебаффа",
		["Add"] = "Добавить",
		["Add debuff color"] = "Добавить окраску",
		["Add debuff color for %s"] = "Добавить окраску дебаффа для %s",
		["Modify"] = "Изменить",
		["Modify debuff color"] = "Изменить окраску",
		["Modify debuff color for %s"] = "Изменить окраску дебаффа для %s",
		["Remove"] = "Убрать",
		["Remove debuff color"] = "Убрать окраску дебаффа",
		["Remove debuff color for %s"] = "Убрать окраску дебаффа для %s",

	}
end)

----------------------------------------------------------------
--	Module
----------------------------------------------------------------
GridStatusRaidDebuff = GridStatus:NewModule("GridStatusRaidDebuff")

local GridStatusRaidDebuff = GridStatusRaidDebuff
GridStatusRaidDebuff.menuName = L["Raid Debuff"]

GridStatusRaidDebuff.options = false

GridStatusRaidDebuff.defaultDB = {
	debug = false,
	prior_stack = true,
	stacktext = true,

	alert_RaidDebuff = {
		text = L["Raid Debuff"],
		desc = L["Raid Debuff"],
		enable = true,
		color = { r = 1.0, g = 0.0, b = 0.0, a = 1 },
		priority = 98,
		range = false,
	},

	debuff_list = {
--		[BZ["Dragonblight"]] = {
--			--Test Jormungar Tunneler
--			[51879] = { --Corrode Flesh
--				enable = false,
--				order = 2, --1 magic, 2 poison, 3 disease, 4 curse
--			},
--		},
		[BZ["Karazhan"]] = {
			--Moroes
			[37066] = { --Garrote
				enable = true,
				order = 1,
			},
			--Maiden
			[29522] = { --Holy Fire
				enable = true,
				order = 4,
				debuffType = 1,
			},
			[29511] = { --Repentance
				enable = true,
				order = 5,
				duration = 12,
			},
			--Opera : Bigbad wolf
			[30753] = { -- Red riding hood
				enable = true,
				order = 6,
				duration = 20,
			},
			--Illhoof
			[30115] = { --sacrifice
				enable = true,
				order = 7,
			},
			--Malche
			[30843]= { --Enfeeble
				enable = true,
				order = 8,
			},
		},
		[BZ["Zul'Aman"]] = {
			--Nalorakk
			[42389] = { --Mangle
				enable = true,
				order = 1,
			},
			--Akilzon
			[43657] = { --Electrical Storm
				enable = true,
				order = 2,
			},
			[43622] = { --Static Distruption
				enable = true,
				order = 3,
			},
			--Zanalai
			[43299] = { --Flame Buffet
				enable = true,
				order = 4,
				debuffType = 1,
			},
			--halazzi
			[43303] = { --Flame Shock
				enable = true,
				order = 5,
				debuffType = 1,
			},
			--hex lord
			[43613] = { --Cold Stare
				enable = true,
				order = 6,
				debuffType = 4,
			},
			[43501] = { --Siphon soul
				enable = true,
				order = 7,
			},
			--Zulzin
			[43093] = { --Throw
				enable = true,
				order = 8,
			},
			[43095] = { --Paralyze
				enable = true,
				order = 9,
			},
			[43150] = { --Rage
				enable = true,
				order = 10,
			},
		},
		[BZ["Serpentshrine Cavern"]] = {
			-- Trash
			[39042] = { --Rampent Infection
				enable = true,
				debuffType = 3,
				order = 1,
			},
			[39044] = { --Serpentshrine Parasite
				enable = true,
				order = 2,
				duration = 10,
			},
			--Hydross
			[38235] = { --Water Tomb
				enable = true,
				order = 3,
				duration = 4,
			},
			[38246] = { --Vile Sludge
				enable = true,
				order = 4,
			},
			--Morogrim
			[37850] = { --Watery Grave
				enable = true,
				order = 5,
				duration = 6,
			},
			[38023] = {
				delegater = 37850,
			},
			[38024] = {
				delegater = 37850,
			},
			[38025] = {
				delegater = 37850,
			},
			--Leotheras
			[37676] = { --insidious whisper
				enable = true,
				order = 6,
			},
			[37641] = { --Whirl wind
				enable = true,
				order = 7,
				duration = 15,
			},
			[37749] = { --Madness
				enable = true,
				order = 8,
			},
			--Vashj
			[38280] = { --Static Charge
				enable = true,
				order = 9,
				duration = 20,
			},
		},
		[BZ["Tempest Keep"]] = {
			--Trash
			[37123] = { --Saw Blade
				enable = true,
				order = 1,
			},
			[37120] = { --Fragmentation Bomb
				enable = true,
				order = 2,
			},
			[37118] = { --Shell Shock
				enable = true,
				order = 3,
			},
			--Solarian
			[42783] = { --Wrath of the Astromancer
				enable = true,
				order = 4,
				duration = 6,
			},
			--Kaeltahas
			[37027] = { --Remote Toy
				enable = true,
				order = 5,
			},
			[36798] = { --Mind Control
				enable = true,
				order = 6,
			},
		},
		[BZ["Hyjal Summit"]] = {
			--Winterchill
			[31249] = { --Ice Bolt
				enable = true,
				order = 1,
				duration = 4,
			},
			--Aneteron
			[31306] = { --Carrion Swarm
				enable = true,
				order = 2,
				duration = 20,
			},
			[31298] = { --Sleep
				enable = true,
				order = 3,
				duration = 10,
			},
			--Azgalor
			[31347] = { --Doom
				enable = true,
				order = 4,
				duration = 20,
			},
			[31341] = { --Unquenchable Flames
				enable = true,
				order = 5,
				duration = 5,
			},
			[31344] = { --Howl of Azgalor
				enable = true,
				order = 6,
				duration = 5,
			},
			--Achimonde
			[31944] = { --Doomfire
				enable = true,
				order = 8,
				duration = 45,
			},
			[31972] = { --Grip
				enable = true,
				order = 9,
				debuffType = 4,
			},
		},
		[BZ["Black Temple"]] = {
			--Trash
			[34654] = { --Blind
				enable = true,
				order = 1,
				debuffType = 1,
				duration = 10,
			},
			[39674] = { --Banish
				enable = true,
				order = 2,
				duration = 15,
			},
			[41150] = { --Fear
				enable = true,
				order = 3,
				debuffType = 1,
				duration = 3,
			},
			[41168] = { --Sonic Strike
				enable = true,
				order = 4,
				duration = 5,
			},
			--Najentus
			[39837] = { --Impaling Spine
				enable = true,
				order = 10,
			},
			--Terron
			[40239] = { --Incinerate
				enable = true,
				order = 20,
				debuffType = 1,
				duration = 3,
			},
			[40251] = { --Shadow of death
				enable = true,
				order = 30,
				duration = 55,
			},
			--Gurtogg
			[40604] = { --FelRage
				enable = true,
				order = 40,
				duration = 30,
			},
			[40481] = { --Acidic Wound
				enable = true,
				order = 41,
				stackable = true,
				duration = 60,
			},
			[40508] = { --Fel-Acid Breath
				enable = true,
				order = 42,
				duration = 20,
			},
			[42005] = { --bloodboil
				enable = true,
				order = 43,
				stackable = true,
				duration = 24,
			},
			--ROS
			[41303] = { --soulDrain
				enable = true,
				order = 50,
			},
			[41410] = { --Deaden
				enable = true,
				order = 51,
				duration = 10,
			},
			[41376] = { --Spite
				enable = true,
				order = 52,
				duration = 6,
			},
			--Mother
			[40860] = { --Vile Beam
				enable = true,
				order = 60,
				duration = 8,
			},
			[41001] = { --Attraction
				enable = true,
				order = 61,
			},
			--Council
			[41485] = { --Deadly Poison
				enable = true,
				order = 70,
				duration = 4,
			},
			[41472] = { --Wrath
				enable = true,
				order = 71,
				duration = 8,
			},
			--Illiidan
			[41914] = { --Parasitic Shadowfiend
				enable = true,
				order = 80,
				duration = 10,
			},
			[41917] = {
				delegater = 41914,
			},
			[40585] = { --Dark Barrage
				enable = true,
				order = 81,
				duration = 10,
			},
			[41032] = { --Shear
				enable = true,
				order = 82,
			},
			[40932] = { --Flames
				enable = true,
				order = 83,
				duration = 60,
			},
		},
		[BZ["Sunwell Plateau"]] = {
			--Trash
			[46561] = { --Fear
				enable = true,
				order = 1,
				debuffType = 1,
			},
			[46562] = { --Mind Flay
				enable = true,
				order = 2,
			},
			[46266] = { --Burn Mana
				enable = true,
				order = 3,
				debuffType = 1,
			},
			[46557] = { --Slaying Shot
				enable = true,
				order = 4,
			},
			[46560] = { --Shadow Word: Pain
				enable = true,
				order = 5,
				debuffType = 1,
			},
			[46543] = { --Ignite Mana
				enable = true,
				order = 6,
				debuffType = 1,
			},
			[46427] = { --Domination
				enable = true,
				order = 7,
				debuffType = 1,
			},
			--Kalecgos
			[45032] = { --Curse of Boundless Agony
				enable = true,
				order = 10,
				debuffType = 4,
				duration = 30,
			},
			[45034] = {
				delegater = 45032,
			},
			[45018] = { --Arcane Buffet
				enable = true,
				order = 12,
				stackable = true,
			},
			--Brutallus
			[46394] = { --Burn
				enable = true,
				order = 20,
				duration = 60,
			},
			[45150] = { --Meteor Slash
				enable = true,
				order = 21,
				stackable = true,
			},
			--Felmyst
			[45855] = { --Gas Nova
				enable = true,
				order = 30,
				debuffType = 1,
			},
			[45662] = { --Encapsulate
				enable = true,
				order = 31,
				duration = 6,
				auraCheck = true, -- doesn't have a combatlog event
			},
			[45402] = { --Demonic Vapor
				enable = true,
				order = 32,
			},
			[45717] = { --Fog of Corruption
				enable = true,
				order = 33,
				auraCheck = true, -- unit is hostile in comabtlog event
			},
			--Twins
			[45256] = { --Confounding Blow
				enable = true,
				order = 41,
			},
			[45333] = { --Conflagration
				enable = true,
				order = 42,
			},
			[46771] = { --Flame Sear
				enable = true,
				order = 43,
			},
			[45270] = { --Shadowfury
				enable = true,
				order = 44,
			},
			[45347] = { --Dark Touched
				enable = true,
				order = 45,
				stackable = true,
				color = { r = 0, g = 0, b = 0, a = 1},
			},
			[45348] = { --Fire Touched
				enable = true,
				order = 46,
				stackable = true,
			},
			--Muru
			[45996] = { --Darkness
				enable = true,
				order = 50,
			},
			--Kiljaeden
			[45442] = { --Soul Flay
				enable = true,
				order = 61,
			},
			[45641] = { --Fire Bloom
				enable = true,
				order = 62,
				duration = 20,
			},
			[45885] = { --Shadow Spike
				enable = true,
				order = 63,
				duration = 10,
			},
			[45737] = { --Flame Dart
				enable = true,
				order = 64,
				duration = 15,
			},
			[45740] = {
				delegater = 45737,
			},
			[45741] = {
				delegater = 45737,
			},
		},
		[BZ["Naxxramas"]] = {
			--Trash
			[55314] = { --Strangulate
				enable = true,
				order = 1,
				duration = 4,
				debuffType = 1,
			},
			--Anub'Rekhan
			[28786] = { --Locust Swarm (Normal)
				enable = true,
				order = 5,
				stackable = true,
				duration = 6,
			},
			[54022] = { --Locust Swarm (Heroic)
				delegater = 28786,
			},
			--Grand Widow Faerlina
			[28796] = { --Poison Bolt Volley (Normal)
				enable = true,
				order = 10,
				stackable = true,
				debuffType = 2,
				duration = 8,
			},
			[54098] = { --Poison Bolt Volley (Heroic)
				delegater = 28796,
			},
			[28794] = { --Rain of Fire (Normal)
				enable = true,
				order = 11,
			},
			[54099] = { --Rain of Fire (Heroic)
				delegater = 28794,
			},
			--Noth the Plaguebringer
			[29213] = { --Curse of the Plaguebringer (Normal)
				enable = true,
				order = 20,
				debuffType = 4,
				duration = 10,
			},
			[54835] = { --Curse of the Plaguebringer (Heroic)
				delegater = 29213,
			},
			[29214] = { --Wrath of the Plaguebringer (Normal)
				enable = true,
				order = 21,
				duration = 10,
			},
			[54836] = { --Wrath of the Plaguebringer (Heroic)
				delegater = 29214,
			},
			[29212] = { --Cripple (Normal & Heroic)
				enable = true,
				order = 22,
				debuffType = 1,
			},
			--Heigan the Unclean
			[29998] = { --Decrepit Fever (Normal)
				enable = true,
				order = 30,
				duration = 21,
				debuffType = 3,
			},
			[55011] = { --Decrepit Fever (Heroic)
				delegater = 29998,
			},
			--Grobbulus
			[28169] = { --Mutating Injection (Normal & Heroic)
				enable = true,
				order = 40,
				debuffType = 3,
				duration = 10,
			},
			--Gluth
			[54378] = { --Mortal Wound
				enable = true,
				order = 50,
				stackable = true,
				duration = 15,
			},
			[29306] = { --Infected Wound (Normal & Heroic)
				enable = true,
				order = 51,
				stackable = true,
			},
			--Instructor Razuvious
			[55550] = { --Jagged Knife (Normal & Heroic)
				enable = true,
				order = 60,
				duration = 5,
			},
			--Sapphiron
			[28522] = { --Icebolt (Normal & Heroic)
				enable = true,
				order = 70,
			},
			[28542] = { --Life Drain (Normal)
				enable = true,
				order = 71,
				debuffType = 4,
			},
			[55665] = { --Life Drain (Heroic)
				delegater = 28542,
			},
			--Kel'Thuzad
			[28410] = { --Chains of Kel'Thuzad (Heroic only)
				enable = false,
				order = 80,
				duration = 20,
			},
			[27819] = { --Detonate Mana (Normal & Heroic)
				enable = false,
				order = 81,
				duration = 5,
			},
			[27808] = { --Frost Blast (Normal & Heroic)
				enable = true,
				order = 82,
				duration = 4,
			},
			--Maexxna
			[28622] = { --Web Wrap (Normal & Heroic)
				enable = true,
				order = 90,
			},
			[54121] = { --Necrotic Poison (Normal)
				enable = true,
				order = 91,
				debuffType = 2,
			},
			[28776] = { --Necrotic Poison (Heroic)
				delegater = 54121,
			},
		},
		[BZ["The Obsidian Sanctum"]] = {
			--Trash
			[39647] = { --Curse of Mending
				enable = true,
				order = 1,
				debuffType = 4,
			},
			[58936] = { --Rain of Fire
				enable = true,
				order = 2,
			},
			--Sartharion
			[60708] = { --Fade Armor (Normal & Heroic)
				enable = true,
				order = 3,
				stackable = true,
				duration = 15,
			},
			[57491] = { --Flame Tsunami (Normal & Heroic)
				enable = true,
				order = 4,
				duration = 10,
			},
		},
		[BZ["The Eye of Eternity"]] = {
			--Malygos
			[57407] = { --Surge of Power (Normal)
				enable = true,
				order = 1,
				duration = 3,
			},
			[60936] = { --Surge of Power (Heroic)
				delegater = 57407,
			},
			[56272] = { --Arcane Breath (Normal)
				enable = true,
				order = 2,
				duration = 5,
			},
			[60072] = { --Arcane Breath (Heroic)
				delegater = 56272,
			},
		},
	}
}

local AuraCheckListZones = {}
local AuraCheckList = {}

function GridStatusRaidDebuff:OnInitialize()
	self:PreLoader()
	self.super.OnInitialize(self)
	self:RegisterStatuses()
	self:CreateMenu()
end

--for get name and icon(Destination is when user played first time... he can see the debuff tooltip.. this is some problem)
--also initialize AuraCheckList
function GridStatusRaidDebuff:PreLoader()
	for zone, cont in pairs(self.defaultDB["debuff_list"]) do
		for stNum, dInfo in pairs(cont) do
			if not dInfo.delegater then
				local link_name,_,link_icon = GetSpellInfo(stNum)
				dInfo.name = link_name or "nil"
				dInfo.icon = link_icon or "nil"
			end
			if dInfo.name and dInfo.auraCheck then
				AuraCheckListZones[zone] = true
				AuraCheckList[dInfo.name] = stNum
			else
				AuraCheckListZones[zone] = false
			end
		end
	end
end

function GridStatusRaidDebuff:OnEnable()
	self.debugging = self.db.profile.debug

	db = self.db.profile.debuff_list

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneCheck")
	self:RegisterEvent("UNIT_AURA", "ScanUnitAuras")
	self:RegisterEvent("Grid_UnitJoined")
end


function GridStatusRaidDebuff:Grid_UnitJoined(guid, unitid)
	self:ScanUnitAuras(unitid)
end


function GridStatusRaidDebuff:ZoneCheck()
	zone = GetRealZoneText()

	self:NukeStatuses()

	if self.db.profile.debuff_list[zone] then
		if not self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "EventHandler")
			self:RegisterEvent("PLAYER_REGEN_ENABLED")

			-- If this zone has debuffs that require aura checking, then register for
			-- the necessary events.
			if (AuraCheckListZones[zone]) then
				if not self:IsEventRegistered("UNIT_AURA") then
					self:RegisterEvent("UNIT_AURA", "ScanUnitAuras")
					self:RegisterEvent("Grid_UnitJoined")
				end
			else
				if self:IsEventRegistered("UNIT_AURA") then
					self:UnregisterEvent("UNIT_AURA")
					self:UnregisterEvent("Grid_UnitJoined")
				end
			end
		end
	else
		if self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			self:UnregisterEvent("PLAYER_REGEN_ENABLED")

			if self:IsEventRegistered("UNIT_AURA") then
				self:UnregisterEvent("UNIT_AURA")
				self:UnregisterEvent("Grid_UnitJoined")
			end
		end
	end
end

function GridStatusRaidDebuff:NukeStatuses()
	for guid in pairs(MemberStatuses) do
		MemberStatuses[guid] = nil
		self.core:SendStatusLost(guid, "alert_RaidDebuff")
	end
end

function GridStatusRaidDebuff:PLAYER_REGEN_ENABLED()
	for guid, unitid in GridRoster:IterateRoster() do
		if not UnitDebuff(unitid, 1) then
			local uName = UnitName(unitid)
			self:NukeUnit(guid)
		end
	end
end


function GridStatusRaidDebuff:PLAYER_ENTERING_WORLD()
	if not zone then
		self:ZoneCheck()
	else
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end

function GridStatusRaidDebuff:RegisterStatuses()
	self:RegisterStatus("alert_RaidDebuff", L["Raid Debuff"], nil, true)
end

function GridStatusRaidDebuff:UnregisterStatuses()
	self:UnregisterStatus("alert_RaidDebuff")
end


-- Create a custom tooltip for debuff description
local tip = CreateFrame("GameTooltip", "GridStatusRaidDebuffTooltip", nil, "GameTooltipTemplate")
tip:SetOwner(UIParent, "ANCHOR_NONE")
for i = 1, 10 do
	tip[i] = _G["GridStatusRaidDebuffTooltipTextLeft"..i]
	if not tip[i] then
		tip[i] = tip:CreateFontString()
		tip:AddFontStrings(tip[i], tip:CreateFontString())
	end
end

function GridStatusRaidDebuff:CreateMenu()
	local db = self.db.profile.debuff_list
	local args = GridStatus.options.args["alert_RaidDebuff"].args

	args["color mode"] = {
		type = "group",
		name = L["Color Mode"],
		desc = L["Option for %s"]:format(L["Color Mode"]),
		order = 10,
		args = {
			["Stackable Debuff"] =
			{
				type = "toggle",
				name = L["Stackable Debuff"],
				desc = L["Stackable debuff is prior"],
				get = function() return self.db.profile.prior_stack end,
				set = function(v) self.db.profile.prior_stack = v end,
			},
			["Normal Debuff"] =
			{
				type = "toggle",
				name = L["Normal Debuff"],
				desc = L["Normal debuff is prior"],
				get = function() return not self.db.profile.prior_stack end,
				set = function(v) self.db.profile.prior_stack = not v end,
			},
		},
	}

	args["stack mode"] = {
		type = "group",
		name = L["Stack Text Mode"],
		desc = L["Option for %s"]:format(L["Stack Text Mode"]),
		order = 11,
		args = {
			["Stackable Debuff"] =
			{
				type = "toggle",
				name = L["Stackable Debuff"],
				desc = L["Ignore Current Icon & Show Stackable Debuff"],
				get = function() return self.db.profile.stacktext end,
				set = function(v) self.db.profile.stacktext = v end,
			},
			["Current Icon"] =
			{
				type = "toggle",
				name = L["Current Icon"],
				desc = L["Current Debuff is prior"],
				get = function() return not self.db.profile.stacktext end,
				set = function(v) self.db.profile.stacktext = not v end,
			},
		},
	}

	args["custom"] = {
		type = "group",
		name = L["Debuff Color"],
		desc = L["Option for %s"]:format(L["Debuff Color"]),
		order = 13,
		args = {
			["add"] = {
				type = "group",
				name = L["Add"],
				desc = L["Add debuff color"],
				order = 1,
				args = {},
			},
			["modify"] = {
				type = "group",
				name = L["Modify"],
				desc = L["Modify debuff color"],
				order = 2,
				args = {},
			},
			["remove"] = {
				type = "group",
				name = L["Remove"],
				desc = L["Remove debuff color"],
				order = 3,
				args = {},
			}
		}
	}

	args["space1"] = {
		type = "header",
		name = " ",
		order = 14,
	}

	args["space2"] = {
		type = "header",
		name = " ",
		order = 16,
	}

	for zone, dlist in pairs(db) do
		local ccargs = args["custom"].args
		args[zone] = {
			type = "group",
			name = zone,
			desc = L["Option for %s"]:format(zone),
			order = 15,
			args = {},
		}
		ccargs["add"].args[zone] = {
			type = "group",
			name = zone,
			desc = zone,
			args = {},
		}
		ccargs["modify"].args[zone] = {
			type = "group",
			name = zone,
			desc = zone,
			args = {},
		}
		ccargs["remove"].args[zone] = {
			type = "group",
			name = zone,
			desc = zone,
			args = {},
		}
		local zoneargs = args[zone].args


		for stNum, dInfo in pairs(dlist) do
			if not dInfo.delegater then
				local prefix = "|r"
				if dInfo.debuffType then
					prefix = debuffColorText[dInfo.debuffType]
				end

				local title = fmt("|T%s:0|t%s%s",dInfo.icon or "nil",prefix,dInfo.name or "nil")

				local description = L["Enable %s"]:format(dInfo.name)
				tip:SetHyperlink("spell:"..stNum)
				if tip:NumLines() > 1 then
					description = tip[tip:NumLines()]:GetText()
				end

				zoneargs[stNum] = {
					type = "toggle",
					name = title,
					desc = description,
					order = dInfo.order,
					get = function() return dInfo.enable end,
					set = function(v) dInfo.enable = v end,
				}

				if not dInfo.color then
					ccargs["add"].args[zone].args[stNum] = {
						type = "execute",
						name = title,
						desc = L["Add debuff color for %s"]:format(dInfo.name),
						order = dInfo.order,
						func = function()
							self.db.profile["debuff_list"][zone][stNum].color = {r = 1, g = 0, b = 0, a = 1}
							self:CreateMenu()
						end,
					}
				else
					ccargs["modify"].args[zone].args[stNum] = {
						type = "color",
						name = title,
						desc = L["Modify debuff color for %s"]:format(dInfo.name),
						order = dInfo.order,
						hasAlpha = true,
						get = function()
							local color = self.db.profile["debuff_list"][zone][stNum].color
							return color.r, color.g, color.b, color.a
						end,
						set = function(r, g, b, a)
							local color = self.db.profile["debuff_list"][zone][stNum].color
							color.r = r
							color.g = g
							color.b = b
							color.a = a
						end,
					}
					ccargs["remove"].args[zone].args[stNum] = {
						type = "execute",
						name = title,
						desc = L["Remove debuff color for %s"]:format(dInfo.name),
						order = dInfo.order,
						func = function()
							self.db.profile["debuff_list"][zone][stNum].color = nil
							self:CreateMenu()
						end,
					}
				end
			end

			if next(ccargs["add"].args[zone].args) then
				ccargs["add"].args[zone].hidden = false
			else
				ccargs["add"].args[zone].hidden = true
			end

			if next(ccargs["modify"].args[zone].args) then
				ccargs["modify"].args[zone].hidden = false
				ccargs["remove"].args[zone].hidden = false
			else
				ccargs["modify"].args[zone].hidden = true
				ccargs["remove"].args[zone].hidden = true
			end
		end
	end
end

function GridStatusRaidDebuff:Reset()
	self.super.Reset(self)
	self:UnregisterStatuses()
	self:RegisterStatuses()
end


function GridStatusRaidDebuff:GainedDebuff(guid, stNum, count)
	if (db[zone]) then
		local dInfo = db[zone][stNum]
		if dInfo then
			if dInfo.delegater then
				dInfo = db[zone][dInfo.delegater]
			end

			if dInfo.enable then
				if not MemberStatuses[guid] then MemberStatuses[guid] = {} end

				MemberStatuses[guid][stNum] = {
					value = count and fmt("%d",count),
					color = dInfo.color or self.db.profile["alert_RaidDebuff"].color,
					icon = dInfo.icon,
					start = GetTime(),
					duration = dInfo.duration,
					stackable = dInfo.stackable,
				}

				self:UpdateUnit(guid)
			end
		end
	end
end


-- COMBAT_LOG_EVENT_UNFILTERED handler
function GridStatusRaidDebuff:EventHandler(ts, event, srcguid, srcname, srcflg, dstguid, dstname, dstflg, ...)
	if bit_band(dstflg, 0x00006868) == 0 then
		if
			event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE"
		then
			local spellId, name, _, auraType, count = select(1, ...)
			if auraType ~= "BUFF" then
				self:GainedDebuff(dstguid, spellId, count or 1)
			end
		elseif
			event == "SPELL_AURA_REMOVED"
		then
			local spellId, name, _, auraType = select(1, ...)
			if auraType ~= "BUFF" then
				self:LostDebuff(dstguid, spellId)
			end
		elseif
			event == "UNIT_DIED"
		then
			self:NukeUnit(dstguid)
		end
	end
end

function GridStatusRaidDebuff:LostDebuff(guid, stNum)
	if (MemberStatuses and MemberStatuses[guid] and MemberStatuses[guid][stNum]) then
		MemberStatuses[guid][stNum] = nil
		self:UpdateUnit(guid)
	end
end

function GridStatusRaidDebuff:NukeUnit(guid)
	if (MemberStatuses and MemberStatuses[guid]) then
		MemberStatuses[guid] = nil
		self.core:SendStatusLost(guid, "alert_RaidDebuff")
	end
end

function GridStatusRaidDebuff:UpdateUnit(guid)
	if (MemberStatuses[guid] and next(MemberStatuses[guid])) then
		local settings = self.db.profile["alert_RaidDebuff"]
		local icon, start, duration
		local value, stackicon

		local normalcolor
		local stackcolor
		for i, k in pairs(MemberStatuses[guid]) do
			if k.stackable then
				stackicon = k.icon
				value = k.value
				stackcolor = k.color
			end
			if not duration then
				icon = k.icon
				start = k.start
				duration = k.duration
				normalcolor = k.color
			end
		end

		local color
		if self.db.profile.prior_stack then
			color = stackcolor or normalcolor
		else
			color = normalcolor or stackcolor
		end

		value = (self.db.profile.stacktext and value) or (icon and "") or value

		self.core:SendStatusGained(
			guid, "alert_RaidDebuff", settings.priority, (settings.range and 40),
			color, nil, nil, nil, icon or stackicon, start, duration, value)
	else
		self.core:SendStatusLost(guid, "alert_RaidDebuff")
	end
end




local debuff_names_seen = {}

function GridStatusRaidDebuff:ScanUnitAuras(unitid)
	local name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable

	local guid = UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(guid) then
		return
	end

	self:Debug("UNIT_AURA", unitid, guid)

	-- scan for debuffs
	wipe(debuff_names_seen)
	local settings = self.db.profile["alert_RaidDebuff"]
	if (settings.enable) then
		local index = 1
		while true do
			name, rank, icon, count, debuffType, duration, expirationTime, isMine, isStealable = UnitAura(unitid, index, "HARMFUL")

			if not name then
				break
			end

			if (AuraCheckList[name]) then
				debuff_names_seen[name] = true
				self:GainedDebuff(guid, AuraCheckList[name], count or 1)
			end

			index = index + 1
		end
	end

	-- handle lost debuffs
	for name in pairs(AuraCheckList) do
		if not debuff_names_seen[name] then
			self:LostDebuff(guid, AuraCheckList[name])
		else
			debuff_names_seen[name] = nil
		end
	end
end
