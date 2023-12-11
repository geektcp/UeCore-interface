local CQI = Cartographer_QuestInfo;
local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");
local BZR = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()
local QuestData = {};
local CQI_QuestObjectButtons = {};

local cqi_questLineIndex = 1

local function __GetNumObjectives(questId)
	local numObjectives	
	local numQuests =GetNumQuestLogEntries()
	for i = 1, numQuests do
		local questID = select(9,GetQuestLogTitle(i))
		if questID == questId then
			numObjectives = GetNumQuestLeaderBoards(i);
			return numObjectives,i
		end
	end
end

local OnMouseDown = function(self)
	if (self.oID and self.qID) then
		CQI:CloseLocationFrame()
		CQI_Tooltip:Hide()
		CQI:ClearQuestNotes()

		if (not QuestData[self.qID]) then
			QuestData[self.qID] = CQI:GetQuest(self.qID);
		end

		if (not QuestData[self.qID]) then return; end

		local obj = QuestData[self.qID].objs and QuestData[self.qID].objs[self.oID];
		if (obj) then
			local map = {};
			map.quest = QuestData[self.qID].title_full;
			map.zones = {}
			map.title = obj.title
			map.npcs = obj.npcs
			local obj_type = QuestData[self.qID].daily and "obj-daily" or "obj";
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
				CQI:OpenQuestMap(map.quest, map.title, obj_type, last_zone, map.zones[last_zone]);
			elseif zone_count > 1 then
				CQI:OpenLocationFrame(map);
			end

			CQI.trackMode = true;
		end
	end

	self.texture:SetTexCoord(0, 1, 0, 1);
end

local function CQI_WatchFrame_ResetQuestLines()
	cqi_questLineIndex = 1
end

local function CQI_WatchFrame_GetQuestLine ()
	local line = WATCHFRAME_QUESTLINES[cqi_questLineIndex];
	
	cqi_questLineIndex = cqi_questLineIndex + 1;
	return line;
end

function CQI:SetQuestDataForButton(button)
	if (button) then
		if (not QuestData[button.qID]) then
			QuestData[button.qID] = CQI:GetQuest(button.qID);
		end	
		if (QuestData[button.qID]) then
			button:Show();
		else
			button:Hide();
		end
	end	
end

-- 创建QuestObject按钮
function CQI:CreateQuestObjectButtons(index,qID, oID)
	local button = CQI_QuestObjectButtons[index]
	if (not button) then
		button = CreateFrame("Button", nil, WatchFrameLines);		
		button:SetHeight(20);
		button:SetWidth(20);
		button:SetFrameLevel(button:GetFrameLevel() + 5);			
		button.texture = button:CreateTexture(nil, "BACKGROUND");
		button.texture:SetTexture("Interface\\TUTORIALFRAME\\TutorialFrame-QuestionMark");
		button.texture:SetAllPoints(button);
		button:SetHighlightTexture("Interface\\TUTORIALFRAME\\TutorialFrame-QuestionMark", "ADD");
		button:SetScript("OnMouseDown", OnMouseDown);
		button:SetScript("OnMouseUp", function(self)
			self.texture:SetTexCoord(0.075, 0.925, 0.075, 0.925);
		end);
		CQI_QuestObjectButtons[index] = button
	end
	button:ClearAllPoints();
	button.oID = oID;
	button.qID = qID;
	
	return button;
end

function CQI:HideAllWatchButton()
	for i, b in pairs(CQI_QuestObjectButtons) do
		b:Hide();
	end
end

