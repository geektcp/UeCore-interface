
if (GetLocale() == "zhCN") then
	BIGFOOT_TOOLTIP = {"鼠标提示", "shubiaotishi"};
	
	ENABLE_BIGFOOT_TOOLTIP = "启用KK魔兽鼠标提示";
	ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "扩展增强了普通鼠标提示信息";
	
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠标", "左上", "顶部", "右上", "左侧", "中心", "右侧", "左下", "底部", "右下"}, nil, NONE },
		[2] = { "BigFootTooltipPositionX", "X轴偏移:", nil, {-300, 300, 5}, -20 },
		[3] = { "BigFootTooltipPositionY", "Y轴偏移:", nil, {-300, 300, 5}, -25 },
		[4] = { "BigFootTooltipFade", "渐隐提示:", {"否", "是"}, nil,  "是"},
		[5] = { "BigFootTooltipTalent", "天赋信息:", {"隐藏", "显示"}, nil, "显示" },
		[6] = { "BigFootTooltipCorpse", "尸体信息:", {"隐藏", "显示"}, nil, "显示" },
		[7] = { "BigFootTooltipToT", "目标的目标:", {"隐藏", "显示"}, nil, "显示" },
		[8] = { "BigFootTooltipPvP", "PvP:", {"显示", "隐藏"}, nil, "隐藏" },
		[9] = { "BigFootTooltipGuildRank", "公会阶级:", {"显示", "隐藏"}, nil, "隐藏" },
	};
	
elseif (GetLocale() == "zhTW") then
	BIGFOOT_TOOLTIP = {"鼠標提示", "shubiaotishi"};
	
	ENABLE_BIGFOOT_TOOLTIP = "啟用大腳鼠標提示";
	ENABLE_BIGFOOT_TOOLTIP_TOOLTIP= "擴展增強了普通鼠標提示信息";
	
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "提示位置:", {NONE, "鼠標", "左上", "頂部", "右上", "左側", "中心", "右側", "左下", "底部", "右下"}, nil, NONE },
		[2] = { "BigFootTooltipPositionX", "X軸偏移:", nil, {-300, 300, 5}, -20 },
		[3] = { "BigFootTooltipPositionY", "Y軸偏移:", nil, {-300, 300, 5}, -25 },
		[4] = { "BigFootTooltipFade", "漸隱提示:", {"否", "是"}, nil, "是" },
		[5] = { "BigFootTooltipTalent", "天賦信息:", {"隱藏", "顯示"}, nil, "顯示" },
		[6] = { "BigFootTooltipCorpse", "屍體信息:", {"隱藏", "顯示"}, nil, "顯示" },
		[7] = { "BigFootTooltipToT", "目標的目標:", {"隱藏", "顯示"}, nil, "顯示" },
		[8] = { "BigFootTooltipPvP", "PvP:", {"顯示", "隱藏"}, nil, "隱藏" },
		[9] = { "BigFootTooltipGuildRank", "公會階級:", {"顯示", "隱藏"}, nil, "隱藏" },
	};
	
else
	BIGFOOT_TOOLTIP = "BigFoot Tooltip";
	
	ENABLE_BIGFOOT_TOOLTIP = "Enable BigFoot Tooltip";
	BIGFOOT_TOOLTIP_OPTION = {
		[1] = { "BigFootTooltipPosition", "Position:", {NONE, "Following Mouse", "Top Left", "Top", "Top Right", "Left", "Center", "Right", "Bottom Left", "Bottom", "Bottom Right"}, nil, NONE },
		[2] = { "BigFootTooltipPositionX", "PositionX:", nil, {-300, 300, 5}, -20 },
		[3] = { "BigFootTooltipPositionY", "PositionY:", nil, {-300, 300, 5}, -25 },
		[4] = { "BigFootTooltipFade", "Fade:", {"No", "Yes"}, nil, "Yes" },
		[5] = { "BigFootTooltipTalent", "Talent:", {"Hide", "Show"}, nil, "Show" },
		[6] = { "BigFootTooltipCorpse", "Corpse:", {"Hide", "Show"}, nil, "Show" },
		[7] = { "BigFootTooltipToT", "ToT:", { "Hide", "Show"}, nil, "Show" },
		[8] = { "BigFootTooltipPvP", "PvP:", {"Show", "Hide"}, nil, "Hide" },
		[9] = { "BigFootTooltipGuildRank", "Guild Rank", {"Show", "Hide"}, nil, "Hide" },
	};
end

if (IsConfigurableAddOn("BFTooltip")) then
	ModManagement_RegisterMod( 
		"BFTT", 
		"Interface\\Icons\\INV_Misc_Coin_09", 
		BIGFOOT_TOOLTIP, 
		"", 
		nil,
		nil,
		{[3]=true}

	);

	ModManagement_RegisterCheckBox(
		"BFTT",
		ENABLE_BIGFOOT_TOOLTIP,
		ENABLE_BIGFOOT_TOOLTIP_TOOLTIP,
		"EnableBFTooltip",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFTooltip")) then
					BigFoot_LoadAddOn("BFTooltip");
				end
				
				if (BigFoot_IsAddOnLoaded("BFTooltip")) then
					BFTT_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BFTooltip")) then
					BFTT_Toggle(false);
				end
			end
		end
	);

	for i, info in ipairs(BIGFOOT_TOOLTIP_OPTION) do
		if (info[4]) then
			ModManagement_RegisterSpinBox(
				"BFTT",
				info[2], 
				nil,
				info[1],
				"range",
				info[4],
				info[5], 
				function(arg)
					if (BigFoot_IsAddOnLoaded("BFTooltip")) then
						BFTT_OPTION_FUNC[i](arg);
					end
				end,
				1
			);
		else
			ModManagement_RegisterSpinBox(
				"BFTT",
				info[2], 
				nil,
				info[1],
				"list",
				info[3],
				info[5], 
				function(arg)
					if (BigFoot_IsAddOnLoaded("BFTooltip")) then
						BFTT_OPTION_FUNC[i](arg);
					end
				end,
				1
			);
		end		
	end
end
