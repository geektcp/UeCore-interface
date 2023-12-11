assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 612 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAPReady")
local media = LibStub("LibSharedMedia-3.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Options for ready checks and votes."] = true,
	["Sound"] = true,
	["Toggle an audio warning upon a ready check or vote."] = true,
	["Ready"] = true,
	["Not Ready"] = true,
	["Are you Ready?"] = true,
	["Yes"] = true,
	["No"] = true,
	["Ready Check"] = true,
	["check"] = true,
	["Vote"] = true,
	["Participant/Ready"] = true,
	["Closing Vote"] = true,
	["Closing Check"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Options for ready checks and votes."] = "준비 확인과 투표에 대한 설정입니다.",
	["Sound"] = "소리",
	["Toggle an audio warning upon a ready check or vote."] = "투표나 준비 확인시 경고음 재생을 선택합니다.",
	["Ready"] = "준비완료",
	["Not Ready"] = "준비안됨",
	["Are you Ready?"] = "준비 되셨습니까?",
	["Yes"] = "예",
	["No"] = "아니오",
	["Ready Check"] = "준비 확인",
	["Vote"] = "투표",
	["Participant/Ready"] = "부분/준비",
	["Closing Vote"] = "투표 닫기",
	["Closing Check"] = "확인 닫기",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Options for ready checks and votes."] = "就位确认和投票的选项。",
	["Sound"] = "声音",
	["Toggle an audio warning upon a ready check or vote."] = "准备检查或投票时发声。",
	["Ready"] = "准备就绪",
	["Not Ready"] = "未准备好",
	["Are you Ready?"] = "准备好了么？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位确认",
	["check"] = "确认",
	["Vote"] = "投票",
	["Participant/Ready"] = "成员/就位",
	["Closing Vote"] = "关闭投票",
	["Closing Check"] = "关闭检查",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Options for ready checks and votes."] = "就位確認與投票選項",
	["Sound"] = "聲音",
	["Toggle an audio warning upon a ready check or vote."] = "就位確認與投票時播放音效",
	["Ready"] = "已就緒",
	["Not Ready"] = "未就緒",
	["Are you Ready?"] = "準備好了嗎？",
	["Yes"] = "是",
	["No"] = "否",
	["Ready Check"] = "就位確認",
	["Vote"] = "投票",
	["Participant/Ready"] = "隊員/就位確認",
	["Closing Vote"] = "關閉投票",
	["Closing Check"] = "關閉檢查",
} end)

L:RegisterTranslations("frFR", function() return {
	["Options for ready checks and votes."] = "Options concernant les appels et les votes.",
	["Sound"] = "Son",
	["Toggle an audio warning upon a ready check or vote."] = "Joue ou non un avertissement sonore lors d'un appel ou d'un vote.",
	["Ready"] = "Prêt",
	["Not Ready"] = "Pas prêt",
	["Are you Ready?"] = "Êtes-vous prêt ?",
	["Yes"] = "Oui",
	["No"] = "Non",
	["Ready Check"] = "Appel",
	["check"] = "check",
	["Vote"] = "Vote",
	["Participant/Ready"] = "Participant/Appel",
	["Closing Vote"] = "Clôture du vote",
	["Closing Check"] = "Clôture de l'appel",
} end)

