
local RecountString ={}
local DBMString ={}
local GridString ={}
local Ora2String ={}
local DecursiveString ={}
local ThreatString ={}
local RaString ={}

RecountString.colorText = "(|cff808080Recount|r)"
DBMString.colorText = "(|cff808080DBM|r)"
GridString.colorText = "(|cff808080Grid|r)"
Ora2String.colorText = "(|cff808080oRA2|r)"
DecursiveString.colorText = "(|cff808080Decursive|r)"
ThreatString.colorText = "(|cff808080Omen3|r)"
RaString.colorText = "(|cff808080RaidAlerter|r)"

local OPEN
if (GetLocale() == "zhCN") then
	RAID_TOOLKIT_TITLE = {"团队工具", "tuanduigongju",2};
	
	OPEN = "开启"
	
	RecountString.Name = "伤害统计";
	DBMString.Name = "首领报警 ";
	GridString.Name = "团队框架 ";
	Ora2String.Name = "团队助手 ";
	DecursiveString.Name = "一键驱散";
	ThreatString.Name = "仇恨统计 ";
	RaString.Name = "团队报警 ";
	
	DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<首领报警>|r 你已经关闭首领报警(DBM)模块，该设置将在下次插件载入时生效。";
	GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<团队框架>|r 你已经关闭团队框架(Grid)模块，该设置将在下次插件载入时生效。";
	ORA2_DISABLE_DELAY_TEXT = "|cff00c0c0<团队助手>|r 你已经关闭团队助手(oRA2)模块，该设置将在下次插件载入时生效。";
	DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<一键驱散>|r 你已经关闭一键驱散(Decursive)模块，该设置将在下次插件载入时生效。";
	RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<伤害统计>|r 你已经关闭伤害统计(Recount)模块，该设置将在下次插件载入时生效。";
	THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<仇恨统计>|r 你已经关闭仇恨统计(Omen3)模块，该设置将在下次插件载入时生效。";
	RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<团队报警>|r 你已经关闭团队报警(RaidAlerter)模块，该设置将在下次插件载入时生效。";
	GRID_RAID_ICON_CONFIG = "团队标记配置"
elseif (GetLocale() == "zhTW") then
	RAID_TOOLKIT_TITLE = {"團隊工具", "tuanduigongju",2};

	OPEN = "開啟"
	
	RecountString.Name = "傷害統計";
	DBMString.Name = "首領報警 ";
	GridString.Name = "團隊框架 ";
	Ora2String.Name = "團隊助手 ";
	DecursiveString.Name = "一鍵驅散";
	ThreatString.Name = "仇恨統計 ";
	RaString.Name = "團隊報警 ";

	DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<首領報警>|r 你已經關閉首領報警(DBM)模組，該設置將在下次外掛程式載入時生效。";
	GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊框架>|r 你已經關閉團隊框架(Grid)模組，該設置將在下次外掛程式載入時生效。";
	ORA2_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊助手>|r 你已經關閉團隊助手(oRA2)模組，該設置將在下次外掛程式載入時生效。";
	DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<一鍵驅散>|r 你已經關閉一鍵驅散(Decursive)模組，該設置將在下次外掛程式載入時生效。";
	RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<傷害統計>|r 你已經關閉傷害統計(Recount)模組，該設置將在下次外掛程式載入時生效。";
	THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<仇恨統計>|r 你已經關閉仇恨統計(Omen3)模組，該設置將在下次外掛程式載入時生效。";
	RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<團隊報警>|r 你已經關閉團隊報警(RaidAlerter)模組，該設置將在下次外掛程式載入時生效。";
	
else
	RAID_TOOLKIT_TITLE = "Raid Toolkit";

	OPEN = "Enable"

	DBM_DISABLE_DELAY_TEXT = "|cff00c0c0<DBM>|r DBM has been disabled. This setting will be available next time.";
	GRID_DISABLE_DELAY_TEXT = "|cff00c0c0<Grid>|r Grid has been disabled. This setting will be available next time.";
	ORA2_DISABLE_DELAY_TEXT = "|cff00c0c0<oRA2>|r oRA2 has been disabled. This setting will be available next time.";
	DECURSIVE_DISABLE_DELAY_TEXT = "|cff00c0c0<Descursive>|r Descursive has been disabled. This setting will be available next time.";
	RECOUNT_DISABLE_DELAY_TEXT = "|cff00c0c0<Recount>|r Recount has been disabled. This setting will be available next time.";
	THREAT_DISABLE_DELAY_TEXT = "|cff00c0c0<Omen3>|r Omen3 has been disabled. This setting will be available next time.";
	RAIDALERT_DISABLE_DELAY_TEXT = "|cff00c0c0<RaidAlerter>|r RaidAlerter has been disabled. This setting will be available next time.";
end

