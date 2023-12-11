local EnableCompare = true;	-- 控制是否显示比较
local isHooked = nil;

local QCompare_Eventer = BLibrary("BEvent");
local QCompare_Hooker = BLibrary("BHook");
-------------------
-- 比系统的更棒的装备比较
-------------------
local function QuickCompare_Tooltip_OnShow(OringFunc, tooltip, customtip)	
	OringFunc(tooltip, customtip);
	-- Ctrl键被按下, 或者Tooltip上不是Item时返回
	local tooltip = tooltip or GameTooltip;
	local item, link = tooltip:GetItem();
	if (not EnableCompare or IsControlKeyDown() or not link) then
		return;
	end
	
	-- 以下Frame时忽略
	local frame = GetMouseFocus() and GetMouseFocus():GetName() or "";	
	if strfind(frame,"^Character.*Slot$")		-- 装备栏忽略
		or strfind(frame,"^TempEnchant%d+$")	-- 临时魔法忽略
		or strfind(frame, "^TM_Button")			-- 饰品栏忽略
		or strfind(frame, "^TrinketMenu")		-- 饰品栏忽略
	then return end
	--correct anchor if tooltip is in right half of screen
	local anchor, align="TOPLEFT", "TOPRIGHT";
	local scale = tooltip:GetScale();
	local escale = tooltip:GetEffectiveScale();

	
	local item1 = nil;
	local item2 = nil;	
	local shoptip1 = getglobal((customtip or "ShoppingTooltip")..1);
	local shoptip2 = getglobal((customtip or "ShoppingTooltip")..2);
	if (shoptip1:SetHyperlinkCompareItem(link, 1) ) then
		item1 = true;
	end
	if ( shoptip2:SetHyperlinkCompareItem(link, 2) ) then
		item2 = true;
	end

	-- find correct side
	local rightDist = 0;
	local leftPos = tooltip:GetLeft();
	local rightPos = tooltip:GetRight();
	if ( not rightPos ) then
		rightPos = 0;
	end
	if ( not leftPos ) then
		leftPos = 0;
	end

	rightDist = GetScreenWidth() - rightPos;
	leftDist = leftPos;

	if (leftPos and (rightDist < leftPos)) then		
		anchor, align = "TOPRIGHT", "TOPLEFT";
	end

	local totalWidth = 0;
	if ( item1  ) then
		totalWidth = totalWidth + shoptip1:GetWidth();
	end
	if ( item2  ) then
		totalWidth = totalWidth + shoptip2:GetWidth();
	end

	local offsetx, offsety = GetCursorPosition();
	local realRightPos = rightPos * escale;
	local realLeftPos = leftPos * escale;

	if (anchor == "TOPLEFT" and offsetx > realRightPos) then
		anchor, align = "TOPRIGHT", "TOPLEFT";
	elseif (anchor == "TOPRIGHT" and offsetx < realLeftPos) then
		anchor, align = "TOPLEFT", "TOPRIGHT";
	end

	if (anchor == "TOPRIGHT" and totalWidth > leftPos * escale) then
		anchor, align = "TOPLEFT", "TOPRIGHT";
	elseif (anchor == "TOPLEFT" and (rightPos * escale + totalWidth) >  GetScreenWidth() * escale) then
		anchor, align = "TOPRIGHT", "TOPLEFT";
	end

	-- see if we should slide the tooltip
	if ( tooltip:GetAnchorType() ) then
		if ( (anchor == "TOPRIGHT") and (totalWidth > leftPos) ) then
			tooltip:SetAnchorType(tooltip:GetAnchorType(), (totalWidth - leftPos), 0);
		elseif ( (anchor == "TOPLEFT") and (rightPos + totalWidth) >  GetScreenWidth() ) then
			tooltip:SetAnchorType(tooltip:GetAnchorType(), -((rightPos + totalWidth) - GetScreenWidth()), 0);
		end
	end
	
	local anchorframe = tooltip;
	local dy = 0;

	for i=1, 2 do			
		local shoptip = getglobal((customtip or "ShoppingTooltip")..i);
		
		if (shoptip:SetHyperlinkCompareItem(link, i)) then			
			shoptip:SetOwner(tooltip, "ANCHOR_NONE");			
			shoptip:SetHyperlinkCompareItem(link, i);
			shoptip:ClearAllPoints();

			local shoptiptext = getglobal(shoptip:GetName().."TextLeft1");			
			local newtext = "|cffE0E0E0["..CURRENTLY_EQUIPPED.. "]|r";
			shoptiptext:SetText("|cffE0E0E0["..CURRENTLY_EQUIPPED.. "]|r");			

			local bottom, top=shoptip:GetBottom(), shoptip:GetTop();
			local uibottom, uitop=UIParent:GetBottom(),UIParent:GetTop();
			if (bottom and bottom*scale-10<=uibottom) then				
				dy = uibottom-bottom+(10*scale);			
			end
	
			shoptip:SetPoint(anchor, anchorframe, align, 0, dy);
			shoptip:SetScale(scale);
			shoptip:Show(); 

			--last comparison tooltip becomes anchorframe for next comparison tooltip
			anchorframe = shoptip;
			dy = 0;
		end
	end
