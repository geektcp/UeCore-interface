assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALLatency")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Options for latency checks."] = true,
	["Leader/Latency"] = true,
	["Latency"] = true,
	["Latency checks disabled."] = true,
	["Refresh"] = true,
	["Close"] = true,
	["Name"] = true,
	["Perform latency check"] = true,
	["Check the raid's latencies."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Options for latency checks."] = "지연 시간 확인에 대한 설정입니다.",
	["Leader/Latency"] = "공격대장/지연 시간",
	["Latency"] = "지연 시간",
	["Latency checks disabled."] = "지연 시간 확인을 비활성화 합니다.",
	["Refresh"] = "새로고침",
	["Close"] = "닫기",
	["Name"] = "이름",
	["Perform latency check"] = "지연 시간 확인 실시",
	["Check the raid's latencies."] = "공격대의 지연 시간을 확인합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Options for latency checks."] = "延迟检查选项。",
	["Leader/Latency"] = "领袖/延迟",
	["Latency"] = "延迟",
	["Latency checks disabled."] = "延迟检查关闭。",
	["Refresh"] = "刷新",
	["Close"] = "关闭",
	["Name"] = "名字",
	["Perform latency check"] = "进行延迟检查",
	["Check the raid's latencies."] = "检查团员的延迟。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Options for latency checks."] = "延遲檢查選項",
	["Leader/Latency"] = "領隊/延遲",
	["Latency"] = "延遲",
	["Latency checks disabled."] = "關閉延遲檢查",
	["Refresh"] = "更新",
	["Close"] = "關閉",
	["Name"] = "名字",
	["Perform latency check"] = "進行延遲檢查",
	["Check the raid's latencies."] = "檢查團員的延遲",
} end )

L:RegisterTranslations("frFR", function() return {
	["Options for latency checks."] = "Options concernant les vérifications des latences.",
	["Leader/Latency"] = "Chef/Latence",
	["Latency"] = "Latence",
	["Latency checks disabled."] = "Vérifications des latences désactivées.",
	["Refresh"] = "Rafraîchir",
	["Close"] = "Fermer",
	["Name"] = "Nom",
	["Perform latency check"] = "Vérifier les latences",
	["Check the raid's latencies."] = "Vérifie les latences du raid.",
} end )

L:RegisterTranslations("deDE", function() return {
	["Options for latency checks."] = "Optionen für Latenz-Checks",
	["Leader/Latency"] = "Anführer/Latenz",
	["Latency"] = "Latenz",
	["Latency checks disabled."] = "Latenz-Checks deaktiviert.",
	["Refresh"] = "Erneuern",
	["Close"] = "Schließen",
	["Name"] = "Name",
	["Perform latency check"] = "Starte einen Latenz-Check",
	["Check the raid's latencies."] = "Überprüft die Latenzen des Schlachtzugs.",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Options for latency checks."] = "Опции проверки задержки",
	["Leader/Latency"] = "Лидер/Задержка",
	["Latency"] = "Задержка",
	["Latency checks disabled."] = "Проверка задержки отключена",
	["Refresh"] = "Обновить",
	["Close"] = "Закрыть",
	["Name"] = "Имя",
	["Perform latency check"] = "Выполнить проверку задержки",
	["Check the raid's latencies."] = "Проверяеет задержку(пинг) рейда",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderLatency")
mod.participant = true
mod.name = L["Leader/Latency"]
mod.consoleCmd = "latency"
mod.consoleOptions = {
	type = "execute",
	name = L["Perform latency check"],
	desc = L["Check the raid's latencies."],
	handler = mod,
	func = "PerformLatencyCheck",
	disabled = function()
		return not oRA:IsModuleActive(mod) or not oRA:IsPromoted()
	end,
}

------------------------------
--      Initialization      --
------------------------------

local latencies = nil

function mod:OnEnable()
	self:RegisterCheck("LAT", "oRA_LatencyResponse")
	self:RegisterShorthand("ralatency", "PerformLatencyCheck")
end

-------------------------
--   Event Handlers    --
-------------------------

function mod:oRA_LatencyResponse(msg, author)
	local latency, requestby = select(3, msg:find("^LAT (%d+) ([^%s]+)$"))
	if latency and requestby and requestby == UnitName("player") then
		self:AddPlayer(author, latency)
		oRA:UpdateWindow()
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function mod:AddPlayer(nick, latency)
	table.insert(latencies, self:new(self.coloredNames[nick], latency))
end

----------------------
-- Command Handlers --
----------------------

local function RefreshLatency()
	mod:PerformLatencyCheck()
end

function mod:PerformLatencyCheck()
	if not oRA:IsPromoted() then return end

	latencies = self:del(latencies)
	latencies = self:new()

	oRA:SendMessage("LATC")
	oRA:OpenWindow( L["Latency"], latencies, RefreshLatency, L["Name"], 160, L["Latency"], 100)
end

