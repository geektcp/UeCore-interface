assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALReady")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Options for ready checks and votes."] = true,
	["Ready"] = true,
	["Not Ready"] = true,
	["Are you Ready?"] = true,
	["Yes"] = true,
	["No"] = true,
	["Ready Check"] = true,
	["Perform a ready check."] = true,
	["Close"] = true,
	["<CTRaid> %s has performed a ready check."] = true,
	["AFK: "] = true,
	["Not Ready: "] = true,
	["Yes: %d No: %d AFK: %d"] = true,
	["Vote Results for: "] = true,
	["<CTRaid> %s has performed a vote: %s"] = true,
	["Vote"] = true,
	["Perform a vote."] = true,
	["<vote>"] = true,
	["Leader/Ready"] = true,
	["Show Results"] = true,
	["Show Other Results"] = true,
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = true,
	["Show Results when you start a readycheck."] = true,
	
} end)

L:RegisterTranslations("koKR", function() return {
	["Options for ready checks and votes."] = "준비확인과 투표에 대한 설정입니다.",
	["Ready"] = "준비완료",
	["Not Ready"] = "준비안됨",
	["Are you Ready?"] = "준비 되셨습니까?",
	["Yes"] = "예",
	["No"] = "아니오",
	["Ready Check"] = "준비 확인",
	["Perform a ready check."] = "준비 상태를 확인 합니다.",
	["Close"] = "닫기",
	["<CTRaid> %s has performed a ready check."] = "<공격대 도우미> %s님이 준비 상태를 확인합니다.",
	["AFK: "] = "자리비움: ",
	["Not Ready: "] = "준비안됨: ",
	["Yes: %d No: %d AFK: %d"] = "예: %d 아니오: %d 자리비움: %d",
	["Vote Results for: "] = "투표 결과: ",
	["<CTRaid> %s has performed a vote: %s"] = "<공격대 도우미> %s님이 투표를 실시합니다.: %s",
	["Vote"] = "투표",
	["Perform a vote."] = "투표를 실시합니다.",
	["<vote>"] = "투표",
	["Leader/Ready"] = "공격대장/준비확인",
	["Show Results"] = "결과 보기",
	["Show Other Results"] = "다른 결과 보기",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "다른 사람이 준비 확인을 시작할 때 결과를 보여줍니다. (승급자 이상의 권한 필요)",
	["Show Results when you start a readycheck."] = "당신이 준비 확인을 시작할 때 결과를 보여줍니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Options for ready checks and votes."] = "就位确认与投票设置。",
	["Ready"] = "准备就绪",
	["Not Ready"] = "未准备好",
	["Are you Ready?"] = "准备好了么？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位确认",
	["Perform a ready check."] = "进行就位确认。",
	["Close"] = "关闭",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid>%s正在进行就位确认。",
	["AFK: "] = "暂离：",
	["Not Ready: "] = "未就绪：",
	["Yes: %d No: %d AFK: %d"] = "是：%d 否：%d 暂离：%d",
	["Vote Results for: "] = "投票结果：",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid>%s开始一场投票：%s",
	["Vote"] = "投票",
	["Perform a vote."] = "进行投票。",
	["<vote>"] = "<投票>",
	["Leader/Ready"] = "团长/就位",
	["Show Results"] = "显示结果",
	["Show Other Results"] = "显示其他结果",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "当其他人开始就位确认时显示结果。(需要 助理/团长)",
	["Show Results when you start a readycheck."] = "当你开始就位确认时显示结果。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Options for ready checks and votes."] = "就位確認與投票選項",
	["Ready"] = "已就緒",
	["Not Ready"] = "未就緒",
	["Are you Ready?"] = "準備好了嗎？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位確認",
	["Perform a ready check."] = "進行就位確認",
	["Close"] = "關閉",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid>%s正在進行就位確認",
	["AFK: "] = "暫離: ",
	["Not Ready: "] = "未就緒",
	["Yes: %d No: %d AFK: %d"] = "是：%d 否：%d 暫離：%d",
	["Vote Results for: "] = "投票結果：",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid>%s開始一場投票：%s",
	["Vote"] = "投票",
	["Perform a vote."] = "進行投票",
	["<vote>"] = "<投票>",
	["Leader/Ready"] = "領隊/就位確認",
	["Show Results"] = "顯示結果",
	["Show Other Results"] = "顯示其他結果",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "當其他人開始就位確認時顯示結果。(需要助理/領隊)",
	["Show Results when you start a readycheck."] = "當你開始就位確認時顯示結果。",
} end)

