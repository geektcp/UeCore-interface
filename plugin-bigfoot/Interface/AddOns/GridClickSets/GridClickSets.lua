local AceOO = AceLibrary("AceOO-2.0")
local Dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")

local GrameFrameClass = AceOO.Class(GridFrame.frameClass)

local _frameClass = GridFrame.frameClass
GridFrame.frameClass = GrameFrameClass

function GrameFrameClass.prototype:CreateFrames()
    GrameFrameClass.super.prototype.CreateFrames(self)

    local f = self.frame
    GridClickSets_SetAttributes(f, GridClickSets.db.profile.set);
end

GridClickSets = Grid:NewModule("GridClickSets")

GridClickSets.defaultDB = {
	set = GridClickSets_GetDefault()
}

GridFrame.options.args["GridClickSets"] = { --GridClickSets.options = {
	type = "execute",
	name = GRIDCLICKSETS_MENUNAME,
	desc = GRIDCLICKSETS_MENUTIP,
	order = 1,
	func = function()
		GridClickSetsFrame:Show()
		if(Dewdrop) then Dewdrop:Close() end
		if waterfall and waterfall:IsOpen("Grid") then waterfall:Close("Grid") end
	end
}

function GridClickSets:OnEnable()
	if GridClickSets.db.profile.set then
		GridClickSets_Set = GridClickSets.db.profile.set
	end
end

function GridClickSets:Reset()
	self.super.Reset(self)
	GridClickSets_Set = GridClickSets.db.profile.set
	GridClickSetsFrame_UpdateGridFrame()
end