local i
local queue = false
local function makeMovable(frame)
	local mover = _G[frame:GetName() .. "Mover"] or CreateFrame("Frame", frame:GetName() .. "Mover", frame)
	mover:EnableMouse(true)
	mover:SetPoint("TOP", frame, "TOP", 0, 10)
	mover:SetWidth(160)
	mover:SetHeight(40)
	mover:SetScript("OnMouseDown", function(self)
		self:GetParent():StartMoving()
	end)
	mover:SetScript("OnMouseUp", function(self)
		self:GetParent():StopMovingOrSizing()
	end)
	-- mover:SetClampedToScreen(true)		-- doesn't work?
	frame:SetMovable(true)
end

function GridClickSetsFrame_OnLoad(self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("VARIABLES_LOADED");
	makeMovable(self)
	PanelTemplates_SetNumTabs(self, 5);
	self.selectedTab = 1;
	PanelTemplates_UpdateTabs(self);

	for i = 1, 8 do
		getglobal("GridClickSetButton"..i.."Title"):SetText(GridClickSets_Titles[i])
	end

	GridClickSetsFrame_TabOnClick();
end

function GridClickSetsFrame_OnEvent(self, event)
	if(event=="PLAYER_REGEN_ENABLED") then
		if(queue) then
			GridClickSetsFrame_UpdateGridFrame()
			queue = false
		end
	end
end

function GridClickSetsFrame_TypeUpdate(id)
	local argF = getglobal("GridClickSetButton"..id.."Arg")
	local typeDD = getglobal("GridClickSetButton"..id.."Type")
	local value = UIDropDownMenu_GetSelectedValue(typeDD)
	if (not value) then value = "NONE" end

	if( value=="spell" or value=="macro" ) then
		argF:Show();
	else
		argF:Hide();
	end

	local below = getglobal("GridClickSetButton"..(id+1))
	if(below) then
		below:ClearAllPoints();
		if argF:IsVisible() then
			below:SetPoint("TOPLEFT", argF, "BOTTOMLEFT", -50, 0);
		else
			below:SetPoint("TOPLEFT", getglobal("GridClickSetButton"..id), "BOTTOMLEFT", 0, -5);
		end
	end
end

function GridClickSetsFrame_Resize()
	local k=0;
	local id
	for id=1, 8 do
		local argF = getglobal("GridClickSetButton"..id.."Arg")
		if(argF:IsVisible()) then
			k = k + argF:GetHeight() + 1;
		end
	end
	local height = 340 + k;
	if(height > 450) then
		GridClickSetsFrame:SetHeight(height);
	else
		GridClickSetsFrame:SetHeight(450);
	end
end

function GridClickSetsFrame_TypeUpdateAll()
	for i=1,8 do
		GridClickSetsFrame_TypeUpdate(i)
	end
	GridClickSetsFrame_Resize();
end

function GridClickSets_Type_OnClick(self)
	UIDropDownMenu_SetSelectedValue(self.owner, self.value);
	local id=self.owner:GetParent():GetID()
	GridClickSetsFrame_TypeUpdate(id)
	GridClickSetsFrame_Resize()
end

local function ddname(str)
	return " = "..str.." = ";
end

function GridClickSetButton_TypeDropDown_Initialize(self)
	local info;

	local _, c = UnitClass("player")
	local list = GridClickSets_SpellList[c];
	if(list) then
		for i=1, #list do
			info = {};
			info.text = SKILL.." - "..GetSpellInfo(list[i])
			info.owner = self;
			info.func = GridClickSets_Type_OnClick;
			info.value = "spellId:"..list[i]
			UIDropDownMenu_AddButton(info);
		end
	end

	info = {};
	info.text = ddname(TARGET);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "target"
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = ddname(BINDING_NAME_ASSISTTARGET);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "assist"
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ddname(SKILL..NAME);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "spell"
	UIDropDownMenu_AddButton(info);

--	info = {};
--	info.text = ddname(SOCIAL_LABEL);
--	info.owner = self;
--	info.func = GridClickSets_Type_OnClick;
--	info.value = "menu"
--	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = ddname(MACRO);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "macro"
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = NONE; --ddname(NONE);
	info.owner = self;
	info.func = GridClickSets_Type_OnClick;
	info.value = "NONE"
	UIDropDownMenu_AddButton(info);
end

function GridClickSetsFrame_GetSet(btn)
	if GridClickSets_Set then
		return GridClickSets_Set[tostring(btn)] or {};
	else
		return GridClickSets_GetBtnDefaultSet(btn);
	end
end

function GridClickSetsFrame_LoadSet(set)
	for i = 1, 8 do
		local dd = getglobal("GridClickSetButton"..i.."Type")
		local atts = set and set[GridClickSets_Modifiers[i]] or {}
		UIDropDownMenu_Initialize(dd, GridClickSetButton_TypeDropDown_Initialize);
		UIDropDownMenu_SetSelectedValue(dd, atts.type or "NONE")
		if(atts.arg) then
			getglobal("GridClickSetButton"..i.."Arg"):SetText(atts.arg)
		else
			getglobal("GridClickSetButton"..i.."Arg"):SetText("")
		end
	end

	GridClickSetsFrame_TypeUpdateAll();
end

function GridClickSetsFrame_TabOnClick()
	GridClickSetsFrame_LoadSet( GridClickSetsFrame_GetSet(GridClickSetsFrame.selectedTab) );
	if ( GridClickSetsFrame.selectedTab == 1 ) then
		UIDropDownMenu_SetSelectedValue(GridClickSetButton1Type, "target");
		UIDropDownMenu_DisableDropDown(GridClickSetButton1Type)
	else
		UIDropDownMenu_EnableDropDown(GridClickSetButton1Type)
	end
end

function GridClickSetsFrame_DefaultsOnClick()
	GridClickSetsFrame_LoadSet(GridClickSets_GetBtnDefaultSet(GridClickSetsFrame.selectedTab))
end

function GridClickSetsFrame_SaveOnClick()
	for i=1,8 do
		GridClickSets_Set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]] = {
			type = UIDropDownMenu_GetSelectedValue( getglobal("GridClickSetButton"..i.."Type") ),
			arg = getglobal("GridClickSetButton"..i.."Arg"):GetText()
		}

		if GridClickSets_Set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].arg == "" then
			GridClickSets_Set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].arg = nil
		end

		if GridClickSets_Set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]].type == "NONE" then
			GridClickSets_Set[tostring(GridClickSetsFrame.selectedTab)][GridClickSets_Modifiers[i]] = nil
		end
	end
end

function GridClickSetsFrame_CancelOnClick()
	GridClickSetsFrame_LoadSet( GridClickSetsFrame_GetSet(GridClickSetsFrame.selectedTab) );
end

function GridClickSetsFrame_ApplyOnClick()
	GridClickSetsFrame_SaveOnClick()
	GridClickSetsFrame_UpdateGridFrame()
	GridClickSetsFrame:Hide()
end

function GridClickSetsFrame_UpdateGridFrame()
	if(InCombatLockdown()) then
		queue = true
		DEFAULT_CHAT_FRAME:AddMessage(GRIDCLICKSETS_LOCKWARNING, 1, 0, 0)
	else
		GridFrame:WithAllFrames(function (f) GridClickSets_SetAttributes(f.frame, GridClickSets_Set) end)
		DEFAULT_CHAT_FRAME:AddMessage(GRIDCLICKSETS_SET, 1, 1, 0)
	end
end