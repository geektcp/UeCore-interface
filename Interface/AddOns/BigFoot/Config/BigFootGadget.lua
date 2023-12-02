local ENABLE_MAIL_MOD;
local ENABLE_RIGHT_CLICK;
local CT_MAIL_MOD_TITLE;

if (GetLocale() == "zhCN") then
	BIGFOOTGADGET_TITLE = {"便捷功能", "bianjiegongneng"};
	
	BIGFOOTGADGET_ENABLE_GPS = "开启坐标指示";
	BIGFOOTGADGET_ENABLE_GPS_TOOLTIP= "显示玩家当前坐标的一个小框体";
	
	BIGFOOTGADGET_ENABLE_VOLUME = "开启声音调节";
	BIGFOOTGADGET_ENABLE_VOLUME_TOOLTIP = "快速调节系统声音大小";
	
	BIGFOOTGADGET_ENABLE_MBB = "开启小地图按键包";
	BIGFOOTGADGET_ENABLE_MBB_TOOLTIP="将一些附加在小地图周围的按键图标(如Grid)整合到一个按键图标中"	
	
	BIGFOOTGADGET_CHANGE_FONT = "修改系统数字字体";	
	BIGFOOTGADGET_CHANGE_FONT_TOOLTIP="使数字的显示变的更加清楚一些"
	
	BIGFOOTGADGET_CASTING_BAR = "使用KK魔兽施法条"
	BIGFOOTGADGET_CASTING_BAR_TOOLTIP="在原有的施法条基础上添加了施法时间与施法延迟提示"
	
	ENABLE_MAIL_MOD = "启用邮件助手";
	ENABLE_MAIL_MOD_TOOLTIP= "强化邮件功能：可记忆收信人及支持批量收取邮件";
	
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "快速设置焦点";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP = "可通过Shift加左键点击头像来设置焦点，Shift加右键点击来清除焦点";

	SCREEN_MARK_PHOTO_MODE="截取纯画面"
	SCREEN_MARK_PHOTO_MODE_TOOLTIP="截图时按住Shift与截图键来截取纯画面图片"
	
	SCREEN_MARK_CINEMATIC_MODE="截取电影模式的画面"
	SCREEN_MARK_CINEMATIC_MODE_TOOLTIP="截图时按住Alt与截图键来截取电影模式的画面图片"
	
elseif (GetLocale() == "zhTW") then
	BIGFOOTGADGET_TITLE = {"便捷功能", "bianjiegongneng"};
	
	BIGFOOTGADGET_ENABLE_GPS = "開啟座標指示";
	BIGFOOTGADGET_ENABLE_GPS_TOOLTIP= "顯示玩家當前座標的一個小框體";
	
	BIGFOOTGADGET_ENABLE_VOLUME = "開啟音量調節";
	BIGFOOTGADGET_ENABLE_VOLUME_TOOLTIP = "快速調節系統聲音大小";
	
	BIGFOOTGADGET_ENABLE_MBB = "開啟小地圖按鍵包";	
	BIGFOOTGADGET_ENABLE_MBB_TOOLTIP= "將一些附加在小地圖周圍的按鍵圖標(如Grid)整合到一個按鍵圖標中";	
	
	BIGFOOTGADGET_CHANGE_FONT = "修改系統數字字體";	
	BIGFOOTGADGET_CHANGE_FONT_TOOLTIP= "數數字的顯示變得更加清楚一些";	
	
	BIGFOOTGADGET_CASTING_BAR = "使用大腳施法條"
	BIGFOOTGADGET_CASTING_BAR_TOOLTIP= "在原有的施法條基礎上添加了施法時間與施法延遲提示"
	
	ENABLE_MAIL_MOD = "啟用郵件助手";
	ENABLE_MAIL_MOD_TOOLTIP= "槍換郵件功能：可記憶收信人及支持批量收取郵件";
	
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "快速設置焦點";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP = "可通過Shift加左鍵點擊頭像來設置焦點，Shift加右鍵點擊頭像來清除焦點";
	
	SCREEN_MARK_PHOTO_MODE="截取純畫面"
	SCREEN_MARK_PHOTO_MODE_TOOLTIP="截圖時按住Shift與截圖鍵來截取純畫面圖片"
	
	SCREEN_MARK_CINEMATIC_MODE="截取電影模式的畫面"
	SCREEN_MARK_CINEMATIC_MODE_TOOLTIP="截圖時按住Alt與截圖鍵來截取電影模式畫面的畫面圖片"
	
else
	BIGFOOTGADGET_TITLE = "BigFoot Gadget";
	BIGFOOTGADGET_ENABLE_GPS = "Enable GPS";
	
	BIGFOOTGADGET_ENABLE_VOLUME = "Enable Sound Control";
	BIGFOOTGADGET_ENABLE_VOLUME_TOOLTIP = "Enable Sound Control";

	BIGFOOTGADGET_ENABLE_MBB = "Enable Minimap button bag";	
	BIGFOOTGADGET_CHANGE_FONT = "Change Default font";	
	BIGFOOTGADGET_CASTING_BAR = "Use BFCastingBar"
	ENABLE_MAIL_MOD = "Enable CT-Mail Mod";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE = "Enable Fast Focus";
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP = "After you enable it, you can click target from by hold shift key to set focus frame.";

	SCREEN_MARK_CINEMATIC_MODE="Hold Alt key to taking cinematic screenshot"
	SCREEN_MARK_PHOTO_MODE="Hold shift key to taking pure screenshot"

end

ModManagement_RegisterMod(
	"BigFootGadget",
	"Interface\\Icons\\INV_Gizmo_HardenedAdamantiteTube",
	BIGFOOTGADGET_TITLE,
	"",
	nil,
	nil,
	{[7]=true},
	true,
	"214"
);

