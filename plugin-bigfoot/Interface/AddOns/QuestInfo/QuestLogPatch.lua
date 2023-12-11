local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

local Quixote = LibStub("LibQuixote-2.0")

-- local C = Cartographer
local CQI = Cartographer_QuestInfo

WorldMapFrame:HookScript("OnShow", function()
	if (QuestLogFrame:IsShown()) then
		QuestLogFrame:Hide();
	end
end);

QuestLogFrame:HookScript("OnShow", function()
	if (WorldMapFrame:IsShown()) then
		WorldMapFrame:Hide();
	end
end);

-------------------------------------------------------------------

----
-- for start and end npc, the CQI_Data is:
-- { 
--		quest = "<quest_title>",
--		npc = <NPC>,
-- },
--
-- for objective, the CQI_Data is:
-- {
--		quest = "<quest_title>",
--		obj = <OBJECTIVE>,
-- }
----
function CQI:Hook_QuestLog_UpdateQuestDetails()
	self:CloseSeriesFrame()
	self:CloseLocationFrame()
	
	CQI_InfoButton:Hide()
	CQI_StartButton:Hide()
	CQI_EndButton:Hide()
	
	for i = 1, 9 do
		local button = getglobal("CQI_ObjButton"..i)
		button:Hide()
	end

	--if not C:IsModuleActive(self) then return end

	local qlink = GetQuestLink(GetQuestLogSelection())
	if not qlink then return end
	local uid = tonumber(string.match(qlink, 'quest:(%d+)'))
	local q = self:GetQuest(uid)
	if not q then return end

	CQI_InfoButton.CQI_Data = q
	CQI_InfoButton:Show()

	if q.start_npc then
		CQI_StartButton.CQI_Data = {
			quest = q.title_full,
			npc = q.start_npc,
			type = "start",
		}
		CQI_StartButton:Show()
	end

	if q.end_npc then
		CQI_EndButton.CQI_Data = {
			quest = q.title_full,
			npc = q.end_npc,
			type = "end",
		}
		CQI_EndButton:Show()
	end
		
	if q.objs then
		local obj_type = q.daily and "obj-daily" or "obj"
		for i = 1, 9 do
			local q_string = getglobal("QuestInfoObjective"..i)
			if q_string and q.objs[i] and q.objs[i].npcs then
				local button = getglobal("CQI_ObjButton"..i)
				button.CQI_Data = {
					quest = q.title_full,
					obj = q.objs[i],
					type = obj_type,
				}
	 			button:ClearAllPoints()
				button:SetPoint("TOPLEFT", q_string, "TOPLEFT", 0, 0)
				button:SetPoint("BOTTOMRIGHT", q_string, "BOTTOMRIGHT", 0, 0)
				button:Show()
			end
		end
	end
end

-------------------------------------------------------------------

function CQI:OnButtonClick(this, button, data)
	if not data then
		data = this.CQI_Data
		if not data then return end
	end
	
	self:CloseLocationFrame()
	CQI_Tooltip:Hide()
	self:ClearQuestNotes()

	local type = data.type
	local map = {}
	map.quest = data.quest
	map.zones = {}

	if type == "start" or type == "end" then
		map.title = (type == "start") and L["Quest Start"] or L["Quest End"]
		map.npcs = { data.npc }		
	else
		map.title = data.obj.title
		map.npcs = data.obj.npcs
	end
	
	if not map.npcs then return end
	
	local zone_count = 0
	local last_zone = nil
	
	for _, npc in ipairs(map.npcs) do
		if npc.loc then
			for zone, pos in pairs(npc.loc) do
				if BZR[zone] then
					if not map.zones[zone] then
						map.zones[zone] = { npc }
						last_zone = zone
						zone_count = zone_count + 1
					else
						table.insert(map.zones[zone], npc)
					end
				end
			end
		end
	end
	
	if zone_count == 1 then
		self:OpenQuestMap(map.quest, map.title, type, last_zone, map.zones[last_zone])
	elseif zone_count > 1 then
		self:OpenLocationFrame(map)
	end

	CQI.trackMode = true;
end

