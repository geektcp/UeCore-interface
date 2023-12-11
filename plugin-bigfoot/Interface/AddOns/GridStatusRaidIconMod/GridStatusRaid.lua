-- -------------------------------------------------------------------------- --
-- GridStatusRaidIcons by kunda                                               --
-- -------------------------------------------------------------------------- --

local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")
local L = GridStatusRaidIcons_Locales
local GridRaidIconFrame = Grid:GetModule("GridRaidIconFrame")
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")

local GridStatusRaidIcons = Grid:GetModule("GridStatus"):NewModule("GridStatusRaidIcons")
GridStatusRaidIcons.menuName = RAID_TARGET_ICON


local _G = _G
local UnitGUID = _G.UnitGUID
local UnitExists = _G.UnitExists
local GetRaidTargetIndex = _G.GetRaidTargetIndex

local LOC_PLAYER       = RAID_TARGET_ICON..": "..PLAYER

local statusmap = GridFrame.db.profile.statusmap

local icontextcolor = {
	[1] = {r = 1.0,  g = 0.92, b = 0,     hex = "ffeb00", text = RAID_TARGET_1}, -- Yellow 4-point Star
	[2] = {r = 0.98, g = 0.57, b = 0,     hex = "fa9100", text = RAID_TARGET_2}, -- Orange Circle
	[3] = {r = 0.83, g = 0.22, b = 0.9,   hex = "d438e6", text = RAID_TARGET_3}, -- Purple Diamond
	[4] = {r = 0.04, g = 0.95, b = 0,     hex = "0af200", text = RAID_TARGET_4}, -- Green Triangle
	[5] = {r = 0.7,  g = 0.82, b = 0.875, hex = "b3d1df", text = RAID_TARGET_5}, -- White Crescent Moon
	[6] = {r = 0,    g = 0.71, b = 1,     hex = "00b5ff", text = RAID_TARGET_6}, -- Blue Square
	[7] = {r = 1.0,  g = 0.24, b = 0.168, hex = "ff3d2b", text = RAID_TARGET_7}, -- Red 'X' Cross
	[8] = {r = 0.98, g = 0.98, b = 0.98,  hex = "fafafa", text = RAID_TARGET_8}  -- White Skull
}

GridStatusRaidIcons.defaultDB = {
	debug = false,
	raidicon_player = {
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
		[8] = true,
	},

	alert_raidicons_player = {
		text =  LOC_PLAYER,
		enable = true,
		priority = 90,
		range = false,
		highlight = false,
	},

}

GridStatusRaidIcons.options = false

function GridStatusRaidIcons:OnInitialize()
	self.super.OnInitialize(self)

	local menu_player = {
		["Raid Icon Size"] = {
			type = "range",
			name = L["Size"],
			desc = L["Raid Icon Size"],
			max = 42,
			min = 15,
			order = 50,
			step = 1,
			get = function()
					return GridRaidIconFrame.db.profile.size
				end,
			set = function(v)
					GridRaidIconFrame.db.profile.size = v
					GridFrame:WithAllFrames(function (f) f:SetRaidIconSize(v) end)
				end
		},
		["Raid Icon Opacity"] = {
			type = "range",
			name = L["Raid Icon Opacity"],
			desc = L["Raid Icon Opacity"],
			max = 100,
			min = 10,
			step = 5,
			order = 55,
			get = function()
					return GridRaidIconFrame.db.profile.alpha * 100
				end,
			set = function(v)
				GridRaidIconFrame.db.profile.alpha = v/100
				GridFrame:WithAllFrames(function (f) f:SetIconAlpha(v/100) end)
				end
		},
		
		["Back Ground Opacity"] = {
			type = "range",
			name = L["Back Ground Opacity"],
			desc = L["Back Ground Opacity"],
			max = 90,
			min = 10,
			step = 5,
			order = 60,
			get = function()
					return GridRaidIconFrame.db.profile.bgalpha * 100
				end,
			set = function(v)
					GridRaidIconFrame.db.profile.bgalpha = v/100
					GridStatusRaidIcons:UpdateAllUnits()
				end
		},
		["Highlight RaidIcon"] = {
			type = "toggle",
			name = L["Highlight RaidIcon"],
			desc = L["Highlight RaidIcon"],
			order = 100,
			get = function()
					return GridStatusRaidIcons.db.profile.alert_raidicons_player.highlight
				end,
			set = function()
					GridStatusRaidIcons.db.profile.alert_raidicons_player.highlight = not GridStatusRaidIcons.db.profile.alert_raidicons_player.highlight
					if statusmap["frameAlpha"] then
						statusmap["frameAlpha"].alert_raidicons_player = GridStatusRaidIcons.db.profile.alert_raidicons_player.highlight
					end
	
					GridStatusRaidIcons:UpdateAllUnits()
				end
		
		},

		["color"] = false,
		["range"]= false,
	}
	for i = 1, #icontextcolor do
		menu_player["raidicon"..i.."_player_toggle"] = {
			type = "toggle",
			name = "|cff"..icontextcolor[i].hex..icontextcolor[i].text.."|r",
			desc = icontextcolor[i].text..".",
			order = 102+i/10,
			get = function()
				return GridStatusRaidIcons.db.profile.raidicon_player[i]
			end,
			set = function()
				GridStatusRaidIcons.db.profile.raidicon_player[i] = not GridStatusRaidIcons.db.profile.raidicon_player[i]
				GridStatusRaidIcons:UpdateAllUnits()
			end
		}
	end
	self:RegisterStatus("alert_raidicons_player", LOC_PLAYER, menu_player, true)
end

function GridStatusRaidIcons:OnStatusEnable(status)
	if status == "alert_raidicons_player" then
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAllUnits")
		self:RegisterEvent("RAID_ROSTER_UPDATE","UpdateAllUnits")
		self:ScheduleEvent(self.UpdateAllUnits,2,self)
	end
end

function GridStatusRaidIcons:OnStatusDisable(status)
	if not self.db.profile.alert_raidicons_player.enable then
		self:UnregisterEvent("RAID_TARGET_UPDATE")
	end
	if status == "alert_raidicons_player" then
		self.core:SendStatusLostAllUnits("alert_raidicons_player")
	end
end

function GridStatusRaidIcons:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusRaidIcons:UpdateAllUnits()
	local settings = self.db.profile.alert_raidicons_player
	local frameSettings = GridRaidIconFrame.db.profile
	local hasMark = false
	for guid, unitid in GridRoster:IterateRoster() do
		
		local raidicon = GetRaidTargetIndex(unitid)
		 if settings.enable then
			if raidicon and GridStatusRaidIcons.db.profile.raidicon_player[raidicon] then
				hasMark = true
				self.core:SendStatusGained(guid, "alert_raidicons_player",
					settings.priority,
					(settings.range and 40),
					{r=1,g=1,b=1,a=frameSettings.alpha},
					nil,
					nil,
					nil,
					"Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidicon)
			else
				self.core:SendStatusGained(guid, "alert_raidicons_player",
					settings.priority,
					(settings.range and 40),
					{r=1,g=1,b=1,a=frameSettings.bgalpha})
			end
		end
	end
	if not hasMark then
		self.core:SendStatusLostAllUnits("alert_raidicons_player")
	end	
end

function GridStatus_OpenRaidPanel()
	waterfall:Open("Grid") 
	waterfall:Open("Grid","GridStatus")
	waterfall:Open("Grid","GridStatus.alert_raidicons_player")
end