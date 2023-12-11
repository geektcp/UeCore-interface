assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 633 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOPlayerTarget")
local media = LibStub("LibSharedMedia-3.0")

local combatUpdate = nil

local classColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	classColors[k] = {v.r, v.g, v.b}
end

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Player"] = true,
	["PlayerTarget"] = true,
	["Optional/PlayerTarget"] = true,
	["Options for the playertargets."] = true,
	["Targettarget"] = true,
	["Toggle TargetTarget frames."] = true,
	["Scale"] = true,
	["Set frame scale."] = true,
	["Alpha"] = true,
	["Set frame alpha."] = true,
	["Raidicon"] = true,
	["Toggle raid icons."] = true,
	["Frames"] = true,
	["Options for the playertarget frames."] = true,
	["Growup"] = true,
	["Toggle growup."] = true,
	["Inverse"] = true,
	["Toggle inverse healthbar."] = true,
	["Deficit"] = true,
	["Toggle deficit health."] = true,
	["Target"] = true,
	["TargetTarget"] = true,
	["Set the maximum number of player tanks you want to show."] = true,
	["Amount"] = true,
	["Classcolor"] = true,
	["Color healthbars by class."] = true,
	["Enemycolor"] = true,
	["Set the color for enemies. (used when classcolor is enabled)"] = true,
	["Color Aggro"] = true,
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = true,
	["Backdrop"] = true,
	["Toggle the backdrop."] = true,
	["Highlight"] = true,
	["Toggle highlighting your target."] = true,
	["Reverse"] = true,
	["Toggle reverse order."] = true,
	["Numbers"] = true,
	["Toggle showing of PT numbers."] = true,
	["Tooltips"] = true,
	["Toggle showing of tooltips."] = true,
	["Show"] = true,
	["Show player."] = true,
	["Show target."] = true,
	["Show targettarget."] = true,
	["Define which frames you want to see."] = true,
	["Layout"] = true,
	["Set the layout for the PT frames."] = true,
	["Vertical"] = true,
	["Horizontal"] = true,

	["Set"] = true,
	["Set a player."]= true,
	["<nr> <name>"] = true,
	["<nr>"] = true,
	["<name>"] = true,
	["Remove"] = true,
	["Remove a player."] = true,
	["Removed player: "] = true,
	["Set player: "] = true,

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear player targets."] = true,
	["Press |cffffffff%s|r to set the next player tank or |cffffffff%s|r to clear the last tank set."] = true,
	["<no binding>"] = true,

	["(%S+)%s*(.*)"] = true,

	["<Not Assigned>"] = true,

	["Style"] = true,
	["Set the frame style."] = true,
	["<style>"] = true,

	["Default"] = true,
	["Compact"] = true,

	["Backwards"] = true,
	["Order PT|PTT|PTTT Backwards."] = true,

	["Lock"] = true,
	["Lock the PT frames."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Player"] = "플레이어",
	["PlayerTarget"] = "플레이어대상",
	["Optional/PlayerTarget"] = "부가/플레이어대상",
	["Options for the playertargets."] = "플레이어 대상에 대한 설정입니다.",
	["Targettarget"] = "대상의대상",
	["Toggle TargetTarget frames."] = "대상의 대상창 표시를 선택합니다.",
	["Scale"] = "크기",
	["Set frame scale."] = "창의 크기를 설정합니다.",
	["Alpha"] = "투명도",
	["Set frame alpha."] = "창의 투명도를 설정합니다.",
	["Raidicon"] = "전술 표시",
	["Toggle raid icons."] = "전술 표시를 선택합니다.",
	["Frames"] = "창",
	["Options for the playertarget frames."] = "플레이어 대상창에 대한 성정입니다.",
	["Growup"] = "방향",
	["Toggle growup."] = "창의 진행 방향을 선택합니다.",
	["Inverse"] = "반전",
	["Toggle inverse healthbar."] = "생명력바 반전을 선택합니다.",
	["Deficit"] = "결손치",
	["Toggle deficit health."] = "생명력바 결손치 표시를 선택합니다.",
	["Target"] = "대상",
	["TargetTarget"] = "대상의대상",
	["Set the maximum number of player tanks you want to show."] = "플레이어의 번호를 표시합니다.",
	["Amount"] = "플레이어의 수",
	["Classcolor"] = "직업별색상",
	["Color healthbars by class."] = "직업별로 생명력바의 색상을 변경합니다.",
	["Enemycolor"] = "적색상",
	["Set the color for enemies. (used when classcolor is enabled)"] = "적의 경우의 색상을 설정합니다. (직업별색상 기능을 사용할 때)",
	["Color Aggro"] = "어그로 색상",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "현재 상태에 따라서 플레이어 탱커를 위한 어그로 색상을 표시힙니다. 오렌지는 대상, 녹색은 탱커, 적색은 어그로 없읍니다.",
	["Backdrop"] = "배경",
	["Toggle the backdrop."] = "배경 표시를 선택합니다.",
	["Highlight"] = "강조",
	["Toggle highlighting your target."] = "대상 강조를 선택합니다.",
	["Reverse"] = "반전",
	["Toggle reverse order."] = "순서 반전을 선택합니다.",
	["Numbers"] = "번호",
	["Toggle showing of PT numbers."] = "플레이어 대상의 번호 표시를 선택합니다.",
	["Tooltips"] = "툴팁",
	["Toggle showing of tooltips."] = "툴팁의 표시를 선택합니다.",
	["Show"] = "표시",
	["Show player."] = "플레이어를 표시합니다.",
	["Show target."] = "대상을 표시합니다.",
	["Show targettarget."] = "대상의 대상을 표시합니다.",
	["Define which frames you want to see."] = "표시하길 원하는 창을 지정합니다.",
	["Layout"] = "레이아웃",
	["Set the layout for the PT frames."] = "플레이어 대상창의 레이아웃을 설정합니다.",
	["Vertical"] = "세로",
	["Horizontal"] = "가로",

	["Set"] = "플레이어 지정",
	["Set a player."]= "플레이어를 지정합니다.",
	["<nr> <name>"] = "<번호> <이름>",
	["<nr>"] = "<번호>",
	["<name>"] = "<이름>",
	["Remove"] = "플레이어 삭제",
	["Remove a player."] = "플레이어를 목록에서 삭제합니다.",
	["Removed player: "] = "삭제된 플레이어: ",
	["Set player: "] = "지정된 플레이어: ",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear player targets."] = "|cffffffff블리자드 단축키 설정창|r을 열어 플레이어 타켓을 지우거나 단축키 지정등을 설정 하세요.",
	["Press |cffffffff%s|r to set the next player tank or |cffffffff%s|r to clear the last tank set."] = "|cffffffff%s|r 누르면 다음 메인 탱커 지정 , |cffffffff%s|r 누르면 마지막 탱커를 지웁니다.",
	["<no binding>"] = "<단축키 없음>",
	
	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<지정되지 않음>",

	["Style"] = "스타일",
	["Set the frame style."] = "프레임 스타일을 설정합니다.",
	["<style>"] = "<스타일>",
	
	["Default"] = "기본형",
	["Compact"] = "간략형",

	["Backwards"] = "뒤로",
	["Order PT|PTT|PTTT Backwards."] = "PT|PTT|PTTT 순서를 뒤로 합니다.",

	["Lock"] = "고정",
	["Lock the PT frames."] = "플레이어 대상창을 고정합니다.",

} end)

