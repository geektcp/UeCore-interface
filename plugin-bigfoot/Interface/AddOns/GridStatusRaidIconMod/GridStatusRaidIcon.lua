-- create a new indicator
--modify existing indicator frameAlpha
--modify statusmap
--register frame option
local AceOO = AceLibrary("AceOO-2.0")

local GridRaidIconFrame = Grid:NewModule("GridRaidIconFrame")
GridRaidIconFrame.defaultDB = {
	alpha =0.9,
	size = 22,
	bgalpha = 0.2
}
local GridFrame = Grid:GetModule("GridFrame")

local L = GridStatusRaidIcons_Locales

local indicators = GridFrame.frameClass.prototype.indicators
table.insert(indicators, { type = "raidicon", order = 16, name = L["Raid Icon"]})

local statusmap = GridFrame.db.profile.statusmap
if (not statusmap["raidicon"] ) then
	statusmap["raidicon"] = {alert_raidicons_player = true}
end

local RaidIconGridFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if ( not _frameClass ) then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = RaidIconGridFrameClass
end
function RaidIconGridFrameClass.prototype:Reset()
	RaidIconGridFrameClass.super.prototype.Reset(self)
	self:SetRaidIconSize(GridRaidIconFrame.db.profile.size)
end

function RaidIconGridFrameClass.prototype:SetRaidIconSize(size)
	local f = self.frame
	 if not self.frame.RaidIcon then return end
	f.RaidIcon:SetWidth(size)
	f.RaidIcon:SetHeight(size)
end

function RaidIconGridFrameClass.prototype:SetIconAlpha(alpha)
	local f = self.frame
	 if not f.RaidIcon then return end
	f.RaidIcon:SetAlpha(alpha)
end

function RaidIconGridFrameClass.prototype:SetFrameTexture(texture)
	RaidIconGridFrameClass.super.prototype.SetFrameTexture(self, texture)

	if not self.frame.RaidIcon then return end

	self.frame.RaidIcon:SetTexture(texture)
end

function RaidIconGridFrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack)

	RaidIconGridFrameClass.super.prototype.SetIndicator(self, indicator, color, text, value, maxValue, texture, start, duration, stack)
	if not self.frame.RaidIcon then return end
	if indicator == "raidicon" then
		if self.frame.hideRI then
			self:HideRaidIcon(false)
		end
		if texture then
			--show the texture frame
			self.frame.RaidIcon:SetTexture(texture)
			self:SetIconAlpha(color.a)
			self:HideRaidIcon(false)


		else
			self:HideRaidIcon(true)
		end
		-- fade out frame
	end
end

function RaidIconGridFrameClass.prototype:ClearIndicator(indicator)
    RaidIconGridFrameClass.super.prototype.ClearIndicator(self,indicator)
    
    if not self.frame.RaidIcon then return end
    
    if (not self.frame.hideRI) and indicator == "raidicon" then
        self:HideRaidIcon(true)
    end
end

function RaidIconGridFrameClass.prototype:CreateFrames()
	RaidIconGridFrameClass.super.prototype.CreateFrames(self)
	
    local f = self.frame
    f.RaidIconBG = CreateFrame("Frame",nil,f)
  	f.RaidIconBG:SetWidth(GridRaidIconFrame.db.profile.size)
	f.RaidIconBG:SetHeight(GridRaidIconFrame.db.profile.size)
	f.RaidIconBG:SetPoint("CENTER", f, "CENTER")
	
	f.RaidIconBG:SetFrameLevel(6)
	
	f.RaidIcon = f.RaidIconBG:CreateTexture("Icon", "OVERLAY")
	f.RaidIcon:SetPoint("CENTER", f.RaidIconBG, "CENTER")
	f.RaidIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	f.RaidIcon:SetTexture(1,1,1,0)		
	self:SetRaidIconSize(GridRaidIconFrame.db.profile.size)
	self:HideRaidIcon(true)
	self:Reset()

end

function RaidIconGridFrameClass.prototype:HideRaidIcon(v)
	local f = self.frame
    if not f.RaidIcon then return end    
	f.hideRI = v
	if v then
		f.RaidIconBG:Hide()
		f.RaidIcon:Hide()
	else
		f.RaidIconBG:Show()
		f.RaidIcon:Show()
	end
end