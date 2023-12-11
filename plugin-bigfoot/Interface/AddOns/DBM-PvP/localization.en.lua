local L

--------------------------
--  General BG Options  --
--------------------------
L = DBM:GetModLocalization("Battlegrounds")

L:SetGeneralLocalization({
	name = "General Options"
})

L:SetTimerLocalization({
	TimerInvite = "%s"
})

L:SetOptionLocalization({
	ColorByClass	= "Set name color to class color in the score frame",
	ShowInviteTimer	= "Show battleground join timer",
	AutoSpirit		= "Auto-release spirit"
})

L:SetMiscLocalization({
	ArenaInvite	= "Arena invite"
})

--------------
--  Arenas  --
--------------
L = DBM:GetModLocalization("Arenas")

L:SetGeneralLocalization({
	name = "Arenas"
})

L:SetTimerLocalization({
	TimerStart	= "Game starts",
	TimerShadow	= "Shadow Sight"
})

L:SetOptionLocalization({
	TimerStart	= "Show start timer",
	TimerShadow = "Show timer for Shadow Sight"
})

L:SetMiscLocalization({
	Start60	= "One minute until the Arena battle begins!",
	Start30	= "Thirty seconds until the Arena battle begins!",
	Start15	= "Fifteen seconds until the Arena battle begins!"
})

----------------------
--  Alterac Valley  --
----------------------
L = DBM:GetModLocalization("AlteracValley")

L:SetGeneralLocalization({
	name = "Alterac Valley"
})

L:SetTimerLocalization({
	TimerStart	= "Game starts", 
	TimerTower	= "%s",
	TimerGY		= "%s"
})

L:SetMiscLocalization({
	BgStart60	= "1 minute until the battle for Alterac Valley begins.",
	BgStart30	= "30 seconds until the battle for Alterac Valley begins.",
	ZoneName	= "Alterac Valley"
})

L:SetOptionLocalization({
	TimerStart	= "Show start timer",
	TimerTower	= "Show tower capture timer",
	TimerGY		= "Show graveyard capture timer",
	AutoTurnIn	= "Automatically turn-in quests"
})

--------------------
--  Arathi Basin  --
--------------------
L = DBM:GetModLocalization("ArathiBasin")

L:SetGeneralLocalization({
	name = "Arathi Basin"
})

L:SetMiscLocalization({
	BgStart60	= "The Battle for Arathi Basin will begin in 1 minute.",
	BgStart30	= "The Battle for Arathi Basin will begin in 30 seconds.",
	ZoneName	= "Arathi Basin",
	ScoreExpr	= "(%d+)/1600",
	Alliance	= "Alliance",
	Horde		= "Horde",
	WinBarText	= "%s wins",
	BasesToWin	= "Bases to win: %d",
	Flag		= "Flag"
})

L:SetTimerLocalization({
	TimerStart	= "Game starts", 
	TimerCap	= "%s"
})

L:SetOptionLocalization({
	TimerStart				= "Show start timer",
	TimerWin				= "Show win timer",
	TimerCap				= "Show capture timer",
	ShowAbEstimatedPoints	= "Show estimated points on win/loss",
	ShowAbBasesToWin		= "Show bases required to win"
})

------------------------
--  Eye of the Storm  --
------------------------
L = DBM:GetModLocalization("EyeoftheStorm")

L:SetGeneralLocalization({
	name = "Eye of the Storm"
})

L:SetMiscLocalization({
	BgStart60		= "The battle begins in 1 minute!",
	BgStart30		= "The battle begins in 30 seconds!",
	ZoneName		= "Eye of the Storm",
	ScoreExpr		= "(%d+)/1600",
	Alliance 		= "Alliance",
	Horde 			= "Horde",
	WinBarText 		= "%s wins",
	FlagReset 		= "The flag has been reset!",
	FlagTaken 		= "(.+) has taken the flag!",
	FlagCaptured	= "The .+ ha%w+ captured the flag!",
	FlagDropped		= "The flag has been dropped!"

})

