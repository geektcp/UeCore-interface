--[[
Name: LibRock-1.0
Revision: $Rev: 295 $
Developed by: ckknight (ckknight@gmail.com)
Website: http://www.wowace.com/
Description: Library to allow for library and addon creation and easy table recycling functions.
License: LGPL v2.1
]]

local MAJOR_VERSION = "LibRock-1.0"
local MINOR_VERSION = tonumber(("$Revision: 295 $"):match("(%d+)")) + 90000

local _G = _G
local GetLocale = _G.GetLocale
local CATEGORIES
if GetLocale() == "deDE" then
	CATEGORIES = {
		["Action Bars"] = "Aktionsleisten",
		["Auction"] = "Auktion",
		["Audio"] = "Audio",
		["Battlegrounds/PvP"] = "Schlachtfeld/PvP",
		["Buffs"] = "Stärkungszauber",
		["Chat/Communication"] = "Chat/Kommunikation",
		["Druid"] = "Druide",
		["Hunter"] = "Jäger",
		["Mage"] = "Magier",
		["Paladin"] = "Paladin",
		["Priest"] = "Priester",
		["Rogue"] = "Schurke",
		["Shaman"] = "Schamane",
		["Warlock"] = "Hexenmeister",
		["Warrior"] = "Krieger",
		["Healer"] = "Heiler",
		["Tank"] = "Tank",
		["Caster"] = "Zauberer",
		["Combat"] = "Kampf",
		["Compilations"] = "Zusammenstellungen",
		["Data Export"] = "Datenexport",
		["Development Tools"] = "Entwicklungstools",
		["Guild"] = "Gilde",
		["Frame Modification"] = "Frameveränderungen",
		["Interface Enhancements"] = "Interfaceverbesserungen",
		["Inventory"] = "Inventar",
		["Library"] = "Bibliotheken",
		["Map"] = "Karte",
		["Mail"] = "Post",
		["Miscellaneous"] = "Diverses",
		["Quest"] = "Quest",
		["Raid"] = "Schlachtzug",
		["Tradeskill"] = "Beruf",
		["UnitFrame"] = "Einheiten-Fenster",
	}
elseif GetLocale() == "frFR" then
	CATEGORIES = {
		["Action Bars"] = "Barres d'action",
		["Auction"] = "Hôtel des ventes",
		["Audio"] = "Audio",
		["Battlegrounds/PvP"] = "Champs de bataille/JcJ",
		["Buffs"] = "Buffs",
		["Chat/Communication"] = "Chat/Communication",
		["Druid"] = "Druide",
		["Hunter"] = "Chasseur",
		["Mage"] = "Mage",
		["Paladin"] = "Paladin",
		["Priest"] = "Prêtre",
		["Rogue"] = "Voleur",
		["Shaman"] = "Chaman",
		["Warlock"] = "Démoniste",
		["Warrior"] = "Guerrier",
		["Healer"] = "Soigneur",
		["Tank"] = "Tank",
		["Caster"] = "Casteur",
		["Combat"] = "Combat",
		["Compilations"] = "Compilations",
		["Data Export"] = "Exportation de données",
		["Development Tools"] = "Outils de développement",
		["Guild"] = "Guilde",
		["Frame Modification"] = "Modification des fenêtres",
		["Interface Enhancements"] = "Améliorations de l'interface",
		["Inventory"] = "Inventaire",
		["Library"] = "Bibliothèques",
		["Map"] = "Carte",
		["Mail"] = "Courrier",
		["Miscellaneous"] = "Divers",
		["Quest"] = "Quêtes",
		["Raid"] = "Raid",
		["Tradeskill"] = "Métiers",
		["UnitFrame"] = "Fenêtres d'unité",
	}
elseif GetLocale() == "koKR" then
	CATEGORIES = {
		["Action Bars"] = "액션바",
		["Auction"] = "경매",
		["Audio"] = "음향",
		["Battlegrounds/PvP"] = "전장/PvP",
		["Buffs"] = "버프",
		["Chat/Communication"] = "대화/의사소통",
		["Druid"] = "드루이드",
		["Hunter"] = "사냥꾼",
		["Mage"] = "마법사",
		["Paladin"] = "성기사",
		["Priest"] = "사제",
		["Rogue"] = "도적",
		["Shaman"] = "주술사",
		["Warlock"] = "흑마법사",
		["Warrior"] = "전사",
		["Healer"] = "힐러",
		["Tank"] = "탱커",
		["Caster"] = "캐스터",
		["Combat"] = "전투",
		["Compilations"] = "복합",
		["Data Export"] = "자료 출력",
		["Development Tools"] = "개발 도구",
		["Guild"] = "길드",
		["Frame Modification"] = "구조 변경",
		["Interface Enhancements"] = "인터페이스 강화",
		["Inventory"] = "인벤토리",
		["Library"] = "라이브러리",
		["Map"] = "지도",
		["Mail"] = "우편",
		["Miscellaneous"] = "기타",
		["Quest"] = "퀘스트",
		["Raid"] = "공격대",
		["Tradeskill"] = "전문기술",
		["UnitFrame"] = "유닛 프레임",
	}
elseif GetLocale() == "zhTW" then
	CATEGORIES = {
		["Action Bars"] = "動作列",
		["Auction"] = "拍賣",
		["Audio"] = "音效",
		["Battlegrounds/PvP"] = "戰場/PvP",
		["Buffs"] = "增益",
		["Chat/Communication"] = "聊天/通訊",
		["Druid"] = "德魯伊",
		["Hunter"] = "獵人",
		["Mage"] = "法師",
		["Paladin"] = "聖騎士",
		["Priest"] = "牧師",
		["Rogue"] = "盜賊",
		["Shaman"] = "薩滿",
		["Warlock"] = "術士",
		["Warrior"] = "戰士",
		["Healer"] = "治療者",
		["Tank"] = "坦克",
		["Caster"] = "施法者",
		["Combat"] = "戰鬥",
		["Compilations"] = "整合",
		["Data Export"] = "資料匯出",
		["Development Tools"] = "開發工具",
		["Guild"] = "公會",
		["Frame Modification"] = "框架修改",
		["Interface Enhancements"] = "介面增強",
		["Inventory"] = "庫存",
		["Library"] = "程式庫",
		["Map"] = "地圖",
		["Mail"] = "郵件",
		["Miscellaneous"] = "雜項",
		["Quest"] = "任務",
		["Raid"] = "團隊",
		["Tradeskill"] = "交易技能",
		["UnitFrame"] = "頭像框架",
	}
elseif GetLocale() == "zhCN" then
	CATEGORIES = {
		["Action Bars"] = "动作条",
		["Auction"] = "拍卖",
		["Audio"] = "音频",
		["Battlegrounds/PvP"] = "战场/PvP",
		["Buffs"] = "增益魔法",
		["Chat/Communication"] = "聊天/交流",
		["Druid"] = "德鲁伊",
		["Hunter"] = "猎人",
		["Mage"] = "法师",
		["Paladin"] = "圣骑士",
		["Priest"] = "牧师",
		["Rogue"] = "潜行者",
		["Shaman"] = "萨满祭司",
		["Warlock"] = "术士",
		["Warrior"] = "战士",
		["Healer"] = "治疗",
		["Tank"] = "坦克",
		["Caster"] = "远程输出",
		["Combat"] = "战斗",
		["Compilations"] = "编译",
		["Data Export"] = "数据导出",
		["Development Tools"] = "开发工具",
		["Guild"] = "公会",
		["Frame Modification"] = "框架修改",
		["Interface Enhancements"] = "界面增强",
		["Inventory"] = "背包",
		["Library"] = "库",
		["Map"] = "地图",
		["Mail"] = "邮件",
		["Miscellaneous"] = "杂项",
		["Quest"] = "任务",
		["Raid"] = "团队",
		["Tradeskill"] = "商业技能",
		["UnitFrame"] = "头像框架",
	}
elseif GetLocale() == "esES" then
	CATEGORIES = {
		["Action Bars"] = "Barras de Acción",
		["Auction"] = "Subasta",
		["Audio"] = "Audio",
		["Battlegrounds/PvP"] = "Campos de Batalla/JcJ",
		["Buffs"] = "Buffs",
		["Chat/Communication"] = "Chat/Comunicación",
		["Druid"] = "Druida",
		["Hunter"] = "Cazador",
		["Mage"] = "Mago",
		["Paladin"] = "Paladín",
		["Priest"] = "Sacerdote",
		["Rogue"] = "Pícaro",
		["Shaman"] = "Chamán",
		["Warlock"] = "Brujo",
		["Warrior"] = "Guerrero",
		["Healer"] = "Sanador",
		["Tank"] = "Tanque",
		["Caster"] = "Conjurador",
		["Combat"] = "Combate",
		["Compilations"] = "Compilaciones",
		["Data Export"] = "Exportar Datos",
		["Development Tools"] = "Herramientas de Desarrollo",
		["Guild"] = "Hermandad",
		["Frame Modification"] = "Modificación de Marcos",
		["Interface Enhancements"] = "Mejoras de la Interfaz",
		["Inventory"] = "Inventario",
		["Library"] = "Biblioteca",
		["Map"] = "Mapa",
		["Mail"] = "Correo",
		["Miscellaneous"] = "Misceláneo",
		["Quest"] = "Misión",
		["Raid"] = "Banda",
		["Tradeskill"] = "Habilidad de Comercio",
		["UnitFrame"] = "Marco de Unidades",
	}
else -- enUS
	CATEGORIES = {
		["Action Bars"] = "Action Bars",
		["Auction"] = "Auction",
		["Audio"] = "Audio",
		["Battlegrounds/PvP"] = "Battlegrounds/PvP",
		["Buffs"] = "Buffs",
		["Chat/Communication"] = "Chat/Communication",
		["Druid"] = "Druid",
		["Hunter"] = "Hunter",
		["Mage"] = "Mage",
		["Paladin"] = "Paladin",
		["Priest"] = "Priest",
		["Rogue"] = "Rogue",
		["Shaman"] = "Shaman",
		["Warlock"] = "Warlock",
		["Warrior"] = "Warrior",
		["Healer"] = "Healer",
		["Tank"] = "Tank",
		["Caster"] = "Caster",
		["Combat"] = "Combat",
		["Compilations"] = "Compilations",
		["Data Export"] = "Data Export",
		["Development Tools"] = "Development Tools",
		["Guild"] = "Guild",
		["Frame Modification"] = "Frame Modification",
		["Interface Enhancements"] = "Interface Enhancements",
		["Inventory"] = "Inventory",
		["Library"] = "Library",
		["Map"] = "Map",
		["Mail"] = "Mail",
		["Miscellaneous"] = "Miscellaneous",
		["Quest"] = "Quest",
		["Raid"] = "Raid",
		["Tradeskill"] = "Tradeskill",
		["UnitFrame"] = "UnitFrame",
	}
end

local select = _G.select
local tostring = _G.tostring
local pairs = _G.pairs
local ipairs = _G.ipairs
local error = _G.error
local setmetatable = _G.setmetatable
local getmetatable = _G.getmetatable
local type = _G.type
local pcall = _G.pcall
local next = _G.next
local tonumber = _G.tonumber
local strmatch = _G.strmatch
local table_remove = _G.table.remove
local debugstack = _G.debugstack
local LoadAddOn = _G.LoadAddOn
local GetAddOnInfo = _G.GetAddOnInfo
local GetAddOnMetadata = _G.GetAddOnMetadata
local GetNumAddOns = _G.GetNumAddOns
local DisableAddOn = _G.DisableAddOn
local EnableAddOn = _G.EnableAddOn
local IsAddOnLoadOnDemand = _G.IsAddOnLoadOnDemand
local IsLoggedIn = _G.IsLoggedIn
local geterrorhandler = _G.geterrorhandler
local assert = _G.assert
local table_sort = _G.table.sort
local table_concat = _G.table.concat

-- #AUTODOC_NAMESPACE Rock


local LibStub = _G.LibStub

local Rock = LibStub:GetLibrary(MAJOR_VERSION, true) or _G.Rock
local oldRock
if not Rock then
	Rock = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
	if not Rock then
		return
	end
	Rock.name = MAJOR_VERSION
else
	Rock, oldRock = Rock:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
	if not Rock then
		return
	end
end
_G.Rock = Rock

