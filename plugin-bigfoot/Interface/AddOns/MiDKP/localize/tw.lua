local L = MiDKP.Locale:NewLocale("zhTW")
--system
L.ADDON_VERSION_TEXT		= "版權所有(C) 2010 178.com %s"
L.ADDON_ENABLE				= "使用MiDKP插件"
L.ADDON_TITLE				= "團隊DKP"
L.MESSAGE_INFO 				= "|cff20ff20<MiDKP 信息> |r"
L.MESSAGE_ERROR 			= "|cffe00000<MiDKP 錯誤> |r"
L.MESSAGE_DEBUG 			= "|cff00c0c0<MiDKP 調試> |r"
L.LDBTOOLTIP1				= "左鍵點擊切換MiDKP面板"
L.LDBTOOLTIP2				= "右鍵點擊切換小地圖按鈕"


L.INFO_SAVED				= "活動已保存。"

L.GREETING_INFO				="MiDKP：%s，由178游戲網（warmane.cn）制作，請使用/md召喚面板"
L.MINI_BUTTON_TITLE			= "MiDKP"
L.MINI_BUTTON_TEXT			= "點擊切換打開關閉MiDKP面板"
L.YOU 						= "你"
L.SPACE						= "　"
L.AWAY 						= "|cff808080(離)|r"
L.OFFLINE 					= "|cff800000(斷)|r"
L.MINOR						= "|cffA34524(小)|r"
L.MAIN						= "|cffA34524(大)|r"
L.ALL 						= "所有成員"
L.CLASS 					= "職業"
L.CLASS_MAGE 				= "法師"
L.CLASS_PRIEST 				= "牧師"
L.CLASS_WARLOCK 			= "術士"
L.CLASS_DRUID				= "德魯伊"
L.CLASS_ROGUE 				= "盜賊"
L.CLASS_ROGUE2 				= "潛行者"
L.CLASS_HUNTER 				= "獵人"
L.CLASS_SHAMAN 				= "薩滿祭司"
L.CLASS_SHAMAN2 			= "薩滿"
L.CLASS_DEATHKNIGHT			= "死亡騎士"
L.CLASS_DEATHKNIGHT2 		= "死騎"
L.CLASS_WARRIOR 			= "戰士"
L.CLASS_PALADIN 			= "聖騎士"
L.CLASS_UNKNOWN				= "未知職業"

L.ARMOR_PLATE 				= "鎧甲"
L.ARMOR_MAIL 				= "鏈甲"
L.ARMOR_LEATHER 			= "皮甲"
L.ARMOR_CLOTH 				= "布甲"
L.ARMOR_UNKNOWN 			= "未知護甲"

L.DEAD						= "你已經死亡"

L.UNDEFINED_ERROR 			= "未定義的錯誤"
L.ERROR_LOADING				= "裝載數據時出現錯誤，請協助發送錯誤時的配置文件"
-- info

L.INFO_INVALID_POINT		= "不合法的分值"

--pop up
L.POP_CONFIRM_DELETE_RAID	= "刪除團隊活動將導致該團隊活動的所有資料都清除，你確定要這麽做嗎？"
L.POP_CONFIRM_DELETE_MEMBER = "你確定要刪除成員<%s>嗎？與其相關的事件將被修改。"
L.POP_CONFIRM_DELETE_EVENT 	= "你確定要刪除事件<%s>嗎？"
L.POP_CONFIRM_DELETE_ITEM 	= "你確定要刪除物品<%s>嗎？"
L.POP_CONFIRM_RAID_END		= "你確定結束活動<%s>嗎？"

L.POP_CONFIRM_ADD_ITEM_IITEM= "你確定要將<%s>添加到忽略列表嗎？"
L.POP_CREATE_IGNORE_ITEM 	= "請輸入你想要創建的忽略物品的名稱"
L.POP_CONFIRM_DELETE_IITEM 	= "你確定要刪除忽略的物品<%s>嗎？"
L.POP_CONFIRM_RESTORE_IITEM	= "所有的自訂的忽略物品都將被清除，你確定要這麽做嗎？"
L.POP_CONFIRM_RELOAD		= "該操作將重新載入當前界面，你確定要這麽做嗎？"
L.POP_CONFIRM_DELETE_MEMBER = "該成員大號<%s>未在團隊中，是否刪除？"


