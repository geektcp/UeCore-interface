
-- Localize it for non-English clients.
if GetLocale() == "zhCN" then
	MYFOCUSFRAME_TITLE = "焦点目标"
	MYFOCUSFRAME_DRAG = "按住鼠标左键拖动来移动框体，Alt+鼠标右键清除焦点"
	MYFOCUSFRAME_DRAG_LOCKED = "使用 /focusframe 解锁(移动)"
	MYFOCUSFRAME_HIDE_FRAME = "隐藏焦点"
elseif GetLocale() == "zhTW" then
	MYFOCUSFRAME_TITLE = "焦點目標"
	MYFOCUSFRAME_DRAG = "按住滑鼠左鍵拖動來移動框體，Alt+鼠標右鍵清除焦點"
	MYFOCUSFRAME_DRAG_LOCKED = "使用 /focusframe 解鎖(移動)"
	MYFOCUSFRAME_HIDE_FRAME = "隱藏焦點"
else
	MYFOCUSFRAME_TITLE = "Focus";
	MYFOCUSFRAME_DRAG = "Drag to move,Alt+Right mouse to hide frame";
	MYFOCUSFRAME_DRAG_LOCKED = "Use /focusframe unlock to move.";
	MYFOCUSFRAME_HIDE_FRAME = "Hide Focus"
end

-- Packages all local variables of MyFocusFrame Addon.
MyFocusFrameLocalVariables = {};
local l = MyFocusFrameLocalVariables;
local i,j,k;

l.MAX_FOCUS_DEBUFFS = 16;
l.MAX_FOCUS_BUFFS = 32;
l.CURRENT_FOCUS_NUM_DEBUFFS = 0;
l.TARGET_BUFFS_PER_ROW = 8;
l.TARGET_DEBUFFS_PER_ROW = 8;
l.LARGE_BUFF_SIZE = 21;
l.LARGE_BUFF_FRAME_SIZE = 23;
l.SMALL_BUFF_SIZE = 17;
l.SMALL_BUFF_FRAME_SIZE = 19;

l.FocusUnitReactionColor = {
	{ r = 1.0, g = 0.0, b = 0.0 },
	{ r = 1.0, g = 0.0, b = 0.0 },
	{ r = 1.0, g = 0.5, b = 0.0 },
	{ r = 1.0, g = 1.0, b = 0.0 },
	{ r = 0.0, g = 1.0, b = 0.0 },
	{ r = 0.0, g = 1.0, b = 0.0 },
	{ r = 0.0, g = 1.0, b = 0.0 },
	{ r = 0.0, g = 1.0, b = 0.0 },
};

l.largeBuffList = {};
l.largeDebuffList = {};

-- Saved variables
MyFocusFrameOptions = MyFocusFrameOptions or {};

local function MyFocusFrame_SlashCommand(msg)
  local cmd,var = strsplit(' ', msg or "")
  if cmd == "scale" and tonumber(var) then
    MyFocusFrame_SetScale(var);
  elseif cmd == "reset" then
    MyFocusFrame_Reset();
  elseif cmd == "lock" then
    MyFocusFrameOptions.lockpos = true;
  elseif cmd == "unlock" then
    MyFocusFrameOptions.lockpos = nil;
  --elseif cmd == "hidewhendead" then
  --  MyFocusFrame_HideWhenDead(true);
  else
    MyFocusFrame_Help();
  end
end
SlashCmdList["FOCUSFRAME"] = MyFocusFrame_SlashCommand;
SLASH_FOCUSFRAME1 = "/focusframe";

function MyFocusFrame_Help()
  DEFAULT_CHAT_FRAME:AddMessage('MyFocusFrame usage:');
  DEFAULT_CHAT_FRAME:AddMessage('/focusframe scale <num> : Set scale (e.g. /focusframe scale 0.7).');
  DEFAULT_CHAT_FRAME:AddMessage('/focusframe reset : Reset position.');
  DEFAULT_CHAT_FRAME:AddMessage('/focusframe lock : Lock position.');
  DEFAULT_CHAT_FRAME:AddMessage('/focusframe unlock : Unlock position.');
  DEFAULT_CHAT_FRAME:AddMessage('/focusframe hidewhendead : Hide when focused enemy target is dead. ['..((MyFocusFrameOptions.hidewhendead and 'ON') or 'OFF')..']');
end

function MyFocusFrame_SetScale(scale)
  if InCombatLockdown() then
    return;
  end

  scalenum = tonumber(scale);
  if scalenum and scalenum <= 10 then
    MyFocusFrameOptions.scale = scalenum;
    local os = MyFocusFrame:GetScale();
    local ox = MyFocusFrame:GetLeft();
    local oy = MyFocusFrame:GetTop();
    MyFocusFrame:SetScale(scale);
    MyFocusFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", ox*os/scale, oy*os/scale);
  else
    DEFAULT_CHAT_FRAME:AddMessage('Usage: /focusframe scale <num> : Set scale (e.g. /focusframe scale 0.7).');
  end
end

function MyFocusFrame_Reset()
    MyFocusFrame:SetPoint("TOPLEFT", UIParent, "CENTER", 0, 0);
