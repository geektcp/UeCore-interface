local CQI = Cartographer_QuestInfo;
local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");

local Quixote = LibStub("LibQuixote-2.0")

-------------------------------------------------------------------

local OBJ_CACHE = {}
local OBJ_CACHE_HIT = 0

-------------------------------------------------------------------

--[[
-- QuestFu Patch (Original by ZeroFire)
-- to use this, modify code in QuestFu.lua QuestsFu:AddQuestToCategory()
	local function CQI_HasInfo(obj, qid)
		return Cartographer_QuestInfo and Cartographer_QuestInfo:FindObjectiveData(qid, obj) ~= nil
	end
	
	local function CQI_ShowInfo(obj, qid)
		if Cartographer_QuestInfo then
			local data = Cartographer_QuestInfo:FindObjectiveData(qid, obj)
			Cartographer_QuestInfo:OnButtonClick(nil, "LeftButton", data)
		end
	end
	
	cat:AddLine(
		'text', '  '..description,
		'text2', party .. (done and L["(done)"] or string.format("%s/%s", numGot, numNeeded)),
		'textR', r or 1, 'textG', g or 1, 'textB', b or 1,
		'text2R', r or 1, 'text2G', g or 1, 'text2B', b or 1,
		'size', fontSize, 'size2', fontSize,
		-- purple, add support for Cartographer_QuestInfo
		'checked', CQI_HasInfo(description, questid), 
		'hasCheck', true, 
		'checkIcon', 'Interface\\GossipFrame\\PetitionGossipIcon',
		'func', CQI_ShowInfo,
		'arg1', description,
		--
		'arg2', questid,
		'indentation', indent
	)
--]]

function CQI:FindObjectiveData(questid, objective)
	if type(objective) ~= "string" then return end

	local uid = Quixote:GetQuestById(questid)
	local q_key = string.format("%d`%s", uid, objective)
	if OBJ_CACHE[q_key] then return OBJ_CACHE[q_key] end

	local q = self:GetQuest(uid)
	if not q or not q.objs then return end

	for _, obj in pairs(q.objs) do
		if obj.title == objective and obj.npcs then
			if OBJ_CACHE_HIT >= 100 then
				-- try to keep cache small
				local next_key = next(OBJ_CACHE)
				OBJ_CACHE[next_key] = nil
			else
				OBJ_CACHE_HIT = OBJ_CACHE_HIT + 1
			end
			local data = {
				quest = q.title_full,
				obj = obj,
			}
			OBJ_CACHE[q_key] = data
			return data
		end
	end
end

