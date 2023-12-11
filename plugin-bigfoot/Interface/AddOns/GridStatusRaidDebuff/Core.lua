
---------------------------------------------------------
--	Library
---------------------------------------------------------
local bzone = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
local bboss = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
local bzoneRev = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

---------------------------------------------------------
--	Localization
---------------------------------------------------------
local L = AceLibrary("AceLocale-2.2"):new("GridStatusRaidDebuff")

L:RegisterTranslations("enUS", function()
	return {
		["Raid Debuff"] = true,
		["Option for %s"] = true,
		["Enable"] = true,
		["Enable %s"] = true,		
		["Icon Priority"] = true,
		["Color Priority"] = true,
		["Custom Color"] = true,
		["Color"] = true,
		colorDesc = "Modify Color",		
		["Ignore dispellable debuff"] = true,		
		["Ignore undispellable debuff"] = true,
		["Remained time"] = true,
		["Stackable debuff"] = true,
		["Only color"] = "Only show color, Ignore icon",
		detector = "Detect new debuff",		
		["Remove"] = true,
		["Load"] = true,
		["Detected debuff"] = true,
		["Remove detected debuff"] = true,
		msgAct = "Debuff detector is activated during current session.",
		msgDeact = "Debuff detector is deactivated.",
		["Aura Refresh Frequency"] = true,
		["Border"] = true,
		["Center Icon"] = true,
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["Raid Debuff"] =  "团队减益",
		["Option for %s"] = "%s 设置",
		["Enable"] = "开启",
		["Enable %s"] = "开启 %s",	
--terry@bf 增加中文locale
		["Icon Priority"] = "图标优先级",
		["Color Priority"] = "颜色优先级",
		["Custom Color"] = "自定义颜色",
		["Color"] = "颜色",
		colorDesc = "修改颜色",		
		["Ignore dispellable debuff"] = "忽略可驱散减益",		
		["Ignore undispellable debuff"] = "忽略不可驱散减益",
		["Remained time"] = "剩余时间",
		["Stackable debuff"] = "可叠加减益",
		["Only color"] = "只显示颜色,忽略图标",
		detector = "检测新减益",		
		["Remove"] = "移除",
		["Load"] = "装载",
		["Detected debuff"] = "检测到的减益",
		["Remove detected debuff"] = "移除检测到的减益",
		msgAct = "开启减益侦测",
		msgDeact = "关闭减益检测.",
		["Aura Refresh Frequency"] = "减益检测频率",
		["Border"] = "外框",
		["Center Icon"] = "中心图标",

}
end)

L:RegisterTranslations("zhTW", function()
	return {
		["Raid Debuff"] = "團隊減益",
		["Option for %s"] = "%s 選項",
		["Enable"] = "啟用",
		["Enable %s"] = "啟用%s",

	}
end)

---------------------------------------------------------
--	local
---------------------------------------------------------
local realzone, detectStatus, enzone, zonetype, detectSessionEnable
local db, myClass, myDispellable
local debuff_list = {}

local colorMap = {
	["Curse"] = { r = .6, g =  0, b = 1},
	["Magic"] = { r = .2, g = .6, b = 1},
	["Poison"] = {r =  0, g = .6, b =  0},
	["Disease"] = { r = .6, g = .4, b =  0},
}

local dispelMap = {
	["PRIEST"] = {["Magic"] = true, ["Disease"] = true},
	["PALADIN"] = {["Magic"] = true, ["Disease"] = true, ["Poison"] = true},
	["MAGE"] = {["Curse"] = true},
	["DRUID"] = {["Curse"] = true, ["Poison"] = true},
	["SHAMAN"] = {["Disease"] = true, ["Poison"] = true, ["Curse"] = (select(5,GetTalentInfo(3,18)) == 1)},	
}


---------------------------------------------------------
--	Core
---------------------------------------------------------
GridStatusRaidDebuff = GridStatus:NewModule("GridStatusRaidDebuff")

local GridStatusRaidDebuff = GridStatusRaidDebuff
GridStatusRaidDebuff.menuName = L["Raid Debuff"]

local GetSpellInfo = GetSpellInfo
local fmt = string.format
local ssub = string.sub

GridStatusRaidDebuff.defaultDB = {
	debug = false,	
	isFirst = true,	
	
	["alert_RaidDebuff"] = {
		text = L["Raid Debuff"],
		desc = L["Raid Debuff"],
		enable = true,
		color = { r = .0, g = .0, b = .0, a=1.0 },
		priority = 98,
		range = false,
	},
	
	ignDis = false,
	ignUndis = false,	
	detect = false,
	frequency = 0.1,
	
	["debuff_options"] = {},
	["detected_debuff"] = {},	
}

