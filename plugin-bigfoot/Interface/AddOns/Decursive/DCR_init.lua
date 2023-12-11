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
if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then DcrFatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    return;
end

Dcr         = LibStub("AceAddon-3.0"):NewAddon("Decursive", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0");

local D = Dcr;

D.name = "Decursive";
D.version = "2.4.5-3-g6a02387";
D.author = "Archarodim";

D.L         = LibStub("AceLocale-3.0"):GetLocale("Decursive", true);

D.LC        = _G.LOCALIZED_CLASS_NAMES_MALE;


D.DcrFullyInitialized = false;

local L = D.L;
local LC = D.LC;

local BOOKTYPE_PET      = BOOKTYPE_PET;
local BOOKTYPE_SPELL    = BOOKTYPE_SPELL;




local select    = _G.select;
local pairs    = _G.pairs;
local ipairs    = _G.ipairs;
local InCombatLockdown  = _G.InCombatLockdown;



-------------------------------------------------------------------------------
-- variables {{{
-------------------------------------------------------------------------------
D.Groups_datas_are_invalid = true;
-------------------------------------------------------------------------------
-- Internal HARD settings for decursive
D.CONF = {};
D.CONF.TEXT_LIFETIME = 4.0;
D.CONF.MAX_LIVE_SLOTS = 10;
D.CONF.MACRONAME = "Decursive";
D.CONF.MACROCOMMAND = string.format("MACRO %s", D.CONF.MACRONAME);

BINDING_HEADER_DECURSIVE = "Decursive";

D.CONF.MACRO_DIAG     = "/dcrdiag";
D.CONF.MACRO_COMMAND  = "/decursive";
D.CONF.MACRO_SHOW     = "/dcrshow";
D.CONF.MACRO_HIDE     = "/dcrhide";
D.CONF.MACRO_OPTION   = "/dcroptions";
D.CONF.MACRO_RESET    = "/dcrreset";

D.CONF.MACRO_PRADD    = "/dcrpradd";
D.CONF.MACRO_PRCLEAR  = "/dcrprclear";
D.CONF.MACRO_PRLIST   = "/dcrprlist";
D.CONF.MACRO_PRSHOW   = "/dcrprshow";

D.CONF.MACRO_SKADD    = "/dcrskadd";
D.CONF.MACRO_SKCLEAR  = "/dcrskclear";
D.CONF.MACRO_SKLIST   = "/dcrsklist";
D.CONF.MACRO_SKSHOW   = "/dcrskshow";
D.CONF.MACRO_DEBUG         = "/dcrdebug";
D.CONF.MACRO_SHOW_ORDER   = "/dcrshoworder";

-- CONSTANTS

local DC = DcrC;

DC.DS = {};

local DS = DC.DS;

DC.AfflictionSound = "Interface\\AddOns\\Decursive\\Sounds\\AfflictionAlert.wav";
--DC.AfflictionSound = "Sound\\Doodad\\BellTollTribal.wav"
DC.FailedSound = "Interface\\AddOns\\Decursive\\Sounds\\FailedSpell.wav";

DC.IconON = "Interface\\AddOns\\Decursive\\iconON.tga";
DC.IconOFF = "Interface\\AddOns\\Decursive\\iconOFF.tga";

DC.CLASS_DRUID       = 'DRUID';
DC.CLASS_HUNTER      = 'HUNTER';
DC.CLASS_MAGE        = 'MAGE';
DC.CLASS_PALADIN     = 'PALADIN';
DC.CLASS_PRIEST      = 'PRIEST';
DC.CLASS_ROGUE       = 'ROGUE';
DC.CLASS_SHAMAN      = 'SHAMAN';
DC.CLASS_WARLOCK     = 'WARLOCK';
DC.CLASS_WARRIOR     = 'WARRIOR';
DC.CLASS_DEATHKNIGHT = 'DEATHKNIGHT';

DC.MyClass = "NOCLASS";
DC.MyName = "NONAME";
DC.MyGUID = "";

DC.MAGIC        = 1;
DC.ENEMYMAGIC   = 2;
DC.CURSE        = 4;
DC.POISON       = 8;
DC.DISEASE      = 16;
DC.CHARMED      = 32;
DC.NOTYPE       = 64;


DC.NORMAL                   = 8;
DC.ABSENT                   = 16;
DC.FAR                      = 32;
DC.STEALTHED                = 64;
DC.BLACKLISTED              = 128;
DC.AFFLICTED                = 256;
DC.AFFLICTED_NIR            = 512;
DC.CHARMED_STATUS           = 1024;
DC.AFFLICTED_AND_CHARMED = bit.bor(DC.AFFLICTED, DC.CHARMED_STATUS);

DC.MFSIZE = 20;

-- This value is returned by UnitName when the name of a unit is not available yet
DC.UNKNOWN = UNKNOWNOBJECT;

-- Get the translation for "pet"
DC.PET = SPELL_TARGET_TYPE8_DESC;

-- Holder for 'Rank #' translation
DC.RANKNUMTRANS = false;

DC.DebuffHistoryLength = 40; -- we use a rather high value to avoid garbage creation

DC.DevVersionExpired = false;


D.DebuffHistory = {};

D.MFContainer = false;
D.LLContainer = false;

D.profile = {};
D.classprofile = {};

D.Status = {};

D.Status.CuringSpells = {};
D.Status.CuringSpellsPrio = {};
D.Status.DelayedFunctionCalls = {};
D.Status.DelayedFunctionCallsCount = 0;

D.Status.Blacklisted_Array = {};
D.Status.UnitNum = 0;

D.Status.PrioChanged = true;

D.Status.last_focus_GUID = false;
D.Status.UpdateCooldown = 0;

D.Status.GroupUpdatedOn = 0;
D.Status.GroupUpdateEvent = 0;

-- An acces the debuff table
D.ManagedDebuffUnitCache = {};
-- A table UnitID=>IsDebuffed (boolean)
D.UnitDebuffed = {};

D.DebugTextTable    = Dcr_DebugTextTable;

-- // }}}
-------------------------------------------------------------------------------


-- D.Initialized = false;
-------------------------------------------------------------------------------

-- add support for FuBar
D.independentProfile    = true; -- for Fubar
D.hasIcon               = DC.IconOFF;
D.hasNoColor            = true;
D.overrideMenu          = true;
D.defaultMinimapPosition = 250;
D.hideWithoutStandby    = true;
D.defaultPosition       = "LEFT";
D.hideMenuTitle         = true;

local AddDebugText = Dcr_AddDebugText;
function D:AddDebugText(a1, ...)
    AddDebugText(a1, ...);
end

function D:BetaWarning()

    local alpha = false;
    --@alpha@
    alpha = true;
    --@end-alpha@

    if (("2.4.5-3-g6a02387"):lower()):find("beta") or ("2.4.5-3-g6a02387"):find("RC") or alpha then

        -- check for expiration of this dev version
        if D.VersionTimeStamp ~= 0 then

            local VersionLifeTime  = 3600 * 24 * 10; -- 10 days

            if time() > D.VersionTimeStamp + VersionLifeTime then
--                DC.DevVersionExpired = true;
--                StaticPopup_Show ("Decursive_Notice_Frame", "|cff00ff00Decursive version: 2.4.5-3-g6a02387|r\n\n" .. "|cFFFFAA66" .. L["DEV_VERSION_EXPIRED"] .. "|r");
                return;
            end

        end

        if self.db.global.NonRealease ~= "2.4.5-3-g6a02387" then
            self.db.global.NonRealease = "2.4.5-3-g6a02387";
            StaticPopup_Show ("Decursive_Notice_Frame", "|cff00ff00Decursive version: 2.4.5-3-g6a02387|r\n\n" .. "|cFFFFAA66" .. L["DEV_VERSION_ALERT"] .. "|r");
        end
    end


end

function D:OnInitialize() -- Called on ADDON_LOADED -- {{{

    if DecursiveSelfDiagnostic() == 2 then
        return false;
    end

    DcrHookErrorHandler();

    D.defaults = D:GetDefaultsSettings();

    self.db = LibStub("AceDB-3.0"):New("DecursiveDB", D.defaults, true);

    self.db.RegisterCallback(self, "OnProfileChanged", "SetConfiguration")
    self.db.RegisterCallback(self, "OnProfileCopied", "SetConfiguration")
    self.db.RegisterCallback(self, "OnProfileReset", "SetConfiguration")

    D:ExportOptions ();
    
    -- Create some useful cache tables
    D:CreateClassColorTables();


    D.MFContainer = DcrMUFsContainer;
    D.MicroUnitF.Frame = D.MFContainer;


    D.LLContainer = DcrLiveList;
    D.LiveList.Frame = DcrLiveList;


    --[=[
    D.DewDrop:Register(DecursiveMainBar,
    'children', function()
        D.DewDrop:FeedAceOptionsTable( D.options )
    end
    )
    D.Waterfall:Register("Decursive","aceOptions", D.options, 'title',  L["STR_OPTIONS"],  "colorR", 0.1, "colorG", 0.1, "colorB", 0.3);
    --]=]

    DC.TypeNames = {
        [DC.MAGIC]      = "Magic";
        [DC.ENEMYMAGIC] = "Magic";
        [DC.CURSE]      = "Curse";
        [DC.POISON]     = "Poison";
        [DC.DISEASE]    = "Disease";
        [DC.CHARMED]    = "Charm";
    }

    DC.NameToTypes = D:tReverse(DC.TypeNames);
    DC.NameToTypes["Magic"] = DC.MAGIC; -- make sure 'Magic' is set to DC.MAGIC and not to DC.ENEMYMAGIC

    DC.TypeColors = {
        [DC.MAGIC]      = "2222DD";
        [DC.ENEMYMAGIC] = "2222FF";
        [DC.CURSE]      = "DD22DD";
        [DC.POISON]     = "22DD22";
        [DC.DISEASE]    = "995533";
        [DC.CHARMED]    = "FF0000";
        [DC.NOTYPE]     = "AAAAAA";
    }



    -- /script DcrC.SpellsToUse[DcrC.DS["Dampen Magic"]] = {Types = {DcrC.MAGIC, DcrC.DISEASE, DcrC.POISON},IsBest = false}; Dcr:Configure();
    -- /script DcrC.SpellsToUse[DcrC.DS["SPELL_POLYMORPH"]] = {  Types = {DcrC.CHARMED}, IsBest = false, Pet = false, Rank = "1 : Pig"}; Dcr:Configure();

    -- SPELL TABLE -- must be parsed after localisation is loaded {{{
    DC.SpellsToUse = {

        --Mages
        [DS["SPELL_POLYMORPH"]]     = {
            Types = {DC.CHARMED},
            IsBest = false,
            Pet = false,
            Rank = 1,
        },
        -- Druids
        [DS["SPELL_CYCLONE"]]       = {
            Types = {DC.CHARMED},
            IsBest = false,
            Pet = false,
        },
        --[[
        -- used for testing only
        [DS["Dampen Magic"] ]       = {
        Types = {DC.MAGIC},--, DC.DISEASE, DC.POISON},
        IsBest = false,
        Pet = false,
        }, --]]
        --[[
        -- used for testing only
        [DS["Amplify Magic"] ]      = {
            Types = {DC.DISEASE, DC.POISON},
            IsBest = false,
            Pet = false,
        }, --]]
        [DS["SPELL_ABOLISH_DISEASE"]]       = {
            Types = {DC.DISEASE},
            IsBest = true,
            Pet = false,

            EnhancedBy = DS["TALENT_BODY_AND_SOUL"],
            EnhancedByCheck = function ()
                return (select(5, GetTalentInfo(2,20))) > 0;
            end,
            Enhancements = {
                Types = {DC.DISEASE, DC.POISON},
                OnPlayerOnly = {
                    [DC.DISEASE] = false,
                    [DC.POISON]  = true,
                },
            }
        },
        [DS["SPELL_CURE_DISEASE"]]          = {
            Types = {DC.DISEASE},
            IsBest = false,
            Pet = false,
        },
        -- paladins
        [DS["SPELL_CLEANSE"]]               = {
            Types = {DC.MAGIC, DC.DISEASE, DC.POISON},
            IsBest = true,
            Pet = false,
        },
        [DS["SPELL_PURIFY"]]                = {
            Types = {DC.DISEASE, DC.POISON},
            IsBest = false,
            Pet = false,
        },
        -- Priests
        [DS["SPELL_DISPELL_MAGIC"]]         = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            IsBest = true,
            Pet = false,
        },
        -- Druids
        [DS["SPELL_ABOLISH_POISON"]]        = {
            Types = {DC.POISON},
            IsBest = true,
            Pet = false,
        },
        [DS["SPELL_CURE_POISON"]]           = {
            Types = {DC.POISON},
            IsBest = false,
            Pet = false,
        },
        [DS["SPELL_CURE_TOXINS"]]           = {
            Types = {DC.POISON, DC.DISEASE},
            IsBest = false,
            Pet = false,
        },
        -- mages
        [DS["SPELL_REMOVE_LESSER_CURSE"]]   = {
            Types = {DC.CURSE},
            IsBest = true,
            Pet = false,
        },
        -- druids and mages
        [DS["SPELL_REMOVE_CURSE"]]          = {
            Types = {DC.CURSE},
            IsBest = true,
            Pet = false,

            --[===[ for testing purpose only
            EnhancedBy = DS["TALENT_ARCANE_POWER"], 
            EnhancedByCheck = function ()
                return (select(5, GetTalentInfo(1,1))) > 0;
            end,
            Enhancements = {
                Types = {DC.CURSE, DC.MAGIC},
                OnPlayerOnly = {
                    [DC.CURSE] = false,
                    [DC.MAGIC]  = true,
                },
            }
            --]===]

        },
        --[=[ -- disabled because of Korean locals... see below
        [DS["SPELL_PURGE"]]                 = {
            Types = {DC.ENEMYMAGIC},
            IsBest = true,
            Pet = false,
        },
        --]=]

        -- HUNTERS http://www.wowhead.com/?spell=19801
        [DS["SPELL_TRANQUILIZING_SHOT"]]    = {
            Types = {DC.ENEMYMAGIC},
            IsBest = true,
            Pet = false,
        },
        
        -- SHAMAN http://www.wowhead.com/?spell=51514
        [DS["SPELL_HEX"]]    = {
            Types = {DC.CHARMED},
            IsBest = true,
            Pet = false,
        },

        [DS["PET_FEL_CAST"]]                = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            IsBest = true,
            Pet = true,
        },
        [DS["PET_DOOM_CAST"]]               = {
            Types = {DC.MAGIC, DC.ENEMYMAGIC},
            IsBest = true,
            Pet = true,
        },
        [DS["CLEANSE_SPIRIT"]]              = {
            Types = {DC.CURSE, DC.DISEASE, DC.POISON},
            IsBest = true,
            Pet = false,
        },

    };


    -- Thanks to Korean localization team of WoW we have to make an exception....
    -- They found the way to call two different spells the same (Shaman PURGE and Paladin CLEANSE... (both are called "정화") )
    if ((select(2, UnitClass("player"))) == "SHAMAN") then
        DC.SpellsToUse[DS["SPELL_PURGE"]]                   = {
            Types = {DC.ENEMYMAGIC},
            IsBest = true,
            Pet = false,
        };
    end

    --[=[ this exception is no longer required since Consume magic no longer exists: http://www.wowwiki.com/Consume_Magic
    -- Thanks to Chinese localization team of WoW we have to make anOTHER exception.... ://///
    -- They found the way to call two different spells the same (Devour Magic and Consume Magic... (both are called "&#21534;&#22124;&#39764;&#27861;" )
    if ((select(2, UnitClass("player"))) == "PRIEST") then
        DC.SpellsToUse[DS["PET_FEL_CAST"]] = nil; -- so we remove PET_FEL_CAST.
    end
    --]=]

    -- // }}}

end -- // }}}

local FirstEnable = true;
function D:OnEnable() -- called after PLAYER_LOGIN -- {{{

    if DecursiveSelfDiagnostic() == 2 then
        return false;
    end


    -- Register slashes command {{{
    if (FirstEnable) then
        SLASH_DECURSIVEDIAG1 = D.CONF.MACRO_DIAG;
        SlashCmdList["DECURSIVEDIAG"] = function(msg)
            DecursiveSelfDiagnostic(true, true);
        end

        SLASH_DECURSIVEPRADD1 = D.CONF.MACRO_PRADD;
        SlashCmdList["DECURSIVEPRADD"] = function(msg)
            D:AddTargetToPriorityList();
        end
        SLASH_DECURSIVEPRCLEAR1 = D.CONF.MACRO_PRCLEAR;
        SlashCmdList["DECURSIVEPRCLEAR"] = function(msg)
            D:ClearPriorityList();
        end

        SLASH_DECURSIVEPRSHOW1 = D.CONF.MACRO_PRSHOW;
        SlashCmdList["DECURSIVEPRSHOW"] = function(msg)
            D:ShowHidePriorityListUI();
        end

        SLASH_DECURSIVESKADD1 = D.CONF.MACRO_SKADD;
        SlashCmdList["DECURSIVESKADD"] = function(msg)
            D:AddTargetToSkipList();
        end
        SLASH_DECURSIVESKCLEAR1 = D.CONF.MACRO_SKCLEAR;
        SlashCmdList["DECURSIVESKCLEAR"] = function(msg)
            D:ClearSkipList();
        end

        SLASH_DECURSIVESKSHOW1 = D.CONF.MACRO_SKSHOW;
        SlashCmdList["DECURSIVESKSHOW"] = function(msg)
            D:ShowHideSkipListUI();
        end

        SLASH_DECURSIVESHOW1 = D.CONF.MACRO_SHOW;
        SlashCmdList["DECURSIVESHOW"] = function(msg)
            D:HideBar(0);
        end

        SLASH_DECURSIVERESET1 = D.CONF.MACRO_RESET;
        SlashCmdList["DECURSIVERESET"] = function(msg)
            D:ResetWindow();
        end

        SLASH_DECURSIVEHIDE1 = D.CONF.MACRO_HIDE;
        SlashCmdList["DECURSIVEHIDE"] = function(msg)
            D:HideBar(1);
        end

        SLASH_DECURSIVEOPTION1 = D.CONF.MACRO_OPTION;
        SlashCmdList["DECURSIVEOPTION"] = function(msg)
            LibStub("AceConfigDialog-3.0"):Open(D.name);
        end

        SLASH_DECURSIVESHOWORDER1 = D.CONF.MACRO_SHOW_ORDER;
        SlashCmdList["DECURSIVESHOWORDER"] = function(msg)
            D:Show_Cure_Order();
        end
    end -- }}}

    D:LocalizeBindings ();

    if (FirstEnable) then
        -- configure the message frame for Decursive
        DecursiveTextFrame:SetFading(true);
        DecursiveTextFrame:SetFadeDuration(D.CONF.TEXT_LIFETIME / 3);
        DecursiveTextFrame:SetTimeVisible(D.CONF.TEXT_LIFETIME);


        -- hook the load macro thing {{{
        -- So Decursive will re-update its macro when the macro UI is closed
        D:SecureHook("ShowMacroFrame", function ()
            if not D:IsHooked(MacroPopupFrame, "Hide") then
                D:Debug("Hooking MacroPopupFrame:Hide()");
                D:SecureHook(MacroPopupFrame, "Hide", function () D:UpdateMacro(); end);
            end
        end); -- }}}



    end

    -- these events are automatically stopped when the addon is disabled by Ace

    -- Spell changes events
    self:RegisterEvent("LEARNED_SPELL_IN_TAB");
    self:RegisterEvent("SPELLS_CHANGED");
    self:RegisterEvent("PLAYER_TALENT_UPDATE");
    self:RegisterEvent("PLAYER_ALIVE");

    -- Combat detection events
    self:RegisterEvent("PLAYER_REGEN_DISABLED","EnterCombat");
    self:RegisterEvent("PLAYER_REGEN_ENABLED","LeaveCombat");

    -- Raid/Group changes events
    self:RegisterEvent("PARTY_MEMBERS_CHANGED", D.GroupChanged, D);
    self:RegisterEvent("PARTY_LEADER_CHANGED", D.GroupChanged, D);
    self:RegisterEvent("RAID_ROSTER_UPDATE", D.GroupChanged, D);
    self:RegisterEvent("PLAYER_FOCUS_CHANGED");

    -- Player pet detection event (used to find pet spells)
    self:RegisterEvent("UNIT_PET");

    self:RegisterEvent("UNIT_AURA");

    self:RegisterEvent("PLAYER_TARGET_CHANGED");
    
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

    -- used for Debugging purpose
    --self:RegisterEvent("ADDON_ACTION_FORBIDDEN","ADDON_ACTION_FORBIDDEN");
    --self:RegisterEvent("ADDON_ACTION_BLOCKED","ADDON_ACTION_BLOCKED");

    self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    self:RegisterEvent("SPELL_UPDATE_COOLDOWN");

    self:ScheduleRepeatingTimer("ScheduledTasks", 0.2);

    -- Configure specific profile dependent data
    D:SetConfiguration();

    if (FirstEnable) then
--        D:ColorPrint(0.3, 0.5, 1, L["IS_HERE_MSG"]);
--        D:ColorPrint(0.3, 0.5, 1, L["SHOW_MSG"]);

        -- schedule a reconfigure in 5 seconds
        --self:ScheduleDelayedCall("Dcr_FirstLogConfUpdate", self.ReConfigure, 5, self);
    end

    FirstEnable = false;

end -- // }}}

function D:SetConfiguration()

    if DecursiveSelfDiagnostic() == 2 then
        return false;
    end


    D.DcrFullyInitialized = false;
    D:CancelDelayedCall("Dcr_LLupdate");
    D:CancelDelayedCall("Dcr_MUFupdate");

    D.Groups_datas_are_invalid = true;
    D.Status = {};
    D.Status.FoundSpells = {};
    D.Status.PlayerOnlyTypes = {};
    D.Status.CuringSpells = {};
    D.Status.CuringSpellsPrio = {};
    D.Status.Blacklisted_Array = {};
    D.Status.UnitNum = 0;
    D.Status.DelayedFunctionCalls = {};
    D.Status.DelayedFunctionCallsCount = 0;
    D.Status.MaxConcurentUpdateDebuff = 0;
    D.Status.PrioChanged = true;
    D.Status.last_focus_GUID = false;
    D.Status.GroupUpdatedOn = 0;
    D.Status.GroupUpdateEvent = 0;
    D.Status.UpdateCooldown = 0;
    D.Status.MouseOveringMUF = false;
    

    -- if we log in and we are already fighting...
    if InCombatLockdown() then
        D.Status.Combat = true;
    end

    D.profile = D.db.profile; -- shortcut
    D.classprofile = D.db.class; -- shortcut

    if type (D.profile.OutputWindow) == "string" then
        D.Status.OutputWindow = getglobal(D.profile.OutputWindow);
    end

    D.debugging = D.db.global.debugging;
    D.debugFrame = D.Status.OutputWindow;
    D.printFrame = D.Status.OutputWindow;

    D:Debug("Loading profile datas...");

    -- some usefull constants
    DC.MyClass = (select(2, UnitClass("player")));
    DC.MyName = (self:UnitName("player"));
    DC.MyGUID = (UnitGUID("player"));

    if not DC.MyGUID then
        DC.MyGUID = "NONE";
    end

    D:Init(); -- initialize Dcr core (set frames display, scans available cleansing spells)


    D.MicroUnitF.MaxUnit = D.profile.DebuffsFrameMaxCount;


    D.Groups_datas_are_invalid = true;
    D:CreateDropDownFiltersMenu(); -- create per class filters menus


    if D.profile.MF_colors['Chronometers'] then
        D.profile.MF_colors[ "COLORCHRONOS"] = D.profile.MF_colors['Chronometers'];
        D.profile.MF_colors['Chronometers'] = nil;
    end

    D:CreateDropDownMUFcolorsMenu(); -- create MUF color configuration menus
    D.MicroUnitF:RegisterMUFcolors(D.profile.MF_colors); -- set the colors as set in the profile



    D.Status.Enabled = true;


    -- set Icon
    if not D.Status.HasSpell or D.profile.Hide_LiveList and not D.profile.ShowDebuffsFrame then
        D:SetIcon(DC.IconOFF);
    else
        D:SetIcon(DC.IconON);
    end

    -- put the updater events at the end of the init so there is no chance they could be called before everything is ready (even if LUA is not multi-threaded... just to stay logical )
    if not D.profile.Hide_LiveList then
        self:ScheduleRepeatedCall("Dcr_LLupdate", D.LiveList.Update_Display, D.profile.ScanTime, D.LiveList);
    end

    if D.profile.ShowDebuffsFrame then
        self:ScheduleRepeatedCall("Dcr_MUFupdate", self.DebuffsFrame_Update, self.profile.DebuffsFrameRefreshRate, self);
    end

    D.DcrFullyInitialized = true; -- everything should be OK
    D:ShowHideButtons(true);
    D:AutoHideShowMUFs();


    D.MicroUnitF:Delayed_MFsDisplay_Update(); -- schedule an update of the MUFs display (number of MUF)
    D.MicroUnitF:Delayed_Force_FullUpdate(); -- schedule all attributes of exixting MUF to update

    D:SetMinimapIcon();

    -- code for backward compatibility
    if     ((not next(D.profile.PrioGUIDtoNAME)) and #D.profile.PriorityList ~= 0)
        or ((not next(D.profile.SkipGUIDtoNAME)) and #D.profile.SkipList ~= 0) then
        D:ClearPriorityList();
        D:ClearSkipList();
    end

    D:GetUnitArray(); -- get the unit array
    D.MicroUnitF:ResetAllPositions (); -- reset all anchors

    D:BetaWarning();

end

function D:OnDisable() -- When the addon is disabled by Ace
    D.Status.Enabled = false;
    D.DcrFullyInitialized = false;
    
    D:SetIcon("Interface\\AddOns\\Decursive\\iconOFF.tga");

    if ( D.profile.ShowDebuffsFrame) then
        D.MFContainer:Hide();
    end

    D:CancelAllTimedCalls();

    -- the disable warning popup : {{{ -
    StaticPopupDialogs["Decursive_OnDisableWarning"] = {
        text = L["DISABLEWARNING"],
        button1 = "OK",
        OnAccept = function()
            return false;
        end,
        timeout = 0,
        whileDead = 1,
        hideOnEscape = false,
        showAlert = 1,
    }; -- }}}

    LibStub("AceConfigRegistry-3.0"):NotifyChange(D.name);
    StaticPopup_Show("Decursive_OnDisableWarning");
end




-------------------------------------------------------------------------------
-- init functions and configuration functions {{{
-------------------------------------------------------------------------------
function D:Init() --{{{

    if (D.profile.OutputWindow == nil or not D.profile.OutputWindow) then
        D.Status.OutputWindow = DEFAULT_CHAT_FRAME;
        D.profile.OutputWindow =  "DEFAULT_CHAT_FRAME";
    end
	--Terry@bf get rid of println
		--D:Println("%s %s by %s", D.name, D.version, D.author);
	--end Terry@bf
    D:Debug( "Decursive Initialization started!");


    -- SET MF FRAME AS WRITTEN IN THE CURRENT PROFILE {{{
    -- Set the scale and place the MF container correctly
    D.MFContainer:Show();
    D.MFContainer:SetScale(D.profile.DebuffsFrameElemScale);
    D.MicroUnitF:Place();

    if (D.profile.ShowDebuffsFrame) then
        D.MFContainer:Show();
    else
        D.MFContainer:Hide();
    end
    -- }}}

    -- SET THE LIVE_LIST FRAME AS WRITTEN IN THE CURRENT PROFILE {{{

        -- Set poristion and scale
    DecursiveMainBar:Show();
    DecursiveMainBar:SetScale(D.profile.LiveListScale);
    DcrLiveList:Show();
    DcrLiveList:SetScale(D.profile.LiveListScale);
    D:PlaceLL();

    if (D.profile.Hidden) then
        DecursiveMainBar:Hide();
    else
        DecursiveMainBar:Show();
    end

    -- displays frame according to the current profile
    if (D.profile.Hide_LiveList) then
        DcrLiveList:Hide();
    else
        DcrLiveList:ClearAllPoints();
        DcrLiveList:SetPoint("TOPLEFT", "DecursiveMainBar", "BOTTOMLEFT");
        DcrLiveList:Show();
    end

    -- set Alpha
    DecursiveMainBar:SetAlpha(D.profile.LiveListAlpha);
    -- }}}

    if (D.db.global.MacroBind == "NONE") then
        D.db.global.MacroBind = false;
    end


    D:ChangeTextFrameDirection(D.profile.CustomeFrameInsertBottom);


    -- Configure spells
    D:Configure();

end --}}}

function D:ReConfigure() --{{{

    if not D.Status.HasSpell then
        return;
    end

    D:Debug("|cFFFF0000D:ReConfigure was called!|r");

    local Spell, spellName;
    local GetSpellInfo = _G.GetSpellInfo;

    local Reconfigure = false;
    for spellName, Spell in pairs(DC.SpellsToUse) do
        -- Do we have that spell?
        if GetSpellInfo(spellName) then -- yes
            -- is it new?
            if not D.Status.FoundSpells[spellName] then -- yes
                Reconfigure = true;
                break;
            elseif DC.SpellsToUse[spellName].EnhancedBy then -- it's not new but there is an enhancement available...

                if  DC.SpellsToUse[spellName].EnhancedByCheck() then -- we have it now
                    if not D.Status.FoundSpells[spellName][3] then -- but not then :)
                        Reconfigure = true;
                        break;
                    end
                else -- we do no not
                    if D.Status.FoundSpells[spellName][3] then -- but we used to :'(
                        Reconfigure = true;
                        break;
                    end
                end
            end

        elseif D.Status.FoundSpells[spellName] then -- we don't have it anymore...
            Reconfigure = true;
            break;
        end
    end

    if Reconfigure == true then
        D:Debug("D:ReConfigure RECONFIGURATION!");
        D:Configure();
        return;
    end
    D:Debug("D:ReConfigure No reconfiguration required!");

end --}}}

function D:Configure() --{{{

    -- first empty out the old "spellbook"
    self.Status.HasSpell = false;


    local CuringSpells = self.Status.CuringSpells;

    CuringSpells[DC.MAGIC]      = false;
    CuringSpells[DC.ENEMYMAGIC] = false;
    CuringSpells[DC.CURSE]      = false;
    CuringSpells[DC.POISON]     = false;
    CuringSpells[DC.DISEASE]    = false;
    CuringSpells[DC.CHARMED]    = false;

    local Spell, spellName, Type, _;
    local GetSpellInfo = _G.GetSpellInfo;
    local Types = {};
    local OnPlayerOnly = false;
    local IsEnhanced = false;

    self:Debug("Configuring Decursive...");

    for spellName, Spell in pairs(DC.SpellsToUse) do
        -- Do we have that spell?
        if GetSpellInfo(spellName) then -- yes
            Types = DC.SpellsToUse[spellName].Types;
            OnPlayerOnly = false;
            IsEnhanced = false;

            -- Could it be enhanced by something (a talent for example)?
            if DC.SpellsToUse[spellName].EnhancedBy then
                --@alpha@
                self:Debug("Enhancement for ", spellName);
                --@end-alpha@
                

                if DC.SpellsToUse[spellName].EnhancedByCheck() then -- we have the enhancement
                    IsEnhanced = true;

                    Types = DC.SpellsToUse[spellName].Enhancements.Types; -- set the type to scan to the new ones

                    if DC.SpellsToUse[spellName].Enhancements.OnPlayerOnly then -- On the 'player' unit only?
                        --@alpha@
                        self:Debug("Enhancement for %s is for player only", spellName);
                        --@end-alpha@
                        OnPlayerOnly = DC.SpellsToUse[spellName].Enhancements.OnPlayerOnly;
                    end
                end
            end

            -- register it
            for _, Type in pairs (Types) do

                if not CuringSpells[Type] or not DC.SpellsToUse[ CuringSpells[Type] ].IsBest then  -- we did not already registered this spell or it's not the best spell for this type

                    self.Status.FoundSpells[spellName] = {DC.SpellsToUse[spellName].Pet, (select(2, GetSpellInfo(spellName))), IsEnhanced};
                    CuringSpells[Type] = spellName;

                    if OnPlayerOnly and OnPlayerOnly[Type] then
                        --@alpha@
                        self:Debug("Enhancement for player only for type added",Type);
                        --@end-alpha@
                        self.Status.PlayerOnlyTypes[Type] = true;
                    else
                        self.Status.PlayerOnlyTypes[Type] = false;
                    end

                    self:Debug("Spell \"%s\" (%s) registered for type %d ( %s ), PetSpell: ", spellName, D.Status.FoundSpells[spellName][2], Type, DC.TypeNames[Type], D.Status.FoundSpells[spellName][1]);
                    self.Status.HasSpell = true;
                end
            end

        end
    end



    --[[
    -- parse through the entire library...
    -- look for known cleaning spells...

    local i = 1;

    local BookType = BOOKTYPE_SPELL;
    local break_flag = false

    -- This array will be used to test if a reconfiguration is required
    D.Status.FoundSpells = {};

    while not break_flag  do
        while (true) do -- I wish there was a continue statement in LUA...
            spellName, spellRank = GetSpellName(i, BookType);
            if (not spellName) then
                if (BookType == BOOKTYPE_PET) then
                    break_flag = true;
                    break;
                end
                BookType = BOOKTYPE_PET; -- once done with our spells, search for our pet' spells
                i = 1;
                break;

            end


            if (DC.SpellsToUse[spellName]) then

                
            end

            i = i + 1
        end
    end
    --]]


    -- Verify the cure order list (if it was damaged)
    self:CheckCureOrder ();
    -- Set the appropriate priorities according to debuffs types
    self:SetCureOrder ();

    LibStub("AceConfigRegistry-3.0"):NotifyChange(D.name);

    if (not self.Status.HasSpell) then
        return;
    end







end --}}}

function D:GetSpellsTranslations(FromDIAG)
    local GetSpellInfo = _G.GetSpellInfo;
    local Spells = {
        ["SPELL_POLYMORPH"]             = {     118,                                     },
        ["SPELL_CYCLONE"]               = {     33786,                                   },
        ["SPELL_CURE_DISEASE"]          = {     528,                                     },
        ["SPELL_ABOLISH_DISEASE"]       = {     552,                                     },
        ["SPELL_PURIFY"]                = {     1152,                                    }, -- paladins
        ["SPELL_CLEANSE"]               = {     4987,                                    },
        ["SPELL_DISPELL_MAGIC"]         = {     527, 988,                                },
        ["SPELL_CURE_TOXINS"]           = {     526,                                     }, -- shamans
        ["SPELL_CURE_POISON"]           = {     8946,                                    },
        ["SPELL_ABOLISH_POISON"]        = {     2893,                                    },
        ["SPELL_REMOVE_LESSER_CURSE"]   = {     475,                                     },
        ["SPELL_REMOVE_CURSE"]          = {     2782,                                    },
        ['SPELL_TRANQUILIZING_SHOT']    = {     19801,                                   },
        ['SPELL_HEX']                   = {     51514,                                   }, -- shamans
        ["CLEANSE_SPIRIT"]              = {     51886,                                   },
        ["SPELL_PURGE"]                 = {     370, 8012,                               },
        ["PET_FEL_CAST"]                = {     19505, 19731, 19734, 19736, 27276, 27277,},
        ["PET_DOOM_CAST"]               = {     527, 988,                                },
        ["CURSEOFTONGUES"]              = {     1714, 11719,                             },
        ["DCR_LOC_SILENCE"]             = {     15487,                                   },
        ["DCR_LOC_MINDVISION"]          = {     2096, 10909,                             },
        ["DREAMLESSSLEEP"]              = {     15822,                                   },
        ["GDREAMLESSSLEEP"]             = {     24360,                                   },
        ["MDREAMLESSSLEEP"]             = {     28504,                                   },
        ["ANCIENTHYSTERIA"]             = {     19372,                                   },
        ["IGNITE"]                      = {     19659,                                   },
        ["TAINTEDMIND"]                 = {     16567,                                   },
        ["MAGMASHAKLES"]                = {     19496,                                   },
        ["CRIPLES"]                     = {     33787,                                   },
        ["DUSTCLOUD"]                   = {     26072,                                   },
        ["WIDOWSEMBRACE"]               = {     28732,                                   },
        ["SONICBURST"]                  = {     39052,                                   },
        ["DELUSIONOFJINDO"]             = {     24306,                                   },
        ["MUTATINGINJECTION"]           = {     28169,                                   },
        ['Phase Shift']                 = {     4511,                                    },
        ['Banish']                      = {     710, 18647,                              },
        ['Frost Trap Aura']             = {     13810,                                   },
        ['Arcane Blast']                = {     30451,                                   },
        ['Prowl']                       = {     5215, 6783, 9913, 24450,                 },
        ['Stealth']                     = {     1784, 1785, 1786, 1787,                  },
        ['Shadowmeld']                  = {     58984,                                   },
        ['Invisibility']                = {     66,                                      },
        ['Lesser Invisibility']         = {     7870,                                    },
        ['Ice Armor']                   = {     7302, 7320, 10219, 10220, 27124,         },
        ['Unstable Affliction']         = {     30108, 30404, 30405,                     },
        ['Dampen Magic']                = {     604,                                     },
        ['Amplify Magic']               = {     1008,                                    },
        ['TALENT_BODY_AND_SOUL']        = {     64129, 65081,                            },
        ['TALENT_ARCANE_POWER']         = {     12042,                                   }, --temp to test
        ['DARK_MATTER']                 = {     59868,                                   }, --temp to test
        --['YOGGG_DOMINATE_MIND']       = {     63042,                                   }, --temp to test
        --['STALVAN_CURSE']             = {     3105,                                    }, --temp to test
    };


    local alpha = false;
    --@alpha@
    alpha = true;
    --@end-alpha@
    local Sname, Sids, Sid, _, ok;
    ok = true;
    for Sname, Sids in pairs(Spells) do
        for _, Sid in ipairs(Sids) do

            if _ == 1 then
                DS[Sname] = (GetSpellInfo(Sid));
                if not DS[Sname] then
                    if random (1, 9000) == 1 or FromDIAG or alpha then
                        D:AddDebugText("SpellID:", Sid, "no longer exists. This was supposed to represent the spell", Sname);
                    end
                end
            elseif FromDIAG then
                if DS[Sname] ~= (GetSpellInfo(Sid)) then

                    D:AddDebugText("Spell IDs", Sids[1] , "and", Sid, "have different translations:", DS[Sname], "and", (GetSpellInfo(Sid)) );

                    D:errln("Spell IDs", Sids[1] , "and", Sid, "have different translations:", DS[Sname], "and", (GetSpellInfo(Sid)) );

                    D:errln("Please report this to ARCHARODIM+DcrReport@teaser.fr");

                    ok = false;
                elseif not DS[Sname] then

                    D:AddDebugText("SpellID:", Sid, "no longer exist. This was supposed to represent the spell", Sname);

                    D:errln("SpellID:", Sid, "no longer exists. This was supposed to represent the spell", Sname);
                end
            end

        end
    end

    -- get a 'Rank #' string exemple (workaround due to the way the
    -- polymorph spell variants are handled in WoW 2.3)

    DC.RANKNUMTRANS = (select(2, GetSpellInfo(118)));

    return ok;

end


-- Create the macro for Decursive
-- This macro will cast the first spell (priority)

-- NEW SetBindingMacro("KEY", "macroname"|macroid)
-- UPDATED name,texture,body,isLocal = GetMacroInfo(id|"name") - Now takes ID or name
-- UPDATED DeleteMacro() -- as above
-- UPDATED EditMacro() -- as above
-- UPDATED PickupMacro() -- as above
-- CreateMacro("name", icon, "body", local)


function D:UpdateMacro ()


    if D.profile.DisableMacroCreation then
        return false;
    end

    if InCombatLockdown() then
        D:AddDelayedFunctionCall (
        "UpdateMacro", self.UpdateMacro,
        self);
        return false;
    end
    D:Debug("UpdateMacro called");


    local CuringSpellsPrio  = D.Status.CuringSpellsPrio;
    local ReversedCureOrder = D.Status.ReversedCureOrder;
    local CuringSpells      = D.Status.CuringSpells;


    -- Get an ordered spell table
    local Spells = {};
    for Spell, Prio in pairs(D.Status.CuringSpellsPrio) do
        Spells[Prio] = Spell;
    end

    if (next (Spells)) then
        for i=1,4 do
            if (not Spells[i]) then
                table.insert (Spells, CuringSpells[ReversedCureOrder[1] ]);
            end
        end
    end

    local MacroParameters = {
        D.CONF.MACRONAME,
        1, -- icon index
        next(Spells) and string.format("/stopcasting\n/cast [target=mouseover,nomod,exists] %s;  [target=mouseover,exists,mod:ctrl] %s; [target=mouseover,exists,mod:shift] %s", unpack(Spells)) or "/script Dcr:Println('"..L["NOSPELL"].."')",
        0, -- per account
    };

    --D:PrintLiteral(GetMacroIndexByName(D.CONF.MACRONAME));
    if (GetMacroIndexByName(D.CONF.MACRONAME) ~= 0) then
        -- D:Debug("Macro found");
        EditMacro(D.CONF.MACRONAME, unpack(MacroParameters));
    elseif ((GetNumMacros()) < 36) then
        CreateMacro(unpack(MacroParameters));
    else
        D:errln("Too many macros exist, Decursive cannot create its macro");
        return false;
    end


    D:SetMacroKey(D.db.global.MacroBind);

    return true;

end



-- }}}

function D:SetDateAndRevision (Date, Revision)
    if not D.TextVersion then
        D.TextVersion = GetAddOnMetadata("Decursive", "Version");
        D.Revision = 0;
    end

    local Rev = tonumber((string.gsub(Revision, "%$Revision: (%d+) %$", "%1")));

    if  Rev and D.Revision < Rev then
        D.Revision = Rev;
        D.date = Date:gsub("%$Date: (.-) %$", "%1");
        D.version = string.format("%s (|cFF11CCAARevision: %d|r)", D.TextVersion, Rev);
    end
end

--D:SetDateAndRevision("$Date: 2008-09-16 00:25:13 +0200 (mar., 16 sept. 2008) $", "$Revision: 81755 $");

function D:LocalizeBindings ()

    BINDING_NAME_DCRSHOW    = L["BINDING_NAME_DCRSHOW"];
    BINDING_NAME_DCRMUFSHOWHIDE = L["BINDING_NAME_DCRMUFSHOWHIDE"];
    BINDING_NAME_DCRPRADD     = L["BINDING_NAME_DCRPRADD"];
    BINDING_NAME_DCRPRCLEAR   = L["BINDING_NAME_DCRPRCLEAR"];
    BINDING_NAME_DCRPRLIST    = L["BINDING_NAME_DCRPRLIST"];
    BINDING_NAME_DCRPRSHOW    = L["BINDING_NAME_DCRPRSHOW"];
    BINDING_NAME_DCRSKADD   = L["BINDING_NAME_DCRSKADD"];
    BINDING_NAME_DCRSKCLEAR = L["BINDING_NAME_DCRSKCLEAR"];
    BINDING_NAME_DCRSKLIST  = L["BINDING_NAME_DCRSKLIST"];
    BINDING_NAME_DCRSKSHOW  = L["BINDING_NAME_DCRSKSHOW"];
    BINDING_NAME_DCRSHOWOPTION = L["BINDING_NAME_DCRSHOWOPTION"];

end

D.Revision = "6a02387";
D.date = "2009-12-06T03:36:40Z";
D.version = "2.4.5-3-g6a02387";
do

    if D.date ~= "@project".."-date-iso@" then

        -- get a fucking table of D.date so we can get a fucking timestamp with time() because @project-timestamp@ doesn't fucking work :/ FUCK!!

        --local example =  "2008-05-01T12:34:56Z";

        local year, month, day, hour, min, sec = string.match( D.date, "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)");
        local projectDate = {["year"] = year, ["month"] = month, ["day"] = day, ["hour"] = hour, ["min"] = min, ["sec"] = sec};

        D.VersionTimeStamp = time(projectDate);
    else
        D.VersionTimeStamp = 0;
    end

end

DcrLoadedFiles["DCR_init.lua"] = "2.4.5-3-g6a02387";

-------------------------------------------------------------------------------

--[======[
TEST to see what keyword substitutions are actually working.... DAMN!!!!

Simple replacements

@file-revision@
    Turns into the current revision of the file in integer form. e.g. 1234
    Note: does not work for git
@project-revision@
    Turns into the highest revision of the entire project in integer form. e.g. 1234
    Note: does not work for git
52d30db80af01ce4f980112eb5909bc2f0b97a29
    Turns into the hash of the file in hex form. e.g. 106c634df4b3dd4691bf24e148a23e9af35165ea
    Note: does not work for svn
6a023879de0c1857f9f6d9054401377e8807f182
    Turns into the hash of the entire project in hex form. e.g. 106c634df4b3dd4691bf24e148a23e9af35165ea
    Note: does not work for svn
52d30db
    Turns into the abbreviated hash of the file in hex form. e.g. 106c63 Note: does not work for svn
6a02387
    Turns into the abbreviated hash of the entire project in hex form. e.g. 106c63
    Note: does not work for svn
Archarodim
    Turns into the last author of the file. e.g. ckknight
Archarodim
    Turns into the last author of the entire project. e.g. ckknight
2009-12-06T03:32:56Z
    Turns into the last changed date (by UTC) of the file in ISO 8601. e.g. 2008-05-01T12:34:56Z
2009-12-06T03:36:40Z
    Turns into the last changed date (by UTC) of the entire project in ISO 8601. e.g. 2008-05-01T12:34:56Z
20091206033256
    Turns into the last changed date (by UTC) of the file in a readable integer fashion. e.g. 20080501123456
20091206033640
    Turns into the last changed date (by UTC) of the entire project in a readable integer fashion. e.g. 2008050123456
@file-timestamp@
    Turns into the last changed date (by UTC) of the file in POSIX timestamp. e.g. 1209663296
@project-timestamp@
    Turns into the last changed date (by UTC) of the entire project in POSIX timestamp. e.g. 1209663296
2.4.5-3-g6a02387
    Turns into an approximate version of the project. The tag name if on a tag, otherwise it's up to the repo.
    :SVN returns something like "r1234"
    :Git returns something like "v0.1-873fc1"
    :Mercurial returns something like "r1234". 

--]======]
