local q =  LibStub("AceAddon-3.0"):NewAddon("BFQuest","AceHook-3.0")
if not q then return end
q:SetDefaultModuleState(false)

local BFQuest_TestPatterns;
local BFQuest_QUEST_PROGRESS;
local BFQuest_QUEST_COMPLETED;
local BFQCompletedMatchPattern;

local Raid_Ad_Text;					--团队宣传M语
local TEAMNOTICE_SET_PARTY_COMMENT;	--小队提示信息
local TEAMNOTICE_SET_ADD_COMMENT;	--团队提示信息
local TEAMNOTICE_PARTY;				--小队提示标题
local TEAMNOTICE_RAID;				--团队提示标题
local TEAMNOTICE_CLASS;				--职业宣传语
local TEAMNOTICE_JOIN;				--小队欢迎语
local Info_Text_Ad;					--提示语
if (GetLocale() == "zhCN") then
	BFQuest_TestPatterns = "(.*)：%s*([-%d]+)%s*/([-%d]+)%s*";
	BFQuest_QUEST_PROGRESS = "KK魔兽任务进度提示: ";
	BFQuest_QUEST_COMPLETED = " (任务完成)";
	BFQCompletedMatchPattern = "（完成）";
	BFQCompletedSuffix = "(完成)";
	
	TEAMNOTICE_CLASS={
		["DEATHKNIGHT"]='] "冰冷视界审视灵魂，死亡领域压迫众生"。',
		["DRUID"]='] "沉睡在翡翠的梦境之中"。',
		["WARLOCK"]='] "现恶魔之能，执混乱之箭，行厄运之灾"。',
		["WARRIOR"]='] "天堂在左，战神在右；在荣耀之路上无所畏惧"。',
		["HUNTER"]='] "各位观众，狩猎开始"！',
		["MAGE"]='] "让敌人感受冰与火的洗礼吧"！',
		["PRIEST"]='] "左手光明、右手暗影。正、邪只在一念间"。',
		["PALADIN"]='] "手握圣光，却望不到天堂"。',
		["SHAMAN"]='] "愿元素之力顾佑着你"。',
		["ROGUE"]='] "心跳做伴，利刃为伍，死亡与暗影之舞者"。',
	};
	Raid_Ad_Text = "欢迎加入本团队，希望我们合作愉快，拥有一次快乐的冒险旅程。";
	TEAMNOTICE_SET_PARTY_COMMENT = "请输入要发送的小队公告信息";
	TEAMNOTICE_SET_ADD_COMMENT = "请输入要发送的团队公告信息";
	TEAMNOTICE_PARTY = "<KK魔兽组队提示>";
	TEAMNOTICE_RAID = "<KK魔兽团队提示>";
	TEAMNOTICE_JOIN = "欢迎新的小队成员  [";
	Info_Text_Ad = "|cff00adef您可通过KK魔兽组队工具设置选项自定义团队公告。|r";
elseif (GetLocale() == "zhTW") then
	BFQuest_TestPatterns = "(.*):%s*([-%d]+)%s*/([-%d]+)%s*";
	BFQuest_QUEST_PROGRESS = "大腳任務進度提示: ";
	BFQuest_QUEST_COMPLETED = " (任務完成)";
	BFQCompletedMatchPattern = "%(完成%)";
	BFQCompletedSuffix = "(完成)";
	
	TEAMNOTICE_CLASS={
		["DEATHKNIGHT"]='] "冰冷視界審視靈魂，死亡領域壓迫眾生"。',
		["DRUID"]='] "沉睡在翡翠的夢境之中"。',
		["WARLOCK"]='] "現惡魔之能，執混亂之箭，行厄運之災"。',
		["WARRIOR"]='] "天堂在左，戰神在右；在榮耀之路上無所畏懼"。',
		["HUNTER"]='] "各位觀眾，狩獵開始"！',
		["MAGE"]='] "讓敵人感受冰與火的洗禮吧"！',
		["PRIEST"]='] "左手光明、右手暗影。正、邪只在一念間"。',
		["PALADIN"]='] "手握聖光，卻望不到天堂"。',
		["SHAMAN"]='] "愿元素之力顧佑著你"。',
		["ROGUE"]='] "心跳做伴，利刃為伍，死亡與暗影之舞者"。',
	};
	Raid_Ad_Text = "歡迎加入本團隊，希望我們合作愉快，擁有一次快樂的冒險旅程。"
	TEAMNOTICE_SET_PARTY_COMMENT = "請輸入要發送的小隊公告信息";
	TEAMNOTICE_SET_ADD_COMMENT = "請輸入要發送的團隊公告信息";
	TEAMNOTICE_PARTY = "<大腳小隊提示>";
	TEAMNOTICE_RAID = "<大腳團隊提示>";
	TEAMNOTICE_JOIN = "歡迎新的小隊成員  [";
	Info_Text_Ad = "|cff00adef您可通過大腳組隊工具設置選項自定義團隊公告。|r";
