local L = AceLibrary("AceLocale-2.2"):new("GridManaBars")
local AceOO = AceLibrary("AceOO-2.0")

local SML = LibStub("LibSharedMedia-3.0", true)

--[[
local mbDB = AceLibrary("AceAddon-2.0"):new("AceDB-2.0")
mbDB:RegisterDB("ManaBarDB", "ManaBarDBPC")
mbDB:RegisterDefaults("profile", {
    size = 0.3,
    side = "Right",
} )
]]

GridMBFrame = Grid:NewModule("GridMBFrame")
GridMBFrame.defaultDB = {
    size = 0.3,
    side = "Right",
}

local indicators = GridFrame.frameClass.prototype.indicators
table.insert(indicators, { type = "manabar",    order = 15,  name = L["Mana Bar"] })

local statusmap = GridFrame.db.profile.statusmap
if ( not statusmap["manabar"] ) then
	statusmap["manabar"] = { unit_mana = true }
end

local mb_options = {
    type = "group",
    name = L["Mana Bar"],
    desc = L["Mana Bar options."],
    args = {
        ["Manabar size"] = {
            type = "range",
            name = L["Size"],
            desc = L["Percentage of frame for mana bar"],
            max = 90,
            min = 10,
            step = 5,
            get = function ()
                return GridMBFrame.db.profile.size * 100
                end,
            set = function(v)
                GridMBFrame.db.profile.size = v / 100
                GridFrame:ResizeAllFrames()
                GridFrame:ScheduleEvent("GridFrame_UpdateLayoutSize", "Grid_ReloadLayout", 0.5)
            end
        },
        ["Manabar side"] = {
            type = "text",
            name = L["Side"],
            desc = L["Side of frame manabar attaches to"],
            get = function ()
                return GridMBFrame.db.profile.side
                end,
            set = function(v)
                GridMBFrame.db.profile.side = v
                GridFrame:WithAllFrames(function (f) f:ReAnchor(v) end)
            end,
            validate={["Left"] = L["Left"], ["Top"] = L["Top"], ["Right"] = L["Right"], ["Bottom"] = L["Bottom"] },
        },
    }
}

GridFrame.options.args["advanced"].args["manabar"] = mb_options
    
-- hooking stuff, taken from GridSideIndicators

local ManaBarGridFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = nil
if ( not _frameClass ) then
	_frameClass = GridFrame.frameClass
	GridFrame.frameClass = ManaBarGridFrameClass
end

function ManaBarGridFrameClass.prototype:Reset()
	ManaBarGridFrameClass.super.prototype.Reset(self)
	self:ReAnchor(GridMBFrame.db.profile.side)
    --GridFrame:WithAllFrames(function (f) f:ReAnchor(GridMBFrame.db.profile.side) end)
end


function ManaBarGridFrameClass.prototype:SetManaBarColor(col)	
	if GridFrame.db.profile.invertBarColor2 then
--DEFAULT_CHAT_FRAME:AddMessage("using inverted colours")
		self.frame.ManaBar:SetStatusBarColor(col.r,col.g,col.b,col.a)
		self.frame.BarMBG:SetVertexColor(0,0,0,0.8)
	else
--DEFAULT_CHAT_FRAME:AddMessage("using noninverted colours")
		self.frame.ManaBar:SetStatusBarColor(0,0,0,0.8)
		self.frame.BarMBG:SetVertexColor(col.r,col.g,col.b,col.a)
	end
end

function ManaBarGridFrameClass.prototype:InvertBarColor()
	ManaBarGridFrameClass.super.prototype.InvertBarColor(self)
--DEFAULT_CHAT_FRAME:AddMessage("FC:InvertBarColor("..self.unitName..")")
	if self.frame.ManaBar then
        local col = {}
        if GridFrame.db.profile.invertBarColor2 then
            col.r, col.g, col.b, col.a = self.frame.BarMBG:GetVertexColor()
        else
            col.r, col.g, col.b, col.a = self.frame.ManaBar:GetStatusBarColor()
        end
		self:SetManaBarColor(col)
	end
end

function ManaBarGridFrameClass.prototype:SetFrameTexture(texture)
	ManaBarGridFrameClass.super.prototype.SetFrameTexture(self, texture)

	if not self.frame.ManaBar then return end

	self.frame.ManaBar:SetStatusBarTexture(texture)
    self.frame.BarMBG:SetTexture(texture)
end

function ManaBarGridFrameClass.prototype:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack)
	ManaBarGridFrameClass.super.prototype.SetIndicator(self, indicator, color, text, value, maxValue, texture, start, duration, stack)
    if not self.frame.ManaBar then return end
	if indicator == "manabar" then
		--DEFAULT_CHAT_FRAME:AddMessage("SI(2 "..type(color)..")")
        if self.frame.hideMB then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(3)")
            self:HideManaBar(false)
        end
        if value and maxValue then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(4)")
            if maxValue <= 0 or value < 0 or value > maxValue then
                maxValue = 100
                value = 0
            end
            self.frame.ManaBar:SetValue(value/maxValue*100)
		end
        if type(color) == "table" then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(5)")
			self:SetManaBarColor(color)
        end
	end
end

function ManaBarGridFrameClass.prototype:ClearIndicator(indicator)
    ManaBarGridFrameClass.super.prototype.ClearIndicator(self,indicator)
    
    if not self.frame.ManaBar then return end
    
    if (not self.frame.hideMB) and indicator == "manabar" then
        self:HideManaBar(true)
    end
end