L:RegisterTranslations("zhCN", function() return {
	["Player"] = "玩家",
	["PlayerTarget"] = "玩家目标",
	["Optional/PlayerTarget"] = "选择/玩家目标",
	["Options for the playertargets."] = "玩家目标选项。",
	["Targettarget"] = "目标的目标",
	["Toggle TargetTarget frames."] = "显示目标的目标框体。",
	["Scale"] = "大小",
	["Set frame scale."] = "设定框体大小。",
	["Alpha"] = "透明度",
	["Set frame alpha."] = "设置框体透明度。",
	["Raidicon"] = "Raid 图标",
	["Toggle raid icons."] = "显示 Raid 图标。",
	["Frames"] = "框体",
	["Options for the playertarget frames."] = "玩家目标框体选项。",
	["Growup"] = "往上增添",
	["Toggle growup."] = "选择往上增添。",
	["Inverse"] = "翻转",
	["Toggle inverse healthbar."] = "选择翻转血条。",
	["Deficit"] = "亏损血量",
	["Toggle deficit health."] = "显示亏损血量。",
	["Target"] = "目标",
	["TargetTarget"] = "目标的目标",
	["Set the maximum number of player tanks you want to show."] = "显示的 PT 数量。",
	["Amount"] = "PT 数量",
	["Classcolor"] = "职业颜色",
	["Color healthbars by class."] = "把血条着色为职业颜色。",
	["Enemycolor"] = "敌人颜色",
	["Set the color for enemies. (used when classcolor is enabled)"] = "为敌人设置颜色(需要激活职业颜色)。",
	["Color Aggro"] = "仇恨颜色",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "PT 的名字边框用颜色来显示仇恨的状态。橘红是有目标，绿色是正在坦克，红色是没有仇恨。",
	["Backdrop"] = "背景",
	["Toggle the backdrop."] = "显示背景。",
	["Highlight"] = "高亮",
	["Toggle highlighting your target."] = "高亮显示你的目标。",
	["Reverse"] = "逆转",
	["Toggle reverse order."] = "颠倒显示顺序。",
	["Numbers"] = "数量",
	["Toggle showing of PT numbers."] = "显示 PT 的数量。",
	["Tooltips"] = "提示",
	["Toggle showing of tooltips."] = "显示提示。",
	["Show"] = "显示",
	["Show player."] = "显示 PT。",
	["Show target."] = "显示目标。",
	["Show targettarget."] = "显示目标的目标。",
	["Define which frames you want to see."] = "定义想要看到的框架。",
	["Layout"] = "布局",
	["Set the layout for the PT frames."] = "设置 PT 框架的布局。",
	["Vertical"] = "垂直",
	["Horizontal"] = "水平",

	["Set"] = "设定 PT",
	["Set a player."]= "设定 PT。",
	["<nr> <name>"] = "<数量> <名字>",
	["<nr>"] = "<数量>",
	["<name>"] = "<姓名>",
	["Remove"] = "移除 PT",
	["Remove a player."] = "移除 PT。",
	["Removed player: "] = "移除 PT：",
	["Set player: "] = "设置 PT：",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear player targets."] = "打开|cffffffff暴雪按键绑定界面|r设置或删除玩家目标的按键绑定。",
	["Press |cffffffff%s|r to set the next player tank or |cffffffff%s|r to clear the last tank set."] = "按|cffffffff%s|r设置下一位玩家 Tank 或者|cffffffff%s|r清除最后 Tank 设置。",
	["<no binding>"] = "没有绑定",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["<Not Assigned>"] = "<还未设定>",

	["Style"] = "风格",
	["Set the frame style."] = "订制框体风格。",
	["<style>"] = "<风格>",

	["Default"] = "默认",
	["Compact"] = "小巧",

	["Backwards"] = "倒排",
	["Order PT|PTT|PTTT Backwards."] = "PT|PTT|PTTT 倒序排列。",

	["Lock"] = "锁定",
	["Lock the PT frames."] = "锁定 PT 框体。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Player"] = "玩家",
	["PlayerTarget"] = "玩家目標",
	["Optional/PlayerTarget"] = "可選/玩家目標",
	["Options for the playertargets."] = "玩家目標選項",
	["Targettarget"] = "目標的目標",
	["Toggle TargetTarget frames."] = "顯示目標的目標框架",
	["Scale"] = "大小",
	["Set frame scale."] = "設定框架大小",
	["Alpha"] = "透明度",
	["Set frame alpha."] = "設定框架的透明度",
	["Raidicon"] = "團隊圖示",
	["Toggle raid icons."] = "切換團隊圖示",
	["Frames"] = "框架",
	["Options for the playertarget frames."] = "玩家目標的框架選項",
	["Growup"] = "往上排列",
	["Toggle growup."] = "切換往上排列",
	["Inverse"] = "倒轉",
	["Toggle inverse healthbar."] = "切換倒轉血條",
	["Deficit"] = "減少血量",
	["Toggle deficit health."] = "顯示減少血量",
	["Target"] = "目標",
	["TargetTarget"] = "目標的目標",
	["Set the maximum number of player tanks you want to show."] = "設定可顯示的玩家最大數量",
	["Amount"] = "玩家數量",
	["Classcolor"] = "職業顏色",
	["Color healthbars by class."] = "依職業設定血條顏色",
	["Enemycolor"] = "敵人顏色",
	["Set the color for enemies. (used when classcolor is enabled)"] = "為敵人設定顏色(需要使用職業顏色)",
	["Color Aggro"] = "仇恨顏色",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "玩家目標的名字邊框用顏色來顯示仇恨的狀態。橘紅是有目標，綠色是正在坦怪，紅色是沒有仇恨。",
	["Backdrop"] = "背景",
	["Toggle the backdrop."] = "顯示背景",
	["Highlight"] = "高亮度",
	["Toggle highlighting your target."] = "高亮度顯示你的目標",
	["Reverse"] = "逆轉",
	["Toggle reverse order."] = "切換逆向排序",
	["Numbers"] = "數量",
	["Toggle showing of PT numbers."] = "顯示玩家目標的數量",
	["Tooltips"] = "提示",
	["Toggle showing of tooltips."] = "顯示提示",
	["Show"] = "顯示",
	["Show player."] = "顯示玩家",
	["Show target."] = "顯示目標",
	["Show targettarget."] = "顯示目標的目標",
	["Define which frames you want to see."] = "定義想要看到的框架",
	["Layout"] = "佈置",
	["Set the layout for the PT frames."] = "設定玩家目標框架的佈置",
	["Vertical"] = "垂直",
	["Horizontal"] = "水平",

	["Set"] = "設置玩家",
	["Set a player."]= "設置一位玩家",
	["<nr> <name>"] = "<數量> <姓名>",
	["<nr>"] = "<數量>",
	["<name>"] = "<姓名>",
	["Remove"] = "移除玩家",
	["Remove a player."] = "移除一位玩家",
	["Removed player: "] = "移除玩家：",
	["Set player: "] = "設置玩家：",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<尚未設定>",

	["Style"] = "風格",
	["Set the frame style."] = "設定框架風格",
	["<style>"] = "<風格>",

	["Default"] = "預設",
	["Compact"] = "簡潔",

	["Backwards"] = "反向",
	["Order PT|PTT|PTTT Backwards."] = "PT|PTT|PTTT順序反向排列",

	["Lock"] = "鎖定",
	["Lock the PT frames."] = "鎖定玩家框架",
} end)