if (IsConfigurableAddOn("BFGadgets")) then
	ModManagement_RegisterCheckBox(
		"BigFootGadget",
		BIGFOOTGADGET_ENABLE_GPS,
		BIGFOOTGADGET_ENABLE_GPS_TOOLTIP,
		"EnableBigFootGPS",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFGadgets")) then
					BigFoot_LoadAddOn("BFGadgets");
				end	
				if BigFoot_IsAddOnLoaded("BFGadgets") then
					BigFoot_EnableGPS(true)
				end
			else
				if BigFoot_IsAddOnLoaded("BFGadgets") then
					BigFoot_EnableGPS(false)
				end
			end
		end
	);
	ModManagement_RegisterCheckBox(
		"BigFootGadget",
		BIGFOOTGADGET_ENABLE_VOLUME,
		BIGFOOTGADGET_ENABLE_VOLUME_TOOLTIP,
		"EnableBigFootVolume",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("BFGadgets")) then
					BigFoot_LoadAddOn("BFGadgets");
				end	
				if BigFoot_IsAddOnLoaded("BFGadgets") then
					BigFoot_EnableVolume(true)
				end
			else
				if BigFoot_IsAddOnLoaded("BFGadgets") then
					BigFoot_EnableVolume(false)
				end
			end
		end
	);
end

ModManagement_RegisterCheckBox(
	"BigFootGadget",
	BIGFOOTGADGET_CHANGE_FONT,
	BIGFOOTGADGET_CHANGE_FONT_TOOLTIP,
	"ChangeBigFootFont",
	1,
	function (arg)
		if (arg == 1) then
			BFGadget_FontName, BFGadget_FontHeight, BFGadget_FontFlags=NumberFontNormal:GetFont()
			NumberFontNormal:SetFont("Fonts\\ZYKai_T.TTF",14,"OUTLINE")
			__BFG_Font_Modified=true
		else
			if __BFG_Font_Modified then
				NumberFontNormal:SetFont(BFGadget_FontName or "Fonts\\ZYKai_C.ttf",BFGadget_FontHeight or 12,BFGadget_FontFlags or "OUTLINE")
			end
			__BFG_Font_Modified=false
		end
	end
);

ModManagement_RegisterCheckBox(
	"BigFootGadget",
	BIGFOOTGADGET_CASTING_BAR,
	BIGFOOTGADGET_CASTING_BAR_TOOLTIP,
	"BFCB",
	1,
	function (arg)
		if (arg == 1) then
			if (not BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BigFoot_LoadAddOn("BFCastingBar");
			end
			if (BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BFCB:Toggle(true)
			end	
		else
			if (BigFoot_IsAddOnLoaded("BFCastingBar")) then
				BFCB:Toggle(false)
			end	
		end
	end
);

if (IsConfigurableAddOn("MailMod")) then
	ModManagement_RegisterCheckBox(
		"BigFootGadget",
		ENABLE_MAIL_MOD,
		ENABLE_MAIL_MOD_TOOLTIP,
		"EnableMailMod",
		1,
		function (arg)
			if (arg == 1) then
				if (not BigFoot_IsAddOnLoaded("MailMod")) then
					BigFoot_LoadAddOn("MailMod");
				end
				
				if (BigFoot_IsAddOnLoaded("MailMod")) then
					MailMod_Toggle(true);
				end
			else
				if (BigFoot_IsAddOnLoaded("MailMod")) then
					MailMod_Toggle(false);									
				end
			end
		end
	);
end

ModManagement_RegisterCheckBox(
	"BigFootGadget",
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TITLE,
	MOD_ARENA_TOOLKIT_ENABLE_FAST_FOCUS_TOOLTIP,
	"EnableFasyFocus",
	1,
	function (arg)
		if ( arg == 1 ) then
			TargetFrame:SetAttribute("shift-type1", "focus");
			TargetFrame:SetAttribute("shift-type2", "macro");
			TargetFrame:SetAttribute("macrotext", "/CLEARFOCUS");
		else
			TargetFrame:SetAttribute("shift-type1", nil);
			TargetFrame:SetAttribute("shift-type2", nil);
			TargetFrame:SetAttribute("macrotext", nil);
		end
	end
);

	
if (IsConfigurableAddOn("ScreenMark")) then
	ModManagement_RegisterCheckBox(
		"BigFootGadget",
		SCREEN_MARK_PHOTO_MODE,
		SCREEN_MARK_PHOTO_MODE_TOOLTIP,
		"ScreenMark_EnablePhotoMode",
		1,
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("ScreenMark")) then
					BigFoot_LoadAddOn("ScreenMark");
				end
				if (BigFoot_IsAddOnLoaded("ScreenMark")) then
					BFScreenMark_EnablePhotoMode = 1; 
				end
			else
				if (BigFoot_IsAddOnLoaded("ScreenMark")) then
					BFScreenMark_EnablePhotoMode = nil;
				end
			end
		end
	);
end
	ModManagement_RegisterCheckBox(
		"BigFootGadget",
		SCREEN_MARK_CINEMATIC_MODE,
		SCREEN_MARK_CINEMATIC_MODE_TOOLTIP,
		"ScreenMark_EnableCinematicMode",
		1,
		function (__arg)
			if (__arg == 1) then
				if (not BigFoot_IsAddOnLoaded("ScreenMark")) then
					BigFoot_LoadAddOn("ScreenMark");
				end
				if (BigFoot_IsAddOnLoaded("ScreenMark")) then
					BFScreenMark_EnableCinematicMode = 1; 
				end
			else
				if (BigFoot_IsAddOnLoaded("ScreenMark")) then
					BFScreenMark_EnableCinematicMode = nil;
				end
			end
		end
	);
