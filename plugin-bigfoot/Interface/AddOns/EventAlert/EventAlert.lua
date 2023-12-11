EA_Config = { DoAlertSound, AlertSound, AlertSoundValue, LockFrame, ShowFrame, ShowName, ShowFlash, ShowTimer, TimerFontSize, StackFontSize, SNameFontSize, ChangeTimer, Version, AllowESC, AllowAltAlerts, Target_MyDebuff };
EA_Position = { Anchor, relativePoint, xLoc, yLoc, xOffset, yOffset, RedDebuff, GreenDebuff, Tar_xOffset, Tar_yOffset };

EA_SPELLINFO_SELF = { };
EA_SPELLINFO_TARGET = { };

local EA_DEBUGFLAG1 = false;
local EA_DEBUGFLAG2 = false;
local EA_DEBUGFLAG3 = false;
local EA_DEBUGFLAG4 = false;
local EA_LISTSEC_SELF = 0;
local EA_LISTSEC_TARGET = 0;

local EA_CurrentBuffs = { };
local EA_TarCurrentBuffs = { };
local EA_PreLoadAlts = { };
local EA_PreLoadComplete = 0;

local EA_SpellName_48517 = "";
local EA_SpellIcon_48517 = "";

local EA_SacredShield;
local EA_SpellID_DB = { };
local ischange;

-- The first event of this UI
function EventAlert_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");

	SlashCmdList["EVENTALERT"] = EventAlert_SlashHandler;
	SLASH_EVENTALERT1 = "/eventalert";
	SLASH_EVENTALERT2 = "/ea";

	EA_SPELLINFO_SELF = { };
	EA_SPELLINFO_TARGET = { };

	EA_CurrentBuffs = { };
	EA_TarCurrentBuffs = { };
	EA_PreLoadAlts = { };
	EA_PreLoadComplete = 0;
end