L:RegisterTranslations("frFR", function() return {
	["Player"] = "Joueur",
	["PlayerTarget"] = "Cibles des joueurs",
	["Optional/PlayerTarget"] = "Optionnel/Cibles des joueurs",
	["Options for the playertargets."] = "Optons concernant les cibles des joueurs.",
	["Targettarget"] = "Cible de la cible",
	["Toggle TargetTarget frames."] = "Affiche ou non les cadres de la cible de la cible.",
	["Scale"] = "Échelle",
	["Set frame scale."] = "Détermine l'échelle des cadres.",
	["Alpha"] = "Transparence",
	["Set frame alpha."] = "Détermine la transparence des cadres.",
	["Raidicon"] = "Icônes de raid",
	["Toggle raid icons."] = "Affiche ou non les icônes de raid.",
	["Frames"] = "Cadres",
	["Options for the playertarget frames."] = "Options concernant les cadres des cibles des joueurs.",
	["Growup"] = "Vers le haut",
	["Toggle growup."] = "Ajoute ou non les nouvelles entrées vers le haut.",
	["Inverse"] = "Inverser les vies",
	["Toggle inverse healthbar."] = "Inverse ou non le sens de remplissage des barres de vie.",
	["Deficit"] = "Déficit",
	["Toggle deficit health."] = "Affiche ou non le déficit en vie.",
	["Target"] = "Cible",
	["TargetTarget"] = "Cible de la cible",
	["Set the maximum number of player tanks you want to show."] = "Définit le nombre maximal de joueurs que vous voulez afficher.",
	["Amount"] = "Nombre",
	["Classcolor"] = "Couleur de la classe",
	["Color healthbars by class."] = "Colore les barres de vie selon la classe.",
	["Enemycolor"] = "Couleur des ennemis",
	["Set the color for enemies. (used when classcolor is enabled)"] = "Détermine la couleur pour les ennemis. (utilisé si \"Couleur de la classe\" est activé)",
	["Color Aggro"] = "Couleur d'aggro",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Indique le statut de l'aggro des cibles des joueurs selon la couleur de leurs noms. Orange s'ils ont la cible, Vert s'ils tankent leur cible, Rouge s'ils n'ont pas l'aggro.",
	["Backdrop"] = "Fond",
	["Toggle the backdrop."] = "Affiche ou non le fond.",
	["Highlight"] = "Surbrillance",
	["Toggle highlighting your target."] = "Met ou non en surbrillance votre cible.",
	["Reverse"] = "Inverser l'ordre",
	["Toggle reverse order."] = "Inverse ou non l'ordre d'affichage.",
	["Numbers"] = "Numéros",
	["Toggle showing of PT numbers."] = "Affiche ou non les numéros des cibles des joueurs.",
	["Tooltips"] = "Infobulles",
	["Toggle showing of tooltips."] = "Affiche ou non les infobulles.",
	["Show"] = "Afficher",
	["Show player."] = "Affiche le joueur.",
	["Show target."] = "Affiche la cible.",
	["Show targettarget."] = "Affiche la cible de la cible.",
	["Define which frames you want to see."] = "Détermine les cadres que vous souhaitez voir.",
	["Layout"] = "Style",
	["Set the layout for the PT frames."] = "Détermine l'orientation des cadres des cibles des joueurs.",
	["Vertical"] = "Vertical",
	["Horizontal"] = "Horizontal",

	["Set"] = "Définir",
	["Set a player."]= "Définit un joueur.",
	["<nr> <name>"] = "<n°> <nom>",
	["<nr>"] = "<n°>",
	["<name>"] = "<nom>",
	["Remove"] = "Enlever",
	["Remove a player."] = "Enlève un joueur.",
	["Removed player: "] = "Joueur enlevé : ",
	["Set player: "] = "Joueur définit : ",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<Non assigné>",

	["Style"] = "Style",
	["Set the frame style."] = "Détermine le style des cadres.",
	["<style>"] = "<style>",

	["Default"] = "Défaut",
	["Compact"] = "Compact",

	["Backwards"] = "Ordre inverse",
	["Order PT|PTT|PTTT Backwards."] = "Ordonne PT|PTT|PTTT en sens inverse.",

	["Lock"] = "Verrouiller",
	["Lock the PT frames."] = "Verrouille les cadres des cibles des joueurs.",
} end)

