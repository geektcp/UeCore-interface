--[[
	ba.lua
		A bag button object
--]]

local Bag = Combuctor:NewClass('Button')
Combuctor.Bag = Bag

--local bindings
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local InvData = Combuctor:GetModule('InventoryData')


--[[ Constructor/Destructor ]]--

local SIZE = 30
local NORMAL_TEXTURE_SIZE = 64 * (SIZE/36)

local unused = {}
local id = 1

function Bag:New()
	local bag = self:Bind(CreateFrame('Button', format('CombuctorBag%d', id)))
	local name = bag:GetName()
	bag:SetWidth(SIZE); bag:SetHeight(SIZE)

	local icon = bag:CreateTexture(name .. 'IconTexture', 'BORDER')
	icon:SetAllPoints(bag)

	local count = bag:CreateFontString(name .. 'Count', 'OVERLAY')
	count:SetFontObject('NumberFontNormalSmall')
	count:SetJustifyH('RIGHT')
	count:SetPoint('BOTTOMRIGHT', -2, 2)

	local nt = bag:CreateTexture(name .. 'NormalTexture')
	nt:SetTexture('Interface/Buttons/UI-Quickslot2')
	nt:SetWidth(NORMAL_TEXTURE_SIZE)
	nt:SetHeight(NORMAL_TEXTURE_SIZE)
	nt:SetPoint('CENTER', 0, -1)
	bag:SetNormalTexture(nt)

	local pt = bag:CreateTexture()
	pt:SetTexture('Interface/Buttons/UI-Quickslot-Depress')
	pt:SetAllPoints(bag)
	bag:SetPushedTexture(pt)

	local ht = bag:CreateTexture()
	ht:SetTexture('Interface/Buttons/ButtonHilight-Square')
	ht:SetAllPoints(bag)
	bag:SetHighlightTexture(ht)

	bag:RegisterForClicks('anyUp')
	bag:RegisterForDrag('LeftButton')

	bag:SetScript('OnEnter', self.OnEnter)
	bag:SetScript('OnLeave', self.OnLeave)
	bag:SetScript('OnClick', self.OnClick)
	bag:SetScript('OnDragStart', self.OnDrag)
	bag:SetScript('OnReceiveDrag', self.OnClick)
	bag:SetScript('OnEvent', self.OnEvent)

	id = id + 1
	return bag
end

function Bag:Get()
	local f = next(unused)
	if f then
		unused[f] = nil
		return f
	end
	return self:New()
end

function Bag:Set(parent, id)
	self:SetID(id)
	self:SetParent(parent)

	if id == BACKPACK_CONTAINER or id == BANK_CONTAINER then
		SetItemButtonTexture(self, 'Interface/Buttons/Button-Backpack-Up')
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		self:Update()

		self:RegisterEvent('ITEM_LOCK_CHANGED')
		self:RegisterEvent('CURSOR_UPDATE')
		self:RegisterEvent('BAG_UPDATE')
		self:RegisterEvent('PLAYERBANKSLOTS_CHANGED')

		if InvData:IsBankBag(self:GetID()) then
			self:RegisterEvent('BANKFRAME_OPENED')
			self:RegisterEvent('BANKFRAME_CLOSED')
			self:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED')
		end
	end
end

function Bag:Release()
	unused[self] = true

	self.cached = nil
	self.hasItem = nil
	self:SetParent(nil)
	self:Hide()
	self:UnregisterAllEvents()
	_G[self:GetName() .. 'Count']:Hide()
end


--[[ Events ]]--

function Bag:OnEvent(event)
	if event == 'BANKFRAME_OPENED' or event == 'BANKFRAME_CLOSED' then
		self:Update()
	elseif not InvData:IsCachedBag(self:GetID(), self:GetParent():GetPlayer()) then
		if event == 'ITEM_LOCK_CHANGED' then
			self:UpdateLock()
		elseif event == 'CURSOR_UPDATE' then
			self:UpdateCursor()
		elseif event == 'BAG_UPDATE' or event == 'PLAYERBANKSLOTS_CHANGED' then
			self:Update()
		elseif event == 'PLAYERBANKBAGSLOTS_CHANGED' then
			self:Update()
		end
	end
