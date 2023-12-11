	local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
	local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
	local L = LibStub("AceLocale-3.0"):GetLocale("Mendeleev")
	
	local showDropRate = function (v)
		v = tonumber(v)
		return v and (" (%.1f%%)"):format(v / 10) or ""
	end

	table.insert(MENDELEEV_SETS, {
		name = BZ["Auchindoun"],
		setindex = "InstanceLoot.Auchindoun",
		colour = "|cffB0C4DE",
		header = BZ["Auchindoun"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Auchenai Crypts.Exarch Maladaar"]=BB["Exarch Maladaar"],
			["InstanceLoot.Auchenai Crypts.Shirrak the Dead Watcher"]=BB["Shirrak the Dead Watcher"],
			["InstanceLoot.Mana-Tombs.Nexus-Prince Shaffar"]=BB["Nexus-Prince Shaffar"],
			["InstanceLoot.Mana-Tombs.Pandemonius"]=BB["Pandemonius"],
			["InstanceLoot.Mana-Tombs.Tavarok"]=BB["Tavarok"],
			["InstanceLoot.Shadow Labyrinth.Ambassador Hellmaw"]=BB["Ambassador Hellmaw"],
			["InstanceLoot.Shadow Labyrinth.Blackheart the Inciter"]=BB["Blackheart the Inciter"],
			["InstanceLoot.Shadow Labyrinth.Grandmaster Vorpil"]=BB["Grandmaster Vorpil"],
			["InstanceLoot.Shadow Labyrinth.Murmur"]=BB["Murmur"],
			["InstanceLoot.Sethekk Halls.Darkweaver Syth"]=BB["Darkweaver Syth"],
			["InstanceLoot.Sethekk Halls.Talon King Ikiss"]=BB["Talon King Ikiss"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Auchindoun"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Auchindoun",
		colour = "|cffB0C4DE",
		header = BZ["Auchindoun"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Auchenai Crypts.Exarch Maladaar"]=BB["Exarch Maladaar"],
			["InstanceLootHeroic.Auchenai Crypts.Shirrak the Dead Watcher"]=BB["Shirrak the Dead Watcher"],
			["InstanceLootHeroic.Mana-Tombs.Nexus-Prince Shaffar"]=BB["Nexus-Prince Shaffar"],
			["InstanceLootHeroic.Mana-Tombs.Pandemonius"]=BB["Pandemonius"],
			["InstanceLootHeroic.Mana-Tombs.Tavarok"]=BB["Tavarok"],
			["InstanceLootHeroic.Shadow Labyrinth.Ambassador Hellmaw"]=BB["Ambassador Hellmaw"],
			["InstanceLootHeroic.Shadow Labyrinth.Blackheart the Inciter"]=BB["Blackheart the Inciter"],
			["InstanceLootHeroic.Shadow Labyrinth.Grandmaster Vorpil"]=BB["Grandmaster Vorpil"],
			["InstanceLootHeroic.Shadow Labyrinth.Murmur"]=BB["Murmur"],
			["InstanceLootHeroic.Sethekk Halls.Darkweaver Syth"]=BB["Darkweaver Syth"],
			["InstanceLootHeroic.Sethekk Halls.Talon King Ikiss"]=BB["Talon King Ikiss"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Caverns of Time"],
		setindex = "InstanceLoot.Caverns of Time",
		colour = "|cffB0C4DE",
		header = BZ["Caverns of Time"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Old Hillsbrad Foothills.Captain Skarloc"]=BB["Captain Skarloc"],
			["InstanceLoot.Old Hillsbrad Foothills.Epoch Hunter"]=BB["Epoch Hunter"],
			["InstanceLoot.Old Hillsbrad Foothills.Lieutenant Drake"]=BB["Lieutenant Drake"],
			["InstanceLoot.The Black Morass.Aeonus"]=BB["Aeonus"],
			["InstanceLoot.The Black Morass.Chrono Lord Deja"]=BB["Chrono Lord Deja"],
			["InstanceLoot.The Black Morass.Temporus"]=BB["Temporus"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Caverns of Time"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Caverns of Time",
		colour = "|cffB0C4DE",
		header = BZ["Caverns of Time"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Old Hillsbrad Foothills.Captain Skarloc"]=BB["Captain Skarloc"],
			["InstanceLootHeroic.Old Hillsbrad Foothills.Epoch Hunter"]=BB["Epoch Hunter"],
			["InstanceLootHeroic.Old Hillsbrad Foothills.Lieutenant Drake"]=BB["Lieutenant Drake"],
			["InstanceLootHeroic.The Black Morass.Aeonus"]=BB["Aeonus"],
			["InstanceLootHeroic.The Black Morass.Chrono Lord Deja"]=BB["Chrono Lord Deja"],
			["InstanceLootHeroic.The Black Morass.Temporus"]=BB["Temporus"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Coilfang Reservoir"],
		setindex = "InstanceLoot.Coilfang Reservoir",
		colour = "|cffB0C4DE",
		header = BZ["Coilfang Reservoir"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Slave Pens.Mennu the Betrayer"]=BB["Mennu the Betrayer"],
			["InstanceLoot.The Slave Pens.Quagmirran"]=BB["Quagmirran"],
			["InstanceLoot.The Slave Pens.Rokmar the Crackler"]=BB["Rokmar the Crackler"],
			["InstanceLoot.The Slave Pens.Ahune"]=BB["Ahune"],
			["InstanceLoot.The Steamvault.Hydromancer Thespia"]=BB["Hydromancer Thespia"],
			["InstanceLoot.The Steamvault.Mekgineer Steamrigger"]=BB["Mekgineer Steamrigger"],
			["InstanceLoot.The Steamvault.Warlord Kalithresh"]=BB["Warlord Kalithresh"],
			["InstanceLoot.The Underbog.Ghaz'an"]=BB["Ghaz'an"],
			["InstanceLoot.The Underbog.Hungarfen"]=BB["Hungarfen"],
			["InstanceLoot.The Underbog.Swamplord Musel'ek"]=BB["Swamplord Musel'ek"],
			["InstanceLoot.The Underbog.The Black Stalker"]=BB["The Black Stalker"],
			["InstanceLoot.Serpentshrine Cavern.Fathom-Lord Karathress"]=BB["Fathom-Lord Karathress"],
			["InstanceLoot.Serpentshrine Cavern.Hydross the Unstable"]=BB["Hydross the Unstable"],
			["InstanceLoot.Serpentshrine Cavern.Lady Vashj"]=BB["Lady Vashj"],
			["InstanceLoot.Serpentshrine Cavern.Leotheras the Blind"]=BB["Leotheras the Blind"],
			["InstanceLoot.Serpentshrine Cavern.Morogrim Tidewalker"]=BB["Morogrim Tidewalker"],
			["InstanceLoot.Serpentshrine Cavern.The Lurker Below"]=BB["The Lurker Below"],
			["InstanceLoot.Serpentshrine Cavern.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Coilfang Reservoir"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Coilfang Reservoir",
		colour = "|cffB0C4DE",
		header = BZ["Coilfang Reservoir"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Slave Pens.Mennu the Betrayer"]=BB["Mennu the Betrayer"],
			["InstanceLootHeroic.The Slave Pens.Quagmirran"]=BB["Quagmirran"],
			["InstanceLootHeroic.The Slave Pens.Rokmar the Crackler"]=BB["Rokmar the Crackler"],
			["InstanceLootHeroic.The Slave Pens.Ahune"]=BB["Ahune"],
			["InstanceLootHeroic.The Steamvault.Hydromancer Thespia"]=BB["Hydromancer Thespia"],
			["InstanceLootHeroic.The Steamvault.Mekgineer Steamrigger"]=BB["Mekgineer Steamrigger"],
			["InstanceLootHeroic.The Steamvault.Warlord Kalithresh"]=BB["Warlord Kalithresh"],
			["InstanceLootHeroic.The Underbog.Ghaz'an"]=BB["Ghaz'an"],
			["InstanceLootHeroic.The Underbog.Hungarfen"]=BB["Hungarfen"],
			["InstanceLootHeroic.The Underbog.Swamplord Musel'ek"]=BB["Swamplord Musel'ek"],
			["InstanceLootHeroic.The Underbog.The Black Stalker"]=BB["The Black Stalker"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Hellfire Citadel"],
		setindex = "InstanceLoot.Hellfire Citadel",
		colour = "|cffB0C4DE",
		header = BZ["Hellfire Citadel"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Hellfire Ramparts.Nazan"]=BB["Nazan"],
			["InstanceLoot.Hellfire Ramparts.Omor the Unscarred"]=BB["Omor the Unscarred"],
			["InstanceLoot.Hellfire Ramparts.Vazruden"]=BB["Vazruden"],
			["InstanceLoot.Hellfire Ramparts.Watchkeeper Gargolmar"]=BB["Watchkeeper Gargolmar"],
			["InstanceLoot.The Blood Furnace.Broggok"]=BB["Broggok"],
			["InstanceLoot.The Blood Furnace.Keli'dan the Breaker"]=BB["Keli'dan the Breaker"],
			["InstanceLoot.The Blood Furnace.The Maker"]=BB["The Maker"],
			["InstanceLoot.The Shattered Halls.Grand Warlock Nethekurse"]=BB["Grand Warlock Nethekurse"],
			["InstanceLoot.The Shattered Halls.Warbringer O'mrogg"]=BB["Warbringer O'mrogg"],
			["InstanceLoot.The Shattered Halls.Warchief Kargath Bladefist"]=BB["Warchief Kargath Bladefist"],
			["InstanceLoot.Magtheridon's Lair.Magtheridon"]=BB["Magtheridon"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Hellfire Citadel"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Hellfire Citadel",
		colour = "|cffB0C4DE",
		header = BZ["Hellfire Citadel"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Hellfire Ramparts.Nazan"]=BB["Nazan"],
			["InstanceLootHeroic.Hellfire Ramparts.Omor the Unscarred"]=BB["Omor the Unscarred"],
			["InstanceLootHeroic.Hellfire Ramparts.Vazruden"]=BB["Vazruden"],
			["InstanceLootHeroic.Hellfire Ramparts.Watchkeeper Gargolmar"]=BB["Watchkeeper Gargolmar"],
			["InstanceLootHeroic.The Blood Furnace.Broggok"]=BB["Broggok"],
			["InstanceLootHeroic.The Blood Furnace.Keli'dan the Breaker"]=BB["Keli'dan the Breaker"],
			["InstanceLootHeroic.The Blood Furnace.The Maker"]=BB["The Maker"],
			["InstanceLootHeroic.The Shattered Halls.Blood Guard Porung"]=BB["Blood Guard Porung"],
			["InstanceLootHeroic.The Shattered Halls.Grand Warlock Nethekurse"]=BB["Grand Warlock Nethekurse"],
			["InstanceLootHeroic.The Shattered Halls.Warbringer O'mrogg"]=BB["Warbringer O'mrogg"],
			["InstanceLootHeroic.The Shattered Halls.Warchief Kargath Bladefist"]=BB["Warchief Kargath Bladefist"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Tempest Keep"],
		setindex = "InstanceLoot.Tempest Keep",
		colour = "|cffB0C4DE",
		header = BZ["Tempest Keep"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Arcatraz.Dalliah the Doomsayer"]=BB["Dalliah the Doomsayer"],
			["InstanceLoot.The Arcatraz.Harbinger Skyriss"]=BB["Harbinger Skyriss"],
			["InstanceLoot.The Arcatraz.Wrath-Scryer Soccothrates"]=BB["Wrath-Scryer Soccothrates"],
			["InstanceLoot.The Arcatraz.Zereketh the Unbound"]=BB["Zereketh the Unbound"],
			["InstanceLoot.The Botanica.Commander Sarannis"]=BB["Commander Sarannis"],
			["InstanceLoot.The Botanica.High Botanist Freywinn"]=BB["High Botanist Freywinn"],
			["InstanceLoot.The Botanica.Laj"]=BB["Laj"],
			["InstanceLoot.The Botanica.Thorngrin the Tender"]=BB["Thorngrin the Tender"],
			["InstanceLoot.The Botanica.Warp Splinter"]=BB["Warp Splinter"],
			["InstanceLoot.The Mechanar.Mechano-Lord Capacitus"]=BB["Mechano-Lord Capacitus"],
			["InstanceLoot.The Mechanar.Nethermancer Sepethrea"]=BB["Nethermancer Sepethrea"],
			["InstanceLoot.The Mechanar.Pathaleon the Calculator"]=BB["Pathaleon the Calculator"],
			["InstanceLoot.The Eye.Al'ar"]=BB["Al'ar"],
			["InstanceLoot.The Eye.High Astromancer Solarian"]=BB["High Astromancer Solarian"],
			["InstanceLoot.The Eye.Kael'thas Sunstrider"]=BB["Kael'thas Sunstrider"],
			["InstanceLoot.The Eye.Void Reaver"]=BB["Void Reaver"],
			["InstanceLoot.The Eye.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Tempest Keep"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Tempest Keep",
		colour = "|cffB0C4DE",
		header = BZ["Tempest Keep"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.The Arcatraz.Dalliah the Doomsayer"]=BB["Dalliah the Doomsayer"],
			["InstanceLootHeroic.The Arcatraz.Harbinger Skyriss"]=BB["Harbinger Skyriss"],
			["InstanceLootHeroic.The Arcatraz.Wrath-Scryer Soccothrates"]=BB["Wrath-Scryer Soccothrates"],
			["InstanceLootHeroic.The Arcatraz.Zereketh the Unbound"]=BB["Zereketh the Unbound"],
			["InstanceLootHeroic.The Botanica.Commander Sarannis"]=BB["Commander Sarannis"],
			["InstanceLootHeroic.The Botanica.High Botanist Freywinn"]=BB["High Botanist Freywinn"],
			["InstanceLootHeroic.The Botanica.Laj"]=BB["Laj"],
			["InstanceLootHeroic.The Botanica.Thorngrin the Tender"]=BB["Thorngrin the Tender"],
			["InstanceLootHeroic.The Botanica.Warp Splinter"]=BB["Warp Splinter"],
			["InstanceLootHeroic.The Mechanar.Mechano-Lord Capacitus"]=BB["Mechano-Lord Capacitus"],
			["InstanceLootHeroic.The Mechanar.Nethermancer Sepethrea"]=BB["Nethermancer Sepethrea"],
			["InstanceLootHeroic.The Mechanar.Pathaleon the Calculator"]=BB["Pathaleon the Calculator"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Karazhan"],
		setindex = "InstanceLoot.Karazhan",
		colour = "|cffB0C4DE",
		header = BZ["Karazhan"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Karazhan.Attumen the Huntsman"]=BB["Attumen the Huntsman"],
			["InstanceLoot.Karazhan.Chess Event"]=BB["Chess Event"],
			["InstanceLoot.Karazhan.Hyakiss the Lurker"]=BB["Hyakiss the Lurker"],
			["InstanceLoot.Karazhan.Julianne"]=BB["Julianne"],
			["InstanceLoot.Karazhan.Maiden of Virtue"]=BB["Maiden of Virtue"],
			["InstanceLoot.Karazhan.Moroes"]=BB["Moroes"],
			["InstanceLoot.Karazhan.Netherspite"]=BB["Netherspite"],
			["InstanceLoot.Karazhan.Nightbane"]=BB["Nightbane"],
			["InstanceLoot.Karazhan.Prince Malchezaar"]=BB["Prince Malchezaar"],
			["InstanceLoot.Karazhan.Romulo"]=BB["Romulo"],
			["InstanceLoot.Karazhan.Shade of Aran"]=BB["Shade of Aran"],
			["InstanceLoot.Karazhan.Terestian Illhoof"]=BB["Terestian Illhoof"],
			["InstanceLoot.Karazhan.The Big Bad Wolf"]=BB["The Big Bad Wolf"],
			["InstanceLoot.Karazhan.The Crone"]=BB["The Crone"],
			["InstanceLoot.Karazhan.The Curator"]=BB["The Curator"],
			["InstanceLoot.Karazhan.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Gruul's Lair"],
		setindex = "InstanceLoot.Gruul's Lair",
		colour = "|cffB0C4DE",
		header = BZ["Gruul's Lair"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Gruul's Lair.High King Maulgar"]=BB["High King Maulgar"],
			["InstanceLoot.Gruul's Lair.Gruul the Dragonkiller"]=BB["Gruul the Dragonkiller"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = L["Outdoor bosses - Outland"],
		setindex = "InstanceLoot.World Bosses",
		colour = "|cffB0C4DE",
		header = L["Outdoor bosses - Outland"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.World Bosses.Doom Lord Kazzak"]=BB["Doom Lord Kazzak"],
			["InstanceLoot.World Bosses.Doomwalker"]=BB["Doomwalker"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Black Temple"],
		setindex = "InstanceLoot.Black Temple",
		colour = "|cffB0C4DE",
		header = BZ["Black Temple"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Black Temple.Gurtogg Bloodboil"]=BB["Gurtogg Bloodboil"],
			["InstanceLoot.Black Temple.High Warlord Naj'entus"]=BB["High Warlord Naj'entus"],
			["InstanceLoot.Black Temple.Illidan Stormrage"]=BB["Illidan Stormrage"],
			["InstanceLoot.Black Temple.Illidari Council"]=BB["The Illidari Council"],
			["InstanceLoot.Black Temple.Mother Shahraz"]=BB["Mother Shahraz"],
			["InstanceLoot.Black Temple.Reliquary of Souls"]=BB["Reliquary of Souls"],
			["InstanceLoot.Black Temple.Shade of Akama"]=BB["Shade of Akama"],
			["InstanceLoot.Black Temple.Supremus"]=BB["Supremus"],
			["InstanceLoot.Black Temple.Teron Gorefiend"]=BB["Teron Gorefiend"],
			["InstanceLoot.Black Temple.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Hyjal Summit"],
		setindex = "InstanceLoot.Hyjal Summit",
		colour = "|cffB0C4DE",
		header = BZ["Hyjal Summit"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Hyjal Summit.Anetheron"]=BB["Anetheron"],
			["InstanceLoot.Hyjal Summit.Archimonde"]=BB["Archimonde"],
			["InstanceLoot.Hyjal Summit.Azgalor"]=BB["Azgalor"],
			["InstanceLoot.Hyjal Summit.Kaz'rogal"]=BB["Kaz'rogal"],
			["InstanceLoot.Hyjal Summit.Rage Winterchill"]=BB["Rage Winterchill"],
			["InstanceLoot.Hyjal Summit.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
		table.insert(MENDELEEV_SETS, {
		name = BZ["Zul'Aman"],
		setindex = "InstanceLoot.Zul'Aman",
		colour = "|cffB0C4DE",
		header = BZ["Zul'Aman"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Zul'Aman.Nalorakk"]=BB["Nalorakk"],
			["InstanceLoot.Zul'Aman.Akil'zon"]=BB["Akil'zon"],
			["InstanceLoot.Zul'Aman.Jan'alai"]=BB["Jan'alai"],
			["InstanceLoot.Zul'Aman.Halazzi"]=BB["Halazzi"],
			["InstanceLoot.Zul'Aman.Malacrass"]=BB["Malacrass"],
			["InstanceLoot.Zul'Aman.Zul'jin"]=BB["Zul'jin"],
			["InstanceLoot.Zul'Aman.Chest1"]=L["Timed Reward Chest1"],
			["InstanceLoot.Zul'Aman.Chest2"]=L["Timed Reward Chest2"],
			["InstanceLoot.Zul'Aman.Chest3"]=L["Timed Reward Chest3"],
			["InstanceLoot.Zul'Aman.Chest4"]=L["Timed Reward Chest4"],
		},
	})

		table.insert(MENDELEEV_SETS, {
		name = BZ["Magisters' Terrace"],
		setindex = "InstanceLoot.Magisters' Terrace",
		colour = "|cffB0C4DE",
		header = BZ["Magisters' Terrace"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Magisters' Terrace.Selin Fireheart"]=BB["Selin Fireheart"],
			["InstanceLoot.Magisters' Terrace.Vexallus"]=BB["Vexallus"],
			["InstanceLoot.Magisters' Terrace.Priestess Delrissa"]=BB["Priestess Delrissa"],
			["InstanceLoot.Magisters' Terrace.Kael'thas Sunstrider"]=BB["Kael'thas Sunstrider"],
		},
	})

		table.insert(MENDELEEV_SETS, {
		name = BZ["Magisters' Terrace"] .. " " .. L["Heroic"],
		setindex = "InstanceLootHeroic.Magisters' Terrace",
		colour = "|cffB0C4DE",
		header = BZ["Magisters' Terrace"] .. " " .. L["Heroic"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLootHeroic.Magisters' Terrace.Selin Fireheart"]=BB["Selin Fireheart"],
			["InstanceLootHeroic.Magisters' Terrace.Vexallus"]=BB["Vexallus"],
			["InstanceLootHeroic.Magisters' Terrace.Priestess Delrissa"]=BB["Priestess Delrissa"],
			["InstanceLootHeroic.Magisters' Terrace.Kael'thas Sunstrider"]=BB["Kael'thas Sunstrider"],
		},
	})

		table.insert(MENDELEEV_SETS, {
		name = BZ["Sunwell Plateau"],
		setindex = "InstanceLoot.Sunwell Plateau",
		colour = "|cffB0C4DE",
		header = BZ["Sunwell Plateau"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Sunwell Plateau.Kalecgos"]=BB["Kalecgos"],
			["InstanceLoot.Sunwell Plateau.Brutallus"]=BB["Brutallus"],
			["InstanceLoot.Sunwell Plateau.Felmyst"]=BB["Felmyst"],
			["InstanceLoot.Sunwell Plateau.The Eredar Twins"]=BB["The Eredar Twins"],
			["InstanceLoot.Sunwell Plateau.M'uru"]=BB["M'uru"],
			["InstanceLoot.Sunwell Plateau.Kil'jaeden"]=BB["Kil'jaeden"],
			["InstanceLoot.Sunwell Plateau.Trash Mobs"]=L["Trash Mobs"],
		},
	})