else
	BFQuest_TestPatterns = "(.*):%s*([-%d]+)%s*/([-%d]+)%s*";
	BFQuest_QUEST_PROGRESS = "Quest progress: ";
	BFQuest_QUEST_COMPLETED = " (Quest Completed)";
	BFQCompletedMatchPattern = "%(Complete%)";
	BFQCompletedSuffix = "(Complete)";
	
	TEAMNOTICE_CLASS={
		["DEATHKNIGHT"]='] "DEATHKNIGHT"',
		["DRUID"]='] "DRUID"',
		["WARLOCK"]='] "WARLOCK"',
		["WARRIOR"]='] "WARRIOR"',
		["HUNTER"]='] "Let the hunt begin"',
		["MAGE"]='] "MAGE"',
		["PRIEST"]='] "PRIEST"',
		["PALADIN"]='] "PALADIN"',
		["SHAMAN"]='] "SHAMAN"',
		["ROGUE"]='] "ROGUE"',
	};
	Raid_Ad_Text = "Welcome to the team, I hope we can cooperate happily, with a happy adventure."
	TEAMNOTICE_SET_PARTY_COMMENT = "Input to send the Team announced information";
	TEAMNOTICE_SET_ADD_COMMENT = "Input to send the Raid announced information";
	TEAMNOTICE_PARTY = "<BF Party hint>";
	TEAMNOTICE_RAID = "<BF Raid hint>";
	TEAMNOTICE_JOIN = "Welcome to the new team members  [";
	Info_Text_Ad = "|cff00adefYou can set BF team tools options to customize the team announcement.|r";
end

--显示任务等级
local lvl = q:NewModule("Level","AceHook-3.0")

local function FastQuest_GetDiffColor(level)
	local lDiff = level - UnitLevel("player");
	if (lDiff >= 0) then
		for i= 1.00, 0.10, -0.10 do
			color = {r = 1.00, g = i, b = 0.00};
			if ((i/0.10)==(10-lDiff)) then return color; end
		end
	elseif ( -lDiff < GetQuestGreenRange() ) then
		for i= 0.90, 0.10, -0.10 do
			color = {r = i, g = 1.00, b = 0.00};
			if ((9-i/0.10)==(-1*lDiff)) then return color; end
		end
	elseif ( -lDiff == GetQuestGreenRange() ) then
		color = {r = 0.50, g = 1.00, b = 0.50};
	else
		color = {r = 0.75, g = 0.75, b = 0.75};
	end
	return color;
end

local function FastQuest_ChangeTitle(questLogTitle, questLogTitleText, level, questTag, suggestedGroup, isHeader, isDaily, Watch)
	local ColorTag = "";
	local DifTag = "";
	local LevelTag = "";
	local cQuestLevel = FastQuest_GetDiffColor(level);
	local LevelString = "";
	if (questLogTitleText and not isHeader) then
		ColorTag = "";
		if (questTag ~= nil) then
			if (isDaily) then
				questTag = format(DAILY_QUEST_TAG_TEMPLATE, questTag);
			end
			DifTag = (" ("..questTag..") ");

			if (questTag == LFG_TYPE_DUNGEON ) then LevelTag = "d";
			elseif (questTag == RAID ) then LevelTag = "r";
			elseif (questTag == PVP ) then LevelTag = "p";
			else LevelTag = "+"; end

		elseif (isDaily) then
			DifTag = (" ("..DAILY..") ");
		end

		LevelString = "["..level..LevelTag.."] ";
		
		if (Watch) then
			questLogTitle:SetText(ColorTag..LevelString..questLogTitleText..DifTag);
		else
			if suggestedGroup > 0 then
				questLogTitle:SetText(ColorTag.." "..LevelString..questLogTitleText.." ("..suggestedGroup..") ");
			else
				questLogTitle:SetText(ColorTag.." "..LevelString..questLogTitleText.." ");
			end
		end
	end
end

function lvl:QuestLogTitleButton_Resize(line)
	
	local index = line:GetID();	
	local questLogTitleText, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(index);
		
	if level then
		FastQuest_ChangeTitle(line, questLogTitleText, level, questTag, suggestedGroup, isHeader, isDaily, false);
	end
	self.hooks.QuestLogTitleButton_Resize(line);
