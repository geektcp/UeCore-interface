function EventAlert_Icon_Options_Frame_OnLoad()
    UIPanelWindows["EA_Icon_Options_Frame"] = {area = "center", pushable = 0};
end

function EventAlert_Icon_Options_Frame_Init()
    EA_Icon_Options_Frame_IconSize:SetValue(EA_Config.IconSize);
	EA_Icon_Options_Frame_IconXOffset:SetValue(EA_Position.xOffset);
	EA_Icon_Options_Frame_IconYOffset:SetValue(EA_Position.yOffset);
	EA_Icon_Options_Frame_IconRedDebuff:SetValue((EA_Position.RedDebuff * 100) - 50);
	EA_Icon_Options_Frame_IconGreenDebuff:SetValue((EA_Position.GreenDebuff * 100) - 50);
    EA_Icon_Options_Frame_LockFrame:SetChecked(EA_Config.LockFrame);
	-- EA_Icon_Options_Frame_Tar_IconXOffset:SetValue(EA_Position.Tar_xOffset);
	-- EA_Icon_Options_Frame_Tar_IconYOffset:SetValue(EA_Position.Tar_yOffset);
	-- EA_Icon_Options_Frame_Tar_NewLine:SetChecked(EA_Position.Tar_NewLine);
end

function EventAlert_Icon_Options_Frame_ToggleAlertFrame()
	if EA_Anchor_Frame1:IsVisible() then
		EA_Anchor_Frame1:Hide();
		EA_Anchor_Frame2:Hide();
		EA_Anchor_Frame3:Hide();
		EA_Anchor_Frame4:Hide();
		EA_Anchor_Frame5:Hide();
    else
		if (EA_Config.ShowFrame == true) then
			EA_Anchor_Frame1:Show();
			EventAlert_Icon_Options_Frame_PaintAlertFrame();
		end

        if (EA_Config.ShowFlash == true) then
        	UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
			UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
        end

		EventAlert_Icon_Options_Frame_ToggleNewLineAnchor();

        -- if (EA_Config.DoAlertSound == true) then
	        -- PlaySoundFile(EA_Config.AlertSound);
		-- end
	end
end

