local L = LibStub("AceLocale-3.0"):NewLocale("BFGadgets", "enUS",true)
if not L then return end

L["Node %d"] = true
L["Map Note"] = true
L["%s has been set, the coordinate is (%d, %d)."] = true
L["Coord Window"] = true
L["Left click to move window.\nShift + Left click to set a mark.\nShift + Right click to reset position."] = true

L["System Volume Control"] = true

if GetLocale()=='enUS' then
	BFVOLUME_GAMETOOLTIP = "Provide System Volume Control"
end