end

function lvl:OnEnable()
	self:RawHook("QuestLogTitleButton_Resize", true);
	--show quest level
end

function lvl:OnDisable()
	self:Unhook("QuestLogTitleButton_Resize");
	--hide quest level
end

-- 小队通报模块
local broad = q:NewModule("Broadcast","AceEvent-3.0")
local FastQuestInfo=nil;
local FastQuestTable={};

function broad:UI_INFO_MESSAGE(...)
	local arg = {...};
	if arg[2] then
		local message = arg[2];
		if message then
			if GetNumPartyMembers() == 0 then
				BFQuest_SendNotification(1);
			elseif string.find(message, BFQuest_TestPatterns) then
				local _,num1,num2=string.match(message, BFQuest_TestPatterns)
				if FastQuestInfo==1 then
					if num1 == num2 then
						SendChatMessage(BFQuest_QUEST_PROGRESS..message..BFQCompletedSuffix, "party");
						BFQuest_SendNotification()
					else
						SendChatMessage(BFQuest_QUEST_PROGRESS..message, "party");
					end
				elseif num1 and num1 == num2 then
					SendChatMessage(BFQuest_QUEST_PROGRESS..message..BFQCompletedSuffix, "party");
					BFQuest_SendNotification()
				end
			elseif string.find(message, BFQCompletedMatchPattern) then
				SendChatMessage(BFQuest_QUEST_PROGRESS..message, "party");
				BFQuest_SendNotification()
			end
		end
	end
end

function broad:QUEST_ACCEPTED(...)
	BFQuest_SendNotification(1);
end
function BFQuest_GetTable()
	local tempTable={}
	for i=1, GetNumQuestLogEntries(), 1 do
		local questLogTitleText, _, _, _, _, _, isComplete, _,questID = GetQuestLogTitle(i);
		if questLogTitleText then
			tempTable[questLogTitleText]=isComplete
		end
	end
	return tempTable
end

function BFQuest_SendNotification(silent)
	if not silent then
		local uQuestTable={}
		BigFoot_DelayCall(function()
			uQuestTable =BFQuest_GetTable();
			for key,value in pairs(uQuestTable) do
				if FastQuestTable then
					if not FastQuestTable[key] then
						SendChatMessage(key..BFQuest_QUEST_COMPLETED, "party");
						break;
					end
				end
			end
			FastQuestTable=uQuestTable
		end,
		1)
	else
		BigFoot_DelayCall(function()
			FastQuestTable =BFQuest_GetTable();
		end,
		1)
	end
end

function broad:OnEnable()
	self:RegisterEvent("UI_INFO_MESSAGE");
	self:RegisterEvent("QUEST_ACCEPTED");
	BigFoot_DelayCall(function()
		FastQuestTable =BFQuest_GetTable();
	end,
	1)
end

function broad:OnDisable()
	self:UnregisterAllEvents()
end

function Auto_FastQuestInfo(arg)
	FastQuestInfo=arg
end

--进队喊话，自动M语
local TeamNotice = q:NewModule("TeamNotice","AceEvent-3.0")
TeamNotice_Comment={};
local _TeamNotice_PartyText_Comment;
local _TeamNotice_RaidText_Comment;
local _party = {};
local _numM=0;
local _partyEnable=nil;
local _raidEnable=nil;
local _Switch=1;
local _ad_swith=1;

function TeamNotice:OnEnable()
	_TeamNotice_PartyText_Comment=TeamNotice_Comment.PartyText or "";
	_TeamNotice_RaidText_Comment=TeamNotice_Comment.RaidText or Raid_Ad_Text;
	BigFoot_DelayCall(function()
		self:RegisterEvent("PARTY_MEMBERS_CHANGED");
		self:RegisterEvent("RAID_ROSTER_UPDATE");
		if  GetNumRaidMembers()>0 then
			for i=1, GetNumRaidMembers(), 1 do
				local name = (UnitName("raid"..i))
				if(name and name~=UnitName("player")) then
					local class = select(2,UnitClass("raid"..i))
					_party[name] = class;
				end
			end
			_numM=GetNumRaidMembers();
		elseif  GetNumPartyMembers()>0 then
			for i=1, GetNumPartyMembers(), 1 do
				local name = (UnitName("party"..i))
				if name then
					local class = select(2,UnitClass("party"..i))
					local _class= (UnitClass("party"..i))
					_party[name] = _class;
				end
			end
			_numM=GetNumPartyMembers()+1;
		end
	end,
	3)
end

