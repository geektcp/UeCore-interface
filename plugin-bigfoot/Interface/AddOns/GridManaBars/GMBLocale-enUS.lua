local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")

L:RegisterTranslations("enUS", function() return {
	["Mana"] = true,
	["Mana Bar"] = true,
	["Mana Bar options."] = true,

	["Size"] = true,
	["Percentage of frame for mana bar"] = true,
	["Side"] = true,
	["Side of frame manabar attaches to"] = true,
	["Left"] = true,
	["Top"] = true,
	["Right"] = true,
	["Bottom"] = true,

	["Colours"] = true,
	["Colours for the various powers"] = true,
	["Mana color"] = true,
	["Color for mana"] = true,
	["Energy color"] = true,
	["Color for energy"] = true,
	["Rage color"] = true,
	["Color for rage"] = true,
    ["Runic power color"] = true,
	["Color for runic power"] = true,

	["Ignore Non-Mana"] = true,
	["Don't track power for non-mana users"] = true,
	["Ignore Pets"] = true,
	["Don't track power for pets"] = true,
} end)