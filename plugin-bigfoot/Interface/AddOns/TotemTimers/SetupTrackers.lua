-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers")

local Timers = XiTimers.timers
local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local AvailableSpells = TotemTimers.AvailableSpells


local WeaponBar

local mainHandWeapon, offHandWeapon, lastMhWeapon, lastOhWeapon
local earthShieldTarget = nil

function TotemTimers.SetNumWeaponTimers()
    local button = Timers[8].button
	local name,_,_,_,rank = GetTalentInfo(2,20)
    TotemTimers.SetDoubleTexture(button, rank and rank>0, true)
    Timers[8].numtimers = (rank and rank > 0) and 2 or 1
	Timers[8]:SetTimerBarPos(Timers[8].timerBarPos)
end


local function splitString(ustring)
    local c = 0
    local s = ""
    for uchar in string.gmatch(ustring, "([%z\1-\127\194-\244][\128-\191]*)") do
        c = c + 1
        s = s..uchar
        if c == 4 then break end
    end
    return s
end

function TotemTimers_CreateTrackers()
	-- ankh tracker
	local ankh = XiTimers:new(1)
	ankh.button:SetScript("OnEvent", TotemTimers.AnkhEvent)
	ankh.button.icons[1]:SetTexture(SpellTextures[SpellIDs.Ankh])
	ankh.events[1] = "BAG_UPDATE"
	ankh.events[2] = "SPELL_UPDATE_COOLDOWN"
	ankh.button.anchorframe = TotemTimers_TrackerFrame
	ankh.showCooldown = true
	ankh.dontAlpha = true
	ankh.button.icons[1]:SetAlpha(1)
	ankh.timeStyle = "blizz"
	ankh.activate = function(self) 
        XiTimers.activate(self) 
        TotemTimers.AnkhEvent(ankh.button, "SPELL_UPDATE_COOLDOWN")
        TotemTimers.ProcessSetting("TimerSize")
    end
	ankh.button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    ankh.deactivate = function(self)
        XiTimers.deactivate(self)
        TotemTimers.ProcessSetting("TimerSize")
    end
    ankh.button.cooldown.noCooldownCount = true
    ankh.button.cooldown.noOCC = true
		
	local shield = XiTimers:new(1)
	shield.button.icons[1]:SetTexture(SpellTextures[SpellIDs.LightningShield])
	shield.button.anchorframe = TotemTimers_TrackerFrame
	shield.button:SetScript("OnEvent", TotemTimers.ShieldEvent)
	shield.events[1] = "UNIT_SPELLCAST_SUCCEEDED"
	shield.events[2] = "UNIT_AURA"
	shield.timeStyle = "blizz"
	shield.activate = function(self)
        XiTimers.activate(self)
        TotemTimers.ShieldEvent(self.button, "UNIT_AURA")
        if not TotemTimers.ActiveSpecSettings.ShieldTracker then
            self.button:Hide()
        end
      end
	shield.button:SetAttribute("*type*", "spell")
    shield.button:SetAttribute("*unit*", "player")
	shield.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
	
	local earthshield = XiTimers:new(1)
	earthshield.button.icons[1]:SetTexture(SpellTextures[SpellIDs.EarthShield])
	earthshield.button.anchorframe = TotemTimers_TrackerFrame
	earthshield.button:SetScript("OnEvent", TotemTimers.EarthShieldEvent)
	earthshield.events[1] = "UNIT_SPELLCAST_SUCCEEDED"
	earthshield.events[2] = "COMBAT_LOG_EVENT_UNFILTERED"
	earthshield.events[3] = "UNIT_AURA"
	earthshield.events[4] = "PARTY_MEMBER_CHANGED"
	earthshield.events[5] = "RAID_ROSTER_UPDATE"
	earthshield.events[6] = "PLAYER_REGEN_ENABLED"
    earthshield.events[7] = "PARTY_LEADER_CHANGED"
	earthshield.timeStyle = "blizz"
	earthshield.button:SetAttribute("*type*", "spell")
	earthshield.activate = function(self)
        XiTimers.activate(self)
        self.button:SetAttribute("*spell*", SpellNames[SpellIDs.EarthShield])
        if not TotemTimers_Settings.EarthShieldTracker then self.button:Hide() end
      end
	earthshield.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up")
    earthshield.ManaCheck = SpellNames[SpellIDs.EarthShield]
    
    earthshield.stop = function(self,nr)
        XiTimers.stop(self,nr)
        if earthShieldTarget then
            self.button.hotkey:SetText(splitString(earthShieldTarget))
            self.button.hotkey:Show()
        end
    end

    earthshield.start = function(self,nr, time, duration)
        XiTimers.start(self,nr, time, duration)
        if earthShieldTarget then
            self.button.hotkey:SetText(splitString(earthShieldTarget))
            self.button.hotkey:Show()
        end
    end
    
   --earthshield.button.hotkey.SetText = function(self, text) print("SetText: "..tostring(text)) if not text or text == "" then print(debugstack()) end end
	
	local weapon = XiTimers:new(2)
	weapon.button.icons[1]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])
	weapon.button.icons[2]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])
	weapon.button.anchorframe = TotemTimers_TrackerFrame
	weapon.button:SetScript("OnEvent", TotemTimers.WeaponEvent)
	weapon.events[1] = "COMBAT_LOG_EVENT_UNFILTERED"
	weapon.events[2] = "UNIT_INVENTORY_CHANGED"
	weapon.events[3] = "CHARACTER_POINTS_CHANGED"
    weapon.events[5] = "UNIT_SPELLCAST_SUCCEEDED"
    weapon.events[6] = "UNIT_AURA"
	weapon.events[7] = "PLAYER_TALENT_UPDATE"
	weapon.timeStyle = "blizz"
	weapon.button:SetAttribute("*type*", "spell")
    weapon.button:SetAttribute("ctrl-spell1", ATTRIBUTE_NOOP)
    weapon.button:RegisterEvent("PLAYER_ALIVE")
	weapon.update = TotemTimers.WeaponUpdate
	weapon.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    weapon.timerbars[1]:SetMinMaxValues(0,1800)
    weapon.timerbars[2]:SetMinMaxValues(0,1800)
	TotemTimers.SetNumWeaponTimers()
    weapon.flashall = true
    weapon.activate = function(self)
        XiTimers.activate(self)
        if not TotemTimers_Settings.WeaponTracker then self.button:Hide() end
      end
      
    weapon.button.HideTooltip =  TotemTimers.HideTooltip
    WeaponBar = TTActionBars:new(6, weapon.button, nil, TotemTimers_TrackerFrame, "weapontimer")
    weapon.bar = WeaponBar
    weapon.button.ShowTooltip = TotemTimers.WeaponButtonTooltip
    weapon.button.SaveLastEnchant = function(self, name)
                                        if name == "spell1" then TotemTimers.ActiveSpecSettings.LastWeaponEnchant = self:GetAttribute("spell1") 
                                        elseif name == "spell2" or name == "spell3" then 
                                            TotemTimers.ActiveSpecSettings.LastWeaponEnchant2 = self:GetAttribute("spell2") or self:GetAttribute("spell3")
                                        elseif name == "doublespell2" then
                                            local ds2 = self:GetAttribute("doublespell2")
                                            if ds2 then
                                                if ds2 == SpellNames[SpellIDs.FlametongueWeapon] then 
                                                    TotemTimers.ActiveSpecSettings.LastWeaponEnchant = 5
                                                elseif ds2 == SpellNames[SpellIDs.FrostbrandWeapon] then
                                                    TotemTimers.ActiveSpecSettings.LastWeaponEnchant = 6
                                                end
                                            end
                                        end
                                    end
    weapon.button:SetAttribute("_onattributechanged", [[ if name=="hide" then
                                                             control:ChildUpdate("show", false)
                                                             control:CallMethod("HideTooltip")
                                                         elseif name == "spell1" or name == "doublespell1" or name == "doublespell2" or name == "spell2" or name == "spell3"then
                                                             control:CallMethod("SaveLastEnchant", name)
                                                         elseif name == "state-invehicle" then
                                                            if value == "show" and self:GetAttribute("active") then
                                                                self:Show()
                                                            else
                                                                self:Hide()
                                                            end
                                                         end]])
    weapon.button:SetAttribute("_onenter", [[ if self:GetAttribute("tooltip") then control:CallMethod("ShowTooltip") end
                                              if self:GetAttribute("OpenMenu") == "mouseover" then
                                                  control:ChildUpdate("show", true)
                                              end ]])
	weapon.button:SetAttribute("_onleave", [[ control:CallMethod("HideTooltip") ]])
	weapon.button:WrapScript(weapon.button, "OnClick", [[ if button == self:GetAttribute("OpenMenu") then
                                                              local open = self:GetAttribute("open")
                                                              control:ChildUpdate("show", not open)
															  self:SetAttribute("open", not open)
                                                          elseif IsControlKeyDown() then
                                                              control:CallMethod("KillEnchants")
                                                          end]])
	weapon.button:WrapScript(weapon.button, "PostClick", [[ if button == "LeftButton" then
                                                                local ds1 = self:GetAttribute("doublespell1")
                                                                if ds1 then
                                                                    if IsControlKeyDown() or self:GetAttribute("ds") ~= 1 then
                                                                        self:SetAttribute("macrotext", "/cast "..ds1.."\n/use 16")
																		self:SetAttribute("ds",1)
                                                                    else
                                                                        self:SetAttribute("macrotext", "/cast "..self:GetAttribute("doublespell2").."\n/use 17")
																		self:SetAttribute("ds",2)
                                                                    end
                                                                end
                                                           end]])
    weapon.button.KillEnchants = function() CancelItemTempEnchantment(1) CancelItemTempEnchantment(2) end
	weapon.button:SetScript("OnDragStop", function(self)
            XiTimers.StopMoving(self)
            if not InCombatLockdown() then self:SetAttribute("hide", true) end
            TotemTimers.ProcessSetting("WeaponBarDirection")
        end)
    weapon.nobars = true
