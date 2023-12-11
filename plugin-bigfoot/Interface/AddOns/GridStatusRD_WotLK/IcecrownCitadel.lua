local zone = "Icecrown Citadel"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--The Lower Spire
GridStatusRaidDebuff:Debuff(zone, 70980, 1, 6, 5) --Web Wrap
GridStatusRaidDebuff:Debuff(zone, 69483, 1, 6, 5, true) --Dark Reckoning
GridStatusRaidDebuff:Debuff(zone, 69969, 1, 5, 5, true) --Curse of Doom

--The Plagueworks
GridStatusRaidDebuff:Debuff(zone, 71089, 2, 5, 5, true) --Bubbling Pus
GridStatusRaidDebuff:Debuff(zone, 71127, 2, 7, 5, true, true) --Mortal Wound
GridStatusRaidDebuff:Debuff(zone, 71163, 2, 6, 5, true) --Devour Humanoid
GridStatusRaidDebuff:Debuff(zone, 71103, 2, 6, 5) --Combobulating Spray
GridStatusRaidDebuff:Debuff(zone, 71157, 2, 5, 5, false, true)--Infested Wound

--The Crimson Hall
GridStatusRaidDebuff:Debuff(zone, 70645, 3, 9, 5, true, false, {r=1,g=0,b=0})  --Chains of Shadow
GridStatusRaidDebuff:Debuff(zone, 70671, 3, 5, 5)-- Leeching Rot
GridStatusRaidDebuff:Debuff(zone, 70432, 3, 6, 5, true) --Blood Sap
GridStatusRaidDebuff:Debuff(zone, 70435, 3, 7, 5, true, true) --Rend Flesh

--Frostwing Hall
GridStatusRaidDebuff:Debuff(zone, 71257, 4, 6, 5, true, true) --Barbaric Strike
GridStatusRaidDebuff:Debuff(zone, 71252, 4, 5, 5, true) --Volley

GridStatusRaidDebuff:Debuff(zone, 71327, 4, 6, 5) -- Web
GridStatusRaidDebuff:Debuff(zone, 36922, 4, 5, 5, true) --Bellowing Roar

--Lord Marrowgar
GridStatusRaidDebuff:BossName(zone, 10, "Lord Marrowgar")
GridStatusRaidDebuff:Debuff(zone, 70823, 11, 5, 5, true) --Coldflame
GridStatusRaidDebuff:Debuff(zone, 69065, 12, 8, 5) --Impaled
GridStatusRaidDebuff:Debuff(zone, 70835, 13, 5, 5) --Bone Storm

--Lady Deathwhisper
GridStatusRaidDebuff:BossName(zone, 20, "Lady Deathwhisper")
GridStatusRaidDebuff:Debuff(zone, 72109, 21, 5, 5) --Death and Decay
GridStatusRaidDebuff:Debuff(zone, 71289, 22, 9, 9, true) --Dominate Mind
GridStatusRaidDebuff:Debuff(zone, 71204, 23, 4, 4, true, true) --Touch of Insignificance
GridStatusRaidDebuff:Debuff(zone, 67934, 24, 5, 5, true) --Frost Fever
GridStatusRaidDebuff:Debuff(zone, 71237, 25, 5, 5, true, false, nil, true) --Curse of Torpor
GridStatusRaidDebuff:Debuff(zone, 72491, 26, 5, 5, true) --Necrotic Strike

--Gunship Battle
GridStatusRaidDebuff:BossName(zone, 30, "Icecrown Gunship Battle")
GridStatusRaidDebuff:Debuff(zone, 69651, 31, 5, 5, true) --Wounding Strike

--Deathbringer Saurfang
GridStatusRaidDebuff:BossName(zone, 40, "Deathbringer Saurfang")
GridStatusRaidDebuff:Debuff(zone, 72293, 41, 6, 8, false, false, {r=1,g=0,b=0}) --Mark of the Fallen Champion
GridStatusRaidDebuff:Debuff(zone, 72442, 42, 8, 5, true) --Boiling Blood
GridStatusRaidDebuff:Debuff(zone, 72449, 43, 5, 5, true) --Rune of Blood
GridStatusRaidDebuff:Debuff(zone, 72769, 44, 5, 5, true) --Scent of Blood (heroic)

--Rotface
GridStatusRaidDebuff:BossName(zone, 50, "Rotface")
GridStatusRaidDebuff:Debuff(zone, 71224, 51, 5, 7, true) --Mutated Infection
GridStatusRaidDebuff:Debuff(zone, 71215, 52, 5, 5) --Ooze Flood
GridStatusRaidDebuff:Debuff(zone, 69774, 53, 5, 5) --Sticky Ooze

--Festergut
GridStatusRaidDebuff:BossName(zone, 60, "Festergut")
GridStatusRaidDebuff:Debuff(zone, 69279, 61, 5, 5, true) --Gas Spore
GridStatusRaidDebuff:Debuff(zone, 71218, 62, 5, 5, true) --Vile Gas
GridStatusRaidDebuff:Debuff(zone, 72219, 63, 5, 5, true, true) --Gastric Bloat

