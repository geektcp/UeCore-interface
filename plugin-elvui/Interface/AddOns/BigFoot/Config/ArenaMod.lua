

if (GetLocale() == "zhCN") then
	MOD_ARENA_MOD = {"竞技助手", "jingjizhushou"};
	
	MOD_ARENA_PROXMIO_ENABLE_TEXT = "开启竞技助手(Gladius)";
	MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一个监测敌方职业，血量，种族，当前目标，技能提示，低血量报警及徽章使用(冷却)提示的框体";
	MOD_ARENA_PROXMIO = "设置";
	
	GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<竞技助手>|r 你已经关闭竞技助手模块，该设置将在下次插件载入时生效。";
	
elseif (GetLocale() == "zhTW") then
	MOD_ARENA_MOD = {"競技助手", "jingjizhushou"};
	
	MOD_ARENA_PROXMIO_ENABLE_TEXT = "開啟競技助手(Gladius)";
	MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP="提供一個監測敵方職業，血量，種族，當前目標，技能提示，低血量報警及徽章使用(冷卻)提示的框體"
	MOD_ARENA_PROXMIO = "设置";
	
	GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<競技助手>|r 你已經關閉競技助手模組，該設置將在下次外掛程式載入時生效。";
	
else
	MOD_ARENA_MOD = "Arena Mod";
	MOD_ARENA_PROXMIO_ENABLE_TEXT = "Enable Gladius";
	MOD_ARENA_PROXMIO = "SET";
	
	GLADIUS_DISABLE_DELAY_TEXT = "|cff00c0c0<Gladius>|r Proximo has been disabled. This setting will be available next time.";
end
if (IsConfigurableAddOn("Gladius")) and GetLocale()=="zhCN" then
	ModManagement_RegisterMod(
		"ArenaMod",
		"Interface\\Icons\\INV_Jewelry_Necklace_14",
		MOD_ARENA_MOD,
		nil,
		nil,
		nil,
		{[2]=true,[4]=true}
	);

	ModManagement_RegisterCheckBox(
		"ArenaMod",
		MOD_ARENA_PROXMIO_ENABLE_TEXT,
		MOD_ARENA_PROXMIO_ENABLE_TEXT_TOOLTIP,
		"EnableProximo",
		1,
		function (arg)
			if ( arg == 1 ) then
				if (not BigFoot_IsAddOnLoaded("Gladius")) then
					BigFoot_LoadAddOn("Gladius");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Gladius")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(GLADIUS_DISABLE_DELAY_TEXT); end);
				end
			end
		end
	);
	
	ModManagement_RegisterButton(
		"ArenaMod",
		MOD_ARENA_PROXMIO,
		function ()
			if BigFoot_IsAddOnLoaded("Gladius")  then
				InterfaceOptionsFrame_OpenToCategory("Gladius")
				PlaySound("igMainMenuOption");
				HideUIPanel(ModManagementFrame);
			end
		end,
		nil,
		1
	);
	
end