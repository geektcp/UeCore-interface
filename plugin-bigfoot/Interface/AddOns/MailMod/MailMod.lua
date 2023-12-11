--==============================================================================
-- MailMod - ver 1.0
-- 日期: 2007-12-5
-- 作者: 独孤傲雪
-- 描述: 提供一系列的邮件辅助功能, 例如记录收件人名字和批量收取邮件等
-- 版权所有: 艾泽拉斯国家地理
-- 特别鸣谢: 原CT_MailMod. 由于2.3邮件系统的改变, 原CT_MailMod已无法使用. 现在单体
--			 的CT_MailMod具有版权, 我们在未取得授权的情况下不得进行修改, 所以我们重
--			 写了该插件.
--														-- KK魔兽KK开发团队.
--==============================================================================

local Check_Interval = 0.5
local L = BLocal("MailMod");
local MailMod_Hook = BLibrary("BHook");
local MailMod_Event = BLibrary("BEvent");
local eventF = CreateFrame("Frame")

local EnableRightClick = false;
local MailMod_Enable = false;
local MailMod_Hooked = false;
local MailMod_Info = {["num"] = nil,  ["id"] = {},};
local MailMod_SelectedItems = {};
local MailMod_Current_ID,MailMod_IsReceiving

eventF:SetScript("OnEvent",function(self,event,...)
	if event=="ITEM_PUSH" then
		if MailMod_Info and MailMod_Info.ItemCounts and MailMod_Current_ID and MailMod_Info.ItemCounts[MailMod_Current_ID] then
			MailMod_Info.ItemCounts[MailMod_Current_ID]=MailMod_Info.ItemCounts[MailMod_Current_ID] - 1
		end
		MailMod_IsReceiving = nil;
	end
end)

if (GetLocale() == "zhCN") then
	L["MailMod"] = "邮件助手";
	MAILMOD_OPEN_SELECT = "打开选择邮件";
	MAILMOD_OPEN_ALL = "打开所有邮件";
	MAILMOD_DISPLAY_PROCESS = "显示具体处理过程";
	L["Open All?"] = "确认打开邮件";
	L["Are you sure you want to open all mails?"]  = "你确定要打开所有邮件?";
	--L["Display process messages"] = "显示邮件处理过程";
	L["Mail %d: %s |r is Cash on Delivery, skipping."] = "邮件 %d: %s 是付款取信邮件, 跳过...";
	L["Mail %d: %s has no money or items, skipping."] = "邮件%d: %s 没有金钱或物品, 跳过...";
	L["Opening mail %d: %s from %s."] = "正在打开邮件%d: %s, 来至%s.";
	L["Error: Inventory full. Aborting."] = "错误: 背包已满, 异常中断...";
	L["Click to select mail receiver"] = "点击选择收件人";
	--L["|cffff0000Warning: the contact list is full.|r"] = "|cffff0000警告:收件人列表已满|r";
	L["Add to contact list"] = " 添加到收件人列表";
	L["Remove from contact list"] = "从收件人列表中移除";
	L["Are you sure delete this contact?"] = "确定要移除此收件人么？";
	--L["|cff00ff00Add|r %s)"] = "|cff00ff00添加|r %s";
	--L["|cffff0000Remove|r %s)"] = "|cffff0000移除|r %s";
	--L["Remember name of receiver"] = "记住收件人的名字";
	L["<MailMod> %s."] = "<邮件助手> %s。";