end

-------------------
-- on hyperlink enter, show tooltip (alternative to ItemRef)
-------------------
local function AjustIconPos()
	local tooltip = getglobal("GameTooltip");
	if (not getglobal("GameTooltipTextLeft"..3):GetText()) then
		GameTooltipItemButton:ClearAllPoints();
		GameTooltipItemButton:SetPoint("TOPRIGHT",tooltip,"TOPLEFT",-1,-4);
		return;
	end
	GameTooltipItemButton:ClearAllPoints();
	GameTooltipItemButton:SetPoint("TOPRIGHT",tooltip,"TOPRIGHT",-6,-8);
	local maxWidth = 0;
	for i=1, 2, 1 do
		local text = getglobal("GameTooltipTextLeft"..i);
		maxWidth = text:GetWidth()>maxWidth and text:GetWidth() or maxWidth;		
	end
	local gWidth = tooltip:GetWidth();		
	if ((maxWidth+50) > gWidth) then
		tooltip:SetWidth(maxWidth+50);
	end
end

local function ChatFrame_OnHyperlinkEnter(self, linkData, link)
	GameTooltip:SetOwner(self,"ANCHOR_TOPRIGHT");
	if strfind(linkData,"^item") or strfind(linkData,"^enchant") then
		GameTooltip:SetHyperlink(linkData);
		GameTooltip:Show();	
		local _,_,_,_,_,_,_,_,_,icon=GetItemInfo(linkData);
		if icon then
			GameTooltipItemButtonIconTexture:SetTexture(icon);
			GameTooltipItemButton:Show();		
		end	
		AjustIconPos();
	elseif (strfind(linkData,"^achievement")) then
		GameTooltip:SetHyperlink(linkData);
		GameTooltip:Show();	
	elseif (strfind(linkData,"^quest")) then
		GameTooltip:SetHyperlink(linkData);
		GameTooltip:Show();	
	end		
end


local function ChatFrame_OnHyperlinkLeave()
	GameTooltipItemButtonIconTexture:SetTexture("");
	GameTooltipItemButton:Hide();
	GameTooltip:Hide();
end

local function QuickCompare_SetItemRef(link, text, button)	
	ItemRefCompareTooltip1:Hide();
	ItemRefCompareTooltip2:Hide();
	if (EnableCompare) then
		QuickCompare_Tooltip_OnShow(function() end, ItemRefTooltip, "ItemRefCompareTooltip");
	end	
end

function QuickCompare_Toggle(switch)	
	if (switch) then
		EnableCompare = true;
		--GameTooltip OnShow	
		QCompare_Hooker:HookScript(GameTooltip, "OnShow", QuickCompare_Tooltip_OnShow);
		if (not isHooked) then
			hooksecurefunc("SetItemRef", QuickCompare_SetItemRef);
			hooksecurefunc("GameTooltip_ShowCompareItem", function() if (not EnableCompare) then return; end QuickCompare_Tooltip_OnShow(function() end); end);
		end
		GameTooltip:HookScript("OnHide",function() 
			if GameTooltipItemButtonIconTexture then 
				GameTooltipItemButtonIconTexture:SetTexture("");
				GameTooltipItemButton:Hide();
			end  
		end)
		local worldFrame_MouseUp=WorldFrame:GetScript("OnMouseUp")
		if worldFrame_MouseUp then
			 WorldFrame:HookScript("OnMouseUp",function()
				GameTooltip:Hide()
			end)
		else
			 WorldFrame:SetScript("OnMouseUp",function()
				GameTooltip:Hide()
			end)
			
		end
		
		
		-- 保持BF原来的风格
		getglobal("ShoppingTooltip1"):SetBackdropColor(0.3,0.3,0.0);
		getglobal("ShoppingTooltip2"):SetBackdropColor(0.3,0.3,0.0);	
	
		--Hyperlink enter and leave
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i);
			frame:SetScript("OnHyperlinkEnter", ChatFrame_OnHyperlinkEnter);
			frame:SetScript("OnHyperlinkLeave", ChatFrame_OnHyperlinkLeave);
		end		
		isHooked = true;
	else
		EnableCompare = nil;
		QCompare_Hooker:UnhookScript(GameTooltip, "OnShow");
		--Hyperlink enter and leave
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i);
			frame:SetScript("OnHyperlinkEnter",function() end);
			frame:SetScript("OnHyperlinkLeave",function() end);
		end		
	end	
end
