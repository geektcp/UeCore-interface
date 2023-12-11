local CQI = Cartographer_QuestInfo
local L = LibStub("AceLocale-3.0"):GetLocale("Cartographer_QuestInfo");
local Tablet = AceLibrary("Tablet-2.0")

-------------------------------------------------------------------

----
--	<OBJMAP> = {
--		quest = "<quest_title>",
--		title = "<note_title>",
--		zones = {
--			["zone"] = <NPC_LIST>,
--			... more ["zone"] = <NPC_LIST>
--		}
--	}
----

local OBJMAP

function CQI:OpenLocationFrame(map)
	OBJMAP = OBJMAP ~= map and map or nil
	self:ScheduleTimer("UpdateLocationFrame", 0, self)
	--self:AddTimer(0, CQI.UpdateLocationFrame, self)
end

function CQI:CloseLocationFrame()
	if Tablet:IsRegistered("CQI_Objectives") then
		self:OpenLocationFrame(nil)
	end
end

-------------------------------------------------------------------

function CQI:UpdateLocationFrame()
	if not Tablet:IsRegistered("CQI_Objectives") then
		Tablet:Register("CQI_Objectives",
			"data", {},
			"clickable", true,
			'movable', true,
			"cantAttach", true,
			"dontHook", true,
			"showTitleWhenDetached", true,
			"hideWhenEmpty", true,
			"strata", "HIGH",
			"minWidth", 450,
			"children", function() self:UpdateLocationContent() end)
		Tablet:Open("CQI_Objectives")
	end
	Tablet:Refresh("CQI_Objectives")
end

function CQI:UpdateLocationContent()
	local map = OBJMAP
	if not map then return end

	Tablet:SetTitle(map.title)

	for zone, npc_list in pairs(map.zones) do
		local cat = Tablet:AddCategory(
			"id", zone,
			"columns", 2,
			"hideBlankLine", true,
			"text", zone,
			"size", 14,
			"child_size", 14,
			"child_size2", 12,
			"textR", 1, "textG", 0.5, "textB", 0,
			"child_textR", 1, "child_textG", 1, "child_textB", 1,
			"child_text2R", 0, "child_text2G", 1, "child_text2B", 0,
			"child_wrap2", true,
			"func", function() self:OpenQuestMap(map.quest, map.title, "obj", zone, npc_list) end)

		for _, npc in ipairs(npc_list) do
			local i = 0
			local where = ""
			for _, l in ipairs(npc.loc[zone]) do
				if l.x ~= 0 and l.y ~= 0 then
					if i < 5 then
						where = where..string.format(" <%d,%d>", l.x, l.y)
					end
					i = i + 1
				end
			end
			if i >= 5 then
				where = where..L[" ..."]
			end
			cat:AddLine(
				"text", npc.name,
				"text2", where,
				"indentation", 10,
				"func", function() self:OpenQuestMap(map.quest, map.title, "obj", zone, { npc }) end)
		end
	end

	Tablet:AddCategory("hideBlankLine", true):AddLine(
		"text", L["Close"],
		"size", 14,
		"justify", "center",
		"func", function() self:CloseLocationFrame() end)
end
