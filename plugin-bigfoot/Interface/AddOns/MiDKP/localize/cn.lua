local L = MiDKP.Locale:NewLocale("zhCN")
--system
L.ADDON_VERSION_TEXT		= "版权所有(C) 2010 178.com %s"
L.ADDON_ENABLE				= "使用MiDKP插件"
L.ADDON_TITLE				= "团队DKP"
L.MESSAGE_INFO 				= "|cff20ff20<MiDKP 信息> |r"
L.MESSAGE_ERROR 			= "|cffe00000<MiDKP 错误> |r"
L.MESSAGE_DEBUG 			= "|cff00c0c0<MiDKP 调试> |r"
L.LDBTOOLTIP1				= "左键点击切换MiDKP面板"
L.LDBTOOLTIP2				= "右键点击切换小地图按钮"

L.INFO_SAVED				= "活动已保存。"

L.INFO_SAVED				= "活动已保存。"

L.GREETING_INFO				="MiDKP：%s，由everwar开源魔兽(https://everwar.cn)制作，请使用/md召唤面板"
L.MINI_BUTTON_TITLE			= "MiDKP"
L.MINI_BUTTON_TEXT			= "点击切换打开关闭MiDKP面板"
L.YOU 					= "你"
L.SPACE					= "　"
L.AWAY 					= "|cff808080(离)|r"
L.OFFLINE 				= "|cff800000(断)|r"
L.MINOR					= "|cffA34524(小)|r"
L.MAIN					= "|cffA34524(大)|r"
L.ALL 					= "所有成员"
L.CLASS 				= "职业"
L.CLASS_MAGE 				= "法师"
L.CLASS_PRIEST 				= "牧师"
L.CLASS_WARLOCK 			= "术士"
L.CLASS_DRUID				= "德鲁伊"
L.CLASS_ROGUE 				= "盗贼"
L.CLASS_ROGUE2 				= "潜行者"
L.CLASS_HUNTER 				= "猎人"
L.CLASS_SHAMAN 				= "萨满祭司"
L.CLASS_SHAMAN2 			= "萨满"
L.CLASS_DEATHKNIGHT			= "死亡骑士"
L.CLASS_DEATHKNIGHT2 		= "死骑"
L.CLASS_WARRIOR 			= "战士"
L.CLASS_PALADIN 			= "圣骑士"
L.CLASS_UNKNOWN				= "未知职业"

L.ARMOR_PLATE 				= "板甲"
L.ARMOR_MAIL 				= "锁甲"
L.ARMOR_LEATHER 			= "皮甲"
L.ARMOR_CLOTH 				= "布甲"
L.ARMOR_UNKNOWN 			= "未知护甲"

L.DEAD					= "你已经死亡"

L.UNDEFINED_ERROR 			= "未定义的错误"
L.ERROR_LOADING				= "装载数据时出现错误，请协助发送错误时的配置文件"
-- info

L.INFO_INVALID_POINT		= "不合法的分值"

--pop up
L.POP_CONFIRM_DELETE_RAID	= "删除团队活动将导致该团队活动的所有资料都清除，你确定要这么做吗？"
L.POP_CONFIRM_DELETE_MEMBER = "你确定要删除成员<%s>吗？与其相关的事件将被修改。"
L.POP_CONFIRM_DELETE_EVENT 	= "你确定要删除事件<%s>吗？"
L.POP_CONFIRM_DELETE_ITEM 	= "你确定要删除物品<%s>吗？"
L.POP_CONFIRM_RAID_END		= "你确定结束活动<%s>吗？"

L.POP_CONFIRM_ADD_ITEM_IITEM= "你确定要将<%s>添加到忽略列表吗？"
L.POP_CREATE_IGNORE_ITEM 	= "请输入你想要创建的忽略物品的名称"
L.POP_CONFIRM_DELETE_IITEM 	= "你确定要删除忽略的物品<%s>吗？"
L.POP_CONFIRM_RESTORE_IITEM	= "所有的自订的忽略物品都将被清除，你确定要这么做吗？"
L.POP_CONFIRM_RELOAD		= "该操作将重新载入当前界面，你确定要这么做吗？"
L.POP_CONFIRM_DELETE_MAIN   = "该成员大号<%s>未在团队中，是否删除？"