L:RegisterTranslations("deDE", function() return {
	["Player"] = "Spieler",
	["PlayerTarget"] = "PlayerTarget",
	["Optional/PlayerTarget"] = "Wahlweise/PlayerTarget",
	["Options for the playertargets."] = "Optionen für PlayerTargets PT (Spielerziel(e)).",
	["Targettarget"] = "Ziel des Zieles",
	["Toggle TargetTarget frames."] = "Aktiviert den Rahmen für das Ziel des Zieles.",
	["Scale"] = "Größe",
	["Set frame scale."] = "Setzt die Rahmengröße.",
	["Alpha"] = "Transparenz",
	["Set frame alpha."] = "Setzt die Rahmentransparenz.",
	["Raidicon"] = "Schlachtzugssymbole",
	["Toggle raid icons."] = "Schlachtzugssymbole ein-/ausblenden.",
	["Frames"] = "Rahmen",
	["Options for the playertarget frames."] = "Optionen für den PlayerTarget Rahmen",
	["Growup"] = "Aufbauend",
	["Toggle growup."] = "Baut den Rahmen nach oben auf.",
	["Inverse"] = "Umkehren",
	["Toggle inverse healthbar."] = "Umkehren des Lebensbalkens ein-/ausschalten.",
	["Deficit"] = "Defizit",
	["Toggle deficit health."] = "Anzeige des Lebensdefizits ein-/ausschalten.",
	["Target"] = "Ziel",
	["TargetTarget"] = "Ziel des Zieles",
	["Set the maximum number of player tanks you want to show."] = "Anzahl der angezeigten Spielerziele.",
	["Amount"] = "Anzahl PlayerTargets",
	["Classcolor"] = "Klassenfarbe",
	["Color healthbars by class."] = "Färbt den Lebensbalken je nach Klasse ein.",
	["Enemycolor"] = "Feindfarbe",
	["Set the color for enemies. (used when classcolor is enabled)"] = "Setzt die Farbe für Gegner. ('Klassenfarbe' muß aktiviert sein)",
	["Color Aggro"] = "Aggro Farbe",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Farbe für den Aggrostatus der PlayerTargets setzen. Orange hat Aggro, Grün tankt, Rot hat keine Aggro.",
	["Backdrop"] = "Hintergrund",
	["Toggle the backdrop."] = "Hintergrund ein-/ausschalten.",
	["Highlight"] = "Hervorheben",
	["Toggle highlighting your target."] = "Hervorheben Deines Ziels ein-/ausschalten.",
	["Reverse"] = "Rückwärts",
	["Toggle reverse order."] = "Rückwärtssortierung ein-/ausschalten.",
	["Numbers"] = "Nummern",
	["Toggle showing of PT numbers."] = "Anzeige der PT Nummern ein-/ausschalten.",
	["Tooltips"] = "Tooltips",
	["Toggle showing of tooltips."] = "Tooltipanzeige ein-/ausschalten.",
	["Show"] = "Zeigen",
	["Show player."] = "Zeige Spieler.",
	["Show target."] = "Zeige Ziel.",
	["Show targettarget."] = "Zeige Ziel des Zieles.",
	["Define which frames you want to see."] = "Definiert welchen Rahmen Du anzeigen willst.",
	["Layout"] = "Layout",
	["Set the layout for the PT frames."] = "Setzt das Layout für die PT Rahmen.",
	["Vertical"] = "Vertikal",
	["Horizontal"] = "Horizontal",

	["Set"] = "Setzt Spieler",
	["Set a player."]= "Setzt einen Spieler.",
	["<nr> <name>"] = "<nr> <name>",
	["<nr>"] = "<nr>",
	["<name>"] = "<name>",
	["Remove"] = "Entferne Spieler",
	["Remove a player."] = "Entfernt einen Spieler.",
	["Removed player: "] = "Spieler entfernt: ",
	["Set player: "] = "Spieler gesetzt: ",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear player targets."] = "Öffne die |cffffffffBlizzard Tastaturbelegung|r um für oRA2 Tasten zuzuweisen, mit welchen du die PlayerTarget (Spielerziele) Fenster setzen und löschen kannst.",
	["Press |cffffffff%s|r to set the next player tank or |cffffffff%s|r to clear the last tank set."] = "Drück |cffffffff%s|r um das nächste PlayerTarget zu setzen oder |cffffffff%s|r um das zuletzt gesetzte PlayerTarget zu löschen.",
	["<no binding>"] = "<keine belegung>",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<nicht zugewiesen>",

	["Style"] = "Aussehen",
	["Set the frame style."] = "Setzt das Aussehen des Rahmens.",
	["<style>"] = "<style>",

	["Default"] = "Standart",
	["Compact"] = "Kompakt",

	["Backwards"] = "Rückwärts",
	["Order PT|PTT|PTTT Backwards."] = "Sortiert PT|PTT|PTTT rückwärts.",

	["Lock"] = "Sperren",
	["Lock the PT frames."] = "Sperrt den PT Rahmen.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Player"] = "Игрок",
	["PlayerTarget"] = "Цель игрока",
	["Optional/PlayerTarget"] = "Дополнительно/Цели игрока",
	["Options for the playertargets."] = "Опции для целей игрока.",
	["Targettarget"] = "Цель Цели",
	["Toggle TargetTarget frames."] = "Вкл/Выкл фреймы Цель Цели.",
	["Scale"] = "Масштаб",
	["Set frame scale."] = "Настройка Масштаба Фрейма.",
	["Alpha"] = "Прозрачность",
	["Set frame alpha."] = "Настройка прозрачность фрейма.",
	["Raidicon"] = "Иконка рейда",
	["Toggle raid icons."] = "Вкл/Выкл иконки рейда.",
	["Frames"] = "Фреймы",
	["Options for the playertarget frames."] = "Опции фреймов целей игрока.",
	["Growup"] = "Рост вверх",
	["Toggle growup."] = "Вкл/Выкл рост вверх.",
	["Inverse"] = "Инверсия",
	["Toggle inverse healthbar."] = "Вкд/Выкл инверсиию полосы здоровья.",
	["Deficit"] = "Нехватка",
	["Toggle deficit health."] = "Вкд/Выкл нехватку здоровья.",
	["Target"] = "Цель",
	["TargetTarget"] = "Цель Цели",
	["Set the maximum number of player tanks you want to show."] = "Установите максимальное количество игроков(второстепенных) танков которое вы хотите видеть.",
	["Amount"] = "Количество.",
	["Classcolor"] = "Цвет Класса",
	["Color healthbars by class."] = "Цвет полосы жизни по классу.",
	["Enemycolor"] = "Цвет врага",
	["Set the color for enemies. (used when classcolor is enabled)"] = "Выберите цвет полосы врага. (использовать при включенном класс цвете)",
	["Color Aggro"] = "Цвет аггро",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Цвет статуса аггро ВТов на их именах. Оранжевый - имеет цель, Зеленый - танкует, Красный - без аггро.",
	["Backdrop"] = "Фон",
	["Toggle the backdrop."] = "Вкл/Выкл Фон.",
	["Highlight"] = "Выделение",
	["Toggle highlighting your target."] = "Вкл/Выкл выделение вашей цели.",
	["Reverse"] = "Перевернуть",
	["Toggle reverse order."] = "Вкл/Выкл переворачивание расположения.",
	["Numbers"] = "Номера",
	["Toggle showing of PT numbers."] = "Вкл/Выкл отображение номеров ВТ.",
	["Tooltips"] = "Подсказки",
	["Toggle showing of tooltips."] = "Вкл/Выкл отображение подсказок.",
	["Show"] = "Отображение",
	["Show player."] = "Отображать игрока.",
	["Show target."] = "Отображать цель.",
	["Show targettarget."] = "Отображать цель цели.",
	["Define which frames you want to see."] = "Определять который фрейм вы хотите видеть.",
	["Layout"] = "Располжение",
	["Set the layout for the PT frames."] = "Установка расположение для фрейма ВТов.",
	["Vertical"] = "Вертикальное",
	["Horizontal"] = "Горизонтальное",

	["Set"] = "Назначить",
	["Set a player."]= "Назначить игрока.",
	["<nr> <name>"] = "<№> <имя>",
	["<nr>"] = "<№>",
	["<name>"] = "<имя>",
	["Remove"] = "Удалить",
	["Remove a player."] = "Удаляет игрока.",
	["Removed player: "] = "Удаленный игрок: ",
	["Set player: "] = "Назначить игрока: ",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<Не назначен>",

	["Style"] = "Стиль",
	["Set the frame style."] = "Установить стиль фреймов.",
	["<style>"] = "<стиль>",

	["Default"] = "Стандартный",
	["Compact"] = "Компактно",

	["Backwards"] = "Вернуть",
	["Order PT|PTT|PTTT Backwards."] = "Сортирует обратно ВТ|ВTЦ|ВTЦЦ.",

	["Lock"] = "Закрепить",
	["Lock the PT frames."] = "Закрепить ВT фреймы.",
} end)

----------------------------------
--    Default Frame Styles      --
----------------------------------

local defaultstyle = {
	width = 120, height = 21,
	bar = {
		width = 112, height = 16,
		xoff = 4, yoff = 0,
		point = "LEFT", rpoint = "LEFT",
	},
	name = {
		width = 62, height = 14,
		xoff = 22, yoff = 0,
		point = "LEFT", rpoint = "LEFT",
	},
	raidicon = {
		width = 14, height = 14,
		xoff = 5, yoff = 0,
		point = "LEFT", rpoint = "LEFT",
	},
	text = { -- health text
		width = 32, height = 14,
		xoff = -4, yoff = 0,
		point = "RIGHT", rpoint = "RIGHT"
	}
}

if (GetLocale() == "koKR") then
	defaultstyle = {
		width = 128, height = 21,
		bar = {
			width = 120, height = 16,
			xoff = 4, yoff = 0,
			point = "LEFT", rpoint = "LEFT",
		},
		name = {
			width = 62, height = 14,
			xoff = 22, yoff = 0,
			point = "LEFT", rpoint = "LEFT",
		},
		raidicon = {
			width = 14, height = 14,
			xoff = 5, yoff = 0,
			point = "LEFT", rpoint = "LEFT",
		},
		text = { -- health text
			width = 40, height = 14,
			xoff = -4, yoff = 0,
			point = "RIGHT", rpoint = "RIGHT"
		}
	}
end

local compactstyle = {
	width = 70, height = 34,
	bar = {
		width = 64, height = 16,
		xoff = 2, yoff = -1,
		point = "TOPLEFT", rpoint = "TOPLEFT",
	},
	name = {
		width = 62, height = 14,
		xoff = 4, yoff = -2,
		point = "TOPLEFT", rpoint = "TOPLEFT",
	},
	raidicon = {
		width = 14, height = 14,
		xoff = 5, yoff = 2,
		point = "BOTTOMLEFT", rpoint = "BOTTOMLEFT",
	},
	text = { -- health text
		width = 32, height = 14,
		xoff = -4, yoff = 2,
		point = "BOTTOMRIGHT", rpoint = "BOTTOMRIGHT"
	}
}


