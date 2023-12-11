
if (GetLocale() == "zhCN") then
	AUTOEQUIP_TITLE = {"一键换装", "zidonghuanzhuang"};
	
	AUTOEQUIP_ENABLE = "允许一键换装";
	AUTOEQUIP_ENABLE_TOOLTIP="在玩家头像上方显示一个快捷保存及换装的选项条"
	
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "团队隐藏";
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP="当玩家在团队中时隐藏换装选项条"
	
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "启用增强模式";
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP="强化一键换装，在屏幕中间显示一个按shift可移动的8套备选方案选项条"

	AUTOEQUIP_KEY_BINDING = "按键绑定";
	
elseif (GetLocale() == "zhTW") then
	AUTOEQUIP_TITLE = {"一鍵換裝", "zidonghuanzhuang"};
	
	AUTOEQUIP_ENABLE = "允許一鍵換裝";
	AUTOEQUIP_ENABLE_TOOLTIP= "在玩家頭像上方顯示一個快捷保存及換裝的選項條";
	
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "團隊隱藏";
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP= "當玩家在團隊中時隱藏換裝選項條";
	
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "啟用增強模式";
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP= "強化一鍵換裝，在屏幕中間顯示一個按shift可移動的8套備選方案選項條";

	AUTOEQUIP_KEY_BINDING = "按鍵綁定";
	
else
	AUTOEQUIP_TITLE = "Auto Equip";
	
	AUTOEQUIP_ENABLE = "Enable Auto Equip";
	AUTOEQUIP_ENABLE_RAID_AUTOHIDE = "Hide UI when you are in raid";
	AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE = "Enahcned mode with 8 sets";
	AUTOEQUIP_KEY_BINDING = "Key Binding";
	
end

if (IsConfigurableAddOn("AutoEquip")) then
	ModManagement_RegisterMod(
		"AutoEquip",
		"Interface\\Icons\\INV_Gizmo_04",
		AUTOEQUIP_TITLE,
		"",
		nil,
		nil,
		{[7]=true},
		true,
		"214"
	);
	
	ModManagement_RegisterCheckBox(
		"AutoEquip",
		AUTOEQUIP_ENABLE,
		AUTOEQUIP_ENABLE_TOOLTIP,
		"EnableAutoEquip",
		0,
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("AutoEquip")) then
					BigFoot_LoadAddOn("AutoEquip");
				end

				if (BigFoot_IsAddOnLoaded("AutoEquip")) then
					AutoEquip_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("AutoEquip")) then
					AutoEquip_Toggle(false);
				end
			end
		end
	);
	
	ModManagement_RegisterCheckBox(
		"AutoEquip",
		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE,
		AUTOEQUIP_ENABLE_RAID_ADVANCED_MODE_TOOLTIP,
		"EnableAdvancedMode",
		0,
		function (__arg)
			if (BigFoot_IsAddOnLoaded("AutoEquip")) then
				if (__arg == 1) then
					AutoEquip_ToggleMode("advance");
				else
					AutoEquip_ToggleMode("normal");
				end
			end
		end,
		1
	);

	ModManagement_RegisterCheckBox(
		"AutoEquip",
		AUTOEQUIP_ENABLE_RAID_AUTOHIDE,
		AUTOEQUIP_ENABLE_RAID_AUTOHIDE_TOOLTIP,
		"EnableAutoHide",
		0,
		function (__arg)
			if (BigFoot_IsAddOnLoaded("AutoEquip")) then
				if (__arg == 1) then
					AutoEquip_EnableAutoHide(true);
				else
					AutoEquip_EnableAutoHide(false);
				end
			end
		end,
		1
	);
	
	ModManagement_RegisterButton(
		"AutoEquip",
		AUTOEQUIP_KEY_BINDING,
		function ()
			if (BigFoot_IsAddOnLoaded("AutoEquip")) then
				AutoEquip_KeyBinding();
			end
		end,
		nil,
		1
	);
end
