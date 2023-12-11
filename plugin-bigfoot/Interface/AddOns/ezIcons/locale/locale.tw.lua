local L = LibStub("AceLocale-3.0"):NewLocale("ezIcons", "zhTW",true)
if not L then return end
L["ezIcons"] = "團隊標記"
L["Radial"] = "環形菜單"
L["Mouseover"] = "鼠標指向快速標記"
L["Massicon"] = "集群標記"
L["Set Icon"] = "設置圖標"
L["Remove Icon"] = "移除圖標"
L["Reset Icons"] = "重置圖標"
L["Enable/Disable the radial target icon menu"] = "啟用/關閉環狀圖標菜單"
L["Enable/Disable mouseover set icon keybindings"] = "啟用/關閉快速標記鼠標指向熱鍵"
L["Enable/Disable mass mouseover set icon modifier keys"] = "啟用/關閉鼠標指向集群目標快速標記熱鍵"


if GetLocale()=="zhCN" then
	BINDING_HEADER_EZICONS= "團隊標記"
	BINDING_NAME_EZICONS_SETICON = "設置標記"
	BINDING_NAME_EZICONS_REMOVEICON = "刪除標記"
	BINDING_NAME_EZICONS_RESETICONS= "重置標記"
end