function CQI:OnButtonTooltip(this, data)
	if not data then
		data = this.CQI_Data
		if not data then return end
	end
	
	local type = data.type
	local npcs, title
	if type == "start" or type == "end" then
		title = (type == "start") and L["Quest Start"] or L["Quest End"]
		npcs = { data.npc }
	else
		title = L["Quest Objective"]
		npcs = data.obj and data.obj.npcs
	end
	
	if not npcs or #npcs == 0 then return end
	
	CQI_Tooltip:SetOwner(this, "ANCHOR_RIGHT")
	CQI_Tooltip:ClearLines()
	CQI_Tooltip:AddLine(title, 1, 0.5, 0)

	if #npcs == 1 then
		CQI_Tooltip:AddLine(npcs[1].name, 1, 1, 1)
	end
	
	local i = 0
	for _, npc in ipairs(npcs) do
		if npc.loc then
			for zone, pos in pairs(npc.loc) do
				local j = 0
				for _, l in ipairs(pos) do
					if l.x ~= 0 and l.y ~= 0 then
						if j < 3 then
							zone = zone..string.format(" <%d,%d>", l.x, l.y)
							j = j + 1
						else
							zone = zone..L[" ..."]
							break
						end
					end
				end
				if i < 5 then
					if #npcs == 1 then
						CQI_Tooltip:AddLine(zone, 0.8, 1, 0)
					else
						local npc_name = npc.name
						if npc.drop_rate then
							npc_name = npc_name.." ("..npc.drop_rate.."%)"
						end
						CQI_Tooltip:AddDoubleLine(npc_name, zone, 1, 1, 1, 0.8, 1, 0)
					end
				end
				i = i + 1
			end
		end
	end

	if i >= 5 then
		CQI_Tooltip:AddDoubleLine(" ", L["... more"], 1, 1, 1, 0.6, 0.6, 0.6)
	end
	
	CQI_Tooltip:Show()
end

-------------------------------------------------------------------

local function MakeQuestLogDoubleWide()	
	--[[
	-- give up if QuestLogFrame is already in wide mode
	if QuestLogFrame:GetWidth() > 500 or IsAddOnLoaded("beql") then return end

	-- code copied from DoubleWide
	QuestLogFrame:SetAttribute("UIPanelLayout-width", 724)
	QuestLogFrame:SetWidth(724)
	QuestLogFrame:SetHeight(513)

	QuestLogDetailScrollFrame:ClearAllPoints()
	QuestLogDetailScrollFrame:SetPoint("TOPLEFT", QuestLogListScrollFrame, "TOPRIGHT", 41, 0)
	QuestLogDetailScrollFrame:SetHeight(362)
	QuestLogListScrollFrame:SetHeight(362)

	local oldQuestsDisplayed = QUESTS_DISPLAYED
	QUESTS_DISPLAYED = QUESTS_DISPLAYED + 17

	for i = oldQuestsDisplayed + 1, QUESTS_DISPLAYED do
	    local button = CreateFrame("Button", "QuestLogTitle" .. i, QuestLogFrame, "QuestLogTitleButtonTemplate")
	    button:SetID(i)
	    button:Hide()
	    button:ClearAllPoints()
	    button:SetPoint("TOPLEFT", getglobal("QuestLogTitle" .. (i-1)), "BOTTOMLEFT", 0, 1)
	end

	local regions = { QuestLogFrame:GetRegions() }
	local xOffsets = { Left = 3, Middle = 259, Right = 515 }
	local yOffsets =  { Top = 0, Bot = -256 }

	local textures = {
	    TopLeft = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_TopLeft",
	    TopMiddle = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_TopMid",
	    TopRight = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_TopRight",
	    BotLeft = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_BotLeft",
	    BotMiddle = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_BotMid",
	    BotRight = "Interface\\AddOns\\QuestInfo\\Artwork\\QL_BotRight",
	}

	local PATTERN = "^Interface\\QuestFrame\\UI%-QuestLog%-(([A-Z][a-z]+)([A-Z][a-z]+))$"
	for _, region in ipairs(regions) do
	    if (region:IsObjectType("Texture")) then
		    local texturefile = region:GetTexture()
		    local which, yofs, xofs = texturefile:match(PATTERN)
		    xofs = xofs and xOffsets[xofs]
		    yofs = yofs and yOffsets[yofs]
		    if (xofs and yofs and textures[which]) then
		        region:ClearAllPoints()
		        region:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", xofs, yofs)
		        region:SetTexture(textures[which])
		        region:SetWidth(256)
		        region:SetHeight(256)
		        textures[which] = nil
		    end
	    end
	end

	for name, path in pairs(textures) do
	    local yofs, xofs = name:match("^([A-Z][a-z]+)([A-Z][a-z]+)$")
	    xofs = xofs and xOffsets[xofs]
	    yofs = yofs and yOffsets[yofs]
	    if (xofs and yofs) then
		    local region = QuestLogFrame:CreateTexture(nil, "ARTWORK")
		    region:ClearAllPoints()
		    region:SetPoint("TOPLEFT", QuestLogFrame, "TOPLEFT", xofs, yofs)
		    region:SetWidth(256)
		    region:SetHeight(256)
		    region:SetTexture(path)
	    end
	end
	]]
end

-------------------------------------------------------------------

