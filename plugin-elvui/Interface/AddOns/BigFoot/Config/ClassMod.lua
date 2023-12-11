local BIGFOOT_CLASS_MOD, ENABLE_AIMED_SHOT, ENABLE_ZERO_FEED, AJUST_CAST_POSITION, ENABLE_MISDIRECT;
local ENABLE_ANTI_DAZE, ENABLE_AUTO_TRACKING, ENABLE_ASPECT_BAR, ENABLE_DISTANCE;
local ENABLE_ATTACK_TIMER, Z_HAPPINESS_POINT, Z_HAPPINESS_TOOLTIP, CLASS_MOD_PATH;
local ENABLE_SHAMAN_ASSIST, SHAMAN_ASSIST_TOOLTIP, SHOW_TOTEM_TITLE, ENABLE_TOTOEM_TIMER;
TotemTimers_switch = 0;
if (GetLocale() == "zhCN") then
	BIGFOOT_CLASS_MOD = {"职业助手", "zhiyezhushou",2};

	ENABLE_ANTI_DAZE = "自动取消猎豹守护";
	ENABLE_ANTI_DAZE_TOOLTIP= "当受到攻击时，自动取消猎豹守护";

	ENABLE_AUTO_TRACKING = "自动切换追踪类型";
	ENABLE_AUTO_TRACKING_TOOLTIP= "根据当前攻击目标自动切换追踪类型";

	ENABLE_ASPECT_BAR = "启用守护动作条";
	ENABLE_ASPECT_BAR_TOOLTIP= "在经验条上方额外显示守护动作条";

	ENABLE_RUNE_ENHANCE = "启用符文条增强";
	UNLOCK_RUNEFRAME = "解锁符文条";


	ENABLE_MISDIRECT = "误导提示";
	ENABLE_MISDIRECT_TOOLTIP= "以喊话的方式提示误导";

	ENABLE_DISTANCE = "启用距离提示";				--可以所有职业都加上吧
	ENABLE_DISTANCE_TOOLTIP= "在屏幕中下方显示你与当前目标距离的提示框体";

	ENABLE_ZERO_FEED = "启用一键喂养";
	ENABLE_ZERO_FEED_TOOLTIP= "在宠物头像右边显示的框体上添加食物，点击就可实现喂养";

	Z_HAPPINESS_POINT = "报警阀值";
	Z_HAPPINESS_TOOLTIP = "当宠物的快乐度低于该值时报警";

	ENABLE_ATTACK_TIMER = "启用近战攻击计时器";
	ENABLE_ATTACK_TIMER_TOOLTIP= "在屏幕中下方显示下次普通攻击的剩余时间框体";

	ENABLE_AIMED_SHOT = "启用自动射击计时器";
	ENABLE_AIMED_SHOT_TOOLTIP= "在屏幕中下方显示下次普通射击的剩余时间框体";

	AJUST_CAST_POSITION = "调整位置";

	ENABLE_SHAMAN_ASSIST = "启用萨满助手";
	SHAMAN_ASSIST_TOOLTIP = "设置";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<萨满助手>|r 你已经关闭萨满助手模块，该设置将在下次插件载入时生效。";

	ENABLE_TOTOEM_TIMER = "开启图腾计时器";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "依赖于技能计时器";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<萨满助手>|r 你已经关闭萨满图腾计时模块，该设置将在下次插件载入时生效。";
