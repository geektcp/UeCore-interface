local zone = "The Obsidian Sanctum"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:Debuff(zone, 39647, 1, 5, 5) --Curse of Mending
GridStatusRaidDebuff:Debuff(zone, 58936, 2, 5, 5) --Rain of Fire
	
--Sartharion
GridStatusRaidDebuff:BossName(zone, 10, "Sartharion")
GridStatusRaidDebuff:Debuff(zone, 60708, 11, 10, 5, false, true) --Fade Armor
GridStatusRaidDebuff:Debuff(zone, 57491, 12, 5, 5, true, false) --Flame Tsunami