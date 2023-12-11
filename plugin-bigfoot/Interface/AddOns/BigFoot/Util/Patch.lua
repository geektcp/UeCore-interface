
-------------------------------------------------------
-- BigFootPatch.lua
-- AndyXiao@BigFoot
-- 本文件是用来修正一些来自WoW本身Interface的问题
-------------------------------------------------------
-- patch 2.4.2 去掉的Global String

if (GetLocale() == "zhCN") then
	GOLD = "金币";
	SILVER = "银币";
	COPPER = "铜币";

	HANDY_TOOLKIT_TITLE = "便捷功能";
elseif (GetLocale() == "zhTW") then
	GOLD = "金幣";
	SILVER = "銀幣";
	COPPER = "銅幣";
else
	GOLD = "gold";
	SILVER = "silver";
	COPPER = "copper";
end

do
	function BPatch_WatchRaidGroupButtons()
		local i;
		local button;
		for i = 1, 40 do 
			button = _G["RaidGroupButton"..i];
			button:SetAttribute("type", "target");
			button:SetAttribute("unit", button.unit);
		end
	end

	function BPatch_WatchPetActionBar()
		PetActionBarFrame:SetAttribute("unit", "pet");
		RegisterUnitWatch(PetActionBarFrame);
	end
	
	local bf_watcher
	
	bf_watcher = CreateFrame("Frame");
	bf_watcher:RegisterEvent("VARIABLES_LOADED");
	bf_watcher:RegisterEvent("ADDON_LOADED");
	bf_watcher:SetScript("OnEvent", function(self,event,arg1)
		if (event == "ADDON_LOADED" and arg1 == "Blizzard_RaidUI") then
			BFSecureCall(BPatch_WatchRaidGroupButtons)
		elseif (event == "ADDON_LOADED" and arg1 == "Blizzard_TimeManager") then
			if _G.TimeManagerClockButton then
				TimeManagerClockButton:SetPoint("CENTER","Minimap","BOTTOM",0,-5)
				TimeManagerClockButton:SetWidth(70)
				TimeManagerClockButton:SetHeight(35)
			end
		elseif (event == "VARIABLES_LOADED") then
			WatchFrame.baseAlpha = WatchFrame.baseAlpha or 0
			BFSecureCall(BPatch_WatchPetActionBar)
		end
	end);

end

-------------------
-- 和谐难看的字体
-------------------
do

SetTextStatusBarTextPrefix(PlayerFrameHealthBar, "");
SetTextStatusBarTextPrefix(PlayerFrameManaBar, "");
SetTextStatusBarTextPrefix(MainMenuExpBar, "");
PlayerFrame.noTextPrefix = true
TextStatusBarText:SetFont(STANDARD_TEXT_FONT, 14, "OUTLINE");

--调整系统时间位置及大小

end
-- 屏蔽界面失效的提醒
UIParent:UnregisterEvent("ADDON_ACTION_BLOCKED");


if (not VoiceOptionsFrameAudioLabel) then
	CreateFrame("Frame", "VoiceOptionsFrameAudioLabel", UIParent);
end


_G["ChatFrameEditBox"] = _G["ChatFrame1EditBox"]
 
