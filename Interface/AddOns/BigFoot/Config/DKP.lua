local ADDON_TITLE
if GetLocale()=='zhCN' then
	ADDON_TITLE = "团队记录"
	GDKP_ADDON_TITLE = "使用KK魔兽金团助手"
elseif GetLocale()=='zhTW' then
	ADDON_TITLE = "团队記錄"
	GDKP_ADDON_TITLE = "使用大腳金團助手"
else
	ADDON_TITLE = "Raid Records"
	GDKP_ADDON_TITLE = "Use GDKP"
end

if not IsConfigurableAddOn("GDKP") and not IsConfigurableAddOn("MiDKP") then return end

ModManagement_RegisterMod(
	"MiDKP",
	"Interface\\Icons\\INV_Misc_Toy_05",
	{ADDON_TITLE,"tuanduiDKP",2},
	"",
	nil,
	nil,
	{[4]=true},
	true,
	"243"
);

if IsConfigurableAddOn("GDKP") then
	ModManagement_RegisterCheckBox(
		"MiDKP",
		GDKP_ADDON_TITLE,
		nil,
		"GDKPEnable",
		0,
		function (arg)
			if arg == 1 then
				if  not IsAddOnLoaded("GDKP") then
					LoadAddOn("GDKP")
				end
				GDKP:Enable()
			else
				GDKP:Disable()
			end
		end
		
	);
end