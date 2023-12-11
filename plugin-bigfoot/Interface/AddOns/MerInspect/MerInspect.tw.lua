if GetLocale() ~='zhTW' then return end
MerInspectDB = {}

local M = LibStub('AceAddon-3.0'):NewAddon('MerInspect','AceEvent-3.0','AceConsole-3.0','AceHook-3.0',"AceTimer-3.0")
local _G = _G
local PaperDollFrame = _G.PaperDollFrame
if GetLocale()=='zhCN' then
	M_REPAIR_COST = "维修费用"
elseif  GetLocale()=='zhTW' then
	M_REPAIR_COST = "維修費用"
else
	M_REPAIR_COST = "Repair Cost"
end
local duraTooltip

local InventorySlots = {
	"HeadSlot|d",
	"NeckSlot|n",
	"ShoulderSlot|d",
	"BackSlot|n",
	"ChestSlot|d",
	"ShirtSlot|n",
	"TabardSlot|n",
	"WristSlot|d",
	"HandsSlot|d",
	"WaistSlot|d",
	"LegsSlot|d",
	"FeetSlot|d",
	"Finger0Slot|n",
	"Finger1Slot|n",
	"Trinket0Slot|n",
	"Trinket1Slot|n",
	"MainHandSlot|d",
	"SecondaryHandSlot|d",
	"RangedSlot|d",
};

local ITEM_COLOR = {	
	[0] = { r = 0.8, g = 0.8, b = 0.8, a = 0.8},
	[1] = { r = 0.5, g = 0.5, b = 0.5, a = 0.8},
	[2] = { r = 0, g = 1.0, b = 0, a = 0.8},
	[3] = { r = 0, g = 0.0, b = 1.0, a = 0.8},
	[4] = { r = 0.5, g = 0, b = 1.0, a = 0.8},
	[5] = { r = 1.0, g = 0.5, b = 0, a = 0.8},
	[6] = { r = 1.0, g = 0, b = 0, a = 0.8},
	[7] = { r = 1, g = 1, b = 0, a = 0.6 },
	[9] = { r = 1, g = 1, b = 0, a = 0.6 },
};

local function CreateBorder(name)
	local button = _G[name]
	local count = _G[name .. "Count"];	
	if button and count then
		button.border = button:CreateTexture(name .. "Border", "OVERLAY");
		button.border:SetAllPoints(button:GetNormalTexture());
		button.border:SetTexture("Interface\\AddOns\\MerInspect\\Border");
		count:ClearAllPoints();
		count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, 3);
		button.count = count
		button.border:Hide();		
	end
end

local function CreateRepairCostFrame()
	local moneyFrame = CreateFrame("Frame", "MerRepairMoneyFrame", PaperDollFrame, "SmallMoneyFrameTemplate");
	moneyFrame:SetPoint("BOTTOMLEFT", PlayerStatFrameLeftDropDown, "TOPLEFT", 24, 4);

	moneyFrame:SetScript("OnShow", function(self)
		MoneyFrame_SetType(self,"STATIC");		
	end);					
	moneyFrame.title = moneyFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	moneyFrame.title:SetPoint("BOTTOMLEFT", moneyFrame, "TOPLEFT", -2, 2);
	moneyFrame.title:SetText(M_REPAIR_COST);
	M.moneyFrame = moneyFrame
end

local function CreateInspectBorders()
	local s;
	for _, v in ipairs(InventorySlots) do
		s = strsplit("|", v);
		CreateBorder("Inspect"..s);
	end
end

local function CreatePaperdollBorders()
	local s;
	for _, v in ipairs(InventorySlots) do
		s = strsplit("|", v);
		CreateBorder("Character"..s);
	end
end

function MerInspect_Toggle(flag)
	M.config.enabled = flag
end

function MerInspect_ToogleD(flag)
	M.config.durability = flag
end

function MerInspect_ToogleH(flag)
	M.config.quality = flag
end

