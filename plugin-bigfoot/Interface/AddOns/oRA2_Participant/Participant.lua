assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 636 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAParticipant")

local spells = {
	[(GetSpellInfo(20484))] = true, -- Rebirth
	[(GetSpellInfo(2006))] = true, -- Resurrection
	[(GetSpellInfo(7328))] = true, -- Redemption
	[(GetSpellInfo(2008))] = true, -- Ancestral Spirit
	[(GetSpellInfo(20608))] = true, -- Reincarnation
}

local iscasting = nil
local mousedowntarget = nil
local ankhs = nil
local shamanResTime = nil

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Participant"] = true,
	["^Corpse of (.+)$"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["^Corpse of (.+)$"] = "^([^%s]+)의 시체",
} end)

L:RegisterTranslations("zhCN", function() return {
	["^Corpse of (.+)$"] = "^(.+)的尸体",
} end)

L:RegisterTranslations("zhTW", function() return {
	["^Corpse of (.+)$"] = "^(.+)的屍體",
} end)

L:RegisterTranslations("frFR", function() return {
	["Participant"] = "Participant",
	["^Corpse of (.+)$"] = "^Cadavre |2 (.+)$",
} end)

L:RegisterTranslations("deDE", function() return {
	["^Corpse of (.+)$"] = "^Leichnam von (.+)$",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Participant"] = "Участник",
	["^Corpse of (.+)$"] = "^Труп (.+)$",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("ParticipantPassive", "AceHook-2.1")

mod.participant = true
mod.name = L["Participant"]

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	-- CoolDowns
	local _, c = UnitClass("player")
	if c == "DRUID" or c == "WARLOCK" or c == "PALADIN" then
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	elseif c == "SHAMAN" then
		self:RegisterEvent("PLAYER_ALIVE")
		self:RegisterBucketEvent("BAG_UPDATE", 0.5)
	end
	-- durability
	self:RegisterCheck("DURC", "oRA_DurabilityCheck")
	-- resistance check
	self:RegisterCheck("RSTC", "oRA_ResistanceCheck")
	-- latency check
	self:RegisterCheck("LATC", "oRA_LatencyCheck")
	-- resurrection stuff
	iscasting = nil
	mousedowntarget = nil
	ankhs = GetItemCount(17030)
	shamanResTime = GetTime()
	self:HookAndRegisterResurrection()
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PLAYER_ALIVE()
	shamanResTime = GetTime()
end

function mod:BAG_UPDATE()
	if (GetTime() - (shamanResTime or 0)) > 1 then
		return
	end

	local newankhs = GetItemCount(17030)
	if newankhs == (ankhs - 1) then
		local _, _, _, _, rank = GetTalentInfo(3, 3)
		local cooldown = 60 - (rank * 10)
		oRA:SendMessage("CD 2 " .. cooldown)
	end
	ankhs = newankhs
end

local rebirth = GetSpellInfo(20484) -- Rebirth
local soulstone = GetSpellInfo(20707) -- Soulstone Resurrection
local divine = GetSpellInfo(19752) -- Divine Intervention
function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spell, rank)
	if unit ~= "player" then return end

	if spell == rebirth then -- 20484
		oRA:SendMessage("CD 1 20")
	elseif spell == soulstone then -- 20707
		oRA:SendMessage("CD 3 30")
	elseif spell == divine then --19752
		oRA:SendMessage("CD 4 20", true) -- only oRA2 clients will receive this cooldown I just numbered on.
	end
	-- call for resurrection check
	self:SpellStopped(unit)
end

function mod:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
	if not target or target == "" or target == UNKNOWN then target = mousedowntarget end -- set from worldframeonmousedown
	if unit == "player" and spells[spell] and target then
		iscasting = true
		oRA:SendMessage("RES " .. target)
	end
end

function mod:SpellStopped(unit)
	if unit == "player" and iscasting then
		iscasting = nil
		mousedowntarget = nil
		oRA:SendMessage("RESNO")
	end
end

function mod:oRA_DurabilityCheck(msg, author)
	local cur, max, broken = self:GetDurability()
	oRA:SendMessage(string.format("DUR %s %s %s %s", cur, max, broken, author))
end

function mod:oRA_LatencyCheck(msg, author)
	local _, _, latency = GetNetStats()
	oRA:SendMessage(string.format("LAT %s %s", latency, author))
end

function mod:oRA_ResistanceCheck(msg, author)
	local resiststr = ""
	for i = 2, 6, 1 do
		local res = select(2, UnitResistance("player", i))
		resiststr = resiststr .." " .. res
	end
	oRA:SendMessage(string.format("RST%s %s", resiststr, author))
end

---------------
--   Hooks   --
---------------

function mod:WorldFrameOnMouseDown(...)
	if GameTooltipTextLeft1:IsVisible() then
		local name = select(3, GameTooltipTextLeft1:GetText():find(L["^Corpse of (.+)$"]))
		if name then
			mousedowntarget = name
		end
	end
	self.hooks[WorldFrame]["OnMouseDown"](...)
end

------------------------------
--    Utility Functions     --
------------------------------

function mod:GetDurability()
	local cur, max, broken = 0, 0, 0
	for i=1,18 do
		local imin, imax = GetInventoryItemDurability(i)
		if imin and imax then
			imin, imax = tonumber(imin), tonumber(imax)
			if imin == 0 then broken = broken + 1 end
			cur = cur + imin
			max = max + imax
		end
		
	end
	return cur, max, broken
end

function mod:HookAndRegisterResurrection()
	local c = select(2, UnitClass("player"))
	if c == "DRUID" or c == "PRIEST" or c == "SHAMAN" or c == "PALADIN" then
	
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
		
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "SpellStopped")
		self:RegisterEvent("UNIT_SPELLCAST_FAILED", "SpellStopped")
		self:RegisterEvent("UNIT_SPELLCAST_STOP", "SpellStopped")
		-- this is registered by default for cooldowns. SpellStopped will be called from there.
		-- self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "SpellStopped")

		self:HookScript(WorldFrame, "OnMouseDown", "WorldFrameOnMouseDown")
	end

	self:Hook(StaticPopupDialogs["DEATH"], "OnShow", function(...)
			self.hooks[StaticPopupDialogs["DEATH"]].OnShow(...)
			if HasSoulstone() then oRA:SendMessage("CANRES") end end, true)

	self:Hook(StaticPopupDialogs["RESURRECT"], "OnShow", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT"]].OnShow(...)
			oRA:SendMessage("RESSED") end, true)

	self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnShow", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnShow(...)
			oRA:SendMessage("RESSED") end, true)

	self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnShow", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnShow(...)
			oRA:SendMessage("RESSED") end, true)

	-- hrmf we can't hook the OnHide's normally, since they are not there. But
	-- blizzard will fire the OnHide if it finds it.
	-- so some more magic to get this working. And be friendly if someone else created
	-- an OnHide already.

	if not StaticPopupDialogs["RESURRECT"].OnHide then
		StaticPopupDialogs["RESURRECT"].OnHide = function(...) oRA:SendMessage("NORESSED") end
	else 
		self:Hook(StaticPopupDialogs["RESURRECT"], "OnHide", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT"]].OnHide(...)
			oRA:SendMessage("NORESSED") end, true)
	end
	if not StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide then
		StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide = function(...) oRA:SendMessage("NORESSED") end
	else
		self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnHide", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnHide(...)
			oRA:SendMessage("NORESSED") end, true)
	end
	if not StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide then
		StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide = function(...) 
			if not StaticPopup_FindVisible("DEATH") then oRA:SendMessage("NORESSED") end
		end
	else
		self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnHide", function(...)
			self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnHide(...)
			if not StaticPopup_FindVisible("DEATH") then oRA:SendMessage("NORESSED") end end, true)
	end
end