elseif (GetLocale() == "zhTW") then
	BIGFOOT_CLASS_MOD = {"職業助手", "zhiyezhushou",2};

	ENABLE_ANTI_DAZE = "自動取消獵豹守護";
	ENABLE_ANTI_DAZE_TOOLTIP= "當受到攻擊時，自動取消獵豹守護";

	ENABLE_AUTO_TRACKING = "自動切換追蹤類型";
	ENABLE_AUTO_TRACKING_TOOLTIP= "根據當前攻擊目標自動切換追蹤類型";

	ENABLE_ASPECT_BAR = "啟用守護動作條";
	ENABLE_ASPECT_BAR_TOOLTIP= "在經驗條上方額外顯示守護動作條";

	ENABLE_RUNE_ENHANCE = "啟用符文條增強";
	UNLOCK_RUNEFRAME = "解锁符文條";

	ENABLE_MISDIRECT = "誤導提示";
	ENABLE_MISDIRECT_TOOLTIP= "以喊話的方式誤導提示";

	ENABLE_DISTANCE = "啟用距離提示";
	ENABLE_DISTANCE_TOOLTIP= "在屏幕中下方顯示你與當前目標距離的提示框體";

	ENABLE_ZERO_FEED = "啟用一鍵喂養";
	ENABLE_ZERO_FEED_TOOLTIP= "在寵物頭像右邊顯示的框體上添加食物，點擊就可以實現餵養";

	Z_HAPPINESS_POINT = "報警閥值";
	Z_HAPPINESS_TOOLTIP = "當寵物的快樂度低于該值時報警";

	ENABLE_ATTACK_TIMER = "啟用近戰攻擊計時器";
	ENABLE_ATTACK_TIMER_TOOLTIP= "在屏幕中下方顯示下次普通攻擊的剩餘時間框體";

	ENABLE_AIMED_SHOT = "啟用自动射擊計時器";
	ENABLE_AIMED_SHOT_TOOLTIP= "在屏幕中下方顯示下次普通射擊的剩餘時間框體";

	AJUST_CAST_POSITION = "調整位置";

	ENABLE_SHAMAN_ASSIST = "啟用薩滿助手";
	SHAMAN_ASSIST_TOOLTIP = "設置";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<薩滿助手>|r 你已經關閉薩滿助手模組，該設置將在下次插件載入時生效。";
	
	ENABLE_TOTOEM_TIMER = "開啟圖騰計時器";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "依賴於技能計時器";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<薩滿助手>|r 你已經關閉薩滿圖騰計時模組，該設置將在下次插件載入時生效。";
else
	BIGFOOT_CLASS_MOD = "Class Assist";
	ENABLE_ANTI_DAZE = "Anti Daze";
	ENABLE_AUTO_TRACKING = "Auto Tracking";
	ENABLE_AIMED_SHOT = "Enable Auto Shot Timer";
	ENABLE_ASPECT_BAR = "Enable Aspect Bar";
	ENABLE_RUNE_ENHANCE = "Enable Enhanced Rune Frame";
	UNLOCK_RUNEFRAME = "Unlock Rune Frame";

	ENABLE_MISDIRECT = "Yell when cast misdirect";
	ENABLE_DISTANCE = "Enable Distance Meter";
	AJUST_CAST_POSITION = "Ajust position";
	ENABLE_ZERO_FEED = "Enable Zero Feed";
	Z_HAPPINESS_POINT = "Warning";
	Z_HAPPINESS_TOOLTIP = "Warning when ur pet's happiness lower than this value";
	ENABLE_ATTACK_TIMER = "Enable Attack Timer";
	ENABLE_SHAMAN_ASSIST = "Enable Shaman Assist";
	SHAMAN_ASSIST_TOOLTIP = "SET";
	SHAMAN_ASSIST_INFO = "|cff00c0c0<Shaman Assistant>|r Shaman helper module that you have turned off, the settings will take effect the next plug-in loaded.";
	ENABLE_TOTOEM_TIMER = "Enable totem timer";
	ENABLE_TOTOEM_TIMER_TOOLTIP= "Depends on the spell timers";
	SHAMAN_TOTOEM_TIMER_INFO = "|cff00c0c0<Shaman Assistant>|r You have closed the shaman totem timer module, the setting will take effect the next plug-in loaded.";
end

local ZERO_FEED_HAPPINESS = { PET_HAPPINESS1, PET_HAPPINESS2 };

local playerclass = select(2, UnitClass("player"));

if (playerclass == "HUNTER") then
	CLASS_MOD_PATH = "Interface\\ICONS\\Ability_Hunter_SniperShot.blp";
elseif (playerclass == "WARRIOR") then
	CLASS_MOD_PATH = "Interface\\Icons\\Ability_Warrior_Charge.blp";
elseif (playerclass == "PALADIN") then
	CLASS_MOD_PATH = "Interface\\Icons\\Spell_Holy_DivineIntervention.blp";
elseif (playerclass == "SHAMAN") then
	CLASS_MOD_PATH = "Interface\\ICONS\\Spell_Nature_StoneSkinTotem.blp";
else
	CLASS_MOD_PATH = "Interface\\ICONS\\Ability_Hunter_SniperShot.blp";
end

