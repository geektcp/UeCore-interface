--最后修訂日期：2011-05-06 by shines, 前一次修訂日期：2011-04-14 by 游云

if GetLocale() == "zhTW" then
	RaidAlerter_UIName				= "團隊報警系統";

	RAL_TEXT_BINDING_1				= "開關警報";
	RAL_TEXT_BINDING_2				= "選項";
	RAL_TEXT_BINDING_3				= "觀察";

	RaidAlerter_RAIDMODE = {
		[1]	= "10人團隊模式",
		[2]	= "15人團隊模式",
		[3]	= "20人團隊模式",
		[4]	= "25人團隊模式",
		[5]	= "30人團隊模式",
		[6]	= "35人團隊模式",
		[7]	= "40人團隊模式",
	};

	RaidAlerter_RAIDICON = {
		[1]	= "{星星}",		--★
		[2]	= "{圈圈}",		--●
		[3]	= "{鑽石}",		--◆
		[4]	= "{三角}",		--▼
		[5]	= "{月亮}",		--月
		[6]	= "{方形}",		--█
		[7]	= "{十字}",		--╳
		[8]	= "{頭顱}",		--骷
	};

	--各種精鍊藥劑Buff名稱文本（可局部匹配，但必須唯一）
	RaidAlerter_SuperFlask_TEXT = {
		--精鍊藥劑
--		"撒塔斯",
--		"泰坦",
--		"萃取智慧",
--		"超級能量",
--		"多重抗性",
--		"強襲",
--		"防禦",
--		"法力恢復",
--		"盲目之光",
--		"炫彩驚奇",
--		"純淨死亡",
		--WotLK精鍊藥劑
		"冰霜巨龍",
		"無盡怒火",
		"石血",
		"純淨魔精",
		"次級強健",
		"次級抗性精鍊",
		"北方精鍊",
	};

	--包含精鍊藥劑在內的各種強化藥劑Buff名稱文本（可局部匹配，但必須唯一）
	RaidAlerter_ForceFlask_TEXT = {
		--精鍊藥劑
--		"撒塔斯",
--		"泰坦",
		"萃取智慧",
--		"超級能量",
--		"多重抗性",
--		"強襲",
--		"防禦",
--		"法力恢復",
--		"盲目之光",
--		"炫彩驚奇",
--		"純淨死亡",
		--WotLK精鍊藥劑
		"冰霜巨龍",
		"無盡怒火",
		"石血",
		"純淨魔精",
		"次級強健",
		"次級抗性精鍊",
		"北方精鍊",
		--TBC藥劑
--		"鐵盾",
--		"猛擊",
--		"內行",
--		"極效力量",
--		"極效敏捷",
--		"極效防禦",
--		"魔化力量",
--		"治療能量",
--		"精通",
--		"極效冰霜之力",
--		"極效火燄之力",
--		"極效暗影之力",
--		"德萊尼智慧",
--		"極效魔血",
--		"強效秘法",
--		"貓鼬",
--		"極效堅韌",
		--WotLK藥劑
		"精準",
		"致命之擊",
		"強力防禦",
		"熟練",
		"穿甲",
		"電光速度",
		"強力思緒",
		"強力法師之血",
		"保護",
		"憤怒",
		"法術能量",
		"精神藥劑",
		"強力力量",
		"古拉的",
		"強力堅韌",
		"強力敏捷",
		--CTM新增
		"鬼靈藥劑",
		"納迦藥劑",
		"眼鏡蛇藥劑",
		"地核藥劑",
		"不可置信精準藥劑",
		"稜彩藥劑",
		"非凡疾速藥水",
		"精通藥劑",
	};

	--Boss清單默初始化為空，團隊中會自動更新BOSS列表以供血量通報使用。若需添加某些特定怪物，可參照下面的表格式在{}內加入準確名稱。
	RaidAlerter_Bosses = {};

	--定義不應被判定為Boss的特定怪物列表
	RaidAlerter_Bosses_EXC = {};
