------------------------------
--      Are you local?      --
------------------------------

local withcore = {}
local asleader = {}

------------------------------
--    Addon Declaration     --
------------------------------

oRALoD = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")

------------------------------
--      Initialization      --
------------------------------

function oRALoD:OnInitialize()
	local numAddons = GetNumAddOns()
	for i = 1, numAddons do
		if not IsAddOnLoaded(i) and IsAddOnLoadOnDemand(i) then
			local meta = GetAddOnMetadata(i, "X-oRA-LoadAsLeader")
			if meta then
				table.insert(asleader, i)
			end
			meta = GetAddOnMetadata(i, "X-oRA-LoadWithCore")
			if meta then
				-- register this addon for loading with core
				table.insert(withcore, i)
			end
		end
	end
end

function oRALoD:OnEnable()
	self:RegisterEvent("oRA_CoreEnabled")
	self:RegisterEvent("oRA_PlayerPromoted")
	self:RegisterEvent("RAID_ROSTER_UPDATE")
end

------------------------------
--     Event Handlers       --
------------------------------

function oRALoD:oRA_CoreEnabled()
	if not withcore then return end

	local loaded = false
	for k,v in ipairs(withcore) do
		if not IsAddOnLoaded(v) then
			loaded = true
			LoadAddOn(v)
		end
	end	

	withcore = nil

	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
		-- Just collect garbage right away, since we will discard lots of unused
		-- translations.
		collectgarbage("collect")
	end
end

do
	local inRaid = false
	local firedPromotedEvent = nil
	function oRALoD:RAID_ROSTER_UPDATE()
		local isInRaidNow = UnitInRaid("player")
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then return end
		if not inRaid and isInRaidNow then
			oRA:ToggleActive(true)
			self:TriggerEvent("oRA_JoinedRaid")
			inRaid = true
			if (IsRaidLeader() or IsRaidOfficer()) then
				self:TriggerEvent("oRA_PlayerPromoted")
				firedPromotedEvent = true
			else
				firedPromotedEvent = nil
			end
		elseif inRaid and not isInRaidNow then
			self:TriggerEvent("oRA_LeftRaid")
			oRA:ToggleActive(false)
			inRaid = false
			firedPromotedEvent = nil
		elseif inRaid and not firedPromotedEvent and (IsRaidLeader() or IsRaidOfficer()) then
			self:TriggerEvent("oRA_PlayerPromoted")
			firedPromotedEvent = true
		end
	end
end

function oRALoD:oRA_PlayerPromoted()
	if not asleader then return end
	local loaded = false
	for k,v in ipairs(asleader) do
		if not IsAddOnLoaded(v) then
			loaded = true
			LoadAddOn(v)
		end
	end	

	asleader = nil

	if loaded then
		self:TriggerEvent("oRA_ModulePackLoaded")
		-- Just collect garbage right away, since we will discard lots of unused
		-- translations.
		collectgarbage("collect")
	end
end