-- The procedures of events
function EventAlert_OnEvent(event)
	if (event == "ADDON_LOADED") then
		if (arg1 == "EventAlert") then

			--EventAlert_VersionCheck();
			if EA_Config.AlertSound == nil then EA_Config.AlertSound = "Sound\\Spells\\ShaysBell.wav" end
			if EA_Config.AlertSoundValue == nil then EA_Config.AlertSoundValue = 1 end
			if EA_Config.DoAlertSound == nil then EA_Config.DoAlertSound = false end
			if EA_Config.LockFrame == nil then EA_Config.LockFrame = true end
			if EA_Config.ShowFrame == nil then EA_Config.ShowFrame = true end
			if EA_Config.ShowName == nil then EA_Config.ShowName = true end
			if EA_Config.ShowFlash == nil then EA_Config.ShowFlash = false end
			if EA_Config.ShowTimer == nil then EA_Config.ShowTimer = true end
			if EA_Config.IconSize == nil then EA_Config.IconSize = 60 end
			if EA_Config.TimerFontSize == nil then EA_Config.TimerFontSize = 28 end
			if EA_Config.StackFontSize == nil then EA_Config.StackFontSize = 18 end
			if EA_Config.SNameFontSize == nil then EA_Config.SNameFontSize = 14 end
			if EA_Config.ChangeTimer == nil then EA_Config.ChangeTimer = false end
			if EA_Config.AllowESC == nil then EA_Config.AllowESC = false end
			if EA_Config.AllowAltAlerts == nil then EA_Config.AllowAltAlerts = true end
			if EA_Config.Target_MyDebuff == nil then EA_Config.Target_MyDebuff = false end

			if EA_Position.Anchor == nil then EA_Position.Anchor = "CENTER" end
			if EA_Position.relativePoint == nil then EA_Position.relativePoint = "CENTER" end
			if EA_Position.xLoc == nil then EA_Position.xLoc = 136 end
			if EA_Position.yLoc == nil then EA_Position.yLoc = 46 end
			if EA_Position.xOffset == nil then EA_Position.xOffset = 0 end
			if EA_Position.yOffset == nil then EA_Position.yOffset = 0 end
			if EA_Position.RedDebuff == nil then EA_Position.RedDebuff = 0 end
			if EA_Position.GreenDebuff == nil then EA_Position.GreenDebuff = 0 end
			if EA_Position.TarAnchor == nil then EA_Position.TarAnchor = "CENTER" end
			if EA_Position.TarrelativePoint == nil then EA_Position.TarrelativePoint = "CENTER" end
			if EA_Position.Tar_xOffset == nil then EA_Position.Tar_xOffset = 0 end
			if EA_Position.Tar_yOffset == nil then EA_Position.Tar_yOffset = -80 end

			if EA_SacredShield == nil then EA_SacredShield = "noPlayerActive" end

			_, EA_playerClass = UnitClass("player");

			EventAlert_LoadSpellArray();
			EventAlert_Options_Init();
			EventAlert_Class_Events_Frame_Init();
			EventAlert_Alert_Events_Frame_Init();
			EventAlert_Icon_Options_Frame_Init();
			EventAlert_Other_Events_Frame_Init();
			EventAlert_Target_Events_Frame_Init();
			EventAlert_CreateFrames();

			-- 48517 and 48518 use the same spellname and rank, only the icon is different
			EA_SpellName_48517, _, EA_SpellIcon_48517 = GetSpellInfo(48517);
		end
	end

	if (event == "PLAYER_TARGET_CHANGED") then
		EventAlert_TarChange_ClearFrame();
		if UnitName("player") ~= UnitName("target") then
			EventAlert_TarBuffs_Update();
		end
	end

	if (event == "UNIT_AURA") then
		EventAlert_Unit_Aura(arg1);
	end

	if (event == "PLAYER_DEAD" or event == "PLAYER_ENTERING_WORLD") then
		local v = table.foreach(EA_CurrentBuffs, function(i, v) if v==arg9 then return v end end)
		if v then
			local f = _G["EAFrame_"..v];
			f:Hide();
			EA_CurrentBuffs = table.wipe(EA_CurrentBuffs);
		end
		EA_SacredShield = "noPlayerActive";

		-- I'm annoyed that this code has to be here and not above in the ADDON_LOADED event. >-(
		if (EA_PreLoadComplete == 0) then
			for i,v in pairs(EA_AltItems[EA_playerClass]) do
				local name, rank = GetSpellInfo(i);
				local EA_link = GetSpellLink(name, "");

				if (EA_link ~= nil) then
					local _, _, spellString = string.find(EA_link, "^|c%x+|Hspell:(.+)|h%[.*%]")
					if (EA_PreLoadAlts[name] == nil) then
						EA_PreLoadAlts[name] = spellString;
					elseif (EA_PreLoadAlts[name] < spellString) then
						EA_PreLoadAlts[name] = spellString;
					elseif (EA_PreLoadAlts[name] >= spellString) then
						-- Do Nothing
					end
				end
			end
			EA_PreLoadComplete = 1;
		end
	end

	if (event == "COMBAT_TEXT_UPDATE" and arg1 == "SPELL_ACTIVE") then
		EventAlert_COMBAT_TEXT_SPELL_ACTIVE(arg2);
	end

end

function EventAlert_Unit_Aura(unit)
	--普通的对自己的处理
	if unit == "player" then
		EventAlert_Buffs_Update(unit);
	end
	---对敌方目标的处理
	if unit == "target" and not UnitIsFriend("player", unit)then
		EventAlert_TarBuffs_Update();
	end
	--检测 "圣洁护盾" 释放对象的处理
	if EA_playerClass == EA_CLASS_PALADIN and UnitIsFriend("player", unit) then
		Pal_CheckUnitSSCaster(unit)
	end
	--对 "圣洁护盾" 触发法术的处理
	if EA_playerClass == EA_CLASS_PALADIN and EA_SacredShield == UnitGUID(unit) then
		PALADIN_SSTrigger(unit);
	end
end

