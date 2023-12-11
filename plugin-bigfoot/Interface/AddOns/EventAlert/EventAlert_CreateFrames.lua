function EventAlert_CreateFrames()
	-- Create anchor frames used for mod customization.
        -- local anchorFrameName = "EA_Anchor_Frame1";

        if (EA_Config.AllowESC == true) then
	        tinsert(UISpecialFrames,"EA_Anchor_Frame1");
        end

		CreateFrames_CreateAnchorFrame("EA_Anchor_Frame1", false);
		CreateFrames_CreateAnchorFrame("EA_Anchor_Frame2", false);
		CreateFrames_CreateAnchorFrame("EA_Anchor_Frame3", false);
		CreateFrames_CreateAnchorFrame("EA_Anchor_Frame4", true);
		CreateFrames_CreateAnchorFrame("EA_Anchor_Frame5", true);
		EA_Anchor_Frame1:SetPoint(EA_Position.Anchor, UIParent, EA_Position.xLoc, EA_Position.yLoc);
        EA_Anchor_Frame2:SetPoint("CENTER", EA_Anchor_Frame1, 100+EA_Position.xOffset, 0+EA_Position.yOffset);
        EA_Anchor_Frame3:SetPoint("CENTER", EA_Anchor_Frame2, 100+EA_Position.xOffset, 0+EA_Position.yOffset);
        EA_Anchor_Frame4:SetPoint("CENTER", EA_Anchor_Frame1, -1 * (100+EA_Position.xOffset), -1 * (0+EA_Position.yOffset));
        -- EA_Anchor_Frame4:SetPoint(EA_Position.TarAnchor, UIParent, -1 * (100+EA_Position.xOffset), -1 * (0+EA_Position.yOffset));
        EA_Anchor_Frame5:SetPoint("CENTER", EA_Anchor_Frame4, -1 * (100+EA_Position.xOffset), -1 * (0+EA_Position.yOffset));
		EA_Anchor_Frame1:Hide();

	-- Create primary alert frames
		for index,value in pairsByKeys(EA_Items[EA_playerClass]) do
			if (type(value) == "number") then
				value = tostring(index)
			elseif (type(value) == "boolean") then
				if (value) then
					value = "true"
			    else
				    value = "false"
			    end
			end
			CreateFrames_CreateSpellFrame(index, false);
	    end


	-- Create alternate alert frames
		for index,value in pairsByKeys(EA_AltItems[EA_playerClass]) do
			if (type(value) == "number") then
				value = tostring(index)
			elseif (type(value) == "boolean") then
				if (value) then
					value = "true"
			    else
				    value = "false"
			    end
			end
			CreateFrames_CreateSpellFrame(index, false);
	    end


	-- Create other alert frames. (Mostly trinket procs)
		for index,value in pairsByKeys(EA_Items[EA_CLASS_OTHER]) do
			if (type(value) == "number") then
				value = tostring(index)
			elseif (type(value) == "boolean") then
				if (value) then
					value = "true"
			    else
				    value = "false"
			    end
			end
			CreateFrames_CreateSpellFrame(index, false);
	    end


	-- Create Target's Debuffs alert frames. (Target's Debuffs only now)
		for index,value in pairsByKeys(EA_TarItems[EA_playerClass]) do
			if (type(value) == "number") then
				value = tostring(index)
			elseif (type(value) == "boolean") then
				if (value) then
					value = "true"
			    else
				    value = "false"
			    end
			end
			CreateFrames_CreateSpellFrame(index, true);
		end

	local EA_OptHeight = EA_Options_Frame:GetHeight();

	-- Create Class Alert menu buttons, etc
		CreateFrames_RefreshPrimarySpellList();
		EA_Class_Events_Frame:SetHeight(EA_OptHeight);


	-- Create Class Alternate Alerts menu buttons
		CreateFrames_RefreshAlternateSpellList();
		EA_Alt_Alerts_Frame:SetHeight(EA_OptHeight);


	-- Create Other Alerts menu buttons
		CreateFrames_RefreshOtherSpellList();
		EA_Other_Events_Frame:SetHeight(EA_OptHeight);


	-- Create Target Alert menu buttons, etc
		CreateFrames_RefreshTargetSpellList();
		EA_Target_Events_Frame:SetHeight(EA_OptHeight);
end


