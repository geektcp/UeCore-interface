
if (GetLocale() == "zhCN") then
	MOD_TRADE_HELPER_TITLE = {"交易助手", "jiaoyizhushou"}
	TRADE_HELPER_ENABLE_TEXT = "开启交易助手"
	TRADE_HELPER_ENABLE_TEXT_TOOLTIP="对交易物品进行提示，并可在小地图按键包中的交易助手显示详细交易记录"
	TRADE_HELPER_DISABLE_DELAY_TEXT = "|cff00c0c0<交易助手>|r 你已经关闭交易助手模块，该设置将在下次插件载入时生效。";
elseif (GetLocale() == "zhTW") then
	MOD_TRADE_HELPER_TITLE = {"交易助手", "jiaoyizhushou"}
	TRADE_HELPER_ENABLE_TEXT = "開啓交易助手"
	TRADE_HELPER_ENABLE_TEXT_TOOLTIP= "對交易物品進行提示，並可在小地圖按鍵包中的交易助手顯示詳細交易記錄"
	TRADE_HELPER_DISABLE_DELAY_TEXT =  "|cff00c0c0<交易助手>|r 你已經關閉交易助手模組，該設置將在下次外掛程式載入時生效。";
else
	MOD_TRADE_HELPER_TITLE = "Trade Helper"
	TRADE_HELPER_ENABLE_TEXT = "Enable Trade Helper"	
	TRADE_HELPER_DISABLE_DELAY_TEXT = "|cff00c0c0<Trade Helper>|r Trade Helper has been disabled. This setting will be available next time.";
end

if  IsConfigurableAddOn("TheBurningTrade") then

	ModManagement_RegisterMod(
		"TradeHelper",
		"Interface\\Icons\\Inv_misc_coin_01",
		MOD_TRADE_HELPER_TITLE,
		"",
		nil,
		nil,
		{[5]=true}
	);

	ModManagement_RegisterCheckBox(
		"TradeHelper",
		TRADE_HELPER_ENABLE_TEXT,
		TRADE_HELPER_ENABLE_TEXT_TOOLTIP,
		"EnableTradeHelper",
		1,
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("TheBurningTrade")) then
					BigFoot_LoadAddOn("TheBurningTrade");
				end
			elseif (BigFoot_IsAddOnLoaded("TheBurningTrade")) then
				BigFoot_RequestReloadUI(function() BigFoot_Print(TRADE_HELPER_DISABLE_DELAY_TEXT); end);
			end
		end
	);
end