end


--[[ Update ]]--

function Bag:Update()
	self:UpdateLock()
	self:UpdateTexture()

	-- Update repair all button status
	if MerchantRepairAllIcon then
		local repairAllCost, canRepair = GetRepairAllCost()
		if canRepair then
			SetDesaturation(MerchantRepairAllIcon, nil)
			MerchantRepairAllButton:Enable()
		else
			SetDesaturation(MerchantRepairAllIcon, true)
			MerchantRepairAllButton:Disable()
		end
	end
end

function Bag:UpdateLock()
	local id = self:GetID()
	local player = self:GetParent():GetPlayer()

	if IsInventoryItemLocked(InvData:GetInvSlot(id)) and not InvData:IsCachedBag(id, player) then
		_G[self:GetName() .. 'IconTexture']:SetDesaturated(true)
	else
		_G[self:GetName() .. 'IconTexture']:SetDesaturated(false)
	end
end

function Bag:UpdateCursor()
	local invSlot = InvData:GetInvSlot(self:GetID())
	if CursorCanGoInSlot(invSlot) then
		self:LockHighlight()
	else
		self:UnlockHighlight()
	end
end

--actually, update texture and count
function Bag:UpdateTexture()
	local id = self:GetID()
	if id > 0 then
		if InvData:IsCachedBag(id, self:GetParent():GetPlayer()) then
			if BagnonDB then
				self:UpdateTextureFromCache()
			end
		else
			self:UpdateTextureFromLive()
		end
	end
end

function Bag:UpdateTextureFromLive()
	local id = self:GetID()
	local texture = GetInventoryItemTexture('player', InvData:GetInvSlot(id))

	if texture then
		self.hasItem = true

		SetItemButtonTexture(self, texture)
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		self.hasItem = nil

		--color red if the bag can be purchased
		SetItemButtonTexture(self, 'Interface/PaperDoll/UI-PaperDoll-Slot-Bag')
		if id > (GetNumBankSlots() + 4) then
			SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
		else
			SetItemButtonTextureVertexColor(self, 1, 1, 1)
		end
	end

	--update count
	self:SetCount(GetInventoryItemCount('player', InvData:GetInvSlot(id)))
end

function Bag:UpdateTextureFromCache()
	local id = self:GetID()
	local player = self:GetParent():GetPlayer()

	local size, link, count, texture = BagnonDB:GetBagData(id, player)
	if link then
		self.hasItem = true
		SetItemButtonTexture(self, texture)
		SetItemButtonTextureVertexColor(self, 1, 1, 1)
	else
		SetItemButtonTexture(self, 'Interface/PaperDoll/UI-PaperDoll-Slot-Bag')

		--color red if the bag can be purchased
		local numBankSlots = BagnonDB:GetNumBankSlots(player)
		if numBankSlots and id > (numBankSlots + 4) then
			SetItemButtonTextureVertexColor(self, 1, 0.1, 0.1)
		else
			SetItemButtonTextureVertexColor(self, 1, 1, 1)
		end

		self.hasItem = nil
	end

	--update count
	self:SetCount(count)
end

function Bag:SetCount(count)
	local text = _G[self:GetName() .. 'Count']
	local count = count or 0
	if count > 1 then
		if count > 999 then
			text:SetFormattedText('%.1fk', count/1000)
		else
			text:SetText(count)
		end
		text:Show()
	else
		text:Hide()
	end
end


--[[ Frame Events ]]--

function Bag:OnClick(button)
	local parent = self:GetParent()
	local player = parent:GetPlayer()
	local bagID = self:GetID()
	local link = InvData:GetBagLink(bagID, player)

	if not((link and HandleModifiedItemClick(link)) or InvData:IsCachedBag(bagID, player)) then
		if CursorHasItem() and not InvData:IsCachedBag(bagID, player) then
			if bagID == KEYRING_CONTAINER then
				PutKeyInKeyRing()
			elseif bagID == BACKPACK_CONTAINER then
				PutItemInBackpack()
			else
				PutItemInBag(ContainerIDToInventoryID(bagID))
			end
		elseif bagID > (GetNumBankSlots() + 4) then
			self:PurchaseSlot()
		elseif bagID > 0 then
			PlaySound('BAGMENUBUTTONPRESS')
			PickupBagFromSlot(InvData:GetInvSlot(bagID))
		end
	end