--  page
L.PAGE_HAPPENS_AT			= "發生于 %s"

L.PAGE_BUTTON_DELETE		= "刪除"
L.PAGE_BUTTON_MODIFY		= "修改"
L.PAGE_BUTTON_CREATE		= "創建"
L.PAGE_BUTTON_OKAY			= "確定"
L.PAGE_BUTTON_CANCEL		= "取消"

L.TAB_RAID				 	= "活動"
L.TAB_MEMBER 				= "人員"
L.TAB_EVENT 				= "事件"
L.TAB_ITEM 					= "物品"
L.TAB_OPTION 				= "選項"
L.TAB_DKP	 				= "分數"



---- raid
L.RAID_PAGE_EXPORT			= "匯出"
L.RAID_PAGE_SAVE			= "保存"
L.RAID_PAGE_ACTIVE 			= "激活"
L.RAID_PAGE_ACTIVED 		= "已激活"
L.RAID_PAGE_ADDEVENT		= "添加事件"

L.RAID_PAGE_STAT_NOTSTARTED	= "(|cff800000未開始|r)"
L.RAID_PAGE_STAT_STARTED 	= "(|cff008000進行中|r)"
L.RAID_PAGE_STAT_ENDED 		= "(|cff008080已結束|r)"

L.RAID_PAGE_BTN_START 		= "開始"
L.RAID_PAGE_BTN_END			= "結束"
L.RAID_PAGE_BTN_EXPORT		= "導出"

L.RAID_PAGE_NAME_PATTERN	= "團隊活動 ("
L.RAID_PAGE_DKP_SUITE 		= "DKP系統"
L.RAID_PAGE_TOTALMEMBER		= "總共%d人."
L.RAID_PAGE_START			= " 開始:"
L.RAID_PAGE_END				= " 結束:"

L.RAID_MODIFY 				= "修改活動"
L.RAID_CREATE 				= "創建活動"
L.RAID_DELETE				= "刪除活動"

L.INFO_RAID_STARTED			= "<%s>已開始"
L.INFO_RAID_ACTIVATED		= "<%s>已激活"
L.INFO_RAID_ENDED			= "<%s>已結束"

L.INFO_RAID_CREATED	 		= "團隊活動<%s>創建成功。"
L.INFO_RAID_MODIFIED		= "團隊活動<%s>修改成功。"
L.INFO_RAID_DELETED			= "團隊活動<%s>已刪除。"
L.ERROR_RAID_NOT_IN_RAID 	= "你不在一個團隊中。"
L.ERROR_RAID_NOT_STARTED	= "活動尚未開始"
L.ERROR_RAID_ALREADY_EXISTS = "團隊活動名稱<%s>已經存在。"
L.ERROR_MEMBER_HAS_MINOR 	= "無法刪除有小號的成員。"

--member

L.MEMBER_PAGE_POINT	 		= "%g 分"
L.MEMBER_PAGE_POINT2 		= "獲得 %g "
L.MEMBER_PAGE_TOTAL_POINT	= "當前分 %g"
L.MEMBER_PAGE_ADDMEMBER		= "添加成員"
L.MEMBER_PAGE_SORT_NAME		= "按姓名排序"
L.MEMBER_PAGE_SORT_DKP		= "獲得分排序"
L.MEMBER_PAGE_SORT_TOTALDKP	= "當前分排序"
L.MEMBER_PAGE_JOIN_TIME		= " 入團："
L.MEMBER_PAGE_LEAVE_TIME	= " 離團："
L.MEMBER_ADDEVENT			= "增加事件"
L.MEMBER_DELETE				= "刪除成員"
L.MEMBER_SET_MAIN			= "設置大號"
L.MEMBER_CANCEL_MAIN		= "取消大號"
L.INFO_MEMBER_CREATED		= "成員<%s> 已創建"
L.INFO_MEMBER_DELETED		= "成員<%s> 已刪除"
L.MEMBER_PAGE_MINOR			= "（%s 小號）"

