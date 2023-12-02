if (GetLocale() == "zhCN") then
	MOD_MOB_HEALTH_TITLE = {"目标信息", "guaiwuxinxi"};
	
	MOB_AGGRO_ENABLE_TEXT = "开启目标的目标及仇恨提示";	
	MOB_AGGRO_TOOLTIP = "开启该功能可以使你监视目标的目标并给予相应的警告。该监视窗口位于目标头像下方，你也可以通过按住Shift键来拖动该监视窗口。";
	
	MOB_HEALTH_ENABLE_TEXT = "开启目标生命";
	MOB_HEALTH_ENABLE_TEXT_TOOLTIP= "设置目标生命及魔法值的显示模式";
	
	MOB_HEALTH_SHOW_HEALTH_PPT = "生命值";	
	MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP= "显示目标生命值";	
	
	MOB_HEALTH_SHOW_HEALTH_FORMAT = "以万为单位计算血量";	
	
	MOB_HEALTH_SHOW_MANA_POINT = "魔法值";
	MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP= "显示目标魔法值";	
	
	MOB_HEALTH_SHOW_HEALTH_PERCENT = "百分比";	--自带的不能同时显示百分比和数值
	MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP= "同时显示数值与百分比";	
	
	MOB_HEALTH_TRANSPARENT_MODE = "半透明模式";
	MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP= "将显示的值透明化";	
	
elseif (GetLocale() == "zhTW") then
	MOD_MOB_HEALTH_TITLE = {"目標信息", "guaiwuxinxi"};
	
	MOB_AGGRO_ENABLE_TEXT = "開啟目標的目標及仇恨提示";
	MOB_AGGRO_TOOLTIP = "開啓該功能可以使你監視目標的目標並給予相應的警告。該監視窗口位于目標頭像下方，你也可以通過按住Shift鍵來拖動該監視窗口。";
	
	MOB_HEALTH_ENABLE_TEXT = "開啟目標生命";	
	MOB_HEALTH_ENABLE_TEXT_TOOLTIP= "設置目標生命及魔法值的顯示模式";	
	
	MOB_HEALTH_SHOW_HEALTH_PPT = "生命值";	
	MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP= "顯示目標生命值";	

	MOB_HEALTH_SHOW_HEALTH_FORMAT = "以萬為單位計算血量";	
	
	MOB_HEALTH_SHOW_MANA_POINT = "魔法值";
	MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP= "顯示目標魔法值";
	
	MOB_HEALTH_SHOW_HEALTH_PERCENT = "百分比";
	MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP= "同時顯示數值與百分比";
	
	MOB_HEALTH_TRANSPARENT_MODE = "半透明模式";
	MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP= "將顯示的值透明化";
else
	MOD_MOB_HEALTH_TITLE = "Mob Health";
	
	MOB_AGGRO_ENABLE_TEXT = "Enable MobAggro";
	MOB_AGGRO_TOOLTIP = "Help you monitor the target of mob and give reposible warning. The monitor window locates below the target window. You can move it by draging with holding shift key.";

	MOB_HEALTH_ENABLE_TEXT = "Enable Mob Health";	
	MOB_HEALTH_SHOW_HEALTH_PPT = "Show mob health";
	MOB_HEALTH_SHOW_HEALTH_FORMAT = "Calculate HP using W"
	MOB_HEALTH_SHOW_MANA_POINT = "Show target mana";
	MOB_HEALTH_SHOW_HEALTH_PERCENT = "Show mob health percentage";
	MOB_HEALTH_TRANSPARENT_MODE = "Transparent mode";
end
if IsConfigurableAddOn("MobHealth") or IsConfigurableAddOn("MobAggro") then
	ModManagement_RegisterMod(
		"MobHealth",
		"Interface\\Icons\\Spell_Shadow_BloodBoil",
		MOD_MOB_HEALTH_TITLE,
		"",
		nil,
		nil,
		{[3]=true}

	);
	if IsConfigurableAddOn("MobHealth")  then
		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_ENABLE_TEXT,
			nil,
			"MobHealthEnable",
			1,
			function(arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("MobHealth")) then
						BigFoot_LoadAddOn("MobHealth");
					end

					if (BigFoot_IsAddOnLoaded("MobHealth")) then
						MobHealth_Toggle(arg);
					end
				else
					if (BigFoot_IsAddOnLoaded("MobHealth")) then
						MobHealth_Toggle(arg);
					end
				end
			end
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_PPT,
			MOB_HEALTH_SHOW_HEALTH_PPT_TOOLTIP,
			"ShowHealthPPT",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowHealth = true;
				else
					MobHealth_ShowHealth = nil;
				end

				MobHealth_Display();
			end,
			1
		);	
		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_FORMAT,
			nil,
			"ShowHealthFormat",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_UseFormatted = true;
				else
					MobHealth_UseFormatted = nil;
				end

				MobHealth_Display();
			end,
			2
		);	

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_MANA_POINT,
			MOB_HEALTH_SHOW_MANA_POINT_TOOLTIP,
			"ShowManaPoint",
			1,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowMana = true;
				else
					MobHealth_ShowMana = nil;
				end

				MobHealth_Display();
			end,
			1
		);

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_SHOW_HEALTH_PERCENT,
			MOB_HEALTH_SHOW_HEALTH_PERCENT_TOOLTIP,
			"ShowHealthPercentv2",
			nil,
			function(arg)
				if (arg == 1) then
					MobHealth_ShowHealthPercent = true;
				else
					MobHealth_ShowHealthPercent = nil;
				end

				MobHealth_Display();
			end,
			1
		);	

		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_HEALTH_TRANSPARENT_MODE,
			MOB_HEALTH_TRANSPARENT_MODE_TOOLTIP,
			"TransparentMode",
			nil,
			function(arg)
				if (arg == 1) then	
					MobHealthFrame:SetAlpha(0.7);
				else
					MobHealthFrame:SetAlpha(1.0);
				end
			end,
			1
		);	
	end
	if (IsConfigurableAddOn("MobAggro")) then
		ModManagement_RegisterCheckBox(
			"MobHealth",
			MOB_AGGRO_ENABLE_TEXT,
			MOB_AGGRO_TOOLTIP,
			"EnableMobAggroV2",
			0,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("MobAggro")) then
						BigFoot_LoadAddOn("MobAggro");
					end

					if (BigFoot_IsAddOnLoaded("MobAggro")) then
						MobAggro_Toggle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("MobAggro")) then
						MobAggro_Toggle(false);
					end
				end
			end
		);
	end
end