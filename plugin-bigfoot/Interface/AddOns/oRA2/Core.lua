------------------------------
--      Are you local?      --
------------------------------
local L = AceLibrary("AceLocale-2.2"):new("oRA")
local dew = AceLibrary("Dewdrop-2.0")
local win = AceLibrary("Window-1.0")
local icon = LibStub("LibDBIcon-1.0", true)

local CTRAversion = "2.005"

local media = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------
-- Local heap and utility functions
-----------------------------------------------------------------------

local new, del
do
	local cache = setmetatable({},{__mode="k"})
	function new(...)
		local t = next(cache)
		if t then
			cache[t] = nil
			for i = 1, select("#", ...) do
				table.insert(t, (select(i, ...)))
			end
			return t
		else
			return {...}
		end
	end
	function del(t)
		if type(t) == "table" then
			for k, v in pairs(t) do
				if type(v) == "table" then
					v = del(v)
				end
				t[k] = nil
			end
			cache[t] = true
		end
		return nil
	end
end

local hexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = "|cff" .. string.format("%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end

local coloredNames = setmetatable({}, {__index =
	function(self, key)
		if type(key) == "nil" then return nil end
		local class = select(2, UnitClass(key))
		if class then
			self[key] = hexColors[class]  .. key .. "|r"
		else
			self[key] = "|cffcccccc<"..key..">|r"
		end
		return self[key]
	end
})

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["You have to be Raid Leader or Assistant to do that."] = true,
	["Requested a status update."] = true,
	["Request status"] = true,
	["Request a status update"] = true,
	["Textures"] = true,
	["Set all statusbar textures."] = true,
	["Minimap icon"] = true,
	["Toggle the minimap icon."] = true,

	-- standard draggable window texts
	["Toggle"] = true,
	["Show or hide the window"] = true,
	["Lock"] = true,
	["Make the window unclickable"] = true,
	["Size"] = true,
	["Change the size of the window."] = true,
	["Transparency"] = true,
	["Change the transparency of the window."] = true,
} end)

L:RegisterTranslations("deDE", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "Du mußt Schlachtzugsleiter oder -assistent sein, um das zu machen.",
	["Requested a status update."] = "Status-Aktualisierung wurde angefordert.",
	["Request status"] = "Status anfordern",
	["Request a status update"] = "Eine Status-Aktualisierung anfordern.",
	["Textures"] = "Texturen",
	["Set all statusbar textures."] = "Texturen der StatusBars festlegen.",

	-- standard draggable window texts
	["Toggle"] = "Aktivieren",
	["Show or hide the window"] = "Fenster ein-/ausblenden.",
	["Lock"] = "Sperren",
	["Make the window unclickable"] = "Macht das Fenster unklickbar.",
	["Size"] = "Größe",
	["Change the size of the window."] = "Ändert die Größe des Fensters.",
	["Transparency"] = "Transparenz",
	["Change the transparency of the window."] = "Ändert die Transparenz des Fensters.",
} end)

L:RegisterTranslations("koKR", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "공격대장이거나 승급된 사람만 사용 가능합니다.",
	["Requested a status update."] = "상태 갱신을 요청합니다.",
	["Request status"] = "상태 요청",
	["Request a status update"] = "상태 갱신을 요청합니다.",
	["Textures"] = "무늬",
	["Set all statusbar textures."] = "모든 상태바의 무늬를 설정합니다.",
	["Minimap icon"] = "미니맵 아이콘",
	["Toggle the minimap icon."] = "미니맵 아이콘 토글",

	-- standard draggable window texts
	["Toggle"] = "사용",
	["Show or hide the window"] = "창을 표시하거나 숨김니다.",
	["Lock"] = "고정",
	["Make the window unclickable"] = "창을 고정시키거나 이동시킵니다.",
	["Size"] = "크기",
	["Change the size of the window."] = "창의 크기를 변경합니다.",
	["Transparency"] = "투명도",
	["Change the transparency of the window."] = "창의 투명도를 변경합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "只有团队领袖/队长才可以这样做。",
	["Requested a status update."] = "请求更新状态。",
	["Request status"] = "获取状态",
	["Request a status update"] = "获取状态更新",
	["Textures"] = "材质",
	["Set all statusbar textures."] = "设置所有状态条的材质。",
	["Minimap icon"] = "小地图图标",
	["Toggle the minimap icon."] = "打开/关闭小地图图标。",

	-- standard draggable window texts
	["Toggle"] = "激活",
	["Show or hide the window"] = "显示或隐藏窗口。",
	["Lock"] = "锁定",
	["Make the window unclickable"] = "锁定窗口。",
	["Size"] = "尺寸",
	["Change the size of the window."] = "改变窗口尺寸。",
	["Transparency"] = "透明度",
	["Change the transparency of the window."] = "改变窗口透明度。",
} end)