function EventAlert_Buffs_Update(unit)
	local buffsCurrent = {};
	local buffsToDelete = {};
	local ifAdd_buffCur = false;
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
	-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buffs_Update");
	if (EA_DEBUGFLAG1 and unit =="player") then
		DEFAULT_CHAT_FRAME:AddMessage("----"..EA_XCMD_SELFLIST.."----");
	end

	if (EA_DEBUGFLAG3 or EA_DEBUGFLAG4) then
		EventAlert_Class_Events_Frame_ClearPrimarySpellList();
	end

	for i=1,40 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitBuff("player", i);
		if (name == EA_SpellName_48517) then
			if (icon == EA_SpellIcon_48517) then
				spellId = 48517;
			else
				spellId = 48518;
			end
		end

		if (name and spellId) then
			if (EA_DEBUGFLAG1) then
				if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
					DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				end
			end

			ifAdd_buffCur = false;
			if (EA_Items[EA_playerClass][spellId] or EA_Items[EA_CLASS_OTHER][spellId]) then
				ifAdd_buffCur = true;
				if (spellId == 53817) and (count <= 4) then		--漩涡武器
					ifAdd_buffCur = false;
				end
				if (EA_Items["FUNKY"][spellId]) and (count < 3) then		--好运
					ifAdd_buffCur = false;
				end
			elseif ((EA_Items[EA_playerClass][spellId] == false) or (EA_Items[EA_CLASS_OTHER][spellId] == false)) then
				ifAdd_buffCur = false;
			elseif (EA_DEBUGFLAG3 or EA_DEBUGFLAG4) then
				if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
					-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." /unitCaster="..unitCaster);
					if EA_DEBUGFLAG3 or (EA_DEBUGFLAG4 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
						if EA_Items[EA_playerClass][spellId] == nil then EA_Items[EA_playerClass][spellId] = true end
						CreateFrames_CreateSpellFrame(spellId, false);
						ifAdd_buffCur = true;
					end
				end
			end

			if (ifAdd_buffCur) then
				EA_SPELLINFO_SELF[spellId].count = count;
				EA_SPELLINFO_SELF[spellId].duration = duration;
				EA_SPELLINFO_SELF[spellId].expirationTime = expirationTime;
				EA_SPELLINFO_SELF[spellId].unitCaster = unitCaster;
				if (spellId ~= 48517 and spellId ~= 48518) then
					EA_SPELLINFO_SELF[spellId].icon = icon;
				end
				EA_SPELLINFO_SELF[spellId].isDebuff = false;
				table.insert(buffsCurrent, spellId);
			end
		end
	end

	for i=41,80 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff("player", i-40)

		if name and spellId then
			if (EA_DEBUGFLAG1) then
				if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
					DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
						" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				end
			end

			ifAdd_buffCur = false;
			if (EA_Items[EA_playerClass][spellId] or EA_Items[EA_CLASS_OTHER][spellId]) then
				ifAdd_buffCur = true;
			elseif ((EA_Items[EA_playerClass][spellId] == false) or (EA_Items[EA_CLASS_OTHER][spellId] == false)) then
				ifAdd_buffCur = false;
			elseif (EA_DEBUGFLAG3 or EA_DEBUGFLAG4) then
				if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
					-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." /unitCaster="..unitCaster);
					if EA_DEBUGFLAG3 or (EA_DEBUGFLAG4 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
						if EA_Items[EA_playerClass][spellId] == nil then EA_Items[EA_playerClass][spellId] = true end
						CreateFrames_CreateSpellFrame(spellId, false);
						ifAdd_buffCur = true;
					end
				end
			end

			if (ifAdd_buffCur) then
				EA_SPELLINFO_SELF[spellId].count = count;
				EA_SPELLINFO_SELF[spellId].duration = duration;
				EA_SPELLINFO_SELF[spellId].expirationTime = expirationTime;
				EA_SPELLINFO_SELF[spellId].unitCaster = unitCaster;
				EA_SPELLINFO_SELF[spellId].icon = icon;
				EA_SPELLINFO_SELF[spellId].isDebuff = true;
				table.insert(buffsCurrent, spellId);
			end
		end
	end

	-- Check: Buff dropped
	local v1 = table.foreach(EA_CurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			if(not EA_AltItems[EA_playerClass][v1]) then
				local v2 = table.foreach(buffsCurrent,
					function(k, v2)
						if (v1==v2) then
							return v2;
						end
					end
				)
				if(not v2) then
					-- Buff dropped
					if v1 ~= 58597 then
						table.insert(buffsToDelete, v1);
					end
				end
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_Buff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_CurrentBuffs,
				function(k, v2)
					if (v1==v2) then
					return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				EventAlert_Buff_Applied(v1);
			end
		end
	)
	EventAlert_PositionFrames();

	if (EA_DEBUGFLAG3 or EA_DEBUGFLAG4) then
		CreateFrames_RefreshPrimarySpellList();
	end
end

function EventAlert_TarBuffs_Update()
	local buffsCurrent = {};
	local buffsToDelete = {};
	local ComfirmToShow = false;
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId;
	-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buffs_Update");
	if (EA_DEBUGFLAG2) then
		DEFAULT_CHAT_FRAME:AddMessage("--------"..EA_XCMD_TARGETLIST.."--------");
	end

	for i=1,40 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff("target", i)
		ComfirmToShow = false;

		if EA_Config.Target_MyDebuff then
			if unitCaster == "player" then
				ComfirmToShow = true;
			end
		else
			ComfirmToShow = true;
		end

		if name and spellId then
			if (EA_DEBUGFLAG2) then
				if ComfirmToShow then
					if (EA_LISTSEC_TARGET == 0 or (0 < duration and duration <= EA_LISTSEC_TARGET)) then
						DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
							" /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
							" /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
							" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
					end
				end
			end

			if (EA_TarItems[EA_playerClass][spellId]) then
				if ComfirmToShow then
					EA_SPELLINFO_TARGET[spellId].count = count;
					EA_SPELLINFO_TARGET[spellId].duration = duration;
					EA_SPELLINFO_TARGET[spellId].expirationTime = expirationTime;
					EA_SPELLINFO_TARGET[spellId].unitCaster = unitCaster;
					EA_SPELLINFO_TARGET[spellId].isDebuff = true;
					table.insert(buffsCurrent, spellId);
				end
			end
		end
	end

	-- Check: Buff dropped
	local v1 = table.foreach(EA_TarCurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			-- DEFAULT_CHAT_FRAME:AddMessage("===============\n=== buff-check: "..i.." /v1 id: "..v1);
			local v2 = table.foreach(buffsCurrent,
				function(k, v2)
					-- DEFAULT_CHAT_FRAME:AddMessage("=== buff-check: "..i.." /v2 id: "..v1);
					if (v1==v2) then
						return v2;
					end
				end
			)
			if(not v2) then
				-- Buff dropped
				-- DEFAULT_CHAT_FRAME:AddMessage("=== add to Delete /v1 id: "..v1);
				table.insert(buffsToDelete, v1);
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_TarBuff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_TarCurrentBuffs,
				function(k, v2)
					if (v1==v2) then
						return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..v1..")");
				EventAlert_TarBuff_Applied(v1);
			end
		end
	)
	EventAlert_TarPositionFrames();