--[[舊數據備用
	RaidAlerter_Bosses_EXC = {
		"風暴要塞-熔爐保安官",	--波塔尼卡
		"黑翼龍獸",				--亞克崔茲
		"暮光龍獸",				--亞克崔茲
		"奈薩斯捕獵者",			--法力墓地
		"伊斯利縛法者",			--法力墓地
		"伊斯利巫者",			--法力墓地
		"塔倫米爾保衛者",		--希爾斯布萊德丘陵舊址
		"塔倫米爾監視者",		--希爾斯布萊德丘陵舊址
		"塔倫米爾守衛",			--希爾斯布萊德丘陵舊址
		"恆龍污染者",			--希爾斯布萊德丘陵舊址
		"恆龍破壞者",			--希爾斯布萊德丘陵舊址
		"恆龍殺戮者",			--希爾斯布萊德丘陵舊址
		"塞司克預言家",			--塞司克大廳
		"塞司克鷹爪領主",		--塞司克大廳
		"塞司克薩滿",			--塞司克大廳
		"時光流逝暗影法師",		--塞司克大廳
	};
]]
	RAL_TEXT_MINDMSG				= "團隊報警系統 Oldhand 製作。命令幫助：";
	RAL_TEXT_OUTTEAM				= "你不在一個隊伍中";
	RAL_TEXT_OUTRAID				= "你不在一個團隊中";
	RAL_TEXT_SYNC_SELECT_FINISH		= "報警發送方自動選擇為：";
	RAL_TEXT_SYNC_SELECT_NONE		= "** 無 **";
	RAL_TEXT_SYNC_START_CHECK		= "開始檢查RaidAlerter版本...";
	RAL_TEXT_SYNC_END_CHECK			= "** 共檢測到%s人 **";
	RAL_TEXT_ICON_CLEAR				= "臨時團隊標記已清除";
	RAL_TEXT_NUL					= "N/A";
	RAL_TEXT_ON						= "開啟";
	RAL_TEXT_ON_SIMPLE				= "開";
	RAL_TEXT_OFF					= "關閉";
	RAL_TEXT_OFF_SIMPLE				= "關";
	RAL_TEXT_ETC					= "等.";
	RAL_TEXT_YOU					= "你";
	RAL_TEXT_I						= "我";
	RAL_TEXT_SEC					= "秒";
	RAL_TEXT_MIN					= "分";
	RAL_TEXT_HOUR					= "時";
	RAL_TEXT_ARROW_L				= "←";
	RAL_TEXT_ARROW_R				= "→";
	RAL_TEXT_LOOT_FREE_FOR_ALL		= "自由拾取";
	RAL_TEXT_LOOT_ROUND_ROBIN		= "輪流拾取";
	RAL_TEXT_LOOT_MASTER_LOOTER		= "隊長分配";
	RAL_TEXT_LOOT_GROUP_LOOT		= "隊伍分配";
	RAL_TEXT_LOOT_NEED_BEFORE_GREED	= "需求優先";

	RAL_TEXT_DRUID					= "德魯伊";
	RAL_TEXT_HUNTER					= "獵人";
	RAL_TEXT_MAGE					= "法師";
	RAL_TEXT_PRIEST					= "牧師";
	RAL_TEXT_ROGUE					= "盜賊";
	RAL_TEXT_WARLOCK				= "術士";
	RAL_TEXT_WARRIOR				= "戰士";
	RAL_TEXT_SHAMAN					= "薩滿";
	RAL_TEXT_PALADIN				= "聖騎士";
	RAL_TEXT_DEATHKNIGHT			= "死亡騎士";

	RAL_TEXT_ZONE_1					= "黑翼之巢";
	RAL_TEXT_ZONE_2					= "安其拉";
	RAL_TEXT_ZONE_3					= "扭曲太空";
	RAL_TEXT_ZONE_4					= "虛空風暴";
	RAL_TEXT_ZONE_5					= "冬握湖";

	RAL_TEXT_CPUMSG_1				= "設置完成！重載界面後即可生效。";
	RAL_TEXT_CPUMSG_2				= "立即重載界面";
	RAL_TEXT_CPUMSG_3				= "以後再說";

	RAL_TEXT_UINTNAME_1				= "其拉甲蟲";
	RAL_TEXT_UINTNAME_2				= "其拉蠍蟲";
	RAL_TEXT_UINTNAME_3				= "奧妮克希亞";

	RAL_TEXT_FRAME_ON				= "開";
	RAL_TEXT_FRAME_OFF				= "關";
	RAL_TEXT_FRAME_1				= "(%s)不在團隊中";
	RAL_TEXT_FRAME_2				= "(%s)%s人隊(%s:%s)";
	RAL_TEXT_FRAME_3				= "(%s)(MP總%s%%)(治療%s%%)(死%s)";
	RAL_TEXT_FRAME_4				= "(%s)%s人團(%s:%s)";

	RAL_TEXT_TIP_1					= "當前戰鬥用時";
	RAL_TEXT_TIP_2					= "本次戰鬥用時";
	RAL_TEXT_TIP_3					= "上次戰鬥用時";
	RAL_TEXT_TIP_4					= "%s秒";
	RAL_TEXT_TIP_5					= "%s分%s秒";
	RAL_TEXT_TIP_6					= "靈魂石已保存%s人";
	RAL_TEXT_TIP_7					= "團隊狀態條操作";
	RAL_TEXT_TIP_8					= "左鍵";
	RAL_TEXT_TIP_9					= "右鍵";
	RAL_TEXT_TIP_10					= "右鍵拖動";
	RAL_TEXT_TIP_11					= "Ctrl";
	RAL_TEXT_TIP_12					= "Alt";
	RAL_TEXT_TIP_13					= "Shift";
	RAL_TEXT_TIP_14					= "開關警報";
	RAL_TEXT_TIP_15					= "選項菜單";
	RAL_TEXT_TIP_16					= "調整團隊狀態條位置";
	RAL_TEXT_TIP_17					= "公佈到位檢查結果";
	RAL_TEXT_TIP_18					= "公佈精煉藥劑檢查結果";
	RAL_TEXT_TIP_19					= "進行MT目標鎖定檢查";
	RAL_TEXT_TIP_20					= "公佈增強藥劑檢查結果";
	RAL_TEXT_TIP_21					= "檢查Buff";
	RAL_TEXT_TIP_22					= "立即清理插件記憶體";
	RAL_TEXT_TIP_23					= "血量危急自動喊話開關";
	RAL_TEXT_TIP_24					= "按住Ctrl鍵移到狀態條上顯示幫助";
	RAL_TEXT_TIP_25					= "系統資源佔用";
	RAL_TEXT_TIP_26					= "記憶體";
	RAL_TEXT_TIP_27					= "CPU";
	RAL_TEXT_TIP_28					= "秒";
	RAL_TEXT_TIP_29					= "分";
	RAL_TEXT_TIP_30					= "5人";
	RAL_TEXT_TIP_31					= "10人";
	RAL_TEXT_TIP_32					= "25人";
	RAL_TEXT_TIP_33					= "普通";
	RAL_TEXT_TIP_34					= "英雄";
	RAL_TEXT_TIP_35					= "難度";
	RAL_TEXT_TIP_36					= "%s人%s";
	RAL_TEXT_TIP_37					= "動態";

	RAL_TEXT_CMD_1					= "命令";
	RAL_TEXT_CMD_2					= "或";
	RAL_TEXT_CMD_3					= "顯示設置菜單";
	RAL_TEXT_CMD_4					= "顯示此幫助訊息";
	RAL_TEXT_CMD_5					= "開關報警(預設開啟)";
	RAL_TEXT_CMD_6					= "組隊(非團隊)模塊開關";
	RAL_TEXT_CMD_7					= "OT報警開關(預設關閉)";
	RAL_TEXT_CMD_8					= "OT密語通知開關(預設關閉)";
	RAL_TEXT_CMD_9					= "開關OT密語的本機顯示(預設關閉，隱藏顯示)";
	RAL_TEXT_CMD_10					= "開關獵人標記和誤導提示(預設開啟)";
	RAL_TEXT_CMD_11					= "團隊狀態條顯示開關(預設開啟)";
	RAL_TEXT_CMD_12					= "將團隊狀態條位置重置於屏幕中間";
	RAL_TEXT_CMD_13					= "檢查團隊成員是否到位";
	RAL_TEXT_CMD_14					= "檢查團隊成員PvP狀態";
	RAL_TEXT_CMD_15					= "檢查團隊的靈魂石綁定狀態";
	RAL_TEXT_CMD_16					= "精煉藥劑檢查";
	RAL_TEXT_CMD_17					= "職業名稱";
	RAL_TEXT_CMD_18					= "職業當前選定目標檢查（省略職業名稱時預設為MT目標檢查）。例如/ral tc 法師 或/ral tc FS";
	RAL_TEXT_CMD_19					= "開關玩家生命危急自動喊話功能。預設界限30%，用“/ral myhp 數值”可更改";
	RAL_TEXT_CMD_20					= "開關狀態條懸停提示的系統資源佔用顯示（預設關閉）";
	RAL_TEXT_CMD_21					= "開啟系統資源佔用提示中的CPU性能顯示。開啟此功能可能會稍微降低系統性能。";
	RAL_TEXT_CMD_22					= "重載界面後生效。";
	RAL_TEXT_CMD_23					= "關閉系統資源佔用提示中的CPU性能顯示";
	RAL_TEXT_CMD_24					= "立即強制執行垃圾記憶體回收";
	RAL_TEXT_CMD_25					= "重置RaidAlerter所有設定到預設狀態";
	RAL_TEXT_CMD_26					= "顯示RaidAlerter當前狀態";
	RAL_TEXT_CMD_27					= "命令無效！鍵入/ral help查看幫助";

	RAL_TEXT_FUNC_1					= "報警";
	RAL_TEXT_FUNC_2					= "組隊(非團隊)模塊";
	RAL_TEXT_FUNC_3					= "僅在本地訊息頻道顯示警報";
	RAL_TEXT_FUNC_4					= "僅在本地屏幕顯示警報";
	RAL_TEXT_FUNC_5					= "Boss戰通報最後一擊";
	RAL_TEXT_FUNC_6					= "MT血量報警";
	RAL_TEXT_FUNC_7					= "MT血量危急上限設置為%s%%";
	RAL_TEXT_FUNC_8					= "MT陣亡報警";