L:RegisterTranslations("zhTW", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "只有領隊/隊長才可以",
	["Requested a status update."] = "請求更新狀態",
	["Request status"] = "請求狀態",
	["Request a status update"] = "請求狀態更新",
	["Textures"] = "材質",
	["Set all statusbar textures."] = "設置所有狀態條的材質",

	-- standard draggable window texts
	["Toggle"] = "顯示",
	["Show or hide the window"] = "顯示或是隱藏視窗",
	["Lock"] = "鎖定",
	["Make the window unclickable"] = "鎖定視窗",
	["Size"] = "大小",
	["Change the size of the window."] = "改變視窗大小",
	["Transparency"] = "透明度",
	["Change the transparency of the window."] = "改變視窗透明度",
} end)

L:RegisterTranslations("frFR", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "Vous devez être le chef du raid ou un de ses assistants pour faire cela.",
	["Requested a status update."] = "Mise à jour du statut demandée.",
	["Request status"] = "Demander le statut",
	["Request a status update"] = "Demande une mise à jour du statut.",
	["Textures"] = "Textures",
	["Set all statusbar textures."] = "Définit la texture de toutes les barres de statut.",

	-- standard draggable window texts
	["Toggle"] = "Afficher",
	["Show or hide the window"] = "Affiche ou masque la fenêtre.",
	["Lock"] = "Verrouiller",
	["Make the window unclickable"] = "Rend impossible toute interaction avec la fenêtre.",
	["Size"] = "Échelle",
	["Change the size of the window."] = "Modifie l'échelle de la fenêtre.",
	["Transparency"] = "Transparence",
	["Change the transparency of the window."] = "Modifie la transparence de la fenêtre.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["You have to be Raid Leader or Assistant to do that."] = "Вы должны быть рейд лидером или помощником чтобы сделать это.",
	["Requested a status update."] = "Требуется обновление данных.",
	["Request status"] = "Запрос данных",
	["Request a status update"] = "Заросить обновление данных.",
	["Textures"] = "Текстуры",
	["Set all statusbar textures."] = "Настройка текстур панели данных.",

	-- standard draggable window texts
	["Toggle"] = "Показать",
	["Show or hide the window"] = "Показать или Скрыть окно.",
	["Lock"] = "Закрепить",
	["Make the window unclickable"] = "Делает окно неподвижным.",
	["Size"] = "Размер",
	["Change the size of the window."] = "Настраивает размер окна.",
	["Transparency"] = "Прозрачность",
	["Change the transparency of the window."] = "Настраивает прозрачность окна.",
} end)

---------------------------------
--   Shorthand/Check Handler   --
---------------------------------

local CTRACL10 = "CTRACompatLayer-1.0"
local CTRACL10_MINOR = 1

if not AceLibrary:HasInstance(CTRACL10) then

local AceOO = AceLibrary("AceOO-2.0")
local rtm = AceOO.Mixin {
	"RegisterCheck",
	"UnregisterCheck",
	"RegisterShorthand",
	"UnregisterShorthand",
}

-- Event handler for the CHAT_MSG_ADDON event
-- Parses the info sent over the addon channel
-- Checks for the keywrods and triggers the appropriate events

local select = select

-- Check if the first part of the string split from " " is a check, and trigger
-- an event if it is.
local function check(author, cmd, ...)
	local c = select(1, ...)
	if c and rtm.checks[c] then
		rtm:TriggerEvent(rtm.checks[c][1], cmd, author)
	end
end

