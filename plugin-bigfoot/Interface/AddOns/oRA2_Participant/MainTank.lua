assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPMainTank")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["MainTank"] = true,
	["Options for the maintanks."] = true,
	["The local maintank list has been refreshed."] = true,
	["Refresh"] = true,
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = true,
	["Participant/MainTank"] = true,
	["Notify deaths"] = true,
	["Notifies you when a main tank dies."] = true,
	["Tank %s has died!"] = true,

	maintankdies = "^([^%s]+) dies%.$",
} end )

L:RegisterTranslations("koKR", function() return {
	["MainTank"] = "메인탱커",
	["Options for the maintanks."] = "메인탱커에 대한 설정입니다.",
	["The local maintank list has been refreshed."] = "로컬 메인탱커 목록이 갱신되었습니다.",
	["Refresh"] = "메인탱커 갱신",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "로컬 메인탱커 목록을 갱신합니다.",
	["Participant/MainTank"] = "부분/메인탱커",
	["Notify deaths"] = "사망 알림",
	["Notifies you when a main tank dies."] = "메인탱커가 사망시 이를 알려줍니다.",
	["Tank %s has died!"] = "메인탱커 %s|1이;가; 죽었습니다!",

	maintankdies = "^([^%s]+)|1이;가; 죽었습니다%.$",
} end )

L:RegisterTranslations("zhCN", function() return {
	["MainTank"] = "MT",
	["Options for the maintanks."] = "MT 选项。",
	["The local maintank list has been refreshed."] = "本地 MT 名单已刷新。",
	["Refresh"] = "刷新 MT",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "刷新本地 MT 名单。",
	["Participant/MainTank"] = "成员/MT 目标",
	["Notify deaths"] = "死亡通知",
	["Notifies you when a main tank dies."] = "当 MT 死亡时通知你。",
	["Tank %s has died!"] = "MT %s 已死亡！",

	maintankdies = "^(.+)死亡了。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["MainTank"] = "主坦",
	["Options for the maintanks."] = "主坦選項",
	["The local maintank list has been refreshed."] = "個人主坦名單已更新",
	["Refresh"] = "更新",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "更新個人主坦名單，特別是主坦名單已經變動而因某些理由沒有更新。\n\n請注意此選項並不會從團隊裡的人取得名單，僅僅只是更新個人的顯示。",
	["Participant/MainTank"] = "隊員/主坦",
	["Notify deaths"] = "死亡通知",
	["Notifies you when a main tank dies."] = "當主坦死亡時通知你",
	["Tank %s has died!"] = "主坦 %s 已死亡!",

	maintankdies = "^(.+)死亡了。",
} end )

L:RegisterTranslations("frFR", function() return {
	["MainTank"] = "Tanks principaux",
	["Options for the maintanks."] = "Options concernant les tanks principaux.",
	["The local maintank list has been refreshed."] = "La liste locale des tanks principaux a été rafraîchie.",
	["Refresh"] = "Rafraîchir",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "Rafraîchit la liste locale des tanks principaux, au cas où des changements n'ont pas été répercutés dans l'affichage pour certaines raisons.\n\nNotez que ceci ne va pas chercher la liste des tanks principaux chez les autres joueurs, mais met à jour uniquement votre affichage local.",
	["Participant/MainTank"] = "Participant/Tanks principaux",
	["Notify deaths"] = "Annoncer les morts",
	["Notifies you when a main tank dies."] = "Prévient quand un tank principal meurt.",
	["Tank %s has died!"] = "Le tank %s est mort !",

	maintankdies = "^([^%s]+) meurt%.$",
} end )

