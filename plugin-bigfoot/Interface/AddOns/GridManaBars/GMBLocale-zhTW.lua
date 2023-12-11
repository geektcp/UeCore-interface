local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")

L:RegisterTranslations("zhTW", function() return {
	["Mana"] = "法力",
	["Mana Bar"] = "法力條",
	["Mana Bar options."] = "法力條選項。",

	["Size"] = "大小",
	["Percentage of frame for mana bar"] = "法力條所佔 Grid 框架的比例",
	["Side"] = "邊緣",
	["Side of frame manabar attaches to"] = "法力條依附的邊緣",
	["Left"] = "左",
	["Top"] = "上",
	["Right"] = "右",
	["Bottom"] = "下",

	["Colours"] = "顏色",
	["Colours for the various powers"] = "設定不同能力條的顏色",
	["Mana color"] = "法力顏色",
	["Color for mana"] = "法力顏色",
	["Energy color"] = "能量顏色",
	["Color for energy"] = "能量顏色",
	["Rage color"] = "怒氣顏色",
	["Color for rage"] = "怒氣顏色",
    ["Runic power color"] = "符能顏色",
	["Color for runic power"] = "符能顏色",

	["Ignore Non-Mana"] = "忽略無法力者",
	["Don't track power for non-mana users"] = "不顯示無法力職業法力條",
	["Ignore Pets"] = "忽略寵物",
	["Don't track power for pets"] = "不監視寵物",
} end)