-- Iterate all the strings split from #
local function splitMessage(author, ...)
	for i = 1, select("#", ...) do
		local x = select(i, ...)
		check(author, x, strsplit(" ", x))
	end
end

function rtm:CHAT_MSG_ADDON(prefix, msg, type, author)
	if prefix ~= "CTRA" and prefix ~= "oRA" then return end
	if type ~= "RAID" then return end
	splitMessage(author, strsplit("#", msg))
end

---------------------------
--    Channel checks     --
---------------------------

-- Registers a keyword check
-- Args: check - keyword to check on
--       event - event to fire when the keyword is received
function rtm:RegisterCheck(check, event)
	rtm:argCheck(check, 2, "string")
	rtm:argCheck(event, 3, "string")
	if rtm.checks[check] and rtm.checks[check][1] ~= event then
		rtm:error("The check %q has already been registered to the event %q - can't register it to the event %q as well.", check, rtm.checks[check][1], event)
		return
	end
	if rtm.checks[check] then
		table.insert(rtm.checks[check], self)
	else
		rtm.checks[check] = new(event, self)
	end
	self:RegisterEvent(event)
end

-- Unregisters a keyword check
-- Args: check - keyword to remove from the checklist
function rtm:UnregisterCheck(check)
	rtm:argCheck(check, 2, "string")
	if rtm.checks[check] then
		for i, v in ipairs(rtm.checks[check]) do
			if i > 1 and v == self then
				table.remove(rtm.checks[check], i)
			end
		end
		if #rtm.checks[check] == 1 then
			rtm.checks[check] = del(rtm.checks[check])
		end
	end
end

---------------------------------
--      Short Hand System      --
---------------------------------

-- Registers a CTRA shorthand
-- Args:
-- shorthand - shorthand you wish to register: rajoin => /rajoin
-- func      - function to execute
function rtm:RegisterShorthand(shorthand, func)
	rtm:argCheck(shorthand, 2, "string")
	rtm:argCheck(func, 3, "string")

	if rtm.shorthands[shorthand] then
		rtm:error("The shorthand %q is already registered.", shorthand)
		return
	end

	rtm.shorthands[shorthand] = self
	local name = "ORA_SHORTHAND_" .. shorthand:upper()
	SlashCmdList[name] = function(input)
		self[func](self, input)
	end
	setglobal("SLASH_"..name.."1", "/"..shorthand:lower())
end

-- Unregisters a CTRA shorthand
-- Args: shorthand - the shorthand you wish to unregister
-- Returns true when succesful
function rtm:UnregisterShorthand(shorthand)
	rtm:argCheck(shorthand, 2, "string")
	if rtm.shorthands[shorthand] and rtm.shorthands[shorthand] == self then
		local u = shorthand:upper()
		local name = "ORA_SHORTHAND_" .. u
		SlashCmdList[name] = nil
		hash_SlashCmdList["/" .. u] = nil
		setglobal("SLASH_"..name.."1", nil)
		rtm.shorthands[shorthand] = nil
	end
end

function rtm:OnEmbedDisable(target)
	for check in pairs(rtm.checks) do
		target:UnregisterCheck(check)
	end
	for shorthand, mod in pairs(rtm.shorthands) do
		if mod == target then
			target:UnregisterShorthand(shorthand)
		end
	end
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		instance:embed(self)
		self:RegisterEvent("CHAT_MSG_ADDON")
	end
end

local function activate(self, oldLib, oldDeactivate)
	rtm = self
	if oldLib then
		self.checks = oldLib.checks
		self.shorthands = oldLib.shorthands
	end
	if not self.checks then self.checks = {} end
	if not self.shorthands then self.shorthands = {} end
	if oldLib and oldDeactivate then
		oldDeactivate(oldLib)
	end
end

AceLibrary:Register(rtm, CTRACL10, CTRACL10_MINOR, activate, nil, external)
end

---------------------------------
--      Addon Declaration      --
---------------------------------

oRA = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceModuleCore-2.0", "AceConsole-2.0", "AceDB-2.0", CTRACL10)
local oRA = oRA