function CQI:Hook_QuestLog_Update()
	--[[
	if not self.db.profile.showQuestTag then return end
	for i = 1, QUESTS_DISPLAYED, 1 do
		local titleLine = _G["QuestLogTitle"..i]
		if titleLine then
			local title = titleLine:GetText()
			if not title then break end
			if not title:find("%[.-%]") then
				local uid, id, _, _, _, _, complete = Quixote:GetQuest(title:trim())
				if uid then
					title = Quixote:GetTaggedQuestName(uid)
					titleLine:SetText(title)
					
					local check = _G["QuestLogTitle" .. i .. "Check"]
					if check and check:IsVisible() then
						check:SetPoint("LEFT", titleLine, "LEFT", -1, -2)
					end
				end
			end
		end
	end
	]]
end

function CQI:Hook_ExpandQuestHeader()
	if not self.db.profile.showQuestTag then return end
	-- self:AddTimer(0, CQI.Hook_QuestLog_Update, CQI)
	self:ScheduleTimer("Hook_QuestLog_Update", 0, self)
end

-------------------------------------------------------------------

local function QuestIconFaded(title)
	local objectives, complete = select(6, Quixote:GetQuest(title))
	-- if we don't have the quest, we don't fade it:
	if objectives == nil and complete == nil then return false end
	return not (complete == 1 or objectives == 0)
end

local function GossipLoop(buttonindex, do_texture, ...)
	local numQuests = select('#', ...)
	for i = 2, numQuests, 3 do
		local button = _G["GossipTitleButton"..buttonindex]
		if not button:GetText():find("%[.-%]") then
			local level = select(i, ...)
			button:SetText(string.format('[%s] %s', level == -1 and '*' or level, button:GetText()))
			if do_texture and QuestIconFaded(Quixote:GetQuest(select(i-1, ...))) then
				_G["GossipTitleButton"..buttonindex.."GossipIcon"]:SetVertexColor(0.5, 0.5, 0.5, 0.5)
			else
				_G["GossipTitleButton"..buttonindex.."GossipIcon"]:SetVertexColor(1, 1, 1, 1)
			end
		end
		buttonindex = buttonindex + 1
	end
	return buttonindex + 1
end

local function ShowQuestTagOnGossip()
	local buttonindex = 1
	if GetGossipAvailableQuests() then
--		buttonindex = GossipLoop(buttonindex, false, GetGossipAvailableQuests())
	end
	if GetGossipActiveQuests() then
--		buttonindex = GossipLoop(buttonindex, true, GetGossipActiveQuests())
	end
end

local function ShowQuestTagOnGreeting()
	local numActive = GetNumActiveQuests()
	local numAvailable = GetNumAvailableQuests()
	local o = 0
	local GetTitle = GetActiveTitle
	local GetLevel = GetActiveLevel
	for i = 1, numActive + numAvailable do
		local button = _G["QuestTitleButton"..i]
		if button:GetText():find("%[.-%]") then break end
		if i == numActive + 1 then
			o = numActive
			GetTitle = GetAvailableTitle
			GetLevel = GetAvailableLevel
		end		
		local title = GetTitle(i-o)
		local level = GetLevel(i-o)
		button:SetText(string.format('[%s] %s', level == -1 and '*' or level, title))
		if QuestIconFaded(title) then
			_G["QuestTitleButton"..i.."QuestIcon"]:SetVertexColor(0.5, 0.5, 0.5, 0.5)
		else
			_G["QuestTitleButton"..i.."QuestIcon"]:SetVertexColor(1, 1, 1, 1)
		end
	end
end

function CQI:GOSSIP_SHOW()
	if not self.db.profile.showQuestTag then return end
	self:ScheduleTimer(ShowQuestTagOnGossip, 0);	
end

function CQI:QUEST_GREETING()
	if not self.db.profile.showQuestTag then return end
	self:ScheduleTimer(ShowQuestTagOnGreeting, 0);		
end

-------------------------------------------------------------------
function CQI:PatchQuestLog()
	if self.IsQuestLogPatched then return end
	self.IsQuestLogPatched = true

	-- delay patch show quest tag, so other addons can take chance first
	self:ScheduleTimer(function(self)
		self:SecureHook("QuestLog_UpdateQuestDetails", "Hook_QuestLog_UpdateQuestDetails")
		self:SecureHook("QuestLog_Update", "Hook_QuestLog_Update")
		self:SecureHook("ExpandQuestHeader", "Hook_ExpandQuestHeader")
		self:RegisterEvent("GOSSIP_SHOW")
		self:RegisterEvent("QUEST_GREETING")
	end, 1, self);

	if self.db.profile.wideQuestLog then
		-- delay extend quest log, so other addons can take chance first
		-- self:ScheduleTimer(MakeQuestLogDoubleWide, 1)
	end
end
