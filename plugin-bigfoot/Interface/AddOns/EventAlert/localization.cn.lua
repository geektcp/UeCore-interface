if GetLocale() ~= "zhCN" then return end

EA_TTIP_DOALERTSOUND = "事件触发时播放声音提示.";
EA_TTIP_ALERTSOUNDSELECT = "选择事件触发时所播放的音效.";
EA_TTIP_LOCKFRAME = "锁定/解锁 技能提示图标.";
EA_TTIP_SHOWFRAME = "显示/隐藏 技能提示图标.";
EA_TTIP_SHOWNAME = "显示/隐藏 法术名称.";
EA_TTIP_SHOWFLASH = "开启/关闭 全屏闪烁.";
EA_TTIP_SHOWTIMER = "显示/隐藏 法术剩余时间.";
EA_TTIP_CHANGETIMER = "修改法术剩余时间的提示位置和字体大小.";
EA_TTIP_ICONSIZE = "修改技能提示图标的大小.";
EA_TTIP_ALLOWESC = "使用Esc关闭提示（需要重载界面）.";
EA_TTIP_ALTALERTS = "显示/隐藏 特殊法术提示图标.";

EA_TTIP_ICONXOFFSET = "调整技能提示图标的水平间距.";
EA_TTIP_ICONYOFFSET = "调整技能提示图标的垂直间距.";
EA_TTIP_ICONREDDEBUFF = "调整自身Debuff图标的红色深度.";
EA_TTIP_ICONGREENDEBUFF = "调整目标Debuff图标的绿色深度.";
EA_TTIP_TAR_ICONXOFFSET = "调整目标Debuff提示图标的水平间距.";
EA_TTIP_TAR_ICONYOFFSET = "调整目标Debuff提示图标的垂直间距.";
EA_TTIP_TARGET_MYDEBUFF = "设置目标Debuff提示图标是否仅显示你自己释放的技能.";

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

EA_SHOWSELF = "在聊天栏显示/隐藏自己获得的法术ID";
EA_SHOWTARGET = "在聊天栏显示/隐藏目标获得的减益法术ID";
EA_OPTIONS = "设置选项";
EA_OPTIONS_Primaries = "技能选择框体";
EA_OPTIONS_Alternates = "特殊法术选择框体";
EA_OPTIONS_Others = "其他技能选择框体";
EA_OPTIONS_Target = "目标技能选择框体";
EA_XOPT_ICONPOSOPT = "图标位置选项";
EA_XOPT_SHOW_ALTFRAME = "显示提示图标";
EA_XOPT_SHOW_BUFFNAME = "显示法术名称";
EA_XOPT_SHOW_TIMER = "显示剩余时间";
EA_XOPT_SHOW_OMNICC = "显示于图标中央";
EA_XOPT_SHOW_FULLFLASH = "全屏闪耀效果";
EA_XOPT_PLAY_SOUNDALERT = "播放声音提示";
EA_XOPT_ESC_CLOSEALERT = "ESC 关闭提示";
EA_XOPT_SHOW_ALTERALERT = "显示特殊法术提示图标";
EA_XOPT_SHOW_SHOWSELF = "查看自身法术ID";
EA_XOPT_SHOW_SHOWTARGET = "查看目标法术ID";
EA_XOPT_SHOW_CLASSALERT = "自身法术提示列表";
EA_XOPT_SHOW_OTHERALERT = "他人法术提示列表";
EA_XOPT_SHOW_TARGETALERT = "设置目标提示";
EA_XOPT_OKAY = "关闭";

EA_XICON_LOCKFRAME = "锁定提示图标";
EA_XICON_LOCKFRAMETIP = "若要移动[技能提示图标]或点击[重设图标位置]时，请先取消选中[锁定技能提示图标]的对勾";
EA_XICON_ICONSIZE = "图标大小";
EA_XICON_LARGE = "大";
EA_XICON_SMALL = "小";
EA_XICON_HORSPACE = "水平间距";
EA_XICON_VERSPACE = "垂直间距";
EA_XICON_MORE = "多";
EA_XICON_LESS = "少";
EA_XICON_REDDEBUFF = "自身Debuff图标红色深度";
EA_XICON_GREENDEBUFF = "目标Debuff图标绿色深度";
EA_XICON_DEEP = "深";
EA_XICON_LIGHT = "浅";
EA_XICON_TOGGLE_ALERTFRAME = "显示/隐藏 提示框体";
EA_XICON_RESET_FRAMEPOS = "重设框体位置";
EA_XICON_SELF_BUFF = "本身Buff";
EA_XICON_SELF_DEBUFF = "本身Debuff";
EA_XICON_TARGET_DEBUFF = "目标Debuff";

EX_XCLSALERT_SPELL = "法术ID:";
EX_XCLSALERT_ADDSPELL = "添加";
EX_XCLSALERT_DELSPELL = "删除";

EA_XTARALERT_TARGET_MYDEBUFF = "仅限玩家施放的Debuff";

EA_XCMD_SELFLIST = " 显示自身Buff/Debuff: ";
EA_XCMD_TARGETLIST = " 显示目标Debuff: ";
EA_XCMD_AUTOADD_SELFLIST = " 自动新增自身法术: ";
EA_XCMD_ENVADD_SELFLIST = " 自动新增自身环境法术: ";
EA_XCMD_DEBUG_P1 = "法术";
EA_XCMD_DEBUG_P2 = "法术ID";
EA_XCMD_DEBUG_P3 = "堆叠";
EA_XCMD_DEBUG_P4 = "持续秒数";

EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlert\124r \124cff00FF00指令\124r说明(/eventalert or /ea):",
	["OPT"] = "\124cff00FF00/ea options(或opt)\124r - 显示/隐藏 设置窗体.",
	["HELP"] = "\124cff00FF00/ea help\124r - 显示进一步指令说明.",
	["SHOW"] = {
		"\124cff00FF00/ea show [sec]\124r -",
		"开启/关闭 列出>玩家< 身上所有 Buff/Debuff 的法术名称及ID.(持续时间为 参数[sec] 秒之内的法术)",
	},
	["SHOWT"] = {
		"\124cff00FF00/ea showtarget(或showt) [sec]\124r -",
		"开启/关闭 列出 >目标< 身上所有 Debuff 的法术名称及ID.(持续时间为 参数[sec] 秒之内的法术)",
	},
	["SHOWA"] = {
		"\124cff00FF00/ea showautoadd(或showa) [sec]\124r -",
		"开始/停止 自动将 >玩家< 身上所有的法术加入 自身法术提示列表.(持续时间为 参数[sec] 秒之内的法术,[sec]默认为60秒)",
	},
}