function GridStatusRaidDebuff:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatuses()
	db = self.db.profile.debuff_options
end

function GridStatusRaidDebuff:OnEnable()
	self.debugging = self.db.profile.debug		
	
	myClass = select(2, UnitClass("player"))
	myDispellable = dispelMap[myClass]
	
	
	if self.db.profile.isFirst then		
		GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  true,
		GridFrame:UpdateAllFrames()
		self.db.profile.isFirst = false
	end	
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneCheck")
	self:RegisterCustomDebuff()
	
end

function GridStatusRaidDebuff:Reset()
	self.super.Reset(self)
	self:UnregisterStatuses()
	self:RegisterStatuses()
end

function GridStatusRaidDebuff:PLAYER_ENTERING_WORLD()	
	self:ZoneCheck()	
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")	
end

function GridStatusRaidDebuff:CheckDetectZone()
	detectStatus = detectSessionEnable and not (zonetype == "none" or zonetype == "pvp") --check db Enable	
	self:Debug("CheckDetectZone", realzone, enzone, detectStatus and "Detector On")	
	
	if detectStatus then 
		self:CreateZoneMenu(realzone) 
		if not debuff_list[realzone] then debuff_list[realzone] = {} end
		if not self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "ScanNewDebuff")
		end
	else
		if self:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED") then
			self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
end

function GridStatusRaidDebuff:ZoneCheck()	
	realzone, zonetype = GetInstanceInfo()
	enzone = bzoneRev[realzone]
	
	self:UpdateAllUnit()
	self:CheckDetectZone()
	
	if myClass == "SHAMAN" then
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
	end
	
	if debuff_list[realzone] then		
		if not self:IsEventScheduled("GSRD_Refresh") then		
			self:ScheduleRepeatingEvent("GSRD_Refresh", self.UpdateAllUnit,self.db.profile.frequency, self)
			self:RegisterEvent("Grid_UnitJoined")			
		end
	else					
		if self:IsEventScheduled("GSRD_Refresh") then
			self:CancelScheduledEvent("GSRD_Refresh")
			self:UnregisterEvent("Grid_UnitJoined")				
		end
	end
end

function GridStatusRaidDebuff:UpdateRefresh()
	self:CancelScheduledEvent("GSRD_Refresh")
	self:ScheduleRepeatingEvent("GSRD_Refresh", self.UpdateAllUnit,self.db.profile.frequency, self)
end

function GridStatusRaidDebuff:RegisterStatuses()
	self:RegisterStatus("alert_RaidDebuff", L["Raid Debuff"])
	self:CreateMainMenu()
end

function GridStatusRaidDebuff:UnregisterStatuses()
	self:UnregisterStatus("alert_RaidDebuff")
end

function GridStatusRaidDebuff:Grid_UnitJoined(guid, unitid)
	self:ScanUnit(unitid, guid)
end

function GridStatusRaidDebuff:PLAYER_TALENT_UPDATE()	
	myDispellable["Curse"] = (select(5,GetTalentInfo(3,18)) == 1)	
end

function GridStatusRaidDebuff:UpdateAllUnit()
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnit(unitid, guid)
	end
end

function GridStatusRaidDebuff:ScanNewDebuff(ts, event, srcguid, srcname, srcflg, dstguid, dstname, dstflg, spellId, name)
	local settings = self.db.profile["alert_RaidDebuff"]	
	if (settings.enable and debuff_list[realzone]) then		
		if event == "SPELL_AURA_APPLIED" and srcguid and not GridRoster:IsGUIDInRaid(srcguid) and GridRoster:IsGUIDInRaid(dstguid) 
			and not debuff_list[realzone][name] then
			if spellId == 1604 then return end --Ignore Dazed
			self:Debug("New Debuff", srcname, dstname, name)
							
			self:Debuff(enzone, name, spellId, 5, 5, true, true)	
			if not self.db.profile.detected_debuff[realzone] then self.db.profile.detected_debuff[realzone] = {} end
			if not self.db.profile.detected_debuff[realzone][name] then self.db.profile.detected_debuff[realzone][name] = spellId end						
							
			self:LoadZoneDebuff(realzone, name)
		end
	end
end