end

function EventAlert_TarChange_ClearFrame()
	local ibuff = #EA_TarCurrentBuffs;
	for i=1,ibuff do
		EventAlert_TarBuff_Dropped(EA_TarCurrentBuffs[1]);
	end
end

function EventAlert_Buff_Dropped(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellId);
	local f = _G["EAFrame_"..spellId];
	if f then
		f:Hide();
		f:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_CurrentBuffs, spellId);
end

function EventAlert_Buff_Applied(spellId)
	local alreadySpell  = false
	for i = 1, #EA_CurrentBuffs do
		if EA_CurrentBuffs[i] == spellId then
			alreadySpell = true
			break;
		end
	end
	if not alreadySpell then
		table.insert(EA_CurrentBuffs, spellId);
		EventAlert_DoAlert(spellId);
	end
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellId);
end

function EventAlert_TarBuff_Dropped(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellId);
	local f = _G["EAFrame_"..spellId];
	if f then
		f:Hide();
		f:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_TarCurrentBuffs, spellId);
end

function EventAlert_TarBuff_Applied(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellId);
	table.insert(EA_TarCurrentBuffs, spellId);
end

function EventAlert_COMBAT_TEXT_SPELL_ACTIVE(spellName)
	if (EA_Config.AllowAltAlerts==true) then
		-- DEFAULT_CHAT_FRAME:AddMessage("spell-active: "..spellName);
		-- searching for the spell-id, because we only get the name of the spell
		local spellId = table.foreach(EA_PreLoadAlts, function(i, spellId)
			-- DEFAULT_CHAT_FRAME:AddMessage("EA_PreLoadAlts("..spellId..")");
			if i==spellName then
				return spellId
			end
		end)

		if spellId then
			spellId = tonumber(spellId);
			if (EA_AltItems[EA_playerClass][spellId]) then
				local v2 = table.foreach(EA_CurrentBuffs, function(i2, v2)
					if v2==spellId then
						return v2
					end
				end)

				if (not v2) then
					-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..spellId..")");
					EventAlert_Buff_Applied(spellId);
					EventAlert_PositionFrames();
				end
			end
		end
	end
end