function TeamNotice:OnDisable()
	self:UnregisterAllEvents()
end

function TeamNotice:PARTY_MEMBERS_CHANGED(...)
	if _partyEnable==0 then return end
	if UnitInBattleground("player") then return end
	if GetNumRaidMembers()>1 then return end
	local arg = {...};
	if arg[1] then
		local _temparty={}
		for i=1, GetNumPartyMembers(), 1 do 
			local name = (UnitName("party"..i))
			if name then
				local class = select(2,UnitClass("party"..i))
				local _class= (UnitClass("party"..i))
				_temparty[name] = _class;
			end
		end
		if IsRealPartyLeader() then		--UnitIsPartyLeader("player")
			for name,class in pairs(_temparty) do
				if not _party[name] then 
					local Temp_Message;
					if _TeamNotice_PartyText_Comment == "" then
						Temp_Message = TEAMNOTICE_PARTY..TEAMNOTICE_JOIN..class.."] "..name;
					else
						Temp_Message = TEAMNOTICE_PARTY.._TeamNotice_PartyText_Comment;
					end
					SendChatMessage(Temp_Message, "party");
				end
			end
		end
		_party=_temparty;
		_numM=GetNumPartyMembers()+1;
	end
end

function TeamNotice:RAID_ROSTER_UPDATE(...)
	if _raidEnable==0 then return end
	if UnitInBattleground("player") then return end
	local arg = {...};
	if arg[1] then
		if _numM~=GetNumRaidMembers() then
			_numM=GetNumRaidMembers();
			local _tempraid={}
			for i=1, GetNumRaidMembers(), 1 do
				local name = (UnitName("raid"..i))
				if (name and name~=UnitName("player")) then
					local class = select(2,UnitClass("raid"..i))
					_tempraid[name] = class;
				end
			end
			if IsRealRaidLeader() then
				for name,class in pairs(_tempraid) do
					if not _party[name] then 
						SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment,"WHISPER",nil,name);
					end
				end
			end
			_party=_tempraid;
		else
			if IsRealRaidLeader() then
				if _Switch then
					SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment, "raid");
					_Switch=nil;
					if _ad_swith then
						print(TEAMNOTICE_RAID..Info_Text_Ad);
						_ad_swith=nil;
					end
				end
			else
				_Switch=1;
			end
		end
	end
end

function Auto_TeamNotice_Party(arg)
	_partyEnable=arg;
end

function Auto_TeamNotice_Raid(arg)
	_raidEnable=arg;
end