----------------------------------
--      Module Declaration      --
----------------------------------

local function validateSet(a, b)
	if b then -- We're in dewdrop.
		return b:find("^(%S+)$")
	else -- We're in AceConsole
		return a:find("^(%S+)$")
	end
end

local mod = oRA:NewModule("OptionalPT")

mod.defaults = {
	raidicon = true,
	alpha = 1,
	scale = 1,
	growup = false,
	inverse = false,
	deficit = false,
	ctplayer = L["Player"],
	cttarget = L["Target"],
	cttargettarget = L["TargetTarget"],
	nrpts = 4,
	classcolor = true,
	enemycolor = {0.8, 0.13, 0},
	coloraggro = true,
	backdrop = true,
	highlight = true,
	reversed = false,
	numbers = true,
	tooltips = true,
	showpt = true,
	showptt = true,
	showpttt = true,
	layout = L["Vertical"],
	playertable = {},
	style = L["Default"],
	targettarget = true,
	backwards = false,
}
mod.optional = true
mod.name = L["Optional/PlayerTarget"]
mod.consoleCmd = "pt"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for the playertargets."],
	name = L["PlayerTarget"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {
		nr = {
			type = "range",
			name = L["Amount"],
			desc = L["Set the maximum number of player tanks you want to show."],
			get = function() return mod.db.profile.nrpts end,
			set = "SetNrPlayers",
			min = 0, max = 10, step = 1,
			disabled = function() return InCombatLockdown() end,
			order = 3,
		},
		set = {
			name = L["Set"], type = "group",
			desc = L["Set a player."],
			disabled = function() return not oRA:IsModuleActive(mod) or InCombatLockdown() end,
			order = 1,
			pass = true,
			get = function(key)
				if mod.db.profile.playertable[key] then
					return mod.db.profile.playertable[key]
				else
					return ""
				end
			end,
			set = "Set",
			args = {
				[1] = {
					name = "1.", type = "text", desc = L["Set"].." 1",
					validate = validateSet,
					usage = L["<name>"],
					order = 1,
				},
				[2] = {
					name = "2.", type = "text", desc = L["Set"].." 2",
					validate = validateSet,
					usage = L["<name>"],
					order = 2,
				},
				[3] = {
					name = "3.", type = "text", desc = L["Set"].." 3",
					validate = validateSet,
					usage = L["<name>"],
					order = 3,
				},
				[4] = {
					name = "4.", type = "text", desc = L["Set"].." 4",
					validate = validateSet,
					usage = L["<name>"],
					order = 4,
				},
				[5] = {
					name = "5.", type = "text", desc = L["Set"].." 5",
					validate = validateSet,
					usage = L["<name>"],
					order = 5,
				},
				[6] = {
					name = "6.", type = "text", desc = L["Set"].." 6",
					validate = validateSet,
					usage = L["<name>"],
					order = 6,
				},
				[7] = {
					name = "7.", type = "text", desc = L["Set"].." 7",
					validate = validateSet,
					usage = L["<name>"],
					order = 7,
				},
				[8] = {
					name = "8.", type = "text", desc = L["Set"].." 8",
					validate = validateSet,
					usage = L["<name>"],
					order = 8,
				},
				[9] = {
					name = "9.", type = "text", desc = L["Set"].." 9",
					validate = validateSet,
					usage = L["<name>"],
					order = 9,
				},
				[10] = {
					name = "10.", type = "text", desc = L["Set"].." 10",
					validate = validateSet,
					usage = L["<name>"],
					order = 10,
				},
			}
		},
		remove = {
			name = L["Remove"], type = "group",
			desc = L["Remove a player."],
			disabled = function() return not oRA:IsModuleActive(mod) or InCombatLockdown() end,
			order = 2,
			pass = true,
			func = "Remove",
			args = {
				[1] = {
					name = "1.", type = "execute", desc = L["Remove"].." 1",
					disabled = function() return not mod.db.profile.playertable[1] end,
					order = 1,
				},
				[2] = {
					name = "2.", type = "execute", desc = L["Remove"].." 2",
					disabled = function() return not mod.db.profile.playertable[2] end,
					order = 2,
				},
				[3] = {
					name = "3.", type = "execute", desc = L["Remove"].." 3",
					disabled = function() return not mod.db.profile.playertable[3] end,
					order = 3,
				},
				[4] = {
					name = "4.", type = "execute", desc = L["Remove"].." 4",
					disabled = function() return not mod.db.profile.playertable[4] end,
					order = 4,
				},
				[5] = {
					name = "5.", type = "execute", desc = L["Remove"].." 5",
					disabled = function() return not mod.db.profile.playertable[5] end,
					order = 5,
				},
				[6] = {
					name = "6.", type = "execute", desc = L["Remove"].." 6",
					disabled = function() return not mod.db.profile.playertable[6] end,
					order = 6,
				},
				[7] = {
					name = "7.", type = "execute", desc = L["Remove"].." 7",
					disabled = function() return not mod.db.profile.playertable[7] end,
					order = 7,
				},
				[8] = {
					name = "8.", type = "execute", desc = L["Remove"].." 8",
					disabled = function() return not mod.db.profile.playertable[8] end,
					order = 8,
				},
				[9] = {
					name = "9.", type = "execute", desc = L["Remove"].." 9",
					disabled = function() return not mod.db.profile.playertable[9] end,
					order = 9,
				},
				[10] = {
					name = "10.", type = "execute", desc = L["Remove"].." 10",
					disabled = function() return not mod.db.profile.playertable[10] end,
					order = 10,
				},
			},
		},
		frames = {
			type = "group",
			desc = L["Options for the playertarget frames."],
			name = L["Frames"],
			disabled = function() return InCombatLockdown() end,
			order = 4,
			args = {
				lock = {
					type = "toggle", name = L["Lock"],
					desc = L["Lock the PT frames."],
					get = function() return mod.db.profile.lock end,
					set = "ToggleLock",
				},
				classcolor = {
					type = "toggle",
					name = L["Classcolor"],
					desc = L["Color healthbars by class."],
					get = function() return mod.db.profile.classcolor end,
					set = function(v) mod.db.profile.classcolor = v end,
				},
				enemycolor = {
					type = "color",
					name = L["Enemycolor"],
					desc = L["Set the color for enemies. (used when classcolor is enabled)"],
					get = function()
						return unpack(mod.db.profile.enemycolor)
					end,
					set = function(r, g, b)
						mod.db.profile.enemycolor[1] = r
						mod.db.profile.enemycolor[2] = g
						mod.db.profile.enemycolor[3] = b
					end,
					disabled = function() return not mod.db.profile.classcolor end,
				},
				aggrocolor = {
					type = "toggle",
					name = L["Color Aggro"],
					desc = L["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."],
					get = function() return mod.db.profile.coloraggro end,
					set = function(v) mod.db.profile.coloraggro = v end,
				},
				backdrop = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = function() return mod.db.profile.backdrop end,
					set = function(v) mod.db.profile.backdrop = v end,
				},
				highlight = {
					type = "toggle",
					name = L["Highlight"],
					desc = L["Toggle highlighting your target."],
					get = function() return mod.db.profile.highlight end,
					set = function(v) mod.db.profile.highlight = v end,
				},
				scale = {
					type = "range",
					name = L["Scale"],
					desc = L["Set frame scale."],
					get = function() return mod.db.profile.scale end,
					set = "SetScale",
					min = 0.1,
					max = 2,
				},
				alpha = {
					type = "range",
					name = L["Alpha"],
					desc = L["Set frame alpha."],
					get = function() return mod.db.profile.alpha end,
					set = "SetAlpha",
					min = 0.1,
					max = 1,
				},
				raidicon = {
					type = "toggle",
					name = L["Raidicon"],
					desc = L["Toggle raid icons."],
					get = function() return mod.db.profile.raidicon end,
					set = "ToggleRaidIcon",
				},
				inverse = {
					type = "toggle",
					name = L["Inverse"],
					desc = L["Toggle inverse healthbar."],
					get = function() return mod.db.profile.inverse end,
					set = function(v) mod.db.profile.inverse = v end,
				},
				tooltips = {
					type = "toggle",
					name = L["Tooltips"],
					desc = L["Toggle showing of tooltips."],
					get = function() return mod.db.profile.tooltips end,
					set = function(v) mod.db.profile.tooltips = v end,
				},
				deficit = {
					type = "toggle",
					name = L["Deficit"],
					desc = L["Toggle deficit health."],
					get = function() return mod.db.profile.deficit end,
					set = function(v) mod.db.profile.deficit = v end,
				},
				style = {
					type = "text",
					name = L["Style"],
					desc = L["Set the frame style."],
					get = function() return mod.db.profile.style end,
					set = "ChangeStyle",
					validate = { L["Default"], L["Compact"] },
					usage = L["<style>"],
				},
				growup = {
					type = "toggle",
					name = L["Growup"],
					desc = L["Toggle growup."],
					get = function() return mod.db.profile.growup end,
					set = "ToggleGrowup",
				},
				reverse = {
					type = "toggle",
					name = L["Reverse"],
					desc = L["Toggle reverse order."],
					get = function() return mod.db.profile.reversed end,
					set = "ToggleReversed",
				},
				targettarget = {
					name = L["TargetTarget"], type = "toggle", desc = L["Show targettarget."],
					get = function() return mod.db.profile.targettarget end,
					set = "ToggleTargetTarget",
				},
				backwards = {
					type = "toggle",
					name = L["Backwards"],
					desc = L["Order PT|PTT|PTTT Backwards."],
					get = function() return mod.db.profile.backwards end,
					set = "ToggleBackwards",
				},
			},
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnRegister()
	self.secureframes = {}
	self.styles = {}

	-- Anyone registering styles in this file without Ammo's permission
	-- will be gangraped by a bunch of gay gorillas.
	self:RegisterStyle(L["Default"], defaultstyle)
	self:RegisterStyle(L["Compact"], compactstyle)

	if not self.styles[self.db.profile.style] then self.db.profile.style = L["Default"] end
	if not self.db.profile.playertable then self.db.profile.playertable = {} end
end

function mod:OnEnable()
	self:RegisterEvent("oRA_JoinedRaid", "UpdatePlayerTargets")
	self:RegisterEvent("oRA_BarTexture")

	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function mod:OnDisable()
	if self.mainframe then
		self.mainframe:Hide()
	end
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PLAYER_REGEN_ENABLED()
	if combatUpdate then
		combatUpdate = nil
		self:UpdatePlayerTargets()
	end
end

function mod:UpdatePlayerTargets()
	if not self.db.profile.playertable then return end
	if InCombatLockdown() then
		combatUpdate = true
		return
	end
	if not self.mainframe then
		self:SetupFrames()
	end

	self:UpdateConsole()

	local pts = {}
	local showpt
	for i = 1, self.db.profile.nrpts do
		if self.db.profile.playertable[i] then
			showpt = true
			table.insert(pts, self.db.profile.playertable[i])
		end
	end

	if showpt and self.mainframe and self.header then
		self.mainframe:Show()
		self.header:SetAttribute("nameList", table.concat(pts,","))
		self.header:Show()
	elseif self.mainframe and self.header then
		self.mainframe:Hide()
		self.header:Hide()
	end

	self:TriggerEvent("oRA_UpdateConfigGUI")
end

function mod:oRA_BarTexture(texture)
	local tex = media:Fetch("statusbar", texture)
	for _, f in pairs(self.secureframes) do
		f.bar:SetStatusBarTexture(tex)
		f.bar.texture:SetTexture(tex)
		f.targetframe.bar:SetStatusBarTexture(tex)
		f.targetframe.bar.texture:SetTexture(tex)
		f.targettargetframe.bar:SetStatusBarTexture(tex)
		f.targettargetframe.bar.texture:SetTexture(tex)
	end
end

------------------------------
-- ConsoleOption Functions  --
------------------------------

function mod:SetScale(scale)
	self.db.profile.scale = scale

	if self.mainframe then
		self.mainframe:SetScale(scale)
	end
	self:RestorePosition()
end

function mod:SetAlpha(alpha)
	self.db.profile.alpha = alpha

	if self.mainframe then
		self.mainframe:SetAlpha(alpha)
	end
end

function mod:ToggleRaidIcon(state)
	self.db.profile.raidicon = state

	if state then return end

	for _, f in pairs(self.secureframes) do
		if f then f.raidicon:Hide() end
		if f.targetframe then f.targetframe.raidicon:Hide() end
		if f.targettargetframe then f.targettargetframe.raidicon:Hide() end
	end
end

function mod:SetNrPlayers(nr)
	self.db.profile.nrpts = nr

	-- Make sure to update the tablet in case it's detached.
	self:TriggerEvent("oRA_UpdateConfigGUI")
	self:UpdatePlayerTargets()
end

------------------------------
--     Utility Functions    --
------------------------------

function mod:ToggleLock(v)
	self.db.profile.lock = v
	if self.mainframe then
		if v then
			self.mainframe.text:Hide()
			self.mainframe:RegisterForDrag(nil)
		else
			self.mainframe.text:Show()
			self.mainframe:RegisterForDrag("LeftButton")
		end
	end
end

function mod:SavePosition()
	local f = self.mainframe
	if not f then return end

	local s = f:GetEffectiveScale()
		
	self.db.profile.posx = f:GetLeft() * s
	self.db.profile.posy = f:GetTop() * s
end

function mod:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy

	if not x or not y then return end

	local f = self.mainframe
	if not f then return end
	local s = f:GetEffectiveScale()

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
end

function mod:SetupFrames()
	local f = CreateFrame("Frame", nil, UIParent)
	f:Hide()
	f:SetMovable(true)
	f:SetScript("OnUpdate", function() self:OnUpdate() end)
	f:SetWidth(150)
	f:SetHeight(13)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	f:SetAlpha(self.db.profile.alpha)
	f:SetScale(self.db.profile.scale)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function() if not InCombatLockdown() and IsAltKeyDown() then this:StartMoving() end end)
	f:SetScript("OnDragStop", function() if not InCombatLockdown() then this:StopMovingOrSizing() self:SavePosition() end end)

	f.text = f:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	f.text:SetText(L["PlayerTarget"])
	f.text:SetAllPoints(f)

	f.update = 0
	self.mainframe = f

	self.header = CreateFrame("Frame", "oRAPlayerTarget",self.mainframe,"SecureRaidGroupHeaderTemplate")

	local f = self.header

	-- evil workaround to stop the header doing a gazillion updates on login
	f:UnregisterEvent("UNIT_NAME_UPDATE")

	f:SetFrameStrata("BACKGROUND")
	f:SetWidth(150)
	f:SetHeight(13)
	f:SetAttribute("minheight",13)
	f:SetAttribute("template","oRAOPlayerTargetTemplate")

	self:SetSecureAttributes(f)

	if self.db.profile.lock then
		self.mainframe.text:Hide()
		self.mainframe:RegisterForDrag(nil)
	end

	f:Show()

	self:RestorePosition()
end

function mod:SetSecureAttributes(f)
	f:ClearAllPoints()

	if self.db.profile.growup then
		f:SetAttribute("point", "TOP")
		f:SetPoint("BOTTOM", self.mainframe, "TOP", 0, 0)
	else
		f:SetAttribute("point", "BOTTOM")
		f:SetPoint("TOP", self.mainframe,"BOTTOM", 0, 0)
	end
	if self.db.profile.reversed then
		f:SetAttribute("sortDir", "ASC")
	else
		f:SetAttribute("sortDir", "DESC")
	end
end

function mod:RegisterSecureFrame(f)
	table.insert(self.secureframes, f)
end

function mod:CreateSecureUnitFrame(f)
	local style = self.styles[self.db.profile.style]
	f:SetHeight(style.height)
	f:SetWidth(style.width)
	self:FillFrame(f)
	self:SetStyle(f)
	f.type = "pt"
	f:SetAttribute("*type1", "target")
	f:RegisterForClicks("AnyUp")

	f:SetScript("OnEnter", function() self:OnEnter() end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)

	f.targetframe = CreateFrame("Button",f:GetName().."Target",f,"SecureActionButtonTemplate")
	f.targetframe.type = "ptt"
	self:FillFrame(f.targetframe)
	if self.db.profile.backwards then
		self:SetWHP(f.targetframe, style.width, style.height, "RIGHT", f, "LEFT", 0, 0)
	else
		self:SetWHP(f.targetframe, style.width, style.height, "LEFT", f, "LEFT", style.width, 0)
	end
	self:SetStyle(f.targetframe)
	f.targetframe:SetAttribute("useparent-unit", true)
	f.targetframe:SetAttribute("unitsuffix", "target")
	f.targetframe:SetAttribute("*type1","target")
	f.targetframe:RegisterForClicks("AnyUp")
	
	f.targetframe:SetScript("OnEnter", function() self:OnEnter() end)
	f.targetframe:SetScript("OnLeave", function() GameTooltip:Hide() end)

	f.targettargetframe = CreateFrame("Button",f:GetName().."TargetTarget",f,"SecureActionButtonTemplate")
	f.targettargetframe.type = "pttt"
	self:FillFrame(f.targettargetframe)
	if self.db.profile.backwards then
		self:SetWHP(f.targettargetframe, style.width, style.height, "RIGHT", f.targetframe, "LEFT", 0, 0)
	else
		self:SetWHP(f.targettargetframe, style.width, style.height, "LEFT", f.targetframe, "LEFT", style.width, 0)
	end
	self:SetStyle(f.targettargetframe)
	f.targettargetframe:SetAttribute("useparent-unit", true)
	f.targettargetframe:SetAttribute("unitsuffix", "targettarget")
	f.targettargetframe:SetAttribute("*type1","target")
	f.targettargetframe:RegisterForClicks("AnyUp")

	f.targettargetframe:SetScript("OnEnter", function() self:OnEnter() end)
	f.targettargetframe:SetScript("OnLeave", function() GameTooltip:Hide() end)

	if not self.db.profile.targettarget then f.targettargetframe:Hide() end

	self:RegisterSecureFrame(f)

	ClickCastFrames = ClickCastFrames or {}
	ClickCastFrames[f] = true
	ClickCastFrames[f.targetframe] = true
	ClickCastFrames[f.targettargetframe] = true
end

function mod:FillFrame(f)
	-- Tank Statusbar
	f.bar = CreateFrame("StatusBar", nil, f)
	f.bar:SetMinMaxValues(0,100)

	-- Tank Statusbar background texture, visible when the bar depleats
	f.bar.texture = f.bar:CreateTexture(nil, "BORDER")
	f.bar.texture:SetVertexColor(1, 0, 0, 0.5)

	-- Tank Statusbar text
	f.bar.text = f.bar:CreateFontString(nil, "OVERLAY")
	f.bar.text:SetFontObject(GameFontHighlightSmall)
	f.bar.text:SetJustifyH("RIGHT")

	-- Tank Name
	f.name = f.bar:CreateFontString(nil, "OVERLAY")
	f.name:SetFontObject(GameFontHighlightSmall)
	f.name:SetJustifyH("LEFT")

	-- Raid Icons
	f.raidicon = f.bar:CreateTexture(nil, "OVERLAY")
	f.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	f.raidicon:Hide()
end

function mod:SetStyle(f)
	local style = self.styles[self.db.profile.style]
	f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})

	if self.db.profile.backdrop then
		f:SetBackdropColor(0, 0, 0, .5)
	else
		f:SetBackdropColor(0, 0, 0, 0)
	end

	f.bar:SetStatusBarTexture(media:Fetch('statusbar', oRA.db.profile.bartexture))
	f.bar.texture:SetTexture(media:Fetch('statusbar', oRA.db.profile.bartexture))
	f.bar.texture:SetVertexColor(.5, .5, .5, .5)

	self:SetWHP(f.bar, style.bar.width, style.bar.height, style.bar.point, f, style.bar.rpoint, style.bar.xoff, style.bar.yoff)
	self:SetWHP(f.bar.texture, style.bar.width, style.bar.height, style.bar.point, f, style.bar.rpoint, style.bar.xoff, style.bar.yoff)

	self:SetWHP(f.raidicon, style.raidicon.width, style.raidicon.height, style.raidicon.point, f, style.raidicon.rpoint, style.raidicon.xoff, style.raidicon.yoff)		
	self:SetWHP(f.name, style.name.width, style.name.height, style.name.point, f, style.name.rpoint, style.name.xoff, style.name.yoff)
	self:SetWHP(f.bar.text, style.text.width, style.text.height, style.text.point, f, style.text.rpoint, style.text.xoff, style.text.yoff)

