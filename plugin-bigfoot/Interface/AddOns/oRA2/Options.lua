assert(oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOptions")
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0") or nil
local dew = AceLibrary("Dewdrop-2.0")
local icon = LibStub("LibDBIcon-1.0", true)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	-- Don't update translations for this yet, guys.
	tablethint = "|cffeda55fCtrl-Alt-Click|r to disable oRA. |cffeda55fAlt-Drag|r to move windows.",
	tablethint_disabled = "|cffeda55fClick|r to enable.",
	["oRA is currently disabled."] = true,
	["oRA Options"] = true,
	["Hidden"] = true,
	["Shown"] = true,
	["Minimap"] = true,
	["Toggle the minimap button."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	tablethint = "oRA 환경설정을 열려면 |cffeda55fSHIFT-클릭|r하세요. oRA를 사용하지 않으려면 |cffeda55fCTRL-ALT-클릭|r하세요. 메인탱커와 플레이어탱커, 각종 현황창을 이동하려면 |cffeda55fALT-드래그|r하세요.",
	tablethint_disabled = "|cffeda55f클릭시|r 사용합니다.",
	["oRA is currently disabled."] = "oRA 는 현재 사용중지 중입니다.",
	["oRA Options"] = "oRA 설정",
	["Hidden"] = "숨김",
	["Shown"] = "표시",
	["Minimap"] = "미니맵",
	["Toggle the minimap button."] = "미니맵 버튼 표시를 선택합니다.",
} end)


L:RegisterTranslations("zhCN", function() return {
	tablethint = "|cffeda55fCtrl-Alt-点击|r 来关闭 oRA。|cffeda55f按住 Alt-拖动|r来移动 MT、PT 和监视框架。",
	tablethint_disabled = "|cffeda55f点击|r 激活。",
	["oRA is currently disabled."] = "oRA 目前已关闭。",
	["oRA Options"] = "oRA 选项",
	["Hidden"] = "隐藏",
	["Shown"] = "显示",
	["Minimap"] = "小地图",
	["Toggle the minimap button."] = "显示小地图图标。",
} end)

L:RegisterTranslations("zhTW", function() return {
	tablethint = "|cffeda55fCtrl-Alt-點擊|r 可關閉 oRA。 |cffeda55fAlt-拖曳|r 可移動 MT、PT 及監視框架。",
	tablethint_disabled = "oRA 目前已關閉。|cffeda55f點擊|r可啟動 oRA。",
	["oRA is currently disabled."] = "oRA 目前已關閉",
	["oRA Options"] = "oRA 選項",
	["Hidden"] = "隱藏",
	["Shown"] = "顯示",
	["Minimap"] = "小地圖",
	["Toggle the minimap button."] = "顯示小地圖按鈕",
} end)

L:RegisterTranslations("frFR", function() return {
	tablethint = "|cffeda55fShift-Clic|r pour configurer oRA. |cffeda55fCtrl-Alt-Clic|r pour désactiver complètement oRA. Maintenez la touche Alt enfoncée pour déplacer les cadres des MTs & des PTs ainsi que les moniteurs.",
	tablethint_disabled = "|cffeda55fCliquez|r pour l'activer.",
	["oRA is currently disabled."] = "oRA est actuellement désactivé.",
	["oRA Options"] = "Options concernant oRA.",
	["Hidden"] = "Masqué",
	["Shown"] = "Affiché",
	["Minimap"] = "Minicarte",
	["Toggle the minimap button."] = "Affiche ou non le bouton de la minicarte.",
} end)

L:RegisterTranslations("deDE", function() return {
	tablethint = "|cffeda55fShift+Klicken|r um die oRA Konfiguration zu öffnen. |cffeda55fStrg+Alt+Klicken|r um oRA zu deaktivieren. |cffeda55fAlt+Drag|r zum verschieben der MT, PT und Fenster.",
	tablethint_disabled = "|cffeda55fKlicken|r um oRA zu aktivieren.",
	["oRA is currently disabled."] = "oRA ist deaktiviert.",
	["oRA Options"] = "oRA Optionen",
	["Hidden"] = "Ausblenden",
	["Shown"] = "Anzeigen",
	["Minimap"] = "Minikarte",
	["Toggle the minimap button."] = "Minikarten Button ein-/ausblenden.",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	tablethint = "|cffeda55fShift-Клик|r открывает oRA Настройки. |cffeda55fCtrl-Alt-Click|r выключает oRA полностью. |cffeda55fAlt-Тащить|r перемещение ГТ,ВТ мониторов.",
	tablethint_disabled = "|cffeda55fClick|r для включения.",
	["oRA is currently disabled."] = "oRA отключен.",
	["oRA Options"] = "Oпции oRA",
	["Hidden"] = "Скрыть",
	["Shown"] = "Показать",
	["Minimap"] = "Мини-карта",
	["Toggle the minimap button."] = "Вкл/Выкл отображение значка у мини-карты.",
} end)

----------------------------
--      LDB Plugin        --
----------------------------

local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("oRA2", {
	type = "launcher",
	text = "oRA2",
	icon = "Interface\\AddOns\\oRA2\\Icons\\core_enabled",
})
local mod = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")

-----------------------------
--      Icon Handling      --
-----------------------------

function mod:OnInitialize()
	if waterfall then
		waterfall:Register("oRA2", "aceOptions", oRA.consoleOptions, "colorR", .6, "colorG", .5, "colorB", .8)
	end
	if icon then
		icon:Register("oRA2", ldb, oRA.db.profile.minimap)
	end
end

function mod:OnEnable()
	self:RegisterEvent("oRA_CoreEnabled", "CoreState")
	self:RegisterEvent("oRA_CoreDisabled", "CoreState")

	self:CoreState()
end

function mod:CoreState()
	if oRA:IsActive() then
		ldb.icon = "Interface\\AddOns\\oRA2\\Icons\\core_enabled"
	else
		ldb.icon = "Interface\\AddOns\\oRA2\\Icons\\core_disabled"
	end
end

-----------------------------
--      FuBar Methods      --
-----------------------------

function ldb.OnTooltipShow(tt)
	tt:AddLine("oRA2")
	if oRA:IsActive() then
		for n, m in oRA:IterateModules() do
			if m.OnTooltipUpdate and oRA:IsModuleActive(m) then
				m:OnTooltipUpdate(tt)
			end
		end
		tt:AddLine(L["tablethint"], 0.2, 1, 0.2, true)
	else
		tt:AddLine(L["tablethint_disabled"], 0.2, 1, 0.2, true)
	end
end

function ldb.OnClick(self, button)
	if button == "RightButton" then
		dew:Open(self, "children", function()
			dew:FeedAceOptionsTable(oRA.consoleOptions)
		end)
	else
		if oRA:IsActive() then
			if IsControlKeyDown() and IsAltKeyDown() then
				oRA:ToggleActive(false)
			elseif IsShiftKeyDown() and waterfall then
				waterfall:Open("oRA2")
			end
		else
			oRA:ToggleActive(true)
		end
	end
end

