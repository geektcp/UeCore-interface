--{{{ Libraries

local RL -- only loaded in OnEnable when used with non-guid Grid now:    = AceLibrary("Roster-2.1")
local L = AceLibrary("AceLocale-2.2"):new("GridStatusHots")

--}}}

local playerClass, englishClass = UnitClass("player")
local playerRace, englishRace = UnitRace("player")

local spellNameCache = {};
--Druid
spellNameCache.Lifebloom = GetSpellInfo(33763);
spellNameCache.Regrowth = GetSpellInfo(8936);
spellNameCache.Rejuvenation = GetSpellInfo(774);
spellNameCache.WildGrowth = GetSpellInfo(48438);

--Paladin
spellNameCache.BeaconofLight = GetSpellInfo(53563);
spellNameCache.FlashofLight = GetSpellInfo(66922);
spellNameCache.SheathofLight = GetSpellInfo(54203);
spellNameCache.SacredShield = GetSpellInfo(53601);

--Priest
spellNameCache.Grace = GetSpellInfo(47930);
spellNameCache.PrayerofMending = GetSpellInfo(33076);
spellNameCache.Renew = GetSpellInfo(139);

--Shaman
spellNameCache.Earthliving = GetSpellInfo(51945);
spellNameCache.EarthShield = GetSpellInfo(49284);
spellNameCache.Riptide = GetSpellInfo(61295);

--Draenei
spellNameCache.GiftoftheNaaru = GetSpellInfo(28880);


GridStatusHots = GridStatus:NewModule("GridStatusHots")
GridStatusHots.menuName = L["My HoTs"];


--fix for Sacred Shield (have to use Icon)
local spellIconCache = {};
local fix_name, fix_rank, fix_icon = GetSpellInfo(53601);
spellIconCache.SacredShield = fix_icon;


GridStatusHots.extraOptions = {
	["frequency"] = {
		type = 'range',
		name = L["Refresh frequency"],
		desc = L["Seconds between status refreshes"],
		get = function() return GridStatusHots.db.profile.frequency end,
		set = function(v)
				  GridStatusHots.db.profile.frequency = v
				  GridStatusHots:UpdateFrequency()
			  end,
		min = 0.01,
		max = 1,
		step = 0.01,
		isPercent = false,
		order = -1,
	},
}


