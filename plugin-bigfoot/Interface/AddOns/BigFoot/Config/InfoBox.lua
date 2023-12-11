
if (GetLocale() == "zhCN") then
	MOD_INFOBOX_TITLE = {"界面调整", "jiemiantiaozheng"};
	
	INFOBOX_ENABLE_TITLE = "开启界面调整";
	INFOBOX_ENABLE_TITLE_TOOLTIP = "当鼠标移动到屏幕顶端弹出界面调整主菜单，通过该菜单你可以调整你所需要的界面";
	
	BLIZZMOVE_ENABLE_TITLE = "开启窗体移动";
	BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖动任意窗体，并通过Ctrl+滚轮对当前窗体进行缩放。";
	
	BFGOLDFRAME_ENABLE_TITLE = "开启金币统计"
	BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷监视当前金币的框体，并可记录金币变化信息"
	
	BLIZZMOVE_DISABLE_DELAY_TEXT ="|cff00c0c0<窗体移动>|r 你已经关闭窗体移动模块，该设置将在下次插件载入时生效。";
	
elseif (GetLocale() == "zhTW") then
	MOD_INFOBOX_TITLE = {"介面調整", "jiemiantiaozheng"};
	
	INFOBOX_ENABLE_TITLE = "開啟介面調整";
	INFOBOX_ENABLE_TITLE_TOOLTIP = "當鼠標移動到屏幕頂端彈出介面調整菜單，通過該菜單你可以調整你所需要的介面";

	BLIZZMOVE_ENABLE_TITLE = "開啟窗體移動";
	BLIZZMOVE_ENABLE_TITLE_TOOLTIP = "任意拖動任意窗體，並通過Ctrl+滾輪對當前窗體進行縮放。";

	BFGOLDFRAME_ENABLE_TITLE = "開啟金幣統計"
	BFGOLDFRAME_ENABLE_TITLE_TOOLTIP= "快捷監視當前金幣的框體，并可記錄金幣變化信息"
	
	BLIZZMOVE_DISABLE_DELAY_TEXT = "|cff00c0c0<窗體移動>|r 你已經關閉窗體移動模組，該設置將在下次插件載入時生效。";
else
	MOD_INFOBOX_TITLE = "InfoBox";
	INFOBOX_ENABLE_TITLE = "Enable InfoBox";
	BLIZZMOVE_ENABLE_TITLE = "Enable BlizzMove";
	BFGOLDFRAME_ENABLE_TITLE = "Enable GoldFrame"
	BFGOLDFRAME_ENABLE_TOOLTIP = "Enable GoldFrame"
	BLIZZMOVE_DISABLE_DELAY_TEXT = "|cff00c0c0<BlizzMove>|r has been disabled. This setting will be available next time.";
end

if (IsConfigurableAddOn("InfoBox")) then
	ModManagement_RegisterMod(
		"InfoBox",
		"Interface\\Icons\\INV_Misc_StoneTablet_11",
		MOD_INFOBOX_TITLE,
		"",
		nil,
		nil,
		{[3]=true}
	);

	ModManagement_RegisterCheckBox(
		"InfoBox",
		INFOBOX_ENABLE_TITLE,
		INFOBOX_ENABLE_TITLE_TOOLTIP,
		"EnableInfoBoxV2",
		0,
		function (__arg)
			if ( __arg == 1 ) then
				if (not BigFoot_IsAddOnLoaded("InfoBox")) then
					BigFoot_LoadAddOn("InfoBox");
				end
				
				if (BigFoot_IsAddOnLoaded("InfoBox")) then
					InfoBox_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("InfoBox")) then
					InfoBox_Toggle(false);
				end
			end
		end
	);
end

if (IsConfigurableAddOn("BlizzMove")) then
	ModManagement_RegisterCheckBox(
		"InfoBox",
		BLIZZMOVE_ENABLE_TITLE,
		BLIZZMOVE_ENABLE_TITLE_TOOLTIP,
		"EnableBlizzMove",
		1,
		function (__arg)
			if ( __arg == 1 ) then
				if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
					BigFoot_LoadAddOn("BlizzMove");
					BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
				end	
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("BlizzMove")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(BLIZZMOVE_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		function(__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BlizzMove")) then
					BigFoot_LoadAddOn("BlizzMove");
				end
			end
		end
	);
end

if (IsConfigurableAddOn("BFGOldFrame")) then
	ModManagement_RegisterCheckBox(
		"InfoBox",
		BFGOLDFRAME_ENABLE_TITLE,
		BFGOLDFRAME_ENABLE_TITLE_TOOLTIP,
		"EnableBFGoldFrame",
		nil,
		function (__arg)
			if ( __arg == 1 ) then
				if (not BigFoot_IsAddOnLoaded("BFGOldFrame")) then
					BigFoot_LoadAddOn("BFGOldFrame");					
				end	
				BFGoldFrame_Toggle(true)
	
			else
				if ( BigFoot_IsAddOnLoaded("BFGOldFrame")) then
					BFGoldFrame_Toggle(false)
				end
			end
		end,
		nil
	);
end
