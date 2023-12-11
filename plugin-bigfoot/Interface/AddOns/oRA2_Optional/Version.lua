assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOVersion")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Version"] = true,
	["Options for version checks."] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Unknown"] = true,
	["Name"] = true,
	["Optional/Version"] = true,
	["Perform version check"] = true,
	["Check the raid's versions."] = true,
	["CTRA"] = true,
	["oRA"] = true,
	["n/a"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Version"] = "버전",
	["Options for version checks."] = "버전 확인에 대한 설정입니다.",
	["Refresh"] = "새로고침",
	["Close"] = "닫기",
	["Unknown"] = "알 수 없음",
	["Name"] = "이름",
	["Optional/Version"] = "부가/버전",
	["Perform version check"] = "버전 확인 실시",
	["Check the raid's versions."] = "공격대의 버전을 확인합니다.",
	["CTRA"] = "공격대 도우미",
	["oRA"] = "oRA",
	["n/a"] = "없음",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Version"] = "版本",
	["Options for version checks."] = "版本检查选项。",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Version"] = "选项/版本",
	["Perform version check"] = "进行版本检查",
	["Check the raid's versions."] = "检查团队版本。",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "n/a",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Version"] = "版本",
	["Options for version checks."] = "版本檢查選項",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Version"] = "可選/版本",
	["Perform version check"] = "進行版本檢查",
	["Check the raid's versions."] = "檢查團隊版本",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "無",
} end )

L:RegisterTranslations("frFR", function() return {
	["Version"] = "Version",
	["Options for version checks."] = "Options concernant les vérifications des versions.",
	["Refresh"] = "Rafraîchir",
	["Close"] = "Fermer",
	["Unknown"] = "Inconnu",
	["Name"] = "Nom",
	["Optional/Version"] = "Optionnel/Version",
	["Perform version check"] = "Vérifier les versions",
	["Check the raid's versions."] = "Vérifie les versions du raid.",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "n/a",
} end )

L:RegisterTranslations("deDE", function() return {
	["Version"] = "Version",
	["Options for version checks."] = "Optionen für den Versions-Check.",
	["Refresh"] = "Erneuern",
	["Close"] = "Schließen",
	["Unknown"] = "Unbekannt",
	["Name"] = "Name",
	["Optional/Version"] = "Wahlweise/Version",
	["Perform version check"] = "Starte einen Versionen-Check",
	["Check the raid's versions."] = "Überprüft die oRA und CTRA Versionen des Schlachtzugs.",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "n/a",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Version"] = "Версия",
	["Options for version checks."] = "Опции проверки версии.",
	["Refresh"] = "Обновить",
	["Close"] = "Закрыть",
	["Unknown"] = "Неизвестно",
	["Name"] = "Имя",
	["Optional/Version"] = "Дополнительно/Версия",
	["Perform version check"] = "Выполнить проверку версии",
	["Check the raid's versions."] = "Проверка версий у рейда.",
	["CTRA"] = "CTRA",
	["oRA"] = "oRA",
	["n/a"] = "нет данных",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("OptionalVersion")
mod.participant = true
mod.name = L["Optional/Version"]
mod.consoleCmd = "version"
mod.consoleOptions = {
	type = "execute",
	name = L["Perform version check"],
	desc = L["Check the raid's versions."],
	handler = mod,
	func = "PerformVersionCheck",
	disabled = function()
		return not oRA:IsModuleActive(mod)
	end,
}

------------------------------
--      Initialization      --
------------------------------

local versions = nil
local oRAVersions = {}
local cTRAVersions = {}

function mod:OnEnable()
	self:RegisterShorthand("raver", "PerformVersionCheck")
	self:RegisterShorthand("raversion", "PerformVersionCheck")
	self:RegisterCheck("V", "oRA_UpdateCTRAVersion")
	self:RegisterCheck("oRAV", "oRA_UpdateVersion")
end

------------------------------
-- Event Handlers           --
------------------------------

-- Event handler for the "V " message
-- Will update the roster for the player who sent the V with his version

function mod:oRA_UpdateCTRAVersion(msg, author)
	local version = select(3, msg:find("V (.+)"))
	if version then
		cTRAVersions[author] = version
	end
end

-- Event handler for the "oRAV " message
-- Will update the roster for the player who sent the oRAV with his version

function mod:oRA_UpdateVersion(msg, author)
	local version = select(3, msg:find("oRAV (.+)"))
	if version then
		oRAVersions[author] = version
	end
end

-----------------------
--  Command Handlers --
-----------------------

local function RefreshVersion()
	mod:PerformVersionCheck()
end

function mod:PerformVersionCheck()
	versions = self:del(versions)
	versions = self:new()

	for i = 1, GetNumRaidMembers() do
		local n = GetRaidRosterInfo(i)
		table.insert(versions, self:new(self.coloredNames[n], cTRAVersions[n] or L["n/a"], oRAVersions[n] or L["n/a"]))
	end
	oRA:OpenWindow( L["Version"], versions, RefreshVersion, L["Name"], 130, L["CTRA"], 80, L["oRA"], 80 )
end