oRA:SetModuleMixins("AceEvent-2.0", CTRACL10)
oRA.defaults = {
	bartexture = "BantoBar",
	minimap = {
		hide = false,
	},
}
oRA.version = tonumber(string.sub("$Revision: 643 $", 12, -3))

oRA.consoleOptions = {
	type = "group",
	handler = oRA,
	args = {
		textures = {
			type = "text",
			name = L["Textures"],
			desc = L["Set all statusbar textures."],
			get = function() return oRA.db.profile.bartexture end,
			set = "SetBarTexture",
			disabled = "~IsActive",
			validate = media:List("statusbar"),
			order = 50,
		},
		spacer = {
			type = "header",
			name = " ",
			order = 100,
		},
		status = {
			name = L["Request status"], type = "execute",
			desc = L["Request a status update"],
			func = "RequestStatus",
			order = 1000,
			disabled = "~IsActive",
		},
		minimap = {
			type = "toggle",
			name = L["Minimap icon"],
			desc = L["Toggle the minimap icon."],
			get = function() return not oRA.db.profile.minimap.hide end,
			set = function(v)
				local hide = not v
				oRA.db.profile.minimap.hide = hide
				if hide then
					icon:Hide("oRA2")
				else
					icon:Show("oRA2")
				end
			end,
			hidden = function() return not icon or not icon:IsRegistered("oRA2") end,
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

local frame = nil -- Version/Zone/etc frame.

function oRA:OnInitialize()
	media:Register("statusbar", "Otravi", "Interface\\AddOns\\oRA2\\Textures\\otravi")
	media:Register("statusbar", "Smooth", "Interface\\AddOns\\oRA2\\Textures\\smooth")
	media:Register("statusbar", "Smudge", "Interface\\AddOns\\oRA2\\Textures\\smudge")
	media:Register("statusbar", "Charcoal", "Interface\\AddOns\\oRA2\\textures\\charcoal")
	media:Register("statusbar", "BantoBar", "Interface\\AddOns\\oRA2\\textures\\bantobar")
	media:Register("statusbar", "Perl", "Interface\\AddOns\\oRA2\\textures\\perl")
	media:Register("statusbar", "Striped", "Interface\\AddOns\\oRA2\\textures\\striped")

	setglobal("BINDING_HEADER_oRA2MT", "oRA2 Main Tanks")
	setglobal("BINDING_HEADER_oRA2PT", "oRA2 Player Tanks")

	self:RegisterDB("oRADB")
	self:RegisterDefaults("profile", self.defaults)
	self:RegisterChatCommand("/ora", "/oRA", self.consoleOptions, "ORA")

	-- try and enable ourselves
	self:ToggleActive(true)
end

function oRA:OnEnable(first)
	if not first or GetNumRaidMembers() > 0 then
		self:RegisterCheck("SR", "oRA_SendVersion")

		for name, module in self:IterateModules() do
			self:ToggleModuleActive(module, true)
		end

		if not first and GetNumRaidMembers() == 0 then
			-- we're enabling by a forced click on the plugin
			-- fake the promotion event
			self:TriggerEvent("oRA_PlayerPromoted")
		end

		self:RegisterEvent("CHAT_MSG_SYSTEM")
		self:RegisterEvent("oRA_JoinedRaid")
		self:RegisterEvent("oRA_ModulePackLoaded")
		self:TriggerEvent("oRA_CoreEnabled")
	else
		self:ToggleActive(false)
	end
end

function oRA:OnDisable()
	for name, module in self:IterateModules() do
		if not module.shouldEnable or (module.shouldEnable ~= nil and type(module.shouldEnable) == "function" and not module:shouldEnable()) then
			self:ToggleModuleActive(module, false)
		end
	end

	self:CloseWindow()
	self:TriggerEvent("oRA_CoreDisabled")
end

--------------------------------
--      Module Prototype      --
--------------------------------

function oRA.modulePrototype:OnInitialize()
	-- Unconditionally register, this shouldn't happen from any other place
	-- anyway.
	oRA:RegisterModule(self.name, self)
end

function oRA.modulePrototype:new(...) return new(...) end
function oRA.modulePrototype:del(t) return del(t) end

function oRA.modulePrototype:Print(...)
	oRA:Print("(%s) %s", self.name, ...)
end

oRA.modulePrototype.coloredNames = coloredNames

-------------------------------
--      Module Handling      --
-------------------------------

local registeredModules = {}
function oRA:RegisterModule(name, module)
	if registeredModules[name] then
		error(string.format("%q is already registered.", name))
		return
	end
	registeredModules[name] = true

	if module.defaults then
		self:RegisterDefaults(name, "profile", module.defaults)
		module.db = self:AcquireDBNamespace(name)
	end

	if module.consoleOptions then
		local m = module.consoleCmd or name
		-- if the consoleoption already exists we merge in the data otherwise we create a new option
		if self.consoleOptions.args[m] then
			for k,v in pairs(module.consoleOptions.args) do
				self.consoleOptions.args[m].args[k] = v
				if module.consoleOptions.handler then
					self.consoleOptions.args[m].args[k].handler = module.consoleOptions.handler
				end
			end
		else
			if module.consoleOptions.type == "group" then
				module.consoleOptions.order = 50
			else
				module.consoleOptions.order = 150
			end
			self.consoleOptions.args[m] = module.consoleOptions
		end
	end

	if type(module.OnRegister) == "function" then
		module:OnRegister()
	end
end

-------------------------------
--      Core                 --
-------------------------------

do
	local unitJoinedRaid = '^' .. ERR_RAID_MEMBER_ADDED_S:gsub("%%s", "(%%S+)") .. '$'
	function oRA:CHAT_MSG_SYSTEM(msg)
		if not UnitInRaid("player") then return end
		local name = select(3, msg:find(unitJoinedRaid))
		if not name then return end
		if rawget(coloredNames, name) then
			coloredNames[name] = nil
		end
	end
end

function oRA:oRA_ModulePackLoaded()
	if not UnitInRaid("player") then return end
	for name, module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end
end

-- Distributes your version to the raid
local ctraVersionDistString = "V " .. CTRAversion
local function distributeVersion()
	oRA:SendMessage(ctraVersionDistString)
	oRA:SendMessage("oRAV " .. oRA.version, true)
end

function oRA:oRA_JoinedRaid()
	distributeVersion()
	for k in pairs(coloredNames) do
		coloredNames[k] = nil
	end
end

function oRA:oRA_SendVersion()
	self:ScheduleEvent("oRASendVersion", distributeVersion, 5)
end

-- Command handler
-- Sends a status request.

function oRA:RequestStatus()
	self:Print(L["Requested a status update."])
	self:SendMessage("SR")
end

function oRA:SetBarTexture(texture)
	self.db.profile.bartexture = texture
	self:TriggerEvent("oRA_BarTexture", texture)
end

-------------------------------
--     Raid Roster Utils     --
-------------------------------

-- Checks if the player is raid leader or raid officer
-- Returns true when the player is raid leader or raid officer
function oRA:IsPromoted()
	return IsRaidLeader() or IsRaidOfficer() and true or nil
end

---------------------------
--       Messaging       --
---------------------------

-- Sends a message
-- Args: msg - message to send
-- returns true when succesful
function oRA:SendMessage(msg, ora)
	if ora then
		SendAddonMessage("oRA", msg, "RAID")
	else
		SendAddonMessage("CTRA", msg, "RAID")
	end
	return true
end

---------------------------
--   Scroll Window GUI   --
---------------------------

local sortIndex
local function sortAsc(a, b) return b[sortIndex] > a[sortIndex] end
local function sortDesc(a, b) return a[sortIndex] > b[sortIndex] end

local sframe
local scrollentries
local scrollheaders
local scrollcontents

function oRA:SortColumn(nr)
	scrollheaders[nr].sortDir = not scrollheaders[nr].sortDir
	sortIndex = nr
	if scrollheaders[nr].sortDir then
		table.sort(scrollcontents, sortAsc)
	else
		table.sort(scrollcontents, sortDesc)
	end
	self:UpdateWindow()
end

function oRA:CreateReportFrame()
	if frame then return end
	local font = GameFontNormal:GetFont()
	local f = CreateFrame("Frame", "oRAReportFrame", UIParent)
	frame = f

	f:Hide()
	f:SetWidth(325)
	f:SetHeight(350)
	f:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\oRA2\\Textures\\otravi-semi-full-border", edgeSize = 32,
		insets = {left = 1, right = 1, top = 20, bottom = 1},
	})
	f:SetBackdropColor(24/255, 24/255, 24/255)
	f:SetBackdropBorderColor(1, 0, 0)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function() this:StartMoving() end)
	f:SetScript("OnDragStop", function() this:StopMovingOrSizing() end)
	f:ClearAllPoints()
	f:SetPoint("CENTER", WorldFrame, "CENTER", 0, 0)

	-- header
	f.header = f:CreateFontString(nil,"OVERLAY")
	f.header:SetFont(font, 12)
	f.header:SetWidth(300)
	f.header:SetText("")
	f.header:SetShadowOffset(.8, -.8)
	f.header:SetShadowColor(0, 0, 0, 1)
	f.header:ClearAllPoints()
	f.header:SetPoint("TOP", f, "TOP", 0, -14)

	-- close button
	f.closebutton = CreateFrame("Button", nil, f)
	f.closebutton:SetWidth(16)
	f.closebutton:SetHeight(16)
	f.closebutton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -7, -13)
	f.closebutton:SetScript("OnClick", function() f:Hide() end)
	f.close = f:CreateTexture(nil, "ARTWORK")
	f.close:SetPoint("CENTER", f.closebutton, "CENTER")
	f.close:SetTexture("Interface\\AddOns\\oRA2\\Textures\\otravi-close")
	f.close:SetWidth(16)
	f.close:SetHeight(16)
	f.close:SetBlendMode("ADD")

	-- refresh button
	f.refreshbutton = CreateFrame("Button", nil, f)
	f.refreshbutton:SetWidth(16)
	f.refreshbutton:SetHeight(16)
	f.refreshbutton:SetPoint("TOPRIGHT", f, "TOPRIGHT", -24, -13)
	f.refreshbutton:SetScript("OnClick", nil)
	f.refresh = f:CreateTexture(nil, "ARTWORK")
	f.refresh:SetPoint("CENTER", f.refreshbutton, "CENTER")
	f.refresh:SetTexture("Interface\\AddOns\\oRA2\\Textures\\otravi-recycle")
	f.refresh:SetWidth(16)
	f.refresh:SetHeight(16)
	f.refresh:SetBlendMode("ADD")

	-- Scroll Entries
	scrollentries = {}
	scrollentries[1] =  self:CreateScrollEntryFrame()
	scrollentries[1]:SetPoint("TOPLEFT", f, "TOPLEFT", 10, -55)
	for i = 2, 18 do
		scrollentries[i] = self:CreateScrollEntryFrame()
		scrollentries[i]:SetPoint("TOPLEFT", scrollentries[i - 1], "BOTTOMLEFT")
	end

	-- Scrolling body
	sframe = CreateFrame("ScrollFrame", "oRAScrollFrame", f, "FauxScrollFrameTemplate")
	sframe:SetParent(f)
	sframe:SetWidth(295)
	sframe:SetHeight(288) -- 18 entries a 16 px
	sframe:SetPoint("TOPLEFT", f, "TOPLEFT", 5, -55)

	local function updateScroll()
		self:UpdateWindow()
	end

	sframe:SetScript("OnVerticalScroll", function(self, offset)
		FauxScrollFrame_OnVerticalScroll(self, offset, 16, updateScroll)
	end)