function EventAlert_OnUpdate(spellId)
	if #EA_CurrentBuffs ~= 0 then

		local eaf = _G["EAFrame_"..spellId];
		local name = EA_SPELLINFO_SELF[spellId].name;
		local rank = EA_SPELLINFO_SELF[spellId].rank;

		if (EA_Config.AllowAltAlerts == true) then
			if (EA_AltItems[EA_playerClass][spellId]) then
				local EA_usable, EA_nomana = IsUsableSpell(name);
				if (EA_usable ~= 1) then
					EventAlert_Buff_Dropped(spellId);
					EventAlert_PositionFrames();
					return;
				 else
					EA_SPELLINFO_SELF[spellId].count = 0;
					EA_SPELLINFO_SELF[spellId].expirationTime = 0;
					EA_SPELLINFO_SELF[spellId].isDebuff = false;
				end
			end
		end

		if (EA_Config.ShowTimer == true) then
			-- local EA_Name,_,_,EA_count,_,_,EA_expirationTime,_,_ = UnitAura("player", name, rank);
			-- local EA_Name = EA_SPELLINFO_SELF[spellId].name;
			local EA_count = EA_SPELLINFO_SELF[spellId].count;
			local EA_expirationTime = EA_SPELLINFO_SELF[spellId].expirationTime;
			-- local IfIsDebuff = EA_SPELLINFO_SELF[spellId].isDebuff;
			local EA_currentTime = 0;
			local EA_timeLeft = 0;
			-- local EA_duration = EA_SPELLINFO_SELF[spellId].duration;
			-- if EA_duration then
				-- local EA_start = EA_expirationTime - EA_duration;
				-- eaf:SetCooldown(EA_start, EA_duration);
			-- end
			eaf:SetCooldown(1, 0);
			if (EA_expirationTime ~= nil) then
				EA_currentTime = GetTime();
				EA_timeLeft = EA_expirationTime - EA_currentTime;

				if EA_timeLeft > 0 then
					eaf.spellTimer:ClearAllPoints();
					if (EA_Config.ChangeTimer == true) then
						eaf.spellTimer:SetPoint("CENTER", 0, 0);
					else
						eaf.spellTimer:SetPoint("TOP", 0, 20);
					end
					eaf.spellTimer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
					if EA_timeLeft <= 60 then
						eaf.spellTimer:SetFormattedText("%d", EA_timeLeft);
					else
						eaf.spellTimer:SetFormattedText("%d:%02d", floor(EA_timeLeft/60), EA_timeLeft % 60);
					end

					eaf.spellStack:ClearAllPoints();
					if (EA_count > 1) then
						eaf.spellStack:SetPoint("BOTTOMRIGHT", 0, 0);
						eaf.spellStack:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
						eaf.spellStack:SetFormattedText("%d", EA_count);
					else
						eaf.spellStack:SetFormattedText("");
					end
				else
					if not EA_AltItems[EA_playerClass][spellId] then
						EventAlert_Buff_Dropped(spellId)
					end
				end
			end
		end
	end
end