end

function mod:SetWHP(f, width, height, p1, relative, p2, x, y)
	if not f then return end

	f:SetWidth(width)
	f:SetHeight(height)

	if p1 then
		f:ClearAllPoints()
		f:SetPoint(p1, relative, p2, x, y)
	end
end

function mod:UpdateFrames(f)
	self:UpdateFrame(f)
	self:UpdateFrame(f.targetframe)
	if self.db.profile.targettarget then
		self:UpdateFrame(f.targettargetframe)
	end
end

function mod:UpdateFrame(f)
	local unit = SecureButton_GetUnit(f)

	if UnitExists(unit) then
		f.name:SetText(UnitName(unit))

		self:UpdateHealthBar(f.bar, unit)

		if self.db.profile.raidicon then
			self:UpdateRaidIcon(f, unit)
		end

		if f.type == "pt" and self.db.profile.coloraggro then
			if UnitExists(unit .. "target") then
				f.name:SetTextColor(1, 0.5, 0.25, 1)
				if UnitExists(unit .. "targettarget") then
					if UnitIsUnit(unit, unit .. "targettarget") then
						f.name:SetTextColor(0.5, 1, 0.5, 1)
					else
						f.name:SetTextColor(1, 0, 0, 1)
					end
				end
			else
				f.name:SetTextColor(1, 1, 1, 1)
			end
		else 
			if UnitIsEnemy(unit, "player") then f.name:SetTextColor(1, 0, 0, 1)
			else f.name:SetTextColor(1, 1, 1, 1) end
		end
			
		if UnitIsUnit(unit, "target") and self.db.profile.highlight then
			f:SetBackdropColor(1, .84, 0, 1)
		elseif self.db.profile.backdrop then
			f:SetBackdropColor(0, 0, 0, .5)
		else
			f:SetBackdropColor(0, 0, 0, 0)
		end
		f.bar.texture:SetVertexColor(.5, .5, .5, .5)
	else
		f.raidicon:Hide()
		f.bar.texture:SetVertexColor(0, 0, 0, 0)
		f:SetBackdropColor(0,0,0,0)
		f.name:SetText("")
		f.name:SetTextColor(1, 1, 1, 1)
		f.bar.text:SetText("")
		f.bar:SetMinMaxValues(0,1)
		f.bar:SetValue(0)
	end	