-- 获得WatchFrameLine 并添加QuestObjects按钮
function CQI:SetQuestObjectButtons()

	local questIndex,isComplete, questID
	local numObjectives
	local line
	local subButton
	local numQuestWatches = GetNumQuestWatches()
	CQI_WatchFrame_ResetQuestLines()
	local subButtonIndex = 1
	for i = 1, numQuestWatches do
		questIndex = GetQuestIndexForWatch(i)
		
		if ( questIndex ) then
			isComplete,_, questID  = select(7, GetQuestLogTitle(questIndex))
			CQI_WatchFrame_GetQuestLine();
			numObjectives = GetNumQuestLeaderBoards(questIndex);
			
			if ( isComplete and isComplete < 0 ) then
				isComplete = false;
			elseif ( numObjectives == 0 ) then
				isComplete = true;		
			end
			
			if isComplete then
				CQI_WatchFrame_GetQuestLine();
			else
				for j = 1, numObjectives do				
					text, _, finished = GetQuestLogLeaderBoard(j, questIndex);
					if ( not finished ) then
						line = CQI_WatchFrame_GetQuestLine();
						subButton = self:CreateQuestObjectButtons(subButtonIndex,questID, j);
						self:SetQuestDataForButton(subButton)
						subButton:ClearAllPoints()
						subButton:SetPoint("TOPRIGHT", line, "TOPLEFT");
						subButtonIndex = subButtonIndex + 1
					end
				end
			end
		end
	end

end

function CQI:WatchFrame_Update()
	

	self:HideAllWatchButton();
	

--	if not CQI.EnablePOIStyle then return end
	self:SetQuestObjectButtons()
	
	self:ScheduleTimer("ShowActiveQuests", 1, self,true)	

end

function CQI:BatchOpenQuest(button)
	if (button.qID) then
		CQI:CloseLocationFrame();
		CQI_Tooltip:Hide();
		CQI:ClearQuestNotes();
		if (not QuestData[button.qID]) then
			QuestData[button.qID] = CQI:GetQuest(button.qID);
		end

		local q = QuestData[button.qID];
		local qIndex = button.qIndex
		local requiredMoney = GetQuestLogRequiredMoney(qIndex);	
		local oNum = GetNumQuestLeaderBoards(qIndex);
		if (oNum == 0 and GetMoney() > requiredMoney) then
			isComplete = true;
		end
		if (isComplete) then		
			if (q.end_npc and q.end_npc.loc) then
				for zone, v in pairs(q.end_npc.loc) do
					self:AddQuestNotes(q.title_full, L["Quest End"], "end", q.end_npc, zone);
				--	self:GotoQuestZone(zone);
					return;
				end				
			end
		else
			local objs = QuestData[button.qID].objs;
			local curZone = QuestInfo_Zone[GetCurrentMapZone()];
			if (objs) then
				local maps = {};
				local zone_count = 0;
				local last_zone = nil;
				local inCurZone = false;
				for oid, obj in ipairs(objs) do
					local map = {};
					map.quest = QuestData[button.qID].title_full;
					map.zones = {};
					map.title = obj.title;
					map.npcs = obj.npcs;
					map.type = QuestData[button.qID].daily and "obj-daily" or "obj";
					
					if map.npcs then
						for _, npc in ipairs(map.npcs) do
							if npc.loc then
								for zone, pos in pairs(npc.loc) do
									if BZR[zone] then
										if not map.zones[zone] then
											map.zones[zone] = { npc };
											last_zone = zone;
											zone_count = zone_count + 1;
											if (curZone == zone) then
												inCurZone = true;
											end
										else
											table.insert(map.zones[zone], npc);
										end
									end
								end
							end
						end					
					end

					table.insert(maps, map);
				end
				
				-- 该处的规则需要修改				
				local zone = inCurZone and curZone or last_zone;
				for i, map in ipairs(maps) do
					if (map.zones[zone]) then
						-- TODO: 根据i顺序标记不同的颜色
						self:BatchAddQuestNotes(map.quest, map.title, map.type, zone, map.zones[zone]);
					end
				end
			--	self:GotoQuestZone(zone);

				CQI.trackMode = true;
			end
		end
	end
end

function CQI_WatchFrameQuestPOI_OnClick(self)	
	if not self.qID then self.qID = self.questId end
	local _,qIndex = __GetNumObjectives(self.qID)
	self.qIndex = qIndex

	CQI:BatchOpenQuest(self);
end