assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOZone")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Zone"] = true,
	["Options for zone checks."] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Unknown"] = true,
	["Name"] = true,
	["Optional/Zone"] = true,
	["Perform zone check"] = true,
	["Check the raid's location."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Zone"] = "지역",
	["Options for zone checks."] = "지역 확인에 대한 설정입니다.",
	["Refresh"] = "새로고침",
	["Close"] = "닫기",
	["Unknown"] = "알 수 없음",
	["Name"] = "이름",
	["Optional/Zone"] = "부가/지역",
	["Perform zone check"] = "지역 확인 실시",
	["Check the raid's location."] = "공격대의 위치를 확인합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Zone"] = "区域",
	["Options for zone checks."] = "区域检查选项。",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Zone"] = "选项/区域",
	["Perform zone check"] = "进行区域检查",
	["Check the raid's location."] = "检查团队所在区域。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Zone"] = "區域",
	["Options for zone checks."] = "區域檢查選項",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Unknown"] = "未知",
	["Name"] = "姓名",
	["Optional/Zone"] = "可選/區域",
	["Perform zone check"] = "區域檢查",
	["Check the raid's location."] = "檢查團隊所在區域",
} end )

L:RegisterTranslations("frFR", function() return {
	["Zone"] = "Zone",
	["Options for zone checks."] = "Options concernant les vérifications de zone.",
	["Refresh"] = "Rafraîchir",
	["Close"] = "Fermer",
	["Unknown"] = "Inconnu",
	["Name"] = "Nom",
	["Optional/Zone"] = "Optionnel/Zone",
	["Perform zone check"] = "Vérifier les zones",
	["Check the raid's location."] = "Vérifie la position des membres du raid.",
} end )

L:RegisterTranslations("deDE", function() return {
	["Zone"] = "Zonen",
	["Options for zone checks."] = "Optionen für den Zonen-Check.",
	["Refresh"] = "Erneuern",
	["Close"] = "Schließen",
	["Unknown"] = "Unbekannt",
	["Name"] = "Name",
	["Optional/Zone"] = "Wahlweise/Zonen",
	["Perform zone check"] = "Starte einen Zonen-Check",
	["Check the raid's location."] = "Überprüft die Standorte der Schlachtzugsmitglieder.",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRUS", function() return {
	["Zone"] = "Зона",
	["Options for zone checks."] = "Опции проверки зоны.",
	["Refresh"] = "Обновить",
	["Close"] = "Закрыть",
	["Unknown"] = "Неизвестно",
	["Name"] = "Имя",
	["Optional/Zone"] = "Дополнительно/Зона",
	["Perform zone check"] = "Выполнить проверку зоны",
	["Check the raid's location."] = "Проверка местонахождения рейда.",
} end )


----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("OptionalZone")
mod.participant = true
mod.name = L["Optional/Zone"]
mod.consoleCmd = "zone"
mod.consoleOptions = {
	type = "execute",
	name = L["Perform zone check"],
	desc = L["Check the raid's location."],
	handler = mod,
	func = "PerformZoneCheck",
	disabled = function()
		return not oRA:IsModuleActive(mod)
	end,
}

------------------------------
--      Initialization      --
------------------------------

local players = nil

function mod:OnEnable()
	self:RegisterShorthand("razone", "PerformZoneCheck")
end

-----------------------
--  Command Handlers --
-----------------------

local function RefreshZone()
	mod:PerformZoneCheck()
end

function mod:PerformZoneCheck()
	local playerzone = GetRealZoneText()
	local playername = UnitName("player")

	players = self:del(players)
	players = self:new()

	for i = 1, GetNumRaidMembers() do
		local name, _, _, _, _, class, zone = GetRaidRosterInfo(i)
		zone = zone or L["Unknown"]
		if name ~= playername and zone ~= playerzone then
			table.insert(players, self:new(self.coloredNames[name], zone))
		end
	end
	oRA:OpenWindow(L["Zone"], players, RefreshZone, L["Name"], 125, L["Zone"], 155)
end

