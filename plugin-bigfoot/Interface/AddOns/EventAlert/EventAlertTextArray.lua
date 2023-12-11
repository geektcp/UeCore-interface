function EventAlert_LoadTextArray()


	if GetLocale() == "zhCN" then
		EA_TTIP_DOALERTSOUND = "事件触发时播放声音。";
		EA_TTIP_ALERTSOUNDSELECT = "选择事件触发时播放的声音。";
		EA_TTIP_LOCKFRAME = "锁定触发框体。";
		EA_TTIP_SHOWFRAME = "显示/隐藏事件时的提示框体。";
		EA_TTIP_SHOWNAME = "显示/隐藏事件时增益名称。";
		EA_TTIP_SHOWFLASH = "显示/隐藏全屏闪光。";
		EA_TTIP_SHOWTIMER = "显示/隐藏增益剩余时间。";
		EA_TTIP_CHANGETIMER = "修改剩余时间的提示位置和大小。";
		EA_TTIP_ICONSIZE = "修改提示图标的大小。";
		EA_TTIP_ALLOWESC = "切换用esc关闭提示（需要重载界面）。";
		EA_TTIP_ALTALERTS = "切换提示非增益事件。";

		EA_TTIP_ICONXOFFSET = "调整提示框体的水平间距";
		EA_TTIP_ICONYOFFSET = "调整提示框体的垂直间距";
	elseif GetLocale() == "zhTW" then
		EA_TTIP_DOALERTSOUND = "事件觸發時播放聲音。";
		EA_TTIP_ALERTSOUNDSELECT = "選擇事件觸發時播放的聲音。";
		EA_TTIP_LOCKFRAME = "鎖定觸發框體。";
		EA_TTIP_SHOWFRAME = "顯示/隱藏事件時的提示框體。";
		EA_TTIP_SHOWNAME = "顯示/隱藏事件時增益名稱。";
		EA_TTIP_SHOWFLASH = "顯示/隱藏全屏閃光。";
		EA_TTIP_SHOWTIMER = "顯示/隱藏增益剩餘時間。";
		EA_TTIP_CHANGETIMER = "修改剩餘時間的提示位置和大小。";
		EA_TTIP_ICONSIZE = "修改提示圖標的大小。";
		EA_TTIP_ALLOWESC = "切換用esc關閉提示（需要重載界面）。";
		EA_TTIP_ALTALERTS = "切換提示非增益事件。";

		EA_TTIP_ICONXOFFSET = "調整提示框體的水平間距";
		EA_TTIP_ICONYOFFSET = "調整提示框體的垂直間距";


	else
		EA_TTIP_DOALERTSOUND = "Play a sound when an event triggers.";
		EA_TTIP_ALERTSOUNDSELECT = "Choose which sound to play when an event triggers.";
		EA_TTIP_LOCKFRAME = "Locks the notification frame so it cannot be moved.";
		EA_TTIP_SHOWFRAME = "Toggle the showing/hiding of the notification frame on events.";
		EA_TTIP_SHOWNAME = "Toggle the showing/hiding of the buff's name on events.";
		EA_TTIP_SHOWFLASH = "Toggle the showing/hiding of the full screen flash on events.";
		EA_TTIP_SHOWTIMER = "Toggle the showing/hiding of the remaining buff time on events.";
		EA_TTIP_CHANGETIMER = "Changes the font and position of the remaining buff time.";
		EA_TTIP_ICONSIZE = "Change the size of the alert icon.";
		EA_TTIP_ALLOWESC = "Changes the ability to use the ESC key to close alert frames. (Note:  Requires a reload of the UI)";
		EA_TTIP_ALTALERTS = "Toggle the ability for EventAlert to alert on alternate non-buff events.";

		EA_TTIP_ICONXOFFSET = "Changes the horizontal spacing between notification frames.";
		EA_TTIP_ICONYOFFSET = "Changes the vertical spacing between notification frames.";



	end


	EA_CLASS_DK = "DEATHKNIGHT";
	EA_CLASS_DRUID = "DRUID";
	EA_CLASS_HUNTER = "HUNTER";
	EA_CLASS_MAGE = "MAGE";
	EA_CLASS_PALADIN = "PALADIN";
	EA_CLASS_PRIEST = "PRIEST";
	EA_CLASS_ROGUE = "ROGUE";
	EA_CLASS_SHAMAN = "SHAMAN";
	EA_CLASS_WARLOCK = "WARLOCK";
	EA_CLASS_WARRIOR = "WARRIOR";
	EA_CLASS_FUNKY = "FUNKY";
	EA_CLASS_OTHER = "OTHER";

end