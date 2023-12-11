local function gn(spellId)
	--return select(1, GetSpellInfo(spellId))
	return spellId;
end

GridClickSets_DefaultSets = {
	PRIEST = {
		["1"] = {
			["shift-"]	= gn(139),--"恢復",
			["ctrl-"]	= gn(527),--"驅散魔法",
			["alt-"]	= gn(2061),--"快速治療",
			["alt-ctrl-"]	= gn(2010),--"復活術",
		},
		["2"] = {
			[""]		= gn(17),--"真言術:盾",
			["shift-"]	= gn(33076),--"癒合禱言",
			["ctrl-"]	= gn(552),--"驅除疾病", 
			["alt-"]	= gn(2060),--"強效治療術",
			["alt-ctrl-"]	= gn(32546),--"束縛治療",
		},
		["3"] = {
			[""]		= gn(34863),--"治療之環",
		},
	},
	
	DRUID = {
		["1"] = {
			["shift-"]	= gn(774),--"回春術",
			["ctrl-"]	= gn(2893),--"驅毒術",
			["alt-"]	= gn(8936),--"癒合",
			["alt-ctrl-"]	= gn(50769),--"復活",
		},
		["2"] = {
			[""]		= gn(53249),--"野性痊癒",
			["shift-"]	= gn(18562),--"迅捷治愈",
			["ctrl-"]	= gn(2782),--"解除詛咒",
			["alt-"]	= gn(50464),--"滋補術",
		},
		["3"] = {
			[""]		= gn(33763),--"生命之花",
		},
	},
	SHAMAN = { 
		["1"] = {
			["alt-"]	= gn(55459),--"治疗链",
			["shift-"]	= gn(49273),--"治疗波",
			["ctrl-"]	= gn(49284),--"大地之盾",
			["alt-ctrl-"]	= gn(49277),--"先祖之魂",
		},
		["2"] = {
			[""]		= gn(61301),--"激流",
			["alt-"]	= gn(49276),--"次级治疗波",
			["shift-"]	= gn(49276),--"次级治疗波",
			["ctrl-"]	= gn(51886),--"净化灵魂",
		},
		["3"] = {
			[""]		= gn(55459),--"治疗链",
		},
	},

	PALADIN = {
		["1"] = {
			["shift-"]	= gn(639),--"聖光術",
			["alt-"]	= gn(19750),--"聖光閃現",
			["ctrl-"]	= gn(53601),--"崇聖護盾",
			["alt-ctrl-"]	= gn(7328),--"救贖",
		},
		["2"] = {
			[""]		= gn(20473),--"神聖震擊",
			["shift-"]	= gn(53653),--"聖光信標",
			["ctrl-"]	= gn(4987),--"淨化術",
			["alt-"]	= gn(19750),--"聖光閃現",
			["alt-ctrl-"]	= gn(633),--"聖療術",
		},
	},

	WARRIOR = {
		["1"] = {
			["ctrl-"]	= gn(50720),--"戒備守護",
		},
		["2"] = {
			[""]		= gn(3411),--"阻擾",
		},
	},

	MAGE = {
		["1"] = {
			["shift-"]	= gn(1008),--"魔法增效",
			["alt-"]	= gn(1461),--"秘法智力",
			["ctrl-"]	= gn(23028),--"秘法光輝",
		},
		["2"] = {
			[""]		= gn(475),--"解除詛咒",
			["ctrl-"]	= gn(475),--"解除詛咒",
			["shift-"]	= gn(604),--"魔法抑制",
		},
	},

	WARLOCK = {
		["1"] = {
			["alt-"]	= gn(132),--"偵測隱形",
			["ctrl-"]	= gn(5697),--"魔息術",
		},
		["2"] = {
			[""]		= gn(698),--"召喚儀式",
		},
	},

	HUNTER = {
		["2"] = {
			[""]		= gn(34477),--"誤導",
		},
	},
	
	ROGUE = {
		["2"] = {
			[""]		= gn(57933),--"偷天換日",
		},
	},
}

