-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local SpellNames = TotemTimers.SpellNames
local AvailableSpells = TotemTimers.AvailableSpells
local FlameShockName = SpellNames[SpellIDs.FlameShock]
local LightningShieldName = SpellNames[SpellIDs.LightningShield]
local FeralSpiritName = SpellNames[SpellIDs.FeralSpirit]

local cds = {}
--local spells = {SpellNames[SpellIDs.StormStrike], SpellNames[SpellIDs.EarthShock], SpellNames[SpellIDs.LavaLash], SpellNames[SpellIDs.FlameShock]}
local maelstrom = CreateFrame("StatusBar", "TotemTimers_MaelstromBar", UIParent, "XiTimersTimerBarTemplate, SecureActionButtonTemplate")
local maelstrombutton = CreateFrame("Button", "TotemTimers_MaelstromBarButton", TotemTimers_MaelstromBar, "ActionButtonTemplate, SecureActionButtonTemplate")
local settings = nil
local playerName = UnitName("player")
local role = "melee"

local num_CD_Spells = {["melee"]=8,["ele"]=6,["heal"]=0,}
TotemTimers.num_CD_Spells = num_CD_Spells
local CD_Spells = {
    ["melee"] = {
        [1] = SpellIDs.StormStrike,
        [2] = SpellIDs.EarthShock,
        [3] = SpellIDs.LavaLash,
        [4] = SpellIDs.FireNova,
        [5] = SpellIDs.Magma,
        [6] = SpellIDs.ShamanisticRage,
        [7] = SpellIDs.WindShear,
        [8] = SpellIDs.LightningShield,
        [9] = SpellIDs.FlameShock,
        [10] = SpellIDs.FeralSpirit,
        [11] = SpellIDs.Maelstrom,
    },
    ["ele"] = {
        [1] = SpellIDs.FlameShock,
        [2] = SpellIDs.LavaBurst,
        [3] = SpellIDs.ChainLightning,
        [4] = SpellIDs.Thunderstorm,
        [5] = SpellIDs.ElementalMastery,
        [6] = SpellIDs.FireNova,
    },
    ["heal"] = {
    },
}

local function ActivateCD(self)
    XiTimers.activate(self)