L:RegisterTranslations("deDE", function() return {
	["Options for ready checks and votes."] = "Optionen für Bereichtschaftschecks und Abstimmungen.",
	["Sound"] = "Sound",
	["Toggle an audio warning upon a ready check or vote."] = "Bei einem Bereitschaftscheck oder einer Abstimmung einen Warnton ausgeben.",
	["Ready"] = "Bereitschaft",
	["Not Ready"] = "Nicht Bereit",
	["Are you Ready?"] = "Bist Du Bereit?",
	["Yes"] = "Ja",
	["No"] = "Nein",
	["Ready Check"] = "Bereitschaftscheck",
	["Vote"] = "Abstimmung",
	["Participant/Ready"] = "Teilnehmer/Bereitschaft",
	["Closing Vote"] = "Schließe Abstimmung",
	["Closing Check"] = "Schließe Bereitschaftcheck",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Options for ready checks and votes."] = "Опции проверки готовности и голосования.",
	["Sound"] = "Звук",
	["Toggle an audio warning upon a ready check or vote."] = "Вкл/Выкл звуковое предупреждение при проверке или голосовании.",
	["Ready"] = "Готов",
	["Not Ready"] = "Не готов",
	["Are you Ready?"] = "Вы готовы?",
	["Yes"] = "Да",
	["No"] = "Нет",
	["Ready Check"] = "Проверка готовности",
	["check"] = "Проверка",
	["Vote"] = "Голосование",
	["Participant/Ready"] = "Участник/Готов",
	["Closing Vote"] = "Закрыть голосование",
	["Closing Check"] = "Закрыть проверку",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("ParticipantReady", "CandyBar-2.0")
mod.defaults = {
	sound = true,
}
mod.participant = true
mod.name = L["Participant/Ready"]
mod.consoleCmd = "ready"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for ready checks and votes."],
	name = L["Ready"],
	disabled = function() return not oRA:IsActive() end,
	args = {
		sound = {
			name = L["Sound"], type = "toggle",
			desc = L["Toggle an audio warning upon a ready check or vote."],
			get = function() return mod.db.profile.sound end,
			set = function(v)
				mod.db.profile.sound = v
			end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterCheck("CHECKREADY", "oRA_ReadyCheck")
	self:RegisterCheck("VOTE", "oRA_Vote")
	self:RegisterEvent("oRA_BarTexture")
end

-------------------------
--   Event Handlers    --
-------------------------

-- Handles an incoming ready check

function mod:oRA_ReadyCheck(msg, author)
	if UnitName("player") ~= author then
		if self.db.profile.sound then PlaySoundFile("Sound\\interface\\levelup2.wav") end
		self:ShowReady(author)
	end
end

-- Handles an incoming vote

function mod:oRA_Vote(msg, author)
	local question = select(3, msg:find("^VOTE (.+)$"))
	if not question then return end
	if UnitName("player") ~= author then
		if self.db.profile.sound then PlaySoundFile("Sound\\interface\\levelup2.wav") end
		self:ShowVote(author, question)
	end
end

function mod:oRA_BarTexture(texture)
	if self:CandyBarStatus("oRAPReadyTimeOut") then
		self:SetCandyBarTexture("oRAPReadyTimeOut", media:Fetch('statusbar', texture))
	end
end

--------------------------
--     Core function    --
--------------------------

function mod:Vote(answer)
	if not answer then return end
	if answer=="yes" then oRA:SendMessage("VOTEYES")
	elseif answer=="no" then oRA:SendMessage("VOTENO")
	end
end

function mod:Ready(readystate)
	if not readystate then return end
	oRA:SendMessage(readystate:upper())
end

------------------------------------
--     Frame Setup and Handling   --
------------------------------------

local header = nil
local info = nil
local leftButtonText = nil
local rightButtonText = nil
local leftButton = nil
local rightButton = nil
local check = nil

local function hideCheck()
	check:Hide()
end

function mod:ShowVote(author, question)
	self:SetupFrames()

	header:SetText(L["Vote"])
	info:SetText("|cffffffff"..author.. "|r: " .. question)
	leftButtonText:SetText(L["Yes"])
	rightButtonText:SetText(L["No"])
	leftButton:SetScript("OnClick", function()
		self:Vote("yes")
		self:StopCandyBar("oRAPReadyTimeOut")
		check:Hide()
		self:CancelScheduledEvent("oRAPReady_HideCheck")
	end)
	rightButton:SetScript("OnClick", function()
		self:Vote("no")
		self:StopCandyBar("oRAPReadyTimeOut")
		check:Hide()
		self:CancelScheduledEvent("oRAPReady_HideCheck")
	end)

	check:Show()

	self:RegisterCandyBar("oRAPReadyTimeOut", 30, L["Closing Vote"], nil,  0, 1, 0,   1, 1, 0,   1, 0, 0 )
	self:SetCandyBarPoint("oRAPReadyTimeOut", "BOTTOM", check, "BOTTOM", 0, 7)
	self:SetCandyBarBackgroundColor("oRAPReadyTimeOut", "black", 0)
	self:SetCandyBarTexture("oRAPReadyTimeOut", media:Fetch('statusbar',  oRA.db.profile.bartexture))
	self:StartCandyBar("oRAPReadyTimeOut", true)

	self:ScheduleEvent("oRAPReady_HideCheck", hideCheck, 30)
end

function mod:ShowReady(author)
	self:SetupFrames()

	header:SetText(L["Ready Check"])
	info:SetText("|cffffffff"..author.. "|r: " .. L["Are you Ready?"])
	leftButtonText:SetText(L["Ready"])
	rightButtonText:SetText(L["Not Ready"])

	leftButton:SetScript("OnClick", function()
		self:Ready("ready")
		self:StopCandyBar("oRAPReadyTimeOut") 
		check:Hide()
		self:CancelScheduledEvent("oRAPReady_HideCheck")
	end)
	rightButton:SetScript("OnClick", function()
		self:Ready("notready") 
		self:StopCandyBar("oRAPReadyTimeOut")
		check:Hide()
		self:CancelScheduledEvent("oRAPReady_HideCheck")
	end)
	check:Show()

	self:RegisterCandyBar("oRAPReadyTimeOut", 30, L["Closing Check"], nil,  0, 1, 0,   1, 1, 0,   1, 0, 0 )
	self:SetCandyBarPoint("oRAPReadyTimeOut", "BOTTOM", check, "BOTTOM", 0, 7)
	self:SetCandyBarBackgroundColor("oRAPReadyTimeOut", "black", 0)
	self:SetCandyBarTexture("oRAPReadyTimeOut", media:Fetch('statusbar', oRA.db.profile.bartexture))
	self:StartCandyBar("oRAPReadyTimeOut", true)

	self:ScheduleEvent("oRAPReady_HideCheck", hideCheck, 30)
end

function mod:SetupFrames()
	if check then return end

	local f = GameFontNormal:GetFont()

	check = CreateFrame("Frame", nil, UIParent)
	check:Hide()
	check:SetWidth(325)
	check:SetHeight(125)
	check:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	check:SetBackdropBorderColor(.5, .5, .5)
	check:SetBackdropColor(0,0,0)
	check:ClearAllPoints()
	check:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	local cfade = check:CreateTexture(nil, "BORDER")
	cfade:SetWidth(319)
	cfade:SetHeight(25)
	cfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	cfade:SetPoint("TOP", check, "TOP", 0, -4)
	cfade:SetBlendMode("ADD")
	cfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)

	header = check:CreateFontString(nil,"OVERLAY")
	header:SetFont(f, 14)
	header:SetWidth(300)
	header:SetText("header")
	header:SetTextColor(1, .8, 0)
	header:ClearAllPoints()
	header:SetPoint("TOP", check, "TOP", 0, -10)

	info = check:CreateFontString(nil,"OVERLAY")
	info:SetFont(f, 10)
	info:SetWidth(300)
	info:SetText("info")
	info:SetTextColor(1, .8, 0)
	info:ClearAllPoints()
	info:SetPoint("TOP", header, "BOTTOM", 0, -10)

	leftButton = CreateFrame("Button", nil, check)
	leftButton:SetWidth(125)
	leftButton:SetHeight(32)
	leftButton:SetPoint("RIGHT", check, "CENTER", -10, -20)

	local t = leftButton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", leftButton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	leftButton:SetNormalTexture(t)

	t = leftButton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(leftButton)
	leftButton:SetPushedTexture(t)

	t = leftButton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(leftButton)
	t:SetBlendMode("ADD")
	leftButton:SetHighlightTexture(t)
	leftButtonText = leftButton:CreateFontString(nil,"OVERLAY")
	leftButtonText:SetFontObject(GameFontHighlight)
	leftButtonText:SetText("left")
	leftButtonText:SetAllPoints(leftButton)

	rightButton = CreateFrame("Button", nil, check)
	rightButton:SetWidth(125)
	rightButton:SetHeight(32)
	rightButton:SetPoint("LEFT", check, "CENTER", 10, -20)

	t = rightButton:CreateTexture()
	t:SetWidth(125)
	t:SetHeight(32)
	t:SetPoint("CENTER", rightButton, "CENTER")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	rightButton:SetNormalTexture(t)

	t = rightButton:CreateTexture(nil, "BACKGROUND")
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(rightButton)
	rightButton:SetPushedTexture(t)

	t = rightButton:CreateTexture()
	t:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	t:SetTexCoord(0, 0.625, 0, 0.6875)
	t:SetAllPoints(rightButton)
	t:SetBlendMode("ADD")
	rightButton:SetHighlightTexture(t)
	rightButtonText = rightButton:CreateFontString(nil,"OVERLAY")
	rightButtonText:SetFontObject(GameFontHighlight)
	rightButtonText:SetText("right")
	rightButtonText:SetAllPoints(rightButton)
end

