if (GetLocale() == "zhCN") then
	MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}
	
	REPAIRHELPER_ENABLE_TEXT = "开启修理助手"
	REPAIRHELPER_ENABLE_TEXT_TOOLTIP= "允许玩家设置及自动修理装备"
	
	REPAIRHELPER_AUTO_REPAIR_TEXT = "自动修理当前装备"
	REPAIRHELPER_AUTO_REPAIR_TEXT_TOOLTIP= "与可修理的NPC对话自动修理当前身上穿的破损装备"
	
	REPAIRHELPER_REPAIR_ALL_TEXT = "自动修理所有装备"
	REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP="与可修理的NPC对话自动修理所有的破损装备"
	
	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "优先使用公会资金"
	
elseif (GetLocale() == "zhTW") then
	MOD_REPAIR_HELPER_TITLE = {"修理助手", "xiulizhushou"}
	
	REPAIRHELPER_ENABLE_TEXT = "開啓修理助手"
	REPAIRHELPER_ENABLE_TEXT_TOOLTIP= "允許玩家設置及自動修理裝備"
	
	REPAIRHELPER_AUTO_REPAIR_TEXT = "自動修理當前裝備"
	REPAIRHELPER_AUTO_REPAIR_TEXT_TOOLTIP= "與可修理的NPC對話自動修理當前身上穿的破損裝備"
	
	REPAIRHELPER_REPAIR_ALL_TEXT = "自動修理身上所有的的裝備"
	REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP= "與可修理的NPC對話自動修理當所有的破損裝備"
	
	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "優先使用公會資金"	
else
	MOD_REPAIR_HELPER_TITLE = "Repair Helper"
	
	REPAIRHELPER_ENABLE_TEXT = "Enable Repair Helper"
	REPAIRHELPER_ENABLE_TEXT_TOOLTIP= "Allow Player to repair their gears automatically"
	
	REPAIRHELPER_AUTO_REPAIR_TEXT = "Repair gears automatically"
	
	REPAIRHELPER_REPAIR_ALL_TEXT = "Repair all gears automatically"
	
	REPAIRHELPER_USE_GUILD_MONEY_TEXT = "Use Guild Gold"
end

	ModManagement_RegisterMod(
		"RepairHelper",
		"Interface\\Icons\\trade_blacksmithing",
		MOD_REPAIR_HELPER_TITLE,
		"",
		nil,
		nil,
		{[5]=true}
	);

	
	ModManagement_RegisterCheckBox(
		"RepairHelper",
		REPAIRHELPER_ENABLE_TEXT,
		REPAIRHELPER_ENABLE_TEXT_TOOLTIP,
		"EnableRepairHelper",
		1, 
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("RepairHelper")) then
					BigFoot_LoadAddOn("RepairHelper");
				end
			end
			if (BigFoot_IsAddOnLoaded("RepairHelper")) then
				RepairHelper_ToggleEnable(__arg);
			end
		end
	);

	ModManagement_RegisterCheckBox(
		"RepairHelper",
		REPAIRHELPER_AUTO_REPAIR_TEXT,	-- text
		REPAIRHELPER_AUTO_REPAIR_TEXT_TOOLTIP,															-- tooltip
		"AutoRepairDurability",									-- variable
		1,																-- default
		function (__arg)
			if (BigFoot_IsAddOnLoaded("RepairHelper")) then
				RepairHelper_ToggleAutoRepair(__arg);
			end
		end,
		1
	);

	ModManagement_RegisterCheckBox(
		"RepairHelper",
		REPAIRHELPER_REPAIR_ALL_TEXT,	-- text
		REPAIRHELPER_REPAIR_ALL_TEXT_TOOLTIP,																	-- tooltip
		"RepairHelper_RepairAll",										-- variable
		0,																		-- default
		function (__arg)														-- callback
			if (BigFoot_IsAddOnLoaded("RepairHelper")) then
				RepairHelper_ToggleRepairAll(__arg);
			end
		end,
		1
	);
				
	ModManagement_RegisterCheckBox(
		"RepairHelper",
		REPAIRHELPER_USE_GUILD_MONEY_TEXT,
		nil,																	-- tooltip
		"RepairHelper_UseGuildMoney",
		1,																		-- default
		function (__arg)														-- callback
			if (BigFoot_IsAddOnLoaded("RepairHelper")) then
				RepairHelper_ToggleUseGuild(__arg);
			end
		end,
		2
	);