--  page
L.PAGE_HAPPENS_AT			= "发生于 %s"

L.PAGE_BUTTON_DELETE		= "删除"
L.PAGE_BUTTON_MODIFY		= "修改"
L.PAGE_BUTTON_CREATE		= "创建"
L.PAGE_BUTTON_OKAY			= "确定"
L.PAGE_BUTTON_CANCEL		= "取消"

L.TAB_RAID				 	= "活动"
L.TAB_MEMBER 				= "人员"
L.TAB_EVENT 				= "事件"
L.TAB_ITEM 					= "物品"
L.TAB_OPTION 				= "选项"
L.TAB_DKP	 				= "分数"



---- raid
L.RAID_PAGE_EXPORT			= "汇出"
L.RAID_PAGE_SAVE			= "保存"
L.RAID_PAGE_ACTIVE 			= "激活"
L.RAID_PAGE_ACTIVED 		= "已激活"
L.RAID_PAGE_ADDEVENT		= "添加事件"

L.RAID_PAGE_STAT_NOTSTARTED	= "(|cff800000未开始|r)"
L.RAID_PAGE_STAT_STARTED 	= "(|cff008000进行中|r)"
L.RAID_PAGE_STAT_ENDED 		= "(|cff008080已结束|r)"

L.RAID_PAGE_BTN_START 		= "开始"
L.RAID_PAGE_BTN_END			= "结束"
L.RAID_PAGE_BTN_EXPORT		= "导出"

L.RAID_PAGE_NAME_PATTERN	= "团队活动 ("
L.RAID_PAGE_DKP_SUITE 		= "DKP系统"
L.RAID_PAGE_TOTALMEMBER		= "总共%d人."
L.RAID_PAGE_START			= " 开始:"
L.RAID_PAGE_END				= " 结束:"

L.RAID_MODIFY 				= "修改活动"
L.RAID_CREATE 				= "创建活动"
L.RAID_DELETE				= "删除活动"

L.INFO_RAID_STARTED			= "<%s>已开始"
L.INFO_RAID_ACTIVATED		= "<%s>已激活"
L.INFO_RAID_ENDED			= "<%s>已结束"

L.INFO_RAID_CREATED	 		= "团队活动<%s>创建成功。"
L.INFO_RAID_MODIFIED		= "团队活动<%s>修改成功。"
L.INFO_RAID_DELETED			= "团队活动<%s>已删除。"
L.ERROR_RAID_NOT_IN_RAID 	= "你不在一个团队中。"
L.ERROR_RAID_NOT_STARTED	= "活动尚未开始"
L.ERROR_RAID_ALREADY_EXISTS = "团队活动名称<%s>已经存在。"
L.ERROR_MEMBER_HAS_MINOR 	= "无法删除有小号的成员。"

--member

L.MEMBER_PAGE_POINT	 		= "%g 分"
L.MEMBER_PAGE_POINT2 		= "获得 %g "
L.MEMBER_PAGE_TOTAL_POINT	= "当前 %g"
L.MEMBER_PAGE_ADDMEMBER		= "添加成员"
L.MEMBER_PAGE_SORT_NAME		= "按姓名排序"
L.MEMBER_PAGE_SORT_DKP		= "获得分排序"
L.MEMBER_PAGE_SORT_TOTALDKP	= "当前分排序"
L.MEMBER_PAGE_JOIN_TIME		= " 入团："
L.MEMBER_PAGE_LEAVE_TIME	= " 离团："
L.MEMBER_ADDEVENT			= "增加事件"
L.MEMBER_DELETE				= "删除成员"
L.MEMBER_SET_MAIN			= "设置大号"
L.MEMBER_CANCEL_MAIN		= "取消大号"
L.INFO_MEMBER_CREATED		= "成员<%s> 已创建"
L.INFO_MEMBER_DELETED		= "成员<%s> 已删除"
L.MEMBER_PAGE_MINOR			= "（%s 小号）"

