
if (GetLocale() == "zhCN") then
	MOUNT_ENHANCE_MOD_TEXT = {"坐骑增强", "zuoqizengqiang"};
	
	MOUNT_ENHANCE_ENABLE_TEXT = "使用坐骑增强"
	MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP="支持随机召唤坐骑功能"
	
elseif (GetLocale() == "zhTW") then
	MOUNT_ENHANCE_MOD_TEXT = {"坐騎增強", "zuoqizengqiang"};
	
	MOUNT_ENHANCE_ENABLE_TEXT = "使用坐騎增強"
	MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP= "支持隨機召喚坐騎功能"
	
else
	MOUNT_ENHANCE_MOD_TEXT = "Mount Enhance";
	MOUNT_ENHANCE_ENABLE_TEXT = "Enable Mount Enhance"
end

if (IsConfigurableAddOn("BFMount")) and GetLocale() =='zhCN' then
	
	ModManagement_RegisterMod(
		"BFMount",
		"Interface\\Icons\\ability_mount_charger",
		MOUNT_ENHANCE_MOD_TEXT,
		"",
		nil,
		nil,
		{[7]=true}
	);

	ModManagement_RegisterCheckBox(
		"BFMount",
		MOUNT_ENHANCE_ENABLE_TEXT,
		MOUNT_ENHANCE_ENABLE_TEXT_TOOLTIP,
		"EnableMountEnhance",
		1,
		function (arg)
			if ( arg == 1 ) then
				if (not BigFoot_IsAddOnLoaded("BFMount")) then
					BigFoot_LoadAddOn("BFMount");
				end
				
				if (BigFoot_IsAddOnLoaded("BFMount")) then
					BFMount:Enable();
				end
			else
				if (BigFoot_IsAddOnLoaded("BFMount")) then
					BFMount:Disable();
				end
			end
		end
	);

	
end