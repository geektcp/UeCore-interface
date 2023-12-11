assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPRaidWarn")

local blockRx = "%*+ .+ %*+$"

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Raidwarning"] = true,
	["Options for raid warning."] = true,
	["Participant/RaidWarn"] = true,
	["Bossblock"] = true,
	["Block messages from Bossmods."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Raidwarning"] = "공격대 경고",
	["Options for raid warning."] = "공격대 경고에 대한 설정입니다.",
	["Participant/RaidWarn"] = "부분/공격대경고",
	["Bossblock"] = "보스차단",
	["Block messages from Bossmods."] = "보스 모드 관련 메세지를 차단합니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Raidwarning"] = "团队警报",
	["Options for raid warning."] = "团队警报选项。",
	["Participant/RaidWarn"] = "成员/团队警报",
	["Bossblock"] = "阻止 Bossmods 预警",
	["Block messages from Bossmods."] = "阻止 Bossmods 的预警消息。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Raidwarning"] = "團隊警告",
	["Options for raid warning."] = "團隊警告選項",
	["Participant/RaidWarn"] = "隊員/團隊警告",
	["Bossblock"] = "阻擋bossmod預警",
	["Block messages from Bossmods."] = "阻擋bossmod的預警訊息",
} end )

L:RegisterTranslations("frFR", function() return {
	["Raidwarning"] = "Avertissement raid",
	["Options for raid warning."] = "Options concernant l'Avertissement raid.",
	["Participant/RaidWarn"] = "Participant/Alerte raid",
	["Bossblock"] = "Bloquer BossMods",
	["Block messages from Bossmods."] = "Bloque les messages provenant des bossmods.",
} end )

L:RegisterTranslations("deDE", function() return {
	["Raidwarning"] = "Schlachtzugswarnung",
	["Options for raid warning."] = "Optionen für Schlachtzugswarnungen.",
	["Participant/RaidWarn"] = "Teilnehmer/Schlachtzugswarnung",
	["Bossblock"] = "BossMods blockieren",
	["Block messages from Bossmods."] = "Blockiert Meldungen die von BossMods versendet werden.",
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Raidwarning"] = "Объявление рейду",
	["Options for raid warning."] = "Опции объявления рейду.",
	["Participant/RaidWarn"] = "Участник/Об.Рейду",
	["Bossblock"] = "Блокировать БоссМод",
	["Block messages from Bossmods."] = "Блокировать сообщения БоссМода.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("ParticipantRaidWarn")

mod.defaults = {
	bossblock = true,
}
mod.participant = true
mod.name = L["Participant/RaidWarn"]
mod.consoleCmd = "rw"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for raid warning."],
	name = L["Raidwarning"],
	disabled = function() return not oRA:IsActive() end,
	args = {
		bossblock = {
			name = L["Bossblock"], type = "toggle",
			desc = L["Block messages from Bossmods."],
			get = function() return mod.db.profile.bossblock end,
			set = function(v)
				mod.db.profile.bossblock = v
			end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterCheck("MS", "oRA_RaidWarnMessage")
end

-------------------------------
--      Event Handlers       --
-------------------------------

function mod:oRA_RaidWarnMessage(msg, author)
	if not msg then return end
	msg = select(3, msg:find("^MS (.+)$"))
	if not msg then return end

	if self.db.profile.bossblock and self:IsSpam(msg) then return end
	PlaySound("RaidWarning")
	RaidNotice_AddMessage(RaidWarningFrame, author .. ": " .. msg, ChatTypeInfo["RAID_WARNING"])
end

function mod:IsSpam(text)
	if not text then return end
	if text:find(blockRx) then return true end
end