end

function MyFocusFrame_HideWhenDead(toggle)
	--[[
	if MyFocusFrameOptions.hidewhendead == nil then
		-- Default is ON
		MyFocusFrameOptions.hidewhendead = true;
	end
	if toggle then
		if InCombatLockdown() then
			DEFAULT_CHAT_FRAME:AddMessage('MyFocusFrame: You cannot toggle hidewhendead while in combat.');
			return;
		end
		if MyFocusFrameOptions.hidewhendead then
			MyFocusFrameOptions.hidewhendead = false;
		    DEFAULT_CHAT_FRAME:AddMessage('MyFocusFrame: hidewhendead is now [OFF]. MyFocusFrame will be always shown.');
		else
			MyFocusFrameOptions.hidewhendead = true;
		    DEFAULT_CHAT_FRAME:AddMessage('MyFocusFrame: hidewhendead is now [ON]. MyFocusFrame will be hide when enemy target is dead.');
		end
	end
	if MyFocusFrameOptions.hidewhendead then
		RegisterStateDriver(MyFocusFrame, "visibility", "[target=focus,noexists][target=focus,harm,dead]hide;show");
	else
		RegisterStateDriver(MyFocusFrame, "visibility", "[target=focus,noexists]hide;show");
	end
	]]
end

function MyFocusFrame_OnLoad(self)
	self.statusCounter = 0;
	self.statusSign = -1;
	self.unitHPPercent = 1;

	self.buffStartX = 5;
	self.buffStartY = 32;
	self.buffSpacing = 3;

	self:RegisterEvent("ADDON_LOADED");

	local frameLevel = MyFocusFrameTextureFrame:GetFrameLevel();
	MyFocusFrameHealthBar:SetFrameLevel(frameLevel-1);
	MyFocusFrameManaBar:SetFrameLevel(frameLevel-1);
	MyFocusFrameSpellBar:SetFrameLevel(frameLevel-1);

    ClickCastFrames = ClickCastFrames or { };
    ClickCastFrames[self] = true;
end

function UnitFrame_DefaultUpdate(frame)
	frame.name:SetText(GetUnitName(frame.unit));
	SetPortraitTexture(frame.portrait, frame.unit);
	UnitFrameHealthBar_Update(frame.healthbar, frame.unit);
	UnitFrameManaBar_Update(frame.manabar, frame.unit);
end

function MyFocusFrame_Update(self)
	-- This check is here so the frame will hide when the focus goes away
	-- even if some of the functions below are hooked by addons.
	if ( UnitExists("focus") ) then
		MyTargetofFocus_Update(self);

		UnitFrame_DefaultUpdate(MyFocusFrame);
		MyFocusFrame_CheckLevel();
		MyFocusFrame_CheckFaction();
		MyFocusFrame_CheckClassification();
		MyFocusFrame_CheckDead();
		if ( UnitIsPartyLeader("focus") ) then
			MyFocusLeaderIcon:Show();
		else
			MyFocusLeaderIcon:Hide();
		end
		MyFocusDebuffButton_Update();
		MyFocusPortrait:SetAlpha(1.0);
	end
end

function MyFocusFrame_OnEvent(self, event, ...)
	UnitFrame_OnEvent(self, event, ...);

	local arg1 = ...;

	if ( event == "PLAYER_ENTERING_WORLD" ) then
		MyFocusFrame_Update(self);
	elseif ( event == "PLAYER_FOCUS_CHANGED" ) then
		MyFocusFrame_Update(self);
		MyFocusFrame_UpdateRaidTargetIcon();
		CloseDropDownMenus();
	elseif ( event == "UNIT_HEALTH" ) then
		if ( arg1 == "focus" ) then
			MyFocusFrame_CheckDead();
		end
	elseif ( event == "UNIT_LEVEL" ) then
		if ( arg1 == "focus" ) then
			MyFocusFrame_CheckLevel();
		end
	elseif ( event == "UNIT_FACTION" ) then
		if ( arg1 == "focus" or arg1 == "player" ) then
			MyFocusFrame_CheckFaction();
			MyFocusFrame_CheckLevel();
		end
	elseif ( event == "UNIT_CLASSIFICATION_CHANGED" ) then
		if ( arg1 == "focus" ) then
			MyFocusFrame_CheckClassification();
		end
	elseif ( event == "UNIT_AURA" ) then
		if ( arg1 == "focus" ) then
			MyFocusDebuffButton_Update();
		end
	elseif ( event == "PLAYER_FLAGS_CHANGED" ) then
		if ( arg1 == "focus" ) then
			if ( UnitIsPartyLeader("focus") ) then
				MyFocusLeaderIcon:Show();
			else
				MyFocusLeaderIcon:Hide();
			end
		end
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		MyTargetofFocus_Update();
		MyFocusFrame_CheckFaction();
	elseif ( event == "RAID_TARGET_UPDATE" ) then
		MyFocusFrame_UpdateRaidTargetIcon();
    elseif ( event == "ADDON_LOADED" ) then
        MyFocusFrameOptions.scale = MyFocusFrameOptions.scale or 1;
		MyFocusFrame_SetScale(MyFocusFrameOptions.scale);
		--MyFocusFrame_HideWhenDead(false);

		MyFocusFrame_Update(self);

		MyFocusFrame:Hide();
	end
