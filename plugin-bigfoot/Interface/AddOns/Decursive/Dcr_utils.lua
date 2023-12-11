--[[
    This file is part of Decursive.
    
    Decursive (v 2.4.5-3-g6a02387) add-on for World of Warcraft UI
    Copyright (C) 2006-2007-2008-2009 John Wellesz (archarodim AT teaser.fr) ( http://www.2072productions.com/to/decursive.php )

    Starting from 2009-10-31 and until said otherwise by its author, Decursive
    is no longer free software, all rights are reserved to its author (John Wellesz).

    The only official and allowed distribution means are www.2072productions.com, www.wowace.com and curse.com.
    To distribute Decursive through other means a special authorization is required.
    

    Decursive is inspired from the original "Decursive v1.9.4" by Quu.
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY.
--]]
-------------------------------------------------------------------------------

-- big ugly scary fatal error message display function {{{
if not DcrFatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    }; -- }}}
DcrFatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not DcrLoadedFiles or not DcrLoadedFiles["Dcr_LDB.lua"] then
    if not DcrCorrupted then DcrFatalError("Decursive installation is corrupted! (Dcr_LDB.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

local D = Dcr;
--D:SetDateAndRevision("$Date: 2008-09-16 00:48:59 +0200 (mar., 16 sept. 2008) $", "$Revision: 81756 $");

local L = D.L;
local LC = D.LC;
local DC = DcrC;
local DS = DC.DS;

local pairs             = _G.pairs;
local ipairs            = _G.ipairs;
local type              = _G.type;
local unpack            = _G.unpack;
local select            = _G.select;
local str_sub           = _G.string.sub;
local str_upper         = _G.string.upper;
local str_lower         = _G.string.lower;
local str_format        = _G.string.format;
local table             = _G.table;
local t_remove          = _G.table.remove;
local t_insert          = _G.table.insert;
local UnitName          = _G.UnitName;
local UnitIsPlayer      = _G.UnitIsPlayer;
local string            = _G.string;
local tonumber          = _G.tonumber;
local UnitGUID          = _G.UnitGUID;
local band              = _G.bit.band;
local GetTime           = _G.GetTime;


function D:ColorText (text, color) --{{{
    return "|c".. color .. text .. "|r";
end --}}}

function D:RemoveColor (text)
    return str_sub(text, 11, -3);
end

function D:MakePlayerName (name) --{{{
    if not name then name = "NONAME" end
    return "|cFFFFAA22|Hplayer:" .. name .. "|h" .. str_upper(name) .. "|h|r";
end --}}}

function D:UnitIsPet (Unit)
    local GUID = UnitGUID(Unit);

    if not GUID then return end

    if band(tonumber(GUID:sub(0,5), 16), 0x00f)==0x004 then
        return true;
    end
    return false;

end

function D:PetUnitName (Unit, Check) -- {{{
    local Name = (self:UnitName(Unit));

    if not Name or Name == DC.UNKNOWN  then
        Name = DC.UNKNOWN .. "-" .. Unit;
        D:Debug("PetUnitName(): Name of %s is unknown", Unit);
    end

    if not Check or (self:UnitIsPet(Unit)) then
        Name =  ("%s-%s"):format (DC.PET,Name);
    end
    
    return Name;

end -- }}}

function D:UnitName(Unit)
    local name, server = UnitName(Unit);
        if ( server and server ~= "" ) then
            return name.."-"..server;
        else
            return name;
        end 
end

local function isFormattedString(string)
    return type(string)=='string' and (string:find("%%[cdEefgGiouXxsq]")) or false;
end

local function UseFormatIfPresent(...)
    if not isFormattedString((select(1,...))) then
        return ...;
    else
        return (select(1,...)):format(select(2, ...));
    end
end

Dcr.UseFormatIfPresent = UseFormatIfPresent;

local function debugStyle(...)
    return "|cFF00AAAADebug:|r", ...;
end

function D:Println( ... ) --{{{

    if D.profile.Print_ChatFrame then
        self:Print(D.Status.OutputWindow, UseFormatIfPresent(...));
    end
    if D.profile.Print_CustomFrame then
        self:Print(DecursiveTextFrame, UseFormatIfPresent(...));
    end
end --}}}

function D:ColorPrint (r,g,b, ... ) --XXX

    local datas = {UseFormatIfPresent(...)};

    local ColorHeader = ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255);

    t_insert(datas, 1, ColorHeader);
    t_insert(datas, #datas + 1, "|r");

    if D.profile.Print_ChatFrame then
        self:Print(D.Status.OutputWindow, ColorHeader, unpack(datas));
    end

    if D.profile.Print_CustomFrame then
        self:Print(DecursiveTextFrame, ColorHeader, unpack(datas));
    end
    
end

function D:errln( ... ) --{{{
    if D.profile.Print_Error then
        self:ColorPrint(1,0,0,...);
        
    end
end --}}}


function D:Debug(...)
    if self.debugging then
        self:Print(debugStyle(UseFormatIfPresent(...)));
    end
end


function D:tremovebyval(tab, val) -- {{{
    local k;
    local v;
    for k,v in pairs(tab) do
        if(v==val) then
            t_remove(tab, k);
            return true;
        end
    end
    return false;
end -- }}}

function D:tcheckforval(tab, val) -- {{{
    local k;
    local v;
    if (tab) then
        for k,v in pairs(tab) do
            if(v==val) then
                return true;
            end
        end
    end
    return false;
end -- }}}

-- tcopy: recursively copy contents of one table to another
function D:tcopy(to, from)   -- "to" must be a table (possibly empty)
    if (type(from) ~= "table") then 
        return error(("D:tcopy: bad argument #2 'from' must be a table, got '%s' instead"):format(type(from)),2);
    end

    if (type(to) ~= "table") then 
        return error(("D:tcopy: bad argument #1 'to' must be a table, got '%s' instead"):format(type(to)),2);
    end
    for k,v in pairs(from) do
        if(type(v)=="table") then
            to[k] = {}; -- this generate garbage
            D:tcopy(to[k], v);
        else
            to[k] = v;
        end
    end
end


function D:tGiveValueIndex(tab, val)
    local k;
    local v;
    for k,v in pairs(tab) do
        if(v==val) then
            return k;
        end
    end
    return false;
end

function D:tSortUsingKeys(tab)
    local SortedTable = {};
    local Keys = {};

    -- store all the keys in a table
    for k,v in pairs(tab) do
        t_insert(Keys, k);
    end

    -- sort the table
    table.sort(Keys);

    -- we now have a sorted table containing the keys
    for pos, k in pairs(Keys) do
        -- insert the values in a new table using the position of each key
        t_insert(SortedTable, pos, tab[k]);
    end

    -- we return a new sorted table with new keys but with the same values
    return SortedTable;
end

function D:tReverse(tab)
    local ReversedTable = {};

    for k,v in pairs(tab) do
        ReversedTable[v] = k;
    end

    return ReversedTable;
end

function D:Pack(...)
    local args = {};
    for i=1,select("#",...), 1 do
        args[i]=select(i, ...);
    end
    return args;
end


function D:ThisSetText(text) --{{{
    getglobal(this:GetName().."Text"):SetText(text);
end --}}}

function D:ThisSetParentText(text) --{{{
    getglobal(this:GetParent():GetName().."Text"):SetText(text);
end --}}}

do
local DefaultAnchorTab = {"ANCHOR_LEFT"};
    function D:DisplayTooltip(Message, RelativeTo, AnchorTab) --{{{
        if (not AnchorTab) then
            AnchorTab = DefaultAnchorTab;
        end
        DcrDisplay_Tooltip:SetOwner(RelativeTo, unpack(AnchorTab));
        DcrDisplay_Tooltip:ClearLines();
        DcrDisplay_Tooltip:SetText(Message);
        DcrDisplay_Tooltip:Show();
    end --}}}
end

function D:DisplayGameTooltip(Message) --{{{
    GameTooltip_SetDefaultAnchor(GameTooltip, this);
    GameTooltip:SetText(Message);
    GameTooltip:Show();
end --}}}



function D:NumToHexColor(ColorTable)
        return str_format("%02x%02x%02x%02x", ColorTable[4] * 255, ColorTable[1] * 255, ColorTable[2] * 255, ColorTable[3] * 255)
end

-- function taken from http://www.wowwiki.com/SetTexCoord_Transformations
function D:SetCoords(t, A, B, C, D, E, F)
        local det = A*E - B*D;
        local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
        
        ULx, ULy = ( B*F - C*E ) / det, ( -(A*F) + C*D ) / det;
        LLx, LLy = ( -B + B*F - C*E ) / det, ( A - A*F + C*D ) / det;
        URx, URy = ( E + B*F - C*E ) / det, ( -D - A*F + C*D ) / det;
        LRx, LRy = ( E - B + B*F - C*E ) / det, ( -D + A -(A*F) + C*D ) / det;
        
        t:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

do

    DC.ClassesColors = { };

    function D:GetClassColor (EnglishClass)
        if not DC.ClassesColors[EnglishClass] then
            if RAID_CLASS_COLORS and RAID_CLASS_COLORS[EnglishClass] then
                DC.ClassesColors[EnglishClass] = { RAID_CLASS_COLORS[EnglishClass].r, RAID_CLASS_COLORS[EnglishClass].g, RAID_CLASS_COLORS[EnglishClass].b };
            else
                DC.ClassesColors[EnglishClass] = { 0.63, 0.63, 0.63 };
            end
            DC.ClassesColors[LC[EnglishClass]] = DC.ClassesColors[EnglishClass];
        end
        return unpack(DC.ClassesColors[EnglishClass]);
    end

    DC.HexClassColor = { };

    function D:GetClassHexColor(EnglishClass)
        if not DC.HexClassColor[EnglishClass] then
            local r, g, b = self:GetClassColor(EnglishClass)
            DC.HexClassColor[EnglishClass] = str_format("%02x%02x%02x", r * 255, g * 255, b * 255);
            DC.HexClassColor[LC[EnglishClass]] = DC.HexClassColor[EnglishClass];

        end

        return DC.HexClassColor[EnglishClass];
    end


    function D:CreateClassColorTables ()
        if RAID_CLASS_COLORS then
            local class, colors;
            for class in pairs(RAID_CLASS_COLORS) do
                if not class:find(" ") then -- thank to a wonderful add-on that adds the wrong translation "Death Knight" to the global RAID_CLASS_COLORS....
                    D:GetClassHexColor(class);
                    D:GetClassColor(class);
                else
                    RAID_CLASS_COLORS[class] = nil; -- Eat that!
                end
            end
        else
            D:AddDebugText("global RAID_CLASS_COLORS does not exist...");
            D:Error("global RAID_CLASS_COLORS does not exist...");
        end
    end

end

function D:MakeError(something)
    local testlocal = "test local";
   
    testErrorCapturing(testlocal);
end

function D:NiceTime()
    return tonumber(("%.4f"):format(GetTime() - DC.StartTime));
end

local DcrTimers = {};
function D:TimerExixts(RefName)
    return DcrTimers[RefName] and DcrTimers[RefName][1] or false;
end

function D:DelayedCallExixts(RefName)
    return DcrTimers[RefName] and DcrTimers[RefName][1] or false;
end

local ObjectWithArgs = {["obj"]=false, ["arg"]=false,};
function D:ScheduleDelayedCall(RefName, FunctionRef, Delay, arg1, ...)

    if DcrTimers[RefName] and DcrTimers[RefName][1] then
        self:CancelTimer(DcrTimers[RefName][1]);
    end

    if not DcrTimers[RefName] then
        DcrTimers[RefName] = {};
    end

    if select('#', ...) > 0 then
        -- arg table
        DcrTimers[RefName][2] = {arg1};

        local i;
        for i = 1, select('#', ...) do
            DcrTimers[RefName][2][i + 1] = (select(i, ...));
        end

        DcrTimers[RefName][1] = self:ScheduleTimer (
        function(arg)
            FunctionRef(unpack(arg));
            DcrTimers[RefName][1] = false;
        end
        , Delay, DcrTimers[RefName][2]
        );
    else
        DcrTimers[RefName][1] = self:ScheduleTimer (
        function(arg)
            FunctionRef(arg);
            DcrTimers[RefName][1] = false;
        end
        , Delay, arg1
        );
    end

    return DcrTimers[RefName][1];
end

function D:ScheduleRepeatedCall(RefName, FunctionRef, Delay, arg)
    if DcrTimers[RefName] and DcrTimers[RefName][1] then
        self:CancelTimer(DcrTimers[RefName][1]);
    end

    if not DcrTimers[RefName] then
        DcrTimers[RefName] = {};
    end

    DcrTimers[RefName][1] = self:ScheduleRepeatingTimer(FunctionRef, Delay, arg);

    return DcrTimers[RefName][1];
end

function D:CancelDelayedCall(RefName)
    if DcrTimers[RefName] and DcrTimers[RefName][1] then
        local cancelHandle = DcrTimers[RefName][1];
        DcrTimers[RefName][1] = false;
        return self:CancelTimer(cancelHandle);
    end
end

function D:CancelAllTimedCalls()
    for RefName in pairs(DcrTimers) do
        self:CancelDelayedCall(RefName);
    end
end

DcrLoadedFiles["Dcr_utils.lua"] = "2.4.5-3-g6a02387";