L:RegisterTranslations("frFR", function() return {
	["Options for ready checks and votes."] = "Options concernant les appels et les votes.",
	["Ready"] = "Prêt",
	["Not Ready"] = "Pas prêt",
	["Are you Ready?"] = "Êtes-vous prêt ?",
	["Yes"] = "Oui",
	["No"] = "Non",
	["Ready Check"] = "Appel",
	["Perform a ready check."] = "Fait l'appel.",
	["Close"] = "Fermer",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid> %s fait l'appel.",
	["AFK: "] = "ABS : ",
	["Not Ready: "] = "Pas prêt : ",
	["Yes: %d No: %d AFK: %d"] = "Oui : %d Non : %d ABS : %d",
	["Vote Results for: "] = "Résultat du vote pour : ",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid> %s a lancé un vote : %s",
	["Vote"] = "Vote",
	["Perform a vote."] = "Soumet un vote au raid.",
	["<vote>"] = "<vote>",
	["Leader/Ready"] = "Chef/Appel",
	["Show Results"] = "Afficher les résultats",
	["Show Other Results"] = "Afficher les résultats des autres",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "Affiche les résultats quand quelqu'un d'autre lance un appel (nécessite d'être assistant ou chef).",
	["Show Results when you start a readycheck."] = "Affiche les résultats quand vous lancez un appel.",
} end)

