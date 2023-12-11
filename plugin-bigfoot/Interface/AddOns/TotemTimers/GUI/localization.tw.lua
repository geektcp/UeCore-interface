-- Translated by a9012456

local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers_GUI", "zhTW")
if not L then return end

L["Air"] = "風之"
L["Automatic"] = "自動"
L["Bottom"] = "置底"
L["Cast Button 1"] = "施法按鈕1"
L["Cast Button 2"] = "施法按鈕2"
L["Down"] = "下"
L["Earth"] = "大地"
L["Enable"] = "啟用"
L["Fire"] = "火焰"
L["Left"] = "左"
L["none"] = "無"
L["Right"] = "右"
L["Top"] = "置頂"
L["Totems"] = "圖騰"
L["TotemTimers"] = true
L["Up"] = "上"
L["Version"] = "版本"
L["vertical"] = "豎直方向"
L["Water"] = "水之"

L["Blizz Style"] = "內建格式"
L["Displays timer bars underneath times"] = "顯示計時條在時間下方"
L["General"] = "一般"
L["Hide Blizzard Timers"] = "隱藏內建計時"
L["Hide Default Totem Bar"] = "隱藏預設圖騰條"
L["Hide Default Totem Bar Desc"] = "If you uncheck this you should reload your interface." -- Requires localization
L["Hide In Vehicles"] = "騎乘時隱藏"
L["Hide In Vehicles Desc"] = "騎乘時隱藏TotemTimers。騎乘時不要改變設定"
L["Lock"] = "鎖定"
L["Locks the position of TotemTimers"] = "鎖定TotemTimers位置"
L["Red Flash Color"] = "紅光閃爍"
L["RedFlash Desc"] = "如果啟用到期時間紅光閃爍，否則淡入或淡出。"
L["Shows tooltips on timer and totem buttons"] = "在計時跟圖騰按鈕上顯示提示"
L["Show Timer Bars"] = "顯示計時條"
L["Show Tooltips"] = "顯示提示"
L["Stop Pulse"] = "Stop Pulse" -- Requires localization
L["Stop Pulse Desc"] = " \"If a timer stops its icon gives a big visible pulse\"" -- Requires localization
L["Time Font"] = "計時字型"
L["Timers On Buttons"] = "按鈕上的計時"

L["Advanced Options"] = "進階設定"
L["Arrangement"] = "排列方式"
L["box"] = "方格排列"
L["Button Size"] = "按鈕大小"
L["Enable Pulse Bar"] = "啟用脈動條"
L["horizontal"] = "水平方向"
L["loose"] = "自由排列"
L["Mini Icons Desc"] = "在標示圖騰分配的計時按鈕右下顯示小圖示來啟動多施法法術和計時按鈕將會施放。"
L["Open On Rightclick"] = "右鍵點擊開啟"
L["Player Range"] = "玩家範圍"
L["Player Range Desc"] = "如果玩家超出範圍在圖騰計時上顯示紅點"
L["Pulse desc"] = "在計時裡面顯示綠色狀態條直到充滿圖騰脈動。"
L["Raid Member Range"] = "團隊成員範圍"
L["Raid Range Tooltip"] = "團隊距離提示"
L["Range Desc"] = "在左下角顯示有多少團隊成員沒有獲得你的圖騰增益"
L["Rightclick Desc"] = "右鍵開啟圖騰選單而不是經過計時按鈕。 用滑鼠中鍵按鈕可以圖騰解散而不是右鍵點擊。"
L["RR Tooltip Desc"] = "滑鼠經過時顯示團隊成員清單沒有在你圖騰範圍內"
L["Scales the timer buttons"] = "縮放圖騰按鈕"
L["Scaling"] = "縮放"
L["Sets the font size of time strings"] = "設定計時字串的字型大小"
L["Sets the format in which times are displayed"] = "設定計時顯示格式"
L["Sets the space between timer buttons"] = "設定計時按鈕之間的間隔"
L["Sets the space between timer buttons and timer bars"] = "設定計時按鈕跟計時條之間的間隔"
L["Sets the width of timer bars."] = "設定計時條的寬度"
L["Show Mini Icons"] = "顯示小圖示"
L["Show Totem Cooldowns"] = "顯示圖騰冷卻"
L["Spacing"] = "間隔"
L["Timer Bar Position"] = "計時條位置"
L["Timer Bar Position Desc"] = "設定在哪一方的圖示計時器顯示的時間"
L["Time Size"] = "計時大小"

