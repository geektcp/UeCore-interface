local SPELL_MONITOR;
local SPELL_TRIGGER_ENABLE;
local EVENTALERT_TIPS;
local SPELL_TD_ENABLE;

if (GetLocale() == "zhCN") then
	SPELL_MONITOR = {"技能触发", "jinengchufa"};
	SPELL_TRIGGER_ENABLE = "启用技能触发监控";
	EVENTALERT_TIPS = "启用法术书ID提示";
	SPELL_TRIGGER_CONFIG = "配置";

elseif (GetLocale() == "zhTW") then
	SPELL_MONITOR = {"技能觸發", "jinengchufa"};
	SPELL_TRIGGER_ENABLE = "啟用技能觸發監控";
	EVENTALERT_TIPS = "啟用法術書ID提示";
	SPELL_TRIGGER_CONFIG = "配置";
else
	SPELL_MONITOR = "Spell Trigger";
	SPELL_TRIGGER_ENABLE = "Enable Event Alerter";
	EVENTALERT_TIPS = "Enable Spell book ID Tips";
	SPELL_TRIGGER_CONFIG = "Config";
end


if IsConfigurableAddOn("EventAlert") then
	ModManagement_RegisterMod(
		"SpellMonitor",
		"Interface\\Icons\\ability_shaman_watershield",
		SPELL_MONITOR,
		"",
		nil,
		nil,
		{[2]=true,[3]=true}

	);
		
	ModManagement_RegisterCheckBox(
		"SpellMonitor",
		SPELL_TRIGGER_ENABLE,
		nil,
		"EnableEventAlert",
		1,
		function (arg)
			if (arg == 1) then
				if not IsAddOnLoaded("EventAlert") then
					LoadAddOn("EventAlert")
				end
				if (IsAddOnLoaded("EventAlert")) then
					EventAlert_Toggle(true)
				end
				
			else
				if (IsAddOnLoaded("EventAlert")) then
					EventAlert_Toggle(false)
				end
			end
		end
	);

	ModManagement_RegisterButton(
		"SpellMonitor",
		SPELL_TRIGGER_CONFIG,
		function()
			if (IsAddOnLoaded("EventAlert")) then
				ShowUIPanel(EA_Options_Frame);
			end
		end,
		nil,
		1
	);
	if GetLocale()=='zhCN' then
		ModManagement_RegisterCheckBox(
			"SpellMonitor",
			EVENTALERT_TIPS,
			nil,
			"EnableTips",
			nil,
			function (arg)
				if (IsAddOnLoaded("EventAlert")) then
					Ev_Switch_Tips(arg);
				end
			end,
			1
		);
	end
end