end

function oRA:CreateScrollEntryFrame()
	local font = GameFontNormal:GetFont()
	local f = CreateFrame("Button", nil, frame)
	f:SetWidth(240)
	f:SetHeight(16)

	f.text = f:CreateFontString(nil,"OVERLAY")
	f.text:SetFont(font, 12)
	f.text:SetJustifyH("LEFT")
	f.text:SetTextColor(1, 1, 1, 1)
	f.text:ClearAllPoints()
	f.text:SetAllPoints(f)

	return f
end

function oRA:SetScrollEntryCols(cols)
	local font = GameFontNormal:GetFont()
	for i = 1, 18 do
		local entry = scrollentries[i]
		if not entry.cols then
			entry.cols = {}
		end
		for j = 1, cols do
			if not entry.cols[j] then
				local f = entry:CreateFontString(nil, "OVERLAY")
				entry.cols[j] = f
				f:SetFont(font, 12)
				f:SetJustifyH("LEFT")
				f:SetTextColor(1, 1, 1, 1)
				f:ClearAllPoints()
				f:SetWidth(scrollheaders[j]:GetWidth())
				f:SetHeight(16)
				if j == 1 then
					f:SetPoint("LEFT", scrollentries[i], "LEFT")
				else
					f:SetPoint("LEFT", entry.cols[j-1], "RIGHT")
				end
			end
		end
	end
