function EventAlert_LoadExtras()

   -- Really nasty hack.  I'll remove this eventually when I get more time to clean up the options panes.
   if (EA_playerClass == EA_CLASS_WARRIOR) then
      Alt_Alerts_Frame:SetWidth(325);
      Alt_Alerts_Frame:SetHeight(675);
   else
      Alt_Alerts_Frame:SetWidth(325);
	  Alt_Alerts_Frame:SetHeight(500);
   end

        
   -- Set up Sacred Shield stuff
   EA_SacredShield.ceArg7 = "noPlayerActive";
   EA_SacredShield.expire = 0;
   EA_SacredShield.spellActive = false;

   if (EA_playerClass == EA_CLASS_PALADIN) then
      EA_nameTalent, _, _, _, EA_talentCurrentRank, _, _, _ = GetTalentInfo(2, 9);

      if (EA_talentCurrentRank == 0) then
         EA_SacredShield.timer = 6;
      elseif (EA_talentCurrentRank == 1) then
         EA_SacredShield.timer = 9;
      elseif (EA_talentCurrentRank == 2) then
         EA_SacredShield.timer = 12;
      end
   end

--[[
I have no idea why this code doesn't work here.
It's annoying and I'll fix it eventually, but I need to actually PLAY the game for now and stop messing with this.  ha!

   for i,v in pairs(EA_AltItems[EA_playerClass]) do

      local name, rank = GetSpellInfo(i);
      local link = GetSpellLink(name, "");
         
      local _, _, spellString = string.find(link, "^|c%x+|Hspell:(.+)|h%[.*%]")
            
      if (EA_PreLoadAlts[name] == nil) then 
         EA_PreLoadAlts[name] = spellString;
      elseif (EA_PreLoadAlts[name] < spellString) then
         EA_PreLoadAlts[name] = spellString;
      elseif (EA_PreLoadAlts[name] >= spellString) then
         -- Do Nothing
      end

   end
 ]]--  
end