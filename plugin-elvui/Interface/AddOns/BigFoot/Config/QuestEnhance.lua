local ENABLE_BIGFOOTQUEST_TEXT;
local BIGFOOTQUEST_MOD_TITLE;

if (GetLocale() == "zhCN") then
	MOD_QUEST_ENHANCEMENT_TITLE = {"任务增强", "renwuzengqiang"};
	
	ENABLE_BIGFOOTQUEST_TEXT = "启用KK魔兽任务(BigFootQuest)";
	ENABLE_BIGFOOTQUEST_TEXT_TOOLTIP= "提供任务给予及交付NPC的位置和任务物品获得方式提示";
	
	ENABLE_QUESTHELPER_TEXT = "启用任务助手(QuestHelper)";	
	ENABLE_QUESTHELPER_TEXT_TOOLTIP= "非常强大的任务插件，自动优化任务路线，任务提示详细，占用内存较大";
	
	ENABLE_QUESTINFO_TEXT = "启用任务查询(QuestInfo)";	
	ENABLE_QUESTINFO_TEXT_TOOLTIP= "提供任务给予及交付NPC的位置和任务物品获得方式提示";
	
	ENABLE_QUEST_LEVEL_TEXT = "显示任务等级";	
	ENABLE_QUEST_LEVEL_TOOLTIP= "在任务面板内显示任务等级";

	ENABLE_QUEST_FastQuest_TEXT	= "小队任务公告";
	ENABLE_QUEST_FastQuest_TOOLTIP = "在小队模式下公布你的任务进度。";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "详细任务进度";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公布具体的任务更新进程。";

	QH_LOADING_TEXT			= "任务助手正在启动..."
	
	BF_DISABLE_BFQ_TIP = "|cff00c0c0<KK魔兽任务>|r 你已经关闭KK魔兽任务(BigFootQuest)模块，该设置将在下次插件载入时生效。";
	BF_DISABLE_QH_TIP = "|cff00c0c0<任务助手>|r 你已经关闭任务助手(QuestHelper)模块，该设置将在下次插件载入时生效。";
	BF_DISABLE_QI_TIP = "|cff00c0c0<任务查询>|r 你已经关闭任务查询(QuestInfo)模块，该设置将在下次插件载入时生效。";

elseif (GetLocale() == "zhTW") then
	MOD_QUEST_ENHANCEMENT_TITLE = {"任務增強", "renwuzengqiang"};
	
	ENABLE_BIGFOOTQUEST_TEXT = "使用大腳任務(BigFootQuest)";
	ENABLE_BIGFOOTQUEST_TEXT_TOOLTIP= "提供任務給予及交付NPC的位置和任務物品獲得方式提示";
	
	ENABLE_QUESTHELPER_TEXT = "使用任務助手(QuestHelper)";	
	ENABLE_QUESTHELPER_TEXT_TOOLTIP= "非常強大的任務插件，自動優化任務路線，任務提示顯示，佔用內存較大";
	
	ENABLE_QUESTINFO_TEXT = "使用任務查詢(QuestInfo)";	
	ENABLE_QUESTINFO_TEXT_TOOLTIP= "提供任務給予及交付NPC的位置和任務物品獲得方式提示";
	
	ENABLE_QUEST_LEVEL_TEXT = "顯示任務等級";	
	ENABLE_QUEST_LEVEL_TOOLTIP= "在任務面板內顯示任務等級";

	ENABLE_QUEST_FastQuest_TEXT	= "小隊任務公告";
	ENABLE_QUEST_FastQuest_TOOLTIP = "在組隊模式下公佈你的任務進度。";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "詳細任務進度";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "公佈具體的任務更新進程。";
	
	QH_LOADING_TEXT			= "任務助手正在啟動..."
	
	BF_DISABLE_BFQ_TIP = "|cff00c0c0<大腳任務>|r 你已經關閉大腳任務(BigFootQuest)模組，該設置將在下次外掛程式載入時生效。";
	BF_DISABLE_QH_TIP = "|cff00c0c0<任務助手>|r 你已經關閉任務助手(QuestHelper)模組，該設置將在下次外掛程式載入時生效。";
	BF_DISABLE_QI_TIP = "|cff00c0c0<任務查詢>|r 你已经關閉任務查詢(QuestInfo)模块，該設置將在下次外掛程式載入時生效。";