local L = setmetatable({}, {__index=function(self,key) self[key] = key; return key end})
if GetLocale() == "zhCN" then
	L["Advanced options"] = "高级选项"
	L["Advanced options for developers and power users."] = "开发者与高级用户的高级选项"
	L["Unit tests"] = "框体测试"
	L["Enable unit tests to be run. This is for developers only.\n\nYou must ReloadUI for changes to take effect."] = "开启框体测试，仅供开发者使用。\n\n需要重载用户界面。"
	L["Contracts"] = "侦错协定"
	L["Enable contracts to be run. This is for developers and anyone wanting to file a bug. Do not file a bug unless contracts are enabled. This will slightly slow down your addons if enabled."] = "启用侦错协定，这是给插件作者用来通报错误所使用。"
	L["Reload UI"] = "重载UI"
	L["Reload the User Interface for some changes to take effect."] = "部分功能更改需要重载用户界面才会生效。"
	L["Reload"] = "重载"
	L["Give donation"] = "捐赠"
	L["Donate"] = "捐赠"
	L["Give a much-needed donation to the author of this addon."] = "给插件作者捐赠支持插件开发。"
	L["File issue"] = "通报错误"
	L["Report"] = "报告"
	L["File a bug or request a new feature or an improvement to this addon."] = "发送错误报告或请求新功能及要改进的部分。"
	L["Press Ctrl-C to copy, then Alt-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Ctrl-C复制网址，Alt-Tab切换到桌面，打开浏览器，在地址栏贴上网址。"
	L["Press Cmd-C to copy, then Cmd-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Cmd-C复制网址，Cmd-Tab切换到电脑桌面，打开浏览器，在地址栏贴上网址。"
	L["Enabled"] = "开启"
	L["Enable or disable this addon."] = "启用这个插件。"	

elseif GetLocale() == "zhTW" then
	L["Advanced options"] = "進階選項"
	L["Advanced options for developers and power users."] = "插件作者、進階用戶選項"
	L["Unit tests"] = "單元測試"
	L["Enable unit tests to be run. This is for developers only.\n\nYou must ReloadUI for changes to take effect."] = "啟用單元測試，這是給插件作者使用的功能。\n\n需要重載介面才能使用。"
	L["Contracts"] = "偵錯協定"
	L["Enable contracts to be run. This is for developers and anyone wanting to file a bug. Do not file a bug unless contracts are enabled. This will slightly slow down your addons if enabled."] = "啟用偵錯協定，這是給插件作者用來通報錯誤所使用。"
	L["Reload UI"] = "重載介面"
	L["Reload the User Interface for some changes to take effect."] = "重新載入使用者介面，部分功能才會生效。"
	L["Reload"] = "重載"
	L["Give donation"] = "捐贈"
	L["Donate"] = "捐贈"
	L["Give a much-needed donation to the author of this addon."] = "捐贈金錢給插件作者。"
	L["File issue"] = "通報錯誤"
	L["Report"] = "報告"
	L["File a bug or request a new feature or an improvement to this addon."] = "發出錯誤報告或請求新功能及要改進的部分。"
	L["Press Ctrl-C to copy, then Alt-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Ctrl-C複製網址，Alt-Tab切換到電腦桌面，打開瀏覽器，在網址列貼上網址。"
	L["Press Cmd-C to copy, then Cmd-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Cmd-C複製網址，Cmd-Tab切換到電腦桌面，打開瀏覽器，在網址列貼上網址。"
	L["Enabled"] = "啟用"
	L["Enable or disable this addon."] = "啟用這個插件。"
elseif GetLocale() == "koKR" then
	L["Advanced options"] = "상세 옵션"
	L["Advanced options for developers and power users."] = "개발자와 파워 사용자를 위한 상세 옵션입니다."
	L["Unit tests"] = "유닛 테스트"
	L["Enable unit tests to be run. This is for developers only.\n\nYou must ReloadUI for changes to take effect."] = "유닛 테스트를 사용합니다. 이것은 개발자만을 위한 옵션입니다.\n\n변경된 결과를 적용하기 위해 당신의 UI를 재실행 합니다."
	L["Contracts"] = "계약"
	L["Enable contracts to be run. This is for developers and anyone wanting to file a bug. Do not file a bug unless contracts are enabled. This will slightly slow down your addons if enabled."] = "계약을 사용합니다. 이것은 개발자와 버그 파일을 알릴 분이면 누구나 사용 가능합니다. 계약이 가능하지 않으면 버그 파일을 보내지 마십시오. 이것은 당신의 애드온 속도를 약간 떨어뜨립니다."
	L["Reload UI"] = "UI 재실행"
	L["Reload the User Interface for some changes to take effect."] = "변경된 결과를 적용하기 위해 사용자 인터페이스를 재실행합니다."
	L["Reload"] = "재실행"
	L["Give donation"] = "기부"
	L["Donate"] = "기부"
	L["Give a much-needed donation to the author of this addon."] = "이 애드온의 제작자에게 필요한 기부를 합니다."
	L["File issue"] = "파일 이슈"
	L["Report"] = "보고"
	L["File a bug or request a new feature or an improvement to this addon."] = "버그 파일을 알리거나 새로운 기능 또는 이 애드온에 대한 개선을 부탁합니다."
	L["Press Ctrl-C to copy, then Alt-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Ctrl-C로 복사합니다. Alt-Tab 눌려 게임으로 부터 나간후 웹 브라우저를 엽니다. 복사된 링크를 주소 창에 붙여넣기 합니다."
	L["Press Cmd-C to copy, then Cmd-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Cmd-C로 복사합니다. Cmd-Tab 눌려 게임으로 부터 나간후 웹 브라우저를 엽니다. 복사된 링크를 주소 창에 붙여넣기 합니다."
	L["Enabled"] = "사용"
	L["Enable or disable this addon."] = "이 애드온을 사용하거나 사용하지 않습니다."
elseif GetLocale() == "frFR" then
	L["Advanced options"] = "Options avancées"
	L["Advanced options for developers and power users."] = "Options avancées à l'attention des développeurs et des utilisateurs expérimentés."
	L["Reload UI"] = "Recharger IU"
	L["Reload the User Interface for some changes to take effect."] = "Recharge l'interface utilisateur afin que certains changements prennent effet."
	L["Reload"] = "Recharger"
	L["Give donation"] = "Faire un don"
	L["Donate"] = "Don"
	L["Give a much-needed donation to the author of this addon."] = "Permet de faire un don bien mérité à l'auteur de cet addon."
	L["File issue"] = "Problème"
	L["Report"] = "Signaler"
	L["File a bug or request a new feature or an improvement to this addon."] = "Permet de signaler un bogue ou de demander une amélioration à cet addon."
	L["Press Ctrl-C to copy, then Alt-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Ctrl-C pour copier, puis Alt-Tab pour sortir du jeu. Ouvrez votre navigateur internet et collez le lien dans la barre d'adresse."
	L["Press Cmd-C to copy, then Cmd-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] = "Cmd-C pour copier, puis Alt-Tab pour sortir du jeu. Ouvrez votre navigateur internet et collez le lien dans la barre d'adresse."
	L["Enabled"] = "Activé"
	L["Enable or disable this addon."] = "Active ou désactive cet addon."
end

local isStandalone = debugstack():match("[Oo%.][Nn%.][Ss%.]\\([^\\]+)\\") == MAJOR_VERSION or nil
local unitTestDB, enableContracts

local weakKey = { __mode = 'k' }

-- frame to manage events from
Rock.frame = oldRock and oldRock.frame or _G.CreateFrame("Frame")
local frame = Rock.frame
-- dict of libraries in { ["major"] = object } form
Rock.libraries = oldRock and oldRock.libraries or { [MAJOR_VERSION] = Rock }
local libraries = Rock.libraries
-- set of libraries which have gone through the finalization process in { [object] = true } form
Rock.finalizedLibraries = setmetatable(oldRock and oldRock.finalizedLibraries or { }, weakKey)
local finalizedLibraries = Rock.finalizedLibraries
-- set of libraries which have been tried to be loaded.
Rock.scannedLibraries = oldRock and oldRock.scannedLibraries or {}
local scannedLibraries = Rock.scannedLibraries
-- exportedMethods[library] = { "method1", "method2" }
Rock.exportedMethods = setmetatable(oldRock and oldRock.exportedMethods or {}, weakKey)
local exportedMethods = Rock.exportedMethods
-- mixinToObject[mixin][object] = true
Rock.mixinToObject = setmetatable(oldRock and oldRock.mixinToObject or {}, weakKey)
local mixinToObject = Rock.mixinToObject
-- dict of addons in { ["name"] = object } form
Rock.addons = oldRock and oldRock.addons or {}
local addons = Rock.addons
-- set of libraries that should be finalized before ADDON_LOADED.
Rock.pendingLibraries = setmetatable(oldRock and oldRock.pendingLibraries or { }, weakKey)
local pendingLibraries = Rock.pendingLibraries
-- list of addons in order of created that need to be initialized by ADDON_LOADED.
Rock.pendingAddons = oldRock and oldRock.pendingAddons or {}
local pendingAddons = Rock.pendingAddons
-- dictionary of addons to their folder names
Rock.addonToFolder = oldRock and oldRock.addonToFolder or {}
local addonToFolder = Rock.addonToFolder
-- set of folders which have been loaded
Rock.foldersLoaded = oldRock and oldRock.foldersLoaded or {}
local foldersLoaded = Rock.foldersLoaded
-- list of addons in order of created that need to be enabled by PLAYER_LOGIN.
Rock.pendingAddonsEnable = oldRock and oldRock.pendingAddonsEnable or {}
local pendingAddonsEnable = Rock.pendingAddonsEnable
-- set of addons which have been enabled at least once.
Rock.addonsAlreadyEnabled = oldRock and oldRock.addonsAlreadyEnabled or {}
local addonsAlreadyEnabled = Rock.addonsAlreadyEnabled
-- set of addons which have no database and are set to be inactive.
Rock.inactiveAddons = oldRock and oldRock.inactiveAddons or {}
local inactiveAddons = Rock.inactiveAddons
-- set of addons which are currently enabled (not necessarily should be)
Rock.currentlyEnabledAddons = oldRock and oldRock.currentlyEnabledAddons or {}
local currentlyEnabledAddons = Rock.currentlyEnabledAddons
-- dictionary of namespace to list of functions which will be run.
Rock.unitTests = oldRock and oldRock.unitTests or {}
local unitTests = Rock.unitTests
-- metatable for addons
Rock.addon_mt = oldRock and oldRock.addon_mt or {}
local addon_mt = Rock.addon_mt
for k in pairs(addon_mt) do
	addon_mt[k] = nil
end
function addon_mt:__tostring()
	return tostring(self.name)
end

local function better_tostring(self)
	if type(self) == "table" and self.name then
		return tostring(self.name)
	end
	return tostring(self)
end

local function figureCurrentAddon(pos)
	local stack = debugstack(pos+1, 1, 0)
	local folder = stack:match("[Oo%.][Nn%.][Ss%.]\\([^\\]+)\\")
	if folder then
		return folder
	end

	local partFolder = stack:match("...([^\\]+)\\")
	if partFolder then
		local partFolder_len = #partFolder
		for i = 1, GetNumAddOns() do
			local name = GetAddOnInfo(i)
			if #name >= partFolder_len then
				local partName = name:sub(-partFolder_len)
				if partName == partFolder then
					return name
				end
			end
		end
	end
	return nil
end

--[[---------------------------------------------------------------------------
Returns:
	string - the localized name of the given category.
Arguments:
	string - the English name of the category.
Example:
	local uf = Rock:GetLocalizedCategory("UnitFrame")
-----------------------------------------------------------------------------]]
function Rock:GetLocalizedCategory(name)
	if type(name) ~= "string" then
		error(("Bad argument #2 to `GetLocalizedCategory'. Expected %q, got %q."):format("string", type(name)), 2)
	end
	local cat = CATEGORIES[name]
	if cat then
		return cat
	end
	local name_lower = name:lower()
	for k in pairs(CATEGORIES) do
		if k:lower() == name_lower then
			return k
		end
	end
	return _G.UNKNOWN or "Unknown"
end

local weak = {__mode = 'kv'}

Rock.recycleData = oldRock and oldRock.recycleData or {}
local recycleData = Rock.recycleData
if recycleData.pools then
	setmetatable(recycleData.pools, weak)
end
if recycleData.debugPools then
	setmetatable(recycleData.debugPools, weak)
end
if recycleData.newList then
	setmetatable(recycleData.newList, weak)
end
if recycleData.newDict then
	setmetatable(recycleData.newDict, weak)
end
if recycleData.newSet then
	setmetatable(recycleData.newSet, weak)
end
if recycleData.del then
	setmetatable(recycleData.del, weak)
end

local tmp = {}
local function myUnpack(t, start)
	if not start then
		start = 1
	end
	local value = t[start]
	if value == nil then
		return
	end
	t[start] = nil
	return value, myUnpack(t, start+1)
end

--[[---------------------------------------------------------------------------
Notes:
	* Returns functions for the specified namespace based on what is provided.
	* function types:
	; "newList" : to create a list
	; "newDict" : to create a dictionary
	; "newSet" : to create a set
	; "del" : to delete a table
	; "unpackListAndDel" : deletes a table and returns what its contents were as a list, in order.
	; "unpackSetAndDel" : deletes a table and returns what its contents were as a set, in no particular order.
	; "unpackDictAndDel" : deletes a table and returns what its contents were as a dictionary, in no particular order.
	* If you provide "Debug" as the last argument, then the namespace can be debugged with ''':DebugRecycle'''
	* It is '''not recommended''' to use table recycling with tables that have more than 128 keys, as it is typically faster to let lua's garbage collector handle it.
Arguments:
	string - the namespace. ''Note: this doesn't necessarily have to be a string.''
Example:
	local newList, newDict, newSet, del, unpackListAndDel, unpackSetAndDel, unpackDictAndDel = Rock:GetRecyclingFunctions("MyNamespace", "newList", "newDict", "newSet", "del", "unpackListAndDel", "unpackSetAndDel", "unpackDictAndDel")

	local t = newList('alpha', 'bravo') -- same as t = {'alpha', 'bravo'}
	local u = newDict('alpha', 'bravo') -- same as t = {['alpha'] = 'bravo'}
	local v = newSet('alpha', 'bravo') -- same as t = {['alpha'] = true, ['bravo'] = true}
	t = del(t) -- you want to clear your reference as well as deleting.
	u = del(u)
	v = del(v)

	-- for debugging
	local newList = Rock:GetRecyclingFunctions("MyNamespace", "newList", "Debug")
	local t = newList()
	Rock:DebugRecycle("MyNamespace")
	t = del(t)

	-- unpacking functions
	unpackListAndDel(newList(...)) => ...
	unpackSetAndDel(newSet(...)) => ...
	unpackDictAndDel(newDict(...)) => ...
	newList(unpackListAndDel(t)) => t
	newSet(unpackSetAndDel(t)) => t
	newDict(unpackDictAndDel(t)) => t
	-- as you can see, they are inverses of each other.
-----------------------------------------------------------------------------]]
function Rock:GetRecyclingFunctions(namespace, ...)
	local pools = recycleData.pools
	if not pools then
		pools = setmetatable({}, weak)
		recycleData.pools = pools
	end
	if namespace == "newList" or namespace == "newSet" or namespace == "newDict" or namespace == "del" or namespace == "unpackListAndDel" or namespace == "unpackSetAndDel" or namespace == "unpackDictAndDel" then
		error(("Bad argument #2 to `GetRecyclingFunctions'. Cannot be %q"):format(namespace), 2)
	end
	local pool = pools[namespace]
	if not pool then
		pool = setmetatable({}, weak)
		pools[namespace] = pool
	end
	local n = select('#', ...)
	local debug = select(n, ...) == "Debug"
	if debug then
		n = n - 1
		local debugPools = recycleData.debugPools
		if not debugPools then
			debugPools = setmetatable({}, weak)
			recycleData.debugPools = debugPools
		end
		debug = debugPools[namespace]
		if not debug then
			debug = { num = 0 }
			debugPools[namespace] = debug
		end
	elseif recycleData.debugPools and recycleData.debugPools[namespace] then
		debug = recycleData.debugPools[namespace]
	end
	for i = 1, n do
		local func = select(i, ...)
		local recycleData_func = recycleData[func]
		if not recycleData_func then
			recycleData_func = setmetatable({}, weak)
			recycleData[func] = recycleData_func
		end
		if func == "newList" then
			local newList = recycleData_func[namespace]
			if not newList then
				function newList(...)
					local t = next(pool)
					local n = select('#', ...)
					if t then
						pool[t] = nil
						for i = 1, n do
							t[i] = select(i, ...)
						end
					else
						t = { ... }
					end

					if debug then
						debug[t] = debugstack(2)
						debug.num = debug.num + 1
					end

					return t, n
				end
				recycleData_func[namespace] = newList
			end
			tmp[i] = newList
		elseif func == "newDict" then
			local newDict = recycleData_func[namespace]
			if not newDict then
				function newDict(...)
					local t = next(pool)
					if t then
						pool[t] = nil
					else
						t = {}
					end

					for i = 1, select('#', ...), 2 do
						t[select(i, ...)] = select(i+1, ...)
					end

					if debug then
						debug[t] = debugstack(2)
						debug.num = debug.num + 1
					end

					return t
				end
				recycleData_func[namespace] = newDict
			end
			tmp[i] = newDict
		elseif func == "newSet" then
			local newSet = recycleData_func[namespace]
			if not newSet then
				function newSet(...)
					local t = next(pool)
					if t then
						pool[t] = nil
					else
						t = {}
					end

					for i = 1, select('#', ...) do
						t[select(i, ...)] = true
					end

					if debug then
						debug[t] = debugstack(2)
						debug.num = debug.num + 1
					end

					return t
				end
				recycleData_func[namespace] = newSet
			end
			tmp[i] = newSet
		elseif func == "del" then
			local del = recycleData_func[namespace]
			if not del then
				function del(t)
					if not t then
						error(("Bad argument #1 to `del'. Expected %q, got %q."):format("table", type(t)), 2)
					end
					if pool[t] then
						local _, ret = pcall(error, "Error, double-free syndrome.", 3)
						geterrorhandler()(ret)
					end
					setmetatable(t, nil)
					for k in pairs(t) do
						t[k] = nil
					end
					t[true] = true
					t[true] = nil
					pool[t] = true

					if debug then
						debug[t] = nil
						debug.num = debug.num - 1
					end
					return nil
				end
				recycleData_func[namespace] = del
			end
			tmp[i] = del
		elseif func == "unpackListAndDel" then
			local unpackListAndDel = recycleData_func[namespace]
			if not unpackListAndDel then
				local function f(t, start, finish)
					if start > finish then
						for k in pairs(t) do
							t[k] = nil
						end
						t[true] = true
						t[true] = nil
						pool[t] = true
						return
					end
					return t[start], f(t, start+1, finish)
				end
				function unpackListAndDel(t, start, finish)
					if not t then
						error(("Bad argument #1 to `unpackListAndDel'. Expected %q, got %q."):format("table", type(t)), 2)
					end
					if not start then
						start = 1
					end
					if not finish then
						finish = #t
					end
					setmetatable(t, nil)
					if debug then
						debug[t] = nil
						debug.num = debug.num - 1
					end
					return f(t, start, finish)
				end
			end
			tmp[i] = unpackListAndDel
		elseif func == "unpackSetAndDel" then
			local unpackSetAndDel = recycleData_func[namespace]
			if not unpackSetAndDel then
				local function f(t, current)
					current = next(t, current)
					if current == nil then
						for k in pairs(t) do
							t[k] = nil
						end
						t[true] = true
						t[true] = nil
						pool[t] = true
						return
					end
					return current, f(t, current)
				end
				function unpackSetAndDel(t)
					if not t then
						error(("Bad argument #1 to `unpackListAndDel'. Expected %q, got %q."):format("table", type(t)), 2)
					end
					setmetatable(t, nil)
					if debug then
						debug[t] = nil
						debug.num = debug.num - 1
					end
					return f(t, nil)
				end
			end
			tmp[i] = unpackSetAndDel
		elseif func == "unpackDictAndDel" then
			local unpackDictAndDel = recycleData_func[namespace]
			if not unpackDictAndDel then
				local function f(t, current)
					local value
					current, value = next(t, current)
					if current == nil then
						for k in pairs(t) do
							t[k] = nil
						end
						t[true] = true
						t[true] = nil
						pool[t] = true
						return
					end
					return current, value, f(t, current)
				end
				function unpackDictAndDel(t)
					if not t then
						error(("Bad argument #1 to `unpackListAndDel'. Expected %q, got %q."):format("table", type(t)), 2)
					end
					setmetatable(t, nil)
					if debug then
						debug[t] = nil
						debug.num = debug.num - 1
					end
					return f(t, nil)
				end
			end
			tmp[i] = unpackDictAndDel
		else
			error(("Bad argument #%d to `GetRecyclingFunctions': %q, %q, %q, %q, %q, %q, or %q expected, got %s"):format(i+2, "newList", "newDict", "newSet", "del", "unpackListAndDel", "unpackSetAndDel", "unpackDictAndDel", type(func) == "string" and ("%q"):format(func) or tostring(func)), 2)
		end
	end
	return myUnpack(tmp)
end

--[[---------------------------------------------------------------------------
Notes:
	* Prints information about the specified recycling namespace, including what tables are still in play and where they come from and how many there are.
	* This goes in tandem with ''':GetRecyclingFunctions'''
Arguments:
	string - the namespace. ''Note: this doesn't necessarily have to be a string.''
Example:
	local newList = Rock:GetRecyclingFunctions("MyNamespace", "newList", "Debug")
	local t = newList()
	Rock:DebugRecycle("MyNamespace")
	t = del(t)
-----------------------------------------------------------------------------]]
function Rock:DebugRecycle(namespace)
	local debug = recycleData.debugPools and recycleData.debugPools[namespace]
	if not debug then
		return
	end
	for k, v in pairs(debug) do
		if k ~= "num" then
			_G.DEFAULT_CHAT_FRAME:AddMessage(v)
			_G.DEFAULT_CHAT_FRAME:AddMessage("------")
		end
	end
	_G.DEFAULT_CHAT_FRAME:AddMessage(("%s: %d tables in action."):format(tostring(namespace), debug.num))
end

local newList, del, unpackListAndDel, unpackDictAndDel = Rock:GetRecyclingFunctions(MAJOR_VERSION, "newList", "del", "unpackListAndDel", "unpackDictAndDel")

--[[---------------------------------------------------------------------------
Notes:
	* Adds a unit test for the specified namespace
	* The function provided is called, and it should be where tests are performed, if a problem occurs, an error should fire. If no problems occur, it should return silently.
	* You can have as many tests per namespace as you want.
Arguments:
	string - the namespace.
	function - the function to call.
Example:
	Rock:AddUnitTest("LibMonkey-1.0", function()
		local LibMonkey = Rock("LibMonkey-1.0")
		assert(LibMonkey:Fling() == "Poo")
	end)
-----------------------------------------------------------------------------]]
function Rock:AddUnitTest(namespace, func)
	if not isStandalone then
		return
	end
	if type(namespace) ~= "string" then
		error(("Bad argument #2 to `AddUnitTest'. Expected %q, got %q."):format("string", type(namespace)), 2)
	end
	if namespace:find("^Lib[A-Z]") then
		local addon = figureCurrentAddon(2)
		if addon ~= namespace then
			return
		end
	end
	if type(func) ~= "function" then
		error(("Bad argument #3 to `AddUnitTest'. Expected %q, got %q."):format("function", type(func)), 2)
	end
	local addon = figureCurrentAddon(2)
	if libraries[namespace] and addon ~= namespace then
		-- only work on standalone libraries.
		return
	end
	local unitTests_namespace = unitTests[namespace]
	if not unitTests_namespace then
		unitTests_namespace = newList()
		unitTests[namespace] = unitTests_namespace
	end
	if not unitTests_namespace.addon then
		unitTests_namespace.addon = addon
	end
	if unitTestDB and not unitTestDB[namespace] then
		return
	end
	unitTests_namespace[#unitTests_namespace+1] = func
end

local LibRockEvent
local LibRockModuleCore
local OpenDonationFrame, OpenIssueFrame
function Rock:OnLibraryLoad(major, library)
	if major == "LibRockEvent-1.0" then
		LibRockEvent = library
		LibRockEvent:Embed(Rock)
	elseif major == "LibRockModuleCore-1.0" then
		LibRockModuleCore = library
	elseif major == "LibRockConfig-1.0" then
		if isStandalone then
			library.rockOptions.args.advanced = {
				type = 'group',
				groupType = 'inline',
				name = L["Advanced options"],
				desc = L["Advanced options for developers and power users."],
				order = -1,
				args = {
					unitTests = {
						type = 'multichoice',
						name = L["Unit tests"],
						desc = L["Enable unit tests to be run. This is for developers only.\n\nYou must ReloadUI for changes to take effect."],
						get = function(key)
							return unitTestDB[key]
						end,
						set = function(key, value)
							unitTestDB[key] = value or nil
						end,
						choices = function()
							local t = newList()
							for k in pairs(unitTests) do
								t[k] = k
							end
							return "@dict", unpackDictAndDel(t)
						end
					},
					contracts = {
						type = 'boolean',
						name = L["Contracts"],
						desc = L["Enable contracts to be run. This is for developers and anyone wanting to file a bug. Do not file a bug unless contracts are enabled. This will slightly slow down your addons if enabled."],
						get = function()
							return enableContracts
						end,
						set = function(value)
							_G.LibRock_1_0DB.contracts = value or nil
							enableContracts = value
						end,
					}
				}
			}
		end
		library.rockOptions.args.reloadui = {
			type = 'execute',
			name = L["Reload UI"],
			desc = L["Reload the User Interface for some changes to take effect."],
			buttonText = L["Reload"],
			func = function()
				_G.ReloadUI()
			end,
			order = -2,
		}
		Rock.donate = "Paypal:ckknight AT gmail DOT com"
		library.rockOptions.args.donate = {
			type = 'execute',
			name = L["Give donation"],
			buttonText = L["Donate"],
			desc = L["Give a much-needed donation to the author of this addon."],
			func = OpenDonationFrame,
			passValue = Rock,
			order = -3,
		}
		Rock.issueTracker = "Wowace:10027"
		library.rockOptions.args.issue = {
			type = 'execute',
			name = L["File issue"],
			buttonText = L["Report"],
			desc = L["File a bug or request a new feature or an improvement to this addon."],
			func = OpenIssueFrame,
			passValue = Rock,
			order = -4,
		}
	end
end

addon_mt.__index = {}
local addon_mt___index = addon_mt.__index
--[[---------------------------------------------------------------------------
#FORCE_DOC
Notes:
	* This is exported to all addons.
	* This information is retrieved from LibRockModuleCore-1.0 if it is a module, otherwise from LibRockDB-1.0 if it uses that as a mixin, otherwise it keeps a variable locally.
Returns:
	boolean - whether the addon is in an active state or not.
Example:
	local active = MyAddon:IsActive()
-----------------------------------------------------------------------------]]
function addon_mt___index:IsActive()
	if LibRockModuleCore then
		local core = LibRockModuleCore:HasModule(self)
		if core then
			return core:IsModuleActive(self)
		end
	end

	local self_db = self.db
	if self_db then
		local disabled
		local self_db_raw = self_db.raw
		if self_db_raw then
			local self_db_raw_disabled = self_db_raw.disabled
			if self_db_raw_disabled then
				local profile = type(self.GetProfile) == "function" and select(2, self:GetProfile()) or false
				disabled = self_db_raw_disabled[profile]
			end
		else
			return false
		end
		return not disabled
	end

	return not inactiveAddons[self]
end
--[[---------------------------------------------------------------------------
#FORCE_DOC
Notes:
	* This is exported to all addons.
	* If it enables the addon, it will call :OnEnable(first) on the addon and :OnEmbedEnable(addon, first) on all its mixins.
	* If it disables the addon, it will call :OnDisable(first) on the addon and :OnEmbedDisable(addon, first) on all its mixins.
	* This information is stored by LibRockModuleCore-1.0 if it is a module, otherwise from LibRockDB-1.0 if it uses that as a mixin, otherwise it keeps a variable locally.
Arguments:
	[optional] boolean - whether the addon should be in an active state or not. Default: not :IsActive()
Returns:
	boolean - whether the addon is in an active state or not.
Example:
	MyAddon:ToggleActive() -- switch
	MyAddon:ToggleActive(true) -- force on
	MyAddon:ToggleActive(false) -- force off
-----------------------------------------------------------------------------]]
function addon_mt___index:ToggleActive(state)
	if state and state ~= true then
		error(("Bad argument #2 to `ToggleActive'. Expected %q or %q, got %q."):format("boolean", "nil", type(state)), 2)
	end
	if LibRockModuleCore then
		local core = LibRockModuleCore:HasModule(self)
		if core then
			return core:ToggleModuleActive(self, state)
		end
	end

	local self_db = self.db
	if self_db then
		local self_db_raw = self_db.raw
		if not self_db_raw then
			error("Error saving to database with `ToggleActive'. db.raw not available.", 2)
		end
		local self_db_raw_disabled = self_db_raw.disabled
		if not self_db_raw_disabled then
			self_db_raw_disabled = newList()
			self_db_raw.disabled = self_db_raw_disabled
		end
		local profile = type(self.GetProfile) == "function" and select(2, self:GetProfile()) or false
		if state == nil then
			state = not not self_db_raw_disabled[profile]
		elseif (not self_db_raw_disabled[profile]) == state then
			return
		end
		self_db_raw_disabled[profile] = not state or nil
		if next(self_db_raw_disabled) == nil then
			self_db_raw.disabled = del(self_db_raw_disabled)
		end
	else
		if state == nil then
			state = not not inactiveAddons[self]
		elseif (not inactiveAddons[self]) == state then
			return
		end
		inactiveAddons[self] = not state or nil
	end

	Rock:RecheckEnabledStates()

	return state
end

local function noop() end

do
	local preconditions = setmetatable({}, weakKey)
	local postconditions = setmetatable({}, weakKey)
	local postconditionsOld = setmetatable({}, weakKey)

	local currentMethod = nil

	local function hook(object, method)
		local object_method = object[method]
		object[method] = function(...)
			local pre = preconditions[object_method]
			local post = postconditions[object_method]
			if pre then
				local old_currentMethod = currentMethod
				currentMethod = method
				pre(...)
				currentMethod = old_currentMethod
			end
			if not post then
				return object_method(...)
			end
			local oldFunc = postconditionsOld[object_method]
			local old
			if oldFunc then
				old = newList()
				oldFunc(old, ...)
			end

			local old_currentMethod = currentMethod
			currentMethod = nil
			local ret, n = newList(object_method(...))

			currentMethod = method
			if old then
				post(old, ret, ...)
				old = del(old)
			else
				post(ret, ...)
			end
			currentMethod = old_currentMethod
			return unpackListAndDel(ret, 1, n)
		end
	end

	local function precondition(object, method, func)
		if type(object) ~= "table" then
			error(("Bad argument #1 to `precondition'. Expected %q, got %q."):format("table", type(object)), 2)
		end
		if type(object[method]) ~= "function" then
			error(("Method %q not found on object %s. Expected %q, got %q."):format(tostring(method), tostring(object), "function", type(object[method])), 2)
		end
		if type(func) ~= "function" then
			error(("Bad argument #3 to `precondition'. Expected %q, got %q."):format("function", type(func)), 2)
		end

		local object_method = object[method]
		if preconditions[object_method] then
			error("Cannot call `preconditon' on the same method twice.", 2)
		end
		preconditions[object_method] = func

		if not postconditions[object_method] then
			hook(object, method)
		end
	end

	local function postcondition(object, method, func, fillOld)
		if type(object) ~= "table" then
			error(("Bad argument #1 to `postcondition'. Expected %q, got %q."):format("table", type(object)), 2)
		end
		if type(object[method]) ~= "function" then
			error(("Method %q not found on object %s. Expected %q, got %q."):format(tostring(method), tostring(object), "function", type(object[method])), 2)
		end
		if type(func) ~= "function" then
			error(("Bad argument #3 to `postcondition'. Expected %q, got %q."):format("function", type(func)), 2)
		end
		if fillOld and type(fillOld) ~= "function" then
			error(("Bad argument #4 to `postcondition'. Expected %q or %q, got %q."):format("function", "nil", type(func)), 2)
		end

		local object_method = object[method]
		if postconditions[object_method] then
			error("Cannot call `postcondition' on the same method twice.", 2)
		end
		postconditions[object_method] = func
		postconditionsOld[object_method] = fillOld

		if not preconditions[object_method] then
			hook(object, method)
		end
	end

	local function argCheck(value, position, ...)
		if not currentMethod then
			error("Cannot call `argCheck' outside of a pre/post-condition.", 2)
		end
		if type(position) ~= "number" then
			error(("Bad argument #2 to `argCheck'. Expected %q, got %q"):format("number", type(position)), 2)
		end
		local type_value = type(value)
		for i = 1, select('#', ...) do
			local v = select(i, ...)
			if type(v) ~= "string" then
				error(("Bad argument #%d to `argCheck'. Expected %q, got %q"):format(i+1, "string", type(v)), 2)
			end
			if v == type_value then
				return
			end
		end
		local t = newList(...)
		t[#t] = nil
		for i,v in ipairs(t) do
			t[i] = ("%q"):format(v)
		end
		local s
		if #t == 0 then
			s = ("%q"):format((...))
		elseif #t == 1 then
			s = ("%q or %q"):format(...)
		else
			s = table_concat(t, ", ") .. ", or " .. ("%q"):format(select(#t+1, ...))
		end
		t = del(t)

		error(("Bad argument #%d to `%s'. Expected %s, got %q."):format(position, tostring(currentMethod), s, type_value), 4)
	end

	--[[---------------------------------------------------------------------------
	Notes:
		* Returns functions for the specified namespace based on what is provided.
		* function types:
		; "precondition" : to set the pre-condition for a method.
		; "postcondition" : to set the post-condition for a method.
		; "argCheck" : to check the type of an argument, to be executed within a pre-condition.
		* preconditon is in the form of <tt>precondition(object, "methodName", func(self, ...))</tt>
		* postcondition is in the form of either <tt>postcondition(object, "methodName", func(returnValues, self, ...))</tt> or <tt>postcondition(object, "methodName", func(oldValues, returnValues, self, ...), populateOld(oldValues, self, ...))</tt>
		** returnValues is the list of return values, empty if no return values were sent.
		** if the populateOld function is provided, then the empty oldValues table is provided and expected to be filled, and then given to the func.
		* argCheck is in the form of <tt>argCheck(value, n, "type1" [, "type2", ...])</tt>
		** value is the value provided to the function you're checking.
		** n is the argument position. ''Note: 1 is the position of `self'. 2 would be the first "real" position.''
		** the tuple of types can be any string, but specifically "nil", "boolean", "string", "number", "function", "userdata", "table", etc.
	Arguments:
		string - the namespace. ''Note: this doesn't necessarily have to be a string.''
	Example:
		local precondition, postcondition, argCheck = Rock:GetRecyclingFunctions("Stack", "precondition", "postcondition", "argCheck")

		local stack = {}
		stack.IsEmpty = function(self)
			return self[1] == nil
		end
		stack.GetLength = function(self)
			return #self
		end
		stack.Push = function(self, value)
			self[#self+1] = value
		end
		precondition(stack, "Push", function(self, value)
			argCheck(value, 2, "string") -- only accept strings, no other values
		end)
		postcondition(stack, "Push", function(old, ret, self, value)
			assert(self:GetLength() == old.length+1)
			assert(not self:IsEmpty())
		end, function(old, self)
			old.length = self:GetLength()
		end)
		stack.Pop = function(self)
			local value = self[#self]
			self[#self] = nil
			return value
		end
		precondition(stack, "Pop", function(self)
			assert(self:GetLength() >= 1)
		end)
		postcondition(stack, "Pop", function(old, ret, self)
			assert(self:GetLength() == old.length-1)
		end, function(old, self)
			old.length = self:GetLength()
		end)
		stack.Peek = function(self)
			return self[#self]
		end
		precondition(stack, "Peek", function(self)
			assert(self:GetLength() >= 1)
		end)
		postcondition(stack, "Peek", function(old, ret, self)
			assert(self:GetLength() == old.length)
		end, function(old, self)
			old.length = self:GetLength()
		end)

		local t = setmetatable({}, {__index=stack})
		t:Push("Alpha")
		t:Push("Bravo")
		t:Push(5) -- error, only strings
		assert(t:Pop() == "Bravo")
		assert(t:Pop() == "Alpha")
		t:Pop() -- error, out of values
	-----------------------------------------------------------------------------]]
	function Rock:GetContractFunctions(namespace, ...)
		if namespace == "precondition" or namespace == "postcondition" or namespace == "argCheck" then
			error(("Bad argument #2 to `GetContractFunctions'. Cannot be %q."):format(namespace), 2)
		end
		local t = newList()
		if enableContracts then
			for i = 1, select('#', ...) do
				local v = select(i, ...)
				if v == "precondition" then
					t[i] = precondition
				elseif v == "postcondition" then
					t[i] = postcondition
				elseif v == "argCheck" then
					t[i] = argCheck
				else
					error(("Bad argument #%d to `GetContractFunctions'. Expected %q, %q, or %q, got %q."):format(i+2, "precondition", "postcondition", "argCheck", tostring(v)))
				end
			end
		else
			for i = 1, select('#', ...) do
				t[i] = noop
			end
		end
		return unpackListAndDel(t)
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* convert a revision string to a number
Arguments:
	string - revision string
Returns:
	string or number - the string given or the number retrieved from it.
-----------------------------------------------------------------------------]]
local function coerceRevisionToNumber(version)
	if type(version) == "string" then
		return tonumber(version:match("(%-?%d+)")) or version
	else
		return version
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* try to enable the standalone library specified
Arguments:
	string - name of the library.
Returns:
	boolean - whether the library is properly enabled and loadable.
-----------------------------------------------------------------------------]]
local function TryToEnable(addon)
	local islod = IsAddOnLoadOnDemand(addon)
	if islod then
		local _, _, _, enabled = GetAddOnInfo(addon)
		EnableAddOn(addon)
		local _, _, _, _, loadable = GetAddOnInfo(addon)
		if not loadable and not enabled then
			DisableAddOn(addon)
		end

		return loadable
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* try to load the standalone library specified
Arguments:
	string - name of the library.
Returns:
	boolean - whether the library is loaded.
-----------------------------------------------------------------------------]]
local function TryToLoadStandalone(major)
	major = major:lower()
	if scannedLibraries[major] then
		return
	end
	scannedLibraries[major] = true
	local name, _, _, enabled, loadable, state = GetAddOnInfo(major)
	if state == "MISSING" or not IsAddOnLoadOnDemand(major) then
		-- backwards compatibility for X-AceLibrary
		local field = "X-AceLibrary-" .. major
		local loaded
		for i = 1, GetNumAddOns() do
			if GetAddOnMetadata(i, field) then
				name, _, _, enabled, loadable = GetAddOnInfo(i)

				loadable = (enabled and loadable) or TryToEnable(name)
				if loadable then
					loaded = true
					LoadAddOn(name)
				end
			end
		end

		return loaded
	elseif (enabled and loadable) or TryToEnable(major) then
		LoadAddOn(major)
		return true
	else
		return false
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* Return the LibStub library, casing is unimportant.
Arguments:
	string - name of the library.
Returns:
	table or nil - library
	number - minor version
-----------------------------------------------------------------------------]]
local function GetLibStubLibrary(major)
	local lib, minor = LibStub:GetLibrary(major, true)
	if lib then
		return lib, minor
	end
	major = major:lower()
	for m, lib in LibStub:IterateLibraries() do
		if m:lower() == major then
			return LibStub:GetLibrary(m)
		end
	end
	return nil, nil
end

local finishLibraryRegistration
--[[---------------------------------------------------------------------------
Notes:
	* create a new library if the version provided is not out of date.
Arguments:
	string - name of the library.
	number - version of the library.
Returns:
	library, oldLibrary
	* table or nil - the library with which to manipulate
	* table or nil - the old version of the library to upgrade from
Example:
	local LibMonkey, oldLib = Rock:NewLibrary("LibMonkey-1.0", 50)
	if not LibMonkey then
		-- opt out now, out of date
		return
	end
-----------------------------------------------------------------------------]]
function Rock:NewLibrary(major, version)
	if type(major) ~= "string" then
		error(("Bad argument #2 to `NewLibrary'. Expected %q, got %q."):format("string", type(major)), 2)
	end
	if not major:match("^Lib[A-Z][A-Za-z%d%-]*%-%d+%.%d+$") then
		error(("Bad argument #2 to `NewLibrary'. Must match %q, got %q."):format("^Lib[A-Z][A-Za-z%d%-]*%-%d+%.%d+$", major), 2)
	end
	TryToLoadStandalone(major)
	version = coerceRevisionToNumber(version)
	if type(version) ~= "number" then
		error(("Bad argument #3 to `NewLibrary'. Expected %q, got %q."):format("number", type(version)), 2)
	end
	local library, oldMinor = LibStub:GetLibrary(major, true)
	if oldMinor and oldMinor >= version then
		-- in case LibStub is acting funny
		return nil, nil
	end
	local library, oldMinor = LibStub:NewLibrary(major, version)
	if not library then
		return nil, nil
	end
	local unitTests_major = unitTests[major]
	if unitTests_major then
		for k,v in pairs(unitTests_major) do
			unitTests_major[k] = nil
		end
	end
	for k, v in pairs(recycleData) do
		v[major] = nil
	end
	local mixinToObject_library = mixinToObject[library]

	local oldLib
	if oldMinor then
		-- previous version exists
		local mixins = newList()
		for mixin, objectSet in pairs(mixinToObject) do
			if objectSet[library] then
				mixins[mixin] = true
			end
		end
		for mixin in pairs(mixins) do
			mixin:Unembed(library)
		end
		mixins = del(mixins)
		oldLib = newList()
		for k, v in pairs(library) do
			oldLib[k] = v
			library[k] = nil
		end
		setmetatable(oldLib, getmetatable(library))
		setmetatable(library, nil)
	end
	finishLibraryRegistration(major, version, library, figureCurrentAddon(2))

	return library, oldLib
end
function finishLibraryRegistration(major, version, library, folder)
	library.name = major

	libraries[major] = library
	pendingLibraries[library] = folder
	local exportedMethods_library = exportedMethods[library]
	if exportedMethods_library then
		local mixinToObject_library = mixinToObject[library]
		if mixinToObject_library then
			for object in pairs(mixinToObject_library) do
				for _,v in ipairs(exportedMethods_library) do
					object[v] = nil
				end
			end
		end
		exportedMethods[library] = del(exportedMethods_library)
	end
	if library ~= Rock then
		Rock:Embed(library)
	end

	frame:Show()
end
if not oldRock then
	finishLibraryRegistration(MAJOR_VERSION, MINOR_VERSION, Rock, figureCurrentAddon(1))
end

-- #NODOC
local function __removeLibrary(libName)
	libraries[libName] = nil
	if LibStub.libs then
		LibStub.libs[libName] = nil
	end
	if LibStub.minors then
		LibStub.minors[libName] = nil
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* properly finalizes the library, essentially stating that it has loaded properly.
	* This will call :OnLibraryLoad("major", library) on every other library
	* This will also call :OnLibraryLoad("major", library) on the library provided, using every other library as the arguments.
	* An error will occur if this is not done before ADDON_LOADED.
Arguments:
	string - name of the library.
Example:
	local LibMonkey, oldLib = Rock:NewLibrary("LibMonkey-1.0", 50)
	if not LibMonkey then
		-- opt out now, out of date
		return
	end
	Rock:FinalizeLibrary("LibMonkey-1.0")
-----------------------------------------------------------------------------]]
function Rock:FinalizeLibrary(major)
	if type(major) ~= "string" then
		error(("Bad argument #2 to `FinalizeLibrary'. Expected %q, got %q."):format("string", type(major)), 2)
	end
	local library = libraries[major]
	if not library then
		error(("Bad argument #2 to `FinalizeLibrary'. %q is not a library."):format("string", major), 2)
	end
	pendingLibraries[library] = nil
	local library_OnLibraryLoad = library.OnLibraryLoad
	if library_OnLibraryLoad then
		for maj, lib in LibStub:IterateLibraries() do -- for all libraries
			if maj ~= major then
				local success, ret = pcall(library_OnLibraryLoad, library, maj, lib)
				if not success then
					geterrorhandler()(ret)
					break
				end
			end
		end
	end
	if finalizedLibraries[library] then
		return
	end
	finalizedLibraries[library] = true
	for maj, lib in pairs(libraries) do -- just Rock libraries
		if maj ~= major then
			local lib_OnLibraryLoad = lib.OnLibraryLoad
			if lib_OnLibraryLoad then
				local success, ret = pcall(lib_OnLibraryLoad, lib, major, library)
				if not success then
					geterrorhandler()(ret)
				end
			end
		end
	end
	if LibRockEvent then
		self:DispatchEvent("LibraryLoad", major, library)
	end
end

local function manualFinalize(major, library)
	if libraries[major] then -- non-Rock libraries only
		return
	end
	if finalizedLibraries[library] then -- don't do it twice
		return
	end
	finalizedLibraries[library] = true
	for maj, lib in pairs(libraries) do -- just Rock libraries
		if maj ~= major then
			local lib_OnLibraryLoad = lib.OnLibraryLoad
			if lib_OnLibraryLoad then
				local success, ret = pcall(lib_OnLibraryLoad, lib, major, library)
				if not success then
					geterrorhandler()(ret)
				end
			end
		end
	end
	if LibRockEvent then
		Rock:DispatchEvent("LibraryLoad", major, library)
	end
end

--[[---------------------------------------------------------------------------
Arguments:
	string - name of the library.
	[optional] boolean - whether to not load a library if it is not found. Default: false
	[optional] boolean - whether to not error if a library is not found. Default: false
Returns:
	library
	* table or nil - the library requested
Example:
	local LibMonkey = Rock:GetLibrary("LibMonkey-1.0")
	-- or
	local LibMonkey = Rock("LibMonkey-1.0")
-----------------------------------------------------------------------------]]
function Rock:GetLibrary(major, dontLoad, dontError)
	if type(major) ~= "string" then
		error(("Bad argument #2 to `GetLibrary'. Expected %q, got %q."):format("string", type(major)), 2)
	end
	if dontLoad and dontLoad ~= true then
		error(("Bad argument #3 to `GetLibrary'. Expected %q or %q, got %q."):format("boolean", "nil", type(dontLoad)), 2)
	end
	if dontError and dontError ~= true then
		error(("Bad argument #4 to `GetLibrary'. Expected %q or %q, got %q."):format("boolean", "nil", type(dontError)), 2)
	end
	if not dontLoad then
		TryToLoadStandalone(major)
	end

	local library = GetLibStubLibrary(major)
	if not library then
		if dontError then
			return nil
		end
		error(("Library %q not found."):format(major), 2)
	end

	return library
end

setmetatable(Rock, { __call = Rock.GetLibrary })

--[[---------------------------------------------------------------------------
Arguments:
	string - name of the library.
Returns:
	boolean - whether the library exists and is a proper mixin which can be embedded.
Example:
	local isMixin = Rock:IsLibraryMixin("LibMonkey-1.0")
-----------------------------------------------------------------------------]]
function Rock:IsLibraryMixin(name)
	local library = self:GetLibrary(name, false, true)
	if not library then
		return false
	end
	return not not exportedMethods[library]
end

--[[---------------------------------------------------------------------------
Arguments:
	string - name of the library.
	[optional] boolean - whether to not load a library if it is not found. Default: false
Returns:
	library
	* table or nil - the library requested
Example:
	local hasLibMonkey = Rock:HasLibrary("LibMonkey-1.0")
-----------------------------------------------------------------------------]]
function Rock:HasLibrary(major, dontLoad)
	if type(major) ~= "string" then
		error(("Bad argument #2 to `HasLibrary'. Expected %q, got %q."):format("string", type(major)), 2)
	end
	if dontLoad and dontLoad ~= true then
		error(("Bad argument #3 to `HasLibrary'. Expected %q or %q, got %q."):format("boolean", "nil", type(dontLoad)), 2)
	end
	if not dontLoad then
		TryToLoadStandalone(major)
	end
	return not not GetLibStubLibrary(major)
end

--[[---------------------------------------------------------------------------
Notes:
	* This is exported to all libraries
Returns:
	major, minor
	* string - name of the library
	* number - version of the library
Example:
	local major, minor = Rock:GetLibraryVersion() -- will be "LibRock-1.0", 12345
	local major, minor = LibMonkey:GetLibraryVersion() -- will be "LibMonkey-1.0", 50
-----------------------------------------------------------------------------]]
function Rock:GetLibraryVersion()
	if type(self) ~= "table" then
		return nil, nil
	end
	local major
	local name = self.name
	if name and GetLibStubLibrary(name) == self then
		major = name
	else
		for m, instance in LibStub:IterateLibraries() do
			if instance == self then
				major = m
				break
			end
		end
		if not major then
			return nil, nil
		end
	end
	local _, minor = GetLibStubLibrary(major)
	return major, minor
end

--[[---------------------------------------------------------------------------
Returns:
	an iterator to traverse all registered libraries.
Example:
	for major, library in Rock:IterateLibraries() do
		-- do something with major and library
	end
-----------------------------------------------------------------------------]]
function Rock:IterateLibraries()
	return LibStub:IterateLibraries()
end

--[[---------------------------------------------------------------------------
Notes:
	* This is exported to all libraries
	* Allows you to set precisely what methods for the library to export.
	* This automatically turns a library into a mixin.
Arguments:
	tuple - the list of method names to export.
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0", 50)
	LibMonkey.FlingPoo = function(self)
		return "Splat!"
	end
	LibMonkey:SetExportedMethods("FlingPoo")
	-- later
	local Darwin = Rock:NewAddon("Darwin", "LibMonkey-1.0")
	assert(Darwin:FlingPoo() == "Splat!")
-----------------------------------------------------------------------------]]
function Rock:SetExportedMethods(...)
	if exportedMethods[self] then
		error("Cannot call `SetExportedMethods' more than once.", 2)
	end
	local t = newList(...)
	if #t == 0 then
		error("Must supply at least 1 method to `SetExportedMethods'.", 2)
	end
	for i,v in ipairs(t) do
		if type(self[v]) ~= "function" then
			error(("Bad argument #%d to `SetExportedMethods'. Method %q does not exist."):format(i+1, tostring(v)), 2)
		end
	end
	exportedMethods[self] = t

	local mixinToObject_library = mixinToObject[self]
	if mixinToObject_library then
		for object in pairs(mixinToObject_library) do
			for _,method in ipairs(t) do
				object[method] = self[method]
			end
		end
	end
end

--[[---------------------------------------------------------------------------
Notes:
	* This is exported to all libraries
	* Embeds all the methods previously set to export onto a table.
	* This will call :OnEmbed(object) on the library if it is available.
Arguments:
	table - the table with which to export methods onto.
Returns:
	The table provided, after embedding.
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0", 50)
	LibMonkey.FlingPoo = function(self)
		return "Splat!"
	end
	LibMonkey:SetExportedMethods("FlingPoo")
	-- later
	local Darwin = {}
	Rock("LibMonkey-1.0"):Embed(Darwin)
	assert(Darwin:FlingPoo() == "Splat!")
-----------------------------------------------------------------------------]]
function Rock:Embed(object)
	if not exportedMethods[self]  then
		error(("Cannot call `Embed' for library %q if `SetExportedMethods' has not been called."):format(tostring(self.name)), 2)
	end
	if type(object) ~= "table" then
		error(("Bad argument #2 to `Embed'. Expected %q, got %q."):format("table", type(object)), 2)
	end

	for i,v in ipairs(exportedMethods[self]) do
		if type(self[v]) ~= "function" then
			error(("Problem embedding method %q from library %q. Expected %q, got %q."):format(tostring(v), better_tostring(self), "function", type(self[v])))
		end
		object[v] = self[v]
	end

	if not mixinToObject[self] then
		-- weak because objects come and go
		mixinToObject[self] = setmetatable(newList(), weakKey)
	end
	if mixinToObject[self][object] then
		error(("Cannot embed library %q into the same object %q more than once."):format(better_tostring(self), better_tostring(object)), 2)
	end
	mixinToObject[self][object] = true
	if type(rawget(object, 'mixins')) == "table" then
		object.mixins[self] = true
	end

	local self_OnEmbed = self.OnEmbed
	if self_OnEmbed then
		local success, ret = pcall(self_OnEmbed, self, object)
		if not success then
			geterrorhandler()(ret)
		end
	end

	return object
end

--[[---------------------------------------------------------------------------
Notes:
	* This is exported to all libraries
	* Unembeds all the methods previously set to export onto a table.
	* This will error if the library is not embedded on the object
	* This will call :OnUnembed(object) on the library if it is available.
Arguments:
	table - the table with which to export methods onto.
Returns:
	The table provided, after embedding.
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0", 50)
	LibMonkey.FlingPoo = function(self)
		return "Splat!"
	end
	LibMonkey:SetExportedMethods("FlingPoo")
	-- later
	local Darwin = {}
	Rock("LibMonkey-1.0"):Embed(Darwin)
	assert(Darwin:FlingPoo() == "Splat!")
	Rock("LibMonkey-1.0"):Unembed(Darwin)
	assert(Darwin.FlingPoo == nil)
-----------------------------------------------------------------------------]]
function Rock:Unembed(object)
	if not exportedMethods[self]  then
		error(("Cannot call `Unembed' for library %q if `SetExportedMethods' has not been called."):format(better_tostring(self)), 2)
	end

	if not mixinToObject[self] or not mixinToObject[self][object] then
		error(("Cannot unembed library %q from object %q, since it is not embedded originally."):format(better_tostring(self), better_tostring(object)), 2)
	end
	local mixinToObject_self = mixinToObject[self]
	mixinToObject_self[object] = nil
	if not next(mixinToObject_self) then
		mixinToObject[self] = del(mixinToObject_self)
	end

	local mixin_OnUnembed = self.OnUnembed
	if mixin_OnUnembed then
		local success, ret = pcall(mixin_OnUnembed, self, object)
		if not success then
			geterrorhandler()(ret)
		end
	end

	for i,v in ipairs(exportedMethods[self]) do
		object[v] = nil
	end
end

local function embedAce2Mixin(mixin, object)
	if not mixinToObject[mixin] then
		mixinToObject[mixin] = setmetatable(newList(), weakKey)
	end
	mixinToObject[mixin][object] = true
	mixin:embed(object)
end

local function embedLibStubMixin(mixin, object)
	if not mixinToObject[mixin] then
		mixinToObject[mixin] = setmetatable(newList(), weakKey)
	end
	mixinToObject[mixin][object] = true
	mixin:Embed(object)
end

--[[---------------------------------------------------------------------------
Notes:
	* create a new addon with the specified name.
Arguments:
	string - name of the addon.
	tuple - list of mixins with which to embed into this addon.
Returns:
	addon
	* table - the addon with which to manipulate
Example:
	local MyAddon = Rock:NewAddon("MyAddon", "Mixin-1.0", "OtherMixin-2.0")
-----------------------------------------------------------------------------]]
function Rock:NewAddon(name, ...)
	if type(name) ~= "string" then
		error(("Bad argument #2 to `NewAddon'. Expected %q, got %q"):format("string", type(name)), 2)
	end
	if name:match("^Lib[A-Z]") then
		error(("Bad argument #2 to `NewAddon'. Cannot start with %q, got %q."):format("Lib", name), 2)
	end
	if self == Rock and name:match("_") then
		error(("Bad argument #2 to `NewAddon'. Cannot contain underscores, got %q."):format(name), 2)
	end

	if addons[name] then
		error(("Bad argument #2 to `NewAddon'. Addon %q already created."):format(name), 2)
	end
	local addon = setmetatable(newList(), addon_mt)
	addon.name = name

	local mixinSet = newList()

	for i = 1, select('#', ...) do
		local libName = select(i, ...)
		if mixinSet[libName] then
			error(("Bad argument #%d to `NewAddon'. %q already stated."):format(i+2, tostring(libName)), 2)
		end
		mixinSet[libName] = true
		TryToLoadStandalone(libName)
		local library = Rock:GetLibrary(libName, false, true)
		if not library then
			error(("Bad argument #%d to `NewAddon'. Library %q is not found."):format(i+2, tostring(libName)), 2)
		end
		
		local style = 'rock'

		if not exportedMethods[library] then
			local good = false
			if AceLibrary then
				local AceOO = AceLibrary:HasInstance("AceOO-2.0", false) and AceLibrary("AceOO-2.0")
				if AceOO and AceOO.inherits(library, AceOO.Mixin) then
					good = true
					style = 'ace2'
				end
			end
			if not good and type(rawget(library, 'Embed')) == "function" then
				good = true
				style = 'libstub'
			end
			if not good then
				error(("Bad argument #%d to `NewAddon'. Library %q is not a mixin."):format(i+2, tostring(libName)), 2)
			end
		end

		if library == Rock then
			error(("Bad argument #%d to `NewAddon'. Cannot use %q as a mixin."):format(i+2, tostring(libName)), 2)
		end

		if style == 'rock' then
			library:Embed(addon)
		elseif style == 'ace2' then
			embedAce2Mixin(library, addon)
		elseif style == 'libstub' then
			embedLibStubMixin(library, addon)
		end
	end

	mixinSet = del(mixinSet)

	addons[name] = addon
	pendingAddons[#pendingAddons+1] = addon
	pendingAddonsEnable[#pendingAddonsEnable+1] = addon
	addonToFolder[addon] = figureCurrentAddon(self == Rock and 2 or 4)

	frame:Show()

	return addon
end

--[[---------------------------------------------------------------------------
Arguments:
	string - name of the addon.
Returns:
	addon
	* table or nil - the addon requested
Example:
	local MyAddon = Rock:GetAddon("MyAddon")
-----------------------------------------------------------------------------]]
function Rock:GetAddon(name)
	if type(name) ~= "string" then
		return nil
	end
	local addon = addons[name]
	if addon then
		return addon
	end
	name = name:lower()
	for k, v in pairs(addons) do
		if k:lower() == name then
			return v
		end
	end
	return nil
end

--[[---------------------------------------------------------------------------
Arguments:
	string or table - name of the addon or the addon itself.
Returns:
	boolean - whether the addon requested exists.
Example:
	local hasMyAddon = Rock:HasAddon("MyAddon")
	-- or
	local hasMyAddon = Rock:HasAddon(MyAddon)
-----------------------------------------------------------------------------]]
function Rock:HasAddon(name)
	if type(name) == "string" then
		local addon = addons[name]
		if addon then
			return true
		end
		name = name:lower()
		for k, v in pairs(addons) do
			if k:lower() == name then
				return true
			end
		end
	elseif type(name) == "table" then
		for k,v in pairs(addons) do
			if v == name then
				return true
			end
		end
	end
	return false
end

--[[---------------------------------------------------------------------------
Returns:
	an iterator to traverse all addons created with Rock.
Example:
	for name, addon in Rock:IterateAddons() do
		-- do something with name and addon
	end
-----------------------------------------------------------------------------]]
function Rock:IterateAddons()
	return pairs(addons)
end

--[[---------------------------------------------------------------------------
Arguments:
	string - major version of the mixin library
Returns:
	an iterator to traverse all objects that the given mixin has embedded into
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0")
	local Darwin = Rock:NewAddon("Darwin", "LibMonkey-1.0")
	for object in LibMonkey:IterateMixinObjects("LibMonkey-1.0") do
		assert(object == Darwin)
	end
-----------------------------------------------------------------------------]]
function Rock:IterateMixinObjects(mixinName)
	local mixin
	if type(mixinName) == "table" then
		mixin = mixinName
	else
		if type(mixinName) ~= "string" then
			error(("Bad argument #2 to `IterateMixinObjects'. Expected %q or %q, got %q."):format("table", "string", type(mixinName)), 2)
		end
		mixin = libraries[mixinName]
	end
	local mixinToObject_mixin = mixinToObject[mixin]
	if not mixinToObject_mixin then
		return noop
	end
	return pairs(mixinToObject_mixin)
end

local function iter(object, mixin)
	mixin = next(mixinToObject, mixin)
	if not mixin then
		return nil
	elseif mixinToObject[mixin][object] then
		return mixin
	end
	return iter(object, mixin) -- try next mixin
end
--[[---------------------------------------------------------------------------
Returns:
	an iterator to traverse all mixins that an object has embedded
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0")
	local Darwin = Rock:NewAddon("Darwin", "LibMonkey-1.0")
	for mixin in Rock:IterateObjectMixins(Darwin) do
		assert(mixin == LibMonkey)
	end
-----------------------------------------------------------------------------]]
function Rock:IterateObjectMixins(object)
	if type(object) ~= "table" then
		error(("Bad argument #2 to `IterateObjectMixins'. Expected %q, got %q."):format("table", type(object)), 2)
	end
	return iter, object, nil
end

--[[---------------------------------------------------------------------------
Arguments:
	table - the object to check
	string - the mixin to check
Returns:
	boolean - whether the object has the given mixin embedded into it.
Example:
	local LibMonkey = Rock:NewLibrary("LibMonkey-1.0")
	local Darwin = Rock:NewAddon("Darwin", "LibMonkey-1.0")
	assert(Rock:DoesObjectUseMixin(Darwin, "LibMonkey-1.0"))
-----------------------------------------------------------------------------]]
function Rock:DoesObjectUseMixin(object, mixinName)
	if type(object) ~= "table" then
		error(("Bad argument #2 to `IterateObjectMixins'. Expected %q, got %q."):format("table", type(object)), 2)
	end
	local mixin
	if type(mixinName) == "table" then
		mixin = mixinName
	else
		if type(mixinName) ~= "string" then
			error(("Bad argument #3 to `IterateMiDoesObjectUseMixininObjects'. Expected %q or %q, got %q."):format("table", "string", type(mixinName)), 2)
		end
		mixin = libraries[mixinName]
	end
	if not mixin then
		return false
	end

	local mixinToObject_mixin = mixinToObject[mixin]
	if not mixinToObject_mixin then
		return false
	end
	return not not mixinToObject_mixin[object]
end

Rock.UID_NUM = oldRock and oldRock.UID_NUM or 0
--[[---------------------------------------------------------------------------
Notes:
	* This UID is not unique across sessions. If you save a UID in a saved variable, the same UID can be generated in another session.
Returns:
	number - a unique number.
Example:
	local UID = Rock:GetUID()
-----------------------------------------------------------------------------]]
function Rock:GetUID()
	local num = Rock.UID_NUM + 1
	Rock.UID_NUM = num
	return num
end

local function unobfuscateEmail(email)
	return email:gsub(" AT ", "@"):gsub(" DOT ", ".")
end
local function fix(char)
	return ("%%%02x"):format(char:byte())
end
local function urlencode(text)
	return text:gsub("[^0-9A-Za-z]", fix)
end

local url
local function makeURLFrame()
	makeURLFrame = nil
	local function bumpFrameLevels(frame, amount)
		frame:SetFrameLevel(frame:GetFrameLevel()+amount)
		local children = newList(frame:GetChildren())
		for _,v in ipairs(children) do
			bumpFrameLevels(v, amount)
		end
		children = del(children)
	end
	-- some code borrowed from Prat here
	StaticPopupDialogs["ROCK_SHOW_URL"] = {
		text = not IsMacClient() and L["Press Ctrl-C to copy, then Alt-Tab out of the game, open your favorite web browser, and paste the link into the address bar."] or L["Press Cmd-C to copy, then Cmd-Tab out of the game, open your favorite web browser, and paste the link into the address bar."],
		button2 = ACCEPT,
		hasEditBox = 1,
		hasWideEditBox = 1,
		showAlert = 1, -- HACK : it's the only way I found to make de StaticPopup have sufficient width to show WideEditBox :(

		OnShow = function()
			local editBox = _G[this:GetName() .. "WideEditBox"]
			editBox:SetText(url)
			editBox:SetFocus()
			editBox:HighlightText(0)
			editBox:SetScript("OnTextChanged", function(...) StaticPopup_EditBoxOnTextChanged(...) end)

			local button = _G[this:GetName() .. "Button2"]
			button:ClearAllPoints()
			button:SetWidth(200)
			button:SetPoint("CENTER", editBox, "CENTER", 0, -30)

			_G[this:GetName() .. "AlertIcon"]:Hide()  -- HACK : we hide the false AlertIcon
			this:SetFrameStrata("FULLSCREEN_DIALOG")
			bumpFrameLevels(this, 30)
		end,
		OnHide = function()
			local editBox = _G[this:GetName() .. "WideEditBox"]
			editBox:SetScript("OnTextChanged", nil)
			this:SetFrameStrata("DIALOG")
			bumpFrameLevels(this, -30)
		end,
		OnAccept = function() end,
		OnCancel = function() end,
		EditBoxOnEscapePressed = function() this:GetParent():Hide() end,
		EditBoxOnTextChanged = function()
			this:SetText(url)
			this:SetFocus()
			this:HighlightText(0)
		end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	}
end

function OpenDonationFrame(self)
	if makeURLFrame then
		makeURLFrame()
	end

	local donate = self.donate
	if type(donate) ~= "string" then
		donate = "Wowace"
	end
	local style, data = (":"):split(donate, 2)
	style = style:lower()
	if style ~= "website" and style ~= "paypal" then
		style = "wowace"
	end
	if style == "wowace" then
		url = "http://www.wowace.com/wiki/Donations"
	elseif style == "website" then
		url = data
	else -- PayPal
		local text = "https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=" .. urlencode(unobfuscateEmail(data))
		local name
		if type(self.title) == "string" then
			name = self.title
		elseif type(self.name) == "string" then
			name = self.name
		end
		if name == MAJOR_VERSION then
			name = "Rock"
		end
		if name then
			name = name:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
			text = text .. "&item_name=" .. urlencode(name)
		end
		url = text
	end

	StaticPopup_Show("ROCK_SHOW_URL")
end
function OpenIssueFrame(self)
	if makeURLFrame then
		makeURLFrame()
	end

	local issueTracker = self.issueTracker
	if type(issueTracker) ~= "string" then
		return
	end
	local style, data = (":"):split(issueTracker, 2)
	style = style:lower()
	if style ~= "website" and style ~= "wowace" then
		return
	end
	if style == "wowace" then
		url = "http://jira.wowace.com/secure/CreateIssue.jspa?pid=" .. data
	elseif style == "website" then
		url = data
	end

	StaticPopup_Show("ROCK_SHOW_URL")
end
local function donate_hidden(addon)
	return type(addon.donate) ~= "string"
end

local function issue_hidden(addon)
	return type(addon.issueTracker) ~= "string"
end

-- #NODOC
function Rock:GetRockConfigOptions(addon)
	return 'active', {
		type = 'boolean',
		name = L["Enabled"],
		desc = L["Enable or disable this addon."],
		get = 'IsActive',
		set = 'ToggleActive',
		handler = addon,
		order = -1,
	}, 'donate', {
		type = 'execute',
		name = L["Give donation"],
		buttonText = L["Donate"],
		desc = L["Give a much-needed donation to the author of this addon."],
		func = OpenDonationFrame,
		hidden = donate_hidden,
		passValue = addon,
		order = -2,
	}, 'issue', {
		type = 'execute',
		name = L["File issue"],
		buttonText = L["Report"],
		desc = L["File a bug or request a new feature or an improvement to this addon."],
		func = OpenIssueFrame,
		hidden = issue_hidden,
		passValue = addon,
		order = -3,
	}
end

local function initAddon(addon, name)
	name = addonToFolder[addon] or name or ""
	-- TOC checks
	if addon.title == nil then
		addon.title = GetAddOnMetadata(name, "Title")
	end
	if type(addon.title) == "string" then
		addon.title = addon.title:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("%-Rock%-$", ""):trim()
	end
	if addon.notes == nil then
		addon.notes = GetAddOnMetadata(name, "Notes")
	end
	if type(addon.notes) == "string" then
		addon.notes = addon.notes:trim()
	end
	if addon.version == nil then
		addon.version = GetAddOnMetadata(name, "Version")
	end
	if type(addon.version) == "string" then
		addon.version = addon.version:trim()
	end
	if addon.author == nil then
		addon.author = GetAddOnMetadata(name, "Author")
	end
	if type(addon.author) == "string" then
		addon.author = addon.author:trim()
	end
	if addon.credits == nil then
		addon.credits = GetAddOnMetadata(name, "X-Credits")
	end
	if type(addon.credits) == "string" then
		addon.credits = addon.credits:trim()
	end
	if addon.donate == nil then
		addon.donate = GetAddOnMetadata(name, "X-Donate")
	end
	if type(addon.donate) == "string" then
		addon.donate = addon.donate:trim()
	end
	if addon.issueTracker == nil then
		addon.issueTracker = GetAddOnMetadata(name, "X-IssueTracker")
	end
	if type(addon.issueTracker) == "string" then
		addon.issueTracker = addon.issueTracker:trim()
	end
	if addon.category == nil then
		addon.category = GetAddOnMetadata(name, "X-Category")
	end
	if type(addon.category) == "string" then
		addon.category = addon.category:trim()
	end
	if addon.email == nil then
		addon.email = GetAddOnMetadata(name, "X-eMail") or GetAddOnMetadata(name, "X-Email")
	end
	if type(addon.email) == "string" then
		addon.email = addon.email:trim()
	end
	if addon.license == nil then
		addon.license = GetAddOnMetadata(name, "X-License")
	end
	if type(addon.license) == "string" then
		addon.license = addon.license:trim()
	end
	if addon.website == nil then
		addon.website = GetAddOnMetadata(name, "X-Website")
	end
	if type(addon.website) == "string" then
		addon.website = addon.website:trim()
	end

	for mixin in Rock:IterateObjectMixins(addon) do
		local mixin_OnEmbedInitialize = mixin.OnEmbedInitialize
		if mixin_OnEmbedInitialize then
			local success, ret = pcall(mixin_OnEmbedInitialize, mixin, addon)
			if not success then
				geterrorhandler()(ret)
			end
		end
	end

	local addon_OnInitialize = addon.OnInitialize
	if addon_OnInitialize then
		local success, ret = pcall(addon_OnInitialize, addon)
		if not success then
			geterrorhandler()(ret)
		end
	end

	if LibRockEvent then
		Rock:DispatchEvent("AddonInitialized", addon)
	end
end


local function manualEnable(addon)
	for i,v in ipairs(pendingAddons) do
		if v == addon then
			return
		end
	end
	if currentlyEnabledAddons[addon] then
		return false
	end
	currentlyEnabledAddons[addon] = true

	local first = not addonsAlreadyEnabled[addon]
	addonsAlreadyEnabled[addon] = true

	for mixin in Rock:IterateObjectMixins(addon) do
		local mixin_OnEmbedEnable = mixin.OnEmbedEnable
		if mixin_OnEmbedEnable then
			local success, ret = pcall(mixin_OnEmbedEnable, mixin, addon, first)
			if not success then
				geterrorhandler()(ret)
			end
		end
	end
	local addon_OnEnable = addon.OnEnable
	if addon_OnEnable then
		local success, ret = pcall(addon_OnEnable, addon, first)
		if not success then
			geterrorhandler()(ret)
		end
	end

	if LibRockEvent then
		Rock:DispatchEvent("AddonEnabled", addon, first)
	end

	return true, first
end

local function manualDisable(addon)
	if not currentlyEnabledAddons[addon] then
		return false
	end
	currentlyEnabledAddons[addon] = nil

	for mixin in Rock:IterateObjectMixins(addon) do
		local mixin_OnEmbedDisable = mixin.OnEmbedDisable
		if mixin_OnEmbedDisable then
			local success, ret = pcall(mixin_OnEmbedDisable, mixin, addon)
			if not success then
				geterrorhandler()(ret)
			end
		end
	end
	local addon_OnDisable = addon.OnDisable
	if addon_OnDisable then
		local success, ret = pcall(addon_OnDisable, addon)
		if not success then
			geterrorhandler()(ret)
		end
	end

	if LibRockEvent then
		Rock:DispatchEvent("AddonDisabled", addon)
	end
	return true
end

local function enableAddon(addon)
	for i,v in ipairs(pendingAddons) do
		if v == addon then
			return
		end
	end
	if addon_mt___index.IsActive(addon) then
		manualEnable(addon)
	end
end

-- #NODOC
-- This is used by internal Rock libraries after updating the active state.
function Rock:RecheckEnabledStates()
	local changed = false
	for _,addon in pairs(addons) do
		local good = true
		for _,a in ipairs(pendingAddonsEnable) do
			if addon == a then
				good = false
				break
			end
		end
		if good then
			if addon_mt___index.IsActive(addon) then
				if manualEnable(addon) then
					changed = true
				end
			else
				if manualDisable(addon) then
					changed = true
				end
			end
		end
	end
	if changed then
		return self:RecheckEnabledStates()
	end
end

frame:UnregisterAllEvents()
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
local function runMainAddonLoadedChunk(name)
	local tmp = newList()
	tmp, pendingAddons = pendingAddons, tmp
	for i, addon in ipairs(tmp) do
		local folder = addonToFolder[addon]
		if name and folder and not foldersLoaded[folder] then
			for j = i, #tmp do
				pendingAddons[#pendingAddons+1] = tmp[j]
				tmp[j] = nil
			end
			break
		end
		initAddon(addon, name)
	end

	if IsLoggedIn() then
		for i, addon in ipairs(tmp) do
			for j, v in ipairs(pendingAddonsEnable) do
				if v == addon then
					table_remove(pendingAddonsEnable, i)
					break
				end
			end
			enableAddon(addon)
		end
		for i, addon in ipairs(pendingAddonsEnable) do
			local good = true
			for j, v in ipairs(pendingAddons) do
				if v == addon then
					good = false
					break
				end
			end
			if not good then
				break
			end
			pendingAddonsEnable[i] = nil
			enableAddon(addon)
		end
	end
	tmp = del(tmp)
	for library, addonName in pairs(pendingLibraries) do
		if not name or foldersLoaded[addonName] then
			local success, ret = pcall(error, ("Library %q not finalized before ADDON_LOADED."):format(better_tostring(library)), 3)
			geterrorhandler()(ret)
			Rock:FinalizeLibrary((library:GetLibraryVersion()))
		end
	end

	if isStandalone then
		local LibRock_1_0DB = _G.LibRock_1_0DB
		if type(LibRock_1_0DB) ~= "table" then
			LibRock_1_0DB = {}
			_G.LibRock_1_0DB = LibRock_1_0DB
		end
		if type(LibRock_1_0DB.unitTests) ~= "table" then
			LibRock_1_0DB.unitTests = {}
		end
		enableContracts = LibRock_1_0DB.contracts or false
		unitTestDB = LibRock_1_0DB.unitTests
		for namespace, data in pairs(unitTests) do
			if not unitTestDB[namespace] then
				if data then
					del(data)
					unitTests[namespace] = false
				end
			elseif data and (not name or data.addon == name) then
				local stats = newList()
				for i,v in ipairs(data) do
					data[i] = nil

					local libs = newList()
					for k,v in pairs(libraries) do
						libs[k] = v
					end

					local success, ret = pcall(v)
					if not success then
						geterrorhandler()(ret)
						stats[i] = ret
					else
						stats[i] = false
					end

					for k in pairs(libraries) do
						if not libs[k] then
							__removeLibrary(k)
						end
					end
					libs = del(libs)
				end
				del(data)
				unitTests[namespace] = false
				if #stats >= 1 then
					local pass, fail = 0, 0
					for i,v in ipairs(stats) do
						if v then
							fail = fail + 1
						else
							pass = pass + 1
						end
					end

					local color
					if fail == 0 then
						_G.DEFAULT_CHAT_FRAME:AddMessage(("|cff00ff00%s: %d unit test(s) passed."):format(namespace, pass))
					elseif pass > 0 then
						_G.DEFAULT_CHAT_FRAME:AddMessage(("|cffff0000%s: %d unit test(s) passed, %d unit test(s) failed."):format(namespace, pass, fail))
					else
						_G.DEFAULT_CHAT_FRAME:AddMessage(("|cffff0000%s: %d unit test(s) failed."):format(namespace, fail))
					end
					for i,v in ipairs(stats) do
						if v then
							_G.DEFAULT_CHAT_FRAME:AddMessage(("|cffff0000%s|r"):format(tostring(v)))
						end
					end
					if fail > 0 then
						_G.DEFAULT_CHAT_FRAME:AddMessage("|cffff0000----------|r")
					end
				end
				stats = del(stats)
			end
		end
	end
	if isStandalone and name == MAJOR_VERSION then
		Rock("LibRockEvent-1.0", false, true) -- load if possible
		Rock("LibRockConsole-1.0", false, true) -- load if possible - I like the default chat commands
		Rock("LibRockComm-1.0", false, true) -- load if possible - has version checking and the like
		Rock("LibRockConfig-1.0", false, true) -- load if possible - LibRock-1.0 registers with it.
	end

	for major, library in LibStub:IterateLibraries() do
		manualFinalize(major, library)
	end

end

frame:Show()
frame:SetScript("OnUpdate", function(this, elapsed)
	-- capture all un-initialized addons.
	runMainAddonLoadedChunk()
	this:SetScript("OnUpdate", nil)
end)
frame:SetScript("OnEvent", function(this, event, ...)
	if event == "ADDON_LOADED" then
		-- this creates a new table and flushes the old in case someone LoDs an addon inside ADDON_LOADED.
		local name = ...
		foldersLoaded[name] = true
		runMainAddonLoadedChunk(name)
		frame:Show()
	elseif event == "PLAYER_LOGIN" then
		for i, addon in ipairs(pendingAddonsEnable) do
			local good = true
			for _, a in ipairs(pendingAddons) do
				if a == addon then
					good = false
					break
				end
			end
			if good then
				pendingAddonsEnable[i] = nil
				enableAddon(addon)
			end
		end
	end
end)

Rock:SetExportedMethods("SetExportedMethods", "Embed", "Unembed", "GetLibraryVersion")

Rock:FinalizeLibrary(MAJOR_VERSION)

for major, library in LibStub:IterateLibraries() do
	manualFinalize(major, library)
end

Rock:AddUnitTest(MAJOR_VERSION, function()
	-- test recycling
	local newList, newDict, newSet, del = Rock:GetRecyclingFunctions(MAJOR_VERSION .. "_UnitTest", "newList", "newDict", "newSet", "del", "Debug")
	local t = newList("Alpha", "Bravo", "Charlie")
	assert(t[1] == "Alpha")
	assert(t[2] == "Bravo")
	assert(t[3] == "Charlie")
	t = del(t)
	t = newList("Alpha", "Bravo", "Charlie")
	-- check recycled table
	assert(t[1] == "Alpha")
	assert(t[2] == "Bravo")
	assert(t[3] == "Charlie")
	t = del(t)
	t = newDict("Alpha", "Bravo", "Charlie", "Delta")
	assert(t.Alpha == "Bravo")
	assert(t.Charlie == "Delta")
	t = del(t)
	t = newSet("Alpha", "Bravo", "Charlie")
	assert(t.Alpha)
	assert(t.Bravo)
	assert(t.Charlie)
	t = del(t)

	local debug = recycleData.debugPools[MAJOR_VERSION .. "_UnitTest"]
	assert(debug.num == 0)
	t = newList()
	assert(debug.num == 1)
	t[1] = newList()
	assert(debug.num == 2)
	t[2] = newList()
	assert(debug.num == 3)
	t[1] = del(t[1])
	assert(debug.num == 2)
	t[2] = del(t[2])
	assert(debug.num == 1)
	t = del(t)
	assert(debug.num == 0)
end)

Rock:AddUnitTest(MAJOR_VERSION, function()
	-- test :GetUID()
	local t = {}
	for i = 1, 10000 do
		local uid = Rock:GetUID()
		if t[i] then
			error(("UID match for iteration %d, UID %s"):format(i, uid))
		end
		t[i] = true
	end
end)

Rock:AddUnitTest(MAJOR_VERSION, function()
	-- test basic creation and deletion
	assert(not LibStub:GetLibrary("LibRockFakeLib-1.0", true))
	assert(not Rock:HasLibrary("LibRockFakeLib-1.0"))
	local lib = Rock:NewLibrary("LibRockFakeLib-1.0", 1)
	Rock:FinalizeLibrary("LibRockFakeLib-1.0")
	lib = nil
	assert(LibStub:GetLibrary("LibRockFakeLib-1.0", true))
	assert(Rock:HasLibrary("LibRockFakeLib-1.0"))
	local good = false
	for _, lib in pairs(libraries) do
		if lib.name == "LibRockFakeLib-1.0" then
			good = true
			break
		end
	end
	assert(good)
	__removeLibrary("LibRockFakeLib-1.0")
	for _, lib in pairs(libraries) do
		assert(lib.name ~= "LibRockFakeLib-1.0")
	end
	assert(not LibStub:GetLibrary("LibRockFakeLib-1.0", true))
	assert(not Rock:HasLibrary("LibRockFakeLib-1.0"))
end)

Rock:AddUnitTest(MAJOR_VERSION, function()
	-- test library creation and the like
	assert(not Rock:HasLibrary("LibRockFakeLib-1.0"))
	for name in Rock:IterateLibraries() do
		assert(name ~= "LibRockFakeLib-1.0")
	end

	local myLib, oldLib = Rock:NewLibrary("LibRockFakeLib-1.0", 1)
	assert(myLib)
	assert(myLib.name == "LibRockFakeLib-1.0")
	assert(not oldLib)

	assert(myLib:GetLibraryVersion() == "LibRockFakeLib-1.0")
	assert(select(2, myLib:GetLibraryVersion()) == 1)

	local good = false
	for name in Rock:IterateLibraries() do
		if name == "LibRockFakeLib-1.0" then
			good = true
			break
		end
	end
	assert(good)
	assert(Rock:HasLibrary("LibRockFakeLib-1.0"))
	assert(Rock:GetLibrary("LibRockFakeLib-1.0") == myLib)
	assert(Rock("LibRockFakeLib-1.0") == myLib)

	assert(not Rock:IsLibraryMixin("LibRockFakeLib-1.0"))
	function myLib:DoSomething()
		return "Something"
	end
	myLib:SetExportedMethods("DoSomething")
	assert(Rock:IsLibraryMixin("LibRockFakeLib-1.0"))
	local t = {}
	assert(not Rock:DoesObjectUseMixin(t, "LibRockFakeLib-1.0"))
	assert(not t.DoSomething)
	for mixin in Rock:IterateObjectMixins(t) do
		assert(false)
	end
	for object in Rock:IterateMixinObjects("LibRockFakeLib-1.0") do
		assert(false)
	end
	myLib:Embed(t)
	assert(t:DoSomething() == "Something")
	assert(Rock:DoesObjectUseMixin(t, "LibRockFakeLib-1.0"))
	for mixin in Rock:IterateObjectMixins(t) do
		assert(mixin == myLib)
	end
	for object in Rock:IterateMixinObjects("LibRockFakeLib-1.0") do
		assert(object == t)
	end

	Rock:FinalizeLibrary("LibRockFakeLib-1.0")

	local myNewLib, oldLib = Rock:NewLibrary("LibRockFakeLib-1.0", 2)
	assert(myNewLib == myLib)
	assert(oldLib)
	assert(Rock:GetLibrary("LibRockFakeLib-1.0") == myLib)

	function myLib:DoSomething()
		return "Something else"
	end
	function myLib:TrySomething()
		return "Blah"
	end
	myLib:SetExportedMethods("DoSomething", "TrySomething")
	assert(Rock:IsLibraryMixin("LibRockFakeLib-1.0"))
	assert(t:DoSomething() == "Something else")
	assert(t:TrySomething() == "Blah")
	assert(Rock:DoesObjectUseMixin(t, "LibRockFakeLib-1.0"))
	for mixin in Rock:IterateObjectMixins(t) do
		assert(mixin == myLib)
	end
	for object in Rock:IterateMixinObjects("LibRockFakeLib-1.0") do
		assert(object == t)
	end

	Rock:FinalizeLibrary("LibRockFakeLib-1.0")

	local myNewLib, oldLib = Rock:NewLibrary("LibRockFakeLib-1.0", 3)
	assert(myNewLib == myLib)
	assert(oldLib)
	assert(Rock:GetLibrary("LibRockFakeLib-1.0") == myLib)

	function myLib:DoSomething()
		return "Something"
	end
	myLib:SetExportedMethods("DoSomething")
	assert(Rock:IsLibraryMixin("LibRockFakeLib-1.0"))
	assert(t:DoSomething() == "Something")
	assert(t.TrySomething == nil)
	assert(Rock:DoesObjectUseMixin(t, "LibRockFakeLib-1.0"))
	for mixin in Rock:IterateObjectMixins(t) do
		assert(mixin == myLib)
	end
	for object in Rock:IterateMixinObjects("LibRockFakeLib-1.0") do
		assert(object == t)
	end

	Rock:FinalizeLibrary("LibRockFakeLib-1.0")

	assert(not Rock:NewLibrary("LibRockFakeLib-1.0", 2)) -- out of date
	assert(not Rock:NewLibrary("LibRockFakeLib-1.0", 3)) -- same revision
end)

Rock:AddUnitTest(MAJOR_VERSION, function()
	assert(not Rock:HasAddon("RockFakeAddon"))
	for name in Rock:IterateAddons() do
		assert(name ~= "RockFakeAddon")
	end

	local myAddon = Rock:NewAddon("RockFakeAddon")

	assert(myAddon)
	assert(myAddon.name == "RockFakeAddon")

	local good = false
	for name in Rock:IterateAddons() do
		if name == "RockFakeAddon" then
			good = true
			break
		end
	end
	assert(good)
	assert(Rock:HasAddon("RockFakeAddon"))
	assert(Rock:GetAddon("RockFakeAddon") == myAddon)
end)

Rock:AddUnitTest(MAJOR_VERSION, function()
	-- test :OnLibraryLoad
	local lib = Rock:NewLibrary("LibRockFakeLib-1.0", 1)
	local triggered = false
	function lib:OnLibraryLoad(major, instance)
		if major == "LibRockFakeLib-2.0" then
			triggered = true
		end
	end
	Rock:FinalizeLibrary("LibRockFakeLib-1.0")

	local lib = Rock:NewLibrary("LibRockFakeLib-2.0", 1)
	assert(not triggered)
	Rock:FinalizeLibrary("LibRockFakeLib-2.0")
	assert(triggered)
	triggered = false
	local lib = Rock:NewLibrary("LibRockFakeLib-2.0", 2)
	assert(not triggered)
	Rock:FinalizeLibrary("LibRockFakeLib-2.0")
	assert(not triggered)
end)