if playerclass == "HUNTER" and( IsConfigurableAddOn("HunterAssist") or IsConfigurableAddOn("BFClassMods")) then
	ModManagement_RegisterMod(
		"BigFootClassMod",
		CLASS_MOD_PATH,
		BIGFOOT_CLASS_MOD,
		"",
		nil,
		nil,
		{[7]=true},
		true,
		"235"
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_AIMED_SHOT,
		ENABLE_AIMED_SHOT_TOOLTIP,
		"EnableAimedShot",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
					BigFoot_LoadAddOn("HunterAssist");
				end
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistBar_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistBar_Toggle(false);
				end
			end
		end
	);
	ModManagement_RegisterButton(
		"BigFootClassMod",
		AJUST_CAST_POSITION,
		function ()
			if (BigFoot_IsAddOnLoaded("HunterAssist")) then
				HunterAssistCasteBar_AjustPosition();
			end
		end,
		nil,
		1
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_ANTI_DAZE,
		ENABLE_ANTI_DAZE_TOOLTIP,
		"EnableAntiDaze",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
					BigFoot_LoadAddOn("HunterAssist");
				end
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistDaze_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistDaze_Toggle(false);
				end
			end
		end
	);
	if GetLocale()=='zhCN' then
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_AUTO_TRACKING,
			ENABLE_AUTO_TRACKING_TOOLTIP,
			"EnableAutoTracking",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
						BigFoot_LoadAddOn("HunterAssist");
					end
					if (BigFoot_IsAddOnLoaded("HunterAssist")) then
						HunterAssistTracking_Toogle(true);
					end
				else
					if (BigFoot_IsAddOnLoaded("HunterAssist")) then
						HunterAssistTracking_Toogle(false);
					end
				end
			end
		);
		ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_ASPECT_BAR,
			ENABLE_ASPECT_BAR_TOOLTIP,
			"EnableAspectBar",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_LoadAddOn("BFClassMods");
					end
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						ToggleBFAspectBar(true)
					end
				else
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						ToggleBFAspectBar(false)
					end
				end
			end
		);
	end
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_MISDIRECT,
		ENABLE_MISDIRECT_TOOLTIP,
		"EnablemisDirect",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
					BigFoot_LoadAddOn("HunterAssist");
				end
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistMisdirect_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistMisdirect_Toggle(false);
				end
			end
		end
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_DISTANCE,
		ENABLE_DISTANCE_TOOLTIP,
		"EnableDistance",
		0,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
					BigFoot_LoadAddOn("HunterAssist");
				end
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistDistance_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					HunterAssistDistance_Toggle(false);
				end
			end
		end
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_ZERO_FEED,
		ENABLE_ZERO_FEED_TOOLTIP,
		"EnableZeroFeed",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("HunterAssist")) then
					BigFoot_LoadAddOn("HunterAssist");
				end
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					ZFeed_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("HunterAssist")) then
					ZFeed_Toggle(false);
				end
			end
		end
	);

	ModManagement_RegisterSpinBox(
		"BigFootClassMod",
		Z_HAPPINESS_POINT,
		Z_HAPPINESS_TOOLTIP,
		"HappIness",
		"list",
		ZERO_FEED_HAPPINESS,
		PET_HAPPINESS1,
		function(arg1)
			if (BigFoot_IsAddOnLoaded("HunterAssist")) then
				ZFeed_CHappiness(arg1);
			end
		end,
		1
	);
end

if  playerclass == "MAGE" or playerclass == "ROGUE" or playerclass == "WARLOCK" and( IsConfigurableAddOn("BFClassMods")) then
	ModManagement_RegisterMod(
		"BigFootClassMod",
		CLASS_MOD_PATH,
		BIGFOOT_CLASS_MOD,
		"",
		nil,
		nil,
		{[7]=true},
		true,
		"235"

	);
	ModManagement_RegisterCheckBox(
			"BigFootClassMod",
			ENABLE_ASPECT_BAR,
			ENABLE_ASPECT_BAR_TOOLTIP,
			"EnableAspectBar",
			1,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_LoadAddOn("BFClassMods");
					end
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						ToggleBFAspectBar(true)
					end
				else
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						ToggleBFAspectBar(false)
					end
				end
			end	,
			nil,
			function (arg)
				if (arg == 1) then
					if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_LoadAddOn("BFClassMods");
					end
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						BigFoot_DelayCall(function()
								ToggleBFAspectBar(true)
							end,
							5)
					end
				else
					if (BigFoot_IsAddOnLoaded("BFClassMods")) then
						ToggleBFAspectBar(false)
					end
				end
			end
		);