L.ERROR_MEMBER_INLIST 		=  "成員<%s>已在列表中。"
L.ERROR_MEMBER_INVALIDNAME 	=  "不合法的成員名稱"
L.ERROR_MEMBER_INVALID_CLASS=  "不合法的成員職業"
L.ERROR_MEMBER_NOT_IN_LIST	= "成員<%s>不在列表中"
L.ERROR_DEFAULT_MEMBER_EMPTY=  "未添加平均分配事件，分配成員列表為空"
L.ERROR_MEMBER_HAS_ITEM		= "無法刪除拾取物品的成員"

--event
L.EVENT_PAGE_SPLIT_NAME_PAT = " %s 平均分配分數"
L.EVENT_PAGE_TOTAL_MEMBER 	= "總共%d人"
L.EVENT_PAGE_FINISH 		= "完成 %s"

L.EVENT_MODIFY				= "修改事件"
L.EVENT_DELETE				= "刪除事件"

L.INFO_EVENT_CREATED		= "事件 <%s> 已創建"
L.INFO_EVENT_DELETED		= "事件 <%s> 已刪除"
L.INFO_EVENT_MODIFIED		= "事件 <%s> 已修改"

L.ERROR_EVENT_EMPTY_MEMBERS = "不能添加成員為空的活動"
L.ERROR_EVENT_INVALID 		= "不合法的事件描述。"
L.ERROR_EVENT_NONEXIST		= "不存在指定的事件。"
L.ERROR_EVENT_NODELETE_ITEM_EVENT= "不能刪除與物品相關的事件，請到物品欄刪除該物品！"
L.ERROR_EVENT_INVALIDPOINT	= "該事件分數不能為負。"


--item
L.ITEM_PAGE_ACCQUIRE		= "%s 獲得"

L.ITEM_MODIFY				= "修改物品"
L.ITEM_DELETE				= "刪除物品"
L.ITEM_ADD_TO_IITEM			= "添加到忽略"

L.INFO_ITEM_NO_MEMBER 		= "列表中不存在指定成員<%s>。"

L.INFO_ITEM_CREATED			= "物品 <%s> 已創建"
L.INFO_ITEM_DELETED			= "物品 <%s> 已刪除"
L.INFO_ITEM_MODIFIED		= "物品 <%s> 已修改"
L.INFO_ITEM_ADDED_TO_IITEM  = "物品 <%s> 已被添加到忽略列表"

L.ERROR_ITEM_INVALID 		= "不合法的物品描述。"
L.ERROR_ITEM_NOMEMBER		= "必須選擇一個成員。"
L.ERROR_ITEM_INVALIDPOINT	= "物品分數不能為負。"

--editpage
L.EDIT_PAGE_NAME			= "名稱"
L.EDIT_PAGE_POINT			= "分數"
L.EDIT_PAGE_BOSSEVENT 		= "BOSS擊殺"

L.EDIT_ADD_EVENT 			= "添加事件"
L.EDIT_ADD_ITEM 			= "添加物品"
L.EDIT_MODIFY_ITEM 			= "修改物品"
L.EDIT_MODIFY_EVENT 		= "修改事件"

L.EDIT_PAGE_SPLIT			= "平均分配分數"

L.EDIT_PAGE_GROUP_FIRST5    = "前五組"
L.EDIT_PAGE_GROUP_RAID 		= "團隊"
L.EDIT_PAGE_GROUP_ALL		= "所有"
L.EDIT_PAGE_GROUP_LAST3		= "后三組"
L.EDIT_PAGE_GROUP_REVERSE	= "反選"

L.ERROR_EDIT_INVALID_POINT	= "不合法的分值。"

--options
L.OPTION_LABEL_ITEMQUALITY	= "記錄的物品的最低品質"
L.OPTION_LABEL_QUERY		= "玩家密語查詢功能"
L.OPTION_LABEL_DEFAULTACTION= "產生事件時觸發的動作"
L.OPTION_LABEL_DEFAULTMEMBER= "產生事件時默認記錄的人員"
L.OPTION_LABEL_SPLITPOINTS 	= "物品分數平均分配到隊員"
L.OPTION_LABEL_EVENTNOTIFY	= "事件修改提示"
L.OPTION_BTN_FROM_HISTORY 	= "從歷史分內扣除物品分"