end

function mod:UpdateHealthBar(bar, unit)
	if not unit then return end
	local cur, max = UnitHealth(unit) or 0, UnitHealthMax(unit) or 0
	local perc = cur / max

	bar:SetMinMaxValues(0, max)
	
	if self.db.profile.inverse then
		bar:SetValue(max - cur)
	else
		bar:SetValue(cur)
	end

	if self.db.profile.classcolor then
		if not UnitIsEnemy(unit, "player") then
			local class = select(2, UnitClass(unit))
			local c = classColors[class] or classColors.WARRIOR
			bar:SetStatusBarColor(unpack(c))
		else
			bar:SetStatusBarColor(unpack(self.db.profile.enemycolor))
		end
	else
		bar:SetStatusBarColor(self:GetHealthBarColor(perc))
	end
	
	if self.db.profile.deficit then
		local val = max - cur
		if val > 1000 then
			val = ceil(val/100)/10 .. "k"
		elseif val == 0 then
			val = ""
		end
		
		bar.text:SetText(val)
	else
		bar.text:SetText(ceil(perc * 100) .. "%")
	end

	bar:Show()
end

function mod:GetHealthBarColor(perc)
	local r, g

	if perc > 0.5 then
		r = (1.0 - perc) * 2
		g = 1.0
	else
		r = 1.0
		g = perc * 2
	end

	return r, g, 0