end

            
function TotemTimers.CreateEnhanceCDs()
    for i = 1,8 do
        cds[i] = XiTimers:new(1)
        cds[i].events[1] = "SPELL_UPDATE_COOLDOWN"
        cds[i].dontFlash = true
        cds[i].timeStyle = "sec"
        cds[i].button.anchorframe = TotemTimers_EnhanceCDsFrame
        cds[i].button:SetAttribute("*type*", "spell")
        --cds[i].activate = ActivateCD
        cds[i].reverseAlpha = true
        --cds[i].dontAlpha = true
        cds[i].button.icons[1]:SetAlpha(1)
        cds[i].button:SetScript("OnEvent", TotemTimers.EnhanceCDEvents)
        cds[i].button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    end
    cds[8].prohibitCooldown = true
    cds[8].reverseAlpha = nil
    cds[9] = XiTimers:new(1, true)
    cds[9].button:Disable()
    cds[9].button.icons[1]:SetVertexColor(1,1,1)
    cds[10] = XiTimers:new(1,true)
    cds[10].button:Disable()
    cds[10].button.icons[1]:SetVertexColor(1,1,1)
    cds[10].hideInactive = true
    cds[10].timeStyle = "sec"
    cds[10].button:SetScript("OnEvent", TotemTimers.FeralSpiritEvent) 
    cds[10].button.cdspell = SpellNames[SpellIDs.FeralSpirit]
    cds[10].button.icons[1]:SetTexture(SpellTextures[SpellIDs.FeralSpirit])
    cds[10].events[1] = "UNIT_SPELLCAST_SUCCEEDED"
    
    maelstrom.icon = getglobal("TotemTimers_MaelstromBarIcon")
    maelstrom.background = getglobal("TotemTimers_MaelstromBarBackground")
    maelstrom.icon:SetTexture(SpellTextures[SpellIDs.Maelstrom])
    maelstrom.icon:Show()
    maelstrom.icon:SetPoint("RIGHT", maelstrom, "LEFT")
    maelstrom.background:Show()
    maelstrom.background:SetValue(1)
    maelstrom.background:SetWidth(100)
    maelstrom.background:SetStatusBarColor(1, 0, 0, 0.1)
    maelstrom:SetWidth(100)
    maelstrom:SetScript("OnEvent", TotemTimers.MaelstromEvent)
    maelstrom:SetScript("OnUpdate", TotemTimers_MaelstromBarUpdate)
    maelstrom.text = getglobal("TotemTimers_MaelstromBarTime")
    TotemTimers.maelstrom = maelstrom
    TotemTimers.maelstrombutton = maelstrombutton
    maelstrombutton:SetWidth(100)
    maelstrombutton:SetHeight(maelstrom.background:GetHeight())
    maelstrombutton:SetPoint("CENTER", maelstrom, "CENTER")
    maelstrombutton:SetNormalTexture(nil)
    maelstrombutton:SetHighlightTexture("Interface\\AddOns\\TotemTimers\\MaelstromHilight")
    maelstrombutton:SetPushedTexture("Interface\\AddOns\\TotemTimers\\MaelstromPushed")
    maelstrombutton:SetAttribute("*type*", "spell")
    maelstrombutton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    maelstrombutton:SetAttribute("*spell1", SpellNames[SpellIDs.LightningBolt])
    maelstrombutton:SetAttribute("*spell2", SpellNames[SpellIDs.ChainLightning])   

    local fs = cds[9]
    fs.button.icons[1]:SetTexture(SpellTextures[SpellIDs.FlameShock])
    fs.button.anchorframe = TotemTimers_EnhanceCDsFrame
    fs.dontAlpha = true
    fs.dontFlash = true
    fs.timeStyle = "sec"
    fs.button:SetAttribute("*type1", "spell")
    fs.button:SetAttribute("*spell1", SpellNames[SpellIDs.FlameShock])
    fs.activate = ActivateCD
    fs.button.icons[1]:SetAlpha(1)
    -- fs.reverseAlpha = true
	fs.RangeCheck = SpellNames[SpellIDs.FlameShock]
	fs.ManaCheck = SpellNames[SpellIDs.FlameShock]
    fs:SetTimerBarPos("RIGHT")
    fs.button:SetScript("OnEvent", TotemTimers.FlameShockEvent)
    fs.events[1] = "COMBAT_LOG_EVENT_UNFILTERED"
    fs.events[2] = "UNIT_AURA"
    fs.events[3] = "PLAYER_REGEN_ENABLED"
    fs.events[4] = "PLAYER_REGEN_DISABLED"
    fs:SetTimerBarPos("RIGHT")
    fs:SetTimeWidth(100)
    fs:SetBarColor(1,0.5,0)    
end

function TotemTimers.ConfigEnhanceCDs() 
    local _,_,spent1 = GetTalentTabInfo(1)
    local _,_,spent2 = GetTalentTabInfo(2)
    local _,_,spent3 = GetTalentTabInfo(3)
    if spent1 and spent2 and spent3 then
        if spent1>=spent2 and spent1>=spent3 then
            role = "ele"
        elseif spent2>=spent1 and spent2>=spent3 then
            role = "melee"
        elseif spent3>=spent1 and spent3>=spent2 then
            role = "heal"
        end
    end
    
    for i=1,10 do
        cds[i]:deactivate()
    end

    for i=1,num_CD_Spells[role] do
        cds[i].button.cdspell = SpellNames[CD_Spells[role][i]]
        cds[i].button.icons[1]:SetTexture(SpellTextures[CD_Spells[role][i]])
        cds[i].button:SetAttribute("*spell1", SpellNames[CD_Spells[role][i]])
        cds[i].RangeCheck = SpellNames[CD_Spells[role][i]]
        cds[i].ManaCheck = SpellNames[CD_Spells[role][i]]
        cds[i].button:SetScript("OnEvent", TotemTimers.EnhanceCDEvents)
    end
    
    if role == "melee" then
        local es = cds[2]
        es.button.icons[1]:SetTexture(SpellTextures[SpellIDs.EarthShock])
        es.button:SetAttribute("*spell1", SpellNames[SpellIDs.EarthShock])
        es.button:SetAttribute("*spell3", SpellNames[SpellIDs.FrostShock])
        es.button:SetAttribute("*spell2", SpellNames[SpellIDs.FlameShock])
    
        --Magma Totem Dur.
        cds[5].button:SetScript("OnEvent", TotemTimers.MagmaTotemEvent)
        cds[5].events[4] = "PLAYER_TOTEM_UPDATE"  
    end
    
    if role == "ele" then
        cds[5].update = TotemTimers.ElementalMasteryUpdate
    else
        cds[5].update = XiTimers.update
    end
    
    if role == "melee" then
        cds[8].update = TotemTimers.LightningShieldUpdate
        cds[8].events[4] = "UNIT_AURA"
        cds[8].button:SetScript("OnEvent", TotemTimers.LightningShieldEvent)
    else
        cds[8].update = TotemTimers.LightningShieldEvent
    end
    
    if role == "melee" and TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[11] and TotemTimers.AvailableTalents.Maelstrom then
        maelstrom:RegisterEvent("UNIT_AURA")
        maelstrom:RegisterEvent("PLAYER_REGEN_ENABLED")
        maelstrom:RegisterEvent("PLAYER_REGEN_DISABLED")
        maelstrom:Show()
        if not InCombatLockdown() and TotemTimers.ActiveSpecSettings.HideEnhanceCDsOOC then 
            maelstrom:Hide()
        end
    else
        maelstrom:UnregisterEvent("UNIT_AURA")
        maelstrom:UnregisterEvent("PLAYER_REGEN_ENABLED")
        maelstrom:UnregisterEvent("PLAYER_REGEN_DISABLED")
        maelstrom:Hide()
    end
    
    if AvailableSpells[SpellNames[SpellIDs.FlameShock]] and
        ((role == "melee" and TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.melee[9])
          or (role == "ele" and TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells.ele[7])) then
        cds[9]:activate()
    end
    
    for i=1,num_CD_Spells[role] do
        if TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells[role][i] and AvailableSpells[SpellNames[CD_Spells[role][TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i]]]] then
            cds[i]:activate()
        end
    end
    if role == "melee" then
        if TotemTimers.ActiveSpecSettings.EnhanceCDs_Spells[role][10] and AvailableSpells[SpellNames[SpellIDs.FeralSpirit]] then
            cds[10]:activate()
        end
    end
