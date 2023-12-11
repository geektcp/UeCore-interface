--[[
	Combuctor.lua
		Some sort of crazy visual inventory management system
--]]

Combuctor = LibStub('AceAddon-3.0'):NewAddon('Combuctor', 'AceEvent-3.0', 'AceConsole-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')
local CURRENT_VERSION = GetAddOnMetadata('Combuctor', 'Version')

--set the binding name stuff here, since its mostly locale independent
BINDING_HEADER_COMBUCTOR = 'Combuctor'
BINDING_NAME_COMBUCTOR_TOGGLE_INVENTORY = L.ToggleInventory
BINDING_NAME_COMBUCTOR_TOGGLE_BANK = L.ToggleBank

--[[
	Loading/Profile Functions
--]]

function Combuctor:OnInitialize()
	self.profile = self:InitDB()

	--version update
	local version = self.db.version
	if version then
		if version ~= CURRENT_VERSION then
			self:UpdateSettings(version:match('(%w+)%.(%w+)%.(%w+)'))
			self:UpdateVersion()
		end
	--new user
	else
		version = CURRENT_VERSION
	end

	--create a loader for the options menu
	local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
	f:SetScript('OnShow', function(self)
		self:SetScript('OnShow', nil)
		LoadAddOn('Combuctor_Config')
	end)

	--slash command support
	self:RegisterChatCommand('combuctor', 'OnSlashCommand')
	self:RegisterChatCommand('cbt', 'OnSlashCommand')
end

function Combuctor:InitDB()
	if not CombuctorDB3 then
		CombuctorDB3 = {
			version = CURRENT_VERSION,
			global = {
				maxScale = 1.2,
			},
			profiles = {
			}
		}
	end
	self.db = CombuctorDB3

	return self:GetProfile() or self:InitProfile()
end

function Combuctor:GetProfile(player)
	if not player then
		player = UnitName('player')
	end
	return self.db.profiles[player .. ' - ' .. GetRealmName()]
end


local function addSet(sets, exclude, name, ...)
	if sets then
		table.insert(sets, name)
	else
		sets = {name}
	end

	if select('#', ...) > 0 then
		if exclude then
			table.insert(exclude, {[name] = {...}})
		else
			exclude = {[name] = {...}}
		end
	end

	return sets, exclude
end

local function getDefaultInventorySets(class)
	local sets, exclude

	if class == 'WARLOCK' then
		sets, exclude = addSet(sets, exclude, L.All, L.Normal,L.Trade,L.Ammo)
	else
		sets, exclude = addSet(sets, exclude, L.All, L.Normal,L.Trade,L.Shards,L.Ammo)
	end
	sets, exclude = addSet(sets, exclude, L.Equipment)
	sets, exclude = addSet(sets, exclude, L.TradeGood)
	sets, exclude = addSet(sets, exclude, L.Quest)
	sets, exclude = addSet(sets, exclude, L.Consumable)
	sets, exclude = addSet(sets, exclude, L.Misc)	
	return sets, exclude
end

local function getDefaultBankSets(class)
	local sets, exclude = addSet(sets, exclude, L.All, L.Shards, L.Ammo, L.Keys)
	sets, exclude = addSet(sets, exclude, L.Equipment)
	sets, exclude = addSet(sets, exclude, L.TradeGood)
	sets, exclude = addSet(sets, exclude, L.Quest)
	sets, exclude = addSet(sets, exclude, L.Consumable)
	sets, exclude = addSet(sets, exclude, L.Misc)

	return sets, exclude
end

function Combuctor:InitProfile()
	local player, realm = UnitName('player'), GetRealmName()
	local class = select(2, UnitClass('player'))
	local numberSlot =0
	for i=0,4,1 do
		numberSlot=numberSlot+GetContainerNumSlots(i)
	end
	local ratio = math.max(math.ceil(math.sqrt(numberSlot))/7,1)
	local profile = self:GetBaseProfile(ratio)

	profile.inventory.sets, profile.inventory.exclude = getDefaultInventorySets(class)
	profile.bank.sets, profile.bank.exclude = getDefaultBankSets(class)

	self.db.profiles[player .. ' - ' .. realm] = profile
	return profile
end