function EventAlert_Icon_Options_Frame_PaintAlertFrame()
	if EA_Anchor_Frame1 ~= nil then
		if EA_Anchor_Frame1:IsVisible() then
			local xOffset = 100 + EA_Position.xOffset;
			local yOffset = 0 + EA_Position.yOffset;

	        EA_Anchor_Frame1:ClearAllPoints();
		    EA_Anchor_Frame1:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);

	        EA_Anchor_Frame2:ClearAllPoints();
	    	EA_Anchor_Frame2:SetPoint("CENTER", EA_Anchor_Frame1, xOffset, yOffset);

	        EA_Anchor_Frame3:ClearAllPoints();
	    	EA_Anchor_Frame3:SetPoint("CENTER", EA_Anchor_Frame2, xOffset, yOffset);
			EA_Anchor_Frame3:SetBackdropColor(1.0, EA_Position.RedDebuff, EA_Position.RedDebuff);

			 EA_Anchor_Frame4:ClearAllPoints();
			EA_Anchor_Frame4:SetPoint(EA_Position.TarAnchor, EA_Position.Tar_xOffset, EA_Position.Tar_yOffset);
			EA_Anchor_Frame4:SetBackdropColor(EA_Position.GreenDebuff, 1.0, EA_Position.GreenDebuff);

			EA_Anchor_Frame5:ClearAllPoints();
			EA_Anchor_Frame5:SetPoint("CENTER", EA_Anchor_Frame4, xOffset, yOffset);
			EA_Anchor_Frame5:SetBackdropColor(EA_Position.GreenDebuff, 1.0, EA_Position.GreenDebuff);

	        if (EA_Config.ShowName == true) then
		        -- EA_Anchor_Frame1_Name:SetText("Event Alert Frame");
		        -- EA_Anchor_Frame2_Name:SetText("Event Alert Frame");
		        -- EA_Anchor_Frame3_Name:SetText("Event Alert Frame");
		        EA_Anchor_Frame1_Name:SetText(EA_XICON_SELF_BUFF.."(1)");
		        EA_Anchor_Frame2_Name:SetText(EA_XICON_SELF_BUFF.."(2)");
		        EA_Anchor_Frame3_Name:SetText(EA_XICON_SELF_DEBUFF.."(3)");
		        EA_Anchor_Frame4_Name:SetText(EA_XICON_TARGET_DEBUFF.."(1)");
		        EA_Anchor_Frame5_Name:SetText(EA_XICON_TARGET_DEBUFF.."(2)");
	        else
	            EA_Anchor_Frame1_Name:SetText("");
	            EA_Anchor_Frame2_Name:SetText("");
	            EA_Anchor_Frame3_Name:SetText("");
	            EA_Anchor_Frame4_Name:SetText("");
	            EA_Anchor_Frame5_Name:SetText("");
	    	end

	       	if (EA_Config.ShowTimer == true) then
				if (EA_Config.ChangeTimer == true) then
	                -- timerFontSize = 28;
	                EA_Anchor_Frame1_Timer:ClearAllPoints();
	                EA_Anchor_Frame1_Timer:SetPoint("CENTER", 0, 0);
	                EA_Anchor_Frame2_Timer:ClearAllPoints();
	                EA_Anchor_Frame2_Timer:SetPoint("CENTER", 0, 0);
	                EA_Anchor_Frame3_Timer:ClearAllPoints();
	                EA_Anchor_Frame3_Timer:SetPoint("CENTER", 0, 0);
	                EA_Anchor_Frame4_Timer:ClearAllPoints();
	                EA_Anchor_Frame4_Timer:SetPoint("CENTER", 0, 0);
	                EA_Anchor_Frame5_Timer:ClearAllPoints();
	                EA_Anchor_Frame5_Timer:SetPoint("CENTER", 0, 0);
	        	else
	            	-- timerFontSize = 18;
	                EA_Anchor_Frame1_Timer:ClearAllPoints();
	                EA_Anchor_Frame1_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame2_Timer:ClearAllPoints();
	                EA_Anchor_Frame2_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame3_Timer:ClearAllPoints();
	                EA_Anchor_Frame3_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame4_Timer:ClearAllPoints();
	                EA_Anchor_Frame4_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame5_Timer:ClearAllPoints();
	                EA_Anchor_Frame5_Timer:SetPoint("TOP", 0, 20);
	            end

	            EA_Anchor_Frame1_Timer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
	            EA_Anchor_Frame1_Timer:SetText(0);
	            EA_Anchor_Frame2_Timer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
	            EA_Anchor_Frame2_Timer:SetText(0);
	            EA_Anchor_Frame3_Timer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
	            EA_Anchor_Frame3_Timer:SetText(0);
	            EA_Anchor_Frame4_Timer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
	            EA_Anchor_Frame4_Timer:SetText(0);
	            EA_Anchor_Frame5_Timer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
	            EA_Anchor_Frame5_Timer:SetText(0);
	        else
				EA_Anchor_Frame1_Timer:SetText("");
				EA_Anchor_Frame2_Timer:SetText("");
				EA_Anchor_Frame3_Timer:SetText("");
				EA_Anchor_Frame4_Timer:SetText("");
				EA_Anchor_Frame5_Timer:SetText("");
	    	end

		    EA_Anchor_Frame1:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame1:SetHeight(EA_Config.IconSize);
		    EA_Anchor_Frame2:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame2:SetHeight(EA_Config.IconSize);
		    EA_Anchor_Frame3:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame3:SetHeight(EA_Config.IconSize);
		    EA_Anchor_Frame4:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame4:SetHeight(EA_Config.IconSize);
		    EA_Anchor_Frame5:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame5:SetHeight(EA_Config.IconSize);
	        EA_Anchor_Frame1:Show();
	        EA_Anchor_Frame2:Show();
	        EA_Anchor_Frame3:Show();
	        EA_Anchor_Frame4:Show();
	        EA_Anchor_Frame5:Show();
		end
	end
end

function EventAlert_Icon_Options_Frame_AdjustTimerFontSize()
	if (EA_Config.ChangeTimer == true) then
		EA_Config.TimerFontSize = 28;
		EA_Config.StackFontSize = 18;
		if EA_Config.IconSize < 60 then
			EA_Config.TimerFontSize = 28 + (EA_Config.IconSize - 60) * 0.3;
			EA_Config.StackFontSize = 18 + (EA_Config.IconSize - 60) * 0.3;
		end
	else
		EA_Config.TimerFontSize = 18;
		EA_Config.StackFontSize = 18;
		if EA_Config.IconSize > 60 then
			EA_Config.TimerFontSize = 22;
		end;
		if EA_Config.IconSize < 60 then
			EA_Config.StackFontSize = 18 + (EA_Config.IconSize - 60) * 0.3;
		end
	end
	EA_Config.SNameFontSize = EA_Config.IconSize / 4;
	if EA_Config.SNameFontSize < 10 then EA_Config.SNameFontSize = 10 end;
end