end

function MyFocusFrame_OnHide(self)
	PlaySound("INTERFACESOUND_LOSTTARGETUNIT");
	CloseDropDownMenus();
end

function MyFocusFrame_CheckLevel()
	local targetLevel = UnitLevel("focus");
	
	if ( UnitIsCorpse("focus") ) then
		MyFocusLevelText:Hide();
		MyFocusHighLevelTexture:Show();
	elseif ( targetLevel > 0 ) then
		-- Normal level target
		MyFocusLevelText:SetText(targetLevel);
		-- Color level number
		if ( UnitCanAttack("player", "focus") ) then
			local color = GetQuestDifficultyColor(targetLevel);
			MyFocusLevelText:SetVertexColor(color.r, color.g, color.b);
		else
			MyFocusLevelText:SetVertexColor(1.0, 0.82, 0.0);
		end
		MyFocusLevelText:Show();
		MyFocusHighLevelTexture:Hide();
	else
		-- Focus is too high level to tell
		MyFocusLevelText:Hide();
		MyFocusHighLevelTexture:Show();
	end
end

function MyFocusFrame_CheckFaction()
	if ( UnitPlayerControlled("focus") ) then
		local r, g, b;
		if ( UnitCanAttack("focus", "player") ) then
			-- Hostile players are red
			if ( not UnitCanAttack("player", "focus") ) then
				r = 0.0;
				g = 0.0;
				b = 1.0;
			else
				r = l.FocusUnitReactionColor[2].r;
				g = l.FocusUnitReactionColor[2].g;
				b = l.FocusUnitReactionColor[2].b;
			end
		elseif ( UnitCanAttack("player", "focus") ) then
			-- Players we can attack but which are not hostile are yellow
			r = l.FocusUnitReactionColor[4].r;
			g = l.FocusUnitReactionColor[4].g;
			b = l.FocusUnitReactionColor[4].b;
		elseif ( UnitIsPVP("focus") and not UnitIsPVPSanctuary("focus") and not UnitIsPVPSanctuary("player") ) then
			-- Players we can assist but are PvP flagged are green
			r = l.FocusUnitReactionColor[6].r;
			g = l.FocusUnitReactionColor[6].g;
			b = l.FocusUnitReactionColor[6].b;
		else
			-- All other players are blue (the usual state on the "blue" server)
			r = 0.0;
			g = 0.0;
			b = 1.0;
		end
		MyFocusFrameNameBackground:SetVertexColor(r, g, b);
		MyFocusPortrait:SetVertexColor(1.0, 1.0, 1.0);
	elseif ( UnitIsTapped("focus") and not UnitIsTappedByPlayer("focus") ) then
		MyFocusFrameNameBackground:SetVertexColor(0.5, 0.5, 0.5);
		MyFocusPortrait:SetVertexColor(0.5, 0.5, 0.5);
	else
		local reaction = UnitReaction("focus", "player");
		if ( reaction ) then
			local r, g, b;
			r = l.FocusUnitReactionColor[reaction].r;
			g = l.FocusUnitReactionColor[reaction].g;
			b = l.FocusUnitReactionColor[reaction].b;
			MyFocusFrameNameBackground:SetVertexColor(r, g, b);
		else
			MyFocusFrameNameBackground:SetVertexColor(0, 0, 1.0);
		end
		MyFocusPortrait:SetVertexColor(1.0, 1.0, 1.0);
	end

	local factionGroup = UnitFactionGroup("focus");
	if ( UnitIsPVPFreeForAll("focus") ) then
		MyFocusPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		MyFocusPVPIcon:Show();
	elseif ( factionGroup and UnitIsPVP("focus") ) then
		MyFocusPVPIcon:SetTexture("Interface\\TargetingFrame\\UI-PVP-"..factionGroup);
		MyFocusPVPIcon:Show();
	else
		MyFocusPVPIcon:Hide();
	end
end

function MyFocusFrame_CheckClassification()
	local classification = UnitClassification("focus");
	if ( classification == "worldboss" ) then
		MyFocusFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif ( classification == "rareelite"  ) then
		MyFocusFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite");
	elseif ( classification == "elite"  ) then
		MyFocusFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
	elseif ( classification == "rare"  ) then
		MyFocusFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
	else
		MyFocusFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	end
end

function MyFocusFrame_CheckDead()
	if ( (MobHealthDB == nil) and (UnitHealth("focus") <= 0) and UnitIsConnected("focus") ) then
		MyFocusDeadText:Show();
	else
		MyFocusDeadText:Hide();
	end
end

function MyFocusFrame_OnUpdate(self, elapsed)
	if (MyFocusFrame_Enabled) then
		if ( MyTargetofFocusFrame:IsShown() ~= UnitExists("focus-target") ) then
			MyTargetofFocus_Update();
		end
	end
end

