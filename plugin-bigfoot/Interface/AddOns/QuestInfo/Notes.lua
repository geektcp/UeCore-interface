--notes
local revision = tonumber(("$Revision: 3261 $"):match("%d+"));
local CQI = Cartographer_QuestInfo;
local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");
local MODNAME = "Notes";
local Mapster_Notes = CQI:NewModule(MODNAME, "AceConsole-3.0", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");

local yardString = "%.0f yd";
local _G = getfenv(0);

CURRENT_DB_VERSION = 3

local Tourist = LibStub("LibTourist-3.0")
local BZ = LibStub("LibBabble-Zone-3.0");
local Dewdrop = AceLibrary("Dewdrop-2.0");
local Tablet = AceLibrary("Tablet-2.0")
local BZL = BZ:GetLookupTable();
local BZH = BZ:GetUnstrictLookupTable()
local BZR = BZ:GetReverseLookupTable()
local db

--from aceaddon-3.0
local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function CreateDispatcher(argCount)
	local code = [[
		local xpcall, eh = ...
		local method, ARGS
		local function call() return method(ARGS) end
	
		local function dispatch(func, ...)
			 method = func
			 if not method then return end
			 ARGS = ...
			 return xpcall(call, eh)
		end
	
		return dispatch
	]]
	
	local ARGS = {}
	for i = 1, argCount do ARGS[i] = "arg"..i end
	code = code:gsub("ARGS", tconcat(ARGS, ", "))
	return assert(loadstring(code, "safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
end

local Dispatchers = setmetatable({}, {__index=function(self, argCount)
	local dispatcher = CreateDispatcher(argCount)
	rawset(self, argCount, dispatcher)
	return dispatcher
end})
Dispatchers[0] = function(func)
	return xpcall(func, errorhandler)
end

local function safecall(func, ...)
	-- we check to see if the func is passed is actually a function here and don't error when it isn't
	-- this safecall is used for optional functions like OnInitialize OnEnable etc. When they are not
	-- present execution should continue without hinderance
	if type(func) == "function" then
		return Dispatchers[select('#', ...)](func, ...)
	end
end

-----

--plugins
Mapster_Notes.plugins = {};

local icons = {}
local function getIconTitle(icon)
	if type(icon) ~= "string" then return "Unknow" end
	if icons[icon] then
		return icons[icon].text
	elseif icon.find and icon:find("^Interface\\") then
		return "Custom icon"
	else
		return icon
	end
end

local function getZoneAndLevel(zone)
	if zone:match("%d$") then
		local level
		zone, level = zone:match("^(.*[^%d])(%d+)$")
		level = level + 0
		if level < 1 then
			level = 1
		end
		return zone, level
	end
	return zone, 1
end

local function isCurrentLevel(level)
	local current = GetCurrentMapDungeonLevel()
	if current < 1 then
		current = 1
	end
	
	if level < 1 then
		level = 1
	end
	
	return level == current
end

local function purifyZone(zone)
	local zone, level = getZoneAndLevel(zone)
	if level == 1 then
		return zone
	else
		return zone .. level
	end
end

local isInInstance
local forceNextMinimapUpdate = false

local math_floor = math.floor
local function round(num, digits)
	local mantissa = 10^digits
	local norm = num * mantissa
	norm = norm + 0.5;
	local norm_f = math_floor(norm)
	if norm == norm_f and (norm_f % 2) ~= 0 then
		return (norm_f - 1)/mantissa
	end
	return norm_f/mantissa
end

local function GetCursorMapLocation(button)
	local x, y = GetCursorPosition();
	local left, top = button:GetLeft(), button:GetTop();
	local width = button:GetWidth();
	local height = button:GetHeight();
	local scale = button:GetEffectiveScale();

	return (x/scale - left) /width, (top - y/scale) / height
end

local function getID(x, y)
	return round(x*10000, 0) + round(y*10000, 0)*10001
end
Mapster_Notes.getID = getID

local function getXY(id)
	return (id % 10001)/10000, math_floor(id/10001)/10000
end
Mapster_Notes.getXY = getXY

--add new func 6.28
local continentMapFile = {
	[WORLDMAP_COSMIC_ID] = "Cosmic", -- That constant is -1
	[0] = "World",
	[1] = "Kalimdor",
	[2] = "Azeroth",
	[3] = "Expansion01",
	[4] = "Northrend",
}
local reverseMapFileC = {}
local reverseMapFileZ = {}
local ContinentList = {}
local ContinentCount = select("#", GetMapContinents());
for C=1, ContinentCount do
	ContinentList[C] = {GetMapZones(C)};
end

for C = 1, ContinentCount do
	for Z = 1, #(ContinentList[C]) do
		local mapFile = ContinentList[C][Z]
		reverseMapFileC[mapFile] = C
		reverseMapFileZ[mapFile] = Z
	end
end
for C = -1, 4 do
	local mapFile = continentMapFile[C]
	reverseMapFileC[mapFile] = C
	reverseMapFileZ[mapFile] = 0
end
for C = -1, 4 do
	local mapFile = continentMapFile[C]
	reverseMapFileC[mapFile] = C
	reverseMapFileZ[mapFile] = 0
end

function Mapster_Notes:GetCZ(mapFile)
	return reverseMapFileC[mapFile], reverseMapFileZ[mapFile]
end
------------------------------------------------**--------------------

local function getColorID(r, g, b)
	r = round(r*255, 0)
	g = round(g*255, 0)
	b = round(b*255, 0)
	if r > 255 then
		r = 255
	elseif r < 0 then
		r = 0
	end

	if g > 255 then
		g = 255
	elseif g < 0 then
		g = 0
	end

	if b > 255 then
		b = 255;
	elseif b < 0 then
		b = 0
	end
	return r * 65536 + g*256 + b
end

Mapster_Notes.getColorID = getColorID
local whiteColorID = getColorID(1, 1, 1);

local function getRGB(id)
	if not id then
		return 1, 1, 1
	end
	local r = math_floor(id/65536)/255
	local g = (math_floor(id/256) %256)/255
	local b = (id % 256) / 255
	return r, g, b	
end
Mapster_Notes.getRGB = getRGB;

local upgradeDatabase
do
	local tmp
	function upgradeDatabase(db)
		if next(db) == nil then
			db.version = CURRENT_DB_VERSION
			return
		end
		if (db.version or 1) == 1 then
			local function idConvert(id)
				if type(id) == "number" then
					return (id % 1001)*10 + math.floor(id / 1001)*100010
				end
				return id
			end

			if not tmp then
				tmp = {}
			end
			for name, zone in pairs(db) do
				if type(zone) == "table" then
					for id, data in pairs(zone) do
						tmp[idConvert(id)] = data
						zone[id] = nil
					end
					for id, data in pairs(tmp) do
						zone[id] = data
						tmp[id] = nil
					end
				end
			end
			db.version = 2
		end
		if db.version == 2 then
			for name, zone in pairs(db) do
				if type(zone) == "table" then
					for id, data in pairs(zone) do
						if type(data) == "table" then
							local r, g, b = data.titleR or 1, data.titleG or 1, data.titleB or 1
							data.titleR, data.titleB, data.titleG = nil, nil, nil
							local colorID = getColorID(r, g, b)
							if colorID ~= whiteColorID then
								data.titleCol = colorID
							end
							r, g, b = data.infoR or 1, data.infoG or 1, data.infoB or 1
							data.infoR, data.infoB, data.infoG = nil, nil, nil
							colorID = getColorID(r, g, b)
							if colorID ~= whiteColorID then
								data.infoCol = colorID
							end
							r, g, b = data.info2R or 1, data.info2G or 1, data.info2B or 1
							data.info2R, data.info2B, data.info2G = nil, nil, nil
							colorID = getColorID(r, g, b)
							if colorID ~= whiteColorID then
								data.info2Col = colorID
							end
						end
					end
				end
			end
			db.version = 3
		end
	end
end

--check index has in table
local function getrawpoi(zone, id, creator)
	local self = Mapster_Notes
	if creator then
		local v = self.externalDBs[creator]
		if v and rawget(v, zone) and rawget(v[zone], id) then
			return v[zone][id], creator
		end
		return
	end
	for k, v in pairs(self.externalDBs) do
		if rawget(v, zone) and rawget(v[zone], id) then
			return v[zone][id], k
		end
	end
	if rawget(self.db.char.pois, zone) then
		local t = rawget(self.db.char.pois[zone], id)
		if t then
			return t, nil
		end
	end
end

local function getpoi(zone, id, creator)
	local self = Mapster_Notes
	if creator then
		local v = self.externalDBs[creator]
		if v and v[zone] and v[zone][id] then
			return v[zone][id], creator
		end
		return
	end
	for k, v in pairs(self.externalDBs) do
		if v[zone] and v[zone][id] then
			return v[zone][id], k
		end
	end
	local t = self.db.char.pois[zone][id];
	return t, nil
end

--在大地图上增加文字
local function AddToMagnifyingGlass(text)
	magnifyingGlassTexts = {
		L["Right-Click on map to zoom out"],
		L["Left-Click on map to zoom in"],
	}

	for _, v in ipairs(magnifyingGlassTexts) do
		if v == text then
			error(string.format("无法添加%q到放大镜中, 它已经存在!", text), 2)
		end
	end
	tinsert(magnifyingGlassTexts, text)
	WorldMapMagnifyingGlassButton:SetText(table.concat(magnifyingGlassTexts, "\n"));
end

--注册一个icon
--name 图标名
--data: cLeft, path, cRight, cTop, cBottom, alpha, width, height
function Mapster_Notes:RegisterIcon(name, data)
	if not data.cLeft then
		if data.path:find("^Interface\\Icons\\") then
			data.cLeft = 0.05;
			data.cRight = 0.95;
			data.cTop = 0.05;
			data.cBottom = 0.95;
		else
			data.cLeft = 0;
			data.cRight = 1;
			data.cTop = 0;
			data.cBottom = 1;
		end
	end

	if not data.alpha then
		data.alpha = 1
	end
	if not data.width then
		data.width = 16
	end
	if not data.height then
		data.height = 16
	end
	icons[name] = data
	self:RefreshMap(false);
end

local icon_cache = {}
function Mapster_Notes:GetIconList()
	local list = {}
	for k, v in pairs(icons) do
		local t = next(icon_cache) or {}
		icon_cache[t] = nil
		t.name = v.text;
		t.path = v.path
		list[k] = t
	end
	return list
end

function Mapster_Notes:OverrideIconGraphic(name, newPath)
	local oldPath = icons[name].path
	icons[name].path =newPath
	return oldPath
end

function Mapster_Notes:IsIconRegister(name)
	return icons[name] and true
end

function Mapster_Notes:UnregisterIcon(name)
	icons[name] = nil
	self:RefreshMap(false);
end

local path
local db
local defaults = {
	char = {
		pois = {
			['*'] = {
				['*'] = {
					creator = "",
					manual = true,
				},
			},
		},
	},
	profile = {
		showCreator = true,--显示创建者的名字
		showYardsAway = false,--显示码数
		iconSize = 1,--图标大小
		minimapIconSize = 0.65,--mini map地图大小
		showMinimapIcons = false,
		notesPerDB = 25,--数据量
		commActive = true,--命令行 接收发送
		commFilter = "handmade",--注释接收过滤
	},
}

local options

local function getOptions()
	if not options then
		options = {
			handler = Mapster_Notes,
			type = "group",
			name = L["Notes"],
			args = {
				intro = {
					order = 1,
					type = "description",
					name = L["Module which allows you to put notes on the map.\n\nHint: /note is available to create notes with the command line."],
				},
				enable = {
					order = 2,
					type = "toggle",
					name = L["Enable Notes"],
					width = "full",
					get = "IsActiveNote",
					set = "ToggleActiveNote",
				},
				showCreator = {
					order = 3,
					type = "toggle",
					disabled = function() return not Mapster_Notes:IsActiveNote() end,
					name = L["Show note creator"],
					desc = L["Show note creator"],
					get = "IsShowingCreator",
					set = "ToggleShowingCreator",
				},
				size = {
					order = 4,
					type = "range",
					disabled = function() return not Mapster_Notes:IsActiveNote() end,
					name = L["Icon size"],
					desc = L["Size of the icons on the map"],
					min = 0.5,
					max = 2,
					step = 0.01,
					bigStep = 0.05,
					isPercent = true,
					get = "GetIconSize",
					set = "SetIconSize",
				},
				minimapIcons = {
					order = 5,
					type = "toggle",
					disabled = function() return not Mapster_Notes:IsActiveNote() end,
					name = L["Show minimap icons"],
					desc = L["Show icons on the minimap"],
					get = "IsShowingMinimapIcons",
					set = "ToggleShowingMinimapIcons",
				},
				minimapSize = {
					order = 6,
					type = "range",
					disabled = function() return not Mapster_Notes:IsActiveNote() end,
					name = L["Minimap icon size"],
					desc = L["Size of the icons on the minimap"],
					min = 0.5,
					max = 2,
					step = 0.01,
					bigStep = 0.05,
					isPercent = true,
					get = "GetMinimapIconSize",
					set = "SetMinimapIconSize",
				},
				clearnotes = {
					order = 7,
					type = "execute",
					disabled = function() return not Mapster_Notes:IsActiveNote() end,
					name = L["Clear all notes on map"],
					desc = L["This will clear all notes on map"],
					func = "ClearAllNotes",
				},
			},
		}
	end
	return options
end

function Mapster_Notes:OnInitialize()
	self.db = CQI.db:RegisterNamespace(MODNAME, defaults);
	db = self.db.profile
	path = debugstack(1, 1, 0)
	-- TODO:\\
	if path:find("QuestInfo\\") then
		path = [[Interface\AddOns\Cartographer_QuestInfo\Arrow]];
	else
		error ("Can't determine path of arrow");
	end
	
	self.externalDBs = {}
	self.handlers = {}
	self.cantDelete = {}
	if not self.pois then
		self.pois = {}
	end

	self:CreatePOI()

	local memoizations = {
		"NOTE", "title", "titleR", "titleG", "titleB", "info", "infoR", "infoG", "infoB", "info2R", "info2G", "info2B", "creator", "manual", "icon",
		"Star", "Circle", "Diamond", "Triangle", "Moon", "Square", "Cross", "Skull",
	}
	for zone in BZ:Iterate() do
		tinsert(memoizations, zone);
	end
	
	do
		local sysicons = {
			["Star"] = UnitPopupButtons.RAID_TARGET_1, -- Star
			["Circle"] = UnitPopupButtons.RAID_TARGET_2, -- Circle
			["Diamond"] = UnitPopupButtons.RAID_TARGET_3, -- Diamond
			["Triangle"] = UnitPopupButtons.RAID_TARGET_4, -- Triangle
			["Moon"] = UnitPopupButtons.RAID_TARGET_5, -- Moon
			["Square"] = UnitPopupButtons.RAID_TARGET_6, -- Square
			["Cross"] = UnitPopupButtons.RAID_TARGET_7, -- Cross
			["Skull"] = UnitPopupButtons.RAID_TARGET_8, -- Skull
			["Auctioneer"] = {text = MINIMAP_TRACKING_AUCTIONEER, icon = "Interface\\Minimap\\Tracking\\Auctioneer"},
			["Banker"] = {text = MINIMAP_TRACKING_BANKER, icon = "Interface\\Minimap\\Tracking\\Banker"},
			["BattleMaster"] = {text = MINIMAP_TRACKING_BATTLEMASTER, icon = "Interface\\Minimap\\Tracking\\BattleMaster"},
			["FlightMaster"] = {text = MINIMAP_TRACKING_FLIGHTMASTER, icon = "Interface\\Minimap\\Tracking\\FlightMaster"},
			["Innkeeper"] = {text = MINIMAP_TRACKING_INNKEEPER, icon = "Interface\\Minimap\\Tracking\\Innkeeper"},
			["Mailbox"] = {text = MINIMAP_TRACKING_MAILBOX, icon = "Interface\\Minimap\\Tracking\\Mailbox"},
			["Repair"] = {text = MINIMAP_TRACKING_REPAIR, icon = "Interface\\Minimap\\Tracking\\Repair"},
			["StableMaster"] = {text = MINIMAP_TRACKING_STABLEMASTER, icon = "Interface\\Minimap\\Tracking\\StableMaster"},
			["Class"] = {text = MINIMAP_TRACKING_TRAINER_CLASS, icon = "Interface\\Minimap\\Tracking\\Class"},
			["Profession"] = {text = MINIMAP_TRACKING_TRAINER_PROFESSION, icon = "Interface\\Minimap\\Tracking\\Profession"},
			["Ammunition"] = {text = MINIMAP_TRACKING_TRIVIAL_QUESTS, icon = "Interface\\Minimap\\Tracking\\TrivialQuests"},
			["Ammunition"] = {text = MINIMAP_TRACKING_VENDOR_AMMO, icon = "Interface\\Minimap\\Tracking\\Ammunition"},
			["Food"] = {text = MINIMAP_TRACKING_VENDOR_FOOD, icon = "Interface\\Minimap\\Tracking\\Food"},
			["Poisons"] = {text = MINIMAP_TRACKING_VENDOR_POISON, icon = "Interface\\Minimap\\Tracking\\Poisons"},
			["Reagents"] = {text = MINIMAP_TRACKING_VENDOR_REAGENT, icon = "Interface\\Minimap\\Tracking\\Reagents"},
			--[[[24] = {text = FACTION_ALLIANCE, icon = "Interface\\TargetingFrame\\UI-PVP-Alliance",
				tCoordLeft = 0.05, tCoordRight = 0.65, tCoordTop = 0, tCoordBottom = 0.6},
			[25] = {text = FACTION_HORDE, icon = "Interface\\TargetingFrame\\UI-PVP-Horde",
				tCoordLeft = 0.05, tCoordRight = 0.65, tCoordTop = 0, tCoordBottom = 0.6},
			[26] = {text = FACTION_STANDING_LABEL4, icon = "Interface\\TargetingFrame\\UI-PVP-FFA",
				tCoordLeft = 0.05, tCoordRight = 0.65, tCoordTop = 0, tCoordBottom = 0.6},
			[27] = {text = ARENA, icon = "Interface\\PVPFrame\\PVP-ArenaPoints-Icon"},
			[28] = {text = L["Portal"], icon = "Interface\\Icons\\Spell_Arcane_PortalDalaran"},]]
		}

		for index, iconInfo in pairs(sysicons) do
			self:RegisterIcon(index, {
				text = iconInfo.text,
				path = iconInfo.icon,
				cLeft = iconInfo.tCoordLeft,
				cRight = iconInfo.tCoordRight,
				cTop = iconInfo.tCoordTop,
				cBottom = iconInfo.tCoordBottom,
				r = iconInfo.color and iconInfo.color.r or 1,
				g = iconInfo.color and iconInfo.color.g or 1,
				b = iconInfo.color and iconInfo.color.b or 1,
				showToUser = true,
			})
		end
	
		self:RegisterIcon("Unknown", {
			text = "Unknown",
			path =  "Interface\\Icons\\INV_Misc_QuestionMark",
		});	
	end

	upgradeDatabase(self.db.char.pois)
	--CQI:RegisterModuleOptions(MODNAME, getOptions, "Notes");
	hooksecurefunc("WorldMapUnit_OnEnter", function()
		WorldMapTooltip:SetFrameStrata("TOOLTIP")
	end)
end


local pois, minimapPois
local oldWorldMapMagnifyingGlassButtonText

local first = true;
function Mapster_Notes:OnEnable()
	--在大地图上增加一段文字
	AddToMagnifyingGlass(L["Ctrl-Right-Click on map to add a note"]);
	--[[ Hook ]]--
	--修改于6.28
	self:RawHookScript(WorldMapButton, "OnMouseUp", "WorldMapButton_OnClick")
	self:SecureHook("ToggleFrame");

	self:RegisterEvent("WORLD_MAP_UPDATE", function() self:RefreshMap(false) end);
	
	if WorldMapFrame:IsShown() then
		self:RefreshMap(false)
	end

	local func = function(button, mouseButton)
		self:WorldMapButton_OnClick(button, mouseButton)
	end
	WorldMapPlayer:SetScript("OnMouseUp", func);
	for i = 1, 4 do
		_G["WorldMapParty" .. i]:SetScript("OnMouseUp", func)
	end
	for i = 1, 40 do
		_G["WorldMapRaid" .. i]:SetScript("OnMouseUp", func)
	end
	WorldMapFlag1:SetScript("OnMouseUp", func)
	WorldMapFlag2:SetScript("OnMouseUp", func)
	WorldMapCorpse:SetScript("OnMouseUp", func)
	WorldMapDeathRelease:SetScript("OnMouseUp", func)

	-- 创建一个slash命令 处理相关信息
		--RegisterChatCommand(cmd, text)
		--分为两种
			--一种快速标记 玩家点击坐标 即能标注上去
			--另一种 由系统进行标记 详细
	if first then
		local temp = {}
		--快速make
		self:RegisterChatCommand("make", function(text) 
			local x, y = GetPlayerMapPosition("player");
			if x== 0 or y == 0 then
				wsPrint(L["Can't create a note for your current position"]);
				return
			end

			local title, info
			if text then
				title = text
			end
			local targetName = UnitName("target");
			if targetName and targetName ~= UnitName("player") and targetName~=UNKNOWNOBJECT then
				info = targetName
			end

			if not title and info then
				title = info
			end

			for k, v in pairs(icons) do
				if v.showToUser then
					tinsert(temp, k)
				end
			end

			local icon = temp[math.random(1, #temp)];
			for k in pairs(temp) do
				temp[k] = nil
			end
			if title and title:len() == 0 then
				title = nil
			end
			if title and icons[title] then
				icon = title
				title = nil
			end
			wsPrint(L["Create a note success"])
			self:SetNote(GetRealZoneText(), x, y, icon, (UnitName("player")), 'manual', true, 'title', title, 'info', info);
		end);
	end
	first = false;
	if self.db.profile.showMinimapIcons then
		Mapster_Notes_MinimapIcons = Mapster_Notes:ScheduleRepeatingTimer("UpdateMinimapIcons", 0)
		self:RegisterEvent("MINIMAP_ZONE_CHANGED");
		self:RegisterEvent("MINIMAP_UPDATE_ZOOM");
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		self:RegisterEvent("PLAYER_LEAVING_WORLD");
		self:MINIMAP_ZONE_CHANGED()
		self:ZONE_CHANGED_NEW_AREA()
	end

	self:RegisterEvent("CVAR_UPDATE");
end

function Mapster_Notes:RegisterPlugins(pluginName, pluginHandler)
	if self.plugins[pluginName] ~= nil then
		return --already registered
	else
		self.plugins[pluginName] = pluginHandler;
	end
	--Mapster_Notes.plugins
end

--rehook
function Mapster_Notes:WorldMapButton_OnClick(button, mouseButton, ...)
	if mouseButton == "RightButton" and (IsAltKeyDown() or IsControlKeyDown()) and not IsShiftKeyDown() then
		if not Mapster_Notes:GetCurrentEnglishZoneName() then
			return
		end
		if not button then
			button = this
		end
		return self:MapButton_OnClick(button, mouseButton)
	else
		if self.hooks[button] then
			return self.hooks[button].OnMouseUp(button, mouseButton, ...)
		end
	end
end

local lastCursorX, lastCursorY
function Mapster_Notes:MapButton_OnClick(button, mouseButton)
	if IsControlKeyDown() then
		if not Dewdrop:IsRegistered(WorldMapFrame) then
			local newNoteFunc = function(creator)
				Mapster_Notes:OpenNewNoteFrame(lastCursorX, lastCursorY, creator)
				Dewdrop:Close()
			end
			local closeFunc = function()
				Dewdrop:Close()
			end
			Dewdrop:Register(button,
				'children', function()
					Dewdrop:AddLine(
						'text', L["Create a new note"],
						'func', newNoteFunc
					)
					Dewdrop:AddLine();
					Dewdrop:AddLine(
						'text', CANCEL,
						'func', closeFunc
					);
				end,
				'dontHook', true,
				'cursorX', true,
				'cursorY', true
			)
		end
		lastCursorX, lastCursorY = GetCursorMapLocation(button)
		if button == WorldMapFrame then
			Dewdrop:Open(button);
		else
			Dewdrop:Open(button, WorldMapFrame)
		end
	else
		local x, y = GetCursorMapLocation(button)
		--new:
		--self:SetNote(purifyZone(self:GetCurrentEnglishZoneName() .. GetCurrentMapDungeonLevel()), x, y, "Triangle", "Mapster_Notes")
		self:SetNote(self:GetCurrentEnglishZoneName(), x, y, "Triangle", "Mapster_Notes")
	end
end

local frame
local function GetNoteDialog()
	if frame then
		return frame
	end

	frame = CreateFrame("Frame", "MapsterNotesNewNoteFrame", WorldMapFrame);
	frame:SetPoint("CENTER", WorldMapFrame, "CENTER", 0, 0);
	frame:SetWidth(500);
	frame:SetHeight(330);
	frame:SetFrameLevel(WorldMapFrame:GetFrameLevel() + 6);
	frame:EnableMouse(true);
	frame:SetMovable(true);
	frame:SetToplevel(true);
	frame:SetFrameStrata("FULLSCREEN");
	frame:RegisterForDrag("LeftButton");
	frame:SetScript("OnDragStart", function(self)
		self:StartMoving()
	end);
	frame:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing();
	end);
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		insets = {
			left = 11,
			right = 12,
			top = 12,
			bottom = 11
		},
		'tileSize', 32,
		'edgeSize', 32
	});

		--header texture
	local texture = frame:CreateTexture(nil, "ARTWORK");
	texture:SetTexture([[Interface\DialogFrame\UI-DialogBox-Header]]);
	texture:SetWidth(256);
	texture:SetHeight(64);
	texture:SetPoint("TOP", frame, "TOP", 0,12);

	local header = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	frame.header = header
	header:SetText(L["New note"]);
	header:SetPoint("TOP", texture, "TOP", 0, -14);

	local okButton = CreateFrame("Button", "MapsterNotesNewNoteFrameOkButton", frame, "UIPanelButtonTemplate2");
	okButton:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 20, 20);
	okButton:SetText(OKAY or L['Okay']);
	okButton:SetWidth(frame:GetWidth()/2 - 25);

	local cancelButton = CreateFrame("Button", "MapsterNotesNewNoteFrameCancelButton", frame, "UIPanelButtonTemplate2");
	cancelButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 20);
	cancelButton:SetText(CANCEL or L['Cancel']);
	cancelButton:SetWidth(frame:GetWidth()/2 - 25)
	cancelButton:SetScript("OnClick", function(self)
		frame:Hide()
	end)

	local last;
	local isGood

	local OnEscapePressed = function(self)
		self:ClearFocus();
	end

	local OnTextChanged = function(self)
		if isGood() then
			okButton:Enable()
		else
			okButton:Disable()
		end
	end

	local function make(text, colorful)
		local editBox = CreateFrame("EditBox", nil, frame);
		editBox:SetFontObject(ChatFontNormal);
		editBox:SetWidth(colorful and 210 or 240);
		editBox:SetHeight(13);
		if not last then
			editBox:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -35, -35);
		else
			editBox:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -20);
		end
		last = editBox;
		editBox:SetAutoFocus(false);
		editBox:SetScript("OnEscapePressed", OnEscapePressed);
		editBox:SetScript("OnTextChanged", OnTextChanged);
		
		local left = editBox:CreateTexture(nil, "BACKGROUND");
		left:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left");
		left:SetTexCoord(0, 100/256, 0, 1);
		left:SetWidth(colorful and 125 or 140);
		left:SetHeight(32);
		left:SetPoint("LEFT", editBox, "LEFT", -10, 0);
		
		local right = editBox:CreateTexture(nil, "BACKGROUND");
		right:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right");
		right:SetTexCoord(156/256, 1, 0, 1);
		right:SetWidth(colorful and 125 or 140);
		right:SetHeight(32);
		right:SetPoint("RIGHT", editBox, "RIGHT", 10, 0);

		local label = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		label:SetPoint("RIGHT", editBox, "LEFT", -20, 0);
		label:SetPoint("LEFT", frame, "LEFT", 20, 0);
		label:SetPoint("TOP", editBox, "TOP");
		label:SetPoint("BOTTOM", editBox, "BOTTOM");
		label:SetJustifyH("RIGHT");
		label:SetText(text);

		if colorful then
			local button = CreateFrame("Button", nil, editBox);
			button:SetPoint("LEFT", editBox, "RIGHT", 20, 0);
			button:SetWidth(16);
			button:SetHeight(16);
			local texture = button:CreateTexture("ARTWORK");
			texture:SetAllPoints(button);
			texture:SetTexture(1, 1, 1, 1);
			local function changeColor(r, g, b)
				texture:SetTexture(r, g, b);
				editBox:SetTextColor(r, g, b);
				Dewdrop:Close();
			end
			function editBox.resetColor(r, g, b)
				if not r then
					r, g, b = 1, 1, 1
				end
				texture:SetTexture(r, g, b);
				editBox:SetTextColor(r, g, b);
			end

			button:SetScript("OnClick", function(self) 
				Dewdrop:Register(button,
					'children', function()
						Dewdrop:AddLine(
							'text', L['White'],
							'textR', 1,
							'textG', 1,
							'textB', 1,
							'func', changeColor,
							'arg1', 1,
							'arg2', 1,
							'arg3', 1
						)
						Dewdrop:AddLine(
							'text', L['Gray'],
							'textR', 0.8,
							'textG', 0.8,
							'textB', 0.8,
							'func', changeColor,
							'arg1', 0.8,
							'arg2', 0.8,
							'arg3', 0.8
						)
						Dewdrop:AddLine(
							'text', L['Pink'],
							'textR', 1,
							'textG', 0.62,
							'textB', 0.59,
							'func', changeColor,
							'arg1', 1,
							'arg2', 0.62,
							'arg3', 0.59
						)
						Dewdrop:AddLine(
							'text', L['Red'],
							'textR', 1,
							'textG', 0.24,
							'textB', 0.17,
							'func', changeColor,
							'arg1', 1,
							'arg2', 0.24,
							'arg3', 0.17
						)
						Dewdrop:AddLine(
							'text', L['Orange'],
							'textR', 0.98,
							'textG', 0.57,
							'textB', 0,
							'func', changeColor,
							'arg1', 0.98,
							'arg2', 0.57,
							'arg3', 0
						)
						Dewdrop:AddLine(
							'text', L['Yellow'],
							'textR', 1,
							'textG', 0.92,
							'textB', 0,
							'func', changeColor,
							'arg1', 1,
							'arg2', 0.92,
							'arg3', 0
						)
						Dewdrop:AddLine(
							'text', L['Green'],
							'textR', 0,
							'textG', 0.72,
							'textB', 0,
							'func', changeColor,
							'arg1', 0,
							'arg2', 0.72,
							'arg3', 0
						)
						Dewdrop:AddLine(
							'text', L['Stone grey'],
							'textR', 0.04,
							'textG', 0.95,
							'textB', 0,
							'func', changeColor,
							'arg1', 0.04,
							'arg2', 0.95,
							'arg3', 0
						)
						Dewdrop:AddLine(
							'text', L['Cyan'],
							'textR', 0,
							'textG', 1,
							'textB', 1,
							'func', changeColor,
							'arg1', 0,
							'arg2', 1,
							'arg3', 1
						)
						Dewdrop:AddLine(
							'text', L['Blue'],
							'textR', 0,
							'textG', 0.71,
							'textB', 1,
							'func', changeColor,
							'arg1', 0,
							'arg2', 0.71,
							'arg3', 1
						)
						Dewdrop:AddLine(
							'text', L['Sky-blue'],
							'textR', 0.7,
							'textG', 0.82,
							'textB', 0.88,
							'func', changeColor,
							'arg1', 0.7,
							'arg2', 0.82,
							'arg3',0.88
						)
						Dewdrop:AddLine(
							'text', L['Purple'],
							'textR', 0.83,
							'textG', 0.22,
							'textB', 0.9,
							'func', changeColor,
							'arg1', 0.83,
							'arg2', 0.22,
							'arg3', 0.9
						)
					end,
					'dontHook', true,
					'point', 'TOPRIGHT',
					'relativePoint', 'BOTTOMRIGHT'
				)
				button:SetScript("OnClick", function(self)
					if Dewdrop:IsOpen(button) then
						Dewdrop:Close()
					else
						Dewdrop:Open(button);
					end
					PlaySound("igMainMenuOptionCheckBoxOn");
				end)
				button:GetScript("OnClick")()
			end)
		end

		return editBox
	end

	frame.xEditBox = make(L["X Offset"]);
	frame.yEditBox = make(L["Y Offset"]);
	frame.zone = make(ZONE or L["Zone"]);
	frame.zone:SetScript("OnEditFocusGained", function(self)
		self:ClearFocus()
	end)
	frame.title = make(L["Title"], true);
	frame.info1 = make(L["Info1"], true);
	frame.info2 = make(L["Info2"], true);
	frame.creator = make(L["Creator"], true);

	frame.xEditBox:SetScript("OnTabPressed", function(self)
		self:ClearFocus();
		frame.yEditBox:SetFocus()
	end)
	frame.yEditBox:SetScript("OnTabPressed", function(self)
		self:ClearFocus();
		frame.title:SetFocus()
	end);
	frame.zone:SetScript("OnTabPressed", frame.yEditBox:GetScript("OnTabPressed"))
	frame.title:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
		frame.info1:SetFocus()
	end);
	frame.info1:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
		frame.info2:SetFocus();
	end);
	frame.info2:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
		frame.creator:SetFocus()
	end);
	frame.creator:SetScript("OnTabPressed", function(self)
		self:ClearFocus()
	end);

	function isGood()
		local x = tonumber(frame.xEditBox:GetText());
		if not x then
			return false
		elseif x < 0 or x > 100 then
			return false
		end

		local y = tonumber(frame.yEditBox:GetText());
		if not y then
			return false
		elseif y < 0 or y > 100 then
			return false
		end

		return true
	end

	local icon = CreateFrame("Frame", "MapsterNotesFrameIcon", frame)
	frame.icon = icon
	icon:SetPoint("TOPLEFT", frame.creator, "BOTTOMLEFT", -20, -10);
	icon:SetWidth(frame:GetWidth()/2 -25);
	icon:SetHeight(30)

	local texture = icon:CreateTexture(nil, "ARTWORK");
	texture:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame");
	texture:SetWidth(25);
	texture:SetHeight(64);
	texture:SetPoint("TOPLEFT", icon, "TOPLEFT", 0, 17);
	texture:SetTexCoord(0, 0.1953125, 0, 1);

	local texture2 = icon:CreateTexture(nil, "ARTWORK")
	texture2:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	texture2:SetWidth(115)
	texture2:SetHeight(64)
	texture2:SetPoint("LEFT", texture, "RIGHT")
	texture2:SetTexCoord(0.1953125, 0.8046875, 0, 1)

	local texture3 = icon:CreateTexture(nil, "ARTWORK")
	texture3:SetTexture("Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame")
	texture3:SetWidth(25)
	texture3:SetHeight(64)
	texture3:SetPoint("LEFT", texture2, "RIGHT")
	texture3:SetTexCoord(0.8046875, 1, 0, 1)

	local fontstring = icon:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	fontstring:SetJustifyH("RIGHT")
	fontstring:SetWidth(0)
	fontstring:SetHeight(10)
	fontstring:SetPoint("RIGHT", texture3, "RIGHT", -43, 2)

	local image = icon:CreateTexture(nil, "OVERLAY")
	image:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	image:SetWidth(16)
	image:SetHeight(16)
	image:SetTexCoord(0, 0.25, 0, 0.25)
	image:SetPoint("LEFT", texture, "LEFT", 20, 0)

	local button = CreateFrame("Button", "MapsterNotesFrameIconButton", icon)
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetPoint("TOPRIGHT", texture3, "TOPRIGHT", -16, -18)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	local iconSelector = function(k)
		icon.value = k
		local t = icons[k]
		if k:find("^Interface\\") then
			if frame.title:GetText() == fontstring:GetText() then
				frame.title:SetText(L["Custom Icon"])
			end
			fontstring:SetText(L["Custom Icon"])
			fontstring:SetTextColor(1, 1, 1)
			image:SetTexture(k)
			if k:find("^Interface\\Icons\\") then
				image:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			else
				image:SetTexCoord(0, 1, 0, 1)
			end
			Dewdrop:Close()
			return
		end
		if not t then
			t = icons.Unknown
		end
		if frame.title:GetText() == fontstring:GetText() then
			frame.title:SetText(t.text)
		end
		fontstring:SetText(t.text)
		fontstring:SetTextColor(t.r or 1, t.g or 1, t.b or 1)
		image:SetTexture(t.path)
		image:SetTexCoord(t.cLeft or 0, t.cRight or 1, t.cTop or 0, t.cBottom or 1)
		Dewdrop:Close()
	end

	frame.iconSelector = iconSelector
	button:SetScript("OnClick", function()
		local t = {}
		local mysort = function(alpha, bravo)
			if not alpha or not bravo then
				return false
			end

			local alpha_text = icons[alpha].text or alpha
			local bravo_text = icons[bravo].text or bravo
			return alpha_text < bravo_text
		end

		Dewdrop:Register(icon, 
			'children', function()
				for k, v in pairs(icons) do
					if v.showToUser then
						tinsert(t, k)
					end
				end
				table.sort(t, mysort)

				for _, k in ipairs(t) do
					local v = icons[k]
					Dewdrop:AddLine(
						'text', v.text or k,
						'textR', v.r or 1,
						'textG', v.g or 1,
						'textB', v.b or 1,
						'icon', v.path,
						'iconCoordLeft', v.cLeft or 0,
						'iconCoordRight', v.cRight or 1,
						'iconCoordTop', v.cTop or 0,
						'iconCoordBottom', v.cBottom or 1,
						'func', iconSelector,
						'arg1', k
					)
				end
				for i = 1, # t do
					t[i] = nil
				end
			end,
			'dontHook', true,
			'point', 'TOPLEFT',
			'relativePoint', 'BOTTOMLEFT'
		)
		button:SetScript("OnClick", function()
			if Dewdrop:IsOpen(icon) then
				Dewdrop:Close()
			else
				Dewdrop:Open(icon)
			end
			PlaySound("igMainMenuOptionCheckBoxOn")
		end)
		button:GetScript("OnClick")()
	end)
	icon:SetScript("OnHide", function()
		if Dewdrop:IsOpen(icon) then
			Dewdrop:Close()
		end
	end)

	okButton:SetScript("OnClick", function(self)
		local r, g, b = frame.title:GetTextColor();
		local r2, g2, b2 = frame.info1:GetTextColor();
		local r3, g3, b3 = frame.info2:GetTextColor();

		local x, y = tonumber((frame.xEditBox:GetText())/100), tonumber((frame.yEditBox:GetText())/100)
		x,y,r,g,b,r2,g2,b2,r3,g3,b3 = round(x, 3),round(y, 3),round(r, 2),round(g, 2),round(b, 2),round(r2, 2),round(g2, 2),round(b2, 2),round(r3, 2),round(g3, 2),round(b3, 2)
		Mapster_Notes:SetNote(frame.zonename, x, y, frame.icon.value, frame.creator:GetText(),
			'title', frame.title:GetText(),
			'titleR', r,
			'titleG', g,
			'titleB', b,
			'info', frame.info1:GetText(),
			'infoR', r2,
			'infoG', g2,
			'infoB', b2,
			'info2', frame.info2:GetText(),
			'info2R', r3,
			'info2G', g3,
			'info2B', b3,
			'manual', true,
			'oldId', frame.id)
		frame:Hide()
	end);

	return frame
