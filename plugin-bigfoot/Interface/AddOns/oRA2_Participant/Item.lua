assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 646 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPItem")

local reagents = {
	PRIEST = 44615, -- "Devout Candle"
	MAGE = 17020, -- "Arcane Powder",
	DRUID = 44605, -- "Wild Spineleaf"
	WARLOCK = 6265, -- "SoulShard"
	SHAMAN = 17030, -- "Ankh"
	PALADIN = 17033, -- "SymbolofDivinity"
	DEATHKNIGHT = 37201, -- "Corpse Dust"
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Item"] = true,
	["Options for item checks."] = true,
	["Participant/Item"] = true,
	["Disable item checks"] = true,
	["Disable responding to item checks."] = true,
	["Disable reagent checks"] = true,
	["Disable responding to reagent checks."] = true,
} end )

L:RegisterTranslations("koKR", function() return {
	["Item"] = "아이템",
	["Options for item checks."] = "아이템 확인에 대한 설정입니다.",
	["Participant/Item"] = "부분/아이템",
	["Disable item checks"] = "아이템 확인 무시",
	["Disable responding to item checks."] = "아이템 확인에 대한 응답을 하지 않습니다.",
	["Disable reagent checks"] = "재료 확인 무시",
	["Disable responding to reagent checks."] = "재료 확인에 대한 응답을 하지 않습니다.",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Item"] = "物品",
	["Options for item checks."] = "物品检查选项。",
	["Participant/Item"] = "成员/物品",
	["Disable item checks"] = "关闭物品检查",
	["Disable responding to item checks."] = "停止回应物品检查。",
	["Disable reagent checks"] = "关闭施法材料检查",
	["Disable responding to reagent checks."] = "停止回应施法材料检查。",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Item"] = "物品",
	["Options for item checks."] = "物品檢查選項",
	["Participant/Item"] = "隊員/物品",
	["Disable item checks"] = "停用檢查",
	["Disable responding to item checks."] = "停止回應物品檢查。",
	["Disable reagent checks"] = "關閉物品檢查",
	["Disable responding to reagent checks."] = "關閉物品檢查回應",
} end )

L:RegisterTranslations("deDE", function() return {
	["Item"] = "Gegenstand",
	["Participant/Item"] = "Teilnehmer/Gegenstand",
	["Options for item checks."] = "Optionen für Gegenstands-Check.",
	["Disable item checks"] = "Deaktiviere Gegenstands-Checks.",
	["Disable responding to item checks."] = "Deaktiviert die Antwort auf Gegenstands-Checks.",
	["Disable reagent checks"] = "Deaktiviere Reagenzien-Checks",
	["Disable responding to reagent checks."] = "Deaktiviert die Antwort auf Reagenzien-Checks.",
} end )

L:RegisterTranslations("frFR", function() return {
	["Item"] = "Objet",
	["Options for item checks."] = "Options concernant les vérifications des objets.",
	["Participant/Item"] = "Participant/Objet",
	["Disable item checks"] = "Désactiver les vérifications des objets",
	["Disable responding to item checks."] = "Désactive l'envoi d'une réponse lors des vérifications des objets.",
	["Disable reagent checks"] = "Désactiver les vérifications des composants",
	["Disable responding to reagent checks."] = "Désactive l'envoi d'une réponse lors des vérifications des composants.",
} end )

L:RegisterTranslations("ruRU", function() return {
	["Item"] = "Предмет",
	["Options for item checks."] = "Опции проверки предметов.",
	["Participant/Item"] = "Участник/Предмет",
	["Disable item checks"] = "Отключить проверку предметов",
	["Disable responding to item checks."] = "Отключить ответ на проверку предметов.",
	["Disable reagent checks"] = "Отключить проверку реагентов",
	["Disable responding to reagent checks."] = "Отключить ответ на проверку реагентов.",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("ParticipantItem")
mod.defaults = {
	disable = false,
	reagentdisable = false,
}
mod.participant = true
mod.name = L["Participant/Item"]
mod.consoleCmd = "item"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for item checks."],
	name = L["Item"],
	disabled = function() return not oRA:IsActive() end,
	args = {
		disableItem = {
			type = "toggle",
			name = L["Disable item checks"],
			desc = L["Disable responding to item checks."],
			get = function() return mod.db.profile.disable end,
			set = function(v) mod.db.profile.disable = v end,
		},
		disableReagent = {
			type = "toggle",
			name = L["Disable reagent checks"],
			desc = L["Disable responding to reagent checks."],
			get = function() return mod.db.profile.reagentdisable end,
			set = function(v) mod.db.profile.reagentdisable = v end,
		},
		
	}
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterCheck("ITMC", "oRA_ItemCheck")
	self:RegisterCheck("REAC", "oRA_ReagentCheck")
end

-------------------------
--   Event Handlers    --
-------------------------

function mod:oRA_ItemCheck(msg, author)
	local itemname = select(3, msg:find("^ITMC (.+)$"))
	if itemname then
		if self.db.profile.disable then
			oRA:SendMessage("ITM -1 "..itemname.." "..author)
		else
			local numitems = GetItemCount(itemname)
			oRA:SendMessage("ITM "..numitems.." "..itemname.." "..author)
		end
	end
end

function mod:oRA_ReagentCheck(msg, author)
	if self.db.profile.reagentdisable then
		oRA:SendMessage("REA -1 "..author)
	else
		local numitems = self:GetReagents()
		if numitems and numitems > 0 then
			oRA:SendMessage("REA " .. numitems .. " " .. author)
		end
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function mod:GetReagents()
	local class = select(2, UnitClass("player"))
	if reagents[class] then
		return GetItemCount(reagents[class])
	end
	return -1
end