function MyFocusDebuffButton_Update()
	local button;
	local name, rank, icon, count, duration, timeLeft;
	local buffCount;
	local numBuffs = 0;
--	local largeBuffList = {};
	local playerIsFocus = UnitIsUnit("player", "focus");
	local cooldown, startCooldownTime;

	for i=1, l.MAX_FOCUS_BUFFS do
		name, rank, icon, count, debuffType, duration, timeLeft = UnitBuff("focus", i);
		button = getglobal("MyFocusFrameBuff"..i);
		if ( not button ) then
			if ( not icon ) then
				break;
			else
				button = CreateFrame("Button", "MyFocusFrameBuff"..i, MyFocusFrame, "MyFocusBuffButtonTemplate");
			end
		end
		
		if ( icon ) then
			getglobal("MyFocusFrameBuff"..i.."Icon"):SetTexture(icon);
			buffCount = getglobal("MyFocusFrameBuff"..i.."Count");
			button:Show();
			if ( count > 1 ) then
				buffCount:SetText(count);
				buffCount:Show();
			else
				buffCount:Hide();
			end
			
			-- Handle cooldowns
			cooldown = getglobal("MyFocusFrameBuff"..i.."Cooldown");
			if ( duration ) then
				if ( duration > 0 ) then
					cooldown:Show();
					CooldownFrame_SetTimer(cooldown, timeLeft - duration, duration, 1);
--					startCooldownTime = GetTime()-(duration-timeLeft);
--					CooldownFrame_SetTimer(cooldown, startCooldownTime, duration, 1);
				else
					cooldown:Hide();
				end
				
				-- Set the buff to be big if the buff is cast by the player and the focus is not the player
				if ( not playerIsFocus ) then
					l.largeBuffList[i] = 1;
				else
					l.largeBuffList[i] = nil;
				end
			else
				cooldown:Hide();
			end

			button.id = i;
			numBuffs = numBuffs + 1; 
			button:ClearAllPoints();
		else
			button:Hide();
		end
	end

	local debuffType, color;
	local debuffCount;
	local numDebuffs = 0;
--	local largeDebuffList = {};
	for i=1, l.MAX_FOCUS_DEBUFFS do
		local debuffBorder = getglobal("MyFocusFrameDebuff"..i.."Border");
		name, rank, icon, count, debuffType, duration, timeLeft = UnitDebuff("focus", i);
		button = getglobal("MyFocusFrameDebuff"..i);
		if ( not button ) then
			if ( not icon ) then
				break;
			else
				button = CreateFrame("Button", "MyFocusFrameDebuff"..i, MyFocusFrame, "MyFocusDebuffButtonTemplate");
				debuffBorder = getglobal("MyFocusFrameDebuff"..i.."Border");
			end
		end
		if ( icon ) then
			getglobal("MyFocusFrameDebuff"..i.."Icon"):SetTexture(icon);
			debuffCount = getglobal("MyFocusFrameDebuff"..i.."Count");
			if ( debuffType ) then
				color = DebuffTypeColor[debuffType];
			else
				color = DebuffTypeColor["none"];
			end
			if ( count > 1 ) then
				debuffCount:SetText(count);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end

			-- Handle cooldowns
			cooldown = getglobal("MyFocusFrameDebuff"..i.."Cooldown");
			if ( duration  ) then
				if ( duration > 0 ) then
					cooldown:Show();
					CooldownFrame_SetTimer(cooldown, timeLeft - duration, duration, 1);
				else
					cooldown:Hide();
				end
				-- Set the buff to be big if the buff is cast by the player
				l.largeDebuffList[i] = 1;
			else
				cooldown:Hide();
				l.largeDebuffList[i] = nil;
			end
			
			debuffBorder:SetVertexColor(color.r, color.g, color.b);
			button:Show();
			numDebuffs = numDebuffs + 1;
			button:ClearAllPoints();
		else
			button:Hide();
		end
		button.id = i;
	end
	
	-- Figure out general information that affects buff sizing and positioning
	local numFirstRowBuffs;
	local buffSize = l.LARGE_BUFF_SIZE;
	local buffFrameSize = l.LARGE_BUFF_FRAME_SIZE;
	if ( MyTargetofFocusFrame:IsShown() ) then
		numFirstRowBuffs = 5;
	else
		numFirstRowBuffs = 6;
	end
	if ( getn(l.largeBuffList) > 0 or getn(l.largeDebuffList) > 0 ) then
		numFirstRowBuffs = numFirstRowBuffs - 1;
	end
	-- Shrink the buffs if there are too many of them
	if ( (numBuffs >= numFirstRowBuffs) or (numDebuffs >= numFirstRowBuffs) ) then
		buffSize = l.SMALL_BUFF_SIZE;
		buffFrameSize = l.SMALL_BUFF_FRAME_SIZE;
	end
		
	-- Reset number of buff rows
	MyFocusFrame.buffRows = 0;
	-- Position buffs
	local size;
	local previousWasPlayerCast;
	local offset;
	for i=1, numBuffs do
		if ( l.largeBuffList[i] ) then
			size = l.LARGE_BUFF_SIZE;
			offset = 3;
			previousWasPlayerCast = 1;
		else
			size = buffSize;
			offset = 3;
			if ( previousWasPlayerCast ) then
				offset = 6;
				previousWasPlayerCast = nil;
			end
		end
		MyFocusFrame_UpdateBuffAnchor("MyFocusFrameBuff", i, numFirstRowBuffs, numDebuffs, size, offset, MyTargetofFocusFrame:IsShown());
	end
	-- Position debuffs
	previousWasPlayerCast = nil;
	for i=1, numDebuffs do
		if ( l.largeDebuffList[i] ) then
			size = l.LARGE_BUFF_SIZE;
			offset = 4;
			previousWasPlayerCast = 1;
		else
			size = buffSize;
			offset = 4;
			if ( previousWasPlayerCast ) then
				offset = 6;
				previousWasPlayerCast = nil;
			end
		end
		MyFocusFrame_UpdateDebuffAnchor("MyFocusFrameDebuff", i, numFirstRowBuffs, numBuffs, size, offset, MyTargetofFocusFrame:IsShown());
 	end

	-- update the spell bar position
	MyFocus_Spellbar_AdjustPosition();