function EventAlert_OnTarUpdate(spellId)
	if #EA_TarCurrentBuffs ~= 0 then
		local eaf = _G["EAFrame_"..spellId];
		if (EA_Config.ShowTimer == true) then
			-- local EA_Name = EA_SPELLINFO_TARGET[spellId].name;
			local EA_count = EA_SPELLINFO_TARGET[spellId].count;
			local EA_expirationTime = EA_SPELLINFO_TARGET[spellId].expirationTime;
			-- local IfIsDebuff = EA_SPELLINFO_TARGET[spellId].isDebuff;
			local EA_currentTime = 0;
			local EA_timeLeft = 0;
			-- local EA_duration = EA_SPELLINFO_TARGET[spellId].duration;
			-- if EA_duration then
				-- local EA_start = EA_expirationTime - EA_duration;
				-- eaf:SetCooldown(EA_start, EA_duration);
			-- end
			eaf:SetCooldown(1, 0);
			if (EA_expirationTime ~= nil) then
				EA_currentTime = GetTime();
				EA_timeLeft = EA_expirationTime - EA_currentTime;

				if EA_timeLeft > 0 then
					eaf.spellTimer:ClearAllPoints();
					if (EA_Config.ChangeTimer == true) then
						eaf.spellTimer:SetPoint("CENTER", 0, 0);
					else
						eaf.spellTimer:SetPoint("TOP", 0, 20);
					end
					eaf.spellTimer:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
					if EA_timeLeft <= 60 then
						eaf.spellTimer:SetFormattedText("%d", EA_timeLeft);
					else
						eaf.spellTimer:SetFormattedText("%d:%02d", floor(EA_timeLeft/60), EA_timeLeft % 60);
					end

					eaf.spellStack:ClearAllPoints();
					if (EA_count > 1) then
						eaf.spellStack:SetPoint("BOTTOMRIGHT", 0, 0);
						eaf.spellStack:SetFont("Fonts\\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
						eaf.spellStack:SetFormattedText("%d", EA_count);
					else
						eaf.spellStack:SetFormattedText("");
					end
				else
					EventAlert_TarBuff_Dropped(spellId)
				end
			end
		end
	end
end

function EventAlert_DoAlert(spellId)
	if (EA_Config.ShowFlash == true) then
		UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
		UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
	end
	if (EA_Config.DoAlertSound == true and spellId ~= 58597) then
		PlaySoundFile(EA_Config.AlertSound);
	end
end

function EventAlert_PositionFrames()
	if (EventAlert_Enable and EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;

		for k,v in ipairs(EA_CurrentBuffs) do
			local eaf = _G["EAFrame_"..v];
			local spellId = tonumber(v);
			local gsiName = EA_SPELLINFO_SELF[spellId].name;
			local gsiIcon = EA_SPELLINFO_SELF[spellId].icon;
			local gsiIsDebuff = EA_SPELLINFO_SELF[spellId].isDebuff;

			eaf:ClearAllPoints();
			if gsiIsDebuff then
				if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
					prevFrame = "EA_Main_Frame";
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
				else
					eaf:SetPoint("CENTER", prevFrame, "CENTER", -1 * xOffset, -1 * yOffset);
				end
			else
				if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
					prevFrame = "EA_Main_Frame";
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, 0, 0);
				else
					eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
				end
			end

			eaf:SetWidth(EA_Config.IconSize);
			eaf:SetHeight(EA_Config.IconSize);
			eaf:SetBackdrop({bgFile = gsiIcon});
			if gsiIsDebuff then eaf:SetBackdropColor(1.0, EA_Position.RedDebuff, EA_Position.RedDebuff) end
			if (EA_Config.ShowName == true) then
				eaf.spellName:SetText(gsiName);
				local SfontName, SfontSize = eaf.spellName:GetFont();
				eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
			else
				eaf.spellName:SetText("");
			end
			eaf:SetScript("OnUpdate", function()
				EventAlert_OnUpdate(spellId)
			end);
			prevFrame = eaf;
			eaf:Show();
		end
	end
end

function EventAlert_TarPositionFrames()
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;

		for k,v in ipairs(EA_TarCurrentBuffs) do
			local eaf = _G["EAFrame_"..v];
			local spellId = tonumber(v);
			local gsiName = EA_SPELLINFO_TARGET[spellId].name;
			local gsiIcon = EA_SPELLINFO_TARGET[spellId].icon;
			-- local gsiIsDebuff = EA_SPELLINFO_TARGET[spellId].isDebuff;

			eaf:ClearAllPoints();
			if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
				prevFrame = "EA_Main_Frame";
				eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset, EA_Position.Tar_yOffset);
			else
				eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
			end

			eaf:SetWidth(EA_Config.IconSize);
			eaf:SetHeight(EA_Config.IconSize);
			eaf:SetBackdrop({bgFile = gsiIcon});
			eaf:SetBackdropColor(EA_Position.GreenDebuff, 1.0, EA_Position.GreenDebuff);
			if (EA_Config.ShowName == true) then
				eaf.spellName:SetText(gsiName);
				local SfontName, SfontSize = eaf.spellName:GetFont();
				eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
			else
				eaf.spellName:SetText("");
			end
			eaf:SetScript("OnUpdate", function()
				EventAlert_OnTarUpdate(spellId)
			end);
			prevFrame = eaf;
			eaf:Show();
		end
	end
end