L.OPTION_BTN_WHISPER_COMM	= "密語查詢命令"
L.OPTION_BTN_HIDE_RETURN	= "不顯示返回給玩家的密語信息"
L.OPTION_BTN_IITEMS			= "忽略的物品"
L.OPTION_BTN_INC_OFFLINE 	= "包含狀態為斷線的成員"
L.OPTION_BTN_FROM_HISTORY 	= "從歷史分內扣除物品分"


L.OPTION_PAGE_ITEM_LVL1		= select(4,GetItemQualityColor(2)).."優秀|r"
L.OPTION_PAGE_ITEM_LVL2		= select(4,GetItemQualityColor(3)).."精良|r"
L.OPTION_PAGE_ITEM_LVL3		= select(4,GetItemQualityColor(4)).."史詩|r"
L.OPTION_PAGE_ITEM_LVL4		= select(4,GetItemQualityColor(5)).."傳奇|r"

L.OPTION_PAGE_EVENT_ACTION1 = "不產生動作"
L.OPTION_PAGE_EVENT_ACTION2 = "僅顯示提示"
L.OPTION_PAGE_EVENT_ACTION3 = "彈出修改介面"

L.EDIT_PAGE_EVENT_NOTIFY_RAID = "團隊內提示"
L.EDIT_PAGE_EVENT_NOTIFY_WHISPER = "密語提示"
L.EDIT_PAGE_EVENT_NOTIFY_NONE = "不發送提示"

L.OPTION_PAGE_DEFAULT 		= "默認"

--dkp page
L.DKP_PAGE_BTN_ANNOUNCE		= "發布"
L.DKP_PAGE_HISTORY_LEFT		= "歷史剩餘 %g "

L.DKP_PAGE_ONLY_RAID 		= "衹查看團隊成員"

L.DKP_PAGE_ANNOUCNE_INFO 	= "發布配置"

L.DKP_PAGE_ANNOUCNE_CHANNEL = "發布頻道"

L.DKP_PAGE_RAID_CHANNEL 	= "團隊頻道"
L.DKP_PAGE_GUILD_CHANNEL 	= "公會頻道"
L.DKP_PAGE_OFFICER_CHANNEL 	= "官員頻道"
L.DKP_PAGE_PARTY_CHANNEL 	= "小隊頻道"

L.DKP_PAGE_ANNOUNCE_CONTENT = "信息內容"

L.DKP_PAGE_ANNOUNCE_EVENT 	= "發布事件資訊"
L.DKP_PAGE_ANNOUNCE_ITEM 	= "發布物品資訊"
L.DKP_PAGE_ANNOUNCE_MEMBER 	= "發布成員資訊"

L.DKP_PAGE_WHISPER_CONTENT 	= "密語返回內容"

L.DKP_MENU_SENDTO_PERSON	= "發送給個人"
L.DKP_MENU_SENDTO_PARTY		= "發布到小隊"
L.DKP_MENU_SENDTO_GUILD		= "發布到公會"
L.DKP_MENU_SENDTO_GUILD		= "發布到團隊"

L.DKP_PAGE_SUITE_RETURNED 	= "密語時返回分數"

L.DKP_PAGE_TITLE			= "DKP分數"
L.DKP_PAGE_CURRENT_DKP		= "此次活動DKP分數"

L.DKP_ANNOUNCE_PERSON		= "發送給個人"
L.DKP_ANNOUNCE_PARTY		= "發送到小隊"
L.DKP_ANNOUNCE_GUILD		= "發送到工會"
L.DKP_ANNOUNCE_RAID			= "發送到團隊"

L.DKP_NOT_IN_A_RAID			= "你不在一個團隊中"
L.DKP_NOT_IN_A_PARTY		= "你不在一個隊伍中"
L.DKP_NOT_IN_A_GUILD		= "你沒有加入任何工會"
L.DKP_NOT_ONLINE			= "該成員沒有在線"
--whispering text