function GridStatusRaidDebuff:ScanUnit(unitid, unitGuid)
	local guid = unitGuid or UnitGUID(unitid)		
	--if not GridRoster:IsGUIDInRaid(guid) then	return end	
	
	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable	
	local settings = self.db.profile["alert_RaidDebuff"]	
	
	if (settings.enable and debuff_list[realzone]) then	
		local d_name, di_prior, dc_prior, dt_prior, d_icon,d_color,d_startTime,d_durTime,d_count
		local data
		
		di_prior = 0
		dc_prior = 0
		dt_prior = 0
		
		local index = 0
		while true do
			index = index + 1
			name, _, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura(unitid, index, "HARMFUL")

			if not name then
				break
			end

			if debuff_list[realzone][name] then		
				data = debuff_list[realzone][name]
				
				if not data.disable and
				   not (self.db.profile.ignDis and myDispellable[debuffType]) and
				   not (self.db.profile.ignUndis and debuffType and not myDispellable[debuffType]) then
				
					if di_prior < data.i_prior then
						di_prior = data.i_prior
						d_name = name
						d_icon = 	not data.noicon and icon
						if data.timer and dt_prior < data.i_prior then
							d_startTime = expirationTime - duration
							d_durTime = duration
						end
					end				
					--Stack
					if data.stackable then
						d_count = count
					end
					--Color Priority
					if dc_prior < data.c_prior then
						dc_prior = data.c_prior					
						d_color = (data.custom_color and data.color) or colorMap[debuffType] or settings.color					
					end
				end
			end
		end
		
		if d_color and not d_color.a then
			d_color.a = settings.color.a
		end
		
		if d_color and d_color.a == 0 then			
			d_color.a = 1
		end
			
		if d_name then
			self.core:SendStatusGained(
			guid, "alert_RaidDebuff", settings.priority, (settings.range and 40),
			d_color, nil, nil, nil, d_icon, d_startTime, d_durTime, d_count)
		else
			self.core:SendStatusLost(guid, "alert_RaidDebuff")	
		end
	else
		self.core:SendStatusLost(guid, "alert_RaidDebuff")	
	end
end

---------------------------------------------------------
--	For External
---------------------------------------------------------
local function getDb(zone, name, arg, ret)	
	if db[zone] and db[zone][name] and db[zone][name][arg] ~= nil then
		return db[zone][name][arg]
	end
	return ret
end

local function insertDb(zone, name, arg, value)
	if not db[zone] then db[zone] = {} end
	if not db[zone][name] then db[zone][name] = {} end
	
	if arg then
		db[zone][name][arg] = value
	end
end