L:RegisterTranslations("deDE", function() return {
	["Options for ready checks and votes."] = "Optionen für Bereitschaftschecks und Abstimmungen.",
	["Ready"] = "Bereitschaft",
	["Not Ready"] = "Nicht Bereit",
	["Are you Ready?"] = "Bist Du Bereit?",
	["Yes"] = "Ja",
	["No"] = "Nein",
	["Ready Check"] = "Bereitschaftscheck",
	["Perform a ready check."] = "Startet einen Bereitschaftscheck.",
	["Close"] = "Schließen",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid> %s hat einen Bereitschaftscheck gestartet.",
	["AFK: "] = "AFK: ",
	["Not Ready: "] = "Nicht Bereit: ",
	["Yes: %d No: %d AFK: %d"] = "Ja: %d Nein: %d AFK: %d",
	["Vote Results for: "] = "Abstimmungsergebnis für: ",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid> %s hat eine Abstimmung gestartet: %s",
	["Vote"] = "Abstimmung",
	["Perform a vote."] = "Startet eine Abstimmung.",
	["<vote>"] = "<abstimmen>",
	["Leader/Ready"] = "Anführer/Bereitschaft",
	["Show Results"] = "Zeige Ergebnisse",
	["Show Other Results"] = "Zeige Ergebnisse von anderen",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "Zeigt Ergebnisse, wenn ein anderer einen Bereitschaftscheck gestartet hast. (Benötigt Assistent/Anführer)",
	["Show Results when you start a readycheck."] = "Zeigt Ergebnisse, wenn Du einen Bereitschaftscheck gestartet hast.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Options for ready checks and votes."] = "Опции проверки готовности и голосования.",
	["Ready"] = "Готов",
	["Not Ready"] = "Не готов",
	["Are you Ready?"] = "Вы готовы?",
	["Yes"] = "Да",
	["No"] = "Нет",
	["Ready Check"] = "Проверка готовности",
	["Perform a ready check."] = "Выполнить проверку готовности.",
	["Close"] = "Закрыть",
	["<CTRaid> %s has performed a ready check."] = "<CTRaid> %s выполнил проверку рейда.",
	["AFK: "] = "Отошел: ",
	["Not Ready: "] = "Не готов: ",
	["Yes: %d No: %d AFK: %d"] = "Да: %d Нет: %d Отошел: %d",
	["Vote Results for: "] = "Результаты проверки: ",
	["<CTRaid> %s has performed a vote: %s"] = "<CTRaid> %s выполнил голосование: %s",
	["Vote"] = "Голосовать",
	["Perform a vote."] = "Выполнить голосование.",
	["<vote>"] = "<голосование>",
	["Leader/Ready"] = "Лидер/Готовность",
	["Show Results"] = "Показать результат",
	["Show Other Results"] = "Показать другие результаты",
	["Show Results when someone else starts a readycheck. (Requires assistant/leader)"] = "Показывать результаты если ктото выполнил проверку готовности. (Требуется помощник/лидер)",
	["Show Results when you start a readycheck."] = "Показывает результат когда вы выполняете проверку готовности",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderReady")
mod.defaults = {
	showself = true,
	showother = true,
}
mod.leader = true
mod.name = L["Leader/Ready"]
mod.consoleCmd = "ready"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for ready checks and votes."],
	name = L["Ready"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {
		check = {
			name = L["Ready Check"], type = "execute",
			desc = L["Perform a ready check."],
			func = "PerformReadyCheck",
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
		},
		vote = {
			name = L["Vote"], type = "text",
			desc = L["Perform a vote."],
			usage = L["<vote>"],
			get = false,
			set = "PerformVote",
			validate = function(v)
				return v:find("^(.+)$")
			end,
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
		},
		showself = {
			name = L["Show Results"], type = "toggle",
			desc = L["Show Results when you start a readycheck."],
			get = function() return mod.db.profile.showself end,
			set = function(v)
				mod.db.profile.showself = v
			end,
		},
		showother = {
			name = L["Show Other Results"], type = "toggle",
			desc = L["Show Results when someone else starts a readycheck. (Requires assistant/leader)"],
			get = function() return mod.db.profile.showother end,
			set = function(v)
				mod.db.profile.showother = v
			end,
		}		
	}
}

------------------------------
--      Initialization      --
------------------------------

local votes = nil
local ready = nil

local playerName = UnitName("player")

function mod:OnEnable()
	self:RegisterEvent("READY_CHECK")
	self:RegisterEvent("READY_CHECK_CONFIRM")
	self:RegisterEvent("READY_CHECK_FINISHED")

	self:RegisterCheck("VOTEYES", "oRA_VoteYes")
	self:RegisterCheck("VOTENO", "oRA_VoteNo")

	self:RegisterShorthand("raready", "PerformReadyCheck")
	self:RegisterShorthand("rar", "PerformReadyCheck")
	self:RegisterShorthand("ravote", "PerformVote")

	self:SetupFrames()
end

-- helpers
local frame = nil

local function voteClose()
	mod:ReportVoteStatus()
	frame:Hide()
end

local function readyClose()
	-- mod:ReportReadyStatus()
	frame:Hide()
end

-------------------------
--   Command Handlers  --
-------------------------

local closebuttontext = nil
local closebutton = nil

local question = nil

function mod:PerformReadyCheck()
	if not oRA:IsPromoted() then return end
	DoReadyCheck()
end

function mod:PerformVote(voteQuestion)
	if not oRA:IsPromoted() then return end
	if not voteQuestion or voteQuestion == "" then return end

	question = voteQuestion

	votes = self:del(votes)
	votes = self:new()

	for i = 1, GetNumRaidMembers(), 1 do
		local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
		if online and name ~= UnitName("player") then votes[name] = "no reply" end
	end

	frame.rheader:SetText(L["Vote"])
	frame.leftinfo:SetText("")
	frame.rightinfo:SetText("")

	frame.closebuttontext:SetText(L["Close"])

	frame.closebutton:SetScript("OnClick", voteClose)

	frame:Show()
	self:UpdateReport(votes, "yes", "no")
	SendChatMessage(string.format(L["<CTRaid> %s has performed a vote: %s"], UnitName("player"), question), "RAID")
	oRA:SendMessage("VOTE "..question)
end

-------------------------
--   Event Handlers    --
-------------------------

function mod:READY_CHECK(author, duration)
	if not oRA:IsPromoted() then return end

	-- raid officers will get the overview
	ready = self:del(ready)
	ready = self:new()

	for i = 1, GetNumRaidMembers(), 1 do
		local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
		if online then ready[name] = "no reply" end
	end

	ready[author] = "ready"

	if not self.db.profile.showself and author == playerName then return end
	if not self.db.profile.showother and author ~= playerName then return end
	
	frame.rheader:SetText(L["Ready Check"])
	frame.leftinfo:SetText("")
	frame.rightinfo:SetText("")

	frame.closebuttontext:SetText(L["Close"])

	frame.closebutton:SetScript("OnClick", readyClose)
	
	frame:Show()
	self:UpdateReport(ready, "ready", "not ready")
end

function mod:READY_CHECK_CONFIRM(raidid, confirm)
	-- only raid leader / officers will receive this
	if not ready then ready = self:new() end
	local name = UnitName("raid"..raidid)
	if confirm == 1 then -- explicit check for 1 since it's 1 / 0
		ready[name] = "ready"
	else
		ready[name] = "not ready"
	end
	self:UpdateReport(ready, "ready", "not ready")
end

function mod:READY_CHECK_FINISHED()
	frame:Hide() -- always hide the frame, can't hurt

	if not oRA:IsPromoted() then return end
	if not IsRaidLeader() then -- raidleader
		self:ReportReadyStatus() -- might be too much
	end
end

function mod:oRA_VoteYes(msg, author)
	if not oRA:IsPromoted() then return end
	if not votes then votes = self:new() end
	votes[author] = "yes"
	self:UpdateReport(votes, "yes", "no")
end

function mod:oRA_VoteNo(msg, author)
	if not oRA:IsPromoted() then return end
	if not votes then votes = self:new() end
	votes[author] = "no"
	self:UpdateReport(votes, "yes", "no")
end

--------------------------
--     Core function    --
--------------------------

function mod:ReportReadyStatus()
	if not ready then return end
	local noreply, notready = "", ""
	for name, status in pairs(ready) do
		if status == "no reply" then noreply = noreply..name.." "
		elseif status == "not ready" then notready = notready..name.." "
		end
	end
	if noreply ~= "" then self:Print(L["AFK: "]..noreply) end
	if notready ~= "" then self:Print(L["Not Ready: "]..notready) end
end

function mod:ReportVoteStatus()
	if not votes then return end
	local noreply, yes, no = 0,0,0
	for name, vote in pairs(votes) do
		if vote == "no reply" then noreply = noreply + 1
		elseif vote == "no" then no = no + 1
		else yes = yes + 1
		end
	end
	SendChatMessage(L["Vote Results for: "]..question, "RAID")
	SendChatMessage(string.format(L["Yes: %d No: %d AFK: %d"], yes, no, noreply), "RAID")
end

------------------------------------
--     Frame Setup and Handling   --
------------------------------------

function mod:UpdateReport(t, green, red)
	local text = ""
	local i = 0
	for name, state in pairs(t) do
		i = i + 1
		if i == 21 then text = "" end
		
		if state == "no reply" then
			text = text .. "|c00CCCCCC" .. name .. "|r\n"
		elseif state == red then
			text = text .. "|c00FF0000" .. name .. "|r\n"
		else
			text = text .. "|c0000FF00" .. name .. "|r\n"
		end
		
		if i <= 20 then frame.leftinfo:SetText(text)
		else frame.rightinfo:SetText(text) end
	end
end

function mod:SetupFrames()
	local f = GameFontNormal:GetFont()
	local report = CreateFrame("Frame", nil, UIParent)
	report:Hide()
	report:SetWidth(325)
	report:SetHeight(325)
	report:EnableMouse(true)
	report:SetMovable(true)
	report:RegisterForDrag("LeftButton")
	report:SetScript("OnDragStart", function() this:StartMoving() end)
	report:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
	report:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
		})
	report:SetBackdropBorderColor(.5, .5, .5)
	report:SetBackdropColor(0,0,0)
	report:ClearAllPoints()
	report:SetPoint("BOTTOM", ReadyCheckFrame, "TOP", 0, 0)

	-- Local pointer
	frame = report

	local rfade = report:CreateTexture(nil, "BORDER")
	rfade:SetWidth(319)
	rfade:SetHeight(25)
	rfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	rfade:SetPoint("TOP", report, "TOP", 0, -4)
	rfade:SetBlendMode("ADD")
	rfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)

	local rheader = report:CreateFontString(nil,"OVERLAY")
	rheader:SetFont(f, 14)
	rheader:SetWidth(300)
	rheader:SetText("header")
	rheader:SetTextColor(1, .8, 0)
	rheader:ClearAllPoints()
	rheader:SetPoint("TOP", report, "TOP", 0, -10)
	frame.rheader = rheader
	
	local leftinfo = report:CreateFontString(nil,"OVERLAY")
	leftinfo:SetFont(f, 12)
	leftinfo:SetWidth(175)
	leftinfo:SetHeight(300)
	leftinfo:SetJustifyV("TOP")
	leftinfo:SetText("leftinfo")
	leftinfo:ClearAllPoints()
	leftinfo:SetPoint("TOPLEFT", report, "TOPLEFT", 0, -30)
	frame.leftinfo = leftinfo

	local rightinfo = report:CreateFontString(nil,"OVERLAY")
	rightinfo:SetFont(f, 12)
	rightinfo:SetWidth(175)
	rightinfo:SetHeight(300)
	rightinfo:SetJustifyV("TOP")
	rightinfo:SetText("rightinfo")
	rightinfo:ClearAllPoints()
	rightinfo:SetPoint("TOPRIGHT", report, "TOPRIGHT", 0, -30)
	frame.rightinfo = rightinfo

	closebutton = CreateFrame("Button", nil, report)
	closebutton.owner = self
	closebutton:SetWidth(125)
	closebutton:SetHeight(32)
	closebutton:SetPoint("BOTTOM", report, "BOTTOM", 0, 10)
	frame.closebutton = closebutton

	local t = closebutton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", closebutton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	closebutton:SetNormalTexture(t)

	t = closebutton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(closebutton)
	closebutton:SetPushedTexture(t)

	t = closebutton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(closebutton)
	t:SetBlendMode("ADD")
	closebutton:SetHighlightTexture(t)

	closebuttontext = closebutton:CreateFontString(nil,"OVERLAY")
	closebuttontext:SetFontObject(GameFontHighlight)
	closebuttontext:SetText("left")
	closebuttontext:SetAllPoints(closebutton)
	frame.closebuttontext = closebuttontext
end