L.TEXT_HELP_MESSAGE			= "使用\"dkp 系統編號\"來查看某套系統數據,\"dkp 職業\"來查看職業數據，比如：\"dkp 1\", \"dkp fs\""
L.TEXT_INV_MESSAGE			= "非法的命令"
L.TEXT_HELP_HINT_MESSAGE	= "使用\"dkp help\"來查看更多密語命令"

L.TEXT_RAID_NONE			= '當前無活動'

L.TEXT_HISTORY_INFO_SELF	= "你在<%s>中的分值為:%s。"
L.TEXT_HISTORY_NONE_SELF	= "你在<%s>中沒有記錄。"

L.TEXT_MEMBER_INFO			= "　　%d. %s:　%s/%s"
L.TEXT_MEMBER_TITLE			= "參加<%s>的%s有"

L.TEXT_CURRENT_NONE_SELF	= "你在當前活動中沒有記錄"
L.TEXT_CURRENT_INFO_SELF_NOT_BIND	= "你在當前活動中的分數為：%s。"
L.TEXT_CURRENT_INFO_SELF_BIND		= "你在當前活動中的歷史分/當前分為：%s/%s。"
L.TEXT_CURRENT_INFO_HIS		= "你在當前活動中的歷史剩餘/總分為：%s/%s。"


L.TEXT_EVENT_NONE_SELF		= "沒有與你相關的事件。"
L.TEXT_EVENT_TITLE_SELF		= "與你有關係的事件有："
L.TEXT_EVENT_TITLE			= "本次活動的事件有："
L.TEXT_EVENT_NONE			= "本次活動沒有事件。"
L.TEXT_EVENT_INFO			=  "    %d. %s (%g分)"

L.TEXT_EVENT_DETAIL			= "事件<%s>的分值已修改為:(%s)，涉及人員(%s)名"

L.TEXT_ITEM_TITLE_SELF		= "你獲得的物品有："
L.TEXT_ITEM_INFO			=  "    %d. %s (%g分)"
L.TEXT_ITEM_DETAIL_INFO		=  "    %d. %s (%s 获得)(%g分)"
L.TEXT_ITEM_NONE_SELF		= "沒有與你相關的物品。"
L.TEXT_ITEM_TITLE			= "本次活動的物品有："
L.TEXT_ITEM_NONE			= "本次活動沒有物品。"

L.TEXT_EVENT_TITLE_MEMBER	= "與 %s 相關的事件有："
L.TEXT_EVENT_NONE_MEMBER	= "沒有與 %s 相關的事件。"

L.TEXT_ITEM_TITLE_MEMBER	= "與 %s 相關的物品有"
L.TEXT_ITEM_NONE_MEMBER		= "沒有與 %s 相關的物品"

L.TEXT_CURRENT_NONE_MEMBER	= "%s在當前活動中沒有記錄"
L.TEXT_CURRENT_INFO_MEMBER_BIND = "%s在 當前活動中的歷史分/總分為：%s/%s"
L.TEXT_CURRENT_INFO_MEMBER_HIS  = "%s在 當前活動中的歷史剩餘/總分為：%s/%s"

L.TEXT_CURRENT_INFO_MEMBER_NOTBIND = "%s在 當前活動中的分數為：%s"

L.TEXT_HISTORY_NONE_MEMBER	= "%s在 <%s> 中沒有記錄"
L.TEXT_HISTORY_INFO_MEMBER	= "%s在 <%s> 中的分值為%s"

L.TEXT_MEMBERS_INFO_BIND	= "　%d. %s 歷史：%s/當前：%s"
L.TEXT_MEMBERS_INFO_CAH		= "　%d. %s 歷史剩餘：%s/總分：%s"
L.TEXT_MEMBERS_INFO_NOT_BIND= "　%d. %s 分數：%s"
L.TEXT_MEMBERS_TITLE		= "目前選擇的成員有："
L.TEXT_MEMBERS_TITLE_HIS	= "目前選擇的成員在<%s>中的分數為："
L.TEXT_MEMBERS_NONE			= "目前沒有選擇成員。"

L.TEXT_CLASS_NOTFOUND		= ""
L.TEXT_CLASS_TITLE			= "本次活動參加的%s有"
L.TEXT_CLASS_EMPTY			= "本次活動沒有%s參加"