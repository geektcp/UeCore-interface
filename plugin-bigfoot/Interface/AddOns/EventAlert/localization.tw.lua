if GetLocale() ~= "zhTW" then return end

EA_TTIP_DOALERTSOUND = "事件發生時播放聲音提示.";
EA_TTIP_ALERTSOUNDSELECT = "選擇事件發生時所播放的音效.";
EA_TTIP_LOCKFRAME = "鎖定/解锁 觸發框體.";
EA_TTIP_SHOWFRAME = "顯示/隱藏 提示框體.";
EA_TTIP_SHOWNAME = "顯示/隱藏 法術名稱.";
EA_TTIP_SHOWFLASH = "開啟/關閉 全螢幕閃爍.";
EA_TTIP_SHOWTIMER = "顯示/隱藏 法術剩餘時間.";
EA_TTIP_CHANGETIMER = "修改法術剩餘時間的提示位置和字體大小.";
EA_TTIP_ICONSIZE = "修改提示圖標的大小.";
EA_TTIP_ALLOWESC = "使用Esc關閉提示. (需重新載入UI)";
EA_TTIP_ALTALERTS = "切換提示額外類型的法術事件.";

EA_TTIP_ICONXOFFSET = "調整提示框體的水平間距.";
EA_TTIP_ICONYOFFSET = "調整提示框體的垂直間距.";
EA_TTIP_ICONREDDEBUFF = "調整自身Debuff圖標的紅色深度.";
EA_TTIP_ICONGREENDEBUFF = "調整目標Debuff圖標的綠色深度.";
EA_TTIP_TAR_ICONXOFFSET = "調整目標Debuff提示框體的水平間距";
EA_TTIP_TAR_ICONYOFFSET = "調整目標Debuff提示框體的垂直間距";
EA_TTIP_TARGET_MYDEBUFF = "調整目標Debuff提示框體是否僅顯示你自己的釋放的技能";

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
EA_CLASS_OTHER = "OTHER";

EA_SHOWSELF = "在聊天欄顯示/隱藏自己獲得的法術ID";
EA_SHOWTARGET = "在聊天欄顯示/隱藏目標獲得的減益法術ID";
EA_OPTIONS = "設置選項";
EA_OPTIONS_Primaries = "技能選擇";
EA_OPTIONS_Alternates = "額外技能選擇";
EA_OPTIONS_Others = "其他技能選擇";
EA_OPTIONS_Target = "目標技能選擇";
EA_XOPT_ICONPOSOPT = "圖標位置選項";
EA_XOPT_SHOW_ALTFRAME = "顯示提示框體";
EA_XOPT_SHOW_BUFFNAME = "顯示法術名稱";
EA_XOPT_SHOW_TIMER = "顯示倒數秒數";
EA_XOPT_SHOW_OMNICC = "顯示與于圖標中央";
EA_XOPT_SHOW_FULLFLASH = "顯示全螢幕閃爍提示";
EA_XOPT_PLAY_SOUNDALERT = "播放聲音提示";
EA_XOPT_ESC_CLOSEALERT = "ESC 關閉提示";
EA_XOPT_SHOW_ALTERALERT = "顯示額外提示";
EA_XOPT_SHOW_SHOWSELF = "查看自身法術ID";
EA_XOPT_SHOW_SHOWTARGET = "查看目標法術ID";
EA_XOPT_SHOW_CLASSALERT = "自身法術提示列表";
EA_XOPT_SHOW_OTHERALERT = "他人法術提示列表";
EA_XOPT_SHOW_TARGETALERT = "設置目標提示";
EA_XOPT_OKAY = "關閉";

EA_XICON_LOCKFRAME = "鎖定提示框體";
EA_XICON_LOCKFRAMETIP = "若要移動[提示框體]或點擊[重設框體位置]時，請先取消選中[鎖定提示框體]的對勾";
EA_XICON_ICONSIZE = "圖標大小";
EA_XICON_LARGE = "大";
EA_XICON_SMALL = "小";
EA_XICON_HORSPACE = "水平間距";
EA_XICON_VERSPACE = "垂直間距";
EA_XICON_MORE = "多";
EA_XICON_LESS = "少";
EA_XICON_REDDEBUFF = "自身Debuff圖標紅色深度";
EA_XICON_GREENDEBUFF = "目標Debuff圖標綠色深度";
EA_XICON_DEEP = "深";
EA_XICON_LIGHT = "淺";
EA_XICON_TOGGLE_ALERTFRAME = "顯示/隱藏 提示框體";
EA_XICON_RESET_FRAMEPOS = "重設框體位置";
EA_XICON_SELF_BUFF = "本身Buff";
EA_XICON_SELF_DEBUFF = "本身Debuff";
EA_XICON_TARGET_DEBUFF = "目標Debuff";

EX_XCLSALERT_SPELL = "法術ID:";
EX_XCLSALERT_ADDSPELL = "添加";
EX_XCLSALERT_DELSPELL = "刪除";

EA_XTARALERT_TARGET_MYDEBUFF = "僅限玩家施放的Debuff";

EA_XCMD_SELFLIST = " 顯示自身Buff/Debuff: ";
EA_XCMD_TARGETLIST = " 顯示目標Debuff: ";
EA_XCMD_AUTOADD_SELFLIST = " 自動新增自身法術: ";
EA_XCMD_ENVADD_SELFLIST = " 自動新增自身環境法術: ";
EA_XCMD_DEBUG_P1 = "法術";
EA_XCMD_DEBUG_P2 = "法術ID";
EA_XCMD_DEBUG_P3 = "堆疊";
EA_XCMD_DEBUG_P4 = "持續秒數";

EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlert\124r \124cff00FF00指令\124r說明(/eventalert or /ea):",
	["OPT"] = "\124cff00FF00/ea options(或opt)\124r - 顯示/隱藏 設定視窗.",
	["HELP"] = "\124cff00FF00/ea help\124r - 顯示進一步指令說明.",
	["SHOW"] = {
		"\124cff00FF00/ea show [sec]\124r -",
		"開啟/關閉 列出 >玩家< 身上所有 Buff/Debuff 的法術名稱及ID.(持續時間為 參數[sec] 秒之內的法術)",
	},
	["SHOWT"] = {
		"\124cff00FF00/ea showtarget(或showt) [sec]\124r -",
		"開啟/關閉 列出 >目標< 身上所有 Debuff 的法術名稱及ID.(持續時間為 參數[sec] 秒之內的法術)",
	},
	["SHOWA"] = {
		"\124cff00FF00/ea showautoadd(或showa) [sec]\124r -",
		"開啟/關閉 自動將 >玩家< 身上所有的法術加入 自身法術提示列表.(持續時間為 參數[sec] 秒之內的法術,[sec]默認為60秒)",
	},
}