--Proffessor
GridStatusRaidDebuff:BossName(zone, 70, "Professor Putricide")
GridStatusRaidDebuff:Debuff(zone, 70341, 71, 5, 5, true) --Slime Puddle
GridStatusRaidDebuff:Debuff(zone, 72549, 72, 5, 5, true) --Malleable Goo
GridStatusRaidDebuff:Debuff(zone, 71278, 73, 5, 5, true) --Choking Gas Bomb
GridStatusRaidDebuff:Debuff(zone, 70215, 74, 5, 5, true) --Gaseous Bloat
GridStatusRaidDebuff:Debuff(zone, 70447, 75, 5, 5, true) --Volatile Ooze Adhesive
GridStatusRaidDebuff:Debuff(zone, 72454, 76, 5, 5, true, true) --Mutated Plague
GridStatusRaidDebuff:Debuff(zone, 70405, 77, 5, 5, false, false, {r=1, g=0, b=0}) --Mutated Transformation
GridStatusRaidDebuff:Debuff(zone, 72856, 78, 6, 4, true) --Unbound Plague
GridStatusRaidDebuff:Debuff(zone, 70953, 79, 4, 6, true, true, {r=0, g=0, b=1}) --Plague Sickness
--Blood Princes
GridStatusRaidDebuff:BossName(zone, 80, "Blood Princes")
GridStatusRaidDebuff:Debuff(zone, 72796, 81, 7, 5, true) --Glittering Sparks
GridStatusRaidDebuff:Debuff(zone, 71822, 82, 5, 7) --Shadow Resonance

--Blood-Queen Lana'thel
GridStatusRaidDebuff:BossName(zone, 90, "Blood-Queen Lana'thel")
GridStatusRaidDebuff:Debuff(zone, 70838, 91, 5, 5) --Blood Mirror
GridStatusRaidDebuff:Debuff(zone, 72265, 92, 6, 5, true) --Delirious Slash
GridStatusRaidDebuff:Debuff(zone, 71473, 93, 5, 7, true) --Essence of the Blood Queen
GridStatusRaidDebuff:Debuff(zone, 71474, 94, 6, 5, true) --Frenzied Bloodthirst
GridStatusRaidDebuff:Debuff(zone, 73070, 95, 5, 5, true) --Incite Terror
GridStatusRaidDebuff:Debuff(zone, 71340, 96, 7, 5) --Pact of the Darkfallen
GridStatusRaidDebuff:Debuff(zone, 71265, 97, 6, 5) --Swarming Shadows
GridStatusRaidDebuff:Debuff(zone, 70923, 98, 10, 10) --Uncontrollable Frenzy

--Valithria Dreamwalker
GridStatusRaidDebuff:BossName(zone, 100, "Valithria Dreamwalker")
GridStatusRaidDebuff:Debuff(zone, 70873, 101, 1, 5, true, true) --Emerald Vigor
GridStatusRaidDebuff:Debuff(zone, 71746, 102, 5, 5) --Column of Frost
GridStatusRaidDebuff:Debuff(zone, 71741, 103, 4, 5) --Mana Void
GridStatusRaidDebuff:Debuff(zone, 71738, 104, 7, 5, true, true) --Corrosion
GridStatusRaidDebuff:Debuff(zone, 71733, 105, 6, 5, true) --Acid Burst
GridStatusRaidDebuff:Debuff(zone, 71283, 106, 6, 5, true) --Gut Spray
GridStatusRaidDebuff:Debuff(zone, 71941, 107, 1, 5, true, true) --Twisted Nightmares

--Sindragosa
GridStatusRaidDebuff:BossName(zone, 110, "Sindragosa")
GridStatusRaidDebuff:Debuff(zone, 69762, 111, 5, 5, true) --Unchained Magic
GridStatusRaidDebuff:Debuff(zone, 70106, 112, 6, 5, true, true) --Chlled to the Bone
GridStatusRaidDebuff:Debuff(zone, 69766, 113, 6, 5, true, true) --Instability
GridStatusRaidDebuff:Debuff(zone, 70126, 114, 9, 5, true) --Frost Beacon
GridStatusRaidDebuff:Debuff(zone, 70157, 115, 8, 5, true) --Ice Tomb
GridStatusRaidDebuff:Debuff(zone, 70127, 116, 7, 5, false, true) --Mystic Buffet

--The Lich King
GridStatusRaidDebuff:BossName(zone, 120, "The Lich King")
GridStatusRaidDebuff:Debuff(zone, 70337, 121, 8, 5, true, true) --Necrotic plague
GridStatusRaidDebuff:Debuff(zone, 72149, 122, 5, 5, true) --Shockwave
GridStatusRaidDebuff:Debuff(zone, 70541, 123, 7, 5) --Infest
GridStatusRaidDebuff:Debuff(zone, 69242, 124, 5, 5, true) --Soul Shriek  -- 69200 Raging Spirit
GridStatusRaidDebuff:Debuff(zone, 69409, 125, 9, 5, true) --Soul Reaper
GridStatusRaidDebuff:Debuff(zone, 72762, 126, 5, 5) --Defile
GridStatusRaidDebuff:Debuff(zone, 68980, 127, 8, 5) --Harvest Soul

