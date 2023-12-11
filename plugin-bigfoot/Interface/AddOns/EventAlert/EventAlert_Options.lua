function EventAlert_Options_OnLoad()
    UIPanelWindows["EA_Options_Frame"] = {area = "center", pushable = 0};
end

function EventAlert_Options_Init()
	EA_Options_Frame_Header_Text:SetFontObject(GameFontNormal);
    EA_Options_Frame_Header_Text:SetText(EA_OPTIONS);
    --EA_Options_Frame_VerUrlText:SetText(EA_XOPT_VERURLTEXT);
    EA_Options_Frame_DoAlertSound:SetChecked(EA_Config.DoAlertSound);
    EA_Options_Frame_ShowFrame:SetChecked(EA_Config.ShowFrame);
    EA_Options_Frame_ShowName:SetChecked(EA_Config.ShowName);
    EA_Options_Frame_ShowFlash:SetChecked(EA_Config.ShowFlash);
    EA_Options_Frame_ShowTimer:SetChecked(EA_Config.ShowTimer);
    EA_Options_Frame_ChangeTimer:SetChecked(EA_Config.ChangeTimer);
    EA_Options_Frame_AltAlerts:SetChecked(EA_Config.AllowAltAlerts);
end

function EventAlert_Options_ToggleIconOptionsFrame()
	if EA_Icon_Options_Frame:IsVisible() then
  		EA_Icon_Options_Frame:Hide();
	else
		if EA_Class_Events_Frame:IsVisible() then EA_Class_Events_Frame:Hide(); end
		if EA_Alt_Alerts_Frame:IsVisible() then EA_Alt_Alerts_Frame:Hide(); end
		if EA_Other_Events_Frame:IsVisible() then EA_Other_Events_Frame:Hide(); end
		if EA_Target_Events_Frame:IsVisible() then EA_Target_Events_Frame:Hide(); end

		EA_Icon_Options_Frame:Show();
    end
end

function EventAlert_Options_ToggleClassEventsFrame()
	if EA_Class_Events_Frame:IsVisible() then
  		EA_Class_Events_Frame:Hide();
        if EA_Alt_Alerts_Frame:IsVisible() then EA_Alt_Alerts_Frame:Hide(); end
   	else
		if EA_Icon_Options_Frame:IsVisible() then EA_Icon_Options_Frame:Hide(); end
		if EA_Other_Events_Frame:IsVisible() then EA_Other_Events_Frame:Hide(); end
		if EA_Target_Events_Frame:IsVisible() then EA_Target_Events_Frame:Hide(); end

		EA_Class_Events_Frame:Show();
        if (EA_Config.AllowAltAlerts == true) then
			EA_Alt_Alerts_Frame:Show();
        else
			EA_Alt_Alerts_Frame:Hide();
        end
    end
end

function EventAlert_Options_ToggleOtherEventsFrame()
	if EA_Other_Events_Frame:IsVisible() then
  		EA_Other_Events_Frame:Hide();
   	else
		if EA_Icon_Options_Frame:IsVisible() then EA_Icon_Options_Frame:Hide(); end
		if EA_Class_Events_Frame:IsVisible() then EA_Class_Events_Frame:Hide(); end
		if EA_Alt_Alerts_Frame:IsVisible() then EA_Alt_Alerts_Frame:Hide(); end
		if EA_Target_Events_Frame:IsVisible() then EA_Target_Events_Frame:Hide(); end

		EA_Other_Events_Frame:Show();
    end
end

function EventAlert_Options_ToggleTargetEventsFrame()
	if EA_Target_Events_Frame:IsVisible() then
  		EA_Target_Events_Frame:Hide();
   	else
		if EA_Icon_Options_Frame:IsVisible() then EA_Icon_Options_Frame:Hide(); end
		if EA_Class_Events_Frame:IsVisible() then EA_Class_Events_Frame:Hide(); end
		if EA_Alt_Alerts_Frame:IsVisible() then EA_Alt_Alerts_Frame:Hide(); end
		if EA_Other_Events_Frame:IsVisible() then EA_Other_Events_Frame:Hide(); end

		EA_Target_Events_Frame:Show();
    end