function M:ShowBorders(unit)
	local button,count,quality,suffix, hasItem,repairCos,itemLink;
	for i, v in ipairs(InventorySlots) do
		suffix = strsplit("|", v);
		button = (unit == "player") and _G["Character" .. suffix] or _G["Inspect" .. suffix];
		duraTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		duraTooltip:ClearLines();
		hasItem, _, repairCos = duraTooltip:SetInventoryItem(unit, button:GetID());
		itemLink = select(2, duraTooltip:GetItem());
		if (hasItem and  itemLink) then
			quality = select(3, GetItemInfo(itemLink));
			if (type(quality) == "number" and quality > 1) and self.config.enabled and self.config.quality then
				button.border:SetVertexColor(ITEM_COLOR[quality].r, ITEM_COLOR[quality].g, ITEM_COLOR[quality].b);
				button.border:Show();
			else
				button.border:Hide();
			end
		end
	end
end

function M:ShowRepairCost()
	local button, count, c, m, p, hasItem, itemLink, repairCos, quality, suffix, scan;
	local totalCos = 0
	for _, v in ipairs(InventorySlots) do
		suffix, scan = strsplit("|", v);
		button = _G["Character" .. suffix]
		count = _G[button:GetName() .."Count"]
		duraTooltip:SetOwner(UIParent, "ANCHOR_NONE");
		duraTooltip:ClearLines();
		hasItem, _, repairCos = duraTooltip:SetInventoryItem("player", button:GetID());
		itemLink = select(2, duraTooltip:GetItem());
		if (hasItem and  itemLink) then
			if scan == "d" and self.config.enabled and self.config.durability then
				-- 汇总修理费用
				totalCos = totalCos + repairCos;
				c, m = GetInventoryItemDurability(button:GetID());
				if (c and m and m > 0) then
					p = c / m;
					count:SetFormattedText("%d%%", floor(p * 100));
					button.durability=format("%d%%", floor(p * 100));
					if (p > 0.5) then
						count:SetTextColor(0.133, 0.78, 0.133);
					elseif (p > 0.25) then
						count:SetTextColor(1, 0.7 ,0.2);							
					else
						count:SetTextColor(1, 0, 0);							
					end
					count:Show()
				else
					button.durability=""
					count:Hide()
				end
			else
				button.durability=""			
				count:Hide()

			end
		else
			button.durability=""
			count:Hide()
			button.border:Hide();
		end
	end
	MoneyFrame_Update(self.moneyFrame:GetName(), totalCos or 0);
	if self.config.enabled then
		if totalCos == 0 then
			self.moneyFrame:Hide()
		else
			self.moneyFrame:Show()
		end
	else
		self.moneyFrame:Hide()
	end
end

function M:PaperDollFrameOnShow()
	self:ShowBorders("player")
	self:ShowRepairCost()
end

function M:PaperDollFrameOnHide()
end

function M:InspectPaperDollFrameOnShow()
	if InspectFrame.unit and UnitExists(InspectFrame.unit) and UnitIsPlayer(InspectFrame.unit) then
		self:ShowBorders(InspectFrame.unit)
	end
end

function M:InspectPaperDollFrameOnHide()
end

function M:UNIT_INVENTORY_CHANGED(...)
	local _,unit = ...
	if unit =="player" then
		self:PaperDollFrameOnShow()
	elseif M.InspectLoaded then
		self:InspectPaperDollFrameOnShow()
	end
end

function M:ADDON_LOADED(...)
	local _,addOn = ...
	if addOn == "Blizzard_InspectUI" then
		self:HookScript(InspectPaperDollFrame,"OnShow","InspectPaperDollFrameOnShow")
		self:HookScript(InspectPaperDollFrame,"OnHide","InspectPaperDollFrameOnHide")
		CreateInspectBorders()
		self:UnregisterEvent("ADDON_LOADED")
		self.InspectLoaded = true
	end
end

function M:OnEnable()
	self:HookScript(PaperDollFrame,"OnShow","PaperDollFrameOnShow")
	self:HookScript(PaperDollFrame,"OnHide","PaperDollFrameOnHide")
	hooksecurefunc("SetItemButtonCount",function(button,...)
		if not button then return end
		if button and button.durability then
			_G[button:GetName().."Count"]:SetText(button.durability)
			_G[button:GetName().."Count"]:Show()
		end
	end);
end

function M:OnDisable()
	self:UnhookAll()
end

function M:OnInitialize()
	self.config = MerInspectDB	
	CreateRepairCostFrame()
	CreatePaperdollBorders()
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	duraTooltip = CreateFrame("GameTooltip", "MerDurabilityTooltip", UIParent, "GameTooltipTemplate");
end