-- The command parser
function EventAlert_SlashHandler(msg)
	local F_EA = "\124cffFFFF00EventAlert\124r";
	local F_ON = "\124cffFF0000".."[ON]".."\124r";
	local F_OFF = "\124cff00FFFF".."[OFF]".."\124r";
	local RtnMsg = "";
	local MoreHelp = false;

	msg = string.lower(msg);
	local cmdtype, para1 = strsplit(" ", msg)
	local listSec = 0;
	if para1 ~= nil then
		listSec = tonumber(para1);
		if type(listSec)~="number" then listSec = 0 end
	end

	if (cmdtype == "options" or cmdtype == "opt") then
		if not EA_Options_Frame:IsVisible() then
			ShowUIPanel(EA_Options_Frame);
		else
			HideUIPanel(EA_Options_Frame);
		end

	-- elseif (cmdtype == "version" or cmdtype == "ver") then
	-- 	DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);

	elseif (cmdtype == "show") then
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG4 = false;
		EA_LISTSEC_SELF = 0;
		if (EA_DEBUGFLAG1) then
			EA_DEBUGFLAG1 = false;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG1 = true;
			EA_LISTSEC_SELF = listSec;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_ON;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showtarget" or cmdtype == "showt") then
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG4 = false;
		EA_LISTSEC_TARGET = 0;
		if (EA_DEBUGFLAG2) then
			EA_DEBUGFLAG2 = false;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_OFF;
		else
			EA_DEBUGFLAG2 = true;
			EA_LISTSEC_TARGET = listSec;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_ON;
			if EA_LISTSEC_TARGET > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_TARGET.." secs)" end
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showautoadd" or cmdtype == "showa") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG4 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG3) then
			EA_DEBUGFLAG3 = false;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG3 = true;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_ON;
			if listSec > 0 then	EA_LISTSEC_SELF = listSec end
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showenvadd" or cmdtype == "showe") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG3 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG4) then
			EA_DEBUGFLAG4 = false;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG4 = true;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_ON;
			if listSec > 0 then	EA_LISTSEC_SELF = listSec end
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	else
		if cmdtype == "help" then MoreHelp = true end
		-- DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.TITLE);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.OPT);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.HELP);

		for i, v in ipairs(EA_XCMD_CMDHELP["SHOW"]) do
			if i == 1 then
				if EA_DEBUGFLAG1 then v = v..EA_XCMD_SELFLIST..F_ON else v = v..EA_XCMD_SELFLIST..F_OFF end
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v)
			end

		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWT"]) do
			if i == 1 then
				if EA_DEBUGFLAG2 then v = v..EA_XCMD_TARGETLIST..F_ON else v = v..EA_XCMD_TARGETLIST..F_OFF end
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v)
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWA"]) do
			if i == 1 then
				if EA_DEBUGFLAG3 then v = v..EA_XCMD_AUTOADD_SELFLIST..F_ON else v = v..EA_XCMD_AUTOADD_SELFLIST..F_OFF end
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v)
			end
		end
	end
end

-- The URLs of update
function EventAlert_ShowVerBuff(SiteIndex)
	local F_EA = "\124cffFFFF00EventAlert\124r";
	local F_ON = "\124cffFF0000".."[ON]".."\124r";
	local F_OFF = "\124cff00FFFF".."[OFF]".."\124r";
	local RtnMsg = "";

	if SiteIndex == 1 then
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG4 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG1) then
			EA_DEBUGFLAG1 = false;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG1 = true;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_ON;
			RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)";
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);
	else
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG4 = false;
		EA_LISTSEC_TARGET = 60;
		if (EA_DEBUGFLAG2) then
			EA_DEBUGFLAG2 = false;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_OFF;
		else
			EA_DEBUGFLAG2 = true;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_ON;
			RtnMsg = RtnMsg.." ("..EA_LISTSEC_TARGET.." secs)";
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);
	end
end

function EventAlert_VersionCheck()
	local EA_tempVer = GetAddOnMetadata("EventAlert", "Version");
	local F_EA = "\124cffFFFF00EventAlert2\124r";

	if (EA_Config.Version == EA_tempVer) then
		-- Do Nothing
	elseif (EA_Config.Version ~= EA_tempVer and EA_Config.Version ~= nil) then
		EA_Config.Version = EA_tempVer;
		if EA_XLOAD_NEWVERSION_LOAD ~= "" then
			EA_Version_Frame_EditBox:SetFontObject(ChatFontNormal);
			EA_Version_Frame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_NEWVERSION_LOAD);
			EA_Version_Frame:Show();
		end
	elseif (EA_Config.Version == nil) then
		EA_Config.Version = EA_tempVer;
		if EA_XLOAD_FIRST_LOAD ~= "" then
			EA_Version_Frame_EditBox:SetFontObject(ChatFontNormal);
			EA_Version_Frame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_FIRST_LOAD)
			EA_Version_Frame:Show();
		end
		-- EventAlert_FunctionOfDoom();
		EA_Config = nil;
		EA_Config = { DoAlertSound, AlertSound, AlertSoundValue, LockFrame, ShowFrame, ShowName, ShowFlash, ShowTimer, TimerFontSize, StackFontSize, SNameFontSize, ChangeTimer, Version, AllowESC, AllowAltAlerts, Target_MyDebuff };
		EA_Position = nil;
		EA_Position = { Anchor, relativePoint, xLoc, yLoc, xOffset, yOffset, RedDebuff, GreenDebuff, Tar_xOffset, Tar_yOffset };
		EA_Items = nil;
		EA_Config.Version = EA_tempVer;
	end

	-- After confirm the version, set the VersionText in the EA_Options_Frame.
    EA_Options_Frame_VersionText:SetText("Ver:\124cffFFFFFF"..EA_Config.Version.."\124r");