end

function Bag:OnDrag()
	local parent = self:GetParent()
	local player = parent:GetPlayer()
	local bagID = self:GetID()

	if not(InvData:IsCachedBag(bagID, player) or bagID <= 0) then
		PlaySound('BAGMENUBUTTONPRESS')
		PickupBagFromSlot(InvData:GetInvSlot(bagID))
	end
end

--tooltip functions
function Bag:OnEnter()
	local frame = self:GetParent()
	local player = frame:GetPlayer()
	local bagID = self:GetID()

	self:AnchorTooltip()

	--backpack tooltip
	if bagID == BACKPACK_CONTAINER then
		GameTooltip:SetText(BACKPACK_TOOLTIP, 1, 1, 1)
	--bank specific code
	elseif bagID == BANK_CONTAINER then
		GameTooltip:SetText(L.Bank, 1, 1, 1)
	--keyring specific code...again
	elseif bagID == KEYRING_CONTAINER then
		GameTooltip:SetText(KEYRING, 1, 1, 1)
	--cached bags
	elseif InvData:IsCachedBag(bagID, player) then
		if BagnonDB then
			local link = select(2, BagnonDB:GetBagData(bagID, player))
			if link then
				GameTooltip:SetHyperlink(link)
			else
				local numBankSlots = BagnonDB:GetNumBankSlots(player)
				if numBankSlots and bagID > (numBankSlots + 4) then
					GameTooltip:SetText(BANK_BAG_PURCHASE, 1, 1, 1)
					if player == UnitName('player') then
						SetTooltipMoney(GameTooltip, GetBankSlotCost(GetNumBankSlots()))
					end
				else
					GameTooltip:SetText(EQUIP_CONTAINER, 1, 1, 1)
				end
			end
		end
	--non cached bags
	else
		--if we don't set a tooltip (meaning there's an item) then determine if the slot is just empty, or an unpurchased bank slot
		--show the purchase cost if its unpurchased
		if not GameTooltip:SetInventoryItem('player', InvData:GetInvSlot(bagID)) then
			if bagID > (GetNumBankSlots() + 4) then
				GameTooltip:SetText(BANK_BAG_PURCHASE, 1, 1, 1)
				GameTooltip:AddLine(L.ClickToPurchase)
				SetTooltipMoney(GameTooltip, GetBankSlotCost(GetNumBankSlots()))
			else
				GameTooltip:SetText(EQUIP_CONTAINER, 1, 1, 1)
			end
		end
	end
	GameTooltip:Show()

	self:GetParent().itemFrame:HighlightBag(bagID)
end

Bag.UpdateTooltip = Bag.OnEnter

function Bag:OnLeave()
	GameTooltip:Hide()
	self:GetParent().itemFrame:HighlightBag(nil)
end


--[[ InvDataity Functions ]]--

--place the tooltip
function Bag:AnchorTooltip()
	if self:GetRight() > (GetScreenWidth()/2) then
		GameTooltip:SetOwner(self, 'ANCHOR_LEFT')
	else
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
	end
end

--show the purchase slot dialog
function Bag:PurchaseSlot()
	if not StaticPopupDialogs['CONFIRM_BUY_BANK_SLOT_COMBUCTOR'] then
		StaticPopupDialogs['CONFIRM_BUY_BANK_SLOT_COMBUCTOR'] = {
			text = TEXT(CONFIRM_BUY_BANK_SLOT),
			button1 = TEXT(YES),
			button2 = TEXT(NO),

			OnAccept = function(self) PurchaseSlot() end,

			OnShow = function(self) MoneyFrame_Update(self:GetName().. 'MoneyFrame', GetBankSlotCost(GetNumBankSlots())) end,

			hasMoneyFrame = 1,
			timeout = 0,
			hideOnEscape = 1,
		}
	end

	PlaySound('igMainMenuOption')
	StaticPopup_Show('CONFIRM_BUY_BANK_SLOT_COMBUCTOR')
end