function ManaBarGridFrameClass.prototype:SetBorderSize(borderSize)
    ManaBarGridFrameClass.super.prototype.SetBorderSize(self, borderSize)
    self:ReAnchor(GridMBFrame.db.profile.side)
end

function ManaBarGridFrameClass.prototype:SetManaBarWidth(width)
	if not self.frame.ManaBar then return end

	if self.frame.hideMB==true then return end
--    DEFAULT_CHAT_FRAME:AddMessage("FC:SetWidth("..width..")")

	local f=self.frame;
	local side = GridMBFrame.db.profile.side

	if side == "Left" or side == "Right" then
		local MBSize = GridMBFrame.db.profile.size
        f.BarBG:SetWidth(width * (1 - MBSize))
	end
end


function ManaBarGridFrameClass.prototype:SetWidth(width)
	ManaBarGridFrameClass.super.prototype.SetWidth(self, width)
	self:SetManaBarWidth(width - (GridFrame.db.profile.borderSize+1)*2)
end

function ManaBarGridFrameClass.prototype:SetManaBarHeight(height)
	if not self.frame.ManaBar then return end
    
	if self.frame.hideMB==true then return end
--    DEFAULT_CHAT_FRAME:AddMessage("FC:SetHeight("..height..")")

	local f=self.frame;
	local side = GridMBFrame.db.profile.side

	if side == "Bottom" or side == "Top" then
        local MBSize = GridMBFrame.db.profile.size
        f.BarBG:SetHeight(height * (1 - MBSize))
	end
end

function ManaBarGridFrameClass.prototype:SetHeight(height)
	ManaBarGridFrameClass.super.prototype.SetHeight(self, height)
	self:SetManaBarHeight(height - (GridFrame.db.profile.borderSize+1)*2)
end

function ManaBarGridFrameClass.prototype:CreateFrames()
	ManaBarGridFrameClass.super.prototype.CreateFrames(self)
	
    local f = self.frame
    local texture = SML and SML:Fetch("statusbar", GridFrame.db.profile.texture) or "Interface\\Addons\\Grid\\gradient32x32"
    f.BarMBG = f:CreateTexture()
    f.BarMBG:SetTexture(texture)

    f.ManaBar = CreateFrame("StatusBar", nil, f)
    f.ManaBar:SetStatusBarTexture(texture)
    f.ManaBar:SetMinMaxValues(0,100)
    f.ManaBar:SetValue(100)
    f.ManaBar:SetPoint("TOPLEFT", f.BarMBG, "TOPLEFT")
    f.ManaBar:SetPoint("BOTTOMRIGHT", f.BarMBG, "BOTTOMRIGHT")

    self:ReAnchor(GridMBFrame.db.profile.side)
    self:HideManaBar(true)
end

function ManaBarGridFrameClass.prototype:HideManaBar(v)
    local f = self.frame
    
    if not f.ManaBar then return end    

--    DEFAULT_CHAT_FRAME:AddMessage("FC:HideManaBar("..tostring(v)..")")
    f.hideMB = v

    if v then
        local side = GridMBFrame.db.profile.side
        if side == "Left" or side == "Right" then
            local width = GridFrame:GetFrameWidth() 
            f.BarBG:SetWidth(width - (GridFrame.db.profile.borderSize+1)*2) --resize health bar to whole frame size
        else
            local height = GridFrame:GetFrameHeight() 
            f.BarBG:SetHeight(height - (GridFrame.db.profile.borderSize+1)*2) --resize health bar to whole frame size
        end
        f.ManaBar:Hide()
        f.BarMBG:Hide()
    else
        f.ManaBar:Show()
        f.BarMBG:Show()
        self:SetManaBarHeight(GridFrame:GetFrameHeight()  - (GridFrame.db.profile.borderSize+1)*2)
        self:SetManaBarWidth(GridFrame:GetFrameWidth()  - (GridFrame.db.profile.borderSize+1)*2)
    end

end

function ManaBarGridFrameClass.prototype:ReAnchor(side)

	local f = self.frame
	if not f.ManaBar then return end
 --   DEFAULT_CHAT_FRAME:AddMessage("FC:ReAnchor("..side..")")

	f.BarBG:ClearAllPoints()
	f.BarMBG:ClearAllPoints()
    
    local b = GridFrame.db.profile.borderSize+1

	if side == "Right" then
		f.BarBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarMBG:SetPoint("TOPRIGHT", f, "TOPRIGHT",-b,-b)
        f.BarMBG:SetPoint("BOTTOMLEFT", f.BarBG, "BOTTOMRIGHT")
		f.ManaBar:SetOrientation("VERTICAL")
	elseif side == "Left" then
		f.BarMBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarBG:SetPoint("TOPRIGHT", f, "TOPRIGHT",-b,-b)
        f.BarMBG:SetPoint("BOTTOMRIGHT", f.BarBG, "BOTTOMLEFT")
		f.ManaBar:SetOrientation("VERTICAL")
	elseif side == "Bottom" then
		f.BarBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarMBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT",b,b)
        f.BarMBG:SetPoint("TOPRIGHT", f.BarBG, "BOTTOMRIGHT")
		f.ManaBar:SetOrientation("HORIZONTAL")
	else
		f.BarMBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT",b,b)
        f.BarMBG:SetPoint("BOTTOMRIGHT", f.BarBG, "TOPRIGHT")
		f.ManaBar:SetOrientation("HORIZONTAL")
	end

	self:SetWidth(GridFrame:GetFrameWidth() )     --tell the frame to update its childs width
	self:SetHeight(GridFrame:GetFrameHeight() )   --and height
end