end


function TotemTimers.SetWeaponTrackerSpells()
    WeaponBar:ResetSpells()
    if AvailableSpells[SpellNames[SpellIDs.RockbiterWeapon]] and not AvailableSpells[SpellNames[SpellIDs.WindfuryWeapon]] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.RockbiterWeapon])
    end
    if  AvailableSpells[SpellNames[SpellIDs.WindfuryWeapon]] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.WindfuryWeapon])
    end
    if  AvailableSpells[SpellNames[SpellIDs.FlametongueWeapon]] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.FlametongueWeapon])
    end
    if  AvailableSpells[SpellNames[SpellIDs.EarthlivingWeapon]] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.EarthlivingWeapon])
    end
    if  AvailableSpells[SpellNames[SpellIDs.FrostbrandWeapon]] then
        WeaponBar:AddSpell(SpellNames[SpellIDs.FrostbrandWeapon])
    end
    if  AvailableSpells[SpellNames[SpellIDs.WindfuryWeapon]] and AvailableSpells[SpellNames[SpellIDs.FlametongueWeapon]] then
        WeaponBar:AddDoubleSpell(SpellNames[SpellIDs.WindfuryWeapon],SpellNames[SpellIDs.FlametongueWeapon])       
    end    
    if  AvailableSpells[SpellNames[SpellIDs.WindfuryWeapon]] and AvailableSpells[SpellNames[SpellIDs.FrostbrandWeapon]] then
        WeaponBar:AddDoubleSpell(SpellNames[SpellIDs.WindfuryWeapon],SpellNames[SpellIDs.FrostbrandWeapon])        
    end    