RECOUNT_ENABLE_TEXT = OPEN..(RecountString.Name or "")..RecountString.colorText;
DBM_ENABLE_TEXT = OPEN..(DBMString.Name or "")..DBMString.colorText;
GRID_ENABLE_TEXT = OPEN..(GridString.Name or "")..GridString.colorText;
ORA2_ENABLE_TEXT = OPEN..(Ora2String.Name or "")..Ora2String.colorText;
DECURSIVE_ENABLE_TEXT = OPEN..(DecursiveString.Name or "")..DecursiveString.colorText;
THREAT_ENABLE_TEXT = OPEN..(ThreatString.Name or "")..ThreatString.colorText;
RAIDALERT_ENABLE_TEXT = OPEN..(RaString.Name or "")..RaString.colorText;

if ( IsConfigurableAddOn("Recount") or IsConfigurableAddOn("DBM_API") or IsConfigurableAddOn("Omen") or IsConfigurableAddOn("Grid") or IsConfigurableAddOn("oRA2") or IsConfigurableAddOn("RaidAlerter")) then
	ModManagement_RegisterMod(
		"RaidToolkit",
		"Interface\\Icons\\INV_Bijou_Orange",
		RAID_TOOLKIT_TITLE,
		nil,
		nil,
		nil,
		{[4]=true},
		true,
		"236"
	);
end


if (IsConfigurableAddOn("Recount")) then

	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		RECOUNT_ENABLE_TEXT,
		nil,
		"EnableRecount",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("Recount")) then
					BigFoot_LoadAddOn("Recount");
				end
				if (not BigFoot_IsAddOnLoaded("RecountFailBot")) then
					BigFoot_LoadAddOn("RecountFailBot");
				end
				if (not BigFoot_IsAddOnLoaded("RecountGuessedAbsorbs")) then
					BigFoot_LoadAddOn("RecountGuessedAbsorbs");
				end
				if (not BigFoot_IsAddOnLoaded("RecountThreat")) then
					BigFoot_LoadAddOn("RecountThreat");
				end
				if (not BigFoot_IsAddOnLoaded("RecountDeathTrack")) then
					BigFoot_LoadAddOn("RecountDeathTrack");
				end
				if (not BigFoot_IsAddOnLoaded("RecountHealAndGuessedAbsorbs")) then
					BigFoot_LoadAddOn("RecountHealAndGuessedAbsorbs");
				end

			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Recount")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(RECOUNT_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		RecountString.Name or RecountString.colorText 
	);
	
end

if (IsConfigurableAddOn("DBM-Core")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		DBM_ENABLE_TEXT,
		nil,
		"EnableDBM",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("DBM-Core")) then
					BigFoot_LoadAddOn("DBM-Core");
					BigFoot_DelayCall(function() if DBM then DBM.Options.SettingsMessageShown = true end end,5)
				end
				if (not BigFoot_IsAddOnLoaded("DBM-SpellTimers")) then
					BigFoot_LoadAddOn("DBM-SpellTimers");
				end

			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("DBM-Core")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(DBM_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		DBMString.Name or DBMString.colorText 

	);
end

if (IsConfigurableAddOn("Grid")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		GRID_ENABLE_TEXT,
		nil,
		"EnableGrid",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("Grid")) then
					BigFoot_LoadAddOn("Grid");
				end

				if (BigFoot_IsAddOnLoaded("Grid")) then
					Grid:Enable()
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Grid")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(GRID_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		GridString.Name or GridString.colorText 

	);
	if GetLocale()=='zhCN' then
		ModManagement_RegisterButton(
			"RaidToolkit",
			GRID_RAID_ICON_CONFIG,
			function()
				if BigFoot_IsAddOnLoaded("Grid") and BigFoot_IsAddOnLoaded("GridStatusRaidIconMod") then
					HideUIPanel(ModManagementFrame);
					GridStatus_OpenRaidPanel()
				end
			end,
			nil,
			1
		);
	end
end

if (IsConfigurableAddOn("oRA2")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		ORA2_ENABLE_TEXT,
		nil,
		"EnableoRA2",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("oRA2")) then
					BigFoot_LoadAddOn("oRA2");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("oRA2")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(ORA2_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
	
		Ora2String.Name or Ora2String.colorText 

	);
end

if (IsConfigurableAddOn("Decursive")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		DECURSIVE_ENABLE_TEXT,
		nil,
		"EnableDecursive",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("Decursive")) then
					BigFoot_LoadAddOn("Decursive");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Decursive")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(DECURSIVE_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		DecursiveString.Name or DecursiveString.colorText 

	);
end

if (IsConfigurableAddOn("Omen")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		THREAT_ENABLE_TEXT,
		nil,
		"EnableThreat",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("Omen")) then
					BigFoot_LoadAddOn("Omen");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("Omen")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(THREAT_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		ThreatString.Name or ThreatString.colorText 
	
	);
end

if (IsConfigurableAddOn("RaidAlerter")) then
	ModManagement_RegisterCheckBox(
		"RaidToolkit",
		RAIDALERT_ENABLE_TEXT,
		nil,
		"EnableRaidAlerter",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("RaidAlerter")) then
					BigFoot_LoadAddOn("RaidAlerter");
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("RaidAlerter")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(RAIDALERT_DISABLE_DELAY_TEXT); end);
				end
			end
		end,
		nil,
		nil,
		RaString.Name or RaString.colorText 
		
	);
end