end

local active_cds = {}

function TotemTimers.LayoutEnhanceCDs()
    local vertdist = not (TotemTimers_Settings.TimersOnButtons or TotemTimers.ActiveSpecSettings.CDTimersOnButtons) and TotemTimers.ActiveSpecSettings.EnhanceCDsTimeHeight*1.5 or 0
    wipe(active_cds)
    for i=1,num_CD_Spells[role] do
        if cds[TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i]].active then
            table.insert(active_cds,TotemTimers.ActiveSpecSettings.EnhanceCDs_Order[role][i])
        end
    end
    for i=1,10 do 
        cds[i]:ClearAnchors()
        cds[i].button:ClearAllPoints()
    end
    maelstrom:ClearAllPoints()
    if #active_cds == 0 then
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", TotemTimers_EnhanceCDsFrame)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", TotemTimers_EnhanceCDsFrame)
        end
        if cds[10].active then
            cds[10].button:SetPoint("BOTTOM", TotemTimers_EnhanceCDsFrame)
        end
    elseif #active_cds < 5 then
        cds[active_cds[1]]:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        for i=2,#active_cds do cds[active_cds[i]]:Anchor(cds[active_cds[i-1]],"LEFT") end
        local xmove = 0
        local relpoint = "BOTTOM"
        if #active_cds == 1 then
            xmove = -(TotemTimers.ActiveSpecSettings.EnhanceCDsSize*2.5+5)
        elseif #active_cds == 2 then
            xmove = -(TotemTimers.ActiveSpecSettings.EnhanceCDsSize*1.5+5)
        elseif #active_cds == 3 then
            relpoint = "BOTTOMLEFT"
        elseif #active_cds == 4 then
            xmove = 5
        end
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", cds[active_cds[1]].button, relpoint, xmove, -vertdist-10)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", cds[active_cds[1]].button, relpoint, xmove, 0)
        end
        cds[10]:Anchor(cds[active_cds[1]], "RIGHT")
    elseif #active_cds == 5 then
        cds[active_cds[1]]:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        cds[active_cds[2]]:Anchor(cds[active_cds[1]],"LEFT")
        cds[active_cds[3]]:Anchor(cds[active_cds[1]],"TOPRIGHT", "BOTTOM", true)
        cds[active_cds[4]]:Anchor(cds[active_cds[3]], "LEFT")
        cds[active_cds[5]]:Anchor(cds[active_cds[4]],"LEFT")
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", cds[active_cds[3]].button, "BOTTOMLEFT", 0, -vertdist-10)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", cds[active_cds[3]].button, "BOTTOMLEFT", 0, 0)
        end
        cds[10]:Anchor(cds[active_cds[3]], "RIGHT")
    elseif #active_cds == 6 then
        cds[active_cds[1]]:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        cds[active_cds[2]]:Anchor(cds[active_cds[1]],"LEFT")
        cds[active_cds[3]]:Anchor(cds[active_cds[2]],"LEFT")
        cds[active_cds[5]]:Anchor(cds[active_cds[2]], "TOP", "BOTTOM")
        cds[active_cds[4]]:Anchor(cds[active_cds[5]],"RIGHT")
        cds[active_cds[6]]:Anchor(cds[active_cds[5]],"LEFT")
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", cds[active_cds[4]].button, "BOTTOMLEFT", 0, -vertdist-10)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", cds[active_cds[4]].button, "BOTTOMLEFT", 0, 0)
        end
        cds[10]:Anchor(cds[active_cds[4]], "RIGHT")
    elseif #active_cds == 7 then
        cds[active_cds[1]]:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        cds[active_cds[2]]:Anchor(cds[active_cds[1]],"LEFT")
        cds[active_cds[3]]:Anchor(cds[active_cds[2]],"LEFT")
        cds[active_cds[5]]:Anchor(cds[active_cds[2]], "TOPRIGHT", "BOTTOM", true)
        cds[active_cds[4]]:Anchor(cds[active_cds[5]],"RIGHT")
        cds[active_cds[6]]:Anchor(cds[active_cds[5]],"LEFT")
        cds[active_cds[7]]:Anchor(cds[active_cds[6]],"LEFT")
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", cds[active_cds[4]].button, "BOTTOM", 5, -vertdist-10)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", cds[active_cds[4]].button, "BOTTOM", 5, 0)
        end
        cds[10]:Anchor(cds[active_cds[4]], "RIGHT")
    elseif #active_cds == 8 then
        cds[active_cds[1]]:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        cds[active_cds[2]]:Anchor(cds[active_cds[1]],"LEFT")
        cds[active_cds[3]]:Anchor(cds[active_cds[2]],"LEFT")
        cds[active_cds[4]]:Anchor(cds[active_cds[3]],"LEFT")
        cds[active_cds[5]]:Anchor(cds[active_cds[1]], "TOP", "BOTTOM")
        cds[active_cds[6]]:Anchor(cds[active_cds[2]], "TOP", "BOTTOM")
        cds[active_cds[7]]:Anchor(cds[active_cds[3]], "TOP", "BOTTOM")
        cds[active_cds[8]]:Anchor(cds[active_cds[4]], "TOP", "BOTTOM")
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", cds[active_cds[5]].button, "BOTTOM", 5, -vertdist-10)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", cds[active_cds[5]].button, "BOTTOM", 5, 0)
        end
        cds[10]:Anchor(cds[active_cds[5]], "RIGHT")
    end
    maelstrom:SetPoint("TOPLEFT", cds[9].button, "BOTTOMRIGHT", 0, -5)