function Combuctor:GetBaseProfile(ratio)
	return {
		inventory = {
			bags = {-2, 0, 1, 2, 3, 4},
			position = {'RIGHT'},
			showBags = false,
			w = 500*ratio,
			h = 512*ratio,
		},

		bank = {
			bags = {-1, 5, 6, 7, 8, 9, 10, 11},
			showBags = false,
			w = 560,
			h = 650,
		}
	}
end

function Combuctor:UpdateSettings(major, minor, bugfix)
end

function Combuctor:UpdateVersion()
	self.db.version = CURRENT_VERSION
	self:Print(format(L.Updated, self.db.version))
end


--[[
	Events
--]]

function Combuctor:OnEnable()
	local profile = Combuctor:GetProfile(UnitName('player'))
	ContainerFrame_Update_ORIG = ContainerFrame_Update_ORIG or ContainerFrame_Update

	self.frames = {
		self.Frame:New(L.InventoryTitle, profile.inventory, false, 'inventory'),
		self.Frame:New(L.BankTitle, profile.bank, true, 'bank')
	}
	--load config here
	--hook bank or backpack or both or none
--	self:HookBagEvents(false,true)
end

local function showBackPack()
	Combuctor:Show(BACKPACK_CONTAINER, true)
end

local function hideBackPack()
	Combuctor:Hide(BACKPACK_CONTAINER, true)
end

local function toggleBag(bag,configBank,configBackPack)
	if configBank==1 and configBackPack==1 then --integrate for both bank and backpack
		Combuctor:Toggle(bag)	
		ContainerFrame_Update =function() end
	elseif configBank==1 then --integrate for bank only
		if bag ==-1 or bag >4 then
			Combuctor:Toggle(bag)	
		else
			ToggleBag_ORIG(bag)
		end
		ContainerFrame_Update =function(frame)
			local id = frame:GetID()
			if id == -1 or id > 4 then
			else
				ContainerFrame_Update_ORIG(frame)
			end
		end
	elseif configBackPack==1 then  --integrate for backpack only
		if bag ==-1 or bag >4 then
			ToggleBag_ORIG(bag)
		else
			Combuctor:Toggle(bag)	
		end
		ContainerFrame_Update =function(frame)
			local id = frame:GetID()
			if id == -1 or id > 4 then
				ContainerFrame_Update_ORIG(frame)
			end
		end
	else--integrate none
		ToggleBag_ORIG(bag)
		ContainerFrame_Update = ContainerFrame_Update_ORIG
	end	
end

local function toggleBackPack()
	Combuctor:Toggle(BACKPACK_CONTAINER)	
end

local function toggleKeyRing()
	Combuctor:Toggle(KEYRING_CONTAINER)
end

local function openAllBags(force)
	if force then
		Combuctor:Show(BACKPACK_CONTAINER)
	else
		Combuctor:Toggle(BACKPACK_CONTAINER)
	end
end

local function bankOpened()
	Combuctor:Show(BANK_CONTAINER, true)
	Combuctor:Show(BACKPACK_CONTAINER, true)
end

local function bankClosed()
	Combuctor:Hide(BANK_CONTAINER, true)
	Combuctor:Hide(BACKPACK_CONTAINER, true)
end