GridClickSets_SpellList = {
	PRIEST = {
		(139),--"恢復",
		(2060),--"強效治療術",
		(2061),--"快速治療",
		(32546),--"束縛治療",
		(34863),--"治療之環",
		(17),--"真言術:盾",
		(33076),--"癒合禱言",
		(2061),--"快速治療",
		(527),--"驅散魔法",
		(552),--"驅除疾病", 
		(2010),--"復活術",
		(1245),--"真言術:韌",
		(47666),--"懺悟",
		(528),--"祛病術",
		(6346),--"防護恐懼結界",
	},
	DRUID = {
		(5185),--"治療之觸",
		(50464),--"滋補術",
		(774),--"回春術",
		(8936),--"癒合",
		(33763),--"生命之花",
		(50769),--"復活",
		(53249),--"野性痊癒",
		(18562),--"迅捷治愈",
		(2782),--"解除詛咒",
		(2893),--"驅毒術",
		(20484),--"復生",
		(1126),--"野性印記", 
		--(21849),--"野性赐福",
	},
	SHAMAN = { 
		(55459),--"治疗链",
		(49273),--"治疗波",
		(49284),--"大地之盾",
		(49277),--"先祖之魂",
		(61301),--"激流",
		(49276),--"次级治疗波",
		(51886),--"净化灵魂",
		(526),--"驱毒",
	},
	PALADIN = {
		(639),--"聖光術",
		(19750),--"聖光閃現",
		(20473),--"神聖震擊",
		(53653),--"聖光信標",
		(4987),--"淨化術",
		(53601),--"崇聖護盾",
		(633),--"聖療術",
		(7328),--"救贖",
		(19740),--"力量祝福",
		(25782),--"强效力量",
		(25894),--"强效智慧祝福",
		(19742),--"智慧祝福",
		(25899),--"强效庇护祝福",
		(20911),--"庇护祝福",
		(25898),--"强效王者祝福",
		(20217),--"王者祝福",
		(19752),--"干涉",
		(31789),--"正义防护",
		(1038),--"拯救之手",
		(1044),--"自由之手",
		(1022),--"保护之手",
	},
	WARRIOR = {
		(50720),--"戒備守護",
		(3411),--"阻擾",
	},

	MAGE = {
		(604),--"魔法抑制",
		(1008),--"魔法增效",
		(1461),--"秘法智力",
		(475),--"解除詛咒",
		--(23028),--"秘法光輝",
	},
	WARLOCK = {
		(132),--"偵測隱形",
		(5697),--"魔息術",
		(698),--"召喚儀式",
	},
	HUNTER = {
		(34477),--"誤導",
	},
	ROGUE = {
		(57933),--"偷天換日",
	},
}

GridClickSets_Titles = {
	"Direct  Click :",
	"Ctrl +  Click :",
	"Alt  +  Click :",
	"Shift + Click :",
	"Ctrl + Alt :",
	"Ctrl + Shift :",
	"Shift + Alt :",
	"C + S + A :",
}

GridClickSets_Modifiers = {
	"",
	"ctrl-",
	"alt-",
	"shift-",
	"alt-ctrl-",
	"ctrl-shift-",
	"alt-shift-",
	"alt-ctrl-shift-",
}

--[[ set format
GridClickSets_Set = {
	["1"] = {
		["shift-"] = { type = "spellId:1001" },
		["ctrl-"] = { type = "TARGET" },
	},
	["3"] = {
		["shift-"] = { type = "SPELL", arg = "治疗波" },
		["shift-"] = { type = "MACRO", arg = "/target ##\n/cast [target=##]治疗波" },
	}
}
]]

function GridClickSets_ConvertDefault(set) 
	if not set then return {} end

	local modi, v
	local conv = {}

	for modi, v in pairs(set) do
		if type(v) == "number" then
			conv[modi] = { type = "spellId:"..v };
		else
			conv[modi] = { type = v.type, arg = v.arg };
		end
	end
	return conv;
end

function GridClickSets_GetBtnDefaultSet(btn)
	local _, c = UnitClass("player")
	if GridClickSets_DefaultSets[c] then
		return GridClickSets_ConvertDefault(GridClickSets_DefaultSets[c][tostring(btn)])
	else
		return {}
	end
end

function GridClickSets_GetDefault()
	local set = {}
	for i=1,5 do
		set[tostring(i)] = GridClickSets_GetBtnDefaultSet(i)
	end
	return set
end

function GridClickSets_SetAttributes(frame, set)
	local i,j
	for i=1,5 do
		local btn = set[tostring(i)] or {};
		for j=1,8 do
			local modi = GridClickSets_Modifiers[j]
			local set = btn[modi] or {}

			GridClickSets_SetAttribute(frame, i, modi, set.type, set.arg)
		end
	end
end

function GridClickSets_SetAttribute(frame, button, modi, type, arg)
	--if InCombatLockdown() then return end

	if(type==nil or type=="NONE") then
		frame:SetAttribute(modi.."type"..button, nil)
		frame:SetAttribute(modi.."macrotext"..button, nil)
		frame:SetAttribute(modi.."spell"..button, nil)
		return
	elseif strsub(type, 1, 8) == "spellId:" then
		frame:SetAttribute(modi.."type"..button, "spell")
		frame:SetAttribute(modi.."spell"..button, select(1, GetSpellInfo(strsub(type, 9))))
		return
	end

	frame:SetAttribute(modi.."type"..button, type)
	if type == "spell" then
		frame:SetAttribute(modi.."spell"..button, arg)
	elseif type == "macro" then
		local unit = SecureButton_GetModifiedUnit(frame, modi.."unit"..button)
		if unit and arg then
			arg = string.gsub(arg, "##", unit)
		end
		frame:SetAttribute(modi.."macrotext"..button, arg)
	end
end