end

function TotemTimers_ActivateEnhanceCDs()
    TotemTimers.ConfigEnhanceCDs()
    TotemTimers.LayoutEnhanceCDs()
end

function TotemTimers_DeactivateEnhanceCDs()
    for k,v in pairs(cds) do
        v:deactivate()
    end
    maelstrom:UnregisterEvent("UNIT_AURA")
    maelstrom:UnregisterEvent("PLAYER_REGEN_ENABLED")
    maelstrom:UnregisterEvent("PLAYER_REGEN_DISABLED")
    maelstrom:Hide()
end

function TotemTimers.EnhanceCDEvents(self, event, ...)
    local settings = TotemTimers.ActiveSpecSettings
    if event == "SPELL_UPDATE_COOLDOWN" and AvailableSpells[self.cdspell] then 
        local start, duration, enable = GetSpellCooldown(self.cdspell)
        if (not start and not duration) or (duration <= 1.5 and not InCombatLockdown()) then
            self.timer:stop(1)					
        else
            if duration == 0 then
                self.timer:stop(1)
            elseif duration > 2 and self.timer.timers[1]<=0 then
                self.timer:start(1,start+duration-floor(GetTime()),duration)
            end
            CooldownFrame_SetTimer(self.cooldown, start, duration, enable)
        end 
    end
end


function TotemTimers.MagmaTotemEvent(self,event,...)
    local element = ...
    if event == "PLAYER_TOTEM_UPDATE" then
        if element == 1 then
            local _, totem, startTime, duration, icon = GetTotemInfo(1)
            if icon == SpellTextures[SpellIDs.Magma] and duration > 0 then
                self.timer:start(1, duration)
            elseif self.timer.timers[1] > 0 then 
                self.timer:stop(1)
            end
        end
    elseif event ~= "SPELL_UPDATE_COOLDOWN" then
        TotemTimers.EnhanceCDEvents(self,event,...)
    end