end

function mod:UpdateRaidIcon(f, unit)
	local icon = GetRaidTargetIndex(unit)

	if icon then
		SetRaidTargetIconTexture(f.raidicon, icon)
		f.raidicon:Show()
	else
		f.raidicon:Hide()
	end
end

function mod:ToggleGrowup(state)
	self.db.profile.growup = state
	self:SetSecureAttributes(self.header)
	self:UpdatePlayerTargets()
end

function mod:ToggleReversed(state)
	self.db.profile.reversed = state
	self:SetSecureAttributes(self.header)
	self:UpdatePlayerTargets()
end

function mod:ToggleBackwards(state)
	self.db.profile.backwards = state
	local style = self.styles[self.db.profile.style]

	for k, f in pairs(self.secureframes) do
		if state then
			self:SetWHP(f.targetframe, style.width, style.height, "RIGHT", f, "LEFT", 0, 0)
			self:SetWHP(f.targettargetframe, style.width, style.height, "RIGHT", f.targetframe, "LEFT", 0, 0)
		else
			self:SetWHP(f.targetframe, style.width, style.height, "LEFT", f, "LEFT", style.width, 0)
			self:SetWHP(f.targettargetframe, style.width, style.height, "LEFT", f.targetframe, "LEFT", style.width, 0)
		end
	end
end

function mod:ToggleTargetTarget(state)
	self.db.profile.targettarget = state
	for k,frame in pairs(self.secureframes) do
		if self.db.profile.targettarget then
			frame.targettargetframe:Show()
		else
			frame.targettargetframe:Hide()
		end
	end
end

-------------------------------
--   Frame Script Functions  --
-------------------------------

function mod:OnUpdate()
	this.update = this.update + arg1

	if this.update >= 0.3 then
		for k,frame in pairs(self.secureframes) do
			self:UpdateFrames(frame)
		end
		this.update = 0
	end
end

function mod:OnEnter()
	if not self.db.profile.tooltips then return end
	local unit = SecureButton_GetUnit(this)

	GameTooltip_SetDefaultAnchor(GameTooltip, this)

	if unit and GameTooltip:SetUnit(unit) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME
	else
		this.updateTooltip = nil
	end
end

---------------------------
-- Setting and Removing  --
---------------------------

function mod:Set(num, name)
	if not name or name == "" then
		name = UnitName("target")
	else
		name = name:lower():gsub("^%l", string.upper)
	end
	if not UnitInRaid(name) then return end

	for k, v in pairs(self.db.profile.playertable) do
		if v == name then
			self.db.profile.playertable[k] = nil
		end
	end

	self.db.profile.playertable[num] = name
	self:UpdatePlayerTargets()

	self:Print(L["Set player: "] .. "[".. num .. "] [" .. name .."]")
end

function mod:Remove(num)
	local name = self.db.profile.playertable[num]
	if not name then return end
	self.db.profile.playertable[num] = nil
	self:UpdatePlayerTargets()
	self:Print(L["Removed player: "] .. num .." "..name)
end

function mod:SetNextMainTank()
	local name = UnitName("target")
	if not name then name = UnitName("mouseover") end
	if not name or not UnitInRaid(name) then return end
	for i = 1, 10 do
		if not self.db.profile.playertable[i] then
			self:Set(i, name)
			break
		end
	end
end

function mod:ClearLastMainTank()
	for i = 10, 1, -1 do
		if self.db.profile.playertable[i] then
			self:Remove(i)
			break
		end
	end
end

local nameString = "%d. %s"
function mod:UpdateConsole()
	local opt = oRA.consoleOptions.args.pt.args
	for k = 1, 10 do
		local pt = self.db.profile.playertable[k]
		if pt then
			local n = nameString:format(k, self.coloredNames[pt])
			opt.remove.args[k].name = n
			opt.set.args[k].name = n
		else
			opt.remove.args[k].name = tostring(k).."."
			opt.set.args[k].name = tostring(k).."."
		end
	end
end

do
	local l = L["Press |cffffffff%s|r to set the next player tank or |cffffffff%s|r to clear the last tank set."]
	local no = L["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear player targets."]
	local noBinding = L["<no binding>"]
	function mod:OnTooltipUpdate(tt)
		--if not oRA:IsPromoted() then return end
		local set = GetBindingKey("Set Next PT")
		local clear = GetBindingKey("Clear Last PT")
		if set then set = GetBindingText(set, "KEY_") end
		if clear then clear = GetBindingText(clear, "KEY_") end
		if set or clear then
			tt:AddLine(l:format(set or noBinding, clear or noBinding), nil, nil, nil, 1)
		else
			tt:AddLine(no, nil, nil, nil, 1)
		end
		tt:AddLine(" ")
	end
end

-------------------------------
--     Style Registration    --
-------------------------------

function mod:RegisterStyle(name, style)
	self.styles[name] = style
end

function mod:ChangeStyle(style)
	self.db.profile.style = style
	local tstyle = self.styles[self.db.profile.style]
	for k, f in pairs(self.secureframes) do	
		f:SetHeight(tstyle.height)
		f:SetWidth(tstyle.width)
		self:SetStyle(f)

		if self.db.profile.backwards then
			self:SetWHP(f.targetframe, tstyle.width, tstyle.height, "RIGHT", f, "LEFT", 0, 0)
		else
			self:SetWHP(f.targetframe, tstyle.width, tstyle.height, "LEFT", f, "LEFT", tstyle.width, 0)
		end
		self:SetStyle(f.targetframe)

		if self.db.profile.backwards then
			self:SetWHP(f.targettargetframe, tstyle.width, tstyle.height, "RIGHT", f.targetframe, "LEFT", 0, 0)
		else
			self:SetWHP(f.targettargetframe, tstyle.width, tstyle.height, "LEFT", f.targetframe, "LEFT", tstyle.width, 0)
		end
		self:SetStyle(f.targettargetframe)
	end
end

