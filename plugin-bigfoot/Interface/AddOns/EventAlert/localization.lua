
EA_TTIP_DOALERTSOUND = "Play a sound when an event triggers.";
EA_TTIP_ALERTSOUNDSELECT = "Choose which sound to play when an event triggers.";
EA_TTIP_LOCKFRAME = "Locks the notification frame so it cannot be moved.";
EA_TTIP_SHOWFRAME = "Toggle the showing/hiding of the notification frame on events.";
EA_TTIP_SHOWNAME = "Toggle the showing/hiding of the buff's name on events.";
EA_TTIP_SHOWFLASH = "Toggle the showing/hiding of the full screen flash on events.";
EA_TTIP_SHOWTIMER = "Toggle the showing/hiding of the remaining buff time on events.";
EA_TTIP_CHANGETIMER = "Changes the font and position of the remaining buff time.";
EA_TTIP_ICONSIZE = "Change the size of the alert icon.";
EA_TTIP_ALLOWESC = "Changes the ability to use the ESC key to close alert frames. (Note:  Requires a reload of the UI)";
EA_TTIP_ALTALERTS = "Toggle the ability for EventAlert2 to alert on alternate non-buff events.";

EA_TTIP_ICONXOFFSET = "Changes the horizontal spacing between notification frames.";
EA_TTIP_ICONYOFFSET = "Changes the vertical spacing between notification frames.";
EA_TTIP_ICONREDDEBUFF = "Changes the Icon of debuffs show in deep/light Red-color.";
EA_TTIP_ICONGREENDEBUFF = "Changes the Icon of Target's debuffs show in deep/light Green-color.";
EA_TTIP_TAR_ICONXOFFSET = "Changes the horizontal spacing with the alert frame";
EA_TTIP_TAR_ICONYOFFSET = "Changes the vertical spacing with the alert frame";
EA_TTIP_TARGET_MYDEBUFF = "Show target's debuffs that only player casts";

EA_CLASS_DK = "DEATHKNIGHT";
EA_CLASS_DRUID = "DRUID";
EA_CLASS_HUNTER = "HUNTER";
EA_CLASS_MAGE = "MAGE";
EA_CLASS_PALADIN = "PALADIN";
EA_CLASS_PRIEST = "PRIEST";
EA_CLASS_ROGUE = "ROGUE";
EA_CLASS_SHAMAN = "SHAMAN";
EA_CLASS_WARLOCK = "WARLOCK";
EA_CLASS_WARRIOR = "WARRIOR";
EA_CLASS_OTHER = "OTHER";

EA_SHOWSELF = "Show self Buff/DeBuff";
EA_SHOWTARGET = "Show target Buff/DeBuff";
EA_OPTIONS = "EventAlert2 Options";
EA_OPTIONS_Primaries = "Enable/Disable Primaries";
EA_OPTIONS_Alternates = "Enable/Disable Alternates";
EA_OPTIONS_Others = "Enable/Disable Others";
EA_OPTIONS_Target = "Enable/Disable Target's Debuff";
EA_XOPT_ICONPOSOPT = "Icon Position Options";
EA_XOPT_SHOW_ALTFRAME = "Show Alert Frame";
EA_XOPT_SHOW_BUFFNAME = "Show Buff Name";
EA_XOPT_SHOW_TIMER = "Show Timer";
EA_XOPT_SHOW_OMNICC = "Mimic OmniCC function";
EA_XOPT_SHOW_FULLFLASH = "Show Fullscreen Flash Alert";
EA_XOPT_PLAY_SOUNDALERT = "Play Sound Alert";
EA_XOPT_ESC_CLOSEALERT = "ESC Key Closes Alerts";
EA_XOPT_SHOW_ALTERALERT = "Enable Alternate Alerts";
EA_XOPT_SHOW_SHOWSELF = "SHOW SELF ID";
EA_XOPT_SHOW_SHOWTARGET = "SHOW TARGET ID";
EA_XOPT_SHOW_CLASSALERT = "Show/Hide Class Alerts";
EA_XOPT_SHOW_OTHERALERT = "Other Alert";
EA_XOPT_SHOW_TARGETALERT = "Target Alert";
EA_XOPT_OKAY = "Okay";

