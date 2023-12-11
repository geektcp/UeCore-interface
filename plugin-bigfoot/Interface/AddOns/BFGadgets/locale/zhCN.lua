local L = LibStub("AceLocale-3.0"):NewLocale("BFGadgets", "zhCN")
if not L then return end

L["Node %d"] = "节点 %d"
L["Map Note"] = "地图标记"
L["%s has been set, the coordinate is (%d, %d)."] = "%s已经被设置，坐标为：(%d, %d)。"
L["Coord Window"] = "坐标显示器"
L["Left click to move window.\nShift + Left click to set a mark.\nShift + Right click to reset position."] = "左键点击拖动窗口。\nShift+左键点击设置地图坐标。\nShift+右键点击重置窗口位置。"

L["System Volume Control"] = "系统声音设置"
if GetLocale()=='zhCN' then
	BFVOLUME_GAMETOOLTIP = "提供系统声音设置"
end