--	RAL_TEXT_FUNC_9					= "通報戰士的盾牆技能";
--	RAL_TEXT_FUNC_10				= "通報戰士的破釜沉舟技能";
	RAL_TEXT_FUNC_11				= "通報戰士的法術反射技能";
	RAL_TEXT_FUNC_12				= "MT嘲諷抵抗報警";
	RAL_TEXT_FUNC_13				= "驅散技能抵抗報警";
	RAL_TEXT_FUNC_14				= "變形技能抵抗報警";
	RAL_TEXT_FUNC_15				= "法術反制技能抵抗報警";
	RAL_TEXT_FUNC_16				= "法術竊取技能抵抗報警";
	RAL_TEXT_FUNC_17				= "獵人寧神射擊通報";
	RAL_TEXT_FUNC_18				= "獵人標記提示";
	RAL_TEXT_FUNC_19				= "獵人誤導提示";
	RAL_TEXT_FUNC_20				= "被控制警報";
	RAL_TEXT_FUNC_21				= "解除控制警報";
	RAL_TEXT_FUNC_22				= "打破控制警報";
	RAL_TEXT_FUNC_23				= "靈魂石綁定通報";
	RAL_TEXT_FUNC_24				= "戰鬥結束後的陣亡通報";
	RAL_TEXT_FUNC_25				= "TAQ雙子戰AOE引怪通報";
	RAL_TEXT_FUNC_26				= "Boss血量報警";
	RAL_TEXT_FUNC_27				= "逐一通報上限設置為%s%%";
	RAL_TEXT_FUNC_28				= "團隊狀態條";
	RAL_TEXT_FUNC_29				= "OT報警";
	RAL_TEXT_FUNC_30				= "OT密語通知";
	RAL_TEXT_FUNC_31				= "顯示發送的OT密語";
	RAL_TEXT_FUNC_32				= "(NEF)墮落治療警報";
	RAL_TEXT_FUNC_33				= "(NEF)狂野變形警報";
	RAL_TEXT_FUNC_34				= "魔法驅散通報";
	RAL_TEXT_FUNC_35				= "法術竊取通報";
	RAL_TEXT_FUNC_36				= "魔法打斷通報";
	RAL_TEXT_FUNC_37				= "神聖干涉通報";
	RAL_TEXT_FUNC_38				= "團隊報警發送";
	RAL_TEXT_FUNC_39				= "強制開啟";
	RAL_TEXT_FUNC_40				= "優先本地顯示";
	RAL_TEXT_FUNC_41				= "預設：自動選擇（推薦）";
	RAL_TEXT_FUNC_42				= "玩家生命危急自動喊話%s（界限=%s%%）";
	RAL_TEXT_FUNC_43				= "狀態條已重置；縮放比例%s";
	RAL_TEXT_FUNC_44				= "系統資源佔用提示";
	RAL_TEXT_FUNC_45				= "狀態條懸停提示的CPU性能顯示";
	RAL_TEXT_FUNC_46				= "插件記憶體清理優化完畢";
	RAL_TEXT_FUNC_47				= "記憶體清理界限已設置為%sK";
	RAL_TEXT_FUNC_48				= "已重置為預設設定";
	RAL_TEXT_FUNC_49				= "當前狀態";
	RAL_TEXT_FUNC_50				= "版本";
	RAL_TEXT_FUNC_51				= "記憶體佔用";
	RAL_TEXT_FUNC_52				= "團隊模式：%s人";
	RAL_TEXT_FUNC_53				= "已設定為%s人團隊模式";

	RAL_TEXT_CHECK_1				= "到位檢查";
	RAL_TEXT_CHECK_2				= "%s人全部到位";
	RAL_TEXT_CHECK_3				= "已到位%s人";
	RAL_TEXT_CHECK_4				= "%s人離線";
	RAL_TEXT_CHECK_5				= "%s人死亡";
	RAL_TEXT_CHECK_6				= "%s人過遠";
	RAL_TEXT_CHECK_7				= "PvP檢查";
	RAL_TEXT_CHECK_8				= "%s人已開PvP";
	RAL_TEXT_CHECK_9				= "無人開PvP";
	RAL_TEXT_CHECK_10				= "%s人未開PvP";
	RAL_TEXT_CHECK_11				= "所有人均已開PvP";
	RAL_TEXT_CHECK_12				= "精煉藥劑";
	RAL_TEXT_CHECK_13				= "增強藥劑";
	RAL_TEXT_CHECK_14				= "檢查";
	RAL_TEXT_CHECK_15				= "%s人已有%s效果";
	RAL_TEXT_CHECK_16				= "無人有%s效果";
	RAL_TEXT_CHECK_17				= "%s人無%s效果";
	RAL_TEXT_CHECK_18				= "所有人均已有%s效果";
	RAL_TEXT_CHECK_19				= "Buff檢查：常規Buff已齊全！";
	RAL_TEXT_CHECK_20				= "Buff檢查：%s缺少！";
	RAL_TEXT_CHECK_21				= "*全無*";
	RAL_TEXT_CHECK_22				= "%s隊(%s)";
	RAL_TEXT_CHECK_23				= "真言術韌";		--僅用於Buff檢查消息標題
	RAL_TEXT_CHECK_24				= "未檢測到團隊的MT設定！";
	RAL_TEXT_CHECK_25				= "未檢測到團隊領袖或助理權限，警報只能在本機顯示";
	RAL_TEXT_CHECK_26				= "檢測到團隊助手已設定%sMT";
	RAL_TEXT_CHECK_27				= "檢測警報發送權限OK！（團隊領袖L或助理A）";
	RAL_TEXT_CHECK_28				= "**%s目標鎖定檢查**";
	RAL_TEXT_CHECK_29				= "**檢查結束**";
	RAL_TEXT_CHECK_30				= "%s "..RAL_TEXT_ARROW_R.." %s%s";		--目標鎖定檢查通報格式：玩家名字 "..RAL_TEXT_ARROW_R.." (標記符號)目標名稱
	RAL_TEXT_CHECK_31				= "未選定目標！";
	RAL_TEXT_CHECK_32				= "未知的職業名稱：%s";
	RAL_TEXT_CHECK_33				= "%s人未選定敵對目標：";
	RAL_TEXT_CHECK_34				= "%s人選定了相同標記：";
	RAL_TEXT_CHECK_35				= "所有人均已有.";
	RAL_TEXT_CHECK_36				= "(%s)人已有, (%s)人尚無.";
	RAL_TEXT_CHECK_37				= "(共%s人無)";

	RAL_TEXT_ALERT_1				= "**[仇恨!]%s"..RAL_TEXT_ARROW_R.."%s**";