else
	MOD_QUEST_ENHANCEMENT_TITLE = "Quest Enhance"
	ENABLE_BIGFOOTQUEST_TEXT = "Enable BigFootQuest";
	ENABLE_QUESTHELPER_TEXT = "Enable QuestHelper";	
	ENABLE_QUESTINFO_TEXT = "Enable QuestInfo";	
	
	ENABLE_QUEST_LEVEL_TEXT = "Show Quest Level";	
	ENABLE_QUEST_LEVEL_TOOLTIP= "Show Quest Level On QuestLog";

	ENABLE_QUEST_FastQuest_TEXT	= "Squad announcement task";
	ENABLE_QUEST_FastQuest_TOOLTIP = "In group mode to publish your task progress.";

	ENABLE_QUEST_FastQuestInfo_TEXT	= "Detailed task progress";
	ENABLE_QUEST_FastQuestInfo_TOOLTIP = "Announce specific mission update process.";
	
	BF_DISABLE_BFQ_TIP = "|cff00c0c0<Quest Enhancement>|r BigFootQuest has been disabled. This setting will be available next time.";
	BF_DISABLE_QH_TIP = "|cff00c0c0<Quest Enhancement>|r QuestHelper has been disabled. This setting will be available next time.";
	BF_DISABLE_QI_TIP ="|cff00c0c0<Quest Enhancement>|r QuestInfo has been disabled. This setting will be available next time.";

end


ModManagement_RegisterMod(
	"QuestEnhancement",
	"Interface\\Icons\\INV_Misc_Note_02",
	MOD_QUEST_ENHANCEMENT_TITLE,
	"",
	nil,
	nil,
	{[6]=true},
	true,
	"230"
);

if  IsConfigurableAddOn("QuestInfo") then
	ModManagement_RegisterCheckBox(
		"QuestEnhancement",
		ENABLE_QUESTINFO_TEXT,
		ENABLE_QUESTINFO_TEXT_TOOLTIP,
		"EnableQuestInfo",
		1,
		function (arg)
			if (arg == 1) then
				BigFoot_LoadAddOn("QuestInfo");					
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("QuestInfo")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(BF_DISABLE_QI_TIP); end);
				end			
			end
		end
	);
end

if IsConfigurableAddOn("BFQuest") then
	
	ModManagement_RegisterCheckBox(
		"QuestEnhancement",
		ENABLE_QUEST_LEVEL_TEXT,
		ENABLE_QUEST_LEVEL_TOOLTIP,
		"EnableQuestLvl",
		1,
		function (arg)
			if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
				BigFoot_LoadAddOn("BFQuest");	
			end
			if (arg == 1) then
				LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("Level")
			else
				LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("Level")				
			end
		end
	);
	
	ModManagement_RegisterCheckBox(
		"QuestEnhancement",
		ENABLE_QUEST_FastQuest_TEXT,
		ENABLE_QUEST_FastQuest_TOOLTIP,
		"EnableQuestBroad",
		1,
		function (arg)
			if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
				BigFoot_LoadAddOn("BFQuest");	
			end
			if (arg == 1) then
				LibStub("AceAddon-3.0"):GetAddon("BFQuest"):EnableModule("Broadcast")
			else
				LibStub("AceAddon-3.0"):GetAddon("BFQuest"):DisableModule("Broadcast")				
			end
		end
	);

	ModManagement_RegisterCheckBox(
		"QuestEnhancement",
		ENABLE_QUEST_FastQuestInfo_TEXT,
		ENABLE_QUEST_FastQuestInfo_TOOLTIP,
		"EnableQuestBroadInfo",
		nil,
		function (arg)
			if (not BigFoot_IsAddOnLoadedFromBigFoot("BFQuest")) then
				BigFoot_LoadAddOn("BFQuest");	
			end
			Auto_FastQuestInfo(arg)
		end,
		1
	);
	
end



