if (GetLocale() == "zhCN") then
	MOD_PALLY_POWER_TITLE = {"祝福助手", "zhufuzhushou"}
	PALLY_POWER_ENABLE_TEXT = "开启骑士祝福助手"			--目前其他职业也能开启。骑士号开启后，此账号内的所有号都将开启
	PALLY_POWER_ENABLE_TEXT_TOOLTIP= "方便监视及设置小队及团队中的祝福"
elseif (GetLocale() == "zhTW") then
	MOD_PALLY_POWER_TITLE = {"祝福助手", "zhufuzhushou"}
	PALLY_POWER_ENABLE_TEXT = "開啟騎士祝福助手"
	PALLY_POWER_ENABLE_TEXT_TOOLTIP= "方便監視及設置小隊及團隊中的祝福"
else
	MOD_PALLY_POWER_TITLE = "Pally Power"
	PALLY_POWER_ENABLE_TEXT = "Enable Pally Power"
end


if  (IsConfigurableAddOn("PallyPower")) then
	ModManagement_RegisterMod(
		"PallyPower",
		"Interface\\Icons\\spell_magic_greaterblessingofkings",
		MOD_PALLY_POWER_TITLE,
		"",
		nil,
		nil,
		{[7]=true}
	);
	
	ModManagement_RegisterCheckBox(
		"PallyPower",
		PALLY_POWER_ENABLE_TEXT,
		PALLY_POWER_ENABLE_TEXT_TOOLTIP,
		"EnablePallyPower",
		0, 
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("PallyPower")) then
					BigFoot_LoadAddOn("PallyPower");
				end
				PallyPower:OnEnable()
			else
				if BigFoot_IsAddOnLoaded("PallyPower") then
					PallyPower:OnDisable()
				end
			end
		end
	);
end
