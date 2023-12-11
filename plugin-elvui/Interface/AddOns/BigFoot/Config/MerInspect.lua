
if (GetLocale() == "zhCN" or GetLocale() == "zhTW") then
	if (GetLocale() == "zhCN") then
		MOD_INFO_STAT_TITLE = {"装备信息", "zhuangbeixinxi"};
		
		MOD_INFO_COMPARISON_STAT_COMPARE = "开启装备属性统计";
		MOD_INFO_COMPARISON_STAT_COMPARE_TOOLTIP="在装备栏右边显示统计当前装备属性总和"
		
		MDO_INFO_ENABLE_DURABILITY = "显示装备耐久度";
		MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物装备图标右下角显示装备剩余耐久度";
		
		MDO_INFO_ENABLE_HIGHLIGHT = "高亮装备栏边框";
		MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根据装备品质高亮显示装备栏边框";
		
		QUICK_COMPARE_ENABLE = "启用装备比较";	---新版自帶
		
		MOD_INFO_RATING_BUSTER = "开启装备属性分析"
		MOD_INFO_RATING_BUSTER_TOOLTIP= "根据人物当前等级将装备说明上的爆击等级、命中等级等换算成直观的百分比。"
		
		RATING_BUSTER_SETTINGS = "装备属性设置"
		
		MOD_INFO_ENABLE_GS = "启用装备计分"
		MOD_INFO_ENABLE_GS_TOOLTIP= "显示玩家装备的评分"
		
	elseif (GetLocale() == "zhTW") then
		MOD_INFO_STAT_TITLE = {"裝備信息", "zhuangbeixinxi"};
		
		MOD_INFO_COMPARISON_STAT_COMPARE = "啟用裝備屬性統計";
		MOD_INFO_COMPARISON_STAT_COMPARE_TOOLTIP= "在裝備欄右邊顯示統計當前裝備屬性總和";
		
		MDO_INFO_ENABLE_DURABILITY = "顯示裝備耐久度";
		MDO_INFO_ENABLE_DURABILITY_TOOLTIP= "在人物裝備圖標右下角顯示裝備剩餘耐久度";
		
		MDO_INFO_ENABLE_HIGHLIGHT = "高亮裝備欄邊框";
		MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP= "根據裝備品質高亮顯示裝備欄邊框";
		
		QUICK_COMPARE_ENABLE = "開啟裝備比較";
		
		MOD_INFO_RATING_BUSTER = "開啟裝備屬性分析"
		MOD_INFO_RATING_BUSTER_TOOLTIP= "根據人物當前等級將裝備說明上的暴擊等級、命中等級等換算成直觀的百分比"
		
		RATING_BUSTER_SETTINGS = "裝備屬性設置"
		
		MOD_INFO_ENABLE_GS = "啟用裝備計分"
		MOD_INFO_ENABLE_GS_TOOLTIP= "顯示玩家裝備的評分"
		
	else
		MOD_INFO_STAT_TITLE = "Info Stat";

		MOD_INFO_COMPARISON_STAT_COMPARE = "Enable Equitment Stat";
		MDO_INFO_ENABLE_DURABILITY = "Display Durability";
		MDO_INFO_ENABLE_HIGHLIGHT = "High light border";
		MOD_INFO_RATING_BUSTER = "Enable Rating Buster"
		RATING_BUSTER_SETTINGS = "Rating Buster Settings"
		QUICK_COMPARE_ENABLE = "Enable Quick Compare";
		MOD_INFO_ENABLE_GS = "Enable GearScoreLite"
	end

	ModManagement_RegisterMod(
		"InfoStat",
		"Interface\\Icons\\INV_Jewelry_Necklace_22",
		MOD_INFO_STAT_TITLE,
		"",
		nil,
		nil,
		{[3]=true,[5]=true}
	);

	if (IsConfigurableAddOn("MerInspect") ) then
		ModManagement_RegisterCheckBox(
			"InfoStat",
			MOD_INFO_COMPARISON_STAT_COMPARE,
			MOD_INFO_COMPARISON_STAT_COMPARE_TOOLTIP,
			"EnableMerInspect",
			1,
			function (arg)
				if ( arg == 1 ) then
					if (not BigFoot_IsAddOnLoaded("MerInspect")) then
						BigFoot_LoadAddOn("MerInspect");
					end
					
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_Toggle(false);
					end
				end
			end
		);
		ModManagement_RegisterCheckBox(
			"InfoStat",
			MDO_INFO_ENABLE_DURABILITY,
			MDO_INFO_ENABLE_DURABILITY_TOOLTIP,
			"DisplayDurability",
			1,
			function (arg)
				if ( arg == 1 ) then				
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_ToogleD(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_ToogleD(false);
					end
				end
			end,
			1
		);
		ModManagement_RegisterCheckBox(
			"InfoStat",
			MDO_INFO_ENABLE_HIGHLIGHT,
			MDO_INFO_ENABLE_HIGHLIGHT_TOOLTIP,
			"DisplayItemQulity",
			1,
			function (arg)
				if ( arg == 1 ) then				
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_ToogleH(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("MerInspect")) then
						MerInspect_ToogleH(false);
					end
				end
			end,
			1
		);
	end


	
	if (IsConfigurableAddOn("QuickCompare")) then	
		ModManagement_RegisterCheckBox(
		"InfoStat",
		QUICK_COMPARE_ENABLE,
		nil,
		"EnableQuickCompare",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("QuickCompare")) then
					BigFoot_LoadAddOn("QuickCompare");
				end
				if (BigFoot_IsAddOnLoaded("QuickCompare")) then
					QuickCompare_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("QuickCompare")) then
					QuickCompare_Toggle(false);					
				end
			end
		end
		);
	end
	if GetLocale()=='zhCN' and IsConfigurableAddOn("RatingBuster") then
			ModManagement_RegisterCheckBox(
				"InfoStat",
				MOD_INFO_RATING_BUSTER,
				MOD_INFO_RATING_BUSTER_TOOLTIP,
				"RatingBuster",
				1,
				function (arg)
					if ( arg == 1 ) then
						if (not BigFoot_IsAddOnLoaded("RatingBuster")) then
							BigFoot_LoadAddOn("RatingBuster");
						end

						if (BigFoot_IsAddOnLoaded("RatingBuster")) then
							RatingBuster:Enable();
						end
					else
						if (BigFoot_IsAddOnLoaded("RatingBuster")) then
							RatingBuster:Disable();
						end
					end
				end		
			);
			ModManagement_RegisterButton(
				"InfoStat",
				RATING_BUSTER_SETTINGS,
				function()
					if BigFoot_IsAddOnLoaded("RatingBuster")  then
						RatingBuster:ShowConfig()
						PlaySound("igMainMenuOption");
						HideUIPanel(ModManagementFrame);
					end
				end,
				nil,
				1
			);
	end	
	ModManagement_RegisterCheckBox(
		"InfoStat",
		MOD_INFO_ENABLE_GS,
		MOD_INFO_ENABLE_GS_TOOLTIP,
		"EnableGearScore",
		1,
		function (arg)
			if ( arg == 1 ) then				
				if IsAddOnLoaded("GearScoreLite") then
					GS_Toggle(true);
				end
			else
				if IsAddOnLoaded("GearScoreLite") then
					GS_Toggle(false);
				end
			end
		end
	)
end