function CreateFrames_CreateSpellFrame(index, IsTarget)
    local eaf = CreateFrame("Cooldown", "EAFrame_"..index, EA_Main_Frame, "CooldownFrameTemplate");
    eaf.noCooldownCount = true;

    if (EA_Config.AllowESC == true) then
        tinsert(UISpecialFrames,"EAFrame_"..index);
    end

    eaf:SetFrameStrata("DIALOG");
	eaf.spellName = eaf:CreateFontString("EAFrame_"..index.."_Name","OVERLAY");
	eaf.spellName:SetFontObject(ChatFontNormal);
	eaf.spellName:SetPoint("BOTTOM", 0, -15);

	eaf.spellTimer = eaf:CreateFontString("EAFrame_"..index.."_Timer","OVERLAY");
	eaf.spellTimer:SetFontObject(ChatFontNormal);
	eaf.spellTimer:SetPoint("TOP", 0, 15);

	eaf.spellStack = eaf:CreateFontString("EAFrame_"..index.."_Stack","OVERLAY");
	eaf.spellStack:SetFontObject(ChatFontNormal);
	eaf.spellStack:SetPoint("BOTTOMRIGHT", 0, 15);

	local spellId = tonumber(index);
	local name, rank, icon = GetSpellInfo(spellId);
	if IsTarget then
		if EA_SPELLINFO_TARGET[spellId] == nil then EA_SPELLINFO_TARGET[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
		EA_SPELLINFO_TARGET[spellId].name = name;
		EA_SPELLINFO_TARGET[spellId].rank = rank;
		EA_SPELLINFO_TARGET[spellId].icon = icon;
	else
		if EA_SPELLINFO_SELF[spellId] == nil then EA_SPELLINFO_SELF[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
		EA_SPELLINFO_SELF[spellId].name = name;
		EA_SPELLINFO_SELF[spellId].rank = rank;
		if (spellId == 48517) then
			-- Druid / Eclipse (Solar): replace the Icon as Wrath (Rank 1)
			_, _, icon, _, _, _, _, _, _ = GetSpellInfo(5176);
		elseif (spellId == 48518) then
			-- Druid / Eclipse (Lunar): replace the Icon as Starfire (Rank 1)
			_, _, icon, _, _, _, _, _, _ = GetSpellInfo(2912);
		end
		EA_SPELLINFO_SELF[spellId].icon = icon;
	end
    -- if (IsTarget) then
    -- 	eaf:SetScript("OnEvent", EventAlert_OnTarEvent);
    -- else
    -- 	eaf:SetScript("OnEvent", EventAlert_OnEvent);
    -- end
    -- eaf:SetScript("OnUpdate", EventAlert_OnUpdate);
end


function CreateFrames_CreateAnchorFrame(AnchorFrameName, IsNewLine)
        local eaaf = CreateFrame("FRAME", AnchorFrameName, UIParent);
        eaaf:SetFrameStrata("DIALOG");
        eaaf:ClearAllPoints();
  		eaaf:SetBackdrop({bgFile = "Interface/Icons/Spell_Nature_Polymorph_Cow"});

		eaaf.spellName = eaaf:CreateFontString(AnchorFrameName.."_Name","OVERLAY");
		eaaf.spellName:SetFontObject(ChatFontNormal);
		eaaf.spellName:SetPoint("BOTTOM", 0, -15);

		eaaf.spellTimer = eaaf:CreateFontString(AnchorFrameName.."_Timer","OVERLAY");
		eaaf.spellTimer:SetFontObject(ChatFontNormal);
		eaaf.spellTimer:SetPoint("TOP", 0, 15);

		eaaf:SetMovable(true);
		eaaf:EnableMouse(true);
		if (IsNewLine) then
			eaaf:SetScript("OnMouseDown", EventAlert_Icon_Options_Frame_Anchor_OnMouseDown2);
			eaaf:SetScript("OnMouseUp", EventAlert_Icon_Options_Frame_Anchor_OnMouseUp2);
		else
			eaaf:SetScript("OnMouseDown", EventAlert_Icon_Options_Frame_Anchor_OnMouseDown);
			eaaf:SetScript("OnMouseUp", EventAlert_Icon_Options_Frame_Anchor_OnMouseUp);
		end
end


function CreateFrames_RefreshPrimarySpellList()
	-- local buttonPositionY = -60 + 25;
	local buttonPositionY = 0;
	for index,value in pairsByKeys(EA_Items[EA_playerClass]) do
		if (type(value) == "number") then
			value = tostring(index)
		elseif (type(value) == "boolean") then
			if (value) then
				value = "true"
		    else
			    value = "false"
		    end
		end

    	local EA_name, EA_rank, EA_icon = GetSpellInfo(index);
        --[[
        	Blizzard isn't consistent with the names and ranks of the procs in relation to the names/ranks of the talents.
	        So, we have to add the code below to make the options menu understandable for certain items.
            And because of localization, I have to go back and re-call the original talent ID.
            Which is, honestly, damned annoying.  But... oh well!  QQ, right?
        --]]
        if (EA_name == "Death Trance!") then
	        local EA_name2, _, EA_icon = GetSpellInfo(49018);
    	    EA_name = EA_name2;
        end
        if (EA_name == "Fireball!") then
	        local EA_name2, _, EA_icon = GetSpellInfo(44549);
    	    EA_name = EA_name2;
        end
        if (index == 12536) then
	        local EA_name3, _, EA_icon = GetSpellInfo(11213);
    	    EA_name = EA_name3;
        end
        if (index == 16870) then
			local EA_name4, _, EA_icon = GetSpellInfo(16864);
	        EA_name = EA_name4;
        end
        if (index == 48517) then
        	local EA_name5, _, EA_icon = GetSpellInfo(5176);
	        EA_rank = EA_name5;
        end
        if (index == 48518) then
	        local EA_name6, _, EA_icon = GetSpellInfo(2912);
    	    EA_rank = EA_name6;
        end
        if (index == 34754) then
	        local EA_name7, _, EA_icon = GetSpellInfo(34753);
    	    EA_name = EA_name7;
        end
        if (index == 14743 or index == 27828) then
			local EA_name8, _, EA_icon = GetSpellInfo(14531);
    	    EA_name = EA_name8;
        end
        if (index == 33151) then EA_rank = "" end;
        if (index == 16246) then
			local EA_name9, _, EA_icon = GetSpellInfo(16164);
	        EA_name = EA_name9;
        end
        if (index == 17941) then
	        local EA_name10, _, EA_icon = GetSpellInfo(18094);
    	    EA_name = EA_name10;
        end
        if (index == 46916) then
	        local EA_name11, _, EA_icon = GetSpellInfo(46913);
    	    EA_name = EA_name11;
        end

		-- 2010/5/24 Add the Icon of Spell -- Start
		local f1 = _G["EA_ClassFrame_Icon_"..index];
		if f1 == nil then
			-- local ClassEventIcon = CreateFrame("Frame", "EA_ClassFrame_Icon_"..index, EA_Class_Events_Frame);
			local ClassEventIcon = CreateFrame("Frame", "EA_ClassFrame_Icon_"..index, EA_Class_Events_Frame_SpellListFrame);
			ClassEventIcon:SetWidth(25);
			ClassEventIcon:SetHeight(25);
			ClassEventIcon:SetPoint("TOPLEFT",0,buttonPositionY);
			ClassEventIcon:SetBackdrop({bgFile = EA_icon});
		else
			f1:SetPoint("TOPLEFT",0,buttonPositionY);
			f1:Show();
		end

		local f2 = _G["EA_ClassFrame_Chkbtn_"..index];
		if f2 == nil then
	        -- local ClassEventCheckButton = CreateFrame("CheckButton", "EA_ClassFrame_Chkbtn_"..index, EA_Class_Events_Frame, "OptionsCheckButtonTemplate");
	        local ClassEventCheckButton = CreateFrame("CheckButton", "EA_ClassFrame_Chkbtn_"..index, EA_Class_Events_Frame_SpellListFrame, "OptionsCheckButtonTemplate");
			ClassEventCheckButton:SetPoint("TOPLEFT",25,buttonPositionY);

	        if (EA_rank == "") then
	            getglobal(ClassEventCheckButton:GetName().."Text"):SetText(EA_name.." ["..index.."]");
	        else
	            getglobal(ClassEventCheckButton:GetName().."Text"):SetText(EA_name.."("..EA_rank..") ["..index.."]");
	        end

	        ClassEventCheckButton:SetChecked(EA_Items[EA_playerClass][index]);
	        ClassEventCheckButton:SetChecked(EA_Items[EA_playerClass][index]);

			local function ClassEventButtonGetChecked()
				EA_Class_Events_Frame_SpellEditBox:SetText(tostring(index));
	        	if (ClassEventCheckButton:GetChecked()) then
	           		EA_Items[EA_playerClass][index] = true
				else
			   		EA_Items[EA_playerClass][index] = false
				end
	        end
	        ClassEventCheckButton:RegisterForClicks("AnyUp");
			ClassEventCheckButton:SetScript("OnClick", ClassEventButtonGetChecked);
		else
			f2:SetPoint("TOPLEFT",25,buttonPositionY);
			f2:Show();
		end

        buttonPositionY = buttonPositionY - 25;
	end
	-- local CEFHeight = -1*(buttonPositionY-140);
	-- local EA_OptHeight = EA_Options_Frame:GetHeight();
	-- if CEFHeight >= 800 then CEFHeight = 800 end;
	-- if CEFHeight < EA_OptHeight then CEFHeight = EA_OptHight end;
end


function CreateFrames_RefreshAlternateSpellList()
	-- local buttonPositionY = -60 + 25;
	local buttonPositionY = 0;
	for index,value in pairsByKeys(EA_AltItems[EA_playerClass]) do
		if (type(value) == "number") then
			value = tostring(index)
		elseif (type(value) == "boolean") then
			if (value) then
				value = "true"
		    else
			    value = "false"
		    end
		end
    	local EA_name, EA_rank, EA_icon = GetSpellInfo(index);

		local f1 = _G["EA_AltFrame_Icon_"..index];
		if f1 == nil then
			local AltClassEventIcon = CreateFrame("Frame", "EA_AltFrame_Icon_"..index, EA_Alt_Alerts_Frame_SpellListFrame);
			AltClassEventIcon:SetWidth(25);
			AltClassEventIcon:SetHeight(25);
			AltClassEventIcon:SetPoint("TOPLEFT",0,buttonPositionY);
			AltClassEventIcon:SetBackdrop({bgFile = EA_icon});
		else
			f1:SetPoint("TOPLEFT",0,buttonPositionY);
			f1:Show();
		end

		local f2 = _G["EA_AltFrame_Chkbtn_"..index];
		if f2 == nil then
			local AltAlertCheckButton = CreateFrame("CheckButton", "EA_AltFrame_Chkbtn_"..index, EA_Alt_Alerts_Frame_SpellListFrame, "OptionsCheckButtonTemplate");
			AltAlertCheckButton:SetPoint("TOPLEFT",25,buttonPositionY);
			if (EA_rank == "") then
				getglobal(AltAlertCheckButton:GetName().."Text"):SetText(EA_name.." ["..index.."]");
			else
				getglobal(AltAlertCheckButton:GetName().."Text"):SetText(EA_name.."("..EA_rank..") ["..index.."]");
			end

			AltAlertCheckButton:SetChecked(EA_AltItems[EA_playerClass][index]);
			AltAlertCheckButton:SetChecked(EA_AltItems[EA_playerClass][index]);
			local function AltAlertButtonGetChecked()
				if (AltAlertCheckButton:GetChecked()) then
					EA_AltItems[EA_playerClass][index] = true
				else
					EA_AltItems[EA_playerClass][index] = false
				end
			end
			AltAlertCheckButton:RegisterForClicks("AnyUp");
			AltAlertCheckButton:SetScript("OnClick", AltAlertButtonGetChecked)
		else
			f2:SetPoint("TOPLEFT",25,buttonPositionY);
			f2:Show();
		end
        buttonPositionY = buttonPositionY - 25;
	end
	-- local CEFHeight = -1*(buttonPositionY-60);
	-- local EA_OptHeight = EA_Options_Frame:GetHeight();
	-- if CEFHeight >= 800 then CEFHeight = 800 end;
	-- if CEFHeight < EA_OptHeight then CEFHeight = EA_OptHeight end;
end


function CreateFrames_RefreshOtherSpellList()
	-- local buttonPositionY = -60 + 25;
	local buttonPositionY = 0;
	for index,value in pairsByKeys(EA_Items[EA_CLASS_OTHER]) do
		if (type(value) == "number") then
			value = tostring(index)
		elseif (type(value) == "boolean") then
			if (value) then
				value = "true"
		    else
			    value = "false"
		    end
		end

    	local EA_name, EA_rank, EA_icon = GetSpellInfo(index);
		local f1 = _G["EA_OtherFrame_Icon_"..index];
		if f1 == nil then
			local OtherEventIcon = CreateFrame("Frame", "EA_OtherFrame_Icon_"..index, EA_Other_Events_Frame_SpellListFrame);
			OtherEventIcon:SetWidth(25);
			OtherEventIcon:SetHeight(25);
			OtherEventIcon:SetPoint("TOPLEFT",0,buttonPositionY);
			OtherEventIcon:SetBackdrop({bgFile = EA_icon});
		else
			f1:SetPoint("TOPLEFT",00,buttonPositionY);
			f1:Show();
		end

		local f2 = _G["EA_OtherFrame_Chkbtn_"..index];
		if f2 == nil then
	        local OtherEventCheckButton = CreateFrame("CheckButton", "EA_OtherFrame_Chkbtn_"..index, EA_Other_Events_Frame_SpellListFrame, "OptionsCheckButtonTemplate");
			OtherEventCheckButton:SetPoint("TOPLEFT",25,buttonPositionY);

	        if (EA_rank == "") then
	            getglobal(OtherEventCheckButton:GetName().."Text"):SetText(EA_name.." ["..index.."]");
	        else
	            getglobal(OtherEventCheckButton:GetName().."Text"):SetText(EA_name.."("..EA_rank..") ["..index.."]");
	        end

	        OtherEventCheckButton:SetChecked(EA_Items[EA_CLASS_OTHER][index]);
	        OtherEventCheckButton:SetChecked(EA_Items[EA_CLASS_OTHER][index]);

			local function OtherEventButtonGetChecked()
				EA_Other_Events_Frame_SpellEditBox:SetText(tostring(index));
	        	if (OtherEventCheckButton:GetChecked()) then
	           		EA_Items[EA_CLASS_OTHER][index] = true
				else
			   		EA_Items[EA_CLASS_OTHER][index] = false
				end
	        end
	        OtherEventCheckButton:RegisterForClicks("AnyUp");
			OtherEventCheckButton:SetScript("OnClick", OtherEventButtonGetChecked)
		else
			f2:SetPoint("TOPLEFT",25,buttonPositionY);
			f2:Show();
		end

        buttonPositionY = buttonPositionY - 25;
	end
	-- local CEFHeight = -1*(buttonPositionY-60);
	-- local EA_OptHeight = EA_Options_Frame:GetHeight();
	-- if CEFHeight >= 800 then CEFHeight = 800 end;
	-- if CEFHeight < EA_OptHeight then CEFHeight = EA_OptHeight end;
end



function CreateFrames_RefreshTargetSpellList()
	-- local buttonPositionY = -60;
	local buttonPositionY = 0;
	for index,value in pairsByKeys(EA_TarItems[EA_playerClass]) do
		if (type(value) == "number") then
			value = tostring(index)
		elseif (type(value) == "boolean") then
			if (value) then
				value = "true"
		    else
			    value = "false"
		    end
		end

    	local EA_name, EA_rank, EA_icon = GetSpellInfo(index);
		local f1 = _G["EA_TargetFrame_Icon_"..index];
		if f1 == nil then
			local TargetEventIcon = CreateFrame("Frame", "EA_TargetFrame_Icon_"..index, EA_Target_Events_Frame_SpellListFrame);
			TargetEventIcon:SetWidth(25);
			TargetEventIcon:SetHeight(25);
			TargetEventIcon:SetPoint("TOPLEFT",0,buttonPositionY);
			TargetEventIcon:SetBackdrop({bgFile = EA_icon});
		else
			f1:SetPoint("TOPLEFT",0,buttonPositionY);
			f1:Show();
		end

		local f2 = _G["EA_TargetFrame_Chkbtn_"..index];
		if f2 == nil then
	        local TargetEventCheckButton = CreateFrame("CheckButton", "EA_TargetFrame_Chkbtn_"..index, EA_Target_Events_Frame_SpellListFrame, "OptionsCheckButtonTemplate");
			TargetEventCheckButton:SetPoint("TOPLEFT",25,buttonPositionY);

	        if (EA_rank == "") then
	            getglobal(TargetEventCheckButton:GetName().."Text"):SetText(EA_name.." ["..index.."]");
	        else
	            getglobal(TargetEventCheckButton:GetName().."Text"):SetText(EA_name.."("..EA_rank..") ["..index.."]");
	        end

	        TargetEventCheckButton:SetChecked(EA_TarItems[EA_playerClass][index]);
	        TargetEventCheckButton:SetChecked(EA_TarItems[EA_playerClass][index]);

			local function TargetEventButtonGetChecked()
				EA_Target_Events_Frame_SpellEditBox:SetText(tostring(index));
	        	if (TargetEventCheckButton:GetChecked()) then
	           		EA_TarItems[EA_playerClass][index] = true
				else
			   		EA_TarItems[EA_playerClass][index] = false
				end
	        end
	        TargetEventCheckButton:RegisterForClicks("AnyUp");
			TargetEventCheckButton:SetScript("OnClick", TargetEventButtonGetChecked)
		else
			f2:SetPoint("TOPLEFT",25,buttonPositionY);
			f2:Show();
		end

        buttonPositionY = buttonPositionY - 25;
	end
	-- local CEFHeight = -1*(buttonPositionY-60);
	-- local EA_OptHeight = EA_Options_Frame:GetHeight();
	-- if CEFHeight >= 800 then CEFHeight = 800 end;
	-- if CEFHeight < EA_OptHeight then CEFHeight = EA_OptHeight end;
end