end

function oRA:CreateScrollHeader(nr)
	local f = CreateFrame("Button", nil, frame)
	local font = GameFontNormal:GetFont()

	if nr == 1 then
		f:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -35)
	else
		f:SetPoint("LEFT", scrollheaders[nr - 1], "RIGHT")
	end

	f:SetHeight(16)
	f:SetScript("OnClick", function() self:SortColumn(nr) end)

	f.text = f:CreateFontString(nil,"OVERLAY")
	f.text:SetFont(font, 12)
	f.text:SetJustifyH("LEFT")
	f.text:SetTextColor(1, 1, 1, 1)
	f.text:ClearAllPoints()
	f.text:SetAllPoints(f)

	f.highlight = f:CreateTexture(nil, "BORDER")
	f.highlight:ClearAllPoints()
	f.highlight:SetAllPoints(f)
	f.highlight:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
	f.highlight:SetBlendMode("ADD")
	f.highlight:SetGradientAlpha("VERTICAL", .1, .08, 0, 0, .2, .16, 0, 1)

	f:SetHighlightTexture(f.highlight)

	return f
end

function oRA:ClearScrollHeaders()
	if not scrollheaders then return end
	for k, header in ipairs(scrollheaders) do
		header:Hide()
	end
end

function oRA:SetScrollHeader(nr, name, width)
	if not scrollheaders then
		scrollheaders = {}
	end

	if not scrollheaders[nr] then
		scrollheaders[nr] = self:CreateScrollHeader(nr)
	end

	scrollheaders[nr]:SetWidth(width)
	scrollheaders[nr].text:SetText(name)
	scrollheaders[nr]:Show()
