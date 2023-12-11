
if (GetLocale() == "zhCN") then
	BF_UNITFRAME_TEXT = {"KK魔兽头像", "dajiaotouxiang"};
	
	ENABLE_BF_UNITFRAME = "开启额外头像";
	ENABLE_BF_UNITFRAME_TOOLTIP= "提供一个监视非当前目标的框体";
	
	FOCUS_UNITFRAME = "焦点头像";
	FOCUS_NORMAL_MODE = "普通模式";
	FOCUS_SIMPLE_MODE = "简单模式";
	FOCUS_DEFAULT_MODE = "系统自带";
	FOCUS_CLOSE_MODE = "关闭";
	FOCUS_UNITFRAME_TOOLTIP= "焦点头像:普通模式,简单模式,系统自带";
	
	ENABLE_TARGETTARGET_UNITFRAME = "显示目标的目标头像";
	ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目标头像下显示其目标的小框体，与系统自带的目标的目标冲突";
	
	ENABLE_TARGETTARGETTARGET_UNITFRAME = "目标目标目标头像";
	ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目标的目标头像下显示其目标的小框体";
	
	ENABLE_CASTING_SHINING = "目标施法闪光";
	ENABLE_CASTING_SHINING_TOOLTIP= "在开启目标的目标或简单模式焦点目标时，目标施法时头像高亮闪光";
	
	ENABLE_CASTING_ICON = "目标法术提示";
	ENABLE_CASTING_ICON_TOOLTIP= "在开启目标的目标或简单模式焦点目标时，目标施法时头像变为法术图标";
elseif (GetLocale() == "zhTW") then
	BF_UNITFRAME_TEXT = {"大腳頭像", "dajiaotouxiang"};
	
	ENABLE_BF_UNITFRAME = "開啟額外頭像";
	ENABLE_BF_UNITFRAME_TOOLTIP= "提供一個監視非當前目標的框體";
	
	FOCUS_UNITFRAME = "焦點頭像";
	FOCUS_NORMAL_MODE = "普通模式";
	FOCUS_SIMPLE_MODE = "簡單模式";
	FOCUS_DEFAULT_MODE = "系統自帶";
	FOCUS_CLOSE_MODE = "關閉";
	FOCUS_UNITFRAME_TOOLTIP= "焦點頭像：普通模式，簡單模式，系統自帶";
	
	ENABLE_TARGETTARGET_UNITFRAME = "顯示目標的目標頭像";
	ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP= "在目標頭像下顯示其目標的小框體，與系統自帶的目標的目標衝突";
	
	ENABLE_TARGETTARGETTARGET_UNITFRAME = "目標目標目標頭像";
	ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP= "在目標的目標頭像下顯示其目標的小框體";
	
	ENABLE_CASTING_SHINING = "施法時頭像閃光";
	ENABLE_CASTING_SHINING_TOOLTIP= "在開啟目標的目標或簡單模式焦點目標時，目標施法時頭像高亮閃光";
	
	ENABLE_CASTING_ICON = "施法時頭像變為法術圖示";
	ENABLE_CASTING_ICON_TOOLTIP= "在開啟目標的目標或簡單模式焦點目標時，目標施法時頭像變為法術圖標";
else
	BF_UNITFRAME_TEXT = "BigFoot UnitFrame";
	
	ENABLE_BF_UNITFRAME = "Enable Unit Frame";
	FOCUS_UNITFRAME = "Focus";
	FOCUS_NORMAL_MODE = "Normal Mode";
	FOCUS_SIMPLE_MODE = "Simple Mode";
	FOCUS_DEFAULT_MODE = "Default Mode";
	FOCUS_CLOSE_MODE = "Close";
	ENABLE_TARGETTARGET_UNITFRAME = "ToT Frame";
	ENABLE_TARGETTARGETTARGET_UNITFRAME = "ToToT Frame";
	ENABLE_CASTING_SHINING = "Shining when casting";
	ENABLE_CASTING_ICON = "Show spell icon when casting";
end

function ToggleDefaultFocusFrame(switch)
	if (switch) then
		FocusFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
		FocusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
		FocusFrame:RegisterEvent("UNIT_HEALTH");
		FocusFrame:RegisterEvent("UNIT_LEVEL");
		FocusFrame:RegisterEvent("UNIT_FACTION");
		FocusFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
		FocusFrame:RegisterEvent("UNIT_AURA");
		FocusFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		FocusFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
		FocusFrame:RegisterEvent("RAID_TARGET_UPDATE");
		FocusFrame:RegisterEvent("VARIABLES_LOADED");
		TargetFrame_CheckFaction(FocusFrame)
		TargetFrame_CheckLevel(FocusFrame)
		TargetFrame_UpdateAuras(FocusFrame);
		TargetFrame_CheckDead(FocusFrame);
		UnitFrame_Update(FocusFrame);
		FocusFrame:Show();
	else
		FocusFrame:UnregisterAllEvents();
		FocusFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
		FocusFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		FocusFrame:Hide();
	end
end