L:SetTimerLocalization({
	TimerStart	= "Game starts", 
	TimerFlag	= "Flag respawn"
})

L:SetOptionLocalization({
	TimerStart		= "Show start timer",
	TimerWin 		= "Show win timer",
	TimerFlag 		= "Show flag respawn timer",
	ShowPointFrame	= "Show flag carrier and estimated points"
})

---------------------
--  Warsong Gulch  --
---------------------
L = DBM:GetModLocalization("WarsongGulch")

L:SetGeneralLocalization({
	name = "Warsong Gulch"
})

L:SetMiscLocalization({
	BgStart60 			= "The battle for Warsong Gulch begins in 1 minute.",
	BgStart30 			= "The battle for Warsong Gulch begins in 30 seconds. Prepare yourselves!",
	ZoneName 			= "Warsong Gulch",
	Alliance 			= "Alliance",
	Horde 				= "Horde",	
	InfoErrorText		= "The flag carrier targeting function will be restored when you are out of combat.",
	ExprFlagPickUp		= "The (%w+) .lag was picked up by (.+)!",
	ExprFlagCaptured	= "(.+) captured the (%w+) flag!",
	ExprFlagReturn		= "The (%w+) .lag was returned to its base by (.+)!",
	FlagAlliance		= "Alliance Flag: ",
	FlagHorde			= "Horde Flag: ",
	FlagBase			= "Base"
})

L:SetTimerLocalization({
	TimerStart	= "Game starts", 
	TimerFlag	= "Flag respawn"
})

L:SetOptionLocalization({
	TimerStart					= "Show start timer",
	TimerFlag					= "Show flag respawn timer",
	ShowFlagCarrier				= "Show flag carrier",
	ShowFlagCarrierErrorNote	= "Show flag carrier error message while in combat"
})

------------------------
--  Isle of Conquest  --
------------------------
L = DBM:GetModLocalization("IsleofConquest")

L:SetGeneralLocalization({
	name = "Isle of Conquest"
})

L:SetWarningLocalization({
	WarnSiegeEngine		= "Siege Engine ready!",
	WarnSiegeEngineSoon	= "Siege Engine in ~10 sec"
})

L:SetTimerLocalization({
	TimerStart			= "Game starts", 
	TimerPOI			= "%s",
	TimerSiegeEngine	= "Siege Engine ready"
})

L:SetOptionLocalization({
	TimerStart			= "Show start timer", 
	TimerPOI			= "Show capture timer",
	TimerSiegeEngine	= "Show timer for Siege Engine construction",
	WarnSiegeEngine		= "Show warning when Siege Engine is ready",
	WarnSiegeEngineSoon	= "Show warning when Siege Engine is almost ready"
})

L:SetMiscLocalization({
	ZoneName				= "Isle of Conquest",
	BgStart60				= "The battle will begin in 60 seconds.",
	BgStart30				= "The battle will begin in 30 seconds.",
	BgStart15				= "The battle will begin in 15 seconds.",
	SiegeEngine				= "Siege Engine",
	GoblinStartAlliance		= "See those seaforium bombs? Use them on the gates while I repair the siege engine!",
	GoblinStartHorde		= "I'll work on the siege engine, just watch my back.  Use those seaforium bombs on the gates if you need them!",
	GoblinHalfwayAlliance	= "I'm halfway there! Keep the Horde away from here.  They don't teach fighting in engineering school!",
	GoblinHalfwayHorde		= "I'm about halfway done! Keep the Alliance away - fighting's not in my contract!",
	GoblinFinishedAlliance	= "My finest work so far! This siege engine is ready for action!",
	GoblinFinishedHorde		= "The siege engine is ready to roll!",
	GoblinBrokenAlliance	= "It's broken already?! No worries. It's nothing I can't fix.",
	GoblinBrokenHorde		= "It's broken again?! I'll fix it... just don't expect the warranty to cover this"
})

