
if (GetLocale() == "zhCN") then
	INFOBOX_LOCK_TEXT = "锁定窗口";
	INFOBOX_UNLOCK_TEXT = "解锁窗口";
	INFOBOX_RESET_POSITION = "重置窗口位置";

	INFOBOX_SHOW_TIME = "显示时间";
	INFOBOX_SHOW_COORDINATE = "显示坐标";
	INFOBOX_OPTIONS_TEXT = "选项";
	INFOBOX_TIME_OFFSET = "时间偏移";

	INFOBOX_TITLE_RESET = "重置位置";

	------------------------------------------------------------------------
	-- 菜单项文字
	------------------------------------------------------------------------
	INFOBOX_MENU_WINDOWS_TITLE = "窗口";
	INFOBOX_MENU_ADVANCE_WINDOWS_TITLE = "高级窗口";
	INFOBOX_MENU_LOCK_WINDOW = "锁定尺寸";
	INFOBOX_MENU_UNLOCK_WINDOW = "解锁尺寸";
	INFOBOX_MENU_LINK_WINDOW = "连动窗口";
	INFOBOX_MENU_NEW_WINDOW = "新建窗口";
	INFOBOX_MENU_CLOSE_WINDOW = "关闭窗口";
	INFOBOX_MENU_MODULE_TITLE = "模块";
	INFOBOX_MENU_MANIFIST_TITLE = "显示";
	INFOBOX_MENU_BACK_COLOR = "底色";
	INFOBOX_MENU_BORDER_COLOR = "边框颜色";
	INFOBOX_MENU_HIDE_BACKGROUND = "隐藏背景";
	INFOBOX_MENU_FULL_HIDE = "完全隐藏";
	INFOBOX_MENU_SETUP_MODULE = "切换模块";
	INFOBOX_MENU_ADD_MODULE = "新增模块";
	INFOBOX_MENU_UNLOAD_MODULE = "卸载模块";
	INFOBOX_MENU_NO_MODULE = "无可用模块";
	INFOBOX_MENU_NEW_EMPTY_WINDOW = "新建空窗口";
	INFOBOX_MENU_THEME_TITLE = "配置方案"
	INFOBOX_MENU_SELECT_THEME = "载入方案";
	INFOBOX_MENU_SAVE_THEME = "存储方案";
	INFOBOX_MENU_SAVE_NEW_THEME = "新的方案";
	INFOBOX_MENU_SAVE_THEME_TITLE = "已存方案";
	INFOBOX_MENU_DELETE_THEME = "删除方案";
	INFOBOX_MENU_RESTORE_THEME = "恢复默认方案";
	INFOBOX_MENU_THEME = "方案";

	------------------------------------------------------------------------
	-- 弹出式对话框文字
	------------------------------------------------------------------------
	MODULE_SLOT_NAME_THEME = "请输入配置方案名称";
	MODULE_SLOT_REPLACE_THEME = "配置方案《|cff00ff00%s|r》已经存在，您真的想要覆盖旧的配置方案吗？";
	MODULE_SLOT_DELETE_THEME = "配置方案《|cff00ff00%s|r》将被永久删除，你真的要删除吗？";

	------------------------------------------------------------------------
	-- 信息提示文字
	------------------------------------------------------------------------
	MODULE_SLOT_INFO_SAVE_THEME_SUCCEED = "配置方案《|cff00ff00%s|r》保存成功。";
	MODULE_SLOT_INFO_LOAD_SUCCESS = "配置方案《|cff00ff00%s|r》载入成功。";
	MODULE_SLOT_INFO_DELETE_THEME = "配置方案《|cff00ff00%s|r》已经被删除。";
	MODULE_SLOT_INFO_RESTORE_THEME = "注意！当前所有配置方案将被缺省配置方案取代！你真的要这么做？";

	INFOBOX_CATEGORY_INFOTIP = "信息提示";
	INFOBOX_CATEGORY_INTERFACE = "界面调整";
	INFOBOX_COORDINATE_PATTERN = "坐标：(%d, %d)";
	INFOBOX_LATENCY_PATTERN = "延迟：%d 毫秒";
	INFOBOX_MEMORY_PATTERN = "内存：%d MB";

	__DPSModule_Patterns = {
		"造成(%d+)",
		"吸取了(%d+)点",
		"造成了(%d+)",
		"将(%d+)点(.*)伤害反弹给"
	};

	INFOBOX_MODULE_TIME_TITLE = "时间显示";
	INFOBOX_MODULE_TIME_DESC = "显示当前的时间";
	INFOBOX_MODULE_COORDINATE_TITLE = "坐标显示";
	INFOBOX_MODULE_COORDINATE_DESC = "显示当前的坐标位置";
	INFOBOX_MODULE_LATENCY_TITLE = "延迟显示";
	INFOBOX_MODULE_LATENCY_DESC = "显示当前的网络延迟";
	INFOBOX_MODULE_FRAME_RATE_TITLE = "帧数显示";
	INFOBOX_MODULE_FRAME_RATE_DESC = "显示当前的画面帧数";
	INFOBOX_MODULE_DPS_TITLE = "DPS显示";
	INFOBOX_MODULE_DPS_DESC = "显示当前的DPS";
	INFOBOX_MODULE_MEMORY_TITLE = "内存消耗显示";
	INFOBOX_MODULE_MEMORY_DESC = "显示当前的内存消耗";
	INFOBOX_MODULE_MONEY_TITLE = "金钱显示";
	INFOBOX_MODULE_MONEY_DESC = "显示当前的金钱数量";
	INFOBOX_MODULE_PORTRAIT_TITLE = "玩家头像";
	INFOBOX_MODULE_PORTRAIT_DESC = "实现可任意移动的玩家头像";
	INFOBOX_MODULE_TARGET_TITLE = "目标头像";
	INFOBOX_MODULE_TARGET_DESC = "实现可任意移动的目标头像";
	INFOBOX_MODULE_PARTY_TITLE = "队友头像";
	INFOBOX_MODULE_PARTY_DESC = "实现可任意移动的队友头像";
	INFOBOX_MODULE_MAIN_ACTION_BAR_TITLE = "主动作条";
	INFOBOX_MODULE_MAIN_ACTION_BAR_DESC = "实现可任意移动的动作条";
	INFOBOX_MODULE_LB_ACTION_BAR_TITLE = "左下动作条";
	INFOBOX_MODULE_LB_ACTION_BAR_DESC = "实现可任意移动的动作条";
	INFOBOX_MODULE_RB_ACTION_BAR_TITLE = "右下动作条";
	INFOBOX_MODULE_RB_ACTION_BAR_DESC = "实现可任意移动的动作条";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_TITLE = "右侧动作条";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_DESC = "实现可任意移动的右侧动作条";
	INFOBOX_MODULE_LEFT_ACTION_BAR_TITLE = "左侧动作条";
	INFOBOX_MODULE_LEFT_ACTION_BAR_DESC = "实现可任意移动的左侧动作条";
	INFOBOX_MODULE_BAG_TITLE = "背包条";
	INFOBOX_MODULE_BAG_DESC = "实现可任意移动的背包条";
	INFOBOX_MODULE_SHAPESHIFT_TITLE = "宠物动作条或形变条";
	INFOBOX_MODULE_SHAPESHIFT_DESC = "实现可任意移动的宠物动作条或形变条";
	INFOBOX_MODULE_MENU_TITLE = "菜单工具条";
	INFOBOX_MODULE_MENU_DESC = "实现可任意移动的菜单工具条";
	INFOBOX_MODULE_CAST_BAR_TITLE = "施法条";
	INFOBOX_MODULE_CAST_BAR_DESC = "实现可任意移动的施法条";
	INFOBOX_MODULE_QUEST_TRACK_TITLE = "追踪栏";
	INFOBOX_MODULE_QUEST_TRACK_DESC = "实现可任意移动的追踪栏";
	INFOBOX_MODULE_DURABILITY_TITLE = "装备磨损面板";
	INFOBOX_MODULE_DURABILITY_DESC = "实现可任意移动的装备磨损面板";
	INFOBOX_MODULE_BUFF_TITLE = "增益魔法条";
	INFOBOX_MODULE_BUFF_DESC = "实现可任意移动的增益魔法条";
	INFOBOX_MODULE_MINIMAP_TITLE = "迷你地图";
	INFOBOX_MODULE_MINIMAP_DESC = "实现可任意移动的迷你地图";
	INFOBOX_MODULE_KEYRING_TITLE = "钥匙链";
	INFOBOX_MODULE_KEYRING_DESC = "实现可任意移动的钥匙链";

	INFOBOX_TOOLTIP_NEW_WINDOW = "创建新的窗口";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "将所有窗口显示出来方便移动，\n必须为解锁状态";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "锁定所有窗口，使其不能移动及显示";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "解锁所有窗口，使其可以移动及显示";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "完全隐藏窗口，包括其内容";
	INFOBOX_TOOLITP_LOAD_THEME = "载入界面方案";
	INFOBOX_TOOLTIP_SAVE_THEME = "保存界面方案";
	INFOBOX_TOOLTIP_DELETE_THEME = "删除界面方案";
	INFOBOX_TOOLTIP_RESET_THEME = "恢复所有界面方案至缺省";

	INFOBOX_HIDE_WINDOW = "隐藏窗口";

	INFOBOX_THEME_1_NAME = "传统型";
	INFOBOX_THEME_1_DESC = "本配置方案采用了简单聊天窗口模式，如果您不喜欢这种方式，请到主菜单下选择界面设置，将<简易聊天模式>一项的设置取消。";
	INFOBOX_THEME_2_NAME = "简约型";
	INFOBOX_THEME_2_DESC = "本配置方案聊天窗口进行了锁定，如果您需要移动聊天窗口，请到主菜单下选择界面设置，将<锁定聊天设置>一项的设置取消。或者通过信息盒2.0工具条的<解锁>来进行移动。";
	INFOBOX_THEME_3_NAME = "现代型";
	INFOBOX_THEME_COMBAT_NAME = "战斗记录";
	INFOBOX_THEME_GENERAL_NAME = "综合";
