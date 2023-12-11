Cartographer_QuestInfo = LibStub("AceAddon-3.0"):NewAddon("IceQuestHelper", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0","AceTimer-3.0", "AceComm-3.0");
-------------------------------------------------------------------
local CQI = Cartographer_QuestInfo
local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");
local Gratuity = LibStub("LibGratuity-3.0")
local Quixote = LibStub("LibQuixote-2.0")

local CN;

-------------------------------------------------------------------
local defaults = {
	profile = {
		iconAlpha = 1,
		iconScale = 1,
		minimapIcons = true,
		cartoButton = true,
		showQuestTag = true,
		wideQuestLog = true,
		autoUpdate = false,
		trackedOnly = false,
		showAllAvail = false,
		availQuestTitle = false,
	},
}
-------------------------------------------------------------------

function CQI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("Cartographer_QuestInfoDB", defaults, UnitName("player").." - "..GetRealmName());
	CN = CQI:GetModule("Notes");
	local options = {
		--[[
		toggle = {
			name = L["Enabled"],
			desc = L["Suspend/resume this module."],
			type = "toggle",
			order = 10,
			get = function() return self:IsModuleActive(self) end,
			set = function() self:ToggleModuleActive(self) end,
		},
		]]
		iconalpha = {
			name = L["Icon alpha"],
			desc = L["Alpha transparency of the icon."],
			type = "range",
			min = 0.1,
			max = 1,
			step = 0.05,
			isPercent = true,
			get = function() return self.db.profile.iconAlpha end,
			set = function(v) self.db.profile.iconAlpha = v; CN:RefreshMap() end,
			order = 40
		},
		iconscale = {
			name = L["Icon size"],
			desc = L["Size of the icons on the map."],
			type = "range",
			min = 0.5,
			max = 2,
			step = 0.05,
			isPercent = true,
			get = function() return self.db.profile.iconScale end,
			set = function(v) self.db.profile.iconScale = v; CN:RefreshMap() end,
			order = 50
		},
		minimapicons = {
			name = L["Show minimap icons"],
			desc = L["Show quest icons on the minimap."],
			type = "toggle",
			get = function() return self.db.profile.minimapIcons end,
			set = function() self.db.profile.minimapIcons = not self.db.profile.minimapIcons; CN:RefreshMap() end,
			order = 60,
		},
		autoupdate = {
			name = L["Auto update quest icons"],
			desc = L["Auto update quest icons after quest or objective completed."],
			type = "toggle",
			get = function() return self.db.profile.autoUpdate end,
			set = function() self.db.profile.autoUpdate = not self.db.profile.autoUpdate end,
			order = 61,
		},
		trackedonly = {
			name = L["Update tracked quests only"],
			desc = L["Update tracked quests only, or update all active quests."],
			type = "toggle",
			disabled = function() return not self.db.profile.autoUpdate end,
			get = function() return self.db.profile.trackedOnly end,
			set = function() self.db.profile.trackedOnly = not self.db.profile.trackedOnly end,
			order = 62,
		},
		showallavail = {
			name = L["Show all quest givers"],
			desc = L["Show all quest givers, or just show givers around your level."],
			type = "toggle",
			get = function() return self.db.profile.showAllAvail end,
			set = function() self.db.profile.showAllAvail = not self.db.profile.showAllAvail end,
			order = 65,
		},
		availquesttitle = {
			name = L["Include giver's quest list"],
			desc = L["Include quest list when showing quest givers, or just show the number of quests (which is much faster)."],
			type = "toggle",
			get = function() return self.db.profile.availQuestTitle end,
			set = function() self.db.profile.availQuestTitle = not self.db.profile.availQuestTitle end,
			order = 66,
		},
		worldmapicon = {
			name = L["Show world map button"],
			desc = L["Show button on the world map."],
			type = "toggle",
			get = function() return self.db.profile.cartoButton end,
			set = function() self:ToggleCartoButton() end,
			order = 70,
		},
		showquesttag = {
			name = L["Show quest level"],
			desc = L["Show quest level in quest log and NPC dialog."],
			type = "toggle",
			get = function() return self.db.profile.showQuestTag end,
			set = function() self.db.profile.showQuestTag = not self.db.profile.showQuestTag end,
			order = 80,
		},
		widequestlog = {
			name = L["Make quest log double wide"],
			desc = L["Make the quest log window double wide, this will require UI reload."],
			type = "toggle",
			get = function() return self.db.profile.wideQuestLog end,
			set = function() self.db.profile.wideQuestLog = not self.db.profile.wideQuestLog end,
			order = 90,
		},
	}

	local QuestInfo = {
		name = L["Quest Info"],
		desc = L["Module description"],
		type = "group",
		args = options,
		handler = self,
	}
	
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(L["Quest Info"], QuestInfo);
	self:PurgeHostileQuests();
	self:PatchQuixote2();
end

function CQI_Option()
	if not (LibStub("AceConfigDialog-3.0"):Close(L["Quest Info"])) then
		LibStub("AceConfigDialog-3.0"):Open(L["Quest Info"]);
	end
end

function CQI:OnSizeDown()
--	self.optionsButton:Hide() 
	_G["CQI_MapButton1"]:Hide()
	_G["CQI_MapButton2"]:Hide()
	_G["CQI_MapButton3"]:Hide()
	_G["CQI_MapButton4"]:Hide()
	_G["WorldMapTrackQuest"]:Hide()
end

function CQI:OnSizeUp()
--	self.optionsButton:Show() 
	_G["CQI_MapButton1"]:Show()
	_G["CQI_MapButton2"]:Show()
	_G["CQI_MapButton3"]:Show()
	_G["CQI_MapButton4"]:Show()
	_G["WorldMapTrackQuest"]:Show()
end

function CQI:SetupMapButton()
--	self.optionsButton = CreateFrame("Button", "CQIToggleButton", WorldMapFrame, "UIPanelButtonTemplate")
--	self.optionsButton:SetWidth(120)
--	self.optionsButton:SetHeight(22)
--	self.optionsButton:SetText(L["DisableQuestInfo"])
--	self.optionsButton:ClearAllPoints()
--	self.optionsButton:SetPoint("TOPRIGHT", WorldMapFrame, "TOPRIGHT", -28, -38)

--	self.optionsButton:SetScript("OnClick",function()
		
--	end)
	local mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster",true)
	if mapster then
		self:Hook(mapster,"SizeUp",function() CQI:OnSizeUp() end)
		self:Hook(mapster,"SizeDown",function()  CQI:OnSizeDown() end)
	end
	WorldMapFrame:HookScript("OnShow",function()
		if WorldMapZoomOutButton:IsShown() then
			--size down
			CQI:OnSizeUp()
		else
			CQI:OnSizeDown()		
		end
	end)
	
	self:SecureHook("WorldMap_ToggleSizeDown", function() CQI:OnSizeDown() end)
	self:SecureHook("WorldMap_ToggleSizeUp", function() CQI:OnSizeUp() end)


end

function CQI:OnEnable()
	self:EnableCartoMap()
	self:PatchQuestLog()
	self:RegisterEvent("QUEST_QUERY_COMPLETE");

	Quixote.RegisterCallback(self, "Quest_Gained", "AutoUpdateQuest")
	Quixote.RegisterCallback(self, "Quest_Abandoned", "AutoUpdateQuest")
	Quixote.RegisterCallback(self, "Quest_Complete", "AutoUpdateQuest")
	Quixote.RegisterCallback(self, "Quest_Failed", "AutoUpdateQuest")
	Quixote.RegisterCallback(self, "Quest_Lost", "AutoUpdateQuest")
	Quixote.RegisterCallback(self, "Objective_Update", "AutoUpdateQuestObjective")	
	QuestInfo_TogglePOIStyle(self.db.profile.showMapNotes)

	self:SetupMapButton()
	self:AutoUpdateQuest()
	self:ScanQuestsCompleted()
end

function CQI:OnDisable()
	self:DisableCartoMap()
	self:UnregisterEvent("QUEST_QUERY_COMPLETE");
	Quixote.UnregisterAll(self)
end

-------------------------------------------------------------------

----
-- Scan Quest tooltip to get title and objective title
-- Note: this may fail when quest data is not yet loaded into cache
--       call this function again may get the correct data
-- @param uid - the quest id
-- @param level - the quest level
-- @return full_title, title, desc, objective_names
----
function CQI:GetQuestText(uid, level)
	local link = "|cff808080|Hquest:"..uid..":"..level.."|h[dummy]|h|r"
	Gratuity:SetHyperlink(link)

	local n = Gratuity:NumLines()
	if n <= 0 then return end

	local title, desc, objs
	local desc_state = 0

	for i = 1, n do
		local line = Gratuity:GetLine(i):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("[\n\t]", " ")
		if i == 1 then
			title = line
		elseif line == " " then
			desc_state = desc_state + 1
		elseif desc_state == 1 then
			desc = (desc or "")..line
		elseif desc_state > 1 then
			local _, _, o = line:find("^%s+%- (.-)%s?x?%s?%d*$")
			if o then
				if not objs then
					objs = {}
				end
				table.insert(objs, o)
			end
		end
	end

	return "["..level.."] "..title, title, desc, objs
end

local function GetQuestNPC(npc)
	local npc_id = 0;
	if (npc) then
		npc_id = tonumber(npc)
		if not npc_id then
			local _, _, npc_a, npc_h = npc:find("A(%-?%d+);H(%-?%d+)")
			if UnitFactionGroup("player") == "Alliance" then
				npc_id = tonumber(npc_a)
			else
				npc_id = tonumber(npc_h)
			end
		end
	end
	return npc_id
end

function CQI:ScanQuestsCompleted()
	if (QueryQuestsCompleted) then
		QueryQuestsCompleted();
	end	
end

function CQI:QUEST_QUERY_COMPLETE()	
	local tmp = GetQuestsCompleted();
	for uid, v in pairs(tmp) do
		if (not QuestInfoPerDB.quest[uid]) then
			QuestInfoPerDB.quest[uid] = true;
		end
	end
end
-- Added by dugu@bigfoot
function CQI:CanAcceptQuest(uid)
	local level = self:PeekQuest(uid)
	local _, name = self:GetQuestText(uid, level);
	if ((not QuestInfoPerDB.quest[uid]) or QuestInfoPerDB.abandon[name]) then
		return true;
	end

	return false;
end
----
-- Get short summary of quest, this is faster than GetQuest
-- @param uid - the quest id
-- @return level, level_req, start_npc_id, end_npc_id, sharable, daily, side, data
----
function CQI:PeekQuest(uid)
	uid = tostring(uid);
	local data = QuestInfo_Quest[uid]
	if not data then return end
	
	local _, _, side, level_req, level, start_npc, end_npc, sharable, daily =
		data.i:find("^(.)`(%d+)`(%d+)`([^`]+)`([^`]+)`(%d)`(%d)$")
	if (not start_npc or not end_npc) then
		print(data.i, side, level_req, level, start_npc, end_npc, sharable, daily)
	end
	return tonumber(level), tonumber(level_req), GetQuestNPC(start_npc), GetQuestNPC(end_npc), sharable == "1", daily == "1", side, data
end

-------------------------------------------------------------------

----
-- Get NPC info from database
-- @param id - the npc id
-- @param zone_filter - limit to this zone only, or nil if no limit
-- @return table in the following structure
--		<NPC> = {
--			id = <id>,
--			name = "<npc_name>",
--			level_min = <level_min>,
--			level_max = <level_max>,
--			side = <npc_side>, -- A, H, B
--			classify = <0|1|2|3>, -- 0 = normal, 1 = elite, 2 = rare elite, 3 = boss
--			loc = {
--				["<zone_name>"] = { { x=<x>, y=<y>}, ... },
--				... more zone
--			},
--		}
----
function CQI:GetNPC(id, zone_filter)
	local data = QuestInfo_NPC[id]
	if not data then return end

	local _, _, side, level_min, level_max, classify, loc = data:find("^(.)`(%d+)`(%d+)`(%d+)(|.*)$")
	local out = {}
	out.id = id
	out.side = side
	out.name = QuestInfo_Name[id] or "????"
	out.level_min = level_min ~= "0" and tonumber(level_min)
	out.level_max = level_max ~= "0" and tonumber(level_max)
	out.classify = tonumber(classify)
	
	for zone, pos in loc:gmatch("|(%d+):([^|]*)") do
		zone = tonumber(zone)
		local zone_name = QuestInfo_Zone[zone]
		if zone_name and (not zone_filter or zone_filter == zone) then
			if not out.loc then
				out.loc = {}
			end
			if not out.loc[zone_name] then
				out.loc[zone_name] = {}
			end
			for x, y in string.gmatch(pos, "(%d+),(%d+)") do
				table.insert(out.loc[zone_name], {x = tonumber(x)/10, y = tonumber(y)/10})
			end
		end
	end

	return out
end

----
-- Get quest info from database
-- @param uid - the quest unique id (as from GetQuestLink)
-- @param ignore_obj - ignore the objective part (will be fatser)
-- @return table in the following structure
--		<QUEST> = {
--			id = <id>,
--			title = "<quest_title>",
--			title_full = "<quest_title_with_tag>"
--			level_req = <required_level>,
--			level = <quest_level>,
--			side = <quest_side>, -- A, H, B
--			sharable = <boolean>,
--			start_npc = <NPC>,
--			end_npc = <NPC>,
--			objs = { <OBJECTIVE>, <OBJECTIVE>, ... },
--			series = { <qid>, <qid>, ... },
--		}
--		<OBJECTIVE> = {
--			title = "<objective_title>",
--			npcs = { <NPC>, <NPC>, ...},
--		}
----
function CQI:GetQuest(uid, ignore_obj)
	local level, level_req, start_npc, end_npc, sharable, daily, side, data = self:PeekQuest(uid)
	if not data then return end

	local out = {}
	out.id = uid
	out.side = side
	out.level = level
	out.level_req = level_req
	out.sharable = sharable
	out.daily = daily
	out.start_npc = self:GetNPC(start_npc)
	out.end_npc = self:GetNPC(end_npc)

	local q_title_full, q_title, q_desc, q_objs = self:GetQuestText(uid, level)
	out.title = q_title or "????"
	out.title_full = q_title_full or "????"
	out.desc = q_desc

	if ignore_obj then return out end

	if data.o then
		out.objs = {}
		for i, o in data.o:gmatch("(%d)=([^|]+)") do
			i = tonumber(i)
			local obj = {}
			obj.title = q_objs and q_objs[i] or "????"
			for npc_id, npc_drop_rate, npc_zone, npc_x, npc_y in string.gmatch(o, "(%-?%d+)#?(%d*)@?(%d*):?(%d*),?(%d*)") do
				npc_id = tonumber(npc_id)
				npc_zone = tonumber(npc_zone)
				npc_drop_rate = tonumber(npc_drop_rate)
				local npc
				if npc_id ~= 0 then
					-- lookup npc database
					npc = self:GetNPC(npc_id, npc_zone)
				elseif npc_zone and QuestInfo_Zone[npc_zone] then
					-- using embeded x, y
					npc_zone = QuestInfo_Zone[npc_zone]
					npc_x = tonumber(npc_x) or 0
					npc_y = tonumber(npc_y) or 0
					npc = {}
					npc.id = 0
					npc.name = obj.title
					npc.classify = 0
					npc.loc = { [npc_zone] = { { x = npc_x/10, y = npc_y/10 } } }
				end
				if npc then
					if not obj.npcs then
						obj.npcs = {}
					end
					npc.drop_rate = npc_drop_rate
					table.insert(obj.npcs, npc)
				end
			end
			if obj.npcs then
				table.sort(obj.npcs, function(a, b)
					local a_drop = a.drop_rate or 0
					local b_drop = b.drop_rate or 0
					return a_drop > b_drop or (a_drop == b_drop and a.name < b.name)
				end)
			end
			out.objs[i] = obj
		end
	end

	if data.s then
		out.series = {}
		for qid in string.gmatch(data.s, "(%d+)") do
			table.insert(out.series, tonumber(qid))
		end
	end

	return out
end

-------------------------------------------------------------------

function CQI:GetQuestColor(level)
	local diff = level - UnitLevel("player")
	if diff >= 5 then -- red / impossible
		return 1, 0.125, 0.125
	elseif diff >= 3 then -- orange / very difficult
		return 1, 0.5, 0.25
	elseif diff >= -2 then -- yellow / difficult
		return 1, 1, 0
	elseif -diff <= GetQuestGreenRange() then -- green / standard
		return 0.25, 0.75, 0.25
	else -- grey / trivial
		return 0.5, 0.5, 0.5
	end
end

function CQI:PurgeHostileQuests()
	local hostile = (UnitFactionGroup("player") == "Alliance") and "H" or "A"
	
	for uid, data in pairs(QuestInfo_Quest) do
		if data.i:sub(1, 1) == hostile then
			QuestInfo_Quest[uid] = nil
		end
	end
	
	for id, data in pairs(QuestInfo_NPC) do
		if data:sub(1, 1) == hostile then
			QuestInfo_NPC[id] = nil
			QuestInfo_Name[id] = nil
		end
	end	
end

-------------------------------------------------------------------

function CQI:PatchQuixote2()
	-- change DAILY shorttags to "y", because "\226\128\162" looks ugly on Asia locales
	local l = GetLocale()
	if l == "zhTW" or l == "zhCN" or l == "koKR" then
		Quixote.shorttags[DAILY] = "y"
		Quixote.shorttags[L["GROUP"]] = "g"
	end
	
	-- disable SendAddonMessage spam
	local f = Quixote.SendAddonMessage
	Quixote.SendAddonMessage = function(self, contents, distribution, target, priority)
		-- don't send message if the target is unknown
		if target == UNKNOWNOBJECT then return end

		-- don't send message in arena or battleground
		local _, instanceType = IsInInstance()
		if instanceType == "arena" or instanceType == "pvp" then return end
				
		f(self, contents, distribution, target, priority)
	end
	
	-- add checking for Quixote frame OnEvent
	if Quixote.frame then
		Quixote.frame:SetScript("OnEvent", function(this, event, ...)
			if this[event] then
				this[event](Quixote, ...)
			end
		end)
	end
end

---------------------
-- Button
function CQI_MapButton_OnEnter(self)
	local id = self:GetID();
	GameTooltip_SetDefaultAnchor(GameTooltip, self);
	if (id == 1) then
		GameTooltip:SetText(L["Show available quests"], 1, 1, 1);
		GameTooltip:AddLine(L["Show the givers of available quests on current map."]);
	elseif (id == 2) then
		GameTooltip:SetText(L["Show active quests"], 1, 1, 1);
		GameTooltip:AddLine(L["Show all info of active quests on current map."]);
	elseif (id == 3) then
		GameTooltip:SetText(L["Show tracked quests"], 1, 1, 1);
		GameTooltip:AddLine(L["Show all info of tracked quests on current map."]);
	elseif (id == 4) then
		GameTooltip:SetText(L["Clear quest icons"], 1, 1, 1);
		GameTooltip:AddLine(L["Clear quest icons generated by QuestInfo."]);
	end
	GameTooltip:Show();
end

function CQI_MapButton_OnLeave(self)
	GameTooltip:Hide();
end

function CQI_MapButton_OnClick(self)
	CQI.trackMode = nil;

	local id = self:GetID();
	
	if (id == 1) then
		CQI:ShowAvialableQuests();
	elseif (id == 2) then
		CQI:ShowActiveQuests();		
	elseif (id == 3) then
		CQI:ShowActiveQuests(true);
	elseif (id == 4) then
		CQI:ClearQuestNotes();
	end
end