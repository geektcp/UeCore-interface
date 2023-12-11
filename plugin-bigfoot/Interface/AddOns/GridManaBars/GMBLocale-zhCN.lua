local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")

L:RegisterTranslations("zhCN", function() return {
	["Mana"] = "法力",
	["Mana Bar"] = "法力条",
	["Mana Bar options."] = "法力条选项。",

	["Size"] = "大小",
	["Percentage of frame for mana bar"] = "法力条所占 Grid 框体的比例",
	["Side"] = "位置",
	["Side of frame manabar attaches to"] = "法力条所在的位置",
	["Left"] = "左侧",
	["Top"] = "顶部",
	["Right"] = "右侧",
	["Bottom"] = "底部",

	["Colours"] = "颜色",
	["Colours for the various powers"] = "不同种类能力条的颜色",
	["Mana color"] = "法力颜色",
	["Color for mana"] = "法力颜色",
	["Energy color"] = "能量颜色",
	["Color for energy"] = "能量颜色",
	["Rage color"] = "怒气颜色",
	["Color for rage"] = "怒气颜色",
    ["Runic power color"] = "符文能量颜色",
	["Color for runic power"] = "符文能量颜色",

	["Ignore Non-Mana"] = "忽略非法力条",
	["Don't track power for non-mana users"] = "不显示非法力条",
	["Ignore Pets"] = "忽略宠物",
	["Don't track power for pets"] = "不监视宠物",
} end)