elseif (GetLocale() == "zhTW") then
	L["MailMod"] = "郵件助手";
	MAILMOD_OPEN_SELECT = "打開選擇郵件";
	MAILMOD_OPEN_ALL = "打開所有郵件";
	MAILMOD_DISPLAY_PROCESS = "顯示具體處理過程";
	L["Open All?"] = "確認打開郵件";
	L["Are you sure you want to open all mails?"] = "你確定要打開所有郵件?";
	--L["Display process messages"] = "顯示郵件處理過程";
	L["Mail %d: %s is Cash on Delivery, skipping."] = "郵件 %d: %s 是付款取信郵件, 跳過...";
	L["Mail %d: %s has no money or items, skipping."] = "郵件%d:%s 沒有金錢或物品, 跳過...";
	L["Opening mail %d: %s from %s."] = "正在打開郵件%d: %s, 來至%s.";
	L["Error: Inventory full. Aborting."] = "錯誤: 背包已滿, 異常中斷...";
	L["Click to select mail receiver"] = "點擊選擇收件人";
	--L["|cffff0000Warning: the contact list is full.|r"]	= "|cffff0000警告:收件人列表已滿|r";
	L["Add to contact list"] = " 添加到收件人列表";
	L["Remove from contact list"] = "從收件人列表中移除";
	L["Are you sure delete this contact?"] = "確定要移除此收件人么？";
	--L["|cff00ff00Add|r %s)"] = "|cff00ff00添加|r %s)";
	--L["|cffff0000Remove|r %s)"]	= "|cffff0000移除|r %s)";
	--L["Remember name of receiver"] = "記住收件人的名字";
	L["<MailMod> %s."] = "<郵件助手> %s。";
else
	MAILMOD_OPEN_SELECT = "Open Select";
	MAILMOD_OPEN_ALL = "Open All";
	MAILMOD_DISPLAY_PROCESS = "Display process message";
end

local M = BLibrary("BInfo", "chat", L["MailMod"]);
local MAILMOD_LIST_MAX_NUM = 30;
local Server, Player, CurrentName, SelectName;

MailMod_Config = {
	["DisplayMessages"] = nil,
	["ContactList"] = {};
	--["Sendee"] = nil,
};

--------------------
-- 确认收取所有邮件
--------------------
-- StaticPopup_Show
StaticPopupDialogs["OPEN_ALL_MAILS"] = {
	text = L["Are you sure you want to open all mails?"],
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function()
		MailMod_OpenSelected(1);
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
};
--------------------
-- 确认删除联系人
--------------------
StaticPopupDialogs["SubtractName_SET"] = {
	text = L["Are you sure delete this contact?"],
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function(self)
		CurrentName = SendMailNameEditBox:GetText();
		if(CurrentName ~= "") then
			local SName = MailModList_InList(CurrentName);
			if SName  then
				MailModList_Remove(SName);
				SubtractPlayerNameButton:Hide();
			end
		end
	end,
	showAlert = 1,
	timeout = 0,
	hideOnEscape = 1,
};
--------------------
-- 在批量收取邮件期间阻止用户手动收取
--------------------
function MailMod_DisableClicks(disable, loopPrevention)
	if ( disable ) then
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(1);
			getglobal("MailItem" .. i .. "Button"):Disable();
		end
		MailMod_InboxOpenSelected:Disable()
		MailMod_InboxOpenAll:Disable()
	else
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ButtonIcon"):SetDesaturated(nil);
			getglobal("MailItem" .. i .. "Button"):Enable();
		end
		MailMod_InboxOpenSelected:Enable()
		MailMod_InboxOpenAll:Enable()
		if ( not loopPrevention ) then	-- 阻止循环调用
			InboxFrame_Update();
		end
	end
end

--------------------
-- 批量打开邮件
--------------------

function MailMod_OnFrameUpdate(frame,elapsed)
	if not MailMod_Enable then return end
	if not MailMod_Info.num then return end
	if not frame.interval then frame.interval =0 end
	frame.interval = frame.interval + elapsed
	if frame.interval >Check_Interval then frame.interval = 0 end
	if frame.interval >0 then return end
	if MailMod_IsReceiving then return end
	if MailMod_Info.num <=0 then
		MailMod_Abort()
	end
	local mailId= MailMod_Info.id[MailMod_Info.num]
	if not mailId then return end
	local success = MailMod_PickMail(mailId)
	if success ==0 then
		MailMod_DeleteLastMail()
	end
end

function MailMod_DeleteLastMail()
	tremove(MailMod_Info.id,MailMod_Info.num)
	MailMod_Info.num = MailMod_Info.num -1