end

function MyFocusFrame_UpdateBuffAnchor(buffName, index, numFirstRowBuffs, numDebuffs, buffSize, offset, hasTargetofFocus)
	local buff = getglobal(buffName..index);
	
	if ( index == 1 ) then
		if ( UnitIsFriend("player", "focus") ) then
			buff:SetPoint("TOPLEFT", MyFocusFrame, "BOTTOMLEFT", MyFocusFrame.buffStartX, MyFocusFrame.buffStartY);
		else
			if ( numDebuffs > 0 ) then
				buff:SetPoint("TOPLEFT", MyFocusFrameDebuffs, "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
			else
				buff:SetPoint("TOPLEFT", MyFocusFrame, "BOTTOMLEFT", MyFocusFrame.buffStartX, MyFocusFrame.buffStartY);
			end
		end
		MyFocusFrameBuffs:SetPoint("TOPLEFT", buff, "TOPLEFT", 0, 0);
		MyFocusFrameBuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( index == (numFirstRowBuffs+1) ) then
		buff:SetPoint("TOPLEFT", getglobal(buffName..1), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameBuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( hasTargetofFocus and index == (2*numFirstRowBuffs+1) ) then
		buff:SetPoint("TOPLEFT", getglobal(buffName..(numFirstRowBuffs+1)), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameBuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( (index > numFirstRowBuffs) and (mod(index+(l.TARGET_BUFFS_PER_ROW-numFirstRowBuffs), l.TARGET_BUFFS_PER_ROW) == 1) and not hasTargetofFocus ) then
		-- Make a new row, have to take the number of buffs in the first row into account
		buff:SetPoint("TOPLEFT", getglobal(buffName..(index-l.TARGET_BUFFS_PER_ROW)), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameBuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	else
		-- Just anchor to previous
		buff:SetPoint("TOPLEFT", getglobal(buffName..(index-1)), "TOPRIGHT", offset, 0);
	end

	-- Resize
	buff:SetWidth(buffSize);
	buff:SetHeight(buffSize);
end

function MyFocusFrame_UpdateDebuffAnchor(buffName, index, numFirstRowBuffs, numBuffs, buffSize, offset, hasTargetofFocus)
	local buff = getglobal(buffName..index);

	if ( index == 1 ) then
		if ( UnitIsFriend("player", "focus") and (numBuffs > 0) ) then
			buff:SetPoint("TOPLEFT", MyFocusFrameBuffs, "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		else
			buff:SetPoint("TOPLEFT", MyFocusFrame, "BOTTOMLEFT", MyFocusFrame.buffStartX, MyFocusFrame.buffStartY);
		end
		MyFocusFrameDebuffs:SetPoint("TOPLEFT", buff, "TOPLEFT", 0, 0);
		MyFocusFrameDebuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( index == (numFirstRowBuffs+1) ) then
		buff:SetPoint("TOPLEFT", getglobal(buffName..1), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameDebuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( hasTargetofFocus and index == (2*numFirstRowBuffs+1) ) then
		buff:SetPoint("TOPLEFT", getglobal(buffName..(numFirstRowBuffs+1)), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameDebuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	elseif ( (index > numFirstRowBuffs) and (mod(index+(l.TARGET_DEBUFFS_PER_ROW-numFirstRowBuffs), l.TARGET_DEBUFFS_PER_ROW) == 1) and not hasTargetofFocus ) then
		-- Make a new row
		buff:SetPoint("TOPLEFT", getglobal(buffName..(index-l.TARGET_DEBUFFS_PER_ROW)), "BOTTOMLEFT", 0, -MyFocusFrame.buffSpacing);
		MyFocusFrameDebuffs:SetPoint("BOTTOMLEFT", buff, "BOTTOMLEFT", 0, 0);
		MyFocusFrame.buffRows = MyFocusFrame.buffRows+1;
	else
		-- Just anchor to previous
		buff:SetPoint("TOPLEFT", getglobal(buffName..(index-1)), "TOPRIGHT", offset, 0);
	end
	
	-- Resize
	buff:SetWidth(buffSize);
	buff:SetHeight(buffSize);
	local debuffFrame = getglobal(buffName..index.."Border");
	debuffFrame:SetWidth(buffSize+2);
	debuffFrame:SetHeight(buffSize+2);
end

function MyFocusFrame_HealthUpdate(self, elapsed, unit)
	if ( UnitIsPlayer(unit) ) then
		if ( (self.unitHPPercent > 0) and (self.unitHPPercent <= 0.2) ) then
			local alpha = 255;
			local counter = self.statusCounter + elapsed;
			local sign    = self.statusSign;
	
			if ( counter > 0.5 ) then
				sign = -sign;
				self.statusSign = sign;
			end
			counter = mod(counter, 0.5);
			self.statusCounter = counter;
	
			if ( sign == 1 ) then
				alpha = (127  + (counter * 256)) / 255;
			else
				alpha = (255 - (counter * 256)) / 255;
			end
			MyFocusPortrait:SetAlpha(alpha);
		end
	end
end

function FocusHealthCheck(self)
	if ( UnitIsPlayer("focus") ) then
		local unitHPMin, unitHPMax, unitCurrHP;
		unitHPMin, unitHPMax = self:GetMinMaxValues();
		unitCurrHP = self:GetValue();
		self:GetParent().unitHPPercent = unitCurrHP / unitHPMax;
		if ( UnitIsDead("focus") ) then
			MyFocusPortrait:SetVertexColor(0.35, 0.35, 0.35, 1.0);
		elseif ( UnitIsGhost("focus") ) then
			MyFocusPortrait:SetVertexColor(0.2, 0.2, 0.75, 1.0);
		elseif ( (self:GetParent().unitHPPercent > 0) and (self:GetParent().unitHPPercent <= 0.2) ) then
			MyFocusPortrait:SetVertexColor(1.0, 0.0, 0.0);
		else
			MyFocusPortrait:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
	end
end

function MyFocusFrameDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, MyFocusFrameDropDown_Initialize, "MENU");

end

function MyFocusFrameDropDown_Initialize(self)
	local menu;
	local name;
	local id = nil;
	if ( UnitIsUnit("focus", "player") ) then
		menu = "SELF";
	elseif ( UnitIsUnit("focus", "pet") ) then
		menu = "PET";
	elseif ( UnitIsPlayer("focus") ) then
		id = UnitInRaid("focus");
		if ( id ) then
			menu = "RAID_PLAYER";
		elseif ( UnitInParty("focus") ) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "RAID_TARGET_ICON";
		name = RAID_TARGET_ICON;
	end
	if ( menu ) then
		UnitPopup_ShowMenu(MyFocusFrameDropDown, menu, "focus", name, id);
	end

end



-- Raid target icon function
function MyFocusFrame_UpdateRaidTargetIcon()
	local index = GetRaidTargetIndex("focus");
	if ( index ) then
		SetRaidTargetIconTexture(MyFocusRaidTargetIcon, index);
		MyFocusRaidTargetIcon:Show();
	else
		MyFocusRaidTargetIcon:Hide();
	end
end


function MyTargetofFocus_OnLoad(self)
	UnitFrame_Initialize(self, "focus-target", MyTargetofFocusName, MyTargetofFocusPortrait, MyTargetofFocusHealthBar, TargetofFocusHealthBarText, MyTargetofFocusManaBar, TargetofMyFocusFrameManaBarText);
	SetTextStatusBarTextZeroText(MyTargetofFocusHealthBar, TEXT(DEAD));

    ClickCastFrames = ClickCastFrames or { };
    ClickCastFrames[self] = true;
end

function MyTargetofFocus_OnHide(self)
	MyFocusDebuffButton_Update(self);
end

function MyTargetofFocus_Update(self)
	if ( MyTargetofFocusFrame:IsShown() ) then
		UnitFrame_DefaultUpdate(MyTargetofFocusFrame);
		TargetofFocus_CheckDead(self);
		TargetofFocusHealthCheck(self);
		RefreshBuffs(MyTargetofFocusFrame,"focus-target",0);
	end
end

function TargetofFocus_CheckDead(self)
	if ( (UnitHealth("focus-target") <= 0) and UnitIsConnected("focus-target") ) then
		MyTargetofFocusBackground:SetAlpha(0.9);
		MyTargetofFocusDeadText:Show();
	else
		MyTargetofFocusBackground:SetAlpha(1);
		MyTargetofFocusDeadText:Hide();
	end
end

function TargetofFocusHealthCheck(self)
	if ( UnitIsPlayer("focus-target") ) then
		local unitHPMin, unitHPMax, unitCurrHP;
		unitHPMin, unitHPMax = MyTargetofFocusHealthBar:GetMinMaxValues();
		unitCurrHP = MyTargetofFocusHealthBar:GetValue();
		MyTargetofFocusFrame.unitHPPercent = unitCurrHP / unitHPMax;
		if ( UnitIsDead("focus-target") ) then
			MyTargetofFocusPortrait:SetVertexColor(0.35, 0.35, 0.35, 1.0);
		elseif ( UnitIsGhost("focus-target") ) then
			MyTargetofFocusPortrait:SetVertexColor(0.2, 0.2, 0.75, 1.0);
		elseif ( (MyTargetofFocusFrame.unitHPPercent > 0) and (MyTargetofFocusFrame.unitHPPercent <= 0.2) ) then
			MyTargetofFocusPortrait:SetVertexColor(1.0, 0.0, 0.0);
		else
			MyTargetofFocusPortrait:SetVertexColor(1.0, 1.0, 1.0, 1.0);
		end
	end
end


function MyFocusFrame_SetFocusSpellbarAspect()
	local frameText = getglobal(MyFocusFrameSpellBar:GetName().."Text");
	if ( frameText ) then
		frameText:SetFontObject(SystemFont_Shadow_Small);
		frameText:ClearAllPoints();
		frameText:SetPoint("TOP", MyFocusFrameSpellBar, "TOP", 0, 4);
	end

	local frameBorder = getglobal(MyFocusFrameSpellBar:GetName().."Border");
	if ( frameBorder ) then
		frameBorder:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small");
		frameBorder:SetWidth(197);
		frameBorder:SetHeight(49);
		frameBorder:ClearAllPoints();
		frameBorder:SetPoint("TOP", MyFocusFrameSpellBar, "TOP", 0, 20);
	end

	local frameFlash = getglobal(MyFocusFrameSpellBar:GetName().."Flash");
	if ( frameFlash ) then
		frameFlash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small");
		frameFlash:SetWidth(197);
		frameFlash:SetHeight(49);
		frameFlash:ClearAllPoints();
		frameFlash:SetPoint("TOP", MyFocusFrameSpellBar, "TOP", 0, 20);
	end
end

function MyFocus_Spellbar_OnLoad(self)
	CastingBarFrame_OnLoad(self, "focus", false);

	local barIcon = getglobal(self:GetName().."Icon");
	barIcon:Show();

	-- check to see if the castbar should be shown
	if (GetCVar("ShowTargetCastbar") == "0") then
		self.showCastbar = false;
	end
	MyFocusFrame_SetFocusSpellbarAspect();
end

function MyFocus_Spellbar_OnEvent(self, event, ...)
	local arg1 = ...
	
	--	Check for target specific events
	if ( (event == "VARIABLES_LOADED") or ((event == "CVAR_UPDATE") and (arg1 == "SHOW_TARGET_CASTBAR")) ) then
		if ( GetCVar("showTargetCastbar") == "0") then
			self.showCastbar = false;
		else
			self.showCastbar = true;
		end
		
		if ( not self.showCastbar ) then
			self:Hide();
		elseif ( self.casting or self.channeling ) then
			self:Show();
		end
		return;
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		-- check if the new target is casting a spell
		local nameChannel  = UnitChannelInfo(self.unit);
		local nameSpell  = UnitCastingInfo(self.unit);
		if ( nameChannel ) then
			event = "UNIT_SPELLCAST_CHANNEL_START";
			arg1 = "target";
		elseif ( nameSpell ) then
			event = "UNIT_SPELLCAST_START";
			arg1 = "target";
		else
			self.casting = nil;
			self.channeling = nil;
			self:SetMinMaxValues(0, 0);
			self:SetValue(0);
			self:Hide();
			return;
		end
		-- The position depends on the classification of the target
		Target_Spellbar_AdjustPosition();
	end
	CastingBarFrame_OnEvent(self, event, arg1, select(2, ...));
end

function MyFocus_Spellbar_AdjustPosition()
	local yPos = 5;
	if ( MyFocusFrame.buffRows and MyFocusFrame.buffRows <= 2 ) then
		yPos = 38;
	elseif ( MyFocusFrame.buffRows ) then
		yPos = 19 * MyFocusFrame.buffRows;
	end
	if ( MyTargetofFocusFrame:IsShown() ) then
		if ( yPos <= 25 ) then
			yPos = yPos + 25;
		end
	else
		yPos = yPos - 5;
		local classification = UnitClassification("focus");
		if ( (yPos < 17) and ((classification == "worldboss") or (classification == "rareelite") or (classification == "elite") or (classification == "rare")) ) then
			yPos = 17;
		end
	end
	MyFocusFrameSpellBar:SetPoint("BOTTOM", "MyFocusFrame", "BOTTOM", -15, -yPos);
end

function MyFocusFrameHealthBarText_UpdateTextString(self, textStatusBar)
	if ( not textStatusBar ) then
		textStatusBar = self;
	end
	local string = MyFocusFrameHealthBarText;
		local value = textStatusBar:GetValue();
		local valueMin, valueMax = textStatusBar:GetMinMaxValues();
		if ( valueMax > 0 ) then
			if (MobHealthDB) then
				-- No longer use default health bar text functions.
				MyFocusFrameHealthBar.TextString = nil;

				if (not UnitIsPlayer("focus") and not UnitIsUnit("focus", "pet")) then
					local focusName,focusLevel = UnitName("focus"),UnitLevel("focus");
					if (focusName == nil or focusLevel == nil) then
						return;
					end
				
					local curHP = UnitHealth("focus");
					local maxHP = UnitHealthMax("focus");				
					  string:SetText(curHP.." / "..maxHP);
				
				else
					string:SetText(value.." / "..valueMax);
				end
				string:Show();
			end
		end
end

function MyFocusFrameHealthBar_OnValueChanged(self, value)
	MyFocusFrameHealthBarText_UpdateTextString(self);
	HealthBar_OnValueChanged(value);
end

function MyFocusFrame_OnDragStart(self)
	if (not MyFocusFrameOptions.lockpos) then
		self:GetParent():StartMoving();
		self.isMoving = true;
	end
end

function MyFocusFrame_OnDragStop(self)
	 self:GetParent():StopMovingOrSizing();
	 self.isMoving = false;
end

function MyFocusFrame_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	if (not MyFocusFrameOptions.lockpos) then
		GameTooltip:SetText(MYFOCUSFRAME_DRAG, nil, nil, nil, nil, 1);
	else
		GameTooltip:SetText(MYFOCUSFRAME_DRAG_LOCKED, nil, nil, nil, nil, 1);
	end
end

function MyFocusFrame_Toggle(switch)
	if (switch) then
		local showmenu = function()
			ToggleDropDownMenu(1, nil, MyFocusFrameDropDown, "MyFocusFrame", 120, 10);
		end

		MyFocusFrame:SetAttribute("*type1", "target");
		MyFocusFrame:SetAttribute("*type2", "menu");
		MyFocusFrame:SetAttribute("alt-type2", "macro");
		MyFocusFrame:SetAttribute("macrotext", "/clearfocus");
		MyFocusFrame:SetAttribute("unit", "focus");
		MyFocusFrame.menu = showmenu;

		MyFocusFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
		MyFocusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
		MyFocusFrame:RegisterEvent("UNIT_HEALTH");
		MyFocusFrame:RegisterEvent("UNIT_LEVEL");
		MyFocusFrame:RegisterEvent("UNIT_FACTION");
		MyFocusFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
		MyFocusFrame:RegisterEvent("UNIT_AURA");
		MyFocusFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		MyFocusFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
		MyFocusFrame:RegisterEvent("RAID_TARGET_UPDATE");
		RegisterUnitWatch(MyFocusFrame);
		--if MyFocusFrameOptions.hidewhendead then
		--	RegisterStateDriver(MyFocusFrame, "visibility", "[target=focus,noexists][target=focus,harm,dead]hide;show");
		--else
		--	RegisterStateDriver(MyFocusFrame, "visibility", "[target=focus,noexists]hide;show");
		--end
		MyFocusFrame_Update(self);

		MyTargetofFocusFrame:SetAttribute("*type1", "target");
		MyTargetofFocusFrame:SetAttribute("unit", "focus-target");
		MyTargetofFocusFrame:RegisterEvent("UNIT_AURA");
		RegisterUnitWatch(MyTargetofFocusFrame);

		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_START");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_STOP");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_FAILED");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_DELAYED");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		MyFocusFrameSpellBar:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
		MyFocusFrameSpellBar:RegisterEvent("PLAYER_ENTERING_WORLD");
		MyFocusFrameSpellBar:RegisterEvent("PLAYER_FOCUS_CHANGED");
		MyFocusFrameSpellBar:RegisterEvent("CVAR_UPDATE");

		MyFocusFrame_Enabled = true;
	else
		MyFocusFrame:SetAttribute("*type1", nil);
		MyFocusFrame:SetAttribute("*type2", nil);
		MyFocusFrame:SetAttribute("unit", nil);
		MyFocusFrame.menu = nil;

		MyFocusFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
		MyFocusFrame:UnregisterEvent("PLAYER_FOCUS_CHANGED");
		MyFocusFrame:UnregisterEvent("UNIT_HEALTH");
		MyFocusFrame:UnregisterEvent("UNIT_LEVEL");
		MyFocusFrame:UnregisterEvent("UNIT_FACTION");
		MyFocusFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED");
		MyFocusFrame:UnregisterEvent("UNIT_AURA");
		MyFocusFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED");
		MyFocusFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
		MyFocusFrame:UnregisterEvent("RAID_TARGET_UPDATE");

		MyTargetofFocusFrame:SetAttribute("*type1", nil);
		MyTargetofFocusFrame:UnregisterEvent("UNIT_AURA");
		
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_START");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_STOP");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_FAILED");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_DELAYED");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
		MyFocusFrameSpellBar:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
		MyFocusFrameSpellBar:UnregisterEvent("PLAYER_ENTERING_WORLD");
		MyFocusFrameSpellBar:UnregisterEvent("PLAYER_FOCUS_CHANGED");
		MyFocusFrameSpellBar:UnregisterEvent("CVAR_UPDATE");

		UnregisterUnitWatch(MyTargetofFocusFrame);  
		UnregisterUnitWatch(MyFocusFrame);

		UnregisterStateDriver(MyFocusFrame);

		MyFocusFrame:Hide();

		MyFocusFrame_Enabled = false;
	end
end
