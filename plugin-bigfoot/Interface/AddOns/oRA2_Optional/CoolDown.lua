assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOCoolDown")
local media = LibStub("LibSharedMedia-3.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Cooldowns"] = true,
	["Optional/CoolDown"] = true,
	["Options for the cooldown monitor."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Cooldowns"] = "재사용 대기시간 현황",
	["Optional/CoolDown"] = "부가/재사용 대기시간",
	["Options for the cooldown monitor."] = "재사용 대기시간에 관한 설정입니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Cooldowns"] = "冷却监视器",
	["Optional/CoolDown"] = "选择/冷却",
	["Options for the cooldown monitor."] = "冷却监视器选项。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Cooldowns"] = "冷卻監視器",
	["Optional/CoolDown"] = "可選/冷卻",
	["Options for the cooldown monitor."] = "冷卻監視器的選項",
} end)

L:RegisterTranslations("frFR", function() return {
	["Cooldowns"] = "Temps de recharge",
	["Optional/CoolDown"] = "Optionnel/Temps de recharge",
	["Options for the cooldown monitor."] = "Options concernant le moniteur des temps de recharge.",
} end)

L:RegisterTranslations("deDE", function() return {
	["Cooldowns"] = "Cooldowns",
	["Optional/CoolDown"] = "Wahlweise/Cooldown",
	["Options for the cooldown monitor."] = "Optionen für den Cooldown-Monitor.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Cooldowns"] = "Перезарядки",
	["Optional/CoolDown"] = "Дополнительно/Перезарядка",
	["Options for the cooldown monitor."] = "Опции мониторинга перезарядкок."
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("OptionalCooldown", "CandyBar-2.0")
mod.defaults = {
	scale = 1,
	-- Modified by Sharak@BigFoot
	hidden = true,
	lock = false,
}
mod.optional = true
mod.name = L["Optional/CoolDown"]
mod.consoleCmd = "cooldown"
mod.consoleOptions = {
	type = "group",
	name = L["Cooldowns"],
	desc = L["Options for the cooldown monitor."],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {},
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnRegister()
	if not self.db.realm.cooldowns then
		self.db.realm.cooldowns = {}
	end
end

function mod:OnEnable()
	oRA:MakeDraggableWindow(L["Cooldowns"], "oRACoolDownFrame", mod.consoleOptions, self.db.profile)

	self:RegisterEvent("oRA_BarTexture")
	self:RegisterEvent("oRA_JoinedRaid")
	self:RegisterCheck("CD", "oRA_CoolDown")
end

function mod:OnDisable()
	if self.frame then
		self.frame:Hide()
	end
	self:StopAllCoolDowns()
end

------------------------
--   Event Handlers   --
------------------------

function mod:oRA_JoinedRaid()
	local t = time()
	for i = 1, GetNumRaidMembers() do
		local n = GetRaidRosterInfo(i)
		local val = self.db.realm.cooldowns[n]
		if val and t < val then
			self:StartCoolDown(n, val - t)
		end
	end
end

function mod:oRA_CoolDown(msg, author)
	local what, length = select(3, msg:find("^CD (%d+) (%d+)"))
	if author and what and tonumber(length) then
		local l = tonumber(length) * 60
		self.db.realm.cooldowns[author] = time() + l
		self:StartCoolDown(author, l)
	end
end

function mod:oRA_BarTexture(texture)
	for key, val in pairs(self.db.realm.cooldowns) do
		self:SetCandyBarTexture("oRAOCoolDown "..key, media:Fetch("statusbar", texture))
	end
end

-------------------------
--  Utility Functions  --
-------------------------

function mod:StartAllCoolDowns()
	local t = time()
	for key, val in pairs(self.db.realm.cooldowns) do
		if t >= val then
			self.db.realm.cooldowns[key] = nil
			self:StopCoolDown(key)
		else
			self:StartCoolDown(key, val - t)
		end
	end
end

function mod:StopAllCoolDowns()
	local t = time()
	for key, val in pairs(self.db.realm.cooldowns) do
		if t >= val then self.db.realm.cooldowns[key] = nil end
		self:StopCoolDown(key)
	end
end

local function sizeFrame(height)
	mod.frame:SetHeight(28 + height)
end

function mod:StartCoolDown(player, time)
	if self.db.profile.hidden then return end
	if not UnitInRaid(player) then return end
	local id = "oRAOCoolDown " .. player
	local class = select(2, UnitClass(player))
	local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

	self:RegisterCandyBarGroup("oRAOCoolDownGroup")
	self:SetCandyBarGroupPoint("oRAOCoolDownGroup", "TOP", self.frame.title, "BOTTOM", 0, -5)
	self:SetCandyBarOnSizeGroup("oRAOCoolDownGroup", sizeFrame)
	self:RegisterCandyBar(id, time, player, nil, r, g, b)
	self:RegisterCandyBarWithGroup(id, "oRAOCoolDownGroup")
	self:SetCandyBarWidth(id, 150)
	self:SetCandyBarTexture(id, media:Fetch('statusbar', oRA.db.profile.bartexture))
	self:SetCandyBarScale(id, self.db.profile.scale or 1)
	self:StartCandyBar(id, true)
end

function mod:StopCoolDown(player)
	self:UnregisterCandyBar("oRAOCoolDown "..player)
end

------------------------
--  Window Handling   --
------------------------

function mod:OnCreateFrame()	-- called by core window handler
	self.frame:SetWidth(175)
	sizeFrame(0)
	self.frame:Hide()
end

function mod:OnToggleFrame(v)  -- called by core window handler
	if v then
		self:StartAllCoolDowns()
	else
		self:StopAllCoolDowns()
	end
end

function mod:OnSetScale(scale)  -- called by core window handler
	for key, val in pairs(self.db.realm.cooldowns) do
		if self:IsCandyBarRegistered("oRAOCoolDown "..key) then
			self:SetCandyBarScale("oRAOCoolDown "..key, scale)
		end
	end
end

