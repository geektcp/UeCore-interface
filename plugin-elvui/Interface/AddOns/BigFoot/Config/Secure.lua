
if (GetLocale() == "zhCN") then
	BFSECURE_TITLE = {"安全设置", "anquanshezhi"};	
	BFSECURE_ENABLE_GLEADER_CHECK="提示转让工会会长"
	BFSECURE_ENABLE_TRADE_CHECK="提示金币交易"
elseif (GetLocale() == "zhTW") then
	BFSECURE_TITLE = {"安全设置", "anquanshezhi"};
	BFSECURE_ENABLE_GLEADER_CHECK="提示轉讓工會會長"
	BFSECURE_ENABLE_TRADE_CHECK="提示金幣交易"
else
	BFSECURE_TITLE = "Secure functions";
	BFSECURE_ENABLE_GLEADER_CHECK="Ask for confirmation before gleader"
	BFSECURE_ENABLE_TRADE_CHECK="Ask for confirmation before trading gold"
end
--[[
	ModManagement_RegisterMod(
		"BESecure",
		"Interface\\Icons\\ability_warrior_shieldmastery",
		BFSECURE_TITLE,
		"",
		nil,
		nil,
		{[7]=true}
	);
	
	ModManagement_RegisterCheckBox(
		"BESecure",
		BFSECURE_ENABLE_GLEADER_CHECK,
		nil,
		"EnableGLeaderCheck",
		1,
		function (__arg)
			if (__arg == 1) then
				BFSecureToggleGLeader(true)
			else
				BFSecureToggleGLeader(false)			
			end
		end
	);
	ModManagement_RegisterCheckBox(
		"BESecure",
		BFSECURE_ENABLE_TRADE_CHECK,
		nil,
		"EnableTradeCheck",
		1,
		function (__arg)
			if (__arg == 1) then
				BFSecureToggleTrade(true)
			else
				BFSecureToggleTrade(false)			
			end
		end
	);]]
	