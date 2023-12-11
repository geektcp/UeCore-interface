
--[[ 
		BigFootGlobalString.lua
		
		一些BigFoot需要的全局变量

		版本：1.12
		更新时间：2004年10月19日
		更新作者：Andy Xiao
]]--

if (GetLocale() == "zhCN") then
	BF_NAME = "KK魔兽";
	BF_HEADER = "KK魔兽设置";
	BF_SHOW_QUEST_LEVEL = "显示任务的详细等级";
	BF_DISABLE_QUEST_FADING = "立即显示任务文字";
	BF_MERCHANT_OPEN_ALL_BAGS = "同商人交易时自动打开背包";
	BF_CENTER_TOOLTIP = "将信息提示放置在屏幕顶上";
	TAB_GENERAL = "一般设置";
	TAB_ACTIONBAR = "动作条";
	TAB_OTHERS = "其它设置";
	BIGFOOT_CONFIRM ="确定";
	RAID_TOOLKIT_TITLE = "团队工具";
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的KK魔兽版本已过期，请用KK魔兽客户端更新，最新版本为:%s，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的KK魔兽版本错误，请重新用KK魔兽客户端更新，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"
elseif (GetLocale() == "zhTW") then
	BF_NAME = "大腳插件";
	BF_HEADER = "大腳設置";
	BF_SHOW_QUEST_LEVEL = "顯示任務的詳細等級";
	BF_DISABLE_QUEST_FADING = "立即顯示任務文字";
	BF_MERCHANT_OPEN_ALL_BAGS = "同商人交易時自動打開背包";
	BF_CENTER_TOOLTIP = "將信息提示放置在屏幕頂上";
	TAB_GENERAL = "一般設置";
	TAB_ACTIONBAR = "動作條";
	TAB_OTHERS = "其它設置";
	BIGFOOT_CONFIRM ="確定";
	RAID_TOOLKIT_TITLE = "團隊工具";
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的大腳版本已過期，請用大腳客戶端更新，最新版本為:%s，大腳插件由everwar开源魔兽(https://everwar.cn)制作。|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的KK魔兽版本錯誤，请重新用KK魔兽客户端更新，KK魔兽插件由everwar开源魔兽(https://everwar.cn)制作.|r"

else
	BF_NAME = "BigFoot";
	BF_HEADER = "BigFoot Menu";
	BF_SHOW_QUEST_LEVEL = "Show the detail level of quests";
	BF_DISABLE_QUEST_FADING = "Disable Quest Fading";
	BF_MERCHANT_OPEN_ALL_BAGS = "Open all bags while talking with vendor";
	BF_CENTER_TOOLTIP = "Rearrange Tooltip";
	BIGFOOT_CONFIRM ="Confirm";
	TAB_GENERAL = "General";
	TAB_ACTIONBAR = "Action Bar";
	TAB_OTHERS = "Others";

	RAID_TOOLKIT_TITLE = "Raid Toolkit";
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 Your BigFoot version is outdated, please upgrade to current version %s|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 Your BigFoot version is incorrect, please download again.|r"

end
