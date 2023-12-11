﻿if GetLocale() ~= "zhTW" then return end

local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name 				= "基本選項"
})

L:SetTimerLocalization({
	TimerInvite 			= "%s"
})

L:SetOptionLocalization({
	ColorByClass			= "在得分視窗中設置玩家名為職業顏色",
	ShowInviteTimer			= "顯示戰場組隊計時器",
	AutoSpirit			= "自動釋放靈魂"
})

L:SetMiscLocalization({
	ArenaInvite			= "競技場邀請"
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name 				= "競技場 "
})

L:SetTimerLocalization({
	TimerStart			= "戰鬥即將開始",
	TimerShadow			= "暗影視界"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器",
	TimerShadow 			= "顯示暗影視界計時器"
})

L:SetMiscLocalization({
	Start60				= "競技場戰鬥在1分鐘內開始!",
	Start30				= "競技場戰鬥在30秒內開始!",
	Start15				= "競技場戰鬥在15秒內開始!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name 				= "奧特蘭克山谷"
})

L:SetTimerLocalization({
	TimerStart			= "戰鬥開始", 
	TimerTower			= "%s",
	TimerGY				= "%s"
})

L:SetMiscLocalization({
	BgStart60			= "奧特蘭克山谷一分鐘後開始戰鬥。",
	BgStart30			= "奧特蘭克山谷30秒後開始戰鬥。",
	ZoneName			= "奧特蘭克山谷"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器",
	TimerTower			= "顯示奪取哨塔計時器",
	TimerGY				= "顯示奪取墓地計時器",
	AutoTurnIn			= "自動繳交任務物品"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name 				= "阿拉希盆地"
})

L:SetMiscLocalization({
	BgStart60			= "阿拉希盆地的戰鬥將在1分鐘後開始。",
	BgStart30			= "阿拉希盆地的戰鬥將在30秒後開始。",
	ZoneName 			= "阿拉希盆地",
	ScoreExpr 			= "(%d+)/1600",
	Alliance 			= "聯盟",
	Horde 				= "部落",
	WinBarText 			= "%s 勝利",
	BasesToWin 			= "勝利需要基地: %d",
	Flag 				= "旗幟"
})

L:SetTimerLocalization({
	TimerStart 			= "戰鬥開始", 
	TimerCap 			= "%s"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器",
	TimerWin			= "顯示勝利計時器",
	TimerCap			= "顯示奪取計時器",
	ShowAbEstimatedPoints		= "顯示戰鬥結束時雙方資源預計值",
	ShowAbBasesToWin		= "顯示勝利需要的基地數量"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name 				= "暴風之眼"
})

L:SetMiscLocalization({
	BgStart60			= "戰鬥在1分鐘內開始!",
	BgStart30			= "戰鬥在30秒內開始!",
	ZoneName			= "暴風之眼",
	ScoreExpr			= "(%d+)/1600",
	Alliance 			= "聯盟",
	Horde 				= "部落",
	WinBarText 			= "%s 勝利",
	FlagReset 			= "旗幟已重置!",
	FlagTaken 			= "(.+)已經奪走了旗幟!",
	FlagCaptured			= "(.+)已奪得旗幟!",
	FlagDropped			= "旗幟已經掉落!"
})

L:SetTimerLocalization({
	TimerStart 			= "戰鬥開始", 
	TimerFlag 			= "旗幟重生"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器",
	TimerWin 			= "顯示勝利計時器",
	TimerFlag 			= "顯示旗幟重生計時器",
	ShowPointFrame			= "顯示旗幟攜帶者和預計勝利方"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name 				= "戰歌峽谷"
})

L:SetMiscLocalization({
	BgStart60 			= "戰歌峽谷戰鬥將在1分鐘內開始。",
	BgStart30 			= "戰歌峽谷戰鬥將在30秒鐘內開始。做好準備!",
	ZoneName 			= "戰歌峽谷",
	Alliance 			= "聯盟",
	Horde 				= "部落",	
	InfoErrorText			= "當你離開戰鬥後，旗幟框架將會回復。",
	ExprFlagPickUp			= "(.+)的旗幟被(.+)拔掉了!",
	ExprFlagCaptured		= "(.+)佔據了(.+)的旗幟!",
	ExprFlagReturn			= "(.+)的旗幟被(.+)還到了它的基地",
	FlagAlliance			= "聯盟旗幟: ",
	FlagHorde			= "部落旗幟: ",
	FlagBase			= "基地"
})

L:SetTimerLocalization({
	TimerStart 			= "戰鬥開始", 
	TimerFlag 			= "旗幟重生"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器",
	TimerFlag			= "顯示旗幟重生計時器",
	ShowFlagCarrier			= "顯示旗幟攜帶者",
	ShowFlagCarrierErrorNote	= "當正在戰鬥時顯示旗幟攜帶者的錯誤訊息。"
})

------------------------
--  Isle of Conquest  --
------------------------

L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name 				= "征服之島"
})

L:SetWarningLocalization({
	WarnSiegeEngine			= "攻城機具準備好了!",
	WarnSiegeEngineSoon		= "10秒後 攻城機具"
})

L:SetTimerLocalization({
	TimerStart			= "戰鬥開始", 
	TimerPOI			= "%s",
	TimerSiegeEngine		= "攻城機具修復"
})

L:SetOptionLocalization({
	TimerStart			= "顯示開始計時器", 
	TimerPOI			= "顯示奪取計時器",
	TimerSiegeEngine		= "為攻城機具的修復顯示計時器",
	WarnSiegeEngine			= "當攻城機具準備好時顯示警告",
	WarnSiegeEngineSoon		= "當攻城機具接近準備好時顯示警告"
})

L:SetMiscLocalization({
	ZoneName			= "征服之島",
	BgStart60			= "戰鬥在1分鐘內開始!",
	BgStart30			= "戰鬥在30秒內開始!",
	BgStart15			= "戰鬥在15秒內開始!",
	SiegeEngine			= "攻城機具",
	GoblinStartAlliance		= "看到那些爆鹽炸彈了嗎?當我維修攻城機具的時候用它們來轟破大門!",
	GoblinStartHorde		= "修理攻城機具的工作就交給我，幫我看著點就夠了。如果你想要轟破大門的話，儘管把那些爆鹽炸彈拿去用吧!",
	GoblinHalfwayAlliance		= "我已經修好一半了!別讓部落靠近。工程學院可沒有教我們如何作戰喔!",
	GoblinHalfwayHorde		= "我已經修好一半了!別讓聯盟靠近 - 我的合約裡可沒有作戰這一條!",
	GoblinFinishedAlliance		= "我有史以來最得意的作品!這台攻城機具已經可以上場囉!",
	GoblinFinishedHorde		= "這台攻城機具已經可以上場啦!",
	GoblinBrokenAlliance		= "這麼快就壞啦?!別擔心，再壞的情況我都可以修得好。",
	GoblinBrokenHorde		= "又壞掉了嗎?!讓我來修理吧…但別指望產品的保固會幫你支付這一切。"
})