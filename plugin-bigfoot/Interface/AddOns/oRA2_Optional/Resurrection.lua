assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOResurrection")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Resurrections"] = true,
	["Optional/Resurrection"] = true,
	["Options for the resurrection monitor."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Resurrections"] = "부활",
	["Optional/Resurrection"] = "부가/부활",
	["Options for the resurrection monitor."] = "부활 현황 설정입니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Resurrections"] = "复活监视",
	["Optional/Resurrection"] = "选择/复活监视",
	["Options for the resurrection monitor."] = "复活监视选项。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Resurrections"] = "復活監視",
	["Optional/Resurrection"] = "可選/復活",
	["Options for the resurrection monitor."] = "復活監視器選項",
} end)

L:RegisterTranslations("frFR", function() return {
	["Resurrections"] = "Résurrections",
	["Optional/Resurrection"] = "Optionnel/Résurrections",
	["Options for the resurrection monitor."] = "Options concernant le moniteur des résurrections.",
} end)

L:RegisterTranslations("deDE", function() return {
	["Resurrections"] = "Wiederbelebungen",
	["Optional/Resurrection"] = "Wahlweise/Wiederbelebung",
	["Options for the resurrection monitor."] = "Optionen für den Wiederbelebungsmonitor.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Resurrections"] = "Воскрешение",
	["Optional/Resurrection"] = "Дополнительно/Воскрешения",
	["Options for the resurrection monitor."] = "Опции для монитоинга Воскрешения.",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("OptionalRessurection")
mod.defaults = {
	scale = 1,
	hidden = true,
	lock = nil,
}
mod.optional = true
mod.name = L["Optional/Resurrection"]
mod.consoleCmd = "resurrection"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for the resurrection monitor."],
	name = L["Resurrections"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {},
}

------------------------------
--      Initialization      --
------------------------------

local ressers = nil
local text = nil

function mod:OnEnable()
	oRA:MakeDraggableWindow(L["Resurrections"], "oRAResurrectionFrame", mod.consoleOptions, self.db.profile)

	self:RegisterCheck("RES", "oRA_ResurrectionStart")
	self:RegisterCheck("RESNO", "oRA_ResurrectionStop")
	self:RegisterCheck("CANRES", "oRA_PlayerCanResurrect")
	self:RegisterCheck("RESSED", "oRA_PlayerResurrected")
	self:RegisterCheck("NORESSED", "oRA_PlayerNotResurrected")
	self:RegisterBucketEvent("RAID_ROSTER_UPDATE", 4, "CheckMonitor")
end

function mod:OnDisable()
	if self.frame then
		self.frame:Hide()
	end
	ressers = self:del(ressers)
end

------------------------
--   Event Handlers   --
------------------------

function mod:CheckMonitor()
	if not ressers then return end

	local update = nil
	for key, val in pairs(ressers) do
		if not UnitInRaid(key) or not UnitInRaid(val) then
			ressers[key] = nil
			update = true
		end
	end
	if update then
		self:UpdateFrame()
	end
end

function mod:oRA_ResurrectionStart(msg, author)
	local player = select(3, msg:find("^RES (.+)$"))
	if player and author then
		if not ressers then ressers = self:new() end
		ressers[author] = player
		self:UpdateFrame()
	end
end

function mod:oRA_ResurrectionStop(msg, author)
	if ressers and author and ressers[author] then
		ressers[author] = nil
		self:UpdateFrame()
	end
end

function mod:oRA_PlayerCanResurrect(msg, author)
	-- we do nothing with these atm.
end

function mod:oRA_PlayerResurrected(msg, author)
	-- we do nothing with these atm.
end

function mod:oRA_PlayerNotResurrected(msg, author)
	-- we do nothing with these atm.
end


-------------------------
--  Utility Functions  --
-------------------------

function mod:OnCreateFrame()	-- called by core window handler
	self.frame:SetWidth(175)
	self.frame:SetHeight(50)

	text = self.frame:CreateFontString(nil, "ARTWORK")
	text:SetFontObject(GameFontHighlightSmall)
	text:SetJustifyH("CENTER")
	text:SetJustifyV("TOP")
	text:Show()
	text:ClearAllPoints()
	text:SetPoint("TOP", self.frame.title, "BOTTOM", 0, -5)

	self.frame:Hide()
end

function mod:OnToggleFrame(v)  -- called by core window handler
	if v then
		self:UpdateFrame()
	end
end

function mod:UpdateFrame()
	if ressers and self.frame and self.frame:IsVisible() then
		local t = self:new()
		for key, val in pairs(ressers) do
			tinsert(t, string.format("%s: %s", self.coloredNames[key], self.coloredNames[val]))
		end
		table.sort(t)
		text:SetText(table.concat(t, "\n"))
		t = self:del(t)
		self.frame:SetWidth(math.max(text:GetWidth()+15, 175))
		self.frame:SetHeight(math.max(text:GetHeight()+30, 50))
	end
end

