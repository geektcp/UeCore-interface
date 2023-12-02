
if (IsConfigurableAddOn("ChatEnhance") or IsConfigurableAddOn("BubbleChat")) then
	if (GetLocale() == "zhCN") then
		CHAT_ENHANCEMENT_TITLE = {"聊天增强", "liaotianzengqiang",2};
		
		BUBBLECHAT_ENABLE_TEXT= "开启泡泡聊天";	
		BUBBLECHAT_ENABLE_TEXT_TOOLTIP="在队友头像右边显示其小队中发送的信息"
		
		SCROLL_CHATFRAME_TEXT = "鼠标滚轮滚动查看聊天信息";
		SCROLL_CHATFRAME_TEXT_TOOLTIP= "当鼠标在聊天窗口上时，允许使用鼠标滚轮滚动查看聊天窗口中的信息";
		
		BFC_ENABLE_TEXT = "启用KK魔兽聊天快捷条"
		BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷条，如使用KK魔兽表情，快捷频道切换等"
		
		PLAYER_LINK_ENABLE_TEXT = "增强聊天窗口"; 
		PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增强聊天窗口，如聊天时间显示，复制聊天内容等"; 
		
		BFC_CONFIG="聊天配置"
		BFC_DISABLE_DELAY_TEXT = "|cff00c0c0<KK魔兽聊天>|r 你已经关闭KK魔兽聊天(BigFootChat)模块，该设置将在下次插件载入时生效。";
	elseif (GetLocale() == "zhTW") then
		CHAT_ENHANCEMENT_TITLE = {"聊天增強", "liaotianzengqiang",2};
		
		BUBBLECHAT_ENABLE_TEXT= "開啟泡泡聊天";
		BUBBLECHAT_ENABLE_TEXT_TOOLTIP= "在隊友頭像右邊顯示其小隊中發送的信息";
		
		SCROLL_CHATFRAME_TEXT = "鼠標滾輪滾動查看聊天信息";
		SCROLL_CHATFRAME_TEXT_TOOLTIP= "當鼠標在聊天窗口上時，允許使用鼠標滾輪滾動查看聊天窗口中的信息";
		
		BFC_ENABLE_TEXT = "啟用大腳聊天快捷條"
		BFC_ENABLE_TEXT_TOOLTIP= "添加聊天快捷條，如使用大腳表情，快捷頻道切換等"
		
		PLAYER_LINK_ENABLE_TEXT = "增強聊天視窗"; 	
		PLAYER_LINK_ENABLE_TEXT_TOOLTIP= "增強聊天窗口，如聊天時間顯示，複製聊天內容等"; 	
		
		BFC_CONFIG="聊天配置"
		BFC_DISABLE_DELAY_TEXT = "|cff00c0c0<大腳聊天>|r 妳已經關閉大腳聊天(BigFootChat)模塊，該設置將在下次插件載入時生效。";
	else
		CHAT_ENHANCEMENT_TITLE = "Chat Enhancement";
		BUBBLECHAT_ENABLE_TEXT= "Enable BubbleChat";
		SCROLL_CHATFRAME_TEXT = "Allow using mouse wheel to scroll chat window";
		BFC_ENABLE_TEXT = "Enable BigFootChat"
		PLAYER_LINK_ENABLE_TEXT = "Enhance player linke in chat window";
		BFC_CONFIG="Config BFC"
	end

	ModManagement_RegisterMod(
		"ChatEnhancement",
		"Interface\\Icons\\Spell_Magic_PolymorphChicken",
		CHAT_ENHANCEMENT_TITLE,
		"",
		nil,
		nil,
		{[3]=true,[7]=true}
	);
end

if (IsConfigurableAddOn("BubbleChat")) then
	ModManagement_RegisterCheckBox(
		"ChatEnhancement",
		BUBBLECHAT_ENABLE_TEXT,
		BUBBLECHAT_ENABLE_TEXT_TOOLTIP,
		"EnableBubbleChat",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BubbleChat")) then
					BigFoot_LoadAddOn("BubbleChat");
				end
				
				if (BigFoot_IsAddOnLoaded("BubbleChat")) then
					BubbleChat_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BubbleChat")) then
					BubbleChat_Toggle(false);
				end
			end
		end
	);
end

if (IsConfigurableAddOn("ChatEnhance")) then
	ModManagement_RegisterCheckBox(
		"ChatEnhancement",
		SCROLL_CHATFRAME_TEXT,
		SCROLL_CHATFRAME_TEXT_TOOLTIP,
		"EnableScrollChatFrame",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("ChatEnhance")) then
					BigFoot_LoadAddOn("ChatEnhance");
				end
				
				if (BigFoot_IsAddOnLoaded("ChatEnhance")) then
					ChatEnahnce_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("ChatEnhance")) then
					ChatEnahnce_Toggle(false);
				end
			end
		end
	);
end

if (IsConfigurableAddOn("PlayerLink")) then
	ModManagement_RegisterCheckBox( 
		"ChatEnhancement", 
		PLAYER_LINK_ENABLE_TEXT, 
		PLAYER_LINK_ENABLE_TEXT_TOOLTIP, 
		"EnablePlayerLink",
		1,
		function(arg1)
			if (arg1 == 1) then
				if (not BigFoot_IsAddOnLoaded("PlayerLink")) then
					BigFoot_LoadAddOn("PlayerLink");
				end

				if (BigFoot_IsAddOnLoaded("PlayerLink")) then
					PlayerLink_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("PlayerLink")) then
					PlayerLink_Toggle(false);
				end
			end
		end
	);
end

if (IsConfigurableAddOn("BigFootChat")) then
	ModManagement_RegisterCheckBox( 
		"ChatEnhancement", 
		BFC_ENABLE_TEXT, 
		BFC_ENABLE_TEXT_TOOLTIP, 
		"DisableBFC",
		0,
		function(arg1)
			if (arg1 == 1) then
				if (not BigFoot_IsAddOnLoaded("BigFootChat")) then
					BigFoot_LoadAddOn("BigFootChat");
				end

				if (BigFoot_IsAddOnLoaded("BigFootChat")) then
					BigFootChat:Enable();
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("BigFootChat")) then
					BigFootChat:Disable();
					BigFoot_RequestReloadUI(function() BigFoot_Print(BFC_DISABLE_DELAY_TEXT); end);
				end
			end
		end
	);
	ModManagement_RegisterButton(
		"ChatEnhancement",
		BFC_CONFIG,
		function()
			if BigFoot_IsAddOnLoaded("BigFootChat")  then
				BigFootChat:ShowOptions()
				PlaySound("igMainMenuOption");
				HideUIPanel(ModManagementFrame);
			end
		end,
		nil,
		1
	);
	
	
end