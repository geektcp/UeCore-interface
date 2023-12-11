function EventAlert_Target_Events_Frame_OnLoad()
    UIPanelWindows["EA_Target_Events_Frame"] = {area = "center", pushable = 0};
end

function EventAlert_Target_Events_Frame_Init()
	EA_Target_Events_Frame_Target_MyDebuff:SetChecked(EA_Config.Target_MyDebuff);
	-- EA_Target_Events_Frame_HelpText1:SetText(EX_XCLSALERT_HELP1);
	-- EA_Target_Events_Frame_HelpText2:SetText(EX_XCLSALERT_HELP2);
	-- EA_Target_Events_Frame_HelpText3:SetText(EX_XCLSALERT_HELP3);
	-- EA_Target_Events_Frame_EditBox:SetFontObject(ChatFontNormal);
	-- EA_Target_Events_Frame_EditBox:SetText(EX_XCLSALERT_SPELLURL);
	EA_Target_Events_Frame_SpellText:SetText(EX_XCLSALERT_SPELL);
	EA_Target_Events_Frame_SpellEditBox:SetFontObject(ChatFontNormal);
	EA_Target_Events_Frame_SpellEditBox:SetText("");

	local framewidht = EA_Target_Events_Frame:GetWidth();
	local panel3 = CreateFrame("ScrollFrame", "EA_Target_Events_Frame_SpellListFrameScroll", EA_Target_Events_Frame, "UIPanelScrollFrameTemplate");
	local scc = CreateFrame("Frame", "EA_Target_Events_Frame_SpellListFrame", panel3);
		panel3:SetScrollChild(scc);
		panel3:SetPoint("TOPLEFT", EA_Target_Events_Frame, "TOPLEFT", 15, -55);
		scc:SetPoint("TOPLEFT", panel3, "TOPLEFT", 0, 0);
		panel3:SetWidth(framewidht-45);
		panel3:SetHeight(370);
		scc:SetWidth(framewidht-45);
		scc:SetHeight(370);
		panel3:SetHorizontalScroll(-50);
		panel3:SetVerticalScroll(50);
		panel3:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		panel3:SetScript("OnVerticalScroll", function()  end);
		panel3:EnableMouse(true);
		panel3:SetVerticalScroll(0);
		panel3:SetHorizontalScroll(0);
end

-- function pairsByKeys (t, f)
-- 	local a = {}
-- 		for n in pairs(t) do table.insert(a, n) end
-- 		table.sort(a, f)
-- 		local i = 0      -- iterator variable
-- 		local iter = function ()   -- iterator function
-- 			i = i + 1
-- 			if a[i] == nil then return nil
-- 			else return a[i], t[a[i]]
-- 			end
-- 		end
-- 	return iter
-- end

function EventAlert_Target_Events_Frame_MouseDown(button)
    if button == "LeftButton" then
        -- Target_Events_Frame:StartMoving();
    end
end

function EventAlert_Target_Events_Frame_MouseUp(button)
    if button == "LeftButton" then
        -- Target_Events_Frame:StopMovingOrSizing();
    end
end

function EventAlert_Target_Events_Frame_AddSpell()
	local spellID = EA_Target_Events_Frame_SpellEditBox:GetText();
	-- DEFAULT_CHAT_FRAME:AddMessage("Add spellID = "..spellID);
	if spellID ~= nil and spellID ~= "" then
		spellID = tonumber(spellID);
		-- Check if is a valid spellID
		local sname = GetSpellInfo(spellID);
		if (sname ~= nil) then
			EventAlert_Target_Events_Frame_ClearTargetSpellList();
			if EA_TarItems[EA_playerClass][spellID] == nil then EA_TarItems[EA_playerClass][spellID] = true end;
			CreateFrames_CreateSpellFrame(spellID, true);
			CreateFrames_RefreshTargetSpellList();
		end
	end 
end

function EventAlert_Target_Events_Frame_DelSpell()
	local spellID = EA_Target_Events_Frame_SpellEditBox:GetText();
	-- DEFAULT_CHAT_FRAME:AddMessage("Del spellID = "..spellID);
	if spellID ~= nil and spellID ~= "" then
		spellID = tonumber(spellID);
		local TempPlayerClass = {};
		local IsCurrSpell = false;
		for index,value in pairsByKeys(EA_TarItems[EA_playerClass]) do
			if (index ~= spellID) then
				-- Store the existed spells
				TempPlayerClass[index] = value;
			else
				-- Find the spell match to delete
				IsCurrSpell = true;
			end;
		end
	 
		-- Check if is a spell in current list
		if (IsCurrSpell) then
			EventAlert_Target_Events_Frame_ClearTargetSpellList();
			EA_TarItems[EA_playerClass] = TempPlayerClass;
			_G["EAFrame_"..spellID] = nil;
			CreateFrames_RefreshTargetSpellList();
		end
	end
end

function EventAlert_Target_Events_Frame_ClearTargetSpellList()
	for index,value in pairsByKeys(EA_TarItems[EA_playerClass]) do
		-- DEFAULT_CHAT_FRAME:AddMessage("Clear spellID = "..index);
		local f1 = _G["EA_TargetFrame_Icon_"..index]; 
		local f2 = _G["EA_TargetFrame_Chkbtn_"..index]; 
		f1:Hide(); 
		f2:Hide(); 
	end
end