end

if ((playerclass == "WARRIOR" or playerclass == "PALADIN" ) and IsConfigurableAddOn("AttackTimer")) then
	ModManagement_RegisterMod(
		"BigFootClassMod",
		CLASS_MOD_PATH,
		BIGFOOT_CLASS_MOD,
		"",
		nil
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_ATTACK_TIMER,
		ENABLE_ATTACK_TIMER_TOOLTIP,
		"EnableAttackTimer",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("AttackTimer")) then
					BigFoot_LoadAddOn("AttackTimer");
				end
				if (BigFoot_IsAddOnLoaded("AttackTimer")) then
					AttackTimer_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("AttackTimer")) then
					AttackTimer_Toggle(false);
				end
			end
		end
	);
	ModManagement_RegisterButton(
		"BigFootClassMod",
		AJUST_CAST_POSITION,
		function ()
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_AjustPosition();
			end
		end,
		nil,
		1
	);
end

if playerclass == "DEATHKNIGHT" and IsConfigurableAddOn("BFClassMods") then
	ModManagement_RegisterMod(
		"BigFootClassMod",
		CLASS_MOD_PATH,
		BIGFOOT_CLASS_MOD,
		"",
		nil	,
		nil,
		{[7]=true},
		true,
		"235"
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_RUNE_ENHANCE,
		nil,
		"EnableRuneFrame",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
					BigFoot_LoadAddOn("BFClassMods");
				end
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleRuneFrame(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleRuneFrame(false)
				end
			end
		end
	);
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		UNLOCK_RUNEFRAME,
		nil,
		"UnlockRuneAnchorPoint",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFClassMods")) then
					BigFoot_LoadAddOn("BFClassMods");
				end
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleRuneHeader(true)
				end
			else
				if (BigFoot_IsAddOnLoaded("BFClassMods")) then
					ToggleRuneHeader(false)
				end
			end
		end,
		1
	)
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_ATTACK_TIMER,
		ENABLE_ATTACK_TIMER_TOOLTIP,
		"EnableAttackTimer",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("AttackTimer")) then
					BigFoot_LoadAddOn("AttackTimer");
				end
				if (BigFoot_IsAddOnLoaded("AttackTimer")) then
					AttackTimer_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("AttackTimer")) then
					AttackTimer_Toggle(false);
				end
			end
		end
	);
	ModManagement_RegisterButton(
		"BigFootClassMod",
		AJUST_CAST_POSITION,
		function ()
			if (BigFoot_IsAddOnLoaded("AttackTimer")) then
				AttackTimer_AjustPosition();
			end
		end,
		nil,
		1
	);
end

if (playerclass == "SHAMAN" and IsConfigurableAddOn("TotemTimers")) then
	ModManagement_RegisterMod(
		"BigFootClassMod",
		CLASS_MOD_PATH,
		BIGFOOT_CLASS_MOD,
		""
	);

	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_SHAMAN_ASSIST,
		nil,
		"TotemTimers",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("TotemTimers")) then
					BigFoot_LoadAddOn("TotemTimers");
					TotemTimers_switch = arg;
				end
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("TotemTimers")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_ASSIST_INFO); end);
				end
			end
		end
	);
	
	ModManagement_RegisterButton(
		"BigFootClassMod",
		SHAMAN_ASSIST_TOOLTIP,
		function ()
			if BigFoot_IsAddOnLoaded("TotemTimers")  then
				InterfaceOptionsFrame_OpenToCategory("TotemTimers")
				PlaySound("igMainMenuOption");
				HideUIPanel(ModManagementFrame);
			end
		end,
		nil,
		1
	);
	
	ModManagement_RegisterCheckBox(
		"BigFootClassMod",
		ENABLE_TOTOEM_TIMER,
		ENABLE_TOTOEM_TIMER_TOOLTIP,
		"EnableTotemTimer",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("SpellTimer")) then
					BigFoot_LoadAddOn("SpellTimer");
				end
				TotemFrameToggle();
			else
				if (BigFoot_IsAddOnLoadedFromBigFoot("SpellTimer")) then
					BigFoot_RequestReloadUI(function() BigFoot_Print(SHAMAN_TOTOEM_TIMER_INFO); end);
				end
			end
		end,
		1
	);
end