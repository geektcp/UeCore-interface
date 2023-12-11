
if (GetLocale() == "zhCN") then
	BF_BANK_OPEN_ALL_BAGS = "显示银行界面时打开所有背包";
	MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};
	BF_BANK_PURCHASE_CONFIRM = "在购买背包时需要得到确认";

	BF_MERCHANT_OPEN_ALL_BAGS = "同商人交易时自动打开背包";
	BF_TRADE_OPEN_ALL_BAGS = "与玩家交易时自动打开背包";
	BF_SHOW_FREE_SLOTS = "显示剩余背包空间";
	
	BF_BUY_CONFIRM = "你将购买一个新的背包，你确信是要购买吗？";
	
	
elseif (GetLocale() == "zhTW") then
	BF_BANK_OPEN_ALL_BAGS = "顯示銀行界面時打開所有背包";
	MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};
	BF_BANK_PURCHASE_CONFIRM = "在購買背包時需要得到確認";

	BF_MERCHANT_OPEN_ALL_BAGS = "與商人交易時自動打開背包";
	BF_TRADE_OPEN_ALL_BAGS = "與玩家交易時自動打開背包";
	BF_SHOW_FREE_SLOTS = "顯示剩餘背包空間";

	BF_BUY_CONFIRM = "你將購買一個新的背包，你確定要購買嗎？";
	
	
else
	BF_BANK_OPEN_ALL_BAGS = "Open all bags while talking with banker";
	MOD_BAG_MANAGEMENT_TITLE = "Bag Management";
	BF_BANK_PURCHASE_CONFIRM = "Prompt before buy slots";

	BF_MERCHANT_OPEN_ALL_BAGS = "Open all bags while talking with vendor";
	BF_TRADE_OPEN_ALL_BAGS = "Open all bags while trading with player";
	BF_SHOW_FREE_SLOTS = "Show free bag slots";

	BF_BUY_CONFIRM = "You will buy a new slot, are you sure?";
end

ModManagement_RegisterMod(
	"BagManagement",
	"Interface\\Icons\\INV_Misc_Bag_16",
	MOD_BAG_MANAGEMENT_TITLE,
	"",
	nil,
	nil,
	{[5]=true}
);

ModManagement_RegisterCheckBox(
	"BagManagement",
	BF_MERCHANT_OPEN_ALL_BAGS,
	nil,
	"EnabelOpenAllBagsOnMerchant",
	1,
	BagManage_MerchantOpenAll
);

ModManagement_RegisterCheckBox(
	"BagManagement",
	BF_BANK_OPEN_ALL_BAGS,
	nil,
	"EnabelOpenAllBagsOnBank",
	1,
	BagManage_BankOpenAll
);

ModManagement_RegisterCheckBox(
	"BagManagement",
	BF_TRADE_OPEN_ALL_BAGS,
	nil,
	"EnabelOpenAllBagsOnTrading",
	1,
	BagManage_TradeOpenAll
);

ModManagement_RegisterCheckBox(
	"BagManagement",
	BF_SHOW_FREE_SLOTS,
	nil,
	"ShowFreeSlots",
	1,
	BagManage_ShowFreeSlots
);