if (GetLocale() == "zhCN") then
	--小队公告设置
	StaticPopupDialogs["TEAMNOTICE_PARTY_COMMENT"] = {
		text = TEAMNOTICE_SET_PARTY_COMMENT,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 48,
		hasWideEditBox = 1,
		OnAccept = function(self)
			local editBox = _G[self:GetName().."WideEditBox"];
			_TeamNotice_PartyText_Comment=editBox:GetText();
			TeamNotice_Comment.PartyText=_TeamNotice_PartyText_Comment;
			if  GetNumPartyMembers()>0 and IsRealPartyLeader() then
				SendChatMessage(TEAMNOTICE_PARTY.._TeamNotice_PartyText_Comment, "party");
			end
		end,
		OnShow = function(self)
			_G[self:GetName().."WideEditBox"]:SetText(_TeamNotice_PartyText_Comment);
			_G[self:GetName().."WideEditBox"]:HighlightText();
		end,
		OnHide = function(self)
			_G[self:GetName().."WideEditBox"]:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			local editBox = _G[self:GetName()];
			_TeamNotice_PartyText_Comment=editBox:GetText();
			TeamNotice_Comment.PartyText=_TeamNotice_PartyText_Comment;
			if  GetNumPartyMembers()>0 and IsRealPartyLeader() then
				SendChatMessage(TEAMNOTICE_PARTY.._TeamNotice_PartyText_Comment, "party");
			end
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};
	--团队公告设置
	StaticPopupDialogs["TEAMNOTICE_SET_COMMENT"] = {
		text = TEAMNOTICE_SET_ADD_COMMENT,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 48,
		hasWideEditBox = 1,
		OnAccept = function(self)
			local editBox = _G[self:GetName().."WideEditBox"];
			_TeamNotice_RaidText_Comment=editBox:GetText();
			TeamNotice_Comment.RaidText=_TeamNotice_RaidText_Comment;
			if  GetNumRaidMembers()>0 and IsRealRaidLeader() then
				SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment, "raid");
			end
		end,
		OnShow = function(self)
			_G[self:GetName().."WideEditBox"]:SetText(_TeamNotice_RaidText_Comment);
			_G[self:GetName().."WideEditBox"]:HighlightText();
		end,
		OnHide = function(self)
			_G[self:GetName().."WideEditBox"]:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			local editBox = _G[self:GetName()];
			_TeamNotice_RaidText_Comment=editBox:GetText();
			TeamNotice_Comment.RaidText=_TeamNotice_RaidText_Comment;
			if  GetNumRaidMembers()>0 and IsRealRaidLeader() then
				SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment, "raid");
			end
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};
else
	--小队公告设置
	StaticPopupDialogs["TEAMNOTICE_PARTY_COMMENT"] = {
		text = TEAMNOTICE_SET_PARTY_COMMENT,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 48,
		OnAccept = function(self)
			local editBox = _G[self:GetName().."EditBox"];
			_TeamNotice_PartyText_Comment=editBox:GetText();
			TeamNotice_Comment.PartyText=_TeamNotice_PartyText_Comment;
			if  GetNumPartyMembers()>0 and IsRealPartyLeader() then
				SendChatMessage(TEAMNOTICE_PARTY.._TeamNotice_PartyText_Comment, "party");
			end
		end,
		OnShow = function(self)
			_G[self:GetName().."EditBox"]:SetText(_TeamNotice_PartyText_Comment);
			_G[self:GetName().."EditBox"]:HighlightText();
		end,
		OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			local editBox = _G[self:GetName()];
			_TeamNotice_PartyText_Comment=editBox:GetText();
			TeamNotice_Comment.PartyText=_TeamNotice_PartyText_Comment;
			if  GetNumPartyMembers()>0 and IsRealPartyLeader() then
				SendChatMessage(TEAMNOTICE_PARTY.._TeamNotice_PartyText_Comment, "party");
			end
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};
	--团队公告设置
	StaticPopupDialogs["TEAMNOTICE_SET_COMMENT"] = {
		text = TEAMNOTICE_SET_ADD_COMMENT,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		maxLetters = 48,
		OnAccept = function(self)
			local editBox = _G[self:GetName().."EditBox"];
			_TeamNotice_RaidText_Comment=editBox:GetText();
			TeamNotice_Comment.RaidText=_TeamNotice_RaidText_Comment;
			if  GetNumRaidMembers()>0 and IsRealRaidLeader() then
				SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment, "raid");
			end
		end,
		OnShow = function(self)
			_G[self:GetName().."EditBox"]:SetText(_TeamNotice_RaidText_Comment);
			_G[self:GetName().."EditBox"]:HighlightText();
		end,
		OnHide = function(self)
			_G[self:GetName().."EditBox"]:SetText("");
		end,
		EditBoxOnEnterPressed = function(self)
			local editBox = _G[self:GetName()];
			_TeamNotice_RaidText_Comment=editBox:GetText();
			TeamNotice_Comment.RaidText=_TeamNotice_RaidText_Comment;
			if  GetNumRaidMembers()>0 and IsRealRaidLeader() then
				SendChatMessage(TEAMNOTICE_RAID.._TeamNotice_RaidText_Comment, "raid");
			end
			self:GetParent():Hide();
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide();
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	};	
end

--修改QuestInfo任务追踪的设置
local plugin = q:NewModule("QIPlugin","AceEvent-3.0","AceHook-3.0")
local questInfo

function plugin:OnQuestUpdate()
	if not questInfo then return end
	if (GetNumQuestWatches() > 0) then
		questInfo:ShowActiveQuests(true)
	else
		questInfo:ShowActiveQuests()
	end
end

function plugin:ZONE_CHANGED_NEW_AREA()
	self:OnQuestUpdate()
end

function plugin:ADDON_LOADED(...)
	local _,name = ...
	if name ~="QuestInfo" then return end
	if not questInfo then questInfo = _G.Cartographer_QuestInfo end
	self:UnregisterEvent("ADDON_LOADED")
end

function plugin:OnEnable()
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	
	self:SecureHook("ToggleFrame",function(frame)
		if frame==_G.WorldMapFrame then
			if frame:IsShown() then
				self:OnQuestUpdate()
			end
		end
	end)
	self:SecureHook("RemoveQuestWatch","OnQuestUpdate")
	self:SecureHook("AddQuestWatch","OnQuestUpdate")
	questInfo = _G.Cartographer_QuestInfo
	if not questInfo then
		self:RegisterEvent("ADDON_LOADED")
	end
end

function plugin:OnDisable()
	self:UnregisterAllEvents()
	self:UnhookAll()
end