local zone = "Naxxramas"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:Debuff(zone, 55314, 1, 5, 5) --Strangulate

--Anub'Rekhan
GridStatusRaidDebuff:BossName(zone, 10, "Anub'Rekhan")
GridStatusRaidDebuff:Debuff(zone, 28786, 11, 5, 5, true, true) --Locust Swarm


--Grand Widow Faerlina
GridStatusRaidDebuff:BossName(zone, 20, "Grand Widow Faerlina")
GridStatusRaidDebuff:Debuff(zone, 28796, 21, 5, 5, false, true) --Poison Bolt Volley
GridStatusRaidDebuff:Debuff(zone, 28794, 22, 5, 5) --Rain of Fire


--Maexxna
GridStatusRaidDebuff:BossName(zone, 25, "Maexxna")
GridStatusRaidDebuff:Debuff(zone, 28622, 26, 5, 5) --Web Wrap
GridStatusRaidDebuff:Debuff(zone, 54121, 27, 5, 5) --Necrotic Poison


--Noth the Plaguebringer
GridStatusRaidDebuff:BossName(zone, 30, "Noth the Plaguebringer")
GridStatusRaidDebuff:Debuff(zone, 29213, 31, 5, 5, true) --Curse of the Plaguebringer
GridStatusRaidDebuff:Debuff(zone, 29214, 32, 5, 5, true) --Wrath of the Plaguebringer
GridStatusRaidDebuff:Debuff(zone, 29212, 33, 5, 5) --Cripple

--Heigan the Unclean
GridStatusRaidDebuff:BossName(zone, 40, "Heigan the Unclean")
GridStatusRaidDebuff:Debuff(zone, 29998, 41, 5, 5) --Decrepit Fever
GridStatusRaidDebuff:Debuff(zone, 29310, 42, 5, 5, false, false, nil, true) --Spell Disruption

--Grobbulus
GridStatusRaidDebuff:BossName(zone, 50, "Grobbulus")
GridStatusRaidDebuff:Debuff(zone, 28169, 51, 5, 5, true) --Mutating Injection

--Gluth
GridStatusRaidDebuff:BossName(zone, 60, "Gluth")
GridStatusRaidDebuff:Debuff(zone, 54378, 61, 5, 5, true) --Mortal Wound			
GridStatusRaidDebuff:Debuff(zone, 29306, 62, 5, 5) --Infected Wound

--Thaddius
GridStatusRaidDebuff:BossName(zone, 65, "Thaddius")
GridStatusRaidDebuff:Debuff(zone, 28084, 66, 5, 5, false, false, {r = 1, g = 0, b = 0}, true) --Negative Charge
GridStatusRaidDebuff:Debuff(zone, 28059, 67, 5, 5, false, false, {r = 0, g = 0, b = 1}, true) --Positive Charge


--Instructor Razuvious
GridStatusRaidDebuff:BossName(zone, 70, "Instructor Razuvious")
GridStatusRaidDebuff:Debuff(zone, 55550, 71, 5, 5, true) --Jagged Knife
			
--Sapphiron
GridStatusRaidDebuff:BossName(zone, 80, "Sapphiron")
GridStatusRaidDebuff:Debuff(zone, 28522, 81, 5, 5) --Icebolt
GridStatusRaidDebuff:Debuff(zone, 28542, 82, 5, 5) --Life Drain

--Kel'Thuzad
GridStatusRaidDebuff:BossName(zone, 100, "Kel'Thuzad")
GridStatusRaidDebuff:Debuff(zone, 28410, 101, 5, 5, true) --Chains of Kel'Thuzad
GridStatusRaidDebuff:Debuff(zone, 27819, 102, 5, 5) --Detonate Mana
GridStatusRaidDebuff:Debuff(zone, 27808, 103, 5, 5) --Frost Blast


				