function GridStatusRaidDebuff:Debuff(en_zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
	local zone = bzone[en_zone]	
	local name, icon, id
	local args, data, order	
	local detected
	
	self:CreateZoneMenu(zone)	
	
	if type(first) == "number" then
		name, _, icon = GetSpellInfo(first)
		id = first
		order = second			
	else
		name, _, icon = GetSpellInfo(second)		
		id = second
		order = 9999
		detected = true
	end
	
	if not debuff_list[zone][name] then
		debuff_list[zone][name] = {}		
		data = debuff_list[zone][name]
		
		data.debuffId = id
		data.icon = icon
		data.order = order
		data.disable = getDb(zone,name,"disable",default_disable)
		data.i_prior = getDb(zone,name,"i_prior",icon_priority)
		data.c_prior = getDb(zone,name,"c_prior",color_priority)
		data.custom_color = getDb(zone,name,"custom_color",color ~= nil)
		data.color = getDb(zone,name,"color",color)
		data.stackable = getDb(zone,name,"stackable",stackable)
		data.timer = getDb(zone,name,"timer",timer)
		data.noicon = getDb(zone,name,"noicon",noicon)
		data.detected = detected
	end
end


function GridStatusRaidDebuff:BossName(en_zone, order, en_boss)
	local zone = bzone[en_zone]
	local boss = en_boss and bboss[en_boss]	or order
	local ord = en_boss and order or 9998
	
	self:CreateZoneMenu(zone)
	
	local args = self.options.args
	
	args[zone].args[boss] = {		
			type = "group",
			name = fmt("%s%s%s","   [ ", boss," ]"),
                        desc = L["Option for %s"]:format(boss),
			order = ord,
			guiHidden = true,
			args = {}
	}
end

-- Create a custom tooltip for debuff description
local tip = CreateFrame("GameTooltip", "GridStatusRaidDebuffTooltip", nil, "GameTooltipTemplate")
tip:SetOwner(UIParent, "ANCHOR_NONE")
for i = 1, 10 do
	tip[i] = _G["GridStatusRaidDebuffTooltipTextLeft"..i]
	if not tip[i] then
		tip[i] = tip:CreateFontString()
		tip:AddFontStrings(tip[i], tip:CreateFontString())
	end
end


function GridStatusRaidDebuff:LoadZoneMenu(zone)
	local args = self.options.args[zone].args	
	local settings = self.db.profile["alert_RaidDebuff"]	
	
	for i,k in pairs(args) do
		if k.guiHidden then 
			k.guiHidden = false
		end	
	end
	
	for name,_ in pairs(debuff_list[zone]) do
		self:LoadZoneDebuff(zone, name)
	end
end

function GridStatusRaidDebuff:LoadZoneDebuff(zone, name)
	local description, menuName, icon, data, k
	local args = self.options.args[zone].args
	
	k = debuff_list[zone][name]
	
	if not args[name] then
		description = L["Enable %s"]:format(name)
		
		tip:SetHyperlink("spell:"..k.debuffId)
		if tip:NumLines() > 1 then
			description = tip[tip:NumLines()]:GetText()
		end		
		
		menuName = fmt("|T%s:0|t%s", k.icon, name)	
		
		args[name] = {
			type = "group",
			name = menuName,
			desc = description,				
			order = k.order,
			args = {
				["enable"] = {
					type = "toggle",
					name = L["Enable"],
					desc = L["Enable %s"]:format(name),
					order = 1,
					get = function()
									return not k.disable
								end,
					set = function(v)
									insertDb(zone,name,"disable",not v)									
									k.disable = not v
									self:UpdateAllUnit()
								end,
				},
				
				["icon priority"] = {
					type = "range",
					name = L["Icon Priority"],
					desc = L["Option for %s"]:format(L["Icon Priority"]),
					order = 2,
					min = 1,
					max = 10,
					step = 1,
					get = function()									
									return k.i_prior
								end,
					set = function(v)
									insertDb(zone,name,"i_prior",v)
									k.i_prior = v
									self:UpdateAllUnit()
								end,	
				},
				["color priority"] = {
					type = "range",
					name = L["Color Priority"],
					desc = L["Option for %s"]:format(L["Color Priority"]),
					order = 3,
					min = 1,
					max = 10,
					step = 1,
					get = function() 
									return k.c_prior
								end,
					set = function(v)
									insertDb(zone,name,"c_prior",v)
									k.c_prior = v
									self:UpdateAllUnit()
								end,					
				},				
				["Remained time"] = {
					type = "toggle",
					name = L["Remained time"],
					desc = L["Enable %s"]:format(L["Remained time"]),
					order = 4,
					get = function() 
									return k.timer
								end,
					set = function(v)
									insertDb(zone,name,"timer",v)
									k.timer = v
									self:UpdateAllUnit()						
								end,		
				},
				["Stackable debuff"] = {
					type = "toggle",
					name = L["Stackable debuff"],
					desc = L["Enable %s"]:format(L["Stackable debuff"]),
					order = 5,
					get = function() 
									return k.stackable
								end,
					set = function(v)
									insertDb(zone,name,"stackable",v)
									k.stackable = v
									self:UpdateAllUnit()						
								end,					
				},
				["only color"] = {
					type = "toggle",
					name = L["Only color"],
					desc = L["Only color"],
					order = 7,
					get = function() 
									return k.noicon
								end,
					set = function(v)
									insertDb(zone,name,"noicon",v)
									k.noicon = v
									self:UpdateAllUnit()								
								end,	
				},
				["custom color"] = {
					type = "toggle",
					name = L["Custom Color"],
					desc = L["Enable %s"]:format(L["Custom Color"]),
					order = 7,
					get = function() 
									return k.custom_color
								end,
					set = function(v)
									insertDb(zone,name,"custom_color",v)
									k.custom_color = v
									
									if v then
										insertDb(zone,name,"color", settings.color)
										k.color = settings.color										
									end
									
									self:UpdateAllUnit()								
								end,					
				},
				["color"] = {
					type = "color",
					name = L["Color"],
					desc = L["Option for %s"]:format(L["Color"]),
					order = 8,
					disabled = function()
											return not k.custom_color
										end,	
					hasAlpha = false,
					get = function ()									
									t = getDb(zone,name,"color", color or {r = 1, g = 0, b = 0})
									return t.r, t.g, t.b
							  end,
					set = function (ir, ig, ib)
									local t = {r = ir, g = ig, b = ib}
									insertDb(zone,name,"color",t)
								  k.color = t
								  self:UpdateAllUnit()
							  end,						
				},
				["remove"] = {
					type = "execute",
					name = L["Remove"],
					desc = L["Remove"],
					order = 9,
					guiHidden = function() return not k.detected end,
                                        hidden = function() return not k.detected end,	
					func = function() 									
									self.db.profile.detected_debuff[zone][name] = nil
									debuff_list[zone][name] = nil
									args[name] = nil
									self:UpdateAllUnit()
								end,									
				}							
			},
		}
	end
end


function GridStatusRaidDebuff:CreateZoneMenu(zone)
	local args
	if not debuff_list[zone] then 
		debuff_list[zone] = {}
				
		args = self.options.args
					
		args[zone] = {
			type = "group",
			name = zone,
			desc = L["Option for %s"]:format(zone),			
			args = {
				["load zone"] = {
					type = "execute",
					name = L["Load"],
					desc = L["Load"],
					func = function()
						self:LoadZoneMenu(zone)
						if not args[zone].args["load zone"].disabled then args[zone].args["load zone"].disabled = true end
					end,
				},
				["remove all"] = {
					type = "execute",
					name = L["Remove detected debuff"],
					desc = L["Remove detected debuff"],
					func = function()
					--terry@bf 增加sanity
									if not self.db.profile.detected_debuff[zone] then return end
					--terry@bf 增加sanity
									for name,k in pairs(self.db.profile.detected_debuff[zone]) do
										self.db.profile.detected_debuff[zone][name] = nil
										debuff_list[zone][name] = nil
										args[zone].args[name] = nil
										self:UpdateAllUnit()
									end
						
					end,					
				},
			
			},
			
		}
	end
end

function GridStatusRaidDebuff:CreateMainMenu()
	local args = self.options.args	
	
	
	for i,k in pairs(args["alert_RaidDebuff"].args) do
		args[i] = k		
	end	
	
	args["alert_RaidDebuff"].hidden = true
	
	args["Border"] = {
			type = "toggle",
			name = L["Border"],			
			desc = L["Enable %s"]:format(L["Border"]),
			order = 98,
			disabled = InCombatLockdown,
			get = function() return GridFrame.db.profile.statusmap["border"].alert_RaidDebuff end,
			set = function(v) 
							GridFrame.db.profile.statusmap["border"].alert_RaidDebuff  =  v 
							GridFrame:UpdateAllFrames()
						end,
	}	
	args["Icon"] = {
			type = "toggle",
			name = L["Center Icon"],			
			desc = L["Enable %s"]:format(L["Center Icon"]),
			order = 99,
			disabled = InCombatLockdown,
			get = function() return GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff end,
			set = function(v) 
							GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  v 
							GridFrame:UpdateAllFrames()
						end,
	}	
	args["Ignore dispellable"] = {
		type = "toggle",
		name = L["Ignore dispellable debuff"],
		desc = L["Ignore dispellable debuff"],
		order = 100,
		get = function() return self.db.profile.ignDis end,
		set = function(v) 
						self.db.profile.ignDis = v
						self:UpdateAllUnit()
					end,
	
	}	
	args["Ignore undispellable"] = {
		type = "toggle",
		name = L["Ignore undispellable debuff"],
		desc = L["Ignore undispellable debuff"],
		order = 101,
		get = function() return self.db.profile.ignUndis end,
		set = function(v) 
						self.db.profile.ignUndis = v
						self:UpdateAllUnit()
					end,	
	}	
	args["Frequency"] = {
		type = "range",
		name = L["Aura Refresh Frequency"],
		desc = L["Aura Refresh Frequency"],
		min = 0.01,
		max = 0.5,
		order = 102,
		step = 0.01,
		get = function()
						return self.db.profile.frequency 
					end,
		set = function(v)
						self.db.profile.frequency = v 
					end,
				
	}
	args["Detect"] = {
		type = "execute",
		name = L["detector"],
		desc = L["Enable %s"]:format(L["detector"]),
		order = 103,		
		func = function() 
						detectSessionEnable = not detectSessionEnable
						if detectSessionEnable then
							ChatFrame1:AddMessage(L.msgAct)
						else
							ChatFrame1:AddMessage(L.msgDeact)
						end
						self:ZoneCheck()		
					end,	
	}	
end

function GridStatusRaidDebuff:RegisterCustomDebuff()
	local en_zone
	for zone,j in pairs(self.db.profile.detected_debuff) do		
		en_zone = bzoneRev[zone]
		self:BossName(en_zone, L["Detected debuff"])
		
		for name,k in pairs(j) do
			self:Debuff(en_zone, name, k, 5, 5, true, true)
		end
	end
end