elseif (GetLocale() == "zhTW") then
	INFOBOX_LOCK_TEXT = "鎖定窗口";
	INFOBOX_UNLOCK_TEXT = "解鎖窗口";
	INFOBOX_RESET_POSITION = "重置窗口位置";

	INFOBOX_SHOW_TIME = "顯示時間";
	INFOBOX_SHOW_COORDINATE = "顯示坐標";
	INFOBOX_OPTIONS_TEXT = "選項";
	INFOBOX_TIME_OFFSET = "時間偏移";

	------------------------------------------------------------------------
	-- 菜單項文字
	------------------------------------------------------------------------
	INFOBOX_MENU_WINDOWS_TITLE = "窗口";
	INFOBOX_MENU_ADVANCE_WINDOWS_TITLE = "高級窗口";
	INFOBOX_MENU_LOCK_WINDOW = "鎖定尺寸";
	INFOBOX_MENU_UNLOCK_WINDOW = "解鎖尺寸";
	INFOBOX_MENU_LINK_WINDOW = "連動窗口";
	INFOBOX_MENU_NEW_WINDOW = "新建窗口";
	INFOBOX_MENU_CLOSE_WINDOW = "關閉窗口";
	INFOBOX_MENU_MODULE_TITLE = "模塊";
	INFOBOX_MENU_MANIFIST_TITLE = "顯示";
	INFOBOX_MENU_BACK_COLOR = "底色";
	INFOBOX_MENU_BORDER_COLOR = "邊框顔色";
	INFOBOX_MENU_HIDE_BACKGROUND = "隱藏背景";
	INFOBOX_MENU_FULL_HIDE = "完全隱藏";
	INFOBOX_MENU_SETUP_MODULE = "切換模塊";
	INFOBOX_MENU_ADD_MODULE = "新增模塊";
	INFOBOX_MENU_UNLOAD_MODULE = "卸載模塊";
	INFOBOX_MENU_NO_MODULE = "無可用模塊";
	INFOBOX_MENU_NEW_EMPTY_WINDOW = "新建空窗口";
	INFOBOX_MENU_THEME_TITLE = "配置方案"
	INFOBOX_MENU_SELECT_THEME = "載入方案";
	INFOBOX_MENU_SAVE_THEME = "存儲方案";
	INFOBOX_MENU_SAVE_NEW_THEME = "新的方案";
	INFOBOX_MENU_SAVE_THEME_TITLE = "已存方案";
	INFOBOX_MENU_DELETE_THEME = "刪除方案";
	INFOBOX_MENU_RESTORE_THEME = "恢複默認方案";
	INFOBOX_MENU_THEME = "方案";

	------------------------------------------------------------------------
	-- 彈出式對話框文字
	------------------------------------------------------------------------
	MODULE_SLOT_NAME_THEME = "請輸入配置方案名稱";
	MODULE_SLOT_REPLACE_THEME = "配置方案《|cff00ff00%s|r》已經存在，您真的想要覆蓋舊的配置方案嗎？";
	MODULE_SLOT_DELETE_THEME = "配置方案《|cff00ff00%s|r》將被永久刪除，你真的要刪除嗎？";

	------------------------------------------------------------------------
	-- 信息提示文字
	------------------------------------------------------------------------
	MODULE_SLOT_INFO_SAVE_THEME_SUCCEED = "配置方案《|cff00ff00%s|r》保存成功。";
	MODULE_SLOT_INFO_LOAD_SUCCESS = "配置方案《|cff00ff00%s|r》載入成功。";
	MODULE_SLOT_INFO_DELETE_THEME = "配置方案《|cff00ff00%s|r》已經被刪除。";
	MODULE_SLOT_INFO_RESTORE_THEME = "注意！當前所有配置方案將被缺省配置方案取代！你真的要這麽做？";

	INFOBOX_CATEGORY_INFOTIP = "信息提示";
	INFOBOX_CATEGORY_INTERFACE = "界面調整";
	INFOBOX_COORDINATE_PATTERN = "坐標：(%d, %d)";
	INFOBOX_LATENCY_PATTERN = "延遲：%d 毫秒";
	INFOBOX_MEMORY_PATTERN = "內存：%d MB";

	__DPSModule_Patterns = {
		"造成(%d+)",
		"吸取了(%d+)點",
		"造成了(%d+)",
		"將(%d+)點(.*)傷害反彈給"
	};

	INFOBOX_MODULE_TIME_TITLE = "時間顯示";
	INFOBOX_MODULE_TIME_DESC = "顯示當前的時間";
	INFOBOX_MODULE_COORDINATE_TITLE = "坐標顯示";
	INFOBOX_MODULE_COORDINATE_DESC = "顯示當前的坐標位置";
	INFOBOX_MODULE_LATENCY_TITLE = "延遲顯示";
	INFOBOX_MODULE_LATENCY_DESC = "顯示當前的網絡延遲";
	INFOBOX_MODULE_FRAME_RATE_TITLE = "幀數顯示";
	INFOBOX_MODULE_FRAME_RATE_DESC = "顯示當前的畫面幀數";
	INFOBOX_MODULE_DPS_TITLE = "DPS顯示";
	INFOBOX_MODULE_DPS_DESC = "顯示當前的DPS";
	INFOBOX_MODULE_MEMORY_TITLE = "內存消耗顯示";
	INFOBOX_MODULE_MEMORY_DESC = "顯示當前的內存消耗";
	INFOBOX_MODULE_MONEY_TITLE = "金錢顯示";
	INFOBOX_MODULE_MONEY_DESC = "顯示當前的金錢數量";
	INFOBOX_MODULE_PORTRAIT_TITLE = "玩家頭像";
	INFOBOX_MODULE_PORTRAIT_DESC = "實現可任意移動的玩家頭像";
	INFOBOX_MODULE_TARGET_TITLE = "目標頭像";
	INFOBOX_MODULE_TARGET_DESC = "實現可任意移動的目標頭像";
	INFOBOX_MODULE_PARTY_TITLE = "隊友頭像";
	INFOBOX_MODULE_PARTY_DESC = "實現可任意移動的隊友頭像";
	INFOBOX_MODULE_MAIN_ACTION_BAR_TITLE = "主動作條";
	INFOBOX_MODULE_MAIN_ACTION_BAR_DESC = "實現可任意移動的動作條";
	INFOBOX_MODULE_LB_ACTION_BAR_TITLE = "左下動作條";
	INFOBOX_MODULE_LB_ACTION_BAR_DESC = "實現可任意移動的動作條";
	INFOBOX_MODULE_RB_ACTION_BAR_TITLE = "右下動作條";
	INFOBOX_MODULE_RB_ACTION_BAR_DESC = "實現可任意移動的動作條";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_TITLE = "右側動作條";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_DESC = "實現可任意移動的右側動作條";
	INFOBOX_MODULE_LEFT_ACTION_BAR_TITLE = "左側動作條";
	INFOBOX_MODULE_LEFT_ACTION_BAR_DESC = "實現可任意移動的左側動作條";
	INFOBOX_MODULE_BAG_TITLE = "背包條";
	INFOBOX_MODULE_BAG_DESC = "實現可任意移動的背包條";
	INFOBOX_MODULE_SHAPESHIFT_TITLE = "寵物動作條或形變條";
	INFOBOX_MODULE_SHAPESHIFT_DESC = "實現可任意移動的寵物動作條或形變條";
	INFOBOX_MODULE_MENU_TITLE = "菜單工具條";
	INFOBOX_MODULE_MENU_DESC = "實現可任意移動的菜單工具條";
	INFOBOX_MODULE_CAST_BAR_TITLE = "施法條";
	INFOBOX_MODULE_CAST_BAR_DESC = "實現可任意移動的施法條";
	INFOBOX_MODULE_QUEST_TRACK_TITLE = "追蹤欄";
	INFOBOX_MODULE_QUEST_TRACK_DESC = "實現可任意移動的追蹤欄";
	INFOBOX_MODULE_DURABILITY_TITLE = "裝備磨損面板";
	INFOBOX_MODULE_DURABILITY_DESC = "實現可任意移動的裝備磨損面板";
	INFOBOX_MODULE_BUFF_TITLE = "增益魔法條";
	INFOBOX_MODULE_BUFF_DESC = "實現可任意移動的增益魔法條";
	INFOBOX_MODULE_MINIMAP_TITLE = "迷你地圖";
	INFOBOX_MODULE_MINIMAP_DESC = "實現可任意移動的迷你地圖";
	INFOBOX_MODULE_KEYRING_TITLE = "鑰匙鏈";
	INFOBOX_MODULE_KEYRING_DESC = "實現可任意移動的鑰匙鏈";

	INFOBOX_TOOLTIP_NEW_WINDOW = "創建新的窗口";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "將所有窗口顯示出來方便移動，\n必須爲解鎖狀態";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "鎖定所有窗口，使其不能移動及顯示";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "解鎖所有窗口，使其可以移動及顯示";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "完全隱藏窗口，包括其內容";
	INFOBOX_TOOLITP_LOAD_THEME = "載入界面方案";
	INFOBOX_TOOLTIP_SAVE_THEME = "保存界面方案";
	INFOBOX_TOOLTIP_DELETE_THEME = "刪除界面方案";
	INFOBOX_TOOLTIP_RESET_THEME = "恢複所有界面方案至缺省";

	INFOBOX_HIDE_WINDOW = "隱藏窗口";

	INFOBOX_THEME_1_NAME = "傳統型";
	INFOBOX_THEME_1_DESC = "本配置方案采用了簡單聊天窗口模式，如果您不喜歡這種方式，請到主菜單下選擇界面設置，將<簡易聊天模式>一項的設置取消。";
	INFOBOX_THEME_2_NAME = "簡約型";
	INFOBOX_THEME_2_DESC = "本配置方案聊天窗口進行了鎖定，如果您需要移動聊天窗口，請到主菜單下選擇界面設置，將<鎖定聊天設置>一項的設置取消。或者通過信息盒2.0工具條的<解鎖>來進行移動。";
	INFOBOX_THEME_3_NAME = "現代型";
	INFOBOX_THEME_COMBAT_NAME = "戰鬥記錄";
	INFOBOX_THEME_GENERAL_NAME = "綜合";