end



local AnkhName = SpellNames[SpellIDs.Ankh]

function TotemTimers.AnkhEvent(self, event)
	if not AvailableSpells[AnkhName] then return end
	if event=="BAG_UPDATE" then
		local ankhs = GetItemCount(17030)
		self.count:SetText(ankhs)
		if ankhs == 0 then
			self.icons[1]:SetVertexColor(0.5,0.5,1.0)
		else
			self.icons[1]:SetVertexColor(1.0,1.0,1.0)
		end
	else
		local start, duration, enable = GetSpellCooldown(AnkhName)
		if duration == 0 then
			self.timer:stop(1)
		elseif self.timer.timers[1]<=0 and duration>2 then
			self.timer:start(1,start+duration-floor(GetTime()),1800)
		end
	end
end

local shieldtable = {SpellNames[SpellIDs.LightningShield], SpellNames[SpellIDs.WaterShield], SpellNames[SpellIDs.EarthShield]}

function TotemTimers.ShieldEvent(self, event, unit)
	if event=="UNIT_SPELLCAST_SUCCEEDED" and unit=="player" then
		local start, duration, enable = GetSpellCooldown(SpellNames[SpellIDs.LightningShield])
		if start and duration and (not self.timer.timerOnButton or self.timer.timers[1]<=0) then
            CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
        end
	elseif unit=="player" then
		self.count:SetText("")
		local name, texture, count, duration, endtime
		for _, shield in pairs(shieldtable) do
			if not name and AvailableSpells[shield] then
				name,_,texture,count,_,duration,endtime = UnitAura("player", shield)
			end
		end	
			
		if name then
			local timeleft = endtime - GetTime()
			if name ~= self.shield or timeleft>self.timer.timers[1] then
				self.icons[1]:SetTexture(texture)
				self.timer:start(1, timeleft, duration)
				self.timer.expirationMsgs[1] = "Shield"
				self.timer.earlyExpirationMsgs[1] = "Shield"
                self.timer.WarningIcons[1] = texture
                self.timer.WarningSpells[1] = name
                self.shield = shield
			end
			self.count:SetText(count)
		elseif self.timer.timers[1]>0 then
			self.timer:stop(1)
		end
	end  