function Combuctor:HookBagEvents(configBank,configBackPack)

	--save original functions
	OpenBackPack_ORIG 	= OpenBackPack_ORIG 	or OpenBackpack
	ToggleBackpack_ORIG = ToggleBackpack_ORIG 	or ToggleBackpack
	ToggleKeyRing_ORIG	= ToggleKeyRing_ORIG 	or ToggleKeyRing
	OpenAllBags_ORIG	= OpenAllBags_ORIG 		or OpenAllBags 
	
	ToggleBag_ORIG    	= ToggleBag_ORIG 		or ToggleBag	
	ToggleBag = function (bag)
		toggleBag(bag,configBank,configBackPack)
	end
	for i = 1, 13 do
		if (_G["ContainerFrame"..i]) then
			_G["ContainerFrame"..i].size = _G["ContainerFrame"..i].size or (GetContainerNumSlots and GetContainerNumSlots(i)) or 1
		end
	end
		

	--auto magic display code
	if configBackPack==1  then
		OpenBackpack 	= showBackPack
		ToggleBackpack 	= toggleBackPack
		ToggleKeyRing 	= toggleKeyRing
		OpenAllBags		= openAllBags
		self:RegisterEvent('TRADE_SHOW', showBackPack)
		self:RegisterEvent('AUCTION_HOUSE_SHOW', showBackPack)
		self:RegisterMessage('COMBUCTOR_BANK_OPENED', function()
			self:Show(BACKPACK_CONTAINER, true)
		end)
		self:RegisterMessage('COMBUCTOR_BANK_CLOSED', function()
			self:Hide(BACKPACK_CONTAINER, true)
		end)
	else
		OpenBackpack 	= OpenBackPack_ORIG 	or OpenBackpack
		ToggleBackpack 	= ToggleBackpack_ORIG 	or ToggleBackpack	
		ToggleKeyRing 	= ToggleKeyRing_ORIG 	or ToggleKeyRing
		OpenAllBags		= OpenAllBags_ORIG 		or OpenAllBags
		self:UnregisterEvent('TRADE_SHOW')
		self:UnregisterEvent('AUCTION_HOUSE_SHOW')
		self:UnregisterMessage('COMBUCTOR_BANK_OPENED')
		self:UnregisterMessage('COMBUCTOR_BANK_CLOSED')
	end
	
	if configBank ==1 then
		BankFrame:UnregisterAllEvents()
		self:RegisterMessage('COMBUCTOR_BANK_OPENED', function()
			self:Show(BANK_CONTAINER, true)
		end)
		self:RegisterMessage('COMBUCTOR_BANK_CLOSED', function()
			self:Hide(BANK_CONTAINER, true)
			self:Hide(BACKPACK_CONTAINER, true)
		end)
	else
		BankFrame:RegisterEvent('BANKFRAME_OPENED')
		BankFrame:RegisterEvent('BANKFRAME_CLOSED')
		self:UnregisterMessage('COMBUCTOR_BANK_OPENED')
		self:UnregisterMessage('COMBUCTOR_BANK_CLOSED')
	end
	
	
	
	hooksecurefunc('CloseBackpack', hideBackPack)
	--closing the game menu triggers this function, and can be done in combat,
	hooksecurefunc('CloseAllBags', function()
		self:Hide(BACKPACK_CONTAINER)
	end)
	
	self:RegisterEvent('MAIL_CLOSED', hideBackPack)
	self:RegisterEvent('TRADE_CLOSED', hideBackPack)
	self:RegisterEvent('AUCTION_HOUSE_CLOSED', hideBackPack)
end

function Combuctor:Show(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				frame:ShowFrame(auto)
				return
			end
		end
	end
end

function Combuctor:Hide(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				frame:HideFrame(auto)
				return
			end
		end
	end
end

function Combuctor:Toggle(bag, auto)
	for _,frame in pairs(self.frames) do
		for _,bagID in pairs(frame.sets.bags) do
			if bagID == bag then
				frame:ToggleFrame(auto)
				if bag==KEYRING_CONTAINER then
					frame:SetSubCategory(L.Keys)
					if (_G["ContainerFrame"..bag]) then
						_G["ContainerFrame"..bag].size = _G["ContainerFrame"..bag].size or (GetKeyRingSize and GetKeyRingSize() ) or 1
					end
				else
					frame:SetSubCategory(L.All)			
				end
				return
			end
		end
	end
end

function Combuctor:ShowOptions()
	if LoadAddOn('Combuctor_Config') then
		InterfaceOptionsFrame_OpenToCategory(self.Options)
		return true
	end
	return false
end

function Combuctor:OnSlashCommand(msg)
	local msg = msg and msg:lower()

	if msg == 'bank' then
		self:Toggle(BANK_CONTAINER)
	elseif msg == 'bags' then
		self:Toggle(BACKPACK_CONTAINER)
	elseif msg == '' or msg == 'config' or msg == 'options' then
		self:ShowOptions()
	else
		self:Print('Commands (/cbt or /combuctor)')
		print('- bank: Toggle bank')
		print('- bags: Toggle inventory')
		print('- options: Shows the options menu')
	end
end


--[[ Utility Functions ]]--

function Combuctor:SetMaxItemScale(scale)
	self.db.global.maxScale = scale or 1
end

function Combuctor:GetMaxItemScale()
	return self.db.global.maxScale
end

--utility function: create a widget class
function Combuctor:NewClass(type, parentClass)
	local class = CreateFrame(type)
	class.mt = {__index = class}

	if parentClass then
		class = setmetatable(class, {__index = parentClass})
		class.super = parentClass
	end

	function class:Bind(o)
		return setmetatable(o, self.mt)
	end

	return class
end