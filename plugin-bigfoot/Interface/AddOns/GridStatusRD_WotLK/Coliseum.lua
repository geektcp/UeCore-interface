zone = "Trial of the Crusader"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--<< Beast of Northrend >> 
--Gormok the Impaler
GridStatusRaidDebuff:BossName(zone, 10, "Gormok the Impaler")
GridStatusRaidDebuff:Debuff(zone, 66331, 11, 5, 5, true, true) --Impale
GridStatusRaidDebuff:Debuff(zone, 67475, 13, 5, 5, true) --Fire Bomb
GridStatusRaidDebuff:Debuff(zone, 66406, 14, 5, 5) --Snowbolled!

--Acidmaw --Dreadscale
GridStatusRaidDebuff:BossName(zone, 20, "Jormungar Behemoth")
GridStatusRaidDebuff:Debuff(zone, 67618, 23, 5, 5, true) --Paralytic Toxin
GridStatusRaidDebuff:Debuff(zone, 66869, 24, 5, 5, true) --Burning Bile

--Icehowl
GridStatusRaidDebuff:BossName(zone, 30, "Icehowl")
GridStatusRaidDebuff:Debuff(zone, 67654, 31, 5, 5, true) --Ferocious Butt
GridStatusRaidDebuff:Debuff(zone, 66689, 32, 5, 5) --Arctic Breathe
GridStatusRaidDebuff:Debuff(zone, 66683, 33, 5, 5) --Massive Crash

--Lord Jaraxxus
GridStatusRaidDebuff:BossName(zone, 40, "Lord Jaraxxus")
GridStatusRaidDebuff:Debuff(zone, 66532, 41, 5, 5) --Fel Fireball
GridStatusRaidDebuff:Debuff(zone, 66237, 42, 8, 10, true, false, {r=1, g=0, b=0}) --Incinerate Flesh
GridStatusRaidDebuff:Debuff(zone, 66242, 43, 7, 5, true) --Burning Inferno
GridStatusRaidDebuff:Debuff(zone, 66197, 44, 5, 5) --Legion Flame
GridStatusRaidDebuff:Debuff(zone, 66283, 45, 9, 5, true) --Spinning Pain Spike
GridStatusRaidDebuff:Debuff(zone, 66209, 46, 5, 5, true) --Touch of Jaraxxus(hard)
GridStatusRaidDebuff:Debuff(zone, 66211, 47, 5, 5, true) --Curse of the Nether(hard)
GridStatusRaidDebuff:Debuff(zone, 67906, 48, 5, 5) --Mistress's Kiss 10H

--Faction Champions
GridStatusRaidDebuff:BossName(zone, 50, "Faction Champions")
GridStatusRaidDebuff:Debuff(zone, 65812, 51, 10, 10, true, false, {r=1, g=0, b=0}) --Unstable Affliction
GridStatusRaidDebuff:Debuff(zone, 65960, 52, 5, 5, true) --Blind
GridStatusRaidDebuff:Debuff(zone, 65801, 53, 5, 7) --Polymorph
GridStatusRaidDebuff:Debuff(zone, 65543, 54, 5, 7) --Psychic Scream
GridStatusRaidDebuff:Debuff(zone, 66054, 55, 5, 7) --Hex
GridStatusRaidDebuff:Debuff(zone, 65809, 56, 5, 7) --Fear

--The Twin Val'kyr
GridStatusRaidDebuff:BossName(zone, 60, "The Twin Val'kyr")
GridStatusRaidDebuff:Debuff(zone, 67176, 61, 5, 10, false, false, {r=1, g=0, b=0}, true) --Dark Essence
GridStatusRaidDebuff:Debuff(zone, 67222, 62, 5, 10, false, false, {r=0, g=0, b=1}, true) --Light Essence
GridStatusRaidDebuff:Debuff(zone, 67283, 63, 7, 5, true) --Dark Touch
GridStatusRaidDebuff:Debuff(zone, 67298, 64, 7, 5, true) --Ligth Touch
GridStatusRaidDebuff:Debuff(zone, 67309, 65, 5, 5, false, true) --Twin Spike

--Anub'arak
GridStatusRaidDebuff:BossName(zone, 70, "Anub'arak")
GridStatusRaidDebuff:Debuff(zone, 67574, 71, 10, 10) --Pursued by Anub'arak
GridStatusRaidDebuff:Debuff(zone, 66013, 72, 7, 10, true, false, {r=1, g=0, b=0}) --Penetrating Cold (10?)
GridStatusRaidDebuff:Debuff(zone, 67847, 73, 5, 5, false, true) --Expose Weakness
GridStatusRaidDebuff:Debuff(zone, 66012, 74, 5, 5) --Freezing Slash
GridStatusRaidDebuff:Debuff(zone, 67863, 75, 8, 5, false, true) --Acid-Drenched Mandibles(25H)
