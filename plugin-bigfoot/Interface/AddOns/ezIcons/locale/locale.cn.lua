local L = LibStub("AceLocale-3.0"):NewLocale("ezIcons", "zhCN",true)
if not L then return end
L["ezIcons"] = "团队标记"
L["Radial"] = "环形菜单"
L["Mouseover"] = "鼠标指向快速标记"
L["Massicon"] = "集群标记"
L["Set Icon"] = "设置图标"
L["Remove Icon"] = "移除图标"
L["Reset Icons"] = "重置图标"
L["Enable/Disable the radial target icon menu"] = "启用/关闭环状图标菜单"
L["Enable/Disable mouseover set icon keybindings"] = "启用/关闭快速标记鼠标指向热键"
L["Enable/Disable mass mouseover set icon modifier keys"] = "启用/关闭鼠标指向集群目标快速标记热键"


if GetLocale()=="zhCN" then
	BINDING_HEADER_EZICONS= "团队标记"
	BINDING_NAME_EZICONS_SETICON = "设置标记"
	BINDING_NAME_EZICONS_REMOVEICON = "删除标记"
	BINDING_NAME_EZICONS_RESETICONS= "重置标记"
end