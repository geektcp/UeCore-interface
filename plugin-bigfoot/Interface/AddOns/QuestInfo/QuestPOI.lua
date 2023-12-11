local CQI = Cartographer_QuestInfo;



-- 修改QuestPOIButton的功能
function CQI:QuestPOI_DisplayButton(parentName, buttonType, buttonIndex, questId)
	local button = self.hooks.QuestPOI_DisplayButton(parentName, buttonType, buttonIndex, questId)	
	local oriScript = button:GetScript("OnClick")
	if not button.cqiIsHooked  then
		button:HookScript("OnMouseDown",function(bn) 
			bn.qID = bn.questId
		end)
		button:HookScript("OnMouseUp",CQI_WatchFrameQuestPOI_OnClick)
		button.cqiIsHooked = true
	end

	return button;
end

--修改地图右侧任务栏的QuestPOI 按钮
function CQI:WorldMapFrame_GetQuestFrame(questCount,isComplete)
	local frame = self.hooks.WorldMapFrame_GetQuestFrame(questCount,isComplete)
	if not frame.cqiIsHooked then
		frame:HookScript("OnMouseDown",function(bn)
			bn.qID = bn.questId
		end)
		frame:HookScript("OnMouseUp",function(...)
			CQI_WatchFrameQuestPOI_OnClick(...)
			QuestInfo_TogglePOIStyle(false);
		end)
		frame.cqiIsHooked = true
	end

	return frame
end

function CQI:HideNotes()
	local i = 1;
	local note = _G["MapsterNotesPOI"..i];
	while (note) do
		note:SetAlpha(0);
		note:SetSize(0, 0);
		i = i + 1;
		note = _G["MapsterNotesPOI"..i];
	end
end

function CQI:ShowNotes()
	local i = 1;
	local note = _G["MapsterNotesPOI"..i];
	while (note) do
		note:SetAlpha(1);
		note:SetSize(16, 16);
		if (note.oldOnEnter) then
			note.OnEnter = note.oldOnEnter;
		end
		i = i + 1;
		note = _G["MapsterNotesPOI"..i];
	end
end

function QuestInfo_TogglePOIStyle(showMapNotes)
	local self = CQI;

	if not self:IsHooked("WatchFrame_Update") then
		self:SecureHook("WatchFrame_Update")
		self:RawHook("WorldMapFrame_GetQuestFrame",true)
		self:RawHook("QuestPOI_DisplayButton",true)
	end

	CQI.showMapNotes = showMapNotes
	if showMapNotes then
		self:ShowNotes();
	else
		self:HideNotes();
	end
end