end

local ButtonPositions = {
	["box"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"TOP",2,"BOTTOM"},{"LEFT",1,"RIGHT"}},
	["horizontal"] = {{"CENTER",0,"CENTER"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"},{"LEFT",1,"RIGHT"}},
	["vertical"] = {{"CENTER",0,"CENTER"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"},{"TOP",1,"BOTTOM"}}	
}

function TotemTimers_OrderTrackers()
	local arrange = TotemTimers_Settings.TrackerArrange
    for e=5,8 do
		Timers[e]:ClearAnchors()
		Timers[e].button:ClearAllPoints()
	end
    if arrange == "free" then
        for i=5,8 do
            Timers[i].savePos = true
            local pos = TotemTimers_Settings.TimerPositions[i]            
            if not pos or not pos[1] then pos = {"CENTER", "UIParent", "CENTER", 0,0} end
            Timers[i].button:ClearAllPoints()
            Timers[i].button:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
        end
    else
    	local counter = 0
    	local buttons = {}
    	for i=5,8 do
            Timers[i].savePos = false
    		--if Timers[i].active then
            if Timers[i].button:IsVisible() then
    			counter = counter + 1
    			if counter == 1 then
    				Timers[i]:SetPoint(ButtonPositions[arrange][1][1], TotemTimers_TrackerFrame, ButtonPositions[arrange][1][3])
    			else
    				Timers[i]:Anchor(buttons[counter-ButtonPositions[arrange][counter][2]], ButtonPositions[arrange][counter][1])	
    			end
    			buttons[counter] = Timers[i]
    		end
    	end
    end
	TotemTimers.ProcessSetting("WeaponBarDirection")
end


local playerName = UnitName("player")
local earthShieldRecast = false
local changeEarthShieldRecast = false

local buttons = {"LeftButton", "RightButton", "MiddleButton", "Button4"}

function TotemTimers_EnableEarthShieldRecast()
	earthShieldRecast = true
end

local function TotemTimers_ChangeEarthShieldTarget()
	for k,v in pairs(buttons) do
		if TotemTimers_Settings["EarthShield"..v] == "recast" then
            if earthShieldTarget == playerName then
                Timers[7].button:SetAttribute("*unit"..k, "player")
                break
            end
			for i = 1,4 do               
				if UnitExists("party"..i) then
                    local n,s = UnitName("party"..i)
                    if s and s~= "" then n = n.."-"..s end
                    if n == earthShieldTarget then
                        Timers[7].button:SetAttribute("*unit"..k, "party"..i)
                        break
                    end
				end
			end
			for i = 1,GetNumRaidMembers() do
				local n,s = UnitName("raid"..i)
                if s and s~= "" then n = n.."-"..s end
                if n == earthShieldTarget then
					Timers[7].button:SetAttribute("*unit"..k, "raid"..i)
					break
				end
			end
			break
		end
	end
end


local EarthShieldSpellName = SpellNames[SpellIDs.EarthShield]

local function checkESBuff(self)
    local name,_,_,count,_,duration,endtime = UnitBuff(earthShieldTarget, EarthShieldSpellName)
    if count then
        local timeleft = endtime - GetTime()
        self.count:SetText(count)
        if timeleft-self.timer.timers[1] > 0.1  then
            self.timer:start(1, timeleft, duration)
            self.timer.expirationMsgs[1] = "EarthShield"
            self.timer.earlyExpirationMsgs[1] = "EarthShield"
            self.timer.WarningIcons[1] = SpellTextures[SpellIDs.EarthShield]
            self.timer.WarningSpells[1] = SpellNames[SpellIDs.EarthShield]
        end
    elseif self.timer.timers[1] > 0 then
        self.timer:stop(1)
        self.count:SetText("")
    end
end


function TotemTimers.EarthShieldEvent(self, event, ...)
	if not AvailableSpells[EarthShieldSpellName] then return end
	local unit,spellcast,_,caster,_,_,target,_,_,spell = ...
	if event == "COMBAT_LOG_EVENT_UNFILTERED" and spellcast=="SPELL_CAST_SUCCESS" and caster == playerName and spell == EarthShieldSpellName then
        earthShieldTarget = target
        if earthShieldRecast then
            if not InCombatLockdown() then
                TotemTimers_ChangeEarthShieldTarget()
            else
                changeEarthShieldRecast = true
            end
        end
        checkESBuff(self)
	elseif event=="UNIT_SPELLCAST_SUCCEEDED" and select(1,...) == "player" then
		local start, duration, enable = GetSpellCooldown(EarthShieldSpellName)
		if start and duration and (not self.timer.timerOnButton or self.timer.timers[1]<=0) then
            CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
        end
	elseif event == "UNIT_AURA" and earthShieldTarget then
        local t,s = UnitName(unit, true)
        if s and s ~= "" then t = t.."-"..s end
        if t == earthShieldTarget then
            checkESBuff(self)
        end
	elseif event == "PLAYER_REGEN_ENABLED" and earthShieldRecast and changeEarthShieldRecast then
		TotemTimers_ChangeEarthShieldTarget()
	elseif (event == "PARTY_MEMBERS_CHANGED" or event == "RAID_ROSTER_UPDATE" or event == "PARTY_LEADER_CHANGED") and earthShieldRecast and earthShieldTarget then
		if InCombatLockdown() then
			changeEarthShieldTarget = true
		else
			TotemTimers_ChangeEarthShieldTarget()
		end
	end
end

local mainMsg = ""
local offMsg = ""

local GetWeaponEnchantInfo = GetWeaponEnchantInfo

local Enchanted, CastEnchant, CastTexture


local function SetWeaponEnchantTextureAndMsg(self, enchant, texture, nr)
    if nr == 1 then TotemTimers_Settings.LastMainEnchants[mainHandWeapon] = {enchant, texture}
    else TotemTimers_Settings.LastOffEnchants[offHandWeapon] = {enchant, texture} end
    self.icons[nr]:SetTexture(texture)
    self.timer.WarningIcons[nr] = texture
    self.timer.WarningSpells[nr] = enchant
    self.timer.expirationMsgs[nr] = "Weapon"
end

function TotemTimers.WeaponUpdate(self, elapsed)
	local enchant, expiration, _, oenchant, oexpiration = GetWeaponEnchantInfo()
    if enchant then
        if expiration/1000 > self.timers[1] then
            self:start(1, expiration/1000, 1800)
            if Enchanted then
                Enchanted = nil
                SetWeaponEnchantTextureAndMsg(self.button, CastEnchant, CastTexture, 1)
            end
        end
        if expiration == 0 then
            self:stop(1)
        else
            self.timers[1] = expiration/1000
        end
    elseif self.timers[1] > 0 then
        self:stop(1)
    end
    if oenchant then
        if oexpiration/1000 > self.timers[2] then
            self:start(2, oexpiration/1000, 1800)
            if Enchanted then
                Enchanted = nil
                SetWeaponEnchantTextureAndMsg(self.button, CastEnchant, CastTexture, 2)
            end
        end
        self.timers[2] = oexpiration/1000
        if oexpiration == 0 then
            self:stop(2)
        end
    elseif self.timers[2] > 0 then
        self:stop(2)
    end
    XiTimers.update(self, 0)
end

local function getWeapons()
	lastMhWeapon = mainHandWeapon
	lastOhWeapon = offHandWeapon
	mainHandWeapon = GetInventoryItemLink("player", 16)
	offHandWeapon = GetInventoryItemLink("player", 17)
	if mainHandWeapon then  mainHandWeapon = tonumber(select(3,string.find(mainHandWeapon, "item:(%d+):"))) else mainHandWeapon = 0 end
	if offHandWeapon then offHandWeapon = tonumber(select(3,string.find(offHandWeapon, "item:(%d+):"))) else offHandWeapon = 0 end
    TotemTimers.MainHand = mainHandWeapon
    TotemTimers.OffHand = offHandWeapon
end


local lastMaelstromCount = 0
local WeaponBuffs = {SpellNames[SpellIDs.WindfuryWeapon], SpellNames[SpellIDs.RockbiterWeapon],
    SpellNames[SpellIDs.FlametongueWeapon], SpellNames[SpellIDs.FrostbrandWeapon], SpellNames[SpellIDs.EarthlivingWeapon]}
local lastWeaponBuffCast

function TotemTimers.WeaponEvent(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _,eventtype,_,_,_,_,name,_,enchantrank,weapon = ...
		if eventtype == "ENCHANT_APPLIED" and name == playerName and enchantrank then
			getWeapons()
			CastEnchant = string.gsub(enchantrank, " %d+$", "")
            if AvailableSpells[lastWeaponBuffCast] then
                CastTexture = GetSpellTexture(lastWeaponBuffCast)
            end
            lastWeaponBuffCast = nil
			if not CastTexture then
				CastTexture = select(10,GetItemInfo(enchantrank))
				if not CastTexture then CastTexture = select(10, GetItemInfo(weapon)) end
			end
            Enchanted = true
		end
	elseif event == "UNIT_INVENTORY_CHANGED" then
		getWeapons()
		if mainHandWeapon ~= lastMhWeapon and mainHandWeapon ~= 0 then
			local enchant, texture 
			if not TotemTimers_Settings.LastMainEnchants[mainHandWeapon] then
				enchant = ""
                texture = SpellTextures[SpellIDs.RockbiterWeapon]
			else
                enchant = TotemTimers_Settings.LastMainEnchants[mainHandWeapon][1]
                texture = TotemTimers_Settings.LastMainEnchants[mainHandWeapon][2]
            end
            SetWeaponEnchantTextureAndMsg(self, enchant, texture, 1)
		end
		if offHandWeapon ~= lastOhWeapon and offHandWeapon ~= 0 then
			local enchant, texture 
			if not TotemTimers_Settings.LastOffEnchants[offHandWeapon] then
				enchant = ""
                texture = SpellTextures[SpellIDs.RockbiterWeapon]
			else
                enchant = TotemTimers_Settings.LastOffEnchants[offHandWeapon][1]
                texture = TotemTimers_Settings.LastOffEnchants[offHandWeapon][2]
            end
            SetWeaponEnchantTextureAndMsg(self, enchant, texture, 2)
        end
	elseif event == "CHARACTER_POINTS_CHANGED" or event == "PLAYER_ALIVE" or event == "PLAYER_TALENT_UPDATE" then
		TotemTimers.SetNumWeaponTimers()
        if event == "PLAYER_ALIVE" then
            Timers[8].button:UnregisterEvent("PLAYER_ALIVE")
        end
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" and select(1,...) == "player" then
        local spell = select(2, ...)
        for k,v in pairs(WeaponBuffs) do
            if v == spell then
                lastWeaponBuffCast = v
            end
        end
        local start, duration, enable = GetSpellCooldown(SpellNames[SpellIDs.RockbiterWeapon])
		if start and duration and (not self.timer.timerOnButton or self.timer.timers[1]<=0) then
            CooldownFrame_SetTimer(self.cooldown, start, duration, enable) 
        end
    elseif event == "UNIT_AURA" and select(1,...) == "player" then
        local name,_,_,count,_,duration,endtime = UnitBuff("player", SpellNames[SpellIDs.Maelstrom])
        self.bar:SetValue(count or 0)
        self.count:SetText(tostring(count or ""))
        if count == 5 and lastMaelstromCount ~= 5 then
            self.timer:PlayWarning("Maelstrom")
        end
        lastMaelstromCount = count or lastMaelstromCount
	end
end
