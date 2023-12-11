assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALDurability")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Durability"] = true,
	["Leader/Durability"] = true,
	["Options for durability checks."] = true,
	["Perform durability check"] = true,
	["Check the raid's durability."] = true,
	["Name"] = true,
	["Percent"] = true,
	["Broken"] = true,
	["Perc"] = true,
	["Close"] = true,
	["Refresh"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Durability"] = "내구도",
	["Leader/Durability"] = "공격대장/내구도",
	["Options for durability checks."] = "내구도 확인에 대한 설정입니다.",
	["Perform durability check"] = "내구도 확인 실시",
	["Check the raid's durability."] = "공격대원의 아이템의 내구도를 확인합니다.",
	["Name"] = "이름",
	["Percent"] = "백분률",
	["Broken"] = "파손",
	["Perc"] = "백분률",
	["Close"] = "닫기",
	["Refresh"] = "새로고침",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Durability"] = "装备耐久度",
	["Leader/Durability"] = "团长/耐久度",
	["Options for durability checks."] = "耐久度选项。",
	["Perform durability check"] = "进行耐久度检查",
	["Check the raid's durability."] = "检查团队耐久度。",
	["Name"] = "姓名",
	["Percent"] = "百分比",
	["Broken"] = "损坏",
	["Perc"] = "百分比",
	["Close"] = "关闭",
	["Refresh"] = "刷新",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Durability"] = "裝備耐久度",
	["Leader/Durability"] = "領隊/裝備耐久度",
	["Options for durability checks."] = "耐久度選項",
	["Perform durability check"] = "進行耐久度檢查",
	["Check the raid's durability."] = "檢查團隊耐久度",
	["Name"] = "姓名",
	["Percent"] = "百分比",
	["Broken"] = "損壞",
	["Perc"] = "百分比",
	["Close"] = "關閉",
	["Refresh"] = "更新",
} end )

L:RegisterTranslations("frFR", function() return {
	["Durability"] = "Durabilité",
	["Leader/Durability"] = "Chef/Durabilité",
	["Options for durability checks."] = "Options concernant les vérifications des durabilités.",
	["Perform durability check"] = "Vérifier les durabilités",
	["Check the raid's durability."] = "Vérifie les durabilités du raid.",
	["Name"] = "Nom",
	["Percent"] = "Pourcentage",
	["Broken"] = "Cassé(s)",
	["Perc"] = "Pourc",
	["Close"] = "Fermer",
	["Refresh"] = "Rafraîchir",
} end )

L:RegisterTranslations("deDE", function() return {
	["Durability"] = "Haltbarkeit",
	["Leader/Durability"] = "Anführer/Haltbarkeit",
	["Options for durability checks."] = "Optionen für den Haltbarkeits-Check.",
	["Perform durability check"] = "Starte einen Haltbarkeits-Check",
	["Check the raid's durability."] = "Überprüft die Haltbarkeitswerte des Schlachtzugs.",
	["Name"] = "Name",
	["Percent"] = "Prozent",
	["Broken"] = "Beschädigt",
	["Perc"] = "Proz",
	["Close"] = "Schließen",
	["Refresh"] = "Erneuern",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Durability"] = "Прочность",
	["Leader/Durability"] = "Лидер/Прочность",
	["Options for durability checks."] = "Опции проверки прочности.",
	["Perform durability check"] = "Выполнить проверку прочности",
	["Check the raid's durability."] = "Проверка прочности рейда.",
	["Name"] = "Имя",
	["Percent"] = "Процент",
	["Broken"] = "Cломан",
	["Perc"] = "%",
	["Close"] = "Закрыть",
	["Refresh"] = "Обновить",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderDurability")
mod.leader = true
mod.name = L["Leader/Durability"]
mod.consoleCmd = "durability"
mod.consoleOptions = {
	type = "execute",
	handler = mod,
	name = L["Perform durability check"],
	desc = L["Check the raid's durability."],
	func = "PerformDurabilityCheck",
	disabled = function()
		return not oRA:IsModuleActive(mod) or not oRA:IsPromoted()
	end,
}

------------------------------
--      Initialization      --
------------------------------

local durability = nil

function mod:OnEnable()
	self:RegisterCheck("DUR", "oRA_DurabilityResponse")
	self:RegisterShorthand("radur", "PerformDurabilityCheck")
end

--------------------
-- Event Handlers --
--------------------

local pName = UnitName("player")
function mod:oRA_DurabilityResponse(msg, author)
	local cur, max, broken, requestby = select(3, msg:find("^DUR (%d+) (%d+) (%d+) ([^%s]+)$"))
	if cur and requestby and requestby == pName then
		local p = math.floor(cur / max * 100)
		self:AddPlayer(author, p, broken)
		oRA:UpdateWindow()
	end
end

----------------------
-- Command handlers --
----------------------

local function RefreshDurability()
	mod:PerformDurabilityCheck()
end

function mod:PerformDurabilityCheck()
	if not oRA:IsPromoted() then return end

	durability = self:del(durability)
	durability = self:new()

	oRA:SendMessage("DURC")
	oRA:OpenWindow(L["Durability"], durability, RefreshDurability, L["Name"], 130, L["Perc"], 80, L["Broken"], 80)
end

function mod:AddPlayer(nick, perc, broken)
	table.insert(durability, self:new(self.coloredNames[nick], perc, broken or 0))
end

