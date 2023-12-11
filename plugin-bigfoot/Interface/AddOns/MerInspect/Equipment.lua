if GetLocale()~='zhCN' then return end
local M = MerInspect;
M.statLogic = LibStub("LibStatLogic-1.1")
local equipTable

function M:MergeEquipTable(equips)
	--合并所有值为数字的同类项（数字的）
	for _,eq in ipairs(equips) do
		for name,val in pairs(eq) do
			if name and type(val)=='number' then
				self.effect[name] = self.effect[name] or 0
				self.effect[name] = self.effect[name] + val
			end
		end
	end
	return merged
end

function M:FindSet(link,unit,i)
	self.tooltip:SetOwner(UIParent, "ANCHOR_NONE");
	self.tooltip:ClearLines();
	self.tooltip:SetInventoryItem(unit,i);		
	for j = 2, self.tooltip:NumLines() do
		local textLeft=_G[self.tooltip:GetName() .."TextLeft" .. j]
		if textLeft then
			txt = textLeft:GetText();
			r, g, b = textLeft:GetTextColor();
			if strfind(txt, "%(%d/%d%)") or strfind(txt, "（%d/%d）") then			
				if self.set[txt] then
					break;
				else
					self.set[txt] = select(3, strfind(link,"(|c%x+)|Hitem:.-|h|r")) or "|cffffffff";
				end
			end
		end
	end
end

function M:ScanUnitEquipment(unit, class, race, level)
	local link, txt, r, g, b;
	equipTable = {}
	for i = 1, 19 do
		link = GetInventoryItemLink(unit, i);
		if link then
			local itemSum ={}
			self.statLogic:GetSum(link,itemSum)
			tinsert(equipTable,itemSum)
			self:FindSet(link,unit,i)
		end
	end
	M:MergeEquipTable(equipTable)
end

tinsert(M.QueueScan, "ScanUnitEquipment");

function M:UpdateMainFrame(unit, class, race, level, talent)
	local frame;	

	self:OnShowInspectFrame(talent);	
	--[[frame = MerInspectRES;
	frame.button1.text:SetText(self:GetEffect("Resistance_Arcane") or 0);
	frame.button2.text:SetText(self:GetEffect("Resistance_Fire") or 0);
	frame.button3.text:SetText(self:GetEffect("Resistance_Nature") or 0);
	frame.button4.text:SetText(self:GetEffect("Resistance_Frost") or 0);
	frame.button5.text:SetText(self:GetEffect("Resistance_Shadow") or 0)
	
	frame = MerInspectBase
	frame.text1:SetText(self.loc.Strength);
	frame.text2:SetText(self.loc.Agility);
	frame.text3:SetText(self.loc.Stamina);
	frame.text4:SetText(self.loc.Intellect);
	frame.text5:SetText(self.loc.Spirit);
	frame.text6:SetText(self.loc.Resilience);
	frame.text7:SetText(self.loc.Armor);

	frame.stat1:SetText(self:GetEffect("Strength"));
	frame.stat2:SetText(self:GetEffect("Agility"));
	frame.stat3:SetText(self:GetEffect("Stamina"));
	frame.stat4:SetText(self:GetEffect("Intellect"));
	frame.stat5:SetText(self:GetEffect("Spirit"));
	frame.stat6:SetText(self:GetEffect("Resilience"));
	frame.stat7:SetText(self:GetEffect("Armor"));;]]
end

tinsert(M.QueueShow, "UpdateMainFrame");