L.ERROR_MEMBER_INLIST 		=  "成员<%s>已在列表中。"
L.ERROR_MEMBER_INVALIDNAME 	=  "不合法的成员名称"
L.ERROR_MEMBER_INVALID_CLASS=  "不合法的成员职业"
L.ERROR_MEMBER_NOT_IN_LIST	= "成员<%s>不在列表中"
L.ERROR_DEFAULT_MEMBER_EMPTY=  "未添加平均分配事件，分配成员列表为空"
L.ERROR_MEMBER_HAS_ITEM		= "无法删除拾取物品的成员"

--event
L.EVENT_PAGE_SPLIT_NAME_PAT = " %s 平均分配分数"
L.EVENT_PAGE_TOTAL_MEMBER 	= "总共%d人"
L.EVENT_PAGE_FINISH 		= "完成 %s"

L.EVENT_MODIFY				= "修改事件"
L.EVENT_DELETE				= "删除事件"

L.INFO_EVENT_CREATED		= "事件 <%s> 已创建"
L.INFO_EVENT_DELETED		= "事件 <%s> 已删除"
L.INFO_EVENT_MODIFIED		= "事件 <%s> 已修改"

L.ERROR_EVENT_EMPTY_MEMBERS = "不能添加成员为空的活动"
L.ERROR_EVENT_INVALID 		= "不合法的事件描述。"
L.ERROR_EVENT_NONEXIST		= "不存在指定的事件。"
L.ERROR_EVENT_NODELETE_ITEM_EVENT= "不能删除与物品相关的事件，请到物品栏删除该物品！"
L.ERROR_EVENT_INVALIDPOINT	= "该事件分数不能为负。"


--item
L.ITEM_PAGE_ACCQUIRE		= "%s 获得"

L.ITEM_MODIFY				= "修改物品"
L.ITEM_DELETE				= "删除物品"
L.ITEM_ADD_TO_IITEM			= "添加到忽略"

L.INFO_ITEM_NO_MEMBER 		= "列表中不存在指定成员<%s>。"

L.INFO_ITEM_CREATED			= "物品 <%s> 已创建"
L.INFO_ITEM_DELETED			= "物品 <%s> 已删除"
L.INFO_ITEM_MODIFIED		= "物品 <%s> 已修改"
L.INFO_ITEM_ADDED_TO_IITEM  = "物品 <%s> 已被添加到忽略列表"

L.ERROR_ITEM_INVALID 		= "不合法的物品描述。"
L.ERROR_ITEM_NOMEMBER		= "必须选择一个成员。"
L.ERROR_ITEM_INVALIDPOINT	= "物品分数不能为负。"

--editpage
L.EDIT_PAGE_NAME			= "名称"
L.EDIT_PAGE_POINT			= "分数"
L.EDIT_PAGE_BOSSEVENT 		= "BOSS击杀"

L.EDIT_ADD_EVENT 			= "添加事件"
L.EDIT_ADD_ITEM 			= "添加物品"
L.EDIT_MODIFY_ITEM 			= "修改物品"
L.EDIT_MODIFY_EVENT 		= "修改事件"

L.EDIT_PAGE_SPLIT			= "平均分配分数"

L.EDIT_PAGE_GROUP_FIRST5    = "前五组"
L.EDIT_PAGE_GROUP_RAID 		= "团队"
L.EDIT_PAGE_GROUP_ALL		= "所有"
L.EDIT_PAGE_GROUP_LAST3		= "后三组"
L.EDIT_PAGE_GROUP_REVERSE	= "反选"

L.ERROR_EDIT_INVALID_POINT	= "不合法的分值。"

--options
L.OPTION_LABEL_ITEMQUALITY	= "记录的物品的最低品质"
L.OPTION_LABEL_QUERY		= "玩家密语查询功能"
L.OPTION_LABEL_DEFAULTACTION= "产生事件时触发的动作"
L.OPTION_LABEL_DEFAULTMEMBER= "产生事件时默认记录的人员"
L.OPTION_LABEL_SPLITPOINTS 	= "物品分数平均分配到队员"
L.OPTION_LABEL_EVENTNOTIFY	= "事件修改提示"
L.OPTION_LABEL_ITEMFROMHISTORY	= "从历史分内扣除物品分"