--	RAL_TEXT_ALERT_2				= "[%s]仇恨==>你!!!";
	RAL_TEXT_ALERT_3				= "%s的仇恨目標是你! 小心!!";
	RAL_TEXT_ALERT_4				= "**%s(%s)的生命危急(%s%%)！**";
	RAL_TEXT_ALERT_5				= "**%s(%s)已經死亡！**";
	RAL_TEXT_ALERT_6				= "光榮的...戰死...";
	RAL_TEXT_ALERT_7				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."被控制了！**";
	RAL_TEXT_ALERT_8				= "**注意解除"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的變形狀態！**";
	RAL_TEXT_ALERT_9				= "**戰鬥結束！用時%s秒**";
	RAL_TEXT_ALERT_10				= "**戰鬥結束！用時%s分%s秒**";
	RAL_TEXT_ALERT_11				= "%s最先進入戰鬥狀態(僅供參考)";
	RAL_TEXT_ALERT_12				= "本次戰鬥死亡(%s)人";
	RAL_TEXT_ALERT_13				= "靈魂石已保存(%s)人";
	RAL_TEXT_ALERT_14				= "團隊MP(%s%%)";
	RAL_TEXT_ALERT_15				= "治療MP(%s%%)";
--	RAL_TEXT_ALERT_16				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已開啟盾牆！注意治療！**";
--	RAL_TEXT_ALERT_17				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已開啟破釜沉舟！注意治療！**";
	RAL_TEXT_ALERT_16				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."已施放%s！注意治療！**";
	RAL_TEXT_ALERT_18				= "**靈魂石已綁定"..RAL_TEXT_ARROW_R.."%s**";
	RAL_TEXT_ALERT_19				= "**%s對"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."施放了誤導**";
	RAL_TEXT_ALERT_20				= "**%s對"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."施放了寧神射擊**";
	RAL_TEXT_ALERT_21				= "**%s標記了"..RAL_TEXT_ARROW_R.."%s！**";
	RAL_TEXT_ALERT_22				= "**已啟動神聖干涉：%s"..RAL_TEXT_ARROW_R.."%s！**";
	RAL_TEXT_ALERT_23				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."把%s變形了！注意解除！**";
	RAL_TEXT_ALERT_24				= "羊";		--控制技能的簡寫
	RAL_TEXT_ALERT_25				= "鎖";		--控制技能的簡寫
	RAL_TEXT_ALERT_26				= "睡";		--控制技能的簡寫
	RAL_TEXT_ALERT_27				= "冰";		--控制技能的簡寫
	RAL_TEXT_ALERT_28				= "**[開%s] %s%s"..RAL_TEXT_ARROW_R.."%s（%s）**";		--打破控制
	RAL_TEXT_ALERT_29				= "**%s驅散了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_30				= "**%s成功竊取了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_31				= "**%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."被%s抵抗了！**";
	RAL_TEXT_ALERT_32				= "**%s免疫了%s的"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_33				= "**[反射] %s"..RAL_TEXT_ARROW_R.."%s（%s）**";
	RAL_TEXT_ALERT_34				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."打斷了%s的%s！**";
	RAL_TEXT_ALERT_35				= "**對%s進行最後一擊的是"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_36				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的%s(AOE)擊中了%s！**";
	RAL_TEXT_ALERT_37				= "**"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."的墮落治療正在使%s受到DOT傷害！累計已受到至少%s點墮落治療傷害（暗影）**";
	RAL_TEXT_ALERT_38				= "生命危急[%s%%]！%s隊<%s>請求治療!!";
	RAL_TEXT_ALERT_39				= "**%s施放了"..RAL_TEXT_ARROW_R.."%s"..RAL_TEXT_ARROW_L.."！**";
	RAL_TEXT_ALERT_40				= "你對%s的仇恨過高! 小心OT!";
	RAL_TEXT_ALERT_41				= "**[高仇恨]%s（%s）**";
	RAL_TEXT_ALERT_42				= "你可能需要啟用「正義之怒」Buff!";
	RAL_TEXT_ALERT_43				= "無正義之怒";
	RAL_TEXT_ALERT_44				= "**[%s]%s"..RAL_TEXT_ARROW_R.."%s**";
	RAL_TEXT_ALERT_45				= "你可能需要啟用「心靈之火」Buff!";
	RAL_TEXT_ALERT_46				= "無心靈之火";
	RAL_TEXT_ALERT_47				= "你尚無充分進食Buff，可能需要坐下來吃魚!";
	RAL_TEXT_ALERT_48				= "無充分進食";

	RAL_TEXT_THREAT_INFO_01			= "*獲得仇恨*";
	RAL_TEXT_THREAT_INFO_02			= "*仇恨消退*";
	RAL_TEXT_THREAT_INFO_03			= "*目標"..RAL_TEXT_ARROW_R.."%s*";
	RAL_TEXT_THREAT_INFO_04			= "*高仇恨*";
	RAL_TEXT_THREAT_INFO_05			= "*焦點"..RAL_TEXT_ARROW_R.."%s*";

	--用SPELL_CREATE判定：各种召唤团队物件的法术名称文本（MATCH：0局部匹配，1完全匹配）
	RAL_TEXT_RAIDSPELL_1 = {
		{["TEXT"]="鮮魚宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="炙烤龍肉盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="哥布林燒烤盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="海鮮珍饈盛宴",["MATCH"]=1,["TYPE"]="COOKFOOD",["DUR"]=180,},
		{["TEXT"]="防護大鍋",["MATCH"]=0,["TYPE"]="ELIXIR",["DUR"]=180,},				--各種防護大鍋
		{["TEXT"]="戰鬥大鍋",["MATCH"]=0,["TYPE"]="ELIXIR",["DUR"]=180,},				--戰鬥大鍋, 加大的戰鬥大鍋
		{["TEXT"]="傳送門:",["MATCH"]=0,["TYPE"]="TRANS",["DUR"]=60,},				--各种传送门
	};
	--用SPELL_CAST_SUCCESS判定：各种召唤团队物件的法术名称文本（MATCH：0局部匹配，1完全匹配）
	RAL_TEXT_RAIDSPELL_2 = {
		{["TEXT"]="餐點儀式",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="召喚儀式",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="靈魂儀式",["MATCH"]=1,["TYPE"]="SPELL",["DUR"]=0,},
		{["TEXT"]="吉福斯",["MATCH"]=1,["TYPE"]="REPAIR",["DUR"]=600,},
		{["TEXT"]="廢料機器人",["MATCH"]=1,["TYPE"]="REPAIR",["DUR"]=300,},
		{["TEXT"]="修理機器人",["MATCH"]=0,["TYPE"]="REPAIR",["DUR"]=600,},			--修理機器人74A型, 修理機器人110G型
	};

	RAL_TEXT_SPELL_1				= "盾牆";
	RAL_TEXT_SPELL_2				= "破釜沉舟";
	RAL_TEXT_SPELL_3				= "靈魂石復活";
	RAL_TEXT_SPELL_4				= "誤導";
	RAL_TEXT_SPELL_4_SPEC_1			= "偷天換日";
	RAL_TEXT_SPELL_5				= "寧神射擊";
	RAL_TEXT_SPELL_6				= "獵人印記";
	RAL_TEXT_SPELL_7				= "神聖干涉";
	RAL_TEXT_SPELL_8				= "狂野變形";
	RAL_TEXT_SPELL_9				= "變形術";
	RAL_TEXT_SPELL_10				= "束縛不死生物";
	RAL_TEXT_SPELL_11				= "休眠";
	RAL_TEXT_SPELL_12				= "冰凍陷阱";
	RAL_TEXT_SPELL_13				= "驅散魔法";
	RAL_TEXT_SPELL_14				= "淨化術";
	RAL_TEXT_SPELL_15				= "盾牌猛擊";
	RAL_TEXT_SPELL_16				= "法術竊取";
	RAL_TEXT_SPELL_17				= "嘲諷";
	RAL_TEXT_SPELL_18				= "低吼";
	RAL_TEXT_SPELL_19				= "正義防禦";
	RAL_TEXT_SPELL_20				= "精神控制";
	RAL_TEXT_SPELL_21				= "法術反制";
	RAL_TEXT_SPELL_22				= "劍刃亂舞";
	RAL_TEXT_SPELL_23				= "多重射擊";
	RAL_TEXT_SPELL_24				= "亂射";
	RAL_TEXT_SPELL_25				= "順劈斬";
	RAL_TEXT_SPELL_26				= "旋風斬";
	RAL_TEXT_SPELL_27				= "雷霆一擊";
	RAL_TEXT_SPELL_28				= "墮落治療";
	RAL_TEXT_SPELL_29				= "攻擊";
	RAL_TEXT_SPELL_30				= "聖佑術";		--3.05新增，QS的“盾牆”
	RAL_TEXT_SPELL_31				= "求生本能";	--3.05新增，XD的“破釜沉舟”
	RAL_TEXT_SPELL_32				= "黑暗敕令";	--WLK DK嘲諷技能
	RAL_TEXT_SPELL_33				= "冰錮堅韌";	--WLK DK盾墻技能
	RAL_TEXT_SPELL_34				= "反魔法護罩";	--WLK DK自身減魔法傷害技能
	RAL_TEXT_SPELL_35				= "反魔法力場";	--WLK DK減團隊魔法傷害技能
	RAL_TEXT_SPELL_36				= "血族之裔";	--WLK DK破釜技能
	RAL_TEXT_SPELL_37				= "魔法凝聚";

	RAL_TEXT_BUFF_1					= "靈魂石復活";
	RAL_TEXT_BUFF_2					= "獵人印記";
	RAL_TEXT_BUFF_3					= "巨熊形態";
	RAL_TEXT_BUFF_4					= "堅韌禱言";
	RAL_TEXT_BUFF_5					= "真言術:韌";
	RAL_TEXT_BUFF_6					= "秘法光輝";
	RAL_TEXT_BUFF_7					= "秘法智力";
	RAL_TEXT_BUFF_7_SPEC_1			= "基魯的勝利之歌";		--2.4.3太陽之井高地“基魯的勝利之歌”Buff狀態下不能追加智力buff
	RAL_TEXT_BUFF_7_SPEC_2			= "達拉然光輝";			--WLK 達拉然光輝狀態下不能追加智力buff
	RAL_TEXT_BUFF_8					= "野性賜福";
	RAL_TEXT_BUFF_9					= "野性印記";
	RAL_TEXT_BUFF_10				= "變形";		--中了變形魔法的DEBUFF名稱，為簡化判定只做局部匹配
	RAL_TEXT_BUFF_11				= "妖術";		--中了變形魔法的DEBUFF名稱，為簡化判定只做局部匹配
	RAL_TEXT_BUFF_12				= "王者祝福";
	RAL_TEXT_BUFF_13				= "強效王者祝福";
	RAL_TEXT_BUFF_13_SPEC_1			= "遺忘諸王祝福"	----WLK制皮鼓Buff
	RAL_TEXT_BUFF_14				= "庇護祝福";
	RAL_TEXT_BUFF_15				= "強效庇護祝福";
	RAL_TEXT_BUFF_16				= "智慧祝福";
	RAL_TEXT_BUFF_17				= "強效智慧祝福";
	RAL_TEXT_BUFF_17_SPEC_1			= "法力之泉";
	RAL_TEXT_BUFF_18				= "力量祝福";
	RAL_TEXT_BUFF_19				= "強效力量祝福";
	RAL_TEXT_BUFF_19_SPEC_1			= "戰鬥怒吼";
	RAL_TEXT_BUFF_20				= "獵豹形態";
	RAL_TEXT_BUFF_21				= "正義之怒";
	RAL_TEXT_BUFF_22				= "精神禱言";
	RAL_TEXT_BUFF_23				= "神聖精神";
	RAL_TEXT_BUFF_24				= "充分進食";
	RAL_TEXT_BUFF_25				= "心靈之火";
	RAL_TEXT_BUFF_26				= "梟獸形態";
	RAL_TEXT_BUFF_27				= "生命之樹";

	RAL_TEXT_MARCO_1				= "巨集語法簡介：";
	RAL_TEXT_MARCO_2				= "舉例：";
	RAL_TEXT_MARCO_3				= "/run RAL.MSG(\"訊息內容\"[,重複次數[,\"頻道(s\||y\||p\||ra\||rw)\"[,防刷屏延時(單位秒)[,\"訊息標識\"]]]])";
	RAL_TEXT_MARCO_4				= "/run RAL.MSG(\"正在對%t施放變羊！\",2)|r - 通知變羊(若省略頻道參數則預設為say說，白字)，重複兩次，短時間內(預設3s)狂按巨集也只會發出一次訊息";
	RAL_TEXT_MARCO_5				= "/run RAL.W(\"M語內容\"[,重複次數[,\"玩家名稱\"[,防刷屏延時(單位秒)[,\"訊息標識\"]]]])";
	RAL_TEXT_MARCO_6				= "/run RAL.W(\"速度過來集中!!!\",3)|r - M語已選定的目標玩家，重複三次，短時間內(預設3s)狂按巨集也只會發出一次訊息";

	RAL_TEXT_XML_1					= "檢查到位";
	RAL_TEXT_XML_2					= "檢查團隊成員是否已到場";
	RAL_TEXT_XML_3					= "檢查Buff";
	RAL_TEXT_XML_4					= "檢查團隊的常規增益效果";
	RAL_TEXT_XML_5					= "包括：\n全團耐力、智力和野性\n全團王者（聖騎≥1人）\n法系智慧、近戰力量（聖騎≥2人）\n全團庇護（聖騎≥3人）\n充分進食（已放置團隊烹飪食物時）";
	RAL_TEXT_XML_6					= "檢查靈魂石";
	RAL_TEXT_XML_7					= "檢查靈魂石是否已有綁定";
	RAL_TEXT_XML_8					= "檢查MT目標";
	RAL_TEXT_XML_9					= "檢查MT鎖定的目標";
	RAL_TEXT_XML_10					= "可用於開怪前的檢查";
	RAL_TEXT_XML_11					= "需預先設定團隊MT：|r選中目標用命令|cFF00FF00/MT|r設定（|cFF00FF00/CLEARMT|r取消）；或者用oRA插件設置。";
	RAL_TEXT_XML_12					= "檢查精煉藥劑";
	RAL_TEXT_XML_13					= "檢查團隊的精煉藥劑狀態";
	RAL_TEXT_XML_14					= "包括各種常用精煉藥劑";
	RAL_TEXT_XML_15					= "檢查增強藥劑";
	RAL_TEXT_XML_16					= "檢查團隊的增強藥劑狀態";
	RAL_TEXT_XML_17					= "各種常用的戰鬥和守護藥劑\n同時也包括精煉藥劑";
	RAL_TEXT_XML_18					= "檢查PvP";
	RAL_TEXT_XML_19					= "檢查團隊的PvP狀態";
	RAL_TEXT_XML_20					= "檢查法師目標";
	RAL_TEXT_XML_21					= "檢查法師鎖定的目標";
	RAL_TEXT_XML_22					= "可用於變羊開怪前的檢查";
	RAL_TEXT_XML_23					= "啟用";
	RAL_TEXT_XML_24					= "開啟團隊警報";
	RAL_TEXT_XML_25					= "需要團長L或者助理A權限\n否則只在本機顯示";
	RAL_TEXT_XML_26					= "5人小隊";
	RAL_TEXT_XML_27					= "5人小隊（非團隊）狀態也啟用報警";
	RAL_TEXT_XML_28					= "此功能無需隊長權限";
	RAL_TEXT_XML_29					= "僅本機";
	RAL_TEXT_XML_30					= "僅在本機訊息頻道顯示警報";
	RAL_TEXT_XML_31					= "勾選此項將不再發送團隊警報\n包括各種檢查結果";
	RAL_TEXT_XML_32					= "僅本屏";
	RAL_TEXT_XML_33					= "僅在本機屏幕顯示警報";
	RAL_TEXT_XML_34					= "記憶體清理   ";
	RAL_TEXT_XML_35					= "界限";
	RAL_TEXT_XML_36					= "狀態條";
	RAL_TEXT_XML_37					= "團隊狀態條";
	RAL_TEXT_XML_38					= "實時顯示團隊法力、治療法力和死亡人數";
	RAL_TEXT_XML_39					= "縮放比例";
	RAL_TEXT_XML_40					= "重置";
	RAL_TEXT_XML_41					= "重置團隊狀態條位置和大小";
	RAL_TEXT_XML_42					= "Boss血量";
	RAL_TEXT_XML_43					= "通報Boss血量";
	RAL_TEXT_XML_44					= "每10%通報一次Boss血量\n低於設定上限則開始逐一通報";
	RAL_TEXT_XML_45					= "注：5人小隊為20%間隔，逐一上限固定5%";
	RAL_TEXT_XML_46					= "通報上限";
	RAL_TEXT_XML_47					= "最後一擊";
	RAL_TEXT_XML_48					= "Boss戰通報是誰進行了最後一擊";
	RAL_TEXT_XML_49					= "需捕捉PARTY_KILL事件\n不一定每次擊殺都會出現";
	RAL_TEXT_XML_50					= "MT血量";
	RAL_TEXT_XML_51					= "警報MT血量危急";
	RAL_TEXT_XML_52					= "5人小隊時警報隊友血量危急";
	RAL_TEXT_XML_53					= "危急上限";
	RAL_TEXT_XML_54					= "MT陣亡";
	RAL_TEXT_XML_55					= "通報MT陣亡";
	RAL_TEXT_XML_56					= "5人小隊時通報自己死亡";
	RAL_TEXT_XML_57					= "保命技能I";
	RAL_TEXT_XML_58					= "通報減傷類保命技能";
	RAL_TEXT_XML_58_1				= "戰士：盾牆\n聖騎士：聖佑術\n死亡騎士：冰錮堅韌、反魔法護罩、反魔法力場";
	RAL_TEXT_XML_59					= "保命技能II";
	RAL_TEXT_XML_60					= "通報加血類保命技能";
	RAL_TEXT_XML_60_1				= "戰士：破釜沉舟\n德魯伊：求生本能\n死亡騎士：血族之裔";
	RAL_TEXT_XML_61					= "法術反射";
	RAL_TEXT_XML_62					= "通報戰士的法術反射技能";
	RAL_TEXT_XML_63					= "仇恨";
	RAL_TEXT_XML_64					= "警報仇恨";
	RAL_TEXT_XML_65					= "1、第一仇恨者：Boss和較危險怪物\n  （非TANK職業獲得第一仇恨通常都是OT）\n2、仇恨過高者：Boss戰時仇恨超過MT";
	RAL_TEXT_XML_66					= "仇恨密語";
	RAL_TEXT_XML_67					= "使用密語通知";
	RAL_TEXT_XML_68					= "顯示發送";
	RAL_TEXT_XML_69					= "是否顯示你發出的密語通知";
	RAL_TEXT_XML_70					= "獵人標記";
	RAL_TEXT_XML_71					= "通報獵人印記技能";
	RAL_TEXT_XML_72					= "威脅轉移";
	RAL_TEXT_XML_73					= "通報獵人的誤導和盜賊的偷天換日技能";
	RAL_TEXT_XML_74					= "獵人寧神";
	RAL_TEXT_XML_75					= "通報獵人的寧神射擊";
	RAL_TEXT_XML_76					= "抵抗嘲諷";
	RAL_TEXT_XML_77					= "通報嘲諷技能的抵抗和免疫";
	RAL_TEXT_XML_78					= "包括戰士、聖騎士、野德和死亡騎士的嘲諷技能";
	RAL_TEXT_XML_79					= "抵抗驅散";
	RAL_TEXT_XML_80					= "通報驅散技能的抵抗和免疫";
	RAL_TEXT_XML_81					= "抵抗變形";
	RAL_TEXT_XML_82					= "通報變形技能的抵抗和免疫";
	RAL_TEXT_XML_83					= "抵抗反制";
	RAL_TEXT_XML_84					= "通報法術反制技能的抵抗和免疫";
	RAL_TEXT_XML_85					= "抵抗法偷";
	RAL_TEXT_XML_86					= "通報法術竊取技能的抵抗和免疫";
	RAL_TEXT_XML_87					= "被控制";
	RAL_TEXT_XML_88					= "通報被控制者並作骷髏標記";
	RAL_TEXT_XML_89					= "此骷髏標記在戰鬥結束後會自動清除";
	RAL_TEXT_XML_90					= "解除控制";
	RAL_TEXT_XML_91					= "提醒解除控制";
	RAL_TEXT_XML_92					= "在團隊頻道通知TANK職業被變形";
	RAL_TEXT_XML_93					= "打破控制";
	RAL_TEXT_XML_94					= "通報打破控制者";
	RAL_TEXT_XML_95					= "包括羊、鎖、睡和冰";
	RAL_TEXT_XML_96					= "魔法驅散";
	RAL_TEXT_XML_97					= "通報怪物身上的魔法被驅散，如：";
	RAL_TEXT_XML_98					= "驅散魔法\n淨化術\n盾擊";
	RAL_TEXT_XML_99					= "法術竊取";
	RAL_TEXT_XML_100				= "通報法師的法術竊取";
	RAL_TEXT_XML_101				= "魔法打斷";
	RAL_TEXT_XML_102				= "通告怪物正在施放的魔法被誰成功打斷";
	RAL_TEXT_XML_103				= "靈魂綁定";
	RAL_TEXT_XML_104				= "通報誰被綁定靈魂石";
	RAL_TEXT_XML_105				= "神聖干涉";
	RAL_TEXT_XML_106				= "聖騎士施放神聖干涉技能時進行通告";
	RAL_TEXT_XML_107				= "陣亡通報";
	RAL_TEXT_XML_108				= "戰鬥結束時通報陣亡人數";
	RAL_TEXT_XML_109				= "視情況通報和法力和靈魂綁定狀態等";
	RAL_TEXT_XML_110				= "墮落(NEF)";
	RAL_TEXT_XML_111				= "黑翼之巢：奈法利安";
	RAL_TEXT_XML_112				= "通報墮落治療者和累計造成傷害";
	RAL_TEXT_XML_113				= "變形(NEF)";
	RAL_TEXT_XML_114				= "點名法師把近戰變形時進行通報";
	RAL_TEXT_XML_115				= "Add(雙子)";
	RAL_TEXT_XML_116				= "安其拉：雙子";
	RAL_TEXT_XML_117				= "警報AOE技能打到小蟲";
	RAL_TEXT_XML_118				= "預設";
	RAL_TEXT_XML_119				= "重置所有警報設定到預設值";
	RAL_TEXT_XML_120				= "全開";
	RAL_TEXT_XML_121				= "開啟全部警報項目";
	RAL_TEXT_XML_122				= "全關";
	RAL_TEXT_XML_123				= "關閉全部警報項目";
	RAL_TEXT_XML_124				= "退出";
	RAL_TEXT_XML_125				= "關閉設置界面";
	RAL_TEXT_XML_126				= "仇恨提示";
	RAL_TEXT_XML_127				= "顯示你的仇恨信息";
	RAL_TEXT_XML_128				= "1、當你獲得任何怪物的第一仇恨時\n2、當你仇恨過高時\n（僅在本機屏幕顯示，並非團隊警報）";
	RAL_TEXT_XML_129				= "音效";
	RAL_TEXT_XML_130				= "為重要警報啟用聲音效果";
	RAL_TEXT_XML_131				= "增大鏡頭上限";
	RAL_TEXT_XML_132				= "使最大鏡頭距離超越系統可設定的上限";
	RAL_TEXT_XML_133				= "關閉此功能後，請在系統的界面設置里重新設定你習慣的鏡頭距離";
	RAL_TEXT_XML_134				= "|cFF00FF00屏|cFF00FFFF幕|cFFFF0000訊|cFFFF00FF息|r";
	RAL_TEXT_XML_135				= "在屏幕上顯示一些訊息\n比如你的嘲諷抵抗、成功打斷等";
	RAL_TEXT_XML_136				= "目標提示";
	RAL_TEXT_XML_137				= "1、當目標的目標轉向你時\n2、當焦點的目標轉向你時\n（僅在本機屏幕顯示，並非團隊警報）";
	RAL_TEXT_XML_138				= "測試";
	RAL_TEXT_XML_139				= "測試屏幕消息效果";
	RAL_TEXT_XML_140				= "團隊物件";
	RAL_TEXT_XML_141				= "通報召喚團隊物件的法術：";
	RAL_TEXT_XML_142				= "";
	RAL_TEXT_XML_143				= "充分進食";
	RAL_TEXT_XML_144				= "通報未吃魚玩家";
	RAL_TEXT_XML_145				= "檢測和通報充分進食的情況";
	RAL_TEXT_XML_146				= "未進食密語";
	RAL_TEXT_XML_147				= "啟用充分進食密語";
	RAL_TEXT_XML_148				= "使用密語通知未進食玩家";
	RAL_TEXT_XML_149				= "心靈之火";
	RAL_TEXT_XML_150				= "通報心靈之火狀態";
	RAL_TEXT_XML_151				= "檢測和通報牧師的心靈之火";
	RAL_TEXT_XML_152				= "心靈之火密語";
	RAL_TEXT_XML_153				= "啟用心靈之火密語";
	RAL_TEXT_XML_154				= "使用密語通知未開開啟心靈之火玩家";
	for i, v in pairs(RAL_TEXT_RAIDSPELL_1) do
		RAL_TEXT_XML_142 = RAL_TEXT_XML_142..v["TEXT"].."\n";
	end
	for i, v in pairs(RAL_TEXT_RAIDSPELL_2) do
		RAL_TEXT_XML_142 = RAL_TEXT_XML_142..v["TEXT"].."\n";
	end
end