end

--------------------
-- 异常中断
--------------------
function MailMod_Abort()

	MailMod_Info.num = nil;
	MailMod_Info.id = {};
	MailMod_Info.ItemCounts = {};
	MailMod_Info.CODMount = {};
	MailMod_Info.ItemMoney = {};
	MailMod_Info.Senders = {};
	MailMod_Info.Subjects = {};
	MailMod_SelectedItems = {};
	MailMod_DisableClicks();
	ManualCheckInbox();
	eventF:UnregisterAllEvents()
	MailMod_IsReceiving = nil;
end

function ManualCheckInbox()
	local __num_items=GetInboxNumItems()
	if __num_items==0 then
		MiniMapMailFrame:Hide()
	else

		for i=1,__num_items,1 do
			local _,_,_,_,_,_,_,_,__wasread=GetInboxHeaderInfo(i);
			if not __wasread then MiniMapMailFrame:Show() return end
		end
		MiniMapMailFrame:Hide()
	end
end

function MailMod_Event.UI_ERROR_MESSAGE(ui,msg)
	if (msg == ERR_INV_FULL or msg == ERR_ITEM_MAX_COUNT ) then
		if ( msg == ERR_INV_FULL ) then
			MailMod_Abort();
			if ( MailMod_Config.DisplayMessages ) then
				M:Print(L["Error: Inventory full. Aborting."]);
			end
		elseif ( msg == ERR_ITEM_MAX_COUNT ) then
			if ( MailMod_Config.DisplayMessages ) then
				M:Print(L["Error: You already have the maximum amount of that item. Aborting."]);
			end
			MailMod_Abort();
		end
	end
end

function MailMod_Event.MAIL_SEND_SUCCESS()
	SendMailNameEditBox:SetText(MM_TempName or "");
end

function MailMod_PickMail(id)
	if ( not id ) then
		return 0;
	end
	if ( MailMod_Info.CODMount[id] and  MailMod_Info.CODMount[id]> 0 ) then
		if ( MailMod_Config.DisplayMessages ) then
			M:Print(format(L["Mail %d: %s is Cash on Delivery, skipping."], id, MailMod_Info.Subjects[id] or "<No Subject>"));
		end
		return 0;

	end

	if (MailMod_Info.ItemMoney[id]> 0 ) then
		TakeInboxMoney(id);
		MailMod_Info.ItemMoney[id] =0 ;
		MailMod_IsReceiving = nil;
		if ( MailMod_Info.ItemCounts[id]) then
			return 1;
		else
			return 0;
		end
	end
	if ( MailMod_Info.ItemCounts[id] and MailMod_Info.ItemCounts[id] >0) then
		if GetInboxItem(id,MailMod_Info.ItemCounts[id])then
			MailMod_IsReceiving = true;
			MailMod_Current_ID = id ;
			if ( MailMod_Config.DisplayMessages ) then
				M:Print(format(L["Opening mail %d: %s from %s."], id, MailMod_Info.Subjects[id] or "<No Subject>", MailMod_Info.Senders[id] or "<Unknown Sender>"));
			end
			TakeInboxItem(id, MailMod_Info.ItemCounts[id]);
		elseif GetInboxItem(id,0) then
			MailMod_IsReceiving = true;
			MailMod_Current_ID = id ;
			if ( MailMod_Config.DisplayMessages ) then
				M:Print(format(L["Opening mail %d: %s from %s."], id, MailMod_Info.Subjects[id] or "<No Subject>", MailMod_Info.Senders[id] or "<Unknown Sender>"));
			end
			TakeInboxItem(id, 0);
		end
		return 1

	else
		if ( MailMod_Config.DisplayMessages ) then
			M:Print(format(L["Mail %d: %s has no money or items, skipping."], id, MailMod_Info.Subjects[id] or "<No Subject>"));
		end
		return 0

	end
	return 0;