end

function removeBuffValue(tab, value)
	for pos, name in ipairs(tab) do
		if (name == value) then
			table.remove(tab, pos)
		end
	end
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0 -- iterator variable
		local iter = function () -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

EventAlert_Enable= false;
function EventAlert_Toggle(toggle)
	if toggle then
		EA_Main_Frame:RegisterEvent("COMBAT_TEXT_UPDATE");
		EA_Main_Frame:RegisterEvent("PLAYER_ENTERING_WORLD");
		EA_Main_Frame:RegisterEvent("PLAYER_DEAD");
		EA_Main_Frame:RegisterEvent("UNIT_AURA");
		EA_Main_Frame:RegisterEvent("PLAYER_TARGET_CHANGED");
		EA_Main_Frame:Show();
		EventAlert_Enable = true;
	else
		EA_Main_Frame:UnregisterEvent("COMBAT_TEXT_UPDATE");
		EA_Main_Frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
		EA_Main_Frame:UnregisterEvent("PLAYER_DEAD");
		EA_Main_Frame:UnregisterEvent("UNIT_AURA");
		EA_Main_Frame:UnregisterEvent("PLAYER_TARGET_CHANGED");
		EA_Main_Frame:Hide();
		EventAlert_Enable = false;
	end
end

function Pal_CheckUnitSSCaster(unit)
	for i=1,40 do
		local name, rank, _, count, _, duration, expirationTime, unitCaster,_,_,spellId = UnitAura(unit, i, "HELPFUL");
		if unitCaster =="player" then
			if spellId == 53601 then
				EA_SacredShield = UnitGUID(unit);
				return
			end
		end
	end
end

function PALADIN_SSTrigger(unit)
	local hasSacredShield = false
	for i=1,40 do
		local name, rank, _, count, _, duration, expirationTime, unitCaster,_,_,spellId = UnitAura(unit, i, "HELPFUL");
		if unitCaster =="player" then
			if (EA_Items[EA_playerClass][58597] and spellId==58597) then
				EA_SPELLINFO_SELF[58597].count = count;
				EA_SPELLINFO_SELF[58597].duration = duration;
				EA_SPELLINFO_SELF[58597].expirationTime = expirationTime;
				EA_SPELLINFO_SELF[58597].unitCaster = unitCaster;
				EA_SPELLINFO_SELF[58597].isDebuff = false;
				hasSacredShield =  true
			end
		end
	end

	if hasSacredShield then
		EventAlert_Buff_Applied(58597)
	else
		EventAlert_Buff_Dropped(58597)
	end
	-- Check: Buff applied
	EventAlert_PositionFrames();

	if (EA_DEBUGFLAG3 or EA_DEBUGFLAG4) then
		CreateFrames_RefreshPrimarySpellList();
	end
end

--Ever@bf 新增法术书快捷显示法术id，减少去网站查询自己的法术id问题
function Ev_GameTooltip_SetSpell(this, id, type, ...)
	Old_GameTooltip_SetSpell(this, id, type, ...);
	local spell = GetSpellName(id, type);
	if spell then
		local id = select(3, strfind(GetSpellLink(spell), "spell:(%d+)"))
		_G[this:GetName().."TextLeft1"]:SetText(format("%s|c00c8c8c8(|c0000e8e8%s|c00c8c8c8)|r",spell, id))
	end
end

function Ev_Switch_Tips(switch)
	if switch == 1 then
		if not ischange then
			ischange = true;
			Old_GameTooltip_SetSpell = GameTooltip.SetSpell;
			GameTooltip.SetSpell = Ev_GameTooltip_SetSpell;
		end
	else
		GameTooltip.SetSpell = _G[GameTooltip.SetSpell];
		ischange = nil;
	end
end