end


function EventAlert_Options_AlertSoundSelect_OnLoad()
	UIDropDownMenu_Initialize(this, EventAlert_Options_AlertSoundSelect_Initialize);
	UIDropDownMenu_SetSelectedID(this, EA_Config.AlertSoundValue);
	UIDropDownMenu_SetWidth(EA_Options_Frame_AlertSoundSelect, 130);
end


function EventAlert_Options_AlertSoundSelect_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(EA_Options_Frame_AlertSoundSelect) ;
	local info;

	info = {};
	info.text = "ShaysBell";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 1;
    if ( info.value == selectedValue ) then
		info.checked = 1;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Flute";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 2;
    if ( info.value == selectedValue ) then
		info.checked = 2;
	end
    UIDropDownMenu_AddButton(info);

    info = {};
	info.text = "Netherwind";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 3;
    if ( info.value == selectedValue ) then
		info.checked = 3;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "PolyCow";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 4;
    if ( info.value == selectedValue ) then
		info.checked = 4;
	end
    UIDropDownMenu_AddButton(info);

    info = {};
	info.text = "Rockbiter";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 5;
    if ( info.value == selectedValue ) then
		info.checked = 5;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Yarrrr!";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 6;
    if ( info.value == selectedValue ) then
		info.checked = 6;
	end
    UIDropDownMenu_AddButton(info);

    info = {};
	info.text = "Broken Heart";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 7;
    if ( info.value == selectedValue ) then
		info.checked = 7;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Millhouse 1!";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 8;
    if ( info.value == selectedValue ) then
		info.checked = 8;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Millhouse 2!";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 9;
    if ( info.value == selectedValue ) then
		info.checked = 9;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Pissed Satyr";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 10;
    if ( info.value == selectedValue ) then
		info.checked = 10;
	end
    UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Pissed Dwarf";
	info.func = EventAlert_Options_AlertSoundSelect_OnClick;
	info.value = 11;
    if ( info.value == selectedValue ) then
		info.checked = 11;
	end
    UIDropDownMenu_AddButton(info);
end


function EventAlert_Options_AlertSoundSelect_OnClick()
	UIDropDownMenu_SetSelectedValue(EA_Options_Frame_AlertSoundSelect, this.value);

	if (this.value == 1) then
		EA_Config.AlertSound = "Sound\\Spells\\ShaysBell.wav";
    	EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 2) then
		 EA_Config.AlertSound = "Sound\\Spells\\FluteRun.wav";
		 EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 3) then
		 EA_Config.AlertSound = "Sound\\Spells\\NetherwindFocusImpact.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 4) then
		 EA_Config.AlertSound = "Sound\\Spells\\PolyMorphCow.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 5) then
		 EA_Config.AlertSound = "Sound\\Spells\\RockBiterImpact.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 6) then
		 EA_Config.AlertSound = "Sound\\Spells\\YarrrrImpact.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 7) then
		 EA_Config.AlertSound = "Sound\\Spells\\valentines_brokenheart.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 8) then
		 EA_Config.AlertSound = "Sound\\Creature\\MillhouseManastorm\\TEMPEST_Millhouse_Ready01.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 9) then
		 EA_Config.AlertSound = "Sound\\Creature\\MillhouseManastorm\\TEMPEST_Millhouse_Pyro01.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 10) then
		 EA_Config.AlertSound = "Sound\\Creature\\Satyre\\SatyrePissed4.wav";
         EA_Config.AlertSoundValue = this.value;
    elseif (this.value == 11) then
		 EA_Config.AlertSound = "Sound\\Creature\\Mortar Team\\MortarTeamPissed9.wav";
         EA_Config.AlertSoundValue = this.value;
    end
    PlaySoundFile(EA_Config.AlertSound);
end

function EventAlert_Options_MouseDown(button)
    if button == "LeftButton" then
        EA_Options_Frame:StartMoving();
    end
end

function EventAlert_Options_MouseUp(button)
    if button == "LeftButton" then
        EA_Options_Frame:StopMovingOrSizing();
    end
end