end
--------------------
-- 设置选择打开的邮件
--------------------
function MailMod_SetSelected(self)
	local id = self:GetID() + (InboxFrame.pageNum-1)*7;
	if ( not self:GetChecked() ) then
		for k, v in pairs(MailMod_SelectedItems) do
			if ( v == id ) then
				tremove(MailMod_SelectedItems, k);
				break;
			end
		end
	else
		tinsert(MailMod_SelectedItems, id);
	end
end
--------------------
-- 批量打开邮件
--------------------
function MailMod_OpenSelected(openAll)
	MailMod_DisableClicks(1);
	MailMod_Info.num = 0;
	MailMod_Info.id = {};
	MailMod_Info.ItemCounts = {};
	MailMod_Info.Senders = {};
	MailMod_Info.Subjects = {};
	MailMod_Info.ItemMoney = {};
	MailMod_Info.CODMount = {};
	if ( openAll ) then		-- 全部打开邮件
		for i = 1, GetInboxNumItems(), 1 do
			MailMod_Info.num = MailMod_Info.num + 1;
			tinsert(MailMod_Info.id, i);
			local _,_,sender,subject,money,CODMount,_,itemCount= GetInboxHeaderInfo(i);
			MailMod_Info.ItemCounts[i] = itemCount;
			MailMod_Info.ItemMoney[i] = money;
			MailMod_Info.CODMount[i] = CODMount;
			MailMod_Info.Senders[i] = sender;
			MailMod_Info.Subjects[i] = subject;
		end
	else
		for k, v in pairs(MailMod_SelectedItems) do
			MailMod_Info.num = MailMod_Info.num + 1;
			tinsert(MailMod_Info.id, v);
			local _,_,sender,subject,money,CODMount,_,itemCount= GetInboxHeaderInfo(v);
			MailMod_Info.ItemCounts[v] = itemCount;
			MailMod_Info.ItemMoney[v] = money;
			MailMod_Info.CODMount[v] = CODMount;
			MailMod_Info.Senders[v] = sender;
			MailMod_Info.Subjects[v] = subject;
		end
	end
	MailMod_SelectedItems = {};
	sort(MailMod_Info.id)
	eventF:RegisterEvent("ITEM_PUSH");

end
--------------------
-- Hook InboxFrame_Update
--------------------
function MailMod_FrameUpdate(...)
	if (MailMod_Enable) then
		for i = 1, 7, 1 do
			local index = (i + (InboxFrame.pageNum-1)*7);
			if ( index > GetInboxNumItems() ) then
				getglobal("MailBoxItem" .. i .. "CB"):Hide();
			else
				getglobal("MailBoxItem" .. i .. "CB"):Show();
				getglobal("MailBoxItem" .. i .. "CB"):SetChecked(nil);
				for k, v in pairs(MailMod_SelectedItems) do
					if ( v == index ) then
						getglobal("MailBoxItem" .. i .. "CB"):SetChecked(1);
						break;
					end
				end
			end
		end
		if ( MailMod_Info.num ) then
			MailMod_DisableClicks(1, 1);
		end
	end
end
--------------------
-- 关闭邮箱时执行异常中断
--------------------
local function MailMod_CloseMail(...)
	if (MailMod_Enable) then
		MailMod_Abort();
	end
end

function MailMod_DisplayMessagesCB_OnClick(self, button)
	MailMod_Config["DisplayMessages"] = self:GetChecked();
end
--==================
-- 增强鼠标提示信息
--==================
local function MailMod_FrameItem_OnEnter(self)
	if (MailMod_Enable) then
		local name, itemTexture, count, quality, canUse;
		if ( self.hasItem and self.itemCount > 1) then
			for i=1, ATTACHMENTS_MAX_RECEIVE do
				name, itemTexture, count, quality, canUse = GetInboxItem(self.index, i);
				if (name and count) then
					local itemLink = GetInboxItemLink(self.index, i)
					if itemLink then
						GameTooltip:AddLine(format("%s |cff00ff00x%d|r",itemLink , count));
					end
				end
			end
			GameTooltip:Show();
		end
	end
