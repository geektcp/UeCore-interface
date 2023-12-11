if (GetLocale() == "zhCN") then
	BF_TRADEMONEY_CONFIRMATION="确定要将下列金额交易给%s吗？"
	BIGFOOT_BAG_PATTERN_MATCH = "(%d+)格(.+)";
elseif (GetLocale() == "zhTW") then
	BF_TRADEMONEY_CONFIRMATION="確定要將下列金額交易給%s嗎？"
	BIGFOOT_BAG_PATTERN_MATCH = "(%d+)格(.+)";
else
	BF_TRADEMONEY_CONFIRMATION="Will trade the follow amount of gold to %s, continue?"
	BIGFOOT_BAG_PATTERN_MATCH = "(%d+) Slot (.+)";
end

--add an popup before trading money, and before doing gleader
local BF_GLeader_Ori=SlashCmdList["GUILD_LEADER"]
BFSecure_MoneyAmount = 1000000

StaticPopupDialogs["BF_TRADE_MONEY"] = {
	text = BF_TRADEMONEY_CONFIRMATION,
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function(self)
		AcceptTrade()
	end,
	OnCancel = function(self)
	end,
	OnShow = function(self)
		MoneyFrame_Update(self.moneyFrame, MoneyInputFrame_GetCopper(TradePlayerInputMoneyFrame));
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};

local function BFSecureToggleTrade(toggle)
	if toggle then
		TradeFrameTradeButton:SetScript("OnClick",function()
			local copper=MoneyInputFrame_GetCopper(TradePlayerInputMoneyFrame);
			if copper>=BFSecure_MoneyAmount then-- if copper >100G
				StaticPopup_Show("BF_TRADE_MONEY",UnitName("NPC"));
			else
				AcceptTrade()
			end
		end)
	else
		TradeFrameTradeButton:SetScript("OnClick",AcceptTrade)
	end
end

local function BFGLeaderFunc(msg)
	if( msg and (strlen(msg) > MAX_CHARACTER_NAME_BYTES) ) then
		ChatFrame_DisplayUsageError(ERR_NAME_TOO_LONG2);
		return;
	end
	if strlen(msg)>0 then
		StaticPopup_Show("CONFIRM_GUILD_PROMOTE", msg)
	elseif 	UnitName("target") then
		StaticPopup_Show("CONFIRM_GUILD_PROMOTE", UnitName("target"))
	end
end

SlashCmdList["GUILD_LEADER"] = BFGLeaderFunc
BFSecureToggleTrade(true)


local bagFrame = CreateFrame("Frame")

bagFrame:SetScript("OnEvent",
	function(self,event)
		if event =="BANKFRAME_OPENED" or event =="MERCHANT_SHOW" or event =="TRADE_SHOW" then
			OpenAllBags(1);
		elseif event =="BANKFRAME_CLOSED" or event =="MERCHANT_CLOSED" or event =="TRADE_CLOSED" then
			CloseAllBags();
		end
	end
)

function BagManage_MerchantOpenAll(flag)
	if ( flag == 1 ) then
		bagFrame:RegisterEvent("MERCHANT_SHOW");
		bagFrame:RegisterEvent("MERCHANT_CLOSED");
	else
		bagFrame:UnregisterEvent("MERCHANT_SHOW");
		bagFrame:UnregisterEvent("MERCHANT_CLOSED");
	end
end

function BagManage_BankOpenAll(flag)
	if ( flag == 1 ) then
		bagFrame:RegisterEvent("BANKFRAME_OPENED");
		bagFrame:RegisterEvent("BANKFRAME_CLOSED");
	else
		bagFrame:UnregisterEvent("BANKFRAME_OPENED");
		bagFrame:UnregisterEvent("BANKFRAME_CLOSED");
	end
end

function BagManage_TradeOpenAll(flag)
	if ( flag == 1 ) then
		bagFrame:RegisterEvent("TRADE_SHOW");
		bagFrame:RegisterEvent("TRADE_CLOSED");
	else
		bagFrame:UnregisterEvent("TRADE_SHOW");
		bagFrame:UnregisterEvent("TRADE_CLOSED");
	end
end

function BagManage_ShowFreeSlots(flag)
	if ( flag == 1 ) then
		SetCVar("displayFreeBagSlots", 1);
		MainMenuBarBackpackButtonCount:Show();
	else
		SetCVar("displayFreeBagSlots", 0);
		MainMenuBarBackpackButtonCount:Hide();
	end
end

------------------------------------------------------
-- 获得指定的行囊的信息
-- 返回：arg1 行囊大小
--       arg2 行囊类型
------------------------------------------------------
function BigFoot_GetBagInfo(bag)
	BigFoot_Tooltip_Init();
	BigFootTooltip:SetInventoryItem("player", bag);

	local text1 = BigFootTooltipTextLeft1:GetText();
	local text2 = BigFootTooltipTextLeft2:GetText();
	local text3 = BigFootTooltipTextLeft3:GetText();
	local text4 = BigFootTooltipTextLeft4:GetText();

	BigFootTooltip:Hide();

	local st, ed, slots, type;
	local pattern_string;

	if (text2) then
		st, ed, slots, type = string.find(text2, BIGFOOT_BAG_PATTERN_MATCH);
		if (st and ed) then
			return slots, type;
		end
	end

	if (text3) then
		st, ed, slots, type = string.find(text3, BIGFOOT_BAG_PATTERN_MATCH);
		if (st and ed) then
			return slots, type;
		end
	end

	if (text4) then
		st, ed, slots, type = string.find(text4, BIGFOOT_BAG_PATTERN_MATCH);
		if (st and ed) then
			return slots, type;
		end
	end
end