L.OPTION_BTN_WHISPER_COMM	= "密语查询命令"
L.OPTION_BTN_HIDE_RETURN	= "不显示返回给玩家的密语信息"
L.OPTION_BTN_IITEMS			= "忽略的物品"
L.OPTION_BTN_INC_OFFLINE 	= "包含状态为断线的成员"
L.OPTION_BTN_FROM_HISTORY 	= "从历史分内扣除物品分"


L.OPTION_PAGE_ITEM_LVL1		= select(4,GetItemQualityColor(2)).."优秀|r"
L.OPTION_PAGE_ITEM_LVL2		= select(4,GetItemQualityColor(3)).."精良|r"
L.OPTION_PAGE_ITEM_LVL3		= select(4,GetItemQualityColor(4)).."史诗|r"
L.OPTION_PAGE_ITEM_LVL4		= select(4,GetItemQualityColor(5)).."传奇|r"

L.OPTION_PAGE_EVENT_ACTION1 = "不产生动作"
L.OPTION_PAGE_EVENT_ACTION2 = "仅显示提示"
L.OPTION_PAGE_EVENT_ACTION3 = "弹出修改介面"

L.EDIT_PAGE_EVENT_NOTIFY_RAID = "团队内提示"
L.EDIT_PAGE_EVENT_NOTIFY_WHISPER = "密语提示"
L.EDIT_PAGE_EVENT_NOTIFY_NONE = "不发送提示"

L.OPTION_PAGE_DEFAULT 		= "默认"

--dkp page
L.DKP_PAGE_BTN_ANNOUNCE		= "发布"
L.DKP_PAGE_HISTORY_LEFT		= "历史剩余 %g "

L.DKP_PAGE_ONLY_RAID 		= "只查看团队成员"

L.DKP_PAGE_ANNOUCNE_INFO 	= "发布配置"

L.DKP_PAGE_ANNOUCNE_CHANNEL = "发布频道"

L.DKP_PAGE_RAID_CHANNEL 	= "团队频道"
L.DKP_PAGE_GUILD_CHANNEL 	= "公会频道"
L.DKP_PAGE_OFFICER_CHANNEL 	= "官员频道"
L.DKP_PAGE_PARTY_CHANNEL 	= "小队频道"

L.DKP_PAGE_ANNOUNCE_CONTENT = "信息内容"

L.DKP_PAGE_ANNOUNCE_EVENT 	= "发布事件资讯"
L.DKP_PAGE_ANNOUNCE_ITEM 	= "发布物品资讯"
L.DKP_PAGE_ANNOUNCE_MEMBER 	= "发布成员资讯"

L.DKP_PAGE_WHISPER_CONTENT 	= "密语返回内容"

L.DKP_MENU_SENDTO_PERSON	= "发送给个人"
L.DKP_MENU_SENDTO_PARTY		= "发布到小队"
L.DKP_MENU_SENDTO_GUILD		= "发布到公会"
L.DKP_MENU_SENDTO_GUILD		= "发布到团队"

L.DKP_PAGE_SUITE_RETURNED 	= "密语时返回分数"

L.DKP_PAGE_TITLE			= "DKP分数"
L.DKP_PAGE_CURRENT_DKP		= "此次活动DKP分数"

L.DKP_ANNOUNCE_PERSON		= "发送给个人"
L.DKP_ANNOUNCE_PARTY		= "发送到小队"
L.DKP_ANNOUNCE_GUILD		= "发送到工会"
L.DKP_ANNOUNCE_RAID			= "发送到团队"

L.DKP_NOT_IN_A_RAID			= "你不在一个团队中"
L.DKP_NOT_IN_A_PARTY		= "你不在一个队伍中"
L.DKP_NOT_IN_A_GUILD		= "你没有加入任何工会"
L.DKP_NOT_ONLINE			= "该成员没有在线"
--whispering text

