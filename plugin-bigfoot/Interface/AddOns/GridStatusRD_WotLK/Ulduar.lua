local zone = "Ulduar"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:Debuff(zone, 63612, 2, 5, 5, true, true) --Lightning Brand
GridStatusRaidDebuff:Debuff(zone, 63615, 3, 10, 5, true, true) --Ravage Armor
GridStatusRaidDebuff:Debuff(zone, 63169, 6, 5, 5, true, true) --Petrify Joints
			
--Razorscale
GridStatusRaidDebuff:BossName(zone, 10, "Razorscale")
GridStatusRaidDebuff:Debuff(zone, 64771, 11, 5, 5, true) --Fuse Armor
			
--Ignis the Furnace Master
GridStatusRaidDebuff:BossName(zone, 15, "Ignis the Furnace Master")
GridStatusRaidDebuff:Debuff(zone, 62548, 16, 5, 5, true) --Scorch
GridStatusRaidDebuff:Debuff(zone, 62680, 17, 5, 5) --Flame Jet
GridStatusRaidDebuff:Debuff(zone, 62717, 18, 6, 5, true) --Slag Pot
			
--XT-002
GridStatusRaidDebuff:BossName(zone, 20, "XT-002 Deconstructor")
GridStatusRaidDebuff:Debuff(zone, 63024, 21, 5, 5, true) --Gravity Bomb
GridStatusRaidDebuff:Debuff(zone, 63018, 22, 5, 5, true) --Light Bomb
			
--The Assembly of Iron
GridStatusRaidDebuff:BossName(zone, 30, "The Iron Council")
GridStatusRaidDebuff:Debuff(zone, 61888, 31, 5, 5, true) --Overwhelming Power
GridStatusRaidDebuff:Debuff(zone, 62269, 32, 6, 5) --Rune of Death
GridStatusRaidDebuff:Debuff(zone, 61903, 33, 5, 5) --Fusion Punch
GridStatusRaidDebuff:Debuff(zone, 61912, 34, 5, 5, true) --Static Disruption
			
--Kologarn
GridStatusRaidDebuff:BossName(zone, 40, "Kologarn")
GridStatusRaidDebuff:Debuff(zone, 64290, 41, 5, 5, true) --Stone Grip
GridStatusRaidDebuff:Debuff(zone, 63355, 42, 10, 5, true, true) --Crunch Armor
GridStatusRaidDebuff:Debuff(zone, 62055, 43, 5, 5, false, true) --Brittle Skin
			
--Hodir
GridStatusRaidDebuff:BossName(zone, 50, "Hodir")
GridStatusRaidDebuff:Debuff(zone, 62469, 51, 5, 5) --Freeze
GridStatusRaidDebuff:Debuff(zone, 61969, 52, 10, 5) --Flash Freeze
GridStatusRaidDebuff:Debuff(zone, 62188, 53, 5, 5, false, true, nil, true) --Biting Cold
			
--Thorim
GridStatusRaidDebuff:BossName(zone, 60, "Thorim")
GridStatusRaidDebuff:Debuff(zone, 62042, 61, 5, 5) --Stormhammer
GridStatusRaidDebuff:Debuff(zone, 62130, 62, 10, 5, true) --Unbalancing Strike
GridStatusRaidDebuff:Debuff(zone, 62526, 63, 5, 5, true) --Rune Detonation
GridStatusRaidDebuff:Debuff(zone, 62470, 64, 5, 5, false, false, nil, true) --Deafening Thunder
GridStatusRaidDebuff:Debuff(zone, 62331, 65, 5, 5) --Impale
			
--Freya
GridStatusRaidDebuff:BossName(zone, 70, "Freya")
GridStatusRaidDebuff:Debuff(zone, 62589, 71, 5, 5, true) --Nature's Fury
GridStatusRaidDebuff:Debuff(zone, 62861, 73, 5, 5) --Iron Roots
			
--Mimiron
GridStatusRaidDebuff:BossName(zone, 80, "Mimiron")
GridStatusRaidDebuff:Debuff(zone, 63666, 81, 5, 5, true) --Napalm Shell
GridStatusRaidDebuff:Debuff(zone, 62997, 82, 5, 5, true) --Plasma Blast
GridStatusRaidDebuff:Debuff(zone, 64668, 83, 5, 5) --Magnetic Field

--General Vezax
GridStatusRaidDebuff:BossName(zone, 90, "General Vezax")
GridStatusRaidDebuff:Debuff(zone, 63276, 91, 10, 5, true) --Mark of the Faceless
GridStatusRaidDebuff:Debuff(zone, 63322, 92, 5, 5, false, true) --Saronite Vapors

--Yogg-Saron
GridStatusRaidDebuff:BossName(zone, 100, "Yogg-Saron")
GridStatusRaidDebuff:Debuff(zone, 63134, 101, 10, 5, true) --Sara's Bless
GridStatusRaidDebuff:Debuff(zone, 63138, 102, 5, 10, true, false, {r=1,g=0,b=0}) --Sara's Fevor
GridStatusRaidDebuff:Debuff(zone, 63830, 103, 5, 5, true) --Malady of the Mind
GridStatusRaidDebuff:Debuff(zone, 63802, 104, 5, 5) --Brain Link(Heroic)
GridStatusRaidDebuff:Debuff(zone, 63042, 105, 5, 5, true) --Dominate Mind
GridStatusRaidDebuff:Debuff(zone, 64156, 106, 5, 7) --Apathy
GridStatusRaidDebuff:Debuff(zone, 64153, 107, 5, 7) --Black Plague
GridStatusRaidDebuff:Debuff(zone, 64157, 108, 5, 7) --Curse of Doom
GridStatusRaidDebuff:Debuff(zone, 64152, 109, 5, 7) --Draining Poison (Heroic)
GridStatusRaidDebuff:Debuff(zone, 64125, 110, 10, 5) --Squeeze
GridStatusRaidDebuff:Debuff(zone, 63050, 111, 5, 5, false, false, nil, true) --Sanity

--Algalon
GridStatusRaidDebuff:BossName(zone, 120, "Algalon the Observer")
GridStatusRaidDebuff:Debuff(zone, 64412, 121, 5, 5, true, true) --Phase Punch
 