end

local possiableIcons
function Mapster_Notes:OpenNewNoteFrame(x, y, creator)
	if not self:GetCurrentEnglishZoneName() then
		return
	end

	local frame = GetNoteDialog()

	frame.header:SetText(L["New Note"]);
	frame.id = nil
	frame.xEditBox:SetText(("%.2f"):format(x * 100));
	frame.yEditBox:SetText(("%2.f"):format(y * 100));

	frame.zone:SetText(self:GetCurrentEnglishZoneName())
	frame.title:SetText("");
	frame.title.resetColor();
	frame.info1:SetText("");
	frame.info1.resetColor();
	frame.info2:SetText("");
	frame.info2.resetColor();
	frame.creator:SetText(creator or UnitName("player"));
	frame:Show();
	frame.title:SetFocus()

	if not possiableIcons then
		possiableIcons = {}
	end
	for k in pairs(possiableIcons) do
		possiableIcons[k] = nil
	end
	for k, v in pairs(icons) do
		if v.showToUser then
			table.insert(possiableIcons, k)
		end
	end
	frame.iconSelector(possiableIcons[math.random(1, #possiableIcons)]);
	frame.zonename = self:GetCurrentEnglishZoneName();
end

function Mapster_Notes:ShowEditDialog(zone, x, y)
	local id;
	if not y then
		id = x
	else
		id = getID(x, y)
	end

	local data, db = getrawpoi(zone, id)
	if not data then
		return
	end

	local frame = GetNoteDialog();
	frame.header:SetText(L["Edit note"]);
	frame.id = id;
	local x, y = getXY(id);
	frame.xEditBox:SetText(("%.2f"):format(x*100));
	frame.yEditBox:SetText(("%2.f"):format(y*100));
	frame.zone:SetText(BZL[zone]);
	if type(data) == "table" then
		frame.title:SetText(data.title or getIconTitle(data.icon))
		frame.title.resetColor(getRGB(data.titleCol));
		frame.info1:SetText(data.info or "");
		frame.info1.resetColor(getRGB(data.infoCol));
		frame.info2:SetText(data.info2 or "");
		frame.info2.resetColor(getRGB(data.info2Col));
		frame.creator:SetText(db or data.creator or "");
		frame.iconSelector(data.icon)
	else
		frame.title:SetText(getIconTitle(data))
		frame.title.resetColor(1, 1, 1)
		frame.info1:SetText("")
		frame.info1.resetColor(1, 1, 1)
		frame.info2:SetText("")
		frame.info2.resetColor(1, 1, 1)
		frame.creator:SetText(db)
		frame.iconSelector(data)
	end
	frame:Show()
	frame.title:SetFocus();
	frame.zonename = zone
end

--[[ world map ]] --
function Mapster_Notes:CreatePOI()
	local old = WorldMapParty1:GetScript("OnLeave");
	function WorldMapUnit_OnLeave(self)
		old(self)
	end
	local func = function(self, ...)
		WorldMapUnit_OnLeave()
	end
	WorldMapPlayer:SetScript("OnLeave", func)
	function WorldMapPlayer:OnTabletRequest()
		local kind = ""
		if self.unit == "player" then
			kind = PLAYER..": ";
		elseif self.unit:find("^party") then
			kind = PARTY..": ";
		elseif self.unit:find("^raid") then
			kind = RAID..": ";
		end
		local name = self.name
		if not name then
			name = UnitName(self.unit)
		end
		Tablet:SetTitle(kind..name)
		
		if self.unit then
			local cat = Tablet:AddCategory("columns", 2);
			local class, enClass = UnitClass(self.unit)
			local color = RAID_CLASS_COLORS[enClass]
			cat:AddLine(
				"text", CLASS..": ",
				'text2', class,
				'text2R', color.r,
				'text2G', color.g,
				'text2B', color.b
			);
			cat:AddLine(
				"text", LEVEL..": ",
				'text2', UnitLevel(self.unit),
				'text2R', 1,
				'text2G', 0.82,
				'text2B', 0
			);
		end
	end
	WorldMapParty1.OnTabletRequest = WorldMapPlayer.OnTabletRequest
	WorldMapRaid1.OnTabletRequest = WorldMapPlayer.OnTabletRequest
	
	local tmp = {}
	function WorldMapPlayer:OnLineRequest(cat)
		if self.unit == "player" then
			tmp[#tmp+1] = PLAYER..": ";
		elseif self.unit:find("^party") then
			tmp[#tmp+1] = PARTY..": ";
		elseif self.unit:find("^raid") then
			tmp[#tmp+1] = RAID..": ";
		end

		if self.name then
			tmp[#tmp+1] = self.name
		else
			local name = UnitName(self.unit);
			tmp[#tmp+1] = name
			tmp[#tmp+1] = " - |cff";
			local class, enClass = UnitClass(self.unit);
			local color = RAID_CLASS_COLORS[enClass];
			tmp[#tmp+1] = ("%02x%02x%02x"):format(color.r*255, color.g*255, color.b*255)
			tmp[#tmp+1] = class
			tmp[#tmp+1] = "|r"
		end
		local text = table.concat(tmp, "");
		for i=1, #tmp do
			tmp[i] = nil
		end

		if self.unit == "player" then
			return "text", text, "hasCheck", true, "checked", false
		else
			local tex = _G[self:GetName().."Icon"];
			local left, top, _, _, _, _, right, bottom = tex:GetTexCoord()
			local r, g, b = tex:GetVertexColor()
			return 'text', text,
				'hasCheck', true,
				'checked', true,
				'checkIcon', tex:GetTexture(),
				'checkCoordLeft', left,
				'checkCoordRight', right,
				'checkCoordTop', top,
				'checkCoordBottom', bottom,
				'checkColorR', r,
				'checkColorG', g,
				'checkColorB', b
		end
	end
	WorldMapPlayer:SetFrameLevel(WorldMapPlayer:GetFrameLevel() + 5);
	PlayerArrowFrame:SetFrameLevel(PlayerArrowFrame:GetFrameLevel()+5)
	PlayerArrowEffectFrame:SetFrameLevel(PlayerArrowEffectFrame:GetFrameLevel()+5)
	WorldMapParty1.OnLineRequest = WorldMapPlayer.OnLineRequest
	WorldMapRaid1.OnLineRequest = WorldMapPlayer.OnLineRequest
	for i=1, 4 do
		local poi = _G["WorldMapParty"..i];
		poi:SetScript("OnLeave", func);
		poi.OnTabletRequest = WorldMapParty1.OnTabletRequest
		poi.OnLineRequest = WorldMapParty1.OnLineRequest
		poi:SetFrameLevel(poi:GetFrameLevel() + 3);
	end
	for i=1, 40 do
		local poi = _G["WorldMapRaid"..i];
		poi:SetScript("OnLeave", func);
		poi.OnTabletRequest = WorldMapRaid1.OnTabletRequest;
		poi.OnLineRequest = WorldMapRaid1.OnLineRequest;
		poi:SetFrameLevel(poi:GetFrameLevel() + 3)
	end
	
	dummyFrame = CreateFrame("Frame");
	if not self.pois then
		self.pois = {}
	end
	local tmp = {}
	self.tooltipData = {}
	Tablet:Register(dummyFrame,
		"children", function()
			--player, party, raid, Vehicles Check debug objects
			if MouseIsOver(WorldMapPlayer) then
				tmp[#tmp+1] = WorldMapPlayer
			end
			for i=1, MAX_PARTY_MEMBERS do
				local unitButton = _G["WorldMapParty"..i]
				if unitButton:IsVisible() and MouseIsOver(unitButton) then
					tmp[#tmp+1] = unitButton
				end
			end
			
			for i=1, MAX_RAID_MEMBERS do
				local unitButton = _G["WorldMapRaid"..i];
				if unitButton:IsVisible() and MouseIsOver(unitButton) then
					tmp[#tmp+1] = unitButton
				end
			end

			--check Vehicles and debug objets... NEED
			local numVehicles = GetNumBattlefieldVehicles();
			for _, v in pairs(MAP_VEHICLES) do
				if (v:IsVisible() and MouseIsOver(v)) then
					if (v.name) then
						Tablet:SetTitle(v.name)--for vehicles
					end
				end
			end

			for frame in pairs(self.pois) do
				if frame:IsVisible() and MouseIsOver(frame) then
					tmp[#tmp+1] = frame
				end
			end
			if #tmp == 1 then
				tmp[1]:OnTabletRequest()
				tmp[1] = nil
			elseif #tmp > 1 then
				local cat = Tablet:AddCategory()
				for i=1, #tmp do
					cat:AddLine(tmp[i]:OnLineRequest())
					tmp[i] = nil
				end
			end
		end,
		"point", function(parent)
			local x, y = GetCursorPosition()
			local cx, cy = GetScreenWidth()/2, GetScreenHeight()/2
			if x > cx then
				if y < cy then
					return "BOTTOMRIGHT"
				else
					return "TOPRIGHT"
				end
			else
				if y < cy then
					return "BOTTOMLEFT"
				else
					return "TOPLEFT"
				end
			end
		end,
		"relativePoint", function(parent)
			local x, y = GetCursorPosition()
			local cx, cy = GetScreenWidth()/2, GetScreenHeight()/2
			if x > cx then
				if y < cy then
					return "TOPLEFT"
				else
					return "BOTTOMLEFT"
				end
			else
				if y < cy then
					return "BOTTOMRIGHT"
				else
					return "TOPRIGHT"
				end
			end
		end,
		"dontHook", true,
		"data", self.tooltipData
	);
	--print('self:RawHook("WorldMapUnit_OnEnter", true)')
	self:RawHook("WorldMapUnit_OnEnter", true)
	self:RawHook("WorldMapUnit_OnLeave", true)
	self:ScheduleTimer("UpdateTooltip", 1)
end

local isOpen = false
function Mapster_Notes:WorldMapUnit_OnEnter(frame)	
	if not Dewdrop:IsOpen(frame) then
		isOpen = true
		Tablet:Open(frame, dummyFrame)		
	end
end

function Mapster_Notes:WorldMapUnit_OnLeave()
	isOpen = false
	Tablet:Close()
end

function Mapster_Notes:UpdateTooltip()
	self:GetCurrentPlayerPosition()
	if isOpen then
		Tablet:Refresh(dummyFrame)
	end
end

function Mapster_Notes:OnNoteMenuRequest(zone, id, data, level, value, level2, level3, level4, defaultMenu)
	if not data then
		return defaultMenu(level, value, level2, level3, level4);
	end

	--print(zone, id, level, value, level2, level3, level4);
end

do
	local cache = {}
	local num_pois = 0

	local OnMouseDown, OnMouseUp, OnEnter, OnLeave, OnClick, OnTabletRequest, OnLineRequest

	local function utf8trunc(str)
		local len = 0
		local needsTrunc = true
		for i = 1, 18 do
			local b = str:byte(len+1);
			if not b then
				needsTrunc = false;
			elseif b <= 127 then
				len = len + 1
			elseif b <= 223 then
				len = len + 2
			elseif b <= 239 then
				len = len + 3
			else
				len = len + 4
			end
		end
		if needsTrunc then
			return str:sub(1, len).."..."
		else
			return str
		end
	end

	local dummy
	local function newpoi(minimap)
		local frame = next(cache)
		if frame then
			cache[frame] = nil
			frame:Show()
			frame.minimap = minimap
			if minimap then
				frame:SetPoint("CENTER", Minimap, "CENTER");
				frame:SetFrameStrata(Minimap:GetFrameStrata());
				frame:SetFrameLevel(5);
				frame:SetFrameLevel(Minimap:GetFrameLevel() + 2)
			else
				frame:SetPoint("CENTER", WorldMapButton, "CENTER");
				frame:SetFrameStrata(WorldMapButton:GetFrameStrata());
				frame:SetFrameLevel(WorldMapButton:GetFrameLevel() + 2)
			end
			frame:SetAlpha(1);
			return frame
		end

		num_pois = num_pois + 1

		local frame = CreateFrame("Button", "MapsterNotesPOI"..num_pois, WorldMapButton);
		frame:EnableMouse(true);
		frame:SetMovable(true);
		frame:SetWidth(16);
		frame:SetHeight(16);
		frame:SetPoint("CENTER", WorldMapButton, "CENTER");

		local texture = frame:CreateTexture(nil, "OVERLAY");
		frame.texture = texture
		texture:SetAllPoints(frame);
		texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");
		texture:SetTexCoord(0, 0.25, 0, 0.25)
		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		if not OnMouseDown then
			OnMouseDown = function(self, button)
				if button == "LeftButton" and self.manual and not self.minimap and IsAltKeyDown() then
					self.isMoving = true
					self:StartMoving()
				end
			end
		end
		frame:SetScript("OnMouseDown", OnMouseDown);

		if not OnMouseUp then
			OnMouseUp = function(self, button)
				if button == "LeftButton" then
					if self.isMoving then
						self:StopMovingOrSizing();
						self.isMoving = nil
						local x, y = self:GetCenter()
						local parent = self:GetParent()
						local left, top = parent:GetLeft(), parent:GetRight();
						local width = parent:GetWidth();
						local height = parent:GetHeight();
						x = (x-left)/width;
						y = (top - y) / height;
						x, y = round(x , 3), round(y , 3);
						if x>1 then
							x = 1
						end
						if x < 0 then
							x = 0
						end
						if y > 1 then
							y = 1
						end
						if y < 0 then
							y = 0
						end
						local id = getID(x, y);
						if id ~= self.id then
							pois[id] = pois[self.id]
							pois[self.id] = nil
							local t, db = getpoi(self.zone, self.id)
							forceNextMinimapUpdate = true;
							if db then
								local v = Mapster_Notes.externalDBs[db]
								v[self.zone][id] = t
								v[self.zone][self.id] = nil
								Mapster_Notes:ShowNote(self.zone, id, db)
							else
								Mapster_Notes.db.char.pois[self.zone][id] = t
								Mapster_Notes.db.char.pois[self.zone][self.id] = nil
								Mapster_Notes:ShowNote(self.zone, id, t.creator or "")
							end
						end
					end
				end
			end
		end
		frame:SetScript("OnMouseUp", OnMouseUp);
		
		if not OnEnter then
			OnEnter = function(self)
				-- TODO: 3.3取消注释
				--WorldMapBlobFrame:SetScript("OnUpdate", nil)
				-- print(self.pluginName)
				Mapster_Notes:WorldMapUnit_OnEnter(self)	;
				-- WorldMapUnit_OnEnter(self)
			end
		end
		frame:SetScript("OnEnter", OnEnter);

		--OnTabletRequest
		if not OnTabletRequest then
			OnTabletRequest = function(self)
				if Mapster_Notes.handlers[self.creator] and type(Mapster_Notes.handlers[self.creator].OnNoteTooltipRequest) == "function" then
					local data = getrawpoi(self.zone, self.id, self.creator);
					if data then
						Mapster_Notes.handlers[self.creator]:OnNoteTooltipRequest(self.zone, self.id, data, self.minimap)
						return
					end
				end
				Tablet:SetTitle(self.title);
				Tablet:SetTitleColor(getRGB(self.titleCol));

				if self.info and self.info ~= "" then
					local r, g, b = getRGB(self.infoCol);
					Tablet:AddCategory(
						'hideBlankLine', true
					):AddLine(
						'text', self.info,
						'textR', r,
						'textG', g,
						'textB', b,
						'wrap', true
					)
				end
				if self.info2 and self.info2 ~= "" then
					local r, g, b = getRGB(self.info2Col);
					Tablet:AddCategory(
						'hideBlankLine', true
					):AddLine(
						'text', self.info2,
						'textR', r,
						'textG', g,
						'textB', b,
						'wrap', true
					)
				end

				if not self.minimap and Mapster_Notes:IsShowingYardsAway() then
					local x, y = getXY(self.id);
					local dist = Mapster_Notes:GetDistanceToPoint(x, y, self.zone);
					if dist then
						Tablet:AddCategory(
							'columns', 2,
							'hideBlankLine', true
						):AddLine(
							'text', L['Range'],
							'text2', yardString:format(dist)
						);
					end
				end
				if not self.minimap and Mapster_Notes:IsShowingCreator() and self.creator and self.creator ~= "" then
					Tablet:AddCategory(
						'columns', 2,
						'hideBlankLine', true
					):AddLine(
						'text', L["Creator: "],
						'text2', self.creator
					)
				end
			end
		end
		frame.OnTabletRequest = OnTabletRequest

		if not OnLineRequest then
			local tmp = {}
			OnLineRequest = function(self)
				if Mapster_Notes.handlers[self.creator] and type(Mapster_Notes.handlers[self.creator].OnNoteTooltipLineRequest) == 'function' then
					local data = getrawpoi(self.zone, self.id, self.creator);
					if data then
						local left, top, _, _, _, _, right, bottom = self.texture:GetTexCoord()
						local r, g, b = self.texture:GetVertexColor()
						return 'hasCheck', true,
							'checked', true,
							'checkIcon', self.texture:GetTexture(),
							'checkCoordLeft', left,
							'checkCoordRight', right,
							'checkCoordTop', top,
							'checkCoordBottom', bottom,
							'checkColorR', r,
							'checkColorG', g,
							'checkColorB', b,
							Mapster_Notes.handlers[self.creator]:OnNoteTooltipLineRequest(self.zone, self.id, data, self.minimap);
					end
				end

				tmp[#tmp+1] = ("|cff%06x"):format(self.titleCol)
				tmp[#tmp+1] = self.title;
				tmp[#tmp+1] = "|r";

				if self.info and self.info ~= "" then
					tmp[#tmp+1] = " - ";
					tmp[#tmp+1] = ("|cff%06x"):format(self.infoCol)
					local info = self.info
					info = utf8trunc(info)
					tmp[#tmp+1] = info
					tmp[#tmp+1] = "|r"
				end

				if not self.minimap and Mapster_Notes:IsShowingCreator() and self.creator and self.creator ~= "" then
					tmp[#tmp+1] = " - ";
					tmp[#tmp+1] = self.creator
				end

				local text = table.concat(tmp, " ");

				for i = 1, #tmp do
					tmp[i] = nil
				end

				local left, top, _,_,_,_,right, bottom =self.texture:GetTexCoord();
				local r, g, b = self.texture:GetVertexColor();
				return 'text', text,
					'hasCheck', true,
					'checked', true,
					'checkIcon', self.texture:GetTexture(),
					'checkCoordLeft', left,
					'checkCoordRight', right,
					'checkCoordTop', top,
					'checkCoordBottom', bottom,
					'checkColorR', r,
					'checkColorG', g,
					'checkColorB', b

			end
		end
		frame.OnLineRequest = OnLineRequest

		if not OnLeave then
			OnLeave = function(self)
				-- TODO: 3.3取消注释
				--WorldMapBlobFrame:SetScript("OnUpdate", WorldMapBlobFrame_OnUpdate)
				WorldMapUnit_OnLeave()
				WorldMapTooltip:Hide();
			end
		end
		frame:SetScript("OnLeave", OnLeave);
		Mapster_Notes:AddPOI(frame);

		do
			local poi
			local function closeFunc()
				CloseMenus();
			end
			local function editNoteFunc()
				closeFunc()
				Mapster_Notes:ShowEditDialog(poi.zone, poi.id)
			end
			local function deleteNoteFunc()
				closeFunc()
				Mapster_Notes:DeleteNote(poi.zone, poi.id)
			end
			local function sendNoteToGroupFunc()
				closeFunc()
				if getrawpoi(poi.zone, poi.id) then
					Mapster_Notes:SendNoteToGroup(poi.zone, getXY(poi.id))
				end
			end
			local function sendNoteToGuildFunc()
				closeFunc()
				if getrawpoi(poi.zone, poi.id) then
					local x, y = getXY(poi.id)
					Mapster_Notes:SendNoteToGuild(poi.zone, x, y)
				end
			end
			local function sendNoteToPlayerFunc(player)
				closeFunc()
				if getrawpoi(poi.zone, poi.id) then
					local x, y = getXY(poi.id)
					Mapster_Notes:SendNoteToPlayer(poi.zone, x, y, player)
				end
			end
			--右键目录
			local function generateMenu(button, level, menuList)
				if (not level) then return end
				if level == 1 then
					local info = UIDropDownMenu_CreateInfo()
					if poi.manual then
						info.text = L["Edit note"];
						info.func = editNoteFunc;
						UIDropDownMenu_AddButton(info, level)
					end
					local info = UIDropDownMenu_CreateInfo()
					if poi.manual or not Mapster_Notes.cantDelete[poi.creator] then
						info.text = L['Delete note'];
						info.func = deleteNoteFunc;
						UIDropDownMenu_AddButton(info, level)
					end
					local info = UIDropDownMenu_CreateInfo()
					info.text = L['Send'];
					info.hasArrow = true;
					info.menuList = "send"
					UIDropDownMenu_AddButton(info, level)
					
					local info = UIDropDownMenu_CreateInfo()
					info.text = CANCEL
					info.func = closeFunc()
					UIDropDownMenu_AddButton(info, level)
				elseif level == 2 then
					if (menuList == "send") then
						local bit = false
						if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
							local info = UIDropDownMenu_CreateInfo()
							info.text = L["Send to Party/Raid"];
							info.func = deleteNoteFunc;
							UIDropDownMenu_AddButton(info, level)
							bit =true
						end
						if IsInGuild() then
							local info = UIDropDownMenu_CreateInfo()
							info.text = L["Send to guild"];
							info.func = sendNoteToGuildFunc;
							UIDropDownMenu_AddButton(info, level)
							bit = true;
						end
						if bit then
							local info = UIDropDownMenu_CreateInfo()
							info.text = "";
							info.notClickable = true
							UIDropDownMenu_AddButton(info, level)
						end
						--[[
						local info = UIDropDownMenu_CreateInfo()
						info.text = L["Send to player"];
						info.tooltipTitle = L["Send to player"];
						info.]]
						--[[
						Dewdrop:AddLine(
											"text", L["Send to player"],
											"tooltipTitle", L["Send to player"],
											"hasArrow", true,
											"hasEditBox", true,
											"editBoxText", UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") or nil,
											'editBoxFunc', sendNoteToPlayerFunc
										);]]
					end
				end
			end
			
			local MNDropDownMenu = CreateFrame("Frame", "MNDropDownMenu")
			MNDropDownMenu.displayMode = "MENU"
			MNDropDownMenu.initialize = generateMenu

			if not OnClick then
				OnClick = function(this, button)
					if this.minimap then
						_G.this = minimap
						local f = Minimap:GetScript("OnMouseDown")
						if f then
							f(Minimap, button)
						end
						f = Minimap:GetScript("OnMouseUp");
						if f then
							f(Minimap, button)
						end
						return
					end
					if button == "LeftButton" then
						if Mapster_Notes.handlers[this.creator] and type(Mapster_Notes.handlers[this.creator].OnNoteClick) == "function" then
							local data = getrawpoi(this.zone, this.id, this.creator);
							if data then
								Mapster_Notes.handlers[this.creator]:OnNoteClick(this.zone, this.id, data)
							end
						end
					elseif button == "RightButton" then
						--[[
						if not dummy then
							dummy = CreateFrame("Frame");
							local function editNoteFunc()
								Mapster_Notes:ShowEditDialog(poi.zone, poi.id)
								Dewdrop:Close()
							end
							local function deleteNoteFunc()
								Mapster_Notes:DeleteNote(poi.zone, poi.id)
							end
							local function closeFunc()
								Dewdrop:Close()
							end
							
							local function sendNoteToGuildFunc()
								if getrawpoi(poi.zone, poi.id) then
									local x, y = getXY(poi.id)
									Mapster_Notes:SendNoteToGuild(poi.zone, x, y)
								end
							end
							local function sendNoteToGroupFunc()
								if getrawpoi(poi.zone, poi.id) then
									Mapster_Notes:SendNoteToGroup(poi.zone, getXY(poi.id))
								end
							end
							local function defaultMenu(level, value, level2, level3, level4)
								if level == 1 then
									if poi.manual then
										Dewdrop:AddLine(
											'text', L["Edit note"],
											'func', editNoteFunc
										)
									end
									if poi.manual or not Mapster_Notes.cantDelete[poi.creator] then
										Dewdrop:AddLine(
											'text', L['Delete note'],
											'func', deleteNoteFunc
										)
									end

									Dewdrop:AddLine(
										"text", L["Send"],
										"hasArrow", true,
										"value", "send"
									);

									Dewdrop:AddLine()

									Dewdrop:AddLine(
										'text', CANCEL,
										'func', closeFunc
									)
								elseif level == 2 then
									if value == "send" then
										local bit = false
										if GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0 then
											Dewdrop:AddLine(
												"text", L["Send to Party/Raid"],
												"func", sendNoteToGroupFunc
											)
											bit =true
										end
										if IsInGuild() then
											Dewdrop:AddLine(
												"text", L["Send to guild"],
												"func", sendNoteToGuildFunc
											);
											bit = true;
										end

										if bit then
											Dewdrop:AddLine()
										end

										Dewdrop:AddLine(
											"text", L["Send to player"],
											"tooltipTitle", L["Send to player"],
											"hasArrow", true,
											"hasEditBox", true,
											"editBoxText", UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") or nil,
											'editBoxFunc', sendNoteToPlayerFunc
										);
									end
								end
							end
							Dewdrop:Register(dummy,
								'children', function(level, value, level2, level3, level4)
									--if Mapster_Notes.handlers[poi.creator] and type(Mapster_Notes.handlers[poi.creator].OnNoteMenuRequest == "function") then
									--	local data = getrawpoi(poi.zone, poi.id, poi.creator);
									--	if data then
									--		Mapster_Notes.handlers[poi.creator]:OnNoteMenuRequest(poi.zone, poi.id, data, level, value, level2, level3, level4, defaultMenu)
									--	end
									--else
										defaultMenu(level, value, level2, level3, level4)
									--end
								end,
								'dontHook', true
							)
						end]]
						poi = this
						if Dewdrop:IsOpen(poi) then
							Dewdrop:Close()
							poi:GetScript("OnEnter")(poi)
						else
							ToggleDropDownMenu(1, nil, MNDropDownMenu, poi, 0, 0)
							Tablet:Close()
							--Dewdrop:Open(poi, dummy)
						end
					end
				end
			end
			frame:SetScript("OnClick", OnClick);
		end

		frame:Hide();
		cache[frame] = true
		return newpoi(minimap)
	end

	local function delpoi(x)
		x:Hide()
		cache[x] = true
		return nil
	end

	local del = function(self, id)
		if id == 'del' then
			return
		end
		local x = rawget(self, id);
		self[id] = nil
		if x then
			delpoi(x)
		end
	end

	local __index = function(self, id)
		local frame = newpoi(self == minimapPois)
		self[id] = frame
		return frame
	end
	
	pois = setmetatable({ del = del }, { __index = __index })
	minimapPois = setmetatable({ del = del }, { __index = __index })
end

function Mapster_Notes:AddPOI(frame)
	if not self.pois then
		self.pois = {}
	end
	self.pois[frame] = true
end

function Mapster_Notes:GetCurrentEnglishZoneName()
	local map = GetMapInfo();
	if not map then
		if GetCurrentMapZone() == 0 then
			if GetCurrentMapContinent() == 0 then
				return "Azeroth"
			elseif GetCurrentMapContinent() == -1 then
				return "Cosmic map"
			end
		end
	end
	return Tourist:GetEnglishZoneFromTexture(map);
end

--xx
function Mapster_Notes:GetCurrentLocalizedZoneName()
	local map = GetMapInfo();
	if not map then
		if GetCurrentMapZone() == 0 then
			if GetCurrentMapContinent() == 0 then
				return BZL["Azeroth"];
			elseif GetCurrentMapContinent() == -1 then
				return BZL["Cosmic map"];
			end
		end
	end

	return Tourist:GetZoneFromTexture(map)
end

local currentYardWidth, currentYardHeight = 1000, 1000 * 2/3
do
	local last_px, last_py

	local x, y, zone
	function Mapster_Notes:GetCurrentPlayerPosition()
		local px, py = GetPlayerMapPosition("player");
		if px == last_px and py == last_py and x ~= nil then
			return x, y, zone
		end
		last_px, last_py = px, py
		if px == 0 or py == 0 or (IsInInstance() and select(2, IsInInstance()) ~= "PVP") then
			return x, y, zone
		end
		local pz = GetRealZoneText();
		if Tourist:IsInstance(pz) then
			px, py, pz = Tourist:GetBestZoneCoordinate(px, py, self:GetCurrentLocalizedZoneName());
		else
			px, py, pz = Tourist:GetBestZoneCoordinate(px, py, self:GetCurrentLocalizedZoneName(), pz)
		end
		if px and py then
			x, y, zone = px, py, BZR[pz]
		end

		return x, y, zone
	end 
end

function Mapster_Notes:GetDistanceToPoint(x, y, zone, px, py, pzone)
	if not px then
		px, py, pzone = self:GetCurrentPlayerPosition();
		if pzone then
			pzone = BZL[pzone]
		end
	end
	if px == 0 or py == 0 or not px or not py then
		return nil
	end
	if pzone and BZH[pzone] then
		pzone = BZL[pzone]
	end
	if zone and BZH[zone] then
		zone = BZL[zone]
	end

	if not zone then
		zone = GetRealZoneText()
	end
	if not pzone then
		pzone = zone
	end
	
	
	--Astrolabe:ComputeDistance();
	local dist = Tourist:GetYardDistance(zone, x, y, pzone, px, py);
	return dist
end

local cache = {}
function Mapster_Notes:SetNote(zone, x, y, icon, creator, ...)
	local self = Mapster_Notes;
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
			error(("%q未知区域.."):format(zone), 2)
		end
	end
	
	local usingDB = self.externalDBs[creator] and creator or nil
	
	local id = getID(x, y);

	if usingDB and not self.externalDBs[creator][zone] then
		self.externalDBs[creator][zone] = {}
	end
	local zoneData = usingDB and self.externalDBs[creator][zone] or self.db.char.pois[zone]
	local oldData = rawget(zoneData, id);
	
	if type(oldData) == "table" then
		local tmp = oldData
		oldData = cache
		for k, v in pairs(tmp) do
			oldData[k] = v
		end
	end

	local k1 = ...
	if not k1 and usingDB then
		zoneData[id] = icon
	else
		local t
		if not zoneData[id] then
			zoneData[id] = {}
		end
		t = zoneData[id]
		for k, v in pairs(t) do
			t[k] = nil
		end
		
		if (type(k1) ~= "table") then
			for i=1, select("#", ...), 2 do
				local k = select(i, ...);
				if k then
					t[k] = select(i+1, ...)
				else
					break;
				end
			end
		else
			for k, v in pairs(k1) do
				t[k] = v
			end
		end

		t.icon = icon
		if not usingDB then
			t.creator = creator
		end
		local defaults = usingDB and self.handlers[creator] and self.handlers[creator].noteDefaults
		if (type(defaults) ~= "table") then
			defaults = nil
		end
		
		--7.2 暂时去除此功能
		--[[
		local oldId = t.oldId
		t.oldId = nil
		if oldId and t.oldId ~= id then
			local oldicon
			if rawget(zoneData, oldId) then
				oldicon = zoneData[oldId]
				zoneData[oldId] = nil
				if (type(oldicon) == "table") then
					oldicon = oldicon.icon
				end
			end
			if zone == self:GetCurrentEnglishZoneName() then
				pois[id] = pois[oldId]
				pois[oldId] = nil
			end
			if oldicon then
				local oldx, oldy = getXY(oldId);
				--执行删除
				self:SendMessage("NoteDeleted", zone, oldx, oldy, oldicon, usingDB);
			end
		end]]

		if t.title == getIconTitle(icon) or t.title == "" then
			t.title = nil
		end
		if t.titleR or t.titleG or t.titleB then
			local r, g, b = t.titleR or 1, t.titleG or 1, t.titleB or 1
			t.titleR,t.titleG,t.titleB = nil
			local colorID = getColorID(r, g, b);
			t.titleCol = colorID
		end
		if t.titleCol == (defaults and defaults.titleCol or whiteColorID) then
			t.titleCol = nil
		end
		 --1
		if t.info == ( defaults and defaults.info or "") then
			t.info = nil
		end
		if t.infoR or t.infoG or t.infoB then
			local r, g, b = t.infoR or 1, t.infoG or 1, t.infoB or 1;
			t.infoR, t.infoG, t.infoB = nil
			local colorID = getColorID(r, g, b)
			t.infoCol = colorID
		end
		if t.infoCol == (defaults and defaults.infoCol or whiteColorID) then
			t.infoCol = nil
		end
		 --2
		if t.info2 == ( defaults and defaults.info or "") then
			t.info2 = nil
		end
		if t.info2R or t.info2G or t.info2B then
			local r, g, b = t.info2R or 1, t.info2G or 1, t.info2B or 1;
			t.info2R, t.info2G, t.info2B = nil
			local colorID = getColorID(r, g, b)
			t.info2Col = colorID
		end
		if t.info2Col == (defaults and defaults.info2Col or whiteColorID) then
			t.info2Col = nil
		end

		if usingDB then
			t.creator = nil
			t.manual = nil
		end

		if creator == "" then
			t.creator = nil
		end
		if next(t) == "icon" and next(t, "icon") == nil then
			zoneData[id] = t.icon
		end
	end

	local diff = false
	local newData = zoneData[id]
	if type(oldData) ~= type(newData) then
		diff = true
	elseif type(oldData) ~= "table" then
		diff = oldData ~= newData
	else
		for k, v in pairs(oldData) do
			if newData[k] ~= v then
				diff = true
				break
			end
		end
		if not diff then
			for k, v in pairs(newData) do
				if oldData[k] ~= v then
					diff = true
					break
				end
			end
		end
	end
	for k, v in pairs(cache) do
		cache[k] = nil
	end
	if not diff then
		return false
	end
	
	zoneData[id] = zoneData[id]

	forceNextMiniMapUpdate = true
	if zone ~= self:GetCurrentEnglishZoneName() then
		return true
	end
	
	self:ShowNote(zone, id, usingDB);
	return true
end

function Mapster_Notes:GetNote(zone, x, y)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
		end
	end
	local id = getID(x, y)
	local data, db = getrawpoi(zone, id)
	if not data then
		return 
	end
	return zone, x, y, type(data) == "string" and data or data.icon, db, data
end

function Mapster_Notes:DeleteNote(zone, x, y)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
			--error(("Trying to destroy a note with an unknown zone: %q"):format(zone), 2)
		end
	end

	local id;
	if not y then
		id = x
		x, y = getXY(id)
	else
		id = getID(x, y)
	end

	local t, db = getrawpoi(zone, id)
	if not t then
		
	end
	if db then
		self.externalDBs[db][zone][id] = nil
	else
		self.db.char.pois[zone][id] = nil
	end

	local icon = t
	if (type(icon) == "table") then
		icon = icon.icon
	end

	if zone == Mapster_Notes:GetCurrentEnglishZoneName() then
		pois:del(id)
	end

	forceNextMinimapUpdate  = true
end

function Mapster_Notes:ShowNote(zone, id, creator)
	local note_trans, note_scale, note_icon
	local default_titleCol, default_info, default_infoCol, default_info2, default_info2Col = whiteColorID, "", whiteColorID, "", whiteColorID
	local gdb = db --save global db

	local localeHandler
	if creator then
		local handler = self.handlers[creator]
		localeHandler = handler and handler.noteLocaleHandler
		local defaults = handler and handler.noteDefaults
		if type(defaults) ~= "table" then
			defaults = nil
		end
		local data = getrawpoi(zone, id, creator)
		if not data then
			return
		end
		-- check note hidden or not
		if handler and handler.IsNoteHidden and handler:IsNoteHidden(zone, id, data) then
			return
		end
		-- creator DB scaling and transparency overrides
		if handler and handler.GetNoteTransparency then
			note_trans = handler:GetNoteTransparency(zone,id,data)
			-- ensure transparency withing range
			if note_trans and (note_trans < 0 or note_trans > 1) then note_trans = nil end
		end
		-- per creator scaling overrides
		if handler and handler.GetNoteScaling then
			note_scale = handler:GetNoteScaling(zone,id,data)
			if note_scale and (note_scale < 0.5 or note_scale > 2) then note_scale = nil end
		end
		-- per creator icon overrides
		if handler and handler.GetNoteIcon then
			note_icon = handler:GetNoteIcon(zone,id,data)
			if type(note_icon) ~= 'string' then note_icon = nil end
		end

		if defaults then
			default_titleCol = defaults.titleCol or whiteColorID
			default_info = defaults.info or ""
			default_infoCol = defaults.infoCol or whiteColorID
			default_info2 = defaults.info2 or ""
			default_info2Col = defaults.info2Col or whiteColorID
		end
	end
	
	local data, db = getpoi(zone, id);
	local poi = pois[id]
	poi.zone = zone
	local icon;
	local creator = db or data.creator or ""

	if type(data) == "string" then
		poi.title = getIconTitle(data);
		poi.titleCol = default_titleCol
		poi.info = default_info
		poi.infoCol = default_infoCol
		poi.info2 = default_info2
		poi.info2Col = default_info2Col
		poi.manual = false
		icon = note_icon or data
	else
		poi.title = data.title or getIconTitle(data.icon)
		poi.titleCol = data.titleCol or default_titleCol
		poi.info = data.info or default_info
		poi.infoCol = data.infoCol or default_infoCol
		poi.info2 = data.info2 or default_info2
		poi.info2Col = data.info2Col or default_info2Col
		poi.icon = data.icon
		poi.manual = data.manual or false
		icon = note_icon or data.icon
	end
	
	
	if localeHandler then
		if poi.title ~= getIconTitle(type(data) == "string" and data or data.icon) and localeHandler:HasTranslation(poi.title) then
			poi.title = localeHandler:GetTranslation(poi.title)
		end
		if poi.info ~= "" and localeHandler:HasTranslation(poi.info) then
			poi.info = localeHandler:GetTranslation(poi.info)
		end
		if poi.info2 ~= "" and localeHandler:HasTranslation(poi.info2) then
			poi.info2 = localeHandler:GetTranslation(poi.info2)
		end
	end

	poi.icon = icon
	poi.creator = creator
	poi.id = id

	local button = WorldMapButton
	poi:SetParent(button);

	if type(icon) == "string" and icon:find("^Interface\\") then
		if note_scale then
			poi:SetWidth(16*self.db.profile.iconSize*note_scale)
			poi:SetHeight(16*self.db.profile.iconSize*note_scale)
		else
			poi:SetWidth(16*self.db.profile.iconSize)
			poi:SetHeight(16*self.db.profile.iconSize)
		end
		-- Note transparency overrides
		if note_trans then
			poi:SetAlpha(note_trans)
		else
			poi:SetAlpha(1)
		end
		poi.texture:SetTexture(icon)
		if icon:find("^Interface\\Icons\\") then
			poi.texture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		else
			poi.texture:SetTexCoord(0, 1, 0, 1)
		end
	else
		local t = icons[icon]
		if not t then
			t = icons.Unknown
		end
		if note_scale then
			poi:SetWidth(t.width*gdb.iconSize*note_scale)
			poi:SetHeight(t.height*gdb.iconSize*note_scale)
		else
			poi:SetWidth(t.width*gdb.iconSize)
			poi:SetHeight(t.height*gdb.iconSize)
		end
		-- Note transparency overrides
		if note_trans then
			poi:SetAlpha(note_trans)
		else
			poi:SetAlpha(t.alpha)
		end
		poi.texture:SetTexture(t.path)
		poi.texture:SetTexCoord(t.cLeft, t.cRight, t.cTop, t.cBottom)
	end
	poi:Show()
	
	poi:ClearAllPoints()
	local x, y = getXY(id)
	poi:SetPoint("CENTER", button, "TOPLEFT", x * button:GetWidth(), -y * button:GetHeight())
end

do
	local searchResults = {}
	function Mapster_Notes:FindZone(search, destTable, iterFunc, iterTable, iterKey)
		if not destTable then
			while #searchResults > 0 do
				table.remove(searchResults)
			end

			destTable = searchResults
		end

		local exact = nil
		if not iterFunc then
			iterFunc, iterTable, iterKey = Tourist:IterateZonesAndInstances()
		end

		local lzone
		for zone in iterFunc, iterTable, iterKey do
			if not search then
				table.insert(destTable, zone)
			else
				lzone = zone:lower()

				if lzone == search then
					table.insert(destTable, zone);
					exact = zone
				elseif lzone:find(search) then
					table.insert(destTable, zone)
				end
			end
		end

		if exact then
			return exact
		end

		return unpack(destTable)
	end
end

local lastMap = nil
function Mapster_Notes:ClearMap()
	for k, v in pairs(pois) do
		pois:del(k)
	end
	lastMap = nil
end

local forceRefresh
local function RefreshMap()
	local force = forceRefresh
	forceRefresh = nil
	local zone = Mapster_Notes:GetCurrentEnglishZoneName()
	if not zone then
		Mapster_Notes:ClearMap()
		return
	end
	if zone == lastMap and force == false then
		return
	end
	Mapster_Notes:ClearMap()
	if rawget(Mapster_Notes.db.char.pois, zone) then
		for id in pairs(Mapster_Notes.db.char.pois[zone]) do
			Mapster_Notes:ShowNote(zone, id, false)
		end
	end

	for k, v in pairs(Mapster_Notes.externalDBs) do
		if rawget(v, zone) then
			for id in pairs(v[zone]) do
				Mapster_Notes:ShowNote(zone, id, k)
			end
		end
	end
	lastMap = zone
	forceNextMinimapUpdate = true
end

function Mapster_Notes:RefreshMap(value)
	forceRefresh = (value == nil) or forceRefresh or value
	if WorldMapFrame:IsShown() then
		self:ScheduleTimer(RefreshMap, 0)
	end
end

function Mapster_Notes:ToggleFrame(frame)
	if (not frame) or (frame ~= WorldMapFrame) then return end
	if MapsterNotesNewNoteFrame then
		MapsterNotesNewNoteFrame:Hide()
	end
	if not WorldMapFrame:IsShown() then
		self:ClearMap()
	else
		self:RefreshMap(false)
	end
end

function Mapster_Notes:RegisterNotesDatabase(name, db, handler, cantDelete)
	upgradeDatabase(db)

	self.externalDBs[name] = db
	self.handlers[name] = handler
	self.cantDelete[name] = not not cantDelete

	for zone, zdata in pairs(self.db.char.pois) do
		if type(zdata) == "table" then
			for id, data in pairs(zdata) do
				if data.creator == name then
					zdata[id] = nil
					if not db[zone] then
						db[zone] = {}
					end
					if not rawget(db[zone], id) then
						db[zone][id] =data
						data.creator = nil
						data.manual = nil
						if next(data) == 'icon' and next(data, 'icon') == nil then
							db[zone][id] = data.icon
						end
					end
				end
			end
		end
	end

	if WorldMapFrame:IsShown() then
		local zone = self:GetCurrentEnglishZoneName()
		if rawget(db, zone) then
			for id in pairs(db[zone]) do
				self:ShowNote(zone, id, name)
			end
		end
	end
end

function Mapster_Notes:UnregisterNotesDatabase(name)
	local t = self.externalDBs[name]
	self.externalDBs[name] = nil
	self.handlers[name] = nil
	local zone = self:GetCurrentEnglishZoneName()
	if rawget(t, zone) then
		for id in pairs(t[zone]) do
			pois:del(id)
		end
	end
end

--[[  send  ]]--
function Mapster_Notes:SendNoteToPlayer(zone, x, y, player)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
		end
	end

	local data, db = getrawpoi(zone, getID(x, y));

	if not data then
		return 
	end
		--SendChatMessage("text" [,"chatType" [,"language" ] [,"channel"]])
	--send msg
	--data.quest
	--目前只对 questhelper进行服务
	local tmpText;
	if db == "QuestHelper" then
		if data.title then
			tmpText = data.title
		else
			tmpText = data.name
		end
		local msgText = data.quest.."  "..tmpText..L[" at "]..zone.." "..format("<%d, %d>", x*100, y*100);
		--print(msgText, player)
		SendChatMessage(msgText, "WHISPER", nil, player)
	end
	return true
end

local function sendNote(channel, zone, x, y)
	local data, db = getrawpoi(zone, getID(x, y));

	if not data then
		return
	end
	
	local tmpText;
		--for questehelper db must have QuestHelper chars!
	if db == "QuestHelper" then
		if data.title then
			tmpText = data.title
		else
			tmpText = data.name
		end
		local str = "";
		if type(data.quest) == "table" then
			for k, v in pairs(data.quest) do
				str = str .. tostring(v);
			end
		elseif type(data.quest) == "string" then
			str = data.quest;
		end
		local msgText = str.."  "..tmpText..L[" at "]..zone.." "..format("<%d, %d>", x*100, y*100);
			--guild/party/raid channel
		SendChatMessage(msgText, channel)
	end

	return true
end

local function getCurrentGroupStatus()
	if _G.MiniMapBattlefieldFrame.status == "actives" then
		return "BATTLEGROUND"
	elseif UnitInRaid("player") then
		return "RAID"
	else
		return "PARTY"
	end
end

function Mapster_Notes:SendNoteToGuild(zone, x, y)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
		end
	end

	if not IsInGuild() then
		return false
	end

	return sendNote("GUILD", zone, x, y)
end

function Mapster_Notes:SendNoteToGroup(zone, x, y)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		else
		end
	end

	if GetNumRaidMembers() > 0 or GetNumPartyMembers() then
		channel = getCurrentGroupStatus();
		return sendNote(channel, zone, x, y)
	end
	return false
end

--/*  end */--
--[[ OPTION ]]--
function Mapster_Notes:IsShowingYardsAway()
	return db.showYardsAway
end

function Mapster_Notes:IsShowingCreator()
	return db.showCreator
end

function Mapster_Notes:ToggleShowingCreator(_, value)
	if value == nil then
		value = not db.showCreator
	end
	db.showCreator = value
end

function Mapster_Notes:GetIconSize()
	return db.iconSize
end

function Mapster_Notes:SetIconSize(_, value)
	db.iconSize = value
	Mapster_Notes:RefreshMap()
end

function Mapster_Notes:IsShowingMinimapIcons()
	return db.showMinimapIcons
end

function Mapster_Notes:ToggleShowingMinimapIcons(_, value)
	if value == nil then
		value = not db.showMinimapIcons
	end
	db.showMinimapIcons = value

	if Mapster_Notes:IsActiveNote() then
		if not value then
			Mapster_Notes:CancelTimer("Mapster_Notes_MinimapIcons", true)
			Mapster_Notes:UnregisterEvent("MINIMAP_ZONE_CHANGED");
			Mapster_Notes:UnregisterEvent("MINIMAP_UPDATE_ZOOM");
			Mapster_Notes:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
			Mapster_Notes:UnregisterEvent("PLAYER_LEAVING_WORLD");
		else
			Mapster_Notes_MinimapIcons = Mapster_Notes:ScheduleRepeatingTimer("UpdateMinimapIcons", 0)
			Mapster_Notes:RegisterEvent("MINIMAP_ZONE_CHANGED");
			Mapster_Notes:RegisterEvent("MINIMAP_UPDATE_ZOOM");
			Mapster_Notes:RegisterEvent("ZONE_CHANGED_NEW_AREA");
			Mapster_Notes:RegisterEvent("PLAYER_LEAVING_WORLD");
			Mapster_Notes:MINIMAP_ZONE_CHANGED()
			Mapster_Notes:MINIMAP_UPDATE_ZOOM()
			Mapster_Notes:ZONE_CHANGED_NEW_AREA()
		end
	end
end

function Mapster_Notes:GetMinimapIconSize()
	return db.minimapIconSize
end

function Mapster_Notes:SetMinimapIconSize(_, value)
	db.minimapIconSize = value;
	forceNextMinimapUpdate = true
end

function Mapster_Notes:GetMinimapNotesPerDB()
	return db.notesPerDB
end

function Mapster_Notes:SetMinimapNotesPerDB(vaule)
	db.notesPerDB = value
	forceNextMinimapUpdate = true
end

function Mapster_Notes:IsActiveNote()
	return true;
	--return CQI:GetModuleEnabled(MODNAME)
end

function Mapster_Notes:ToggleActiveNote(_, value)
	--CQI:SetModuleEnabled(MODNAME, value)
	Mapster_Notes:ClearAllNotes()
end


function Mapster_Notes:ClearAllNotes()
	local zone = Mapster_Notes:GetCurrentEnglishZoneName();
	local zoneData
	zoneData = rawget(Mapster_Notes.db.char.pois, zone);

	if zoneData and next(zoneData) then
		for i, data in pairs(zoneData) do
			local x, y = getXY(i);
			Mapster_Notes:DeleteNote(zone, x, y);
		end
	end

	for k, v in pairs(Mapster_Notes.externalDBs) do
		local zoneData = rawget(v, zone)
		if zoneData and next(zoneData) then
			for i, data in pairs(zoneData) do
				local x, y = getXY(i);
				Mapster_Notes:DeleteNote(zone, x, y);
			end
		end
	end
end

---
local cache = {}
local function iter(t)
	t.id = t.id + 1
	local notes = t.notes

	local id = notes[t.id]
	if id then
		local data = t.zoneData[id]
		local x, y = getXY(id)

		return t.zone, x, y, type(data) == "string" and data or data.icon, t.creator, data
	end
	
	cache[t] = true
	for k in pairs(t) do
		t[k] = nil
	end

	cache[notes] = true
	for k in pairs(notes) do
		notes[k] = nil
	end
	return nil
end

local function retNil()
	return nil
end

local current_x, current_y
local current_using_yards
local function mysort(alpha, bravo)
	if not alpha or not bravo then
		return false
	end
	local a_x, a_y = getXY(alpha)
	local b_x, b_y = getXY(bravo)

	a_x, a_y = a_x - current_x, a_y - current_y
	b_x, b_y = b_x - current_x, b_y - current_y

	if current_using_yards then
		a_y = a_y * 2/3
		b_y = b_y * 2/3
	end
	return a_x*a_x + a_y*a_y < b_x*b_x + b_y*b_y
end

function Mapster_Notes:IterateNearbyNotes(zone, x, y, radius, creator, max_notes, use_yards)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		end
	end
	
	if not radius then
		radius = 1/10
	end

	if creator and not self.externalDBs[creator] then
		--error(("Database %q not registered."):format(creator), 2)
	end
	
	local zoneData
	if creator then
		zoneData = rawget(Mapster_Notes.externalDBs[creator], zone)
	else
		zoneData = rawget(Mapster_Notes.db.char.pois, zone)
	end
	
	if not zoneData or not next(zoneData) then
		return retNil
	end

	if creator then
		local handler = Mapster_Notes.handlers[creator];
		if handler and handler["GetRadius"] then
			radius = handler:GetRadius()
		end
	end

	local radius_2 = radius * radius

	local notes = next(cache) or {}

	cache[notes] = nil
	local yardWidthMult, yardHeightMult = 1, 1

	if use_yards then
		yardWidthMult, yardHeightMult = Tourist:GetZoneYardSize(BZL[zone])
		if not yardWidthMult then
			local yardWidthMult, yardHeightMult = 1000, 1000* 2/3
		end
	end

	for i, data in pairs(zoneData) do
		local x_p, y_p = getXY(i)
		local x_d = (x_p - x) * yardWidthMult
		local y_d = (y_p - y) * yardHeightMult
		if x_d * x_d + y_d*y_d <= radius_2 then
			tinsert(notes, i)
		end
	end

	current_x, current_y = x, y
	current_using_yards = using_yards
	table.sort(notes, mysort)
	
	current_x, current_y = nil, nil
	current_using_yards = nil

	if max_notes and max_notes > #notes then
		for i = max_notes + 1, #notes do
			notes[i] = nil
		end
	end

	local t = next(cache) or {}
	cache[t] = nil
	
	t.zoneData = zoneData
	t.zone = zone
	t.creator = creator
	t.notes = notes
	t.id = 0
	
	return iter, t, nil
end


function Mapster_Notes:GetNearbyNote(zone, x, y, radius, creator, use_yards)
	if not BZH[zone] then
		if BZR[zone] then
			zone = BZR[zone]
		end
	end
	if not radius then
		radius = 1/0
	end
	if creator and not self.externalDBs[creator] then
	--	error(("Database %q not registered."):format(creator), 2)
	end
	
	local zoneData
	if creator then
		zoneData = rawget(self.externalDBs[creator], zone)
	else
		zoneData = rawget(self.db.char.pois, zone)
	end
	if not zoneData or not next(zoneData) then
		return
	end
	local radius_2 = radius*radius
	
	local close_distance = 1/0
	local close_id
	
	local yardWidthMult, yardHeightMult = 1, 1
	if use_yards then
		yardWidthMult, yardHeightMult = Tourist:GetZoneYardSize(BZL[zone])
		if not yardWidthMult then
			yardWidthMult, yardHeightMult = 1000, 1000 * 2/3
		end
	end
	
	for id, data in pairs(zoneData) do
		local x_p, y_p = getXY(id)
		
		local x_d = (x_p - x) * yardWidthMult
		local y_d = (y_p - y) * yardHeightMult
		
		local d_2 = x_d*x_d + y_d*y_d
		
		if d_2 <= radius_2 and d_2 < close_distance then
			close_distance = d_2
			close_id = id
		end
	end
	if not close_id then
		return
	end
	local x_p, y_p = getXY(close_id)
	local data = zoneData[close_id]
	return zone, x_p, y_p, type(data) == "string" and data or data.icon, creator, data
end
--[[ minimap show ]] --
local MinimapSize = {
	["indoor"] = {
		[0] = 150,
		[1] = 120,
		[2] = 90,
		[3] = 60,
		[4] = 40,
		[5] = 25,
	},
	["outdoor"] = {
		[0] = 233 + 1/3,
		[1] = 200,
		[2] = 166 + 2/3,
		[3] = 133 + 1/6,
		[4] = 100,
		[5] = 66 + 2/3,
	}
}

local lastX, lastY = 1/0, 1/0;
local lastZoom = -1
local lastTracking
local indoors = 'outdoor'

local TRACK = {
	["Interface\\Icons\\Spell_Nature_Earthquake"] = "Mining",
	["Interface\\Icons\\INV_Misc_Flower_02"] = "Herbalism",
	["Interface\\Icons\\Racial_Dwarf_FindTreasure"] = "Treasure",
}

local FAKE_TRACK = {}

local function CheckToUpdateMinimapIcons(x_, y_, x, y, force)
	local self = Mapster_Notes
	if isInInstance then
		return
	end
	if not x then
		return
	end

	local diffX = (lastX - x);
	local diffY = (lastY - y);
	local distance_2 = diffX*diffX + diffY*diffY
	if not force and not forceNextMinimapUpdate and distance_2 < 5^2 then
		return
	end
	forceNextMinimapUpdate = false
	lastX, lastY = x, y
	local radius = MinimapSize[indoors][lastZoom]*2
	local radius_2 = radius*radius

	local zone = GetRealZoneText()

	for id, v in pairs(minimapPois) do
		if id ~= "del" then
			local idX, idY = self:PointToYards(getXY(id));
			local diffX, diffY = (x - idX), (y - idY)
			local distance_2 = diffX*diffX + diffY*diffY
			if distance_2 > radius_2 or not getrawpoi(zone, id) then
				minimapPois:del(id)
			end
		end
	end

	local db = nil
	local notesPerDB = self.db.profile.notesPerDB
	while true do
		db = next(self.externalDBs, db)
		for zone, x, y, icon, creator, data in self:IterateNearbyNotes(zone, x_, y_, radius, db, notesPerDB, true) do
			local id = getID(x, y)
			local note_icon
			local default_titleCol, default_info, default_infoCol, default_info2, default_info2Col = whiteColorID, "", whiteColorID, "", whiteColorID
			
			local continue = false
			if creator then
				local handler = self.handlers[creator]
				local defaults = handler and handler.noteDefaults
				if type(defaults) ~= "table" then
					defaults = nil
				end
				local data = rawget(self.externalDBs[creator], zone)
				if handler and handler.IsTracking and handler:IsTracking(zone,id,data) then
					FAKE_TRACK[creator] = true
				elseif FAKE_TRACK[creator] then
					FAKE_TRACK[creator] = nil
				end
				if not data then
					continue = true
				else
					data = rawget(data, id)
					if not data then
						continue = true
					elseif handler and handler.IsNoteHidden and handler:IsNoteHidden(zone, id, data) then
						continue = true
					elseif handler and handler.IsMiniNoteHidden and handler:IsMiniNoteHidden(zone,id,data) then
						continue = true
					elseif handler and handler.GetNoteIcon then
						note_icon = handler:GetNoteIcon(zone,id,data)
						if type(note_icon) ~= 'string' then note_icon = nil end
					end
				end
				if continue and rawget(minimapPois, id) then
					minimapPois:del(id)
				elseif defaults then
					default_titleCol = defaults.titleCol or whiteColorID
					default_info = defaults.info or ""
					default_infoCol = defaults.infoCol or whiteColorID
					default_info2 = defaults.info2 or ""
					default_info2Col = defaults.info2Col or whiteColorID
				end
			end
			if not continue then
				local poi = minimapPois[id]
				poi.zone = zone
				local icon
				local creator = db or data.creator or ""
				if type(data) == "string" then
					poi.title = getIconTitle(data)
					poi.titleCol = default_titleCol
					poi.info = default_info
					poi.infoCol = default_infoCol
					poi.info2 = default_info2
					poi.info2Col = default_info2Col
					poi.manual = false
					icon = note_icon or data
				else
					poi.title = data.title or getIconTitle(data.icon)
					poi.titleCol = data.titleCol or default_titleCol
					poi.info = data.info or default_info
					poi.infoCol = data.infoCol or default_infoCol
					poi.info2 = data.info2 or default_info2
					poi.info2Col = data.info2Col or default_info2Col
					poi.manual = data.manual or false
					icon = note_icon or data.icon
				end
				poi.creator = creator
				poi.id = id
				poi.icon = icon
				if self.developing == creator then
					poi.manual = true
				end
				if creator and (creator == TRACK[lastTracking] or FAKE_TRACK[creator]) then
					local poiX, poiY = Mapster_Notes:PointToYards(x, y)
					local diffX = lastX - poiX
					local diffY = lastY - poiY
					local distance_2 = diffX*diffX + diffY*diffY
					if distance_2 <= 100^2 then
						icon = path .. "TrackCircle"
					end
				end
				
				poi:SetParent(Minimap)
				if type(icon) == "string" and icon:find("^Interface\\") then
					poi:SetWidth(16*self.db.profile.minimapIconSize)
					poi:SetHeight(16*self.db.profile.minimapIconSize)
					poi:SetAlpha(1)
					poi.texture:SetTexture(icon)
					if icon:find("^Interface\\Icons\\") then
						poi.texture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
					else
						poi.texture:SetTexCoord(0, 1, 0, 1)
					end
				else
					local t = icons[icon]
					if not t then
						t = icons.Unknown
					end
					poi:SetWidth(t.width*self.db.profile.minimapIconSize)
					poi:SetHeight(t.height*self.db.profile.minimapIconSize)
					poi:SetAlpha(t.alpha)
					poi.texture:SetTexture(t.path)
					poi.texture:SetTexCoord(t.cLeft, t.cRight, t.cTop, t.cBottom)
				end
				poi:Show()
			end
			
		end
		if db == nil then
			break
		end
	end
end

local Minimap = Minimap
local rotateMinimap = GetCVar("rotateMinimap") == "1"
local lastX, lastY, lastFacing = 1/0, 1/0, 1/0

function Mapster_Notes:UpdateMinimapIcons()
	local self = Mapster_Notes
	if isInInstance then
		return
	end
	local x_, y_ = self:GetCurrentPlayerPosition()
	if not x_ or not y_ or x_ < 0 or x_ > 1 or y_ < 0 or y_ > 1 then
		for id in pairs(minimapPois) do
			minimapPois:del(id)
		end
		return
	end
	local x, y = self:PointToYards(x_, y_)
	if not x then
		return
	end
	local zoom = Minimap:GetZoom()
	local diffZoom = zoom ~= lastZoom
	local tracking = GetTrackingTexture()
	local diffTracking = tracking ~= lastTracking
	local GetMinimapShape = GetMinimapShape
	local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
	local facing
	if rotateMinimap then
		facing = -GetPlayerFacing()
	else
		facing = lastFacing
	end

	if diffZoom or diffTracking or x ~= lastX or y ~= lastY or facing ~= lastFacing or forceNextMinimapUpdate then
		lastZoom = zoom
		lastTracking = tracking
		lastFacing = facing
		local Minimap_Width = Minimap:GetWidth()/2
		lastX, lastY = x, y
		CheckToUpdateMinimapIcons(x_, y_, x, y, diffZoom)
		local radius = MinimapSize[indoors][lastZoom]
		for id, poi in pairs(minimapPois) do
			if id ~= 'del' then
				local px, py = self:PointToYards(getXY(id))
				local dx, dy = px - x, py - y
				if rotateMinimap then
					local sin = math.sin(facing)
					local cos = math.cos(facing)
					dx, dy = dx*cos - dy*sin, dx*sin + dy*cos
				end
				local diffX = dx / radius
				local diffY = dy / radius
				local dist
				local alpha = 1
				local round = true
				if minimapShape == "ROUND" then
					-- do nothing
				elseif minimapShape == "SQUARE" then
					round = false
				elseif minimapShape == "CORNER-TOPRIGHT" then
					if diffX < 0 or diffY > 0 then
						round = false
					end
				elseif minimapShape == "CORNER-TOPLEFT" then
					if diffX > 0 or diffY > 0 then
						round = false
					end
				elseif minimapShape == "CORNER-BOTTOMRIGHT" then
					if diffX < 0 or diffY < 0 then
						round = false
					end
				elseif minimapShape == "CORNER-BOTTOMLEFT" then
					if diffX > 0 or diffY < 0 then
						round = false
					end
				elseif minimapShape == "SIDE-LEFT" then
					if diffX > 0 then
						round = false
					end
				elseif minimapShape == "SIDE-RIGHT" then
					if diffX < 0 then
						round = false
					end
				elseif minimapShape == "SIDE-TOP" then
					if diffY > 0 then
						round = false
					end
				elseif minimapShape == "SIDE-BOTTOM" then
					if diffY < 0 then
						round = false
					end
				elseif minimapShape == "TRICORNER-TOPRIGHT" then
					if diffX < 0 and diffY > 0 then
						round = false
					end
				elseif minimapShape == "TRICORNER-TOPLEFT" then
					if diffX > 0 and diffY > 0 then
						round = false
					end
				elseif minimapShape == "TRICORNER-BOTTOMRIGHT" then
					if diffX < 0 and diffY < 0 then
						round = false
					end
				elseif minimapShape == "TRICORNER-BOTTOMLEFT" then
					if diffX > 0 and diffY < 0 then
						round = false
					end
				end
				if round then
					dist = (diffX*diffX + diffY*diffY) / 0.9^2
				else
					dist = math.max(diffX*diffX, diffY*diffY) / 0.9^2
				end
				if dist > 1 then
					dist = dist^0.5
					diffX = diffX/dist
					diffY = diffY/dist 
					alpha = 2 - dist*0.9
				end
				poi:SetPoint("CENTER", Minimap, "CENTER", diffX * Minimap_Width, -diffY * Minimap_Width)
				poi:SetAlpha(alpha)
			end
		end
	end
end

function Mapster_Notes:PointToYards(x, y, zone)
	local w, h
	if not zone or zone == GetRealZoneText() then
		w, h = currentYardWidth, currentYardHeight
	else
		w, h = Tourist:GetZoneYardSize(zone)
		if not w then
			w, h = 1000, 1000 * 2/3
		end
	end

	if x then
		return x * w, y * h
	end

	return nil, nil
end

function Mapster_Notes:configureYards()
	forceNextMinimapUpdate = true
	isInInstance = Tourist:IsInstance(GetRealZoneText())
	if isInInstance then
		for k,v in pairs(minimapPois) do
			minimapPois:del(k)
		end
	end
end

function Mapster_Notes:MINIMAP_ZONE_CHANGED()
	self:configureYards()
end

function Mapster_Notes:MINIMAP_UPDATE_ZOOM()
	forceNextMinimapUpdate = true
	local zoom = Minimap:GetZoom()
	if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
		Minimap:SetZoom(zoom < 2 and zoom + 1 or zoom - 1)
	end
	indoors = GetCVar("minimapZoom")+0 == Minimap:GetZoom() and "outdoor" or "indoor"
	Minimap:SetZoom(zoom)
	self:MINIMAP_ZONE_CHANGED()
end

function Mapster_Notes:ZONE_CHANGED_NEW_AREA()
	self:PLAYER_LEAVING_WORLD()
	self:MINIMAP_UPDATE_ZOOM()
	self:MINIMAP_ZONE_CHANGED()
end

function Mapster_Notes:PLAYER_LEAVING_WORLD()
	for k,v in pairs(minimapPois) do
		minimapPois:del(k)
	end
	forceNextMinimapUpdate = true
end

function Mapster_Notes:CVAR_UPDATE(event, cvar, value)
	if cvar == "ROTATE_MINIMAP" then
		rotateMinimap = value == "1"
	end
end

function CQI_ToggleMinimapIcons(switch)
	if (switch) then
		Mapster_Notes:ToggleShowingMinimapIcons(_, true);
	else
		Mapster_Notes:ToggleShowingMinimapIcons(_, false);
	end	
end

--CQI_ToggleMinimapIcons(false);