function EventAlert_Icon_Options_Frame_ResetFrame()
	if (EA_Config.LockFrame == true) then
		-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert: You must unlock the alert frame in order to move it or reset it's position.")
	    DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00EventAlert\124r: "..EA_XICON_LOCKFRAMETIP);
	else
		EA_Position.Anchor = "CENTER";
		EA_Position.relativePoint = "CENTER";
		EA_Position.xLoc = 136;
		EA_Position.yLoc = 46;
		EA_Position.xOffset = 0;
		EA_Position.yOffset = 0;
		EA_Position.RedDebuff = 0;
		EA_Position.GreenDebuff = 0;

		EA_Anchor_Frame1:ClearAllPoints();
	    EA_Anchor_Frame1:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);

		EA_Icon_Options_Frame_IconXOffset:SetValue(EA_Position.xOffset);
		EA_Icon_Options_Frame_IconYOffset:SetValue(EA_Position.yOffset);
		EA_Icon_Options_Frame_IconRedDebuff:SetValue((EA_Position.RedDebuff * 100) - 50);
		EA_Icon_Options_Frame_IconGreenDebuff:SetValue((EA_Position.GreenDebuff * 100) - 50);
		EventAlert_Icon_Options_Frame_ToggleNewLineAnchor();
        EventAlert_Icon_Options_Frame_ToggleAlertFrame();
	end
end


function EventAlert_Icon_Options_Frame_MouseDown(button)
    if button == "LeftButton" then
        -- EA_Icon_Options_Frame:StartMoving();
    end
end

function EventAlert_Icon_Options_Frame_MouseUp(button)
    if button == "LeftButton" then
        -- EA_Icon_Options_Frame:StopMovingOrSizing();
    end
end

function EventAlert_Icon_Options_Frame_ToggleNewLineAnchor()
	EA_Anchor_Frame4:SetScript("OnMouseDown", EventAlert_Icon_Options_Frame_Anchor_OnMouseDown2);
	EA_Anchor_Frame4:SetScript("OnMouseUp", EventAlert_Icon_Options_Frame_Anchor_OnMouseUp2);
	EA_Anchor_Frame5:SetScript("OnMouseDown", EventAlert_Icon_Options_Frame_Anchor_OnMouseDown2);
	EA_Anchor_Frame5:SetScript("OnMouseUp", EventAlert_Icon_Options_Frame_Anchor_OnMouseUp2);
end

function EventAlert_Icon_Options_Frame_Anchor_OnMouseDown()
	if (EA_Config.LockFrame == true) then
	    DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00EventAlert\124r: "..EA_XICON_LOCKFRAMETIP);
	else
	    EA_Anchor_Frame1:StartMoving();
    end
end

function EventAlert_Icon_Options_Frame_Anchor_OnMouseUp()
	EA_Anchor_Frame1:StopMovingOrSizing();
    local EA_point, _, EA_relativePoint, EA_xOfs, EA_yOfs = EA_Anchor_Frame1:GetPoint();
    EA_Position.Anchor = EA_point;
    EA_Position.relativePoint = EA_relativePoint;
    EA_Position.xLoc = EA_xOfs;
	EA_Position.yLoc = EA_yOfs;
    -- DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00EventAlert2\124r EA_yOfs: "..EA_yOfs);
end

function EventAlert_Icon_Options_Frame_Anchor_OnMouseDown2()
	if (EA_Config.LockFrame == true) then
	    DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00EventAlert\124r: "..EA_XICON_LOCKFRAMETIP);
	else
	    EA_Anchor_Frame4:StartMoving();
    end
end

function EventAlert_Icon_Options_Frame_Anchor_OnMouseUp2()
	EA_Anchor_Frame4:StopMovingOrSizing();
    local EA_point, UIParent, EA_relativePoint, EA_x4Ofs, EA_y4Ofs = EA_Anchor_Frame4:GetPoint();
    EA_Position.TarAnchor = EA_point;
    EA_Position.TarrelativePoint = EA_relativePoint;
    EA_Position.Tar_xOffset = EA_x4Ofs;
	EA_Position.Tar_yOffset = EA_y4Ofs;
	-- EA_Icon_Options_Frame_Tar_IconXOffset:SetValue(EA_Position.Tar_xOffset);
	-- EA_Icon_Options_Frame_Tar_IconYOffset:SetValue(EA_Position.Tar_yOffset);
	-- print("EA_point="..EA_point.." / EA_relativePoint="..EA_relativePoint.." / EA_x4Ofs="..EA_x4Ofs.." / EA_y4Ofs="..EA_y4Ofs);
    -- DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00EventAlert2\124r EA_yOfs: "..EA_yOfs);
end