EA_XICON_LOCKFRAME = "Lock Frame";
EA_XICON_LOCKFRAMETIP = "You must unlock the alert frame in order to move it or reset it's position.";
EA_XICON_ICONSIZE = "Icon Size";
EA_XICON_LARGE = "Large";
EA_XICON_SMALL = "Small";
EA_XICON_HORSPACE = "Horizontal Spacing";
EA_XICON_VERSPACE = "Vertical Spacing";
EA_XICON_MORE = "More";
EA_XICON_LESS = "Less";
EA_XICON_REDDEBUFF = "Debuff Icon in Red";
EA_XICON_GREENDEBUFF = "Target's Debuff Icon in Green";
EA_XICON_DEEP = "Deep";
EA_XICON_LIGHT = "Light";
EA_XICON_TOGGLE_ALERTFRAME = "Show/Hide Tips frame";
EA_XICON_RESET_FRAMEPOS = "Reset Frame Position";
EA_XICON_SELF_BUFF = "Self Buff";
EA_XICON_SELF_DEBUFF = "Self Debuff";
EA_XICON_TARGET_DEBUFF = "Target Debuff";

EX_XCLSALERT_SPELL = "SpellID:";
EX_XCLSALERT_ADDSPELL = "Add";
EX_XCLSALERT_DELSPELL = "Del";

EA_XTARALERT_TARGET_MYDEBUFF = "Debuffs only player casts";

EA_XLOAD_FIRST_LOAD = "- EventAlert first load detected.\n\n\n- EventAlert is setting all settings to default.\n\n- Use /ea opt to set all settings.\n\n- And use /ea help to view command helps.";
EA_XLOAD_NEWVERSION_LOAD = "- Main updates -\n\n1. Use drag to adjust the Target's Debuff Frame.\n\n2. Reduce cpu% of the refesh frequence of the spells.";

EA_XCMD_VER = " \124cff00FFFFBy ACDACD@TW-REALM\124r version: ";
EA_XCMD_SELFLIST = " Show player Buff/Debuff: ";
EA_XCMD_TARGETLIST = " Show target Debuff: ";
EA_XCMD_AUTOADD_SELFLIST = " Auto add all player's Buff/Debuff: ";
EA_XCMD_ENVADD_SELFLIST = " Auto add all player's Buff/Debuff (non-raid): ";
EA_XCMD_DEBUG_P1 = "Spell";
EA_XCMD_DEBUG_P2 = "Spell-ID";
EA_XCMD_DEBUG_P3 = "Stack";
EA_XCMD_DEBUG_P4 = "Duration";

EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlert\124r \124cff00FF00Commands\124r(/eventalert or /ea):",
	["OPT"] = "\124cff00FF00/ea options(/ea opt)\124r - Toggle the options window on or off",
	["HELP"] = "\124cff00FF00/ea help\124r - Show advance command help.",
	["SHOW"] = {
		"\124cff00FF00/ea show [sec]\124r -",
		"Toggle the mode on or off. To list all Buffs/Debuffs which the duration is in [sec] seconds on the player.",
	},
	["SHOWT"] = {
		"\124cff00FF00/ea showtarget(/ea showt) [sec]\124r -",
		"Toggle the mode on or off. To list all Debuffs which the duration is in [sec] seconds on the target.",
	},
	["SHOWA"] = {
		"\124cff00FF00/ea showautoadd(/ea showa) [sec]\124r -",
		"Toggle the mode on or off. Automatically add all Buffs/Debuffs which the duration is in [sec](default 60) seconds on the player.",
	},
}