if (IsConfigurableAddOn("BUnitFrame")) then
	ModManagement_RegisterMod( 
		"BUnitFrame", 
		"Interface\\Icons\\ABILITY_SEAL", 
		BF_UNITFRAME_TEXT, 
		"", 
		nil, 
		nil,
		{[3]=true}

	);

	ModManagement_RegisterCheckBox(
		"BUnitFrame",
		ENABLE_BF_UNITFRAME,
		ENABLE_BF_UNITFRAME_TOOLTIP,
		"EnableBUnitFrame",
		1,
		function (arg)
			if (arg == 1) then
				if (BigFoot_LoadAddOn("BUnitFrame")) then
					BUnitFrame_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_Toggle(false);
				end
			end
		end
	);

	local modes = {};
	local _, euf = GetAddOnInfo("EN_UnitFrames");
	if (IsConfigurableAddOn("MyFocusFrame") and euf == nil) then
		table.insert(modes, FOCUS_NORMAL_MODE);
	end
	table.insert(modes, FOCUS_SIMPLE_MODE);
	table.insert(modes, FOCUS_DEFAULT_MODE);
	table.insert(modes, FOCUS_CLOSE_MODE);

	ModManagement_RegisterSpinBox(
		"BUnitFrame",
		FOCUS_UNITFRAME,
		FOCUS_UNITFRAME_TOOLTIP,
		"FocusMode",
		"list",
		modes,
		FOCUS_NORMAL_MODE,
		function (arg)
			if (arg == FOCUS_NORMAL_MODE) then
				if (IsConfigurableAddOn("MyFocusFrame")) then
					if (BigFoot_LoadAddOn("MyFocusFrame")) then
						MyFocusFrame_Toggle(true);
					end
				end

				if (BigFoot_IsAddOnLoaded("MyFocusFrame")) then
					BUnitFrame_FocusFrame_Toggle(false);
				end
				ToggleDefaultFocusFrame(false);
			elseif (arg == FOCUS_SIMPLE_MODE) then
				if (BigFoot_IsAddOnLoadedFromBigFoot("MyFocusFrame")) then
					MyFocusFrame_Toggle(false);
					
				elseif (BigFoot_IsAddOnLoadedFromOther("MyFocusFrame")) then
					MyFocusFrame_Toggle(true);
				end

				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_FocusFrame_Toggle(true);
				end
				ToggleDefaultFocusFrame(false);
			elseif (arg == FOCUS_DEFAULT_MODE) then
				if (BigFoot_IsAddOnLoaded("MyFocusFrame")) then
					MyFocusFrame_Toggle(false);
				end

				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_FocusFrame_Toggle(false);
				end
				ToggleDefaultFocusFrame(true);
			else
				if (BigFoot_IsAddOnLoaded("MyFocusFrame")) then
					MyFocusFrame_Toggle(false);
				end

				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_FocusFrame_Toggle(false);
				end
				ToggleDefaultFocusFrame(false);
			end
		end,
		1
	);


	ModManagement_RegisterCheckBox(
		"BUnitFrame",
		ENABLE_TARGETTARGET_UNITFRAME,
		ENABLE_TARGETTARGET_UNITFRAME_TOOLTIP,
		"EnableTargetTarget",
		0,
		function (arg)
			if (arg == 1) then
				if (BigFoot_LoadAddOn("BUnitFrame")) then
					BUnitFrame_TargetTargetFrame_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_TargetTargetFrame_Toggle(false);
				end
			end
		end,
		1
	);

	ModManagement_RegisterCheckBox(
		"BUnitFrame",
		ENABLE_TARGETTARGETTARGET_UNITFRAME,
		ENABLE_TARGETTARGETTARGET_UNITFRAME_TOOLTIP,
		"EnableTargetTargetTarget",
		0,
		function (arg)
			if (arg == 1) then
				if (BigFoot_LoadAddOn("BUnitFrame")) then
					BUnitFrame_TargetTargetTargetFrame_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_TargetTargetTargetFrame_Toggle(false);
				end
			end
		end,
		2
	);

	ModManagement_RegisterCheckBox(
		"BUnitFrame",
		ENABLE_CASTING_SHINING,
		ENABLE_CASTING_SHINING_TOOLTIP,
		"EnableCastingShining",
		1,
		function (arg)
			if (arg == 1) then
				if (BigFoot_LoadAddOn("BUnitFrame")) then
					BUnitFrame_CastingShining_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_CastingShining_Toggle(false);
				end
			end
		end,
		1
	);

	ModManagement_RegisterCheckBox(
		"BUnitFrame",
		ENABLE_CASTING_ICON,
		ENABLE_CASTING_ICON_TOOLTIP,
		"EnableCastingIcon",
		1,
		function (arg)
			if (arg == 1) then
				if (BigFoot_LoadAddOn("BUnitFrame")) then
					BUnitFrame_CastingIcon_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("BUnitFrame")) then
					BUnitFrame_CastingIcon_Toggle(false);
				end
			end
		end,
		1
	);

end