L["Ankh Tracker"] = "復生追蹤"
L["Ankh Tracker Desc"] = "顯示你復生能力剩餘冷卻時間以及在你背包的復生數目。也被用來儲存或是載入圖騰設定。"
L["Button 4"] = "按鈕4"
L["EarthShieldDesc"] = "顯示大地之盾剩餘時間和次數。 可用於投大地之盾。"
L["Earth Shield Tracker"] = "大地之盾追蹤"
L["esrecast"] = "改寫 (最後目標/團隊圖騰)"
L["Leftclick"] = "左鍵點擊"
L["Middle Button"] = "中鍵按鈕"
L["Rightclick"] = "右鍵點擊"
L["Shield Tracker"] = "盾追蹤"
L["Trackers"] = "追蹤"
L["Weapon Buff Tracker"] = "武器增益追蹤"
L["WeaponDesc"] = "顯示武器剩餘增益時間。左鍵點擊施放選擇的武器增益，右鍵點擊開啟選單選擇增益。一個圖示顯示兩個增益，第一個左鍵點擊施放左邊增益和第二個左鍵點擊右邊增益。"

L["Color"] = "Color" -- Requires localization
L["disabled warnings desc"] = "即使追蹤禁用，到期增益警告還是會顯示"
L["EarthShield warnings"] = "大地之盾警告"
L["Maelstrom notification"] = "氣漩通知"
L["Messages"] = "訊息"
L["Shield expiration warnings"] = "盾到期警告"
L["Show warnings of disabled trackers"] = "禁用追蹤顯示警告"
L["Sound"] = "Sound" -- Requires localization
L["Totem Desctruction Desc"] = "警告如果圖騰在到期前被銷毀。"
L["Totem Destruction Message"] = "圖騰銷毀訊息"
L["Totem Expiration Desc"] = "圖騰到期之後警告。"
L["Totem Expiration Message"] = "圖騰到期訊息"
L["Totem Expiration Warning"] = "圖騰到期警告"
L["Totem Warning Desc"] = "在圖騰10秒到期前警告。"
L["Warnings"] = "Warnings" -- Requires localization
L["Weapon buff warnings"] = "武器增益警告"

L["Menu Direction"] = "選單方向"
L["Multicast Button"] = "圖騰組按鈕"
L["Same as totem menus"] = "跟圖騰選單相同"

L["Duration"] = "Duration" -- Requires localization
L["ECD Button Size"] = "增強冷卻按鈕大小"
L["ECD Font Size"] = "增強冷卻字型大小"
L["EnhanceCDs"] = "增強冷卻設定"
L["Hide OOC Desc"] = "改變這個設定下一次戰鬥才會生效"
L["Hide out of combat"] = "離開戰鬥隱藏"
L["Maelstrom Bar Height"] = "氣漩條高度"
L["OOC Alpha"] = "離開戰鬥透明度"
L["OOC Alpha Desc"] = "離開戰鬥控制不透明的按鈕，0 = 透明, 1 = 不透明"
L["Show OmniCC counters"] = "顯示OmniCC計數"



if (GetLocale() == "zhTW") then

TT_GUI_ROLE_NAMES = {
    [0]="uninspected",
    [1]="melee",
    [2]="ranged",
    [3]="caster",
    [4]="healer",
    [5]="enhancer"
}

end