end

function oRA:OpenWindow(windowname, contents, refreshfunc, ...)
	self:CreateReportFrame()
	self:ClearScrollHeaders()

	-- used to figure out if we're allowed to add data to the currently shown window
	frame.windowname = windowname
	scrollcontents = contents

	local cols = 0
	for i = 1, select("#", ...), 2 do
		local name, width = select(i, ...)
		if name and width then
			cols = cols + 1
			self:SetScrollHeader(cols, name, width)
		end
	end
	-- used in updatescrollbar
	if not frame.cols or frame.cols < cols then
		-- adjust the columns in the scroll entries
		self:SetScrollEntryCols(cols)
	end
	frame.cols = cols

	frame.header:SetText(windowname)

	frame.refreshbutton:SetScript("OnClick", refreshfunc)

	-- Show the Frame before updating the scrollbar to prevent evil blizzard bugs from hell
	frame:Show()
	self:UpdateWindow()
end

function oRA:CloseWindow()
	self:ClearScrollHeaders()
	if frame then
		frame:Hide()
	end
end

function oRA:UpdateWindow()
	local entries = #scrollcontents
	FauxScrollFrame_Update(sframe, entries, 18, 16)
	for i = 1, 18 do
		local j = i + FauxScrollFrame_GetOffset(sframe)
		local entry = scrollentries[i]
		if j <= entries then
			for k, col in ipairs(entry.cols) do
				col:SetWidth(scrollheaders[k]:GetWidth())
				col:SetText(scrollcontents[j][k])
			end
			entry:Show()
		else
			entry:Hide()
		end
	end
end

-------------------------------------------
-- Standard draggable window with a title
-------------------------------------------

