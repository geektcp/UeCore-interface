assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 648 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALItem")

-- DO NOT translate these, use the locale tables below
local reagents = {
	PRIEST = "DevoutCandle",
	MAGE = "ArcanePowder",
	DRUID = "WildSpineleaf",
	WARLOCK = "SoulShard",
	SHAMAN = "Ankh",
	PALADIN = "SymbolofDivinity",
	DEATHKNIGHT = "CorpseDust",
}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Options for item checks."] = true,
	["Checks Disabled"] = true,
	["Items"] = true,
	["Reagents"] = true,
	["Close"] = true,
	["Refresh"] = true,
	["Name"] = true,
	["Item"] = true,
	["Amount"] = true,
	["Nr"] = true,
	["Perform item check"] = true,
	["Check the raid for an item."] = true,
	["<item>"] = true,
	["Perform reagent check"] = true,
	["Check the raid for reagents."] = true,
	["Leader/Item"] = true,
	["Use item-ID if available"] = true,
	["Prefer using item-ID when checking for items."] = true,

	DevoutCandle = "Devout Candle",
	ArcanePowder = "Arcane Powder",
	WildSpineleaf = "Wild Spineleaf",
	Ankh = "Ankh",
	SymbolofDivinity = "Symbol of Divinity",
	SoulShard = "Soul Shard",
	CorpseDust = "Corpse Dust",
} end)

L:RegisterTranslations("koKR", function() return {
	["Options for item checks."] = "아이템 확인에 대한 설정입니다.",
	["DevoutCandle"] = "기원의 양초",
	["ArcanePowder"] = "불가사의한 가루",
	["WildSpineleaf"] = "야생 가시돌기",
	["Ankh"] = "십자가",
	["SymbolofDivinity"] = "신앙의 징표",
	["SoulShard"] = "영혼의 조각",
	["Checks Disabled"] = "확인 사용안함",
	["Items"] = "아이템",
	["Reagents"] = "재료",
	["Close"] = "닫기",
	["Refresh"] = "새로고침",
	["Name"] = "이름",
	["Item"] = "아이템",
	["Amount"] = "수량",
	["Nr"] = "갯수",
	["Perform item check"] = "아이템 확인 실시",
	["Check the raid for an item."] = "공격대원의 아이템을 확인합니다.",
	["<item>"] = "<아이템>",
	["Perform reagent check"] = "재료 확인 실시",
	["Check the raid for reagents."] = "공격대원의 재료를 확인합니다.",
	["Leader/Item"] = "공격대장/아이템",
	["Use item-ID if available"] = "아이템-ID가 이용 가능시 사용",
	["Prefer using item-ID when checking for items."] = "아아템 확인할 경우, 아이템-ID를 우선적으로 사용합니다.",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Options for item checks."] = "物品检查选项。",
	["Checks Disabled"] = "禁止查询",
	["Items"] = "物品",
	["Reagents"] = "施法材料",
	["Close"] = "关闭",
	["Refresh"] = "刷新",
	["Name"] = "姓名",
	["Item"] = "物品",
	["Amount"] = "数量",
	["Nr"] = "数量",
	["Perform item check"] = "进行物品检查",
	["Check the raid for an item."] = "对团队进行物品检查。",
	["<item>"] = "<物品>",
	["Perform reagent check"] = "进行施法材料检查",
	["Check the raid for reagents."] = "对团队进行施法材料检查。",
	["Leader/Item"] = "团长/物品",
	["Use item-ID if available"] = "使用物品ID (如果可用)",
	["Prefer using item-ID when checking for items."] = "使用物品ID进行物品检查",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Options for item checks."] = "物品檢查選項",
	["DevoutCandle"] = "神聖蠟燭",
	["ArcanePowder"] = "魔粉",
	["WildSpineleaf"] = "野生羽蔓",
	["Ankh"] = "十字章",
	["SymbolofDivinity"] = "神聖符印",
	["SoulShard"] = "靈魂碎片",
	["Checks Disabled"] = "檢查已停用",
	["Items"] = "物品",
	["Reagents"] = "施法材料",
	["Close"] = "關閉",
	["Refresh"] = "更新",
	["Name"] = "姓名",
	["Item"] = "物品",
	["Amount"] = "數量",
	["Nr"] = "數量",
	["Perform item check"] = "進行物品檢查",
	["Check the raid for an item."] = "對團隊進行物品檢查",
	["<item>"] = "<物品>",
	["Perform reagent check"] = "進行施法材料檢查",
	["Check the raid for reagents."] = "對團隊進行施法材料檢查",
	["Leader/Item"] = "領隊/物品",
	["Use item-ID if available"] = "使用物品ID檢查",
	["Prefer using item-ID when checking for items."] = "進行物品ID檢查",
} end)

