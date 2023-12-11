if ( GetLocale() == "zhCN" ) then
_G["BINDING_HEADER_TOTEMTIMERSHEADER"] = "TotemTimers"
_G["BINDING_NAME_TOTEMTIMERSAIR"] = "Cast active air totem"
_G["BINDING_NAME_TOTEMTIMERSAIRMENU"] = "Open air totem menu"
_G["BINDING_NAME_TOTEMTIMERSEARTH"] = "Cast active earth totem"
_G["BINDING_NAME_TOTEMTIMERSEARTHMENU"] = "Open earth totem menu"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDLEFT"] = "Earth Shield Leftclick"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDMIDDLE"] = "Earth Shield Middleclick"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDRIGHT"] = "Earth Shield Rightclick"
_G["BINDING_NAME_TOTEMTIMERSFIRE"] = "Cast active fire totem"
_G["BINDING_NAME_TOTEMTIMERSFIREMENU"] = "Open fire totem menu"
_G["BINDING_NAME_TOTEMTIMERSWATER"] = "Cast active water totem"
_G["BINDING_NAME_TOTEMTIMERSWATERMENU"] = "Open water totem menu"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF1"] = "Weapon Buff 1"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF2"] = "Weapon Buff 2"

end


local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers", "zhCN")
if not L then return end

L["Air Button"] = "Air Button" -- Requires localization
L["Ctrl-Leftclick to remove weapon buffs"] = "Ctrl-左键点击 移除武器Buff"
L["Delete Set"] = "Delete Totem Set %u?" -- Requires localization
L["Earth Button"] = "Earth Button" -- Requires localization
L["Fire Button"] = "Fire Button" -- Requires localization
L["Leftclick to cast %s"] = "左键点击施放 %s"
L["Leftclick to cast spell"] = "左键点击施放法术"
L["Leftclick to load totem set to %s"] = "Leftclick to load totem set to %s" -- Requires localization
L["Leftclick to open totem set menu"] = "Leftclick to open totem set menu" -- Requires localization
L["Maelstrom Notifier"] = "漩涡武器就绪！"
L["Middleclick to cast %s"] = "中键点击施放 %s"
L["Next leftclick casts %s"] = "下一个左键点击施放 %s"
L["Rightclick to assign both %s and %s to leftclick"] = "右键点击指定 %s 和 %s 都到左键点击"
L["Rightclick to assign spell to leftclick"] = "右键点击指定法术到左键点击"
L["Rightclick to assign totem"] = "右键点击将此法术绑定到当前方案中"
L["Rightclick to cast %s"] = "右键点击施放 %s"
L["Rightclick to delete totem set"] = "Rightclick to delete totem set" -- Requires localization
L["Rightclick to save active totem configuration as set"] = "Rightclick to save active totem configuration as set" -- Requires localization
L["Rightclick to set %s as active multicast spell"] = "右键点击设置 %s 为常用方案设置" -- Requires localization
L["Shield removed"] = "%s效果消失。"
L["Shift-Rightclick to assign spell to middleclick"] = "Shift-中键点击 指定法术到鼠标中键点击"
L["Shift-Rightclick to assign spell to rightclick"] = "Shift-右键点击 指定法术到右键点击"
L["Totem Destroyed"] = "%s被摧毁了。"
L["Totem Expired"] = "s到期了。"
L["Totem Expiring"] = "s即将到期。"
L["Water Button"] = "Water Button" -- Requires localization