L.TEXT_HELP_MESSAGE			= "使用\"dkp 系统编号\"来查看某套系统数据,\"dkp 职业\"来查看职业数据，比如：\"dkp 1\", \"dkp fs\""
L.TEXT_INV_MESSAGE			= "非法的命令"
L.TEXT_HELP_HINT_MESSAGE	= "使用\"dkp help\"来查看更多密语命令"

L.TEXT_RAID_NONE			= '当前无活动'

L.TEXT_HISTORY_INFO_SELF	= "你在<%s>中的分值为:%s。"
L.TEXT_HISTORY_NONE_SELF	= "你在<%s>中没有记录。"

L.TEXT_MEMBER_INFO			= "　　%d. %s:　%s/%s"
L.TEXT_MEMBER_TITLE			= "参加<%s>的%s有"

L.TEXT_CURRENT_NONE_SELF	= "你在当前活动中没有记录"
L.TEXT_CURRENT_INFO_SELF_NOT_BIND	= "你在当前活动中的分数为：%s。"
L.TEXT_CURRENT_INFO_SELF_BIND		= "你在当前活动中的历史分/总分为：%s/%s。"
L.TEXT_CURRENT_INFO_HIS		= "你在当前活动中的历史剩余/总分为：%s/%s。"


L.TEXT_EVENT_NONE_SELF		= "没有与你相关的事件。"
L.TEXT_EVENT_TITLE_SELF		= "与你有关系的事件有："
L.TEXT_EVENT_TITLE			= "本次活动的事件有："
L.TEXT_EVENT_NONE			= "本次活动没有事件。"
L.TEXT_EVENT_INFO			=  "    %d. %s (%g分)"

L.TEXT_EVENT_DETAIL			= "事件<%s>的分值已修改为:(%s)，涉及人员(%s)名"

L.TEXT_ITEM_TITLE_SELF		= "你获得的物品有："
L.TEXT_ITEM_INFO			=  "    %d. %s (%g分)"
L.TEXT_ITEM_DETAIL_INFO		=  "    %d. %s (%s 获得)(%g分)"
L.TEXT_ITEM_NONE_SELF		= "没有与你相关的物品。"
L.TEXT_ITEM_TITLE			= "本次活动的物品有："
L.TEXT_ITEM_NONE			= "本次活动没有物品。"

L.TEXT_EVENT_TITLE_MEMBER	= "与 %s 相关的事件有："
L.TEXT_EVENT_NONE_MEMBER	= "没有与 %s 相关的事件。"

L.TEXT_ITEM_TITLE_MEMBER	= "与 %s 相关的物品有"
L.TEXT_ITEM_NONE_MEMBER		= "没有与 %s 相关的物品"

L.TEXT_CURRENT_NONE_MEMBER	= "%s在当前活动中没有记录"
L.TEXT_CURRENT_INFO_MEMBER_BIND = "%s在 当前活动中的历史分/总分为：%s/%s"
L.TEXT_CURRENT_INFO_MEMBER_HIS  = "%s在 当前活动中的历史剩余/总分为：%s/%s"

L.TEXT_CURRENT_INFO_MEMBER_NOTBIND = "%s在 当前活动中的分数为：%s"

L.TEXT_HISTORY_NONE_MEMBER	= "%s在 <%s> 中没有记录"
L.TEXT_HISTORY_INFO_MEMBER	= "%s在 <%s> 中的分值为%s" 

L.TEXT_MEMBERS_INFO_BIND	= "　%d. %s 历史：%s/当前：%s"
L.TEXT_MEMBERS_INFO_CAH		= "%d. %s 历史剩余：%s/总分：%s"
L.TEXT_MEMBERS_INFO_NOT_BIND= "　%d. %s 分数：%s" 
L.TEXT_MEMBERS_TITLE		= "目前选择的成员有："
L.TEXT_MEMBERS_TITLE_HIS	= "目前选择的成员在<%s>中的分数为："
L.TEXT_MEMBERS_NONE			= "目前没有选择成员。"

L.TEXT_CLASS_NOTFOUND		= ""
L.TEXT_CLASS_TITLE			= "本次活动参加的%s有"
L.TEXT_CLASS_EMPTY			= "本次活动没有%s参加"