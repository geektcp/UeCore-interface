if (GetLocale() == "zhCN") then
	MOD_MAP_TOOLKIT = {"地图工具", "ditugongju"};

	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS = "开启旧大陆副本地图";  ---新版本失效

	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS_WLK = "开启巫妖王副本地图";  ---新版本失效
	
	MAP_PLUS_ENABLE_TEXT = "开启地图标记";
	MAP_PLUS_ENABLE_TEXT_TOOLTIP= "可在地图上需要标记的地方点击鼠标左键创建一个标记";
	
	MAP_PLUS_ACCEPT_MAP_NOTE = "接收其他玩家发送的标记"; 	---未测试
	
	MAP_MARK_ENABLE = "开启NPC位置";
	MAP_MARK_ENABLE_TOOLTIP= "在地图上以图标方式显示NPC位置";
	
	INSTANCE_MAPS_DISABLE_DELAY_TEXT = "|cff00c0c0<副本地图>|r 你已经关闭副本地图模块，该设置将在下次插件载入时生效。";
	
elseif (GetLocale() == "zhTW") then
	MOD_MAP_TOOLKIT = {"地圖工具", "ditugongju"};

	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS = "開啟舊大陸副本地圖";
	
	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS_WLK = "開啟巫妖王副本地圖";  ---新版本失效

	
	MAP_PLUS_ENABLE_TEXT = "開啟地圖標記";
	MAP_PLUS_ENABLE_TEXT_TOOLTIP="可在地圖上需要標記的地方那個點擊鼠標鄒建左鍵創建一個標記"
	
	MAP_PLUS_ACCEPT_MAP_NOTE = "接收其他玩家發送的標記";
	
	MAP_MARK_ENABLE = "開啟NPC位置";
	MAP_MARK_ENABLE_TOOLTIP= "在地圖上以圖表方式顯示NPC位置";
	
	INSTANCE_MAPS_DISABLE_DELAY_TEXT = "|cff00c0c0<副本地圖>|r 你已經關閉副本地圖模組，該設置將在下次插件載入時生效。";
else
	MOD_MAP_TOOLKIT = "Map Toolkit";
	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS = "Enable Instance Maps";
	MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS_WLK = "Enable WLK Instance Maps";
	MAP_PLUS_ENABLE_TEXT = "Enable Map Note";
	MAP_PLUS_ACCEPT_MAP_NOTE = "Accept notes from other players";
	MAP_MARK_ENABLE = "Enable NPC locations";
	INSTANCE_MAPS_DISABLE_DELAY_TEXT = "|cff00c0c0<Instance Maps>|r Instance Maps has been disabled. This setting will be available next time.";
end

if  IsConfigurableAddOn("MapPlus") or  IsConfigurableAddOn("BigFootMark")  then
	ModManagement_RegisterMod(
		"MapToolkit",
		"Interface\\Icons\\INV_Misc_Toy_06",
		MOD_MAP_TOOLKIT,
		nil,
		nil,
		nil,
		{[6]=true}
	);
end

if IsConfigurableAddOn("YssBossLoot") then
	ModManagement_RegisterCheckBox(
		"MapToolkit",
		MOD_MAP_TOOLKIT_ENABLE_INSTANCE_MAPS_WLK,
		nil,
		"EnableYssBossLoot",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("YssBossLoot")) then
					BigFoot_LoadAddOn("YssBossLoot");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("YssBossLoot")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(INSTANCE_MAPS_DISABLE_DELAY_TEXT); end);
				end
			end
		end
	);
end

if (IsConfigurableAddOn("MapPlus")) then
	
	ModManagement_RegisterCheckBox(
		"MapToolkit",
		MAP_PLUS_ENABLE_TEXT,
		MAP_PLUS_ENABLE_TEXT_TOOLTIP,
		"EnableMapPlus",
		1,
		function (__arg)
			if (__arg==1)then
				if (not BigFoot_IsAddOnLoaded("MapPlus")) then
					BigFoot_LoadAddOn("MapPlus");
				end
			end
			if BigFoot_IsAddOnLoaded("MapPlus") then
				MapPlus_ToggleEnable(__arg)
			end
		end
	);
	
	ModManagement_RegisterCheckBox(
		"MapToolkit",
		MAP_PLUS_ACCEPT_MAP_NOTE,
		nil,
		"AcceptMapNote",
		1,
		function (__arg)
			if (__arg==1)then
				if (not BigFoot_IsAddOnLoaded("MapPlus")) then
					BigFoot_LoadAddOn("MapPlus");
				end
			end
			if BigFoot_IsAddOnLoaded("MapPlus") then
				MapPlus_ToggleReceive(__arg)
			end
		end,
		1
	);
	
end
if IsConfigurableAddOn("BigFootMark") and GetLocale()=="zhCN" then
	ModManagement_RegisterCheckBox(
		"MapToolkit",
		MAP_MARK_ENABLE,
		MAP_MARK_ENABLE_TOOLTIP,
		"MapMarkEnable",
		1,
		function (__arg)
			if (__arg==1)then
				if (not BigFoot_IsAddOnLoaded("BigFootMark")) then
					BigFoot_LoadAddOn("BigFootMark");
				end
--				BFM_ToggleEnable(1)
			else
				if BigFoot_IsAddOnLoaded("BigFootMark") then
					BFM_ToggleEnable(0)
				end
			end
			
		end
	);
end