L:RegisterTranslations("deDE", function() return {
	["Options for item checks."] = "Optionen für Gegenstands-Checks.",
	["Checks Disabled"] = "Deaktiviere Überprüfungen",
	["Items"] = "Gegenstände",
	["Reagents"] = "Reagenzien",
	["Close"] = "Schließen",
	["Refresh"] = "Erneuern",
	["Name"] = "Name",
	["Item"] = "Gegenstand",
	["Amount"] = "Anzahl",
	["Nr"] = "Nr",
	["Perform item check"] = "Starte einen Gegenstands-Check",
	["Check the raid for an item."] = "Überprüft den Schlachtzug auf einen Gegenstand.",
	["<item>"] = "<item>",
	["Perform reagent check"] = "Starte einen Reagenzien-Check",
	["Check the raid for reagents."] = "Überprüft den Schlachtzug auf Reagenzien.",
	["Leader/Item"] = "Anführer/Gegenstand",
	["Use item-ID if available"] = "Nutze Item-ID",
	["Prefer using item-ID when checking for items."] = "Item-ID zur Abfrage benutzen falls verfügbar.",

	DevoutCandle = "Hochheilige Kerze",
	ArcanePowder = "Arkanes Pulver",
	WildSpineleaf = "Wilder Dornwurz",
	Ankh = "Ankh",
	SymbolofDivinity = "Symbol der Könige",
	SoulShard = "Seelensplitter",
} end)

L:RegisterTranslations("frFR", function() return {
	["Options for item checks."] = "Options concernant les vérifications des objets.",
	["Checks Disabled"] = "Vérifications désactivées.",
	["Items"] = "Objets",
	["Reagents"] = "Composants",
	["Close"] = "Fermer",
	["Refresh"] = "Rafraîchir",
	["Name"] = "Nom",
	["Item"] = "Objet",
	["Amount"] = "Quantité",
	["Nr"] = "N°",
	["Perform item check"] = "Vérifier un objet",
	["Check the raid for an item."] = "Vérifie la disponibilité d'un objet dans le raid.",
	["<item>"] = "<objet>",
	["Perform reagent check"] = "Vérifier les composants",
	["Check the raid for reagents."] = "Vérifie les composants du raid.",
	["Leader/Item"] = "Chef/Objet",
	["Use item-ID if available"] = "Utiliser les ItemIDs si disponibles",
	["Prefer using item-ID when checking for items."] = "Donne la préférence à l'utilisation des ItemIDs lors de la vérification des objets.",

	DevoutCandle = "Bougie sacrée",
	ArcanePowder = "Poudre des arcanes",
	WildSpineleaf = "Ronceterre sauvage",
	Ankh = "Ankh",
	SymbolofDivinity = "Symbole de divinité",
	SoulShard = "Fragment d'âme",
} end)