--{{{ AceDB defaults
--
GridStatusHots.defaultDB = {
	frequency = 0.5,
	alert_tothots = {
		text = L["Buff: Hot Count"],
		desc = L["Buff: Hot Count"],
		enable = true,
		lbeach = false,
		priority = 95,
		range = false,
		color = { r = 0, g = 1, b = 0, a = 1 },
	},

	--Druid
	alert_lifebl = {
		text = L["Buff: My Lifebloom"],
		desc = L["Buff: My Lifebloom"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_lifebl_stack = {
		text = L["Buff: My Lifebloom Stack Colored"],
		desc = L["Buff: My Lifebloom Stack Colored"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_regrow = {
		text = L["Buff: My Regrowth"],
		desc = L["Buff: My Regrowth"],
		enable = true,
		totshow = true,
		priority = 97,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 1, g = 1, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_rejuv = {
		text = L["Buff: My Rejuvenation"],
		desc = L["Buff: My Rejuvenation"],
		enable = true,
		totshow = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 0, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_wgrowth = {
		text = L["Buff: My Wild Growth"],
		desc = L["Buff: My Wild Growth"],
		enable = true,
		totshow = true,
		priority = 96,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g =1, b = 1, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Paladin
	alert_beacon = {
		text = L["Buff: My Beacon of Light"],
		desc = L["Buff: My Beacon of Light"],
		enable = true,
		priority = 96,
		range = false,
		threshold2 = 10,
		threshold3 = 5,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_fol = {
		text = L["Buff: My Flash of Light"],
		desc = L["Buff: My Flash of Light"],
		enable = true,
		totshow = true,
		priority = 95,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_sashield = {
		text = L["Buff: My Sacred Shield"],
		desc = L["Buff: My Sacred Shield"],
		enable = true,
		folshow = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_slight = {
		text = L["Buff: My Sheath of Light"],
		desc = L["Buff: My Sheath of Light"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Priest
	alert_gracestack = {
		text = L["Buff: My Grace Stack"],
		enable = true,
		priority = 90,
		range = false,
		color = { r = 1, g = .41, b = .28, a = 1 },
		color2 = { r = 1, g = 1, b = .52, a = 1 },
		color3 = { r = .5, g = 1, b = .23, a = 1 },
	},
	alert_gracedurstack = {
		text = L["Buff: My Grace Duration + Stack"],
		enable = true,
		priority = 90,
		range = false,
		threshold2 = 5.5,
		threshold3 = 3,
		color = { r = .5, g = 1, b = .23, a = 1 },
		color2 = { r = 1, g = 1, b = .52, a = 1 },
		color3 = { r = 1, g = .41, b = .28, a = 1 },
	},
	alert_pom = {
		text = L["Buff: My Prayer of Mending"],
		desc = L["Buff: My Prayer of Mending"],
		enable = true,
		priority = 70,
		range = false,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = .5, b = 0, a = 1 },
		color3 = { r = 1, g = 1, b = 0, a = 1 },
		color4 = { r = 0, g = 1, b = 1, a = 1 },
		color5 = { r = .5, g = 1, b = 0, a = 1 },
		color6 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_renew = {
		text = L["Buff: My Renew"],
		desc = L["Buff: My Renew"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Shaman
	alert_earthliving = {
		text = L["Buff: My Earthliving"],
		desc = L["Buff: My Earthliving"],
		enable = true,
		totshow = true,
		priority = 98,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
	alert_earthshield = {
		text = L["Buff: My Earth Shield"],
		desc = L["Buff: My Earth Shield"],
		enable = true,
		priority = 91,
		range = false,
		threshold2 = 2,
		threshold3 = 1,
		color = { r = 1, g = 0, b = 0, a = 1 },
		color2 = { r = 1, g = .5, b = 0, a = 1 },
		color3 = { r = 1, g = 1, b = 0, a = 1 },
		color4 = { r = 0, g = 1, b = 1, a = 1 },
		color5 = { r = 0, g = 1, b = 0, a = 1 },
	},
	alert_riptide = {
		text = L["Buff: My Riptide"],
		desc = L["Buff: My Riptide"],
		enable = true,
		totshow = true,
		priority = 99,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},

	--Draenei
	alert_gift = {
		text = L["Buff: My Gift of the Naaru"],
		desc = L["Buff: My Gift of the Naaru"],
		enable = true,
		totshow = true,
		priority = 91,
		range = false,
		threshold2 = 4,
		threshold3 = 2,
		color = { r = 0, g = 1, b = 0, a = 1 },
		color2 = { r = 1, g = 1, b = 0, a = 1 },
		color3 = { r = 1, g = 0, b = 0, a = 1 },
	},
}

local tothots_options = {
	["lbeach"] = {
		type = "toggle",
		name = L["Count Lifebloom as 1 HoT per stack"],
		desc = L["Check, if you want each stack of Lifebloom to count as 1 HoT"],
		get = function () return GridStatusHots.db.profile.alert_tothots.lbeach end,
		set = function (arg)
			GridStatusHots.db.profile.alert_tothots.lbeach = arg
		end,
	},
}

local renew_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_renew.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_renew.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_renew.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_renew.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_renew.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_renew.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_renew.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_renew.totshow = arg
		end,
	},
}

local rejuv_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_rejuv.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_rejuv.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_rejuv.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_rejuv.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_rejuv.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_rejuv.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_rejuv.totshow = arg
		end,
	},
}

local regrow_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_regrow.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_regrow.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_regrow.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_regrow.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_regrow.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_regrow.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_regrow.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_regrow.totshow = arg
		end,
	},
}

local lifebl_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_lifebl.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_lifebl.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_lifebl.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_lifebl.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_lifebl.totshow = arg
		end,
	},
}

local lifebl_stack_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_lifebl_stack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_lifebl_stack.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_lifebl_stack.totshow = arg
		end,
	},
}

local wgrowth_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_wgrowth.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_wgrowth.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_wgrowth.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_wgrowth.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_wgrowth.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_wgrowth.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_wgrowth.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_wgrowth.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_wgrowth.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_wgrowth.totshow = arg
		end,
	},
}

local slight_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_slight.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_slight.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_slight.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_slight.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_slight.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_slight.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_slight.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_slight.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_slight.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_slight.totshow = arg
		end,
	},
}

local sashield_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_sashield.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_sashield.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_sashield.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_sashield.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_sashield.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_sashield.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_sashield.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_sashield.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["folshow"] = {
		type = "toggle",
		name = L["Show Flash of Light - HoT"],
		desc = L["Check, if you want to see a countdown for your Flash of Light - HoT behind your Sacred Shield (i.e. 25-10)"],
		get = function () return GridStatusHots.db.profile.alert_sashield.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_sashield.totshow = arg
		end,
	},
}

local riptide_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_riptide.threshold2
			end,
		set = function (v)
			GridStatusHots.db.profile.alert_riptide.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_riptide.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_riptide.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_riptide.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_riptide.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_riptide.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_riptide.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_riptide.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_riptide.totshow = arg
		end,
	},
}

local pom_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has two charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has three charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color4"] = {
		type = "color",
		name = L["Color 4"],
		desc = L["Color when player has four charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color4
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color4
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color5"] = {
		type = "color",
		name = L["Color 5"],
		desc = L["Color when player has five charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color5
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color5
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color6"] = {
		type = "color",
		name = L["Color 6"],
		desc = L["Color when player has six charges of PoM."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_pom.color6
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_pom.color6
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local beacon_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_beacon.threshold2
			end,
		set = function (v)
			GridStatusHots.db.profile.alert_beacon.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_beacon.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_beacon.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_beacon.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_beacon.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_beacon.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_beacon.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local earthliving_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
				return GridStatusHots.db.profile.alert_earthliving.threshold2
			end,
		set = function (v)
			GridStatusHots.db.profile.alert_earthliving.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthliving.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthliving.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_earthliving.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_earthliving.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthliving.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthliving.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_earthliving.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_earthliving.totshow = arg
		end,
	},
}

local earthshield_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has 2 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has 3 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color4"] = {
		type = "color",
		name = L["Color 4"],
		desc = L["Color when player has 4 charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color4
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color4
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color5"] = {
		type = "color",
		name = L["Color 5"],
		desc = L["Color when player has 5 or more charges of Earth Shield."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_earthshield.color5
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_earthshield.color5
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gracestack_hotcolors = {
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color when player has two charges of grace."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracestack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracestack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color when player has three charges of grace."],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracestack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracestack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gracedurstack_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 7,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_gracedurstack.threshold2
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_gracedurstack.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracedurstack.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracedurstack.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 7,
		min = 1,
		step = .5,
		get = function ()
			      return GridStatusHots.db.profile.alert_gracedurstack.threshold3
		      end,
		set = function (v)
			       GridStatusHots.db.profile.alert_gracedurstack.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gracedurstack.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gracedurstack.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
}

local gift_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_gift.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_gift.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gift.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gift.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_gift.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_gift.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_gift.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_gift.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_gift.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_gift.totshow = arg
		end,
	},
}

local fol_hotcolors = {
	["threshold2"] = {
		type = "range",
		name = L["Threshold to activate color 2"],
		desc = L["Threshold to activate color 2"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_fol.threshold2
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_fol.threshold2 = v
		end,
	},
	["color2"] = {
		type = "color",
		name = L["Color 2"],
		desc = L["Color 2"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_fol.color2
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_fol.color2
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["threshold3"] = {
		type = "range",
		name = L["Threshold to activate color 3"],
		desc = L["Threshold to activate color 3"],
		max = 10,
		min = 1,
		step = .5,
		get = function ()
			return GridStatusHots.db.profile.alert_fol.threshold3
		end,
		set = function (v)
			GridStatusHots.db.profile.alert_fol.threshold3 = v
		end,
	},
	["color3"] = {
		type = "color",
		name = L["Color 3"],
		desc = L["Color 3"],
		hasAlpha = true,
		get = function ()
			local color = GridStatusHots.db.profile.alert_fol.color3
			return color.r, color.g, color.b, color.a
		end,
		set = function (r, g, b, a)
			local color = GridStatusHots.db.profile.alert_fol.color3
			color.r = r
			color.g = g
			color.b = b
			color.a = a or 1
		end,
	},
	["totshow"] = {
		type = "toggle",
		name = L["Show HoT-Counter"],
		desc = L["Check, if you want to see the total of HoTs behind the countdown of your HoT(i.e. 13-5)"],
		get = function () return GridStatusHots.db.profile.alert_fol.totshow end,
		set = function (arg)
			GridStatusHots.db.profile.alert_fol.totshow = arg
		end,
	},
}
--}}}


function GridStatusHots:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus("alert_tothots", L["Buff: Hot Count"], tothots_options)
	if englishClass == "PRIEST" then
		self:RegisterStatus("alert_renew", L["Buff: My Renew"], renew_hotcolors)
        self:RegisterStatus("alert_pom", L["Buff: My Prayer of Mending"], pom_hotcolors)
		self:RegisterStatus("alert_gracestack", L["Buff: My Grace Stack"], gracestack_hotcolors)
		self:RegisterStatus("alert_gracedurstack", L["Buff: My Grace Duration + Stack"], gracedurstack_hotcolors)
	end
	if englishClass == "DRUID" then
		self:RegisterStatus("alert_rejuv", L["Buff: My Rejuvenation"], rejuv_hotcolors)
		self:RegisterStatus("alert_regrow", L["Buff: My Regrowth"], regrow_hotcolors)
		self:RegisterStatus("alert_lifebl", L["Buff: My Lifebloom"], lifebl_hotcolors)
		self:RegisterStatus("alert_lifebl_stack", L["Buff: My Lifebloom Stack Colored"], lifebl_stack_hotcolors)
		self:RegisterStatus("alert_wgrowth", L["Buff: My Wild Growth"], wgrowth_hotcolors)
	end
	if englishClass == "PALADIN" then
		self:RegisterStatus("alert_slight", L["Buff: My Sheath of Light"], slight_hotcolors)
		self:RegisterStatus("alert_sashield", L["Buff: My Sacred Shield"], sashield_hotcolors)
		self:RegisterStatus("alert_beacon", L["Buff: My Beacon of Light"], beacon_hotcolors)
		self:RegisterStatus("alert_fol", L["Buff: My Flash of Light"], fol_hotcolors)
	end
	if englishClass == "SHAMAN" then
		self:RegisterStatus("alert_riptide", L["Buff: My Riptide"], riptide_hotcolors)
		self:RegisterStatus("alert_earthliving", L["Buff: My Earthliving"], earthliving_hotcolors)
		self:RegisterStatus("alert_earthshield", L["Buff: My Earth Shield"], earthshield_hotcolors)
	end
	if englishRace == "Draenei" then
		self:RegisterStatus("alert_gift", L["Buff: My Gift of the Naaru"], gift_hotcolors)
	end
end

function GridStatusHots:OnEnable()
	if not GridRoster then
		RL = AceLibrary("Roster-2.1")
	end
	self:ScheduleRepeatingEvent("GHS_Refresh", self.UpdateAll, GridStatusHots.db.profile.frequency, self)
end

function GridStatusHots:UpdateFrequency()
	self:CancelScheduledEvent("GHS_Refresh");
	self:ScheduleRepeatingEvent("GHS_Refresh", self.UpdateAll, GridStatusHots.db.profile.frequency, self)
end

function GridStatusHots:Reset()
	self.super.Reset(self)
end

local function updateUnit(self, gridid, unitid)
	local total_hots, lbstack, pomstack, grastack, esstack = 0, 0, 0, 0, 0;
	local retime,rjtime,rgtime,lbtime,wgtime,sltime,sstime,ritime,pomtime,boltime,eltime,estime,gratime,gifttime,foltime

	local now = GetTime()
	-- Find number of hots per unit
	for i=1,999 do
		local bname,brank,btexture,bcount,btype,bdur,bexptime,bismine = UnitBuff(unitid, i)
		if not bname then break end

		local btime = bexptime - now
		if bname == spellNameCache["Renew"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then retime = btime end
		elseif bname == spellNameCache["Regrowth"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then rgtime = btime end
		elseif bname == spellNameCache["Rejuvenation"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then rjtime = btime end
		elseif bname == spellNameCache["Lifebloom"] then
			if self.db.profile.alert_tothots.lbeach then
				total_hots = total_hots + bcount;
			else
				total_hots = total_hots + 1;
			end
			if (bismine == "player" and btime) then
				lbtime = btime
				lbstack = bcount
			end
		elseif bname == spellNameCache["WildGrowth"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then wgtime = btime end
		elseif bname == spellNameCache["SheathofLight"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then sltime = btime end
		elseif bname == spellNameCache["SacredShield"] and btexture == spellIconCache["SacredShield"] then
			if (bismine == "player" and btime) then sstime = btime end
		elseif bname == spellNameCache["Riptide"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then ritime = btime end
		elseif bname == spellNameCache["PrayerofMending"] then
			if btime then
				pomtime = btime
				pomstack = bcount
			end
		elseif bname == spellNameCache["BeaconofLight"] then
			if (bismine == "player" and btime) then boltime = btime end
		elseif bname == spellNameCache["Earthliving"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then eltime = btime end
		elseif bname == spellNameCache["EarthShield"] then
			if (bismine == "player" and btime) then
				estime = btime
				esstack = bcount
			end
		elseif bname == spellNameCache["Grace"] then
			if (bismine == "player" and btime) then
				gratime = btime
				grastack = bcount
			end
		elseif bname == spellNameCache["GiftoftheNaaru"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then gifttime = btime end
		elseif bname == spellNameCache["FlashofLight"] then
			total_hots = total_hots + 1;
			if (bismine == "player" and btime) then foltime = btime end
		end
	end

	-- Set number of hots currently running on all units
	if total_hots > 0 and self.db.profile.alert_tothots.enable then
		local settings = self.db.profile.alert_tothots
		self.core:SendStatusGained(gridid, "alert_tothots",
			settings.priority,
			(settings.range and 40),
			settings.color,
			tostring(total_hots)
		)
	else
		if self.core:GetCachedStatus(gridid, "alert_tothots") then self.core:SendStatusLost(gridid, "alert_tothots") end
	end

	--Renew
	if retime and self.db.profile.alert_renew.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_renew
		local hotcolor = settings.color
		if retime <= settings.threshold2 then hotcolor = settings.color2 end
		if retime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_renew",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(retime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_renew",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(retime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_renew") then self.core:SendStatusLost(gridid, "alert_renew") end
	end

	--Regrowth
	if rgtime and self.db.profile.alert_regrow.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_regrow
		local hotcolor = settings.color
		if rgtime <= settings.threshold2 then hotcolor = settings.color2 end
		if rgtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_regrow",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rgtime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_regrow",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rgtime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_regrow") then self.core:SendStatusLost(gridid, "alert_regrow") end
	end

	--Rejuv
	if rjtime and self.db.profile.alert_rejuv.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_rejuv
		local hotcolor = settings.color
		if rjtime <= settings.threshold2 then hotcolor = settings.color2 end
		if rjtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_rejuv",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rjtime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_rejuv",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(rjtime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_rejuv") then self.core:SendStatusLost(gridid, "alert_rejuv") end
	end

	--Lifebloom
	if lbtime and (self.db.profile.alert_lifebl_stack.enable or self.db.profile.alert_lifebl.enable) then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_lifebl_stack
		local hotcolor = settings.color
		if lbstack == 2 then hotcolor = settings.color2 end
		if lbstack == 3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_lifebl_stack",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%.1f-%d", lbtime, total_hots)
			)
		else
			self.core:SendStatusGained(gridid, "alert_lifebl_stack",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%.1f", lbtime)
			)
		end

		local settings = self.db.profile.alert_lifebl
		local hotcolor = settings.color
		if lbtime <= settings.threshold2 then hotcolor = settings.color2 end
		if lbtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_lifebl",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%.1f-%d", lbstack, lbtime, total_hots)
			)
		else
			local settings = self.db.profile.alert_lifebl
			local hotcolor = settings.color
			if lbtime <= settings.threshold2 then hotcolor = settings.color2 end
			if lbtime <= settings.threshold3 then hotcolor = settings.color3 end
			self.core:SendStatusGained(gridid, "alert_lifebl",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				string.format("%d-%.1f", lbstack, lbtime)
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_lifebl") then self.core:SendStatusLost(gridid, "alert_lifebl") end
		if self.core:GetCachedStatus(gridid, "alert_lifebl_stack") then self.core:SendStatusLost(gridid, "alert_lifebl_stack") end
	end

	--Wild Growth
	if wgtime and self.db.profile.alert_wgrowth.enable then
		local settings = self.db.profile.alert_wgrowth
		local hotcolor = settings.color
		if wgtime <= settings.threshold2 then hotcolor = settings.color2 end
		if wgtime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_wgrowth",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(wgtime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_wgrowth",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(wgtime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_wgrowth") then self.core:SendStatusLost(gridid, "alert_wgrowth") end
	end

	--Sheath of Light
	if sltime and self.db.profile.alert_slight.enable then
		local settings = self.db.profile.alert_slight
		local hotcolor = settings.color
		if sltime <= settings.threshold2 then hotcolor = settings.color2 end
		if sltime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_slight",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(sltime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_slight",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(sltime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_slight") then self.core:SendStatusLost(gridid, "alert_slight") end
	end

	--Sacred Shield
	if sstime and self.db.profile.alert_sashield.enable then
		local settings = self.db.profile.alert_sashield
		local hotcolor = settings.color
		if sstime <= settings.threshold2 then hotcolor = settings.color2 end
		if sstime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.folshow and foltime then
			self.core:SendStatusGained(gridid, "alert_sashield",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(sstime).."-"..math.floor(foltime))
			)
		else
			self.core:SendStatusGained(gridid, "alert_sashield",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(sstime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_sashield") then self.core:SendStatusLost(gridid, "alert_sashield") end
	end

	--Riptide
	if ritime and self.db.profile.alert_riptide.enable then
		local settings = self.db.profile.alert_riptide
		local hotcolor = settings.color
		if ritime <= settings.threshold2 then hotcolor = settings.color2 end
		if ritime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_riptide",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(ritime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_riptide",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(ritime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_riptide") then self.core:SendStatusLost(gridid, "alert_riptide") end
	end

	-- Earth Shield
	if estime and self.db.profile.alert_earthshield.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_earthshield
		local hotcolor = settings.color
		if esstack == 2 then hotcolor = settings.color2 end
		if esstack == 3 then hotcolor = settings.color3 end
		if esstack == 4 then hotcolor = settings.color4 end
		if esstack > 4 then hotcolor = settings.color5 end
		self.core:SendStatusGained(gridid, "alert_earthshield",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(esstack)
		)
	else
		if self.core:GetCachedStatus(gridid, "alert_earthshield") then self.core:SendStatusLost(gridid, "alert_earthshield") end
	end

	--Prayer of Mending
	if pomtime and self.db.profile.alert_pom.enable then
		local settings = self.db.profile.alert_pom
		local hotcolor = settings.color
		if pomstack == 2 then hotcolor = settings.color2 end
		if pomstack == 3 then hotcolor = settings.color3 end
		if pomstack == 4 then hotcolor = settings.color4 end
		if pomstack == 5 then hotcolor = settings.color5 end
		if pomstack == 6 then hotcolor = settings.color6 end
		self.core:SendStatusGained(gridid, "alert_pom",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(math.floor(pomtime))
		)
	else
		if self.core:GetCachedStatus(gridid, "alert_pom") then self.core:SendStatusLost(gridid, "alert_pom") end
	end

	--Beacon of Light
	if boltime and self.db.profile.alert_beacon.enable then
		local settings = self.db.profile.alert_beacon
		local hotcolor = settings.color
		if boltime <= settings.threshold2 then hotcolor = settings.color2 end
		if boltime <= settings.threshold3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(gridid, "alert_beacon",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(math.floor(boltime))
		)
	else
		if self.core:GetCachedStatus(gridid, "alert_beacon") then self.core:SendStatusLost(gridid, "alert_beacon") end
	end

	--Earthliving
	if eltime and self.db.profile.alert_earthliving.enable then
		local settings = self.db.profile.alert_earthliving
		local hotcolor = settings.color
		if eltime <= settings.threshold2 then hotcolor = settings.color2 end
		if eltime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_earthliving",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(eltime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_earthliving",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(eltime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_earthliving") then self.core:SendStatusLost(gridid, "alert_earthliving") end
	end

	--Grace
	if gratime and (self.db.profile.alert_gracestack.enable or self.db.profile.alert_gracedurstack.enable) then
		local settings = self.db.profile.alert_gracestack
		local hotcolor = settings.color
		if grastack == 2 then hotcolor = settings.color2 end
		if grastack == 3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(gridid, "alert_gracestack",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(math.floor(gratime))
		)

		local settings = self.db.profile.alert_gracedurstack
		local hotcolor = settings.color
		if gratime <= settings.threshold2 then hotcolor = settings.color2 end
		if gratime <= settings.threshold3 then hotcolor = settings.color3 end
		self.core:SendStatusGained(gridid, "alert_gracedurstack",
			settings.priority,
			(settings.range and 40),
			hotcolor,
			tostring(math.floor(gratime).."-"..tostring(grastack))
		)
	else
		if self.core:GetCachedStatus(gridid, "alert_gracestack") then self.core:SendStatusLost(gridid, "alert_gracestack") end
		if self.core:GetCachedStatus(gridid, "alert_gracedurstack") then self.core:SendStatusLost(gridid, "alert_gracedurstack") end
	end

	--Gift of the Naaru
	if gifttime and self.db.profile.alert_gift.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_gift
		local hotcolor = settings.color
		if gifttime <= settings.threshold2 then hotcolor = settings.color2 end
		if gifttime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_gift",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(gifttime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_gift",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(gifttime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_gift") then self.core:SendStatusLost(gridid, "alert_gift") end
	end

	--Flash of Light
	if foltime and self.db.profile.alert_fol.enable then
		-- Add self thrown countdown and status
		local settings = self.db.profile.alert_fol
		local hotcolor = settings.color
		if foltime <= settings.threshold2 then hotcolor = settings.color2 end
		if foltime <= settings.threshold3 then hotcolor = settings.color3 end
		if settings.totshow then
			self.core:SendStatusGained(gridid, "alert_fol",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(foltime).."-"..tostring(total_hots))
			)
		else
			self.core:SendStatusGained(gridid, "alert_fol",
				settings.priority,
				(settings.range and 40),
				hotcolor,
				tostring(math.floor(foltime))
			)
		end
	else
		if self.core:GetCachedStatus(gridid, "alert_fol") then self.core:SendStatusLost(gridid, "alert_fol") end
	end
end

function GridStatusHots:UpdateAll()

	if GridRoster then
		for guid, unitid in GridRoster:IterateRoster() do
			updateUnit(self, guid, unitid)
		end
	else
		for u in RL:IterateRoster(true) do
			local name = UnitName(u.unitid)
			if name then
				updateUnit(self, name, u.unitid)
			end
		end
	end
end