end


function TotemTimers.ElementalMasteryUpdate(self,elapsed)
    XiTimers.update(self,elapsed)
    if self.timers[1] > 0 then
        local start, duration, enable = GetSpellCooldown(self.button.cdspell)
        if (not start and not duration) then
            self:stop(1)					
        else
            if duration == 0 then
                self:stop(1)
            elseif (start+duration-floor(GetTime())) < self.timers[1]-1 then
                self.timers[1] = start+duration-floor(GetTime())
            end
        end
    end        
end


function TotemTimers.LightningShieldEvent(self, event, ...)
	if event == "UNIT_AURA" and select(1,...) =="player" then
		local name,_,texture,count,_,duration,endtime = UnitAura("player", LightningShieldName)

		if name then
			self.timer:start(1, count, 9)
            --self.timer.expirationMsgs[1] = TotemTimers_Settings.ShieldMsg and string.format(L["Shield removed"], name) or nil
			--self.timer.earlyExpirationMsgs[1] = TotemTimers_Settings.ShieldMsg and string.format(L["Shield removed"], name) or nil
		elseif self.timer.timers[1]>0 then
			self.timer:stop(1)
		end
	elseif event ~= "SPELL_UPDATE_COOLDOWN" then
        TotemTimers.EnhanceCDEvents(self,event,...)
    end
end

function TotemTimers.LightningShieldUpdate(self, elapsed)
end


local AuraGUID = nil
local FSEv, FSSource, FSTarget, FSSpell, FSBuffType = nil

function TotemTimers.FlameShockEvent(self,event,...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        _, FSEv, _, FSSource, _, FSTarget, _, _, _, FSSpell, _, FSBuffType = ...
        if FSEv == "SPELL_DAMAGE" then
            if FSSource == playerName and FSSpell == FlameShockName then
                AuraGUID = FSTarget
            end
        elseif FSEv == "UNIT_DIED" then
            if AuraGUID and FSTarget == AuraGUID then
                self.timer:stop(1)
                AuraGUID = nil
            end
        end
    elseif event == "UNIT_AURA" then
        local unit = ...
        if (unit == "target" or unit == "focus") and UnitGUID(unit) == AuraGUID then
            local name = 1
            local duration = 0
            local source = ""
            local i = 0
            while (name) and i<40 do
                i = i+1
                name,_,_,_,_,duration,expires,source = UnitDebuff(unit, i)
                if name == FlameShockName and duration and source == "player" then
                    self.timer:start(1,-1*GetTime()+expires,duration)
                    break
                end
            end
            if not name then
                self.timer:stop(1)
            end
        end
    end
end


function TotemTimers.FeralSpiritEvent(self,event,unit, spell)
    if event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" and spell == FeralSpiritName then
        self.timer:start(1,45)
    end
end


local maelstromname = SpellNames[SpellIDs.Maelstrom]

function TotemTimers.MaelstromEvent(self, event, unit) 
    if event == "UNIT_AURA" and unit == "player"  then
        local name,_,_,count,_,duration,endtime = UnitBuff("player", maelstromname)
        self:SetValue(count or 0)
        self.text:SetText(tostring(count or ""))
        self.count = count
        if count then
            self:SetStatusBarColor(5-count, -0.33+count*0.33, 0, 1.0)
            self.background:SetStatusBarColor(1-count*0.2, count*0.2, 0, 0.1)
        else
            self:SetStatusBarColor(1, 0, 0, 1.0)
            self.background:SetStatusBarColor(1, 0, 0, 0.1)
        end
	elseif event == "PLAYER_REGEN_ENABLED" then
        if TotemTimers.ActiveSpecSettings.HideEnhanceCDsOOC then
            self:Hide()
        end
        self:SetAlpha(TotemTimers.ActiveSpecSettings.EnhanceCDsOOCAlpha)
    elseif event == "PLAYER_REGEN_DISABLED" then
        if not self:IsVisible() then
            self:Show()
        end
       self:SetAlpha(1)
    end
end

function TotemTimers_MaelstromBarUpdate(self, ...)
    if self.count == 5 then
        self:SetStatusBarColor(1-BuffFrame.BuffAlphaValue, BuffFrame.BuffAlphaValue, 0, 1)
    end
end