L:RegisterTranslations("ruRU", function() return {
	["Options for item checks."] = "Опции проверки предметов .",
	["Checks Disabled"] = "Проверка выключена",
	["Items"] = "Предметы",
	["Reagents"] = "Реагенты",
	["Close"] = "Закрыть",
	["Refresh"] = "Обновить",
	["Name"] = "Имя",
	["Item"] = "Предмет",
	["Amount"] = "Количество",
	["Nr"] = "№",
	["Perform item check"] = "Выполнить проверку предметов",
	["Check the raid for an item."] = "Проверка рейда на предметы.",
	["<item>"] = "<предмет>",
	["Perform reagent check"] = "Выпонить проверку реагентов",
	["Check the raid for reagents."] = "Проверка рейда на Реагенты.",
	["Leader/Item"] = "Лидер/Предмет",
	["Use item-ID if available"] = "Использовать ID предмета (если знаете)",
	["Prefer using item-ID when checking for items."] = "Использование ID-предмета при проверки предметов.",

	DevoutCandle = "Свеча благочестия",
	ArcanePowder = "Порошок чар",
	WildSpineleaf = "Дикий шиполист",
	Ankh = "Крест",
	SymbolofDivinity = "Знак божественности",
	SoulShard = "Осколок души",
	CorpseDust = "Прах",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderItem")
mod.defaults = {
	useitemids = false,
}
mod.leader = true
mod.name = L["Leader/Item"]
mod.consoleCmd = "item"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for item checks."],
	name = L["Item"],
	handler = mod,
	args = {
		check = {
			type="text", name = L["Perform item check"],
			desc = L["Check the raid for an item."],
			get = false,
			set = "PerformItemCheck",
			validate = function(v)
				return v:find("(.+)")
			end,
			usage = L["<item>"],
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
		},
		reagent = {
			type="execute", name = L["Perform reagent check"],
			desc = L["Check the raid for reagents."],
			func = "PerformReagentCheck",
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
		},
		useitemids = {
			type="toggle", name = L["Use item-ID if available"],
			desc = L["Prefer using item-ID when checking for items."],
			get = function() return mod.db.profile.useitemids end,
			set = function(v) mod.db.profile.useitemids = v end,
		}
	}
}

------------------------------
--      Initialization      --
------------------------------

local items = nil

function mod:OnEnable()
	self:RegisterCheck("ITM", "oRA_ItemResponse")
	self:RegisterCheck("REA", "oRA_ReagentResponse")

	self:RegisterShorthand("raitem", "PerformItemCheck")
	self:RegisterShorthand("rareg", "PerformReagentCheck")
	self.itemNames = {}
end

function mod:oRA_ItemResponse(msg, author)
	local numitems, itemname, requestby = msg:match("^ITM ([-%d]+) (.+) ([^%s]+)$")
	if numitems and itemname and requestby and UnitIsUnit(requestby, "player") then
		numitems = tonumber(numitems)
		if numitems == -1 then
			self:AddPlayer(author, L["Checks Disabled"], 0)
		else
			-- Support for itemLink translation
			itemname = self.itemNames[tonumber(itemname)] or itemname
			
			self:AddPlayer(author, itemname, numitems)
		end
		oRA:UpdateWindow()
	end
end

function mod:oRA_ReagentResponse(msg, author)
	local numitems, requestby = msg:match("^REA ([^%s]+) ([^%s]+)$")
	if numitems and requestby and UnitIsUnit(requestby, "player") then
		numitems = tonumber(numitems)
		if UnitInRaid(author) then
			local class = select(2, UnitClass(author))
			if reagents[class] then
				if numitems == -1 then
					self:AddPlayer(author, L["Checks Disabled"], 0)
				else
					self:AddPlayer(author, L[reagents[class]], numitems)
				end
				oRA:UpdateWindow()
			end
		end
	end
end

---------------------------
--   Utility Functions   --
---------------------------

function mod:AddPlayer(nick, item, amount)
	table.insert(items, self:new(self.coloredNames[nick], item, amount or 0))
end

--------------------------
--   Command Handlers   --
--------------------------

local function RefreshItemCheck()
	mod:PerformItemCheck(mod.item)
end

function mod:PerformItemCheck(item)
	if not oRA:IsPromoted() then return end
	
	local linkName 	= item:match("%[(.+)%]")
	local linkID	= item:match("item:(%d+)")
	
	if self.db.profile.useitemids and linkID then
		item = linkID
		self.itemNames[tonumber(linkID)] = linkName
	elseif linkName then
		item = linkName 
	end

	items = self:del(items)
	items = self:new()

	self.item = item
	oRA:SendMessage("ITMC " .. item)
	oRA:OpenWindow(L["Items"], items, RefreshItemCheck, L["Name"], 130, L["Item"], 130, L["Nr"], 30)
end

local function RefreshReagentCheck()
	mod:PerformReagentCheck()
end

function mod:PerformReagentCheck()
	if not oRA:IsPromoted() then return end

	items = self:del(items)
	items = self:new()

	oRA:SendMessage("REAC")
	oRA:OpenWindow(L["Reagents"], items, RefreshReagentCheck, L["Name"], 130, L["Item"], 130, L["Nr"], 30)
end