end
--==================
-- 快速添加邮寄物品
--==================
local function ItemButtonPostClick(self, button)
	if (MailMod_Enable and IsAltKeyDown() and button == "LeftButton") then
		local bag, slot = self:GetParent():GetID(), self:GetID();
		if (bag and slot and SendMailFrame:IsShown()) then
			PickupContainerItem(bag, slot);
			if (CursorHasItem()) then
				for i=1, ATTACHMENTS_MAX_SEND do
					if (not GetSendMailItem(i)) then
						ClickSendMailItemButton(i);
					end
				end
			end
		end
	end
end

--------------------
-- 添加/删除收件人
--------------------

function MailModList_Init()
	Player = UnitName("player");
	Server = GetCVar("realmName");

	MailMod_Config["ContactList"][Server] = MailMod_Config["ContactList"][Server] or {};
	--CurrentName = MailMod_Config["Sendee"];
end

function SendMailNameEditBox_OnTextChanged(self, isUserInput)
	if not MailMod_Enable then return end
	CurrentName = self:GetText();
	if(CurrentName ~= "") then
		local SName = MailModList_InList(CurrentName);
		if not SName and #(MailMod_Config["ContactList"][Server]) < MAILMOD_LIST_MAX_NUM  then
			AddPlayerNameButton:Show()
			SubtractPlayerNameButton:Hide()
		else
			AddPlayerNameButton:Hide()
			SubtractPlayerNameButton:Show()
		end
	else
		AddPlayerNameButton:Hide()
		SubtractPlayerNameButton:Hide()
	end
end

function AddPlayerNameButton_OnClick()
	if not MailMod_Enable then return end
	CurrentName = SendMailNameEditBox:GetText();
	if(CurrentName ~= "") then
		local SName = MailModList_InList(CurrentName);
		if not SName and #(MailMod_Config["ContactList"][Server]) < MAILMOD_LIST_MAX_NUM  then
			MailModList_Add();
			AddPlayerNameButton:Hide();
		end
	end
end

function SubtractPlayerNameButton_OnClick()
	if not MailMod_Enable then return end
	StaticPopup_Show("SubtractName_SET");
end

--------------------
-- 鼠标进入
--------------------
function MailModList_ButtonOnEnter(self)
	if (MailMod_Enable) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText(self.tooltip);
	end
end

function AddPlayerNameButton_OnEnter(self)
	if (MailMod_Enable) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(L["Add to contact list"]);
	end
end

function SubtractPlayerNameButton_OnEnter(self)
	if (MailMod_Enable) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT");
		GameTooltip:SetText(L["Remove from contact list"]);
	end
end

--------------------
--
--------------------
function MailModList_DropDown_OnShown(self)
	self.tooltip = L["Click to select mail receiver"];
	BDropDownMenu_Initialize(self:GetParent(), MailModList_DropDown_Init);
	BDropDownMenu_SetAnchor(self:GetParent(), 0, 0, "TOPRIGHT", self:GetName(), "BOTTOMRIGHT")
end