else
	INFOBOX_LOCK_TEXT = "Lock";
	INFOBOX_UNLOCK_TEXT = "Unlock";
	INFOBOX_RESET_POSITION = "Reset Position";

	INFOBOX_SHOW_TIME = "Show Time";
	INFOBOX_SHOW_COORDINATE = "Show Coordinate";
	INFOBOX_OPTIONS_TEXT = "Options";
	INFOBOX_TIME_OFFSET = "Time Offset";

	------------------------------------------------------------------------
	-- 菜单项文字
	------------------------------------------------------------------------
	INFOBOX_MENU_WINDOWS_TITLE = "Window";
	INFOBOX_MENU_ADVANCE_WINDOWS_TITLE = "Advanced Window";
	INFOBOX_MENU_LOCK_WINDOW = "Lock";
	INFOBOX_MENU_UNLOCK_WINDOW = "Unlock";
	INFOBOX_MENU_LINK_WINDOW = "Link Window";
	INFOBOX_MENU_NEW_WINDOW = "New Window";
	INFOBOX_MENU_CLOSE_WINDOW = "Close Window";
	INFOBOX_MENU_MODULE_TITLE = "Module";
	INFOBOX_MENU_MANIFIST_TITLE = "Display";
	INFOBOX_MENU_BACK_COLOR = "Background Color";
	INFOBOX_MENU_BORDER_COLOR = "Border Color";
	INFOBOX_MENU_HIDE_BACKGROUND = "Hide Background";
	INFOBOX_MENU_FULL_HIDE = "Full Hide";
	INFOBOX_MENU_SETUP_MODULE = "Switch Module";
	INFOBOX_MENU_ADD_MODULE = "Add Module";
	INFOBOX_MENU_UNLOAD_MODULE = "Unload Module";
	INFOBOX_MENU_NO_MODULE = "No available module";
	INFOBOX_MENU_NEW_EMPTY_WINDOW = "New Empty Window";
	INFOBOX_MENU_THEME_TITLE = "Theme"
	INFOBOX_MENU_SELECT_THEME = "Load Theme";
	INFOBOX_MENU_SAVE_THEME = "Save Theme";
	INFOBOX_MENU_SAVE_NEW_THEME = "New Theme";
	INFOBOX_MENU_SAVE_THEME_TITLE = "Save Theme";
	INFOBOX_MENU_DELETE_THEME = "Delete Theme";
	INFOBOX_MENU_RESTORE_THEME = "Restore Theme";
	INFOBOX_MENU_THEME = "Theme";

	------------------------------------------------------------------------
	-- 弹出式对话框文字
	------------------------------------------------------------------------
	MODULE_SLOT_NAME_THEME = "Please input the name of theme";
	MODULE_SLOT_REPLACE_THEME = "Theme '|cff00ff00%s|r' already exists, do you really want to replace old theme?";
	MODULE_SLOT_DELETE_THEME = "Theme '|cff00ff00%s|r' will be deleted, are you sure?";

	------------------------------------------------------------------------
	-- 信息提示文字
	------------------------------------------------------------------------
	MODULE_SLOT_INFO_SAVE_THEME_SUCCEED = "Theme '|cff00ff00%s|r' save successfully.";
	MODULE_SLOT_INFO_LOAD_SUCCESS = "Theme '|cff00ff00%s|r' load successfully.";
	MODULE_SLOT_INFO_DELETE_THEME = "Theme '|cff00ff00%s|r' has been deleted.";
	MODULE_SLOT_INFO_RESTORE_THEME = "Caustion! All current themes will be replace with default themes! Are you sure?";

	INFOBOX_CATEGORY_INFOTIP = "Infomation Tip";
	INFOBOX_CATEGORY_INTERFACE = "UI arrangement";
	INFOBOX_COORDINATE_PATTERN = "Coord: (%d, %d)";
	INFOBOX_LATENCY_PATTERN = "Latency: %d ms";
	INFOBOX_MEMORY_PATTERN = "Memory: %d MB";

	__DPSModule_Patterns = {
		"Cause (%d+)",
		"Absorb (%d+)",
		"Cause (%d+)",
		"Reflect (%d+) (.*) damage"
	};

	INFOBOX_MODULE_TIME_TITLE = "Time";
	INFOBOX_MODULE_TIME_DESC = "Show current time";
	INFOBOX_MODULE_COORDINATE_TITLE = "Coordinate";
	INFOBOX_MODULE_COORDINATE_DESC = "Show Coordinate";
	INFOBOX_MODULE_LATENCY_TITLE = "Latency";
	INFOBOX_MODULE_LATENCY_DESC = "Show Latency";
	INFOBOX_MODULE_FRAME_RATE_TITLE = "Frame Rate";
	INFOBOX_MODULE_FRAME_RATE_DESC = "Show Frame Rate";
	INFOBOX_MODULE_DPS_TITLE = "DPS";
	INFOBOX_MODULE_DPS_DESC = "Show DPS";
	INFOBOX_MODULE_MEMORY_TITLE = "Memory";
	INFOBOX_MODULE_MEMORY_DESC = "Show Memroy Cost";
	INFOBOX_MODULE_MONEY_TITLE = "Money";
	INFOBOX_MODULE_MONEY_DESC = "Show Money";
	INFOBOX_MODULE_PORTRAIT_TITLE = "Player Portrait";
	INFOBOX_MODULE_PORTRAIT_DESC = "Implement movable player protrait";
	INFOBOX_MODULE_TARGET_TITLE = "Target Portrait";
	INFOBOX_MODULE_TARGET_DESC = "Implement movable target protrait";
	INFOBOX_MODULE_PARTY_TITLE = "Party Portraits";
	INFOBOX_MODULE_PARTY_DESC = "Implement movable party protraits";
	INFOBOX_MODULE_MAIN_ACTION_BAR_TITLE = "Main ActionBar";
	INFOBOX_MODULE_MAIN_ACTION_BAR_DESC = "Implement movable main actionbar";
	INFOBOX_MODULE_LB_ACTION_BAR_TITLE = "Left Bottom ActionBar";
	INFOBOX_MODULE_LB_ACTION_BAR_DESC = "Implement movable left-bottom actionbar";
	INFOBOX_MODULE_RB_ACTION_BAR_TITLE = "Right Bottom ActionBar";
	INFOBOX_MODULE_RB_ACTION_BAR_DESC = "Implement movalbe right-bottom actionbar";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_TITLE = "Right ActionBar";
	INFOBOX_MODULE_RIGHT_ACTION_BAR_DESC = "Implement movable right actionbar";
	INFOBOX_MODULE_LEFT_ACTION_BAR_TITLE = "Left ActionBar";
	INFOBOX_MODULE_LEFT_ACTION_BAR_DESC = "Implement movable left actionbar";
	INFOBOX_MODULE_BAG_TITLE = "Bags";
	INFOBOX_MODULE_BAG_DESC = "Implmenent movable Bags";
	INFOBOX_MODULE_SHAPESHIFT_TITLE = "Pet ActionBar";
	INFOBOX_MODULE_SHAPESHIFT_DESC = "Implement movalbe pet actionbar";
	INFOBOX_MODULE_MENU_TITLE = "Menu Bar";
	INFOBOX_MODULE_MENU_DESC = "Implement movable menu bar";
	INFOBOX_MODULE_CAST_BAR_TITLE = "Casting Bar";
	INFOBOX_MODULE_CAST_BAR_DESC = "Implement movable casting bar";
	INFOBOX_MODULE_QUEST_TRACK_TITLE = "Watch Frame";
	INFOBOX_MODULE_QUEST_TRACK_DESC = "Implement movable watch frame";
	INFOBOX_MODULE_DURABILITY_TITLE = "Druability Pane";
	INFOBOX_MODULE_DURABILITY_DESC = "Implement movable durability pane";
	INFOBOX_MODULE_BUFF_TITLE = "Buff Pane";
	INFOBOX_MODULE_BUFF_DESC = "Implement movalbe buff pane";
	INFOBOX_MODULE_MINIMAP_TITLE = "Minimap";
	INFOBOX_MODULE_MINIMAP_DESC = "Make the minimap moveable";
	INFOBOX_MODULE_KEYRING_TITLE = "Keyring";
	INFOBOX_MODULE_KEYRING_DESC = "Make the keyring moveable";

	INFOBOX_TOOLTIP_NEW_WINDOW = "New Window";
	INFOBOX_TOOLTIP_MOVE_WINDOW = "Show all windows to move，\nMust be unlock status";
	INFOBOX_TOOLTIP_LOCK_WINDOW = "Lock all windows to prevent form moving";
	INFOBOX_TOOLTIP_UNLOCK_WINDOW = "Unlock all window to move";
	INFOBOX_TOOLTIP_HIDE_WINDOW = "Hide window including its content";
	INFOBOX_TOOLITP_LOAD_THEME = "Load Theme";
	INFOBOX_TOOLTIP_SAVE_THEME = "Save Theme";
	INFOBOX_TOOLTIP_DELETE_THEME = "Delete Theme";
	INFOBOX_TOOLTIP_RESET_THEME = "Reset Theme";

	INFOBOX_HIDE_WINDOW = "Hide Window";

	INFOBOX_THEME_1_NAME = "Tradition";
	INFOBOX_THEME_1_DESC = "This theme use simple chat mode. If you do not like this mehto, pleast select interfact settings in main menu and cancel item <Simple Chat Mode>.";
	INFOBOX_THEME_2_NAME = "Compat";
	INFOBOX_THEME_2_DESC = "This theme lock chat window. If you need move chat window, pleast select interface in main menu and cancel lock chat window. Or use 'Unlock' in InfoBox to move it.";
	INFOBOX_THEME_3_NAME = "Popular";
	INFOBOX_THEME_COMBAT_NAME = "Combat Log";
	INFOBOX_THEME_GENERAL_NAME = "General";
end

