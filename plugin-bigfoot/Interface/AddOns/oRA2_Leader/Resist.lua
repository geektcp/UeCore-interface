assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALResist")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Options for resistance checks."] = true,
	["Leader/Resist"] = true,
	["Name"] = true,
	["Fire"] = true,
	["Nature"] = true,
	["Frost"] = true,
	["Shadow"] = true,
	["Arcane"] = true,
	["Resistance checks disabled."] = true,
	["Resistances"] = true,
	["Fr"] = true,
	["Ft"] = true,
	["N"] = true,
	["A"] = true,
	["S"] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Perform resistance check"] = true,
	["Check the raid's resistances."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Options for resistance checks."] = "저항력 확인에 대한 설정입니다.",
	["Leader/Resist"] = "공격대장/저항",
	["Name"] = "이름",
	["Fire"] = "화염",
	["Nature"] = "자연",
	["Frost"] = "냉기",
	["Shadow"] = "암흑",
	["Arcane"] = "비전",
	["Resistance checks disabled."] = "저항력 확인이 불가능합니다.",
	["Resistances"] = "저항",
	["Fr"] = "화",
	["Ft"] = "냉",
	["N"] = "자",
	["A"] = "비",
	["S"] = "암",
	["Refresh"] = "새로고침",
	["Close"] = "닫기",
	["Perform resistance check"] = "저항 확인 실시",
	["Check the raid's resistances."] = "공격대원의 저항력을 확인합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Options for resistance checks."] = "抗性助手选项。",
	["Leader/Resist"] = "团长/抗性",
	["Name"] = "姓名",
	["Fire"] = "火焰",
	["Nature"] = "自然",
	["Frost"] = "冰霜",
	["Shadow"] = "暗影",
	["Arcane"] = "奥术",
	["Resistance checks disabled."] = "禁止抗性检查。",
	["Resistances"] = "抗性",
	["Fr"] = "火",
	["Ft"] = "冰",
	["N"] = "自",
	["A"] = "奥",
	["S"] = "暗",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Perform resistance check"] = "进行抗性检查",
	["Check the raid's resistances."] = "检查团队抗性。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Options for resistance checks."] = "抗性助手選項",
	["Leader/Resist"] = "領隊/抗性",
	["Name"] = "姓名",
	["Fire"] = "火焰",
	["Nature"] = "自然",
	["Frost"] = "冰霜",
	["Shadow"] = "暗影",
	["Arcane"] = "秘法",
	["Resistance checks disabled."] = "已停用抗性檢查",
	["Resistances"] = "抗性",
	["Fr"] = "火",
	["Ft"] = "冰",
	["N"] = "自",
	["A"] = "秘",
	["S"] = "暗",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Perform resistance check"] = "進行抗性檢查",
	["Check the raid's resistances."] = "檢查團隊抗性",
} end )

L:RegisterTranslations("frFR", function() return {
	["Options for resistance checks."] = "Options concernant les vérifications des résistances.",
	["Leader/Resist"] = "Chef/Résistances",
	["Name"] = "Nom",
	["Fire"] = "Feu",
	["Nature"] = "Nature",
	["Frost"] = "Givre",
	["Shadow"] = "Ombre",
	["Arcane"] = "Arcanes",
	["Resistance checks disabled."] = "Vérifications des résistances désactivées.",
	["Resistances"] = "Résistances",
	["Fr"] = "F",
	["Ft"] = "G",
	["N"] = "N",
	["A"] = "A",
	["S"] = "O",
	["Refresh"] = "Rafraîchir",
	["Close"] = "Fermer",
	["Perform resistance check"] = "Vérifier les résistances",
	["Check the raid's resistances."] = "Vérifie les résistances du raid.",
} end )

L:RegisterTranslations("deDE", function() return {
	["Options for resistance checks."] = "Optionen für Resistenz-Checks.",
	["Leader/Resist"] = "Anführer/Resistenzen",
	["Name"] = "Name",
	["Fire"] = "Feuer",
	["Nature"] = "Natur",
	["Frost"] = "Frost",
	["Shadow"] = "Schatten",
	["Arcane"] = "Arkan",
	["Resistance checks disabled."] = "Resistenz-Checks deaktiviert.",
	["Resistances"] = "Resistenzen",
	["Fr"] = "Fr",
	["Ft"] = "Ft",
	["N"] = "Nt",
	["A"] = "Ar",
	["S"] = "Sch",
	["Refresh"] = "Erneuern",
	["Close"] = "Schließen",
	["Perform resistance check"] = "Starte einen Resistenz-Check",
	["Check the raid's resistances."] = "Überprüft die Resistenzen des Schlachtzugs.",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Options for resistance checks."] = "Опции проверки сопротивления",
	["Leader/Resist"] = "Лидер/Сопрот.",
	["Name"] = "Название",
	["Fire"] = "Огоню",
	["Nature"] = "Природе",
	["Frost"] = "Льду",
	["Shadow"] = "Тьме",
	["Arcane"] = "Тайной магии",
	["Resistance checks disabled."] = "Проверка сопротивления выключена.",
	["Resistances"] = "Сопротивления ",
	["Fr"] = "Ог",
	["Ft"] = "Лед",
	["N"] = "П",
	["A"] = "ТМ",
	["S"] = "Т",
	["Refresh"] = "Обновить",
	["Close"] = "Закрыть",
	["Perform resistance check"] = "Выполнить проверку сопротивления",
	["Check the raid's resistances."] = "Проверка сопротивления рейда",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderResist")
mod.participant = true
mod.name = L["Leader/Resist"]
mod.consoleCmd = "resist"
mod.consoleOptions = {
	type = "execute",
	name = L["Perform resistance check"],
	desc = L["Check the raid's resistances."],
	handler = mod,
	func = "PerformResistanceCheck",
	disabled = function()
		return not oRA:IsModuleActive(mod) or not oRA:IsPromoted()
	end,
}

------------------------------
--      Initialization      --
------------------------------

local resists = nil

function mod:OnEnable()
	self:RegisterCheck("RST", "oRA_ResistanceResponse")
	self:RegisterShorthand("raresist", "PerformResistanceCheck")
end

-------------------------
--   Event Handlers    --
-------------------------

function mod:oRA_ResistanceResponse( msg, author)
	local requestby = select(3, msg:find("^RST %-1 ([^%s]+)$"))
	if requestby and requestby == UnitName("player") then
		self:Print(author .. " " .. L["Resistance checks disabled."])
	else
		local fire, nature, frost, shadow, arcane, requestby = select(3, msg:find("^RST (%d+) (%d+) (%d+) (%d+) (%d+) ([^%s]+)$"))
		if fire and requestby and requestby == UnitName("player") then
			self:AddPlayer(author, tonumber(fire), tonumber(nature), tonumber(frost), tonumber(shadow), tonumber(arcane))
			oRA:UpdateWindow()
		end
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function mod:AddPlayer(nick, fire, nature, frost, shadow, arcane)
	table.insert(resists, self:new(self.coloredNames[nick], fire, nature, frost, shadow, arcane))
end

----------------------
-- Command Handlers --
----------------------

local function RefreshResistance()
	mod:PerformResistanceCheck()
end

function mod:PerformResistanceCheck()
	if not oRA:IsPromoted() then return end

	resists = self:del(resists)
	resists = self:new()

	oRA:SendMessage("RSTC")
	oRA:OpenWindow(L["Resistances"], resists, RefreshResistance, L["Name"], 130, L["Fr"], 30, L["N"], 30, L["Ft"], 30, L["S"], 30, L["A"], 30)
end