function MailModList_DropDown_Init(self)
	local info = {value = 0, notCheckable = 1};
	CurrentName = SendMailNameEditBox:GetText();
	if(CurrentName ~= "") then
		SelectName = MailModList_InList(CurrentName);
		-- if(SelectName) then
			-- info.text = string.format(L["|cffff0000Remove|r %s)"], CurrentName);
			-- info.func = MailModList_Remove;
		-- elseif(#(MailMod_Config["ContactList"][Server]) < MAILMOD_LIST_MAX_NUM) then
			-- info.text = string.format(L["|cff00ff00Add|r %s)"], CurrentName);
			-- info.func = MailModList_Add;
		-- else
			-- info = nil;
			-- M:Print(L["|cffff0000Warning: the contact list is full.|r"]);
		-- end
		-- if(info) then
			-- BDropDownMenu_AddButton(info);
		-- end
	end
	-- 人物列表
	for key, name in pairs(MailMod_Config["ContactList"][Server]) do
		info = {text=name, value=key, func=MailModList_Select};
		if(key == SelectName) then
			info.checked = 1;
		end
		BDropDownMenu_AddButton(info);
	end
end
--------------------
-- 选择收件人
--------------------
function MailModList_Select(self)
	local value = self.value;
	if(value) then
		CurrentName = MailMod_Config["ContactList"][Server][value];
		SendMailNameEditBox:SetText(CurrentName);
		SendMailNameEditBox:HighlightText(0,-1);
	end
end
--------------------
-- 添加收件人
--------------------
function MailModList_Add()
	table.insert(MailMod_Config["ContactList"][Server], CurrentName);
	table.sort(MailMod_Config["ContactList"][Server]);
	MailToName_SavedName = SendMailNameEditBox:GetText();
	M:Print(CurrentName..L["Add to contact list"]);
end
--------------------
-- 取消收件人
--------------------
function MailModList_Remove(SName)
	table.remove(MailMod_Config["ContactList"][Server], SName);
	SendMailNameEditBox:SetText('');
	M:Print(CurrentName..L["Remove from contact list"]);
end
-------------------
-- 列表中是否有该名字
-------------------
function MailModList_InList(MCname)
	local LCname = string.lower(MCname);
	for key, name in pairs(MailMod_Config["ContactList"][Server]) do
		if(LCname == string.lower(name)) then
			return key;
		end
	end
end
--------------------------------------------------------------------------------
--
--------------------------------------------------------------------------------
local function MailMod_SecureHook()
	hooksecurefunc("InboxFrame_Update", MailMod_FrameUpdate);
	hooksecurefunc("CloseMail", MailMod_CloseMail);
	hooksecurefunc("InboxFrameItem_OnEnter", MailMod_FrameItem_OnEnter);
	SendMailMailButton:SetScript("PreClick",function() MM_TempName = SendMailNameEditBox:GetText() end)
	hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", ItemButtonPostClick);

	if MailFrame:GetScript("OnUpdate") then
		MailFrame:HookScript("OnUpdate",MailMod_OnFrameUpdate)
	else
		MailFrame:SetScript("OnUpdate",MailMod_OnFrameUpdate)
	end

	if SendMailNameEditBox:GetScript("OnTextChanged") then
		SendMailNameEditBox:HookScript("OnTextChanged",SendMailNameEditBox_OnTextChanged)
	else
		SendMailNameEditBox:SetScript("OnTextChanged",SendMailNameEditBox_OnTextChanged)
	end
end

MailMod_Event:Init{
	name = "MailMod",
	func = function ()
		MailModList_Init();
		MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 48, -80);
		for i = 1, 7, 1 do
			getglobal("MailItem" .. i .. "ExpireTime"):SetPoint("TOPRIGHT", "MailItem" .. i, "TOPRIGHT", 10, -4);
			getglobal("MailItem" .. i):SetWidth(280);
		end
		MailMod_InboxDisplayMessagesCB:SetChecked(MailMod_Config.DisplayMessages);
	end
};

function MailMod_Toggle(switch)
	if (switch) then
		MailMod_Enable = true;
		if (not MailMod_Hooked) then
			MailMod_SecureHook();
		end
		MailMod_Event:RegisterEvent("UI_ERROR_MESSAGE");
		MailMod_Event:RegisterEvent("MAIL_SEND_SUCCESS");
		MailMod_InboxOpenSelected:Show();
		MailMod_InboxOpenAll:Show();
		MailMod_InboxDisplayMessagesCB:Show();
		MailModList_DropDownMenuButton:Show();
		MailMod_Hooked = true;
	else
		MailMod_Enable = false;
		MailMod_Event:UnregisterEvent("UI_ERROR_MESSAGE");
		MailMod_Event:UnregisterEvent("MAIL_SEND_SUCCESS");
		MailMod_InboxOpenSelected:Hide();
		MailMod_InboxOpenAll:Hide();
		MailMod_InboxDisplayMessagesCB:Hide();
		MailModList_DropDownMenuButton:Hide();
	end
end