L:RegisterTranslations("deDE", function() return {
	["MainTank"] = "MainTank",
	["Options for the maintanks."] = "Optionen für MainTanks.",
	["The local maintank list has been refreshed."] = "Die lokale MainTank-Liste wurde erneuert.",
	["Refresh"] = "Erneuern",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "Erneuert die lokale MainTank-Liste, falls lokale Änderungen vorgenommen wurden, aber die Anzeige sich aus irgendwelchen Gründen nicht aktualisiert hat.\n\nHinweis: Dies ruft NICHT die MainTank-Liste anderer Personen des Schlachtzugs ab, sondern aktualisiert nur Deine lokale Anzeige.",
	["Participant/MainTank"] = "Teilnehmer/MainTank",
	["Notify deaths"] = "Melde MainTank Tot",
	["Notifies you when a main tank dies."] = "Benachrichtigt Dich, wenn einer der MainTanks stirbt.",
	["Tank %s has died!"] = "MainTank %s ist gestorben!",

	maintankdies = "^([^%s]+) stirbt%.$",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
    ["MainTank"] = "Главный танк",
	["Options for the maintanks."] = "Опции главного танка.",
	["The local maintank list has been refreshed."] = "Местный список танков был обновлен.",
	["Refresh"] = "Обновить",
	["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."] = "Обновляет локальный список главных танков, которые были у вас ранее не показаные.\n\nЗамечу это  не обновить списко людей рейда, это обновить только локальный список.",
	["Participant/MainTank"] = "Участник/ГлавныйТанк",
	["Notify deaths"] = "Сообщать о смерти",
	["Notifies you when a main tank dies."] = "Извещать о смерти танков.",
	["Tank %s has died!"] = "Танк %s умер!",

	maintankdies = "^([^%s]+) умер%.$",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------
local mod = oRA:NewModule("ParticipantMT")
mod.defaults = {
	notifydeath = false,
}
mod.participant = true
mod.name = L["Participant/MainTank"]
mod.consoleCmd = "mt"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {
		refresh = {
			name = L["Refresh"], type = "execute",
			desc = L["Refresh the local main tank list, in case changes were done locally that were not picked up by the display for any reason.\n\nNote that this does not fetch main tank lists from other people in your raid, it just updates your local display."],
			func = "Refresh",
			disabled = function() return not oRA:IsModuleActive(mod) end,
			order = 300,
		},
		notifydeath = {
			name = L["Notify deaths"], type = "toggle",
			desc = L["Notifies you when a main tank dies."],
			get = function() return mod.db.profile.notifydeath end,
			set = function(v) mod.db.profile.notifydeath = v end,
			order = 301,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function mod:OnRegister()
	if not oRA.maintanktable then
		oRA.maintanktable = oRA.db.profile.maintanktable or {}
	end
end

function mod:OnEnable()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("oRA_JoinedRaid")
	self:RegisterCheck("SET", "oRA_SetMainTank")
	self:RegisterCheck("R", "oRA_RemoveMainTank")
end

function mod:OnDisable()
	for k in pairs(oRA.maintanktable) do
		oRA.maintanktable[k] = nil
	end
	oRA.db.profile.maintanktable = nil
end

-------------------------------
--      Event Handlers       --
-------------------------------

local red = {r = 1, g = 0, b = 0}
function mod:COMBAT_LOG_EVENT_UNFILTERED(_, event, _, _, _, _, tank)
	if event ~= "UNIT_DIED" then return end
	if not self.db.profile.notifydeath then return end
	if not tank then return end
	for k, name in pairs(oRA.maintanktable) do
		if name == tank then
			-- I'm pretty sure this is the same sound that CTRA uses, someone
			-- should confirm.
			if BigWigs then
				self:TriggerEvent("BigWigs_Message", L["Tank %s has died!"]:format(name), red, true, false)
			elseif RaidNotice_AddMessage and RaidWarningFrame then
				RaidNotice_AddMessage(RaidWarningFrame, L["Tank %s has died!"]:format(name), red)
			end
			PlaySound("igQuestFailed")
		end
	end
end

do
	local tanks = {}
	local function reallySetTanks()
		local changed = nil
		for num, name in pairs(tanks) do
			if not oRA.maintanktable[num] or oRA.maintanktable[num] ~= name then
				for i, n in pairs(oRA.maintanktable) do
					if n == name then oRA.maintanktable[i] = nil end
				end
				oRA.maintanktable[num] = name
				changed = true
			end
		end
		for k in pairs(tanks) do tanks[k] = nil end
		if changed then
			oRA.db.profile.maintanktable = oRA.maintanktable
			mod:TriggerEvent("oRA_MainTankUpdate")
		end
	end

	function mod:oRA_SetMainTank(msg, author)
		local num, name = select(3, msg:find("^SET (%d+) (.+)$"))
		if not num or not name then return end
		tanks[tonumber(num)] = name
		self:ScheduleEvent("oRAPMT_ReallySetTanks", reallySetTanks, 2)
	end
end

function mod:oRA_RemoveMainTank(msg, author)
	local name = select(3, msg:find("^R (.+)$"))
	if not name then return end

	self:RemoveTank(name)
	self:TriggerEvent("oRA_MainTankUpdate")
end

function mod:oRA_JoinedRaid()
	oRA:SendMessage("GETMT", true)
end

-------------------------------
--     Utility Functions     --
-------------------------------

function mod:RemoveTank(name)
	for n, t in pairs(oRA.maintanktable) do
		if t == name then
			oRA.maintanktable[n] = nil
		end
	end
	oRA.db.profile.maintanktable = oRA.maintanktable
end

-------------------------------
--      Command Handlers     --
-------------------------------

function mod:Refresh()
	self:TriggerEvent("oRA_MainTankUpdate")
	self:Print(L["The local maintank list has been refreshed."])
end