local windowAceOptions ={
	toggle = {
		type = "toggle", name = L["Toggle"],
		desc = L["Show or hide the window"],
		get = "windowGetToggled",
		set = "windowSetToggled",
	},
	lock = {
		type = "toggle", name = L["Lock"],
		desc = L["Make the window unclickable"],
		get = "windowGetLocked",
		set = "windowSetLocked",
	},
	size = {
		type = "range", name = L["Size"],
		desc = L["Change the size of the window."],
		min = 0.5, max=2, step=0.02, bigStep=0.1, isPercent=true,
		get = "windowGetScale",
		set = "windowSetScale",
	},
	alpha = {
		type = "range", name = L["Transparency"],
		desc = L["Change the transparency of the window."],
		min = 0.0, max=0.8, step=0.05, bigStep=0.1, isPercent=true,
		get = "windowGetTransparency",
		set = "windowSetTransparency",
	}
}

local function windowOnMouseUp(this, button)
	if arg1 == "RightButton" then
		dew:Open(this,
			"children", this.handler.windowFeedDewDrop,
			"cursorX", true,
			"cursorY", true
		)
	end
end

-- Anything present in this table will be copied into aceoptiontable.handler
local handlers = {}

function handlers:windowGetToggled()
	return not self.windowConfig.hidden
end

function handlers:windowSetToggled(v)
	self.windowConfig.hidden = not v
	if v and not self.frame then
		self:windowCreateFrame()
	end
	if self.frame then
		self.frame[v and "Show" or "Hide"](self.frame)
		if self.OnToggleFrame then
			self:OnToggleFrame(v)
		end
	end
end

function handlers:windowCreateFrame()
	assert(not self.frame)

	self.frame = CreateFrame("Frame", self.windowName , UIParent)
	self.frame.handler = self
	self.frame:SetScript("OnMouseUp", windowOnMouseUp)

	self.frame.title = self.frame:CreateFontString(nil, "ARTWORK")
	self.frame.title:SetFontObject(GameFontNormalSmall)
	self.frame.title:SetText(self.windowTitle)
	self.frame.title:SetJustifyH("CENTER")
	self.frame.title:SetPoint("TOP", self.frame, "TOP", 0, -5)
	self.frame.title:Show()

	win:RegisterConfig(self.frame, self.windowConfig)
	win:RestorePosition(self.frame)  -- restores scale also
	win:MakeDraggable(self.frame)
	win:EnableMouseOnAlt(self.frame)
	self.frame:SetAlpha(self:windowGetAlpha())
	self:windowSetLocked(self:windowGetLocked())

	self:OnCreateFrame()
end

function handlers:windowGetLocked()
	return self.windowConfig.lock
end

function handlers:windowSetLocked(v)
	self.windowConfig.lock = v
	if self.frame then
		if v then
			self.frame:RegisterForDrag(nil)
			self.frame.title:Hide()
		else
			self.frame:RegisterForDrag("LeftButton")
			self.frame.title:Show()
		end
	end
end

function handlers:windowGetScale()
	return self.windowConfig.scale
end

function handlers:windowSetScale(scale)
	if self.frame then
		win:SetScale(self.frame, scale)
		if self.OnSetScale then
			self:OnSetScale(scale)
		end
	else
		self.windowConfig.scale = scale
	end
end

function handlers:windowGetAlpha()
	return self.windowConfig.alpha or 1
end

function handlers:windowGetTransparency()
	return 1 - (self.windowConfig.alpha or 1)
end

function handlers:windowSetTransparency(v)
	self.windowConfig.alpha = 1 - v
	if self.frame then
		self.frame:SetAlpha(1 - v)
	end
end

function oRA:MakeDraggableWindow(titleText, frameName, options, config)
	assert(options.args and options.handler)

	if not config.x then
		config.x = (config.posx or 0) / UIParent:GetScale()
		config.y = (config.posy or 0) / UIParent:GetScale()
	end

	for k,v in pairs(windowAceOptions) do
		options.args[k] = v
	end

	options.handler.windowConfig = config
	options.handler.windowTitle = titleText
	options.handler.windowName = frameName

	for k,v in pairs(handlers) do
		options.handler[k] = v
	end

	-- dewdrop feed function needs to be defined here to have access to the "options" upvalue
	options.handler.windowFeedDewDrop = function ()
		dew:FeedAceOptionsTable(options)
	end

	options.handler:windowSetToggled(options.handler:windowGetToggled())
end

