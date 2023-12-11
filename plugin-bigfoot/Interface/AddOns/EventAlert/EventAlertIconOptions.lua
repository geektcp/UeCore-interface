-- Terry@bf
--localize menu



function EA_Icon_Options_OnLoad()
    UIPanelWindows["EA_Icon_Options_Frame"] = {area = "center", pushable = 0};
end

function EA_Icon_Options_Init()
    EA_Icon_Options_Frame_IconSize:SetValue(EA_Config.IconSize);
	EA_Icon_Options_Frame_IconXOffset:SetValue(EA_Position.xOffset);
	EA_Icon_Options_Frame_IconYOffset:SetValue(EA_Position.yOffset);
    EA_Icon_Options_Frame_LockFrame:SetChecked(EA_Config.LockFrame);
end

function EventAlert_Options_ToggleAlertFrame()
local timerFontSize = 0;

	if EA_Anchor_Frame:IsVisible() then
	   EA_Anchor_Frame:Hide();
	   EA_Anchor_Frame2:Hide();
	   EA_Anchor_Frame3:Hide();
    else
		if (EA_Config.ShowFrame == true) then

	        EA_Anchor_Frame:ClearAllPoints();
		    EA_Anchor_Frame:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);

	        EA_Anchor_Frame2:ClearAllPoints();
        	EA_Anchor_Frame2:SetPoint("CENTER", EA_Anchor_Frame, 100+EA_Position.xOffset, 0+EA_Position.yOffset);

	        EA_Anchor_Frame3:ClearAllPoints();
        	EA_Anchor_Frame3:SetPoint("CENTER", EA_Anchor_Frame2, 100+EA_Position.xOffset, 0+EA_Position.yOffset);


	        if (EA_Config.ShowName == true) then
		        EA_Anchor_Frame_Name:SetText(EVENT_ALERT_FRAME);
		        EA_Anchor_Frame2_Name:SetText(EVENT_ALERT_FRAME);
		        EA_Anchor_Frame3_Name:SetText(EVENT_ALERT_FRAME);
	        else
	            EA_Anchor_Frame_Name:SetText("");
	            EA_Anchor_Frame2_Name:SetText("");
	            EA_Anchor_Frame3_Name:SetText("");
	    	end

	       	if (EA_Config.ShowTimer == true) then
				if (EA_Config.ChangeTimer == true) then
	               timerFontSize = 28;
	               EA_Anchor_Frame_Timer:ClearAllPoints();
	               EA_Anchor_Frame_Timer:SetPoint("CENTER", 0, 0);
	               EA_Anchor_Frame2_Timer:ClearAllPoints();
	               EA_Anchor_Frame2_Timer:SetPoint("CENTER", 0, 0);
	               EA_Anchor_Frame3_Timer:ClearAllPoints();
	               EA_Anchor_Frame3_Timer:SetPoint("CENTER", 0, 0);
	        	else
	            	timerFontSize = 18;
	                EA_Anchor_Frame_Timer:ClearAllPoints();
	                EA_Anchor_Frame_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame2_Timer:ClearAllPoints();
	                EA_Anchor_Frame2_Timer:SetPoint("TOP", 0, 20);
	                EA_Anchor_Frame3_Timer:ClearAllPoints();
	                EA_Anchor_Frame3_Timer:SetPoint("TOP", 0, 20);
	            end

	            EA_Anchor_Frame_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame_Timer:SetText(EA_TIME_LEFT);
                EA_Anchor_Frame2_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame2_Timer:SetText(EA_TIME_LEFT);
                EA_Anchor_Frame3_Timer:SetFont("Fonts\\\FRIZQT__.TTF", timerFontSize, "OUTLINE");
                EA_Anchor_Frame3_Timer:SetText(EA_TIME_LEFT);
	        else
				EA_Anchor_Frame_Timer:SetText("");
				EA_Anchor_Frame2_Timer:SetText("");
				EA_Anchor_Frame3_Timer:SetText("");
	    	end

    	    EA_Anchor_Frame:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame:SetHeight(EA_Config.IconSize);
    	    EA_Anchor_Frame2:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame2:SetHeight(EA_Config.IconSize);
    	    EA_Anchor_Frame3:SetWidth(EA_Config.IconSize);
	        EA_Anchor_Frame3:SetHeight(EA_Config.IconSize);
	        EA_Anchor_Frame:Show();
	        EA_Anchor_Frame2:Show();
	        EA_Anchor_Frame3:Show();

		end


        if (EA_Config.ShowFlash == true) then
        	UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
			UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
        end

        if (EA_Config.DoAlertSound == true) then
	        PlaySoundFile(EA_Config.AlertSound);
		end
	end
end


function EventAlert_Options_ResetFrame()
	if (EA_Config.LockFrame == true) then
	    DEFAULT_CHAT_FRAME:AddMessage("EventAlert: You must unlock the alert frame in order to move it or reset it's position.")
	else
		EA_Position.Anchor = "CENTER";
        EA_Position.relativePoint = "CENTER";
		EA_Position.xLoc = 114;
		EA_Position.yLoc = 81;
        EA_Position.xOffset = 0;
        EA_Position.yOffset = 0;

		EA_Anchor_Frame:ClearAllPoints();
	    EA_Anchor_Frame:SetPoint(EA_Position.Anchor, EA_Position.xLoc, EA_Position.yLoc);

		EA_Icon_Options_Frame_IconXOffset:SetValue(EA_Position.xOffset);
		EA_Icon_Options_Frame_IconYOffset:SetValue(EA_Position.yOffset);
        EventAlert_Options_ToggleAlertFrame();
        EventAlert_Options_ToggleAlertFrame();
	end
end


function EA_Icon_Options_Frame_MouseDown(button)
    if button == "LeftButton" then
        EA_Icon_Options_Frame:StartMoving();
    end
end

function EA_Icon_Options_Frame_MouseUp(button)
    if button == "LeftButton" then
        EA_Icon_Options_Frame:StopMovingOrSizing();
    end
end