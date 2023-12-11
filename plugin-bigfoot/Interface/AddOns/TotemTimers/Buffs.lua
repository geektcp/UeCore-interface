-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.



local map, mapfloor = nil,nil
local mapWidth, mapHeight = 0,0

local mapdata = LibStub("LibMapData-1.0");


mapdata:RegisterCallback("MapChanged",
    function(event,mapname,mfloor,w,h)
        map = mapname
        mapfloor = mfloor
        mapWidth = w or 0
        mapHeight = h or 0
    end)

local function yards(x,y)
    return x*mapWidth,y*mapHeight
end


local playerName = UnitName("player")

local BuffNames = TotemTimers.BuffNames

-- roles: 1:melee, 2:ranged, 3:caster, 4:healer, 5:hybrid (elemental shaman)
local GroupTalents = LibStub:GetLibrary("LibGroupTalents-1.0")

local RaidNames = {}
local RaidRoles = {}
local RaidClasses = {}
local RaidRange = {[1]={},[2]={},[3]={},[4]={}}
local RaidRangeCount = {0,0,0,0}
local inRaid = false
local inParty = false
local inBattleground = false
local TotemPositions = {[1]={x=0,y=0},[2]={x=0,y=0},[3]={x=0,y=0},[4]={x=0,y=0},}
local PlayerRange = {}


local function checkRange(unit,nr,guid)
    if UnitIsDeadOrGhost(unit) then return true end
    local role = nil
    if guid then role = RaidRoles[RaidNames[guid]] end
    local totem = XiTimers.timers[nr].activeTotem
    if TotemData[totem].noRangeCheck then return true end
    if TotemData[totem].partyOnly and not UnitInParty(unit) then return true end
    if role and role ~= 0 and not TotemData[totem].needed[role] then return true end
    if TotemData[totem].hasBuff or mapWidth == 0 or mapHeight == 0 then
        -- Coordinates not available or totem gives buff, check buffs instead
        local buff = BuffNames[TotemData[totem].hasBuff]
        if buff then
            local b = UnitBuff(unit,buff)
            if not b and TotemData[totem].moreBuffs then
                for k,v in pairs(TotemData[totem].moreBuffs) do
                    if BuffNames[v] then
                        b = UnitBuff(unit, BuffNames[v]) or b
                    end
                end
            end
            return b ~= nil
        else
            -- totem gives no buff and no coords available: always return true
            return true
        end
    else
        --check range using coordinates
        local element = XiTimers.timers[nr].button.element
        local x,y = GetPlayerMapPosition(unit)
        x = x * mapWidth
        y = y * mapHeight
        local xDist = x - TotemPositions[element].x
        local yDist = y - TotemPositions[element].y
        local squareDist = xDist*xDist+yDist*yDist
        return squareDist<=900        
    end
end

local lastUnit = 0

-- only check two players per update
local function UpdatePartyRange()
    for i = 1,2 do
        lastUnit = lastUnit + 1
        if (not inRaid and lastUnit > 4) or (inRaid and lastUnit > 25) then lastUnit = 1 end
        local unit
        if inRaid then
            unit = "raid"..lastUnit
        else
            unit = "party"..lastUnit
        end
        if UnitExists(unit) then
            local guid = UnitGUID(unit)
            for nr = 1,4 do
                if XiTimers.timers[nr].timers[1] > 0 then 
                    local range = checkRange(unit,nr,guid)
                    local element = XiTimers.timers[nr].button.element
                    if (not RaidRange[element][guid]) ~= range then
                        if range then RaidRange[element][guid] = nil
                        else RaidRange[element][guid] = true end
                        RaidRangeCount[element] = 0
                        for k,v in pairs(RaidRange[element]) do
                            RaidRangeCount[element] = RaidRangeCount[element] + 1
                        end                    
                    end
                end                    
            end
        end
    end
end

local lastPlayerTotem = 0

local function UpdatePlayerRange()
    lastPlayerTotem = lastPlayerTotem + 1
    if lastPlayerTotem > 4 then lastPlayerTotem = 1 end
    if XiTimers.timers[lastPlayerTotem].timers[1] > 0 then
        local element = XiTimers.timers[lastPlayerTotem].button.element
        PlayerRange[element] = checkRange("player", lastPlayerTotem)
    end
end

local rangeFrame = CreateFrame("Frame", "TotemTimers_RangeFrame")
rangeFrame:Hide()
TotemTimers.RangeFrame = rangeFrame

local Settings

rangeFrame:SetScript("OnUpdate", function(self)
    if Settings.CheckRaidRange and (inRaid or inParty) then
        UpdatePartyRange()
    end
    if Settings.CheckPlayerRange then UpdatePlayerRange() end
end)

rangeFrame:SetScript("OnEvent", function(self)
    if GetNumRaidMembers() > 0 then inRaid = true end
    if GetNumPartyMembers() > 0 then inParty = true end
end)

rangeFrame:SetScript("OnShow", function()
    Settings = TotemTimers_Settings
end)



function TotemTimers.ResetRange(element)
    wipe(RaidRange[element])
    RaidRangeCount[element] = 0
end


function TotemTimers.LibGroupTalents_Add(self, event, guid, unit, name, realm)
    RaidNames[guid] = name
    _, RaidClasses[guid] = UnitClass(unit)
    --for i=1,4 do ResetRange(i) end
end


local Roles = {tank = 1, melee = 1, caster = 3, healer = 4}

function TotemTimers.LibGroupTalents_RoleChange(guid, unit, newrole, oldrole)
    local _,class = UnitClass(unit)
    if class == "HUNTER" then
        RaidRoles[guid] = 2
    elseif class == "SHAMAN" and newrole == "melee" then
        RaidRoles[guid] = 5
    else
        RaidRoles[guid] = Roles[newrole]
    end
end

function TotemTimers.LibGroupTalents_Remove(guid, name, realm)
    RaidNames[guid] = nil
    RaidRoles[guid] = nil
    for i=1,4 do TotemTimers.ResetRange(i) end
end

GroupTalents.RegisterCallback(TotemTimers, "LibGroupTalents_Add")
GroupTalents.RegisterCallback(TotemTimers, "LibGroupTalents_RoleChange")
GroupTalents.RegisterCallback(TotemTimers, "LibGroupTalents_Remove")


function TotemTimers.GetPlayerRange(element)
    return (TotemTimers_Settings.CheckPlayerRangen and true) or PlayerRange[element]
end

function TotemTimers.GetOutOfRange(element)
    return RaidRangeCount[element]
end

function TotemTimers.GetOutOfRangePlayers(element)
    return RaidRange[element], RaidNames, RaidClasses
end

function TotemTimers.GetRaidRoles()
    return RaidRoles, RaidClasses
end

--position of totems around player in radians, order fire,earth,water,air
local TotemOffsets = {0.7354,5.4978,3.927,2.3562,}

local sin, cos = math.sin, math.cos

function TotemTimers.SetTotemPosition(element)
   local x,y = GetPlayerMapPosition("player")
   x = x * mapWidth
   y = y * mapHeight
   local facing = GetPlayerFacing()
   local offsetX = -sin(facing+TotemOffsets[element])
   local offsetY = cos(facing+TotemOffsets[element])
   TotemPositions[element].x = x+offsetX
   TotemPositions[element].y = y+offsetY
end
