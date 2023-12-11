	local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
	local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
	local L = LibStub("AceLocale-3.0"):GetLocale("Mendeleev")
	
	local showDropRate = function (v)
		v = tonumber(v)
		return v and (" (%.1f%%)"):format(v / 10) or ""
	end

	table.insert(MENDELEEV_SETS, {
		name = L["Elemental bosses"],
		setindex = "InstanceLoot.World Bosses",
		colour = "|cffB0C4DE",
		header = L["Elemental bosses"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.World Bosses.Avalanchion"] = BB["Avalanchion"],
			["InstanceLoot.World Bosses.The Windreaver"] = BB["The Windreaver"],
			["InstanceLoot.World Bosses.Baron Charr"] = BB["Baron Charr"],
			["InstanceLoot.World Bosses.Princess Tempestria"] = BB["Princess Tempestria"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Dire Maul"],
		setindex = "InstanceLoot.Dire Maul",
		colour = "|cffB0C4DE",
		header = BZ["Dire Maul"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Dire Maul North.King Gordok"] = BB["King Gordok"],
			["InstanceLoot.Dire Maul North.Cho'Rush the Observer"] = BB["Cho'Rush the Observer"],
			["InstanceLoot.Dire Maul North.Captain Kromcrush"] = BB["Captain Kromcrush"],
			["InstanceLoot.Dire Maul North.Guard Fengus"] = BB["Guard Fengus"],
			["InstanceLoot.Dire Maul North.Guard Mol'dar"] = BB["Guard Mol'dar"],
			["InstanceLoot.Dire Maul North.Guard Slip'kik"] = BB["Guard Slip'kik"],
			["InstanceLoot.Dire Maul North.Stomper Kreeg"] = BB["Stomper Kreeg"],
			["InstanceLoot.Dire Maul West.Lord Hel'nurath"] = BB["Lord Hel'nurath"],
			["InstanceLoot.Dire Maul West.Illyanna Ravenoak"] = BB["Illyanna Ravenoak"],
			["InstanceLoot.Dire Maul West.Immol'thar"] = BB["Immol'thar"],
			["InstanceLoot.Dire Maul West.Magister Kalendris"] = BB["Magister Kalendris"],
			["InstanceLoot.Dire Maul West.Tendris Warpwood"] = BB["Tendris Warpwood"],
			["InstanceLoot.Dire Maul West.Prince Tortheldrin"] = BB["Prince Tortheldrin"],
			["InstanceLoot.Dire Maul West.Tsu'zee"] = BB["Tsu'zee"],
			["InstanceLoot.Dire Maul East.Pimgib"] = BB["Pimgib"],
			["InstanceLoot.Dire Maul East.Alzzin the Wildshaper"] = BB["Alzzin the Wildshaper"],
			["InstanceLoot.Dire Maul East.Zevrim Thornhoof"] = BB["Zevrim Thornhoof"],
			["InstanceLoot.Dire Maul East.Hydrospawn"] = BB["Hydrospawn"],
			["InstanceLoot.Dire Maul East.Lethtendris"] = BB["Lethtendris"],
			["InstanceLoot.Dire Maul East.Pusillin"] = BB["Pusillin"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Maraudon"],
		setindex = "InstanceLoot.Maraudon",
		colour = "|cffB0C4DE",
		header = BZ["Maraudon"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Maraudon.Celebras the Cursed"] = BB["Celebras the Cursed"],
			["InstanceLoot.Maraudon.Gelk"] = BB["Gelk"],
			["InstanceLoot.Maraudon.Kolk"] = BB["Kolk"],
			["InstanceLoot.Maraudon.Landslide"] = BB["Landslide"],
			["InstanceLoot.Maraudon.Lord Vyletongue"] = BB["Lord Vyletongue"],
			["InstanceLoot.Maraudon.Magra"] = BB["Magra"],
			["InstanceLoot.Maraudon.Maraudos"] = BB["Maraudos"],
			["InstanceLoot.Maraudon.Meshlok the Harvester"] = BB["Meshlok the Harvester"],
			["InstanceLoot.Maraudon.Noxxion"] = BB["Noxxion"],
			["InstanceLoot.Maraudon.Princess Theradras"] = BB["Princess Theradras"],
			["InstanceLoot.Maraudon.Razorlash"] = BB["Razorlash"],
			["InstanceLoot.Maraudon.Rotgrip"] = BB["Rotgrip"],
			["InstanceLoot.Maraudon.Tinkerer Gizlock"] = BB["Tinkerer Gizlock"],
			["InstanceLoot.Maraudon.Veng"] = BB["Veng"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = L["UBRS"],
		setindex = "InstanceLoot.Upper Blackrock Spire",
		colour = "|cffB0C4DE",
		header = L["UBRS"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Upper Blackrock Spire.General Drakkisath"] = BB["General Drakkisath"],
			  ["InstanceLoot.Upper Blackrock Spire.Warchief Rend Blackhand"] = BB["Warchief Rend Blackhand"],
			  ["InstanceLoot.Upper Blackrock Spire.Gyth"] = BB["Gyth"],
			  ["InstanceLoot.Upper Blackrock Spire.Goraluk Anvilcrack"] = BB["Goraluk Anvilcrack"],
			  ["InstanceLoot.Upper Blackrock Spire.Pyroguard Emberseer"] = BB["Pyroguard Emberseer"],
			  ["InstanceLoot.Upper Blackrock Spire.Solakar Flamewreath"] = BB["Solakar Flamewreath"],
			  ["InstanceLoot.Upper Blackrock Spire.The Beast"] = BB["The Beast"],
			}
	})
	
	table.insert(MENDELEEV_SETS, {
		name = L["LBRS"],
		setindex = "InstanceLoot.Lower Blackrock Spire",
		colour = "|cffB0C4DE",
		header = L["LBRS"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Lower Blackrock Spire.Halycon"] = BB["Halycon"],
			  ["InstanceLoot.Lower Blackrock Spire.Crystal Fang"] = BB["Crystal Fang"],
			  ["InstanceLoot.Lower Blackrock Spire.Mother Smolderweb"] = BB["Mother Smolderweb"],
			  ["InstanceLoot.Lower Blackrock Spire.Overlord Wyrmthalak"] = BB["Overlord Wyrmthalak"],
			  ["InstanceLoot.Lower Blackrock Spire.Highlord Omokk"] = BB["Highlord Omokk"],
			  ["InstanceLoot.Lower Blackrock Spire.War Master Voone"] = BB["War Master Voone"],
			  ["InstanceLoot.Lower Blackrock Spire.Shadow Hunter Vosh'gajin"] = BB["Shadow Hunter Vosh'gajin"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Blackrock Depths"],
		setindex = "InstanceLoot.Blackrock Depths",
		colour = "|cffB0C4DE",
		header = BZ["Blackrock Depths"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Blackrock Depths.Ambassador Flamelash"] = BB["Ambassador Flamelash"],
			  ["InstanceLoot.Blackrock Depths.Anub'shiah"] = BB["Anub'shiah"],
			  ["InstanceLoot.Blackrock Depths.Bael'Gar"] = BB["Bael'Gar"],
			  ["InstanceLoot.Blackrock Depths.Emperor Dagran Thaurissan"] = BB["Emperor Dagran Thaurissan"],
			  ["InstanceLoot.Blackrock Depths.Fineous Darkvire"] = BB["Fineous Darkvire"],
			  ["InstanceLoot.Blackrock Depths.General Angerforge"] = BB["General Angerforge"],
			  ["InstanceLoot.Blackrock Depths.Golem Lord Argelmach"] = BB["Golem Lord Argelmach"],
			  ["InstanceLoot.Blackrock Depths.Gorosh the Dervish"] = BB["Gorosh the Dervish"],
			  ["InstanceLoot.Blackrock Depths.Grizzle"] = BB["Grizzle"],
			  ["InstanceLoot.Blackrock Depths.Hedrum the Creeper"] = BB["Hedrum the Creeper"],
			  ["InstanceLoot.Blackrock Depths.High Interrogator Gerstahn"] = BB["High Interrogator Gerstahn"],
			  ["InstanceLoot.Blackrock Depths.High Priestess of Thaurissan"] = BB["High Priestess of Thaurissan"],
			  ["InstanceLoot.Blackrock Depths.Houndmaster Grebmar"] = BB["Houndmaster Grebmar"],
			  ["InstanceLoot.Blackrock Depths.Hurley Blackbreath"] = BB["Hurley Blackbreath"],
			  ["InstanceLoot.Blackrock Depths.Lord Incendius"] = BB["Lord Incendius"],
			  ["InstanceLoot.Blackrock Depths.Lord Roccor"] = BB["Lord Roccor"],
			  ["InstanceLoot.Blackrock Depths.Magmus"] = BB["Magmus"],
			  ["InstanceLoot.Blackrock Depths.Ok'thor the Breaker"] = BB["Ok'thor the Breaker"],
			  ["InstanceLoot.Blackrock Depths.Panzor the Invincible"] = BB["Panzor the Invincible"],
			  ["InstanceLoot.Blackrock Depths.Phalanx"] = BB["Phalanx"],
			  ["InstanceLoot.Blackrock Depths.Plugger Spazzring"] = BB["Plugger Spazzring"],
			  ["InstanceLoot.Blackrock Depths.Princess Moira Bronzebeard"] = BB["Princess Moira Bronzebeard"],
			  ["InstanceLoot.Blackrock Depths.Ribbly Screwspigot"] = BB["Ribbly Screwspigot"],
			  ["InstanceLoot.Blackrock Depths.The Seven Dwarves"] = BB["The Seven Dwarves"],
			  ["InstanceLoot.Blackrock Depths.Verek"] = BB["Verek"],
			  ["InstanceLoot.Blackrock Depths.Warder Stilgiss"] = BB["Warder Stilgiss"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Scholomance"],
		setindex = "InstanceLoot.Scholomance",
		colour = "|cffB0C4DE",
		header = BZ["Scholomance"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Scholomance.Lord Alexei Barov"] = BB["Lord Alexei Barov"],
			  ["InstanceLoot.Scholomance.Darkmaster Gandling"] = BB["Darkmaster Gandling"],
			  ["InstanceLoot.Scholomance.Kirtonos the Herald"] = BB["Kirtonos the Herald"],
			  ["InstanceLoot.Scholomance.Rattlegore"] = BB["Rattlegore"],
			  ["InstanceLoot.Scholomance.Vectus"] = BB["Vectus"],
			  ["InstanceLoot.Scholomance.Marduk Blackpool"] = BB["Marduk Blackpool"],
			  ["InstanceLoot.Scholomance.Ras Frostwhisper"] = BB["Ras Frostwhisper"],
			  ["InstanceLoot.Scholomance.Jandice Barov"] = BB["Jandice Barov"],
			  ["InstanceLoot.Scholomance.Doctor Theolen Krastinov"] = BB["Doctor Theolen Krastinov"],
			  ["InstanceLoot.Scholomance.The Ravenian"] = BB["The Ravenian"],
			  ["InstanceLoot.Scholomance.Lorekeeper Polkelt"] = BB["Lorekeeper Polkelt"],
			  ["InstanceLoot.Scholomance.Instructor Malicia"] = BB["Instructor Malicia"],
			  ["InstanceLoot.Scholomance.Jandice Barov"] = BB["Jandice Barov"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Stratholme"],
		setindex = "InstanceLoot.Stratholme",
		colour = "|cffB0C4DE",
		header = BZ["Stratholme"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Stratholme.Baron Rivendare"] = BB["Baron Rivendare"],
			  ["InstanceLoot.Stratholme.Baroness Anastari"] = BB["Baroness Anastari"],
			  ["InstanceLoot.Stratholme.Magistrate Barthilas"] = BB["Magistrate Barthilas"],
			  ["InstanceLoot.Stratholme.Maleki the Pallid"] = BB["Maleki the Pallid"],
			  ["InstanceLoot.Stratholme.Nerub'enkan"] = BB["Nerub'enkan"],
			  ["InstanceLoot.Stratholme.Ramstein the Gorger"] = BB["Ramstein the Gorger"],
			  ["InstanceLoot.Stratholme.Archivist Galford"] = BB["Archivist Galford"],
			  ["InstanceLoot.Stratholme.Cannon Master Willey"] = BB["Cannon Master Willey"],
			  ["InstanceLoot.Stratholme.Balnazzar"] = BB["Balnazzar"],
			  ["InstanceLoot.Stratholme.Timmy the Cruel"] = BB["Timmy the Cruel"],
			  ["InstanceLoot.Stratholme.Hearthsinger Forresten"] = BB["Hearthsinger Forresten"],
			  ["InstanceLoot.Stratholme.Postmaster Malown"] = BB["Postmaster Malown"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["The Temple of Atal'Hakkar"],
		setindex = "InstanceLoot.Sunken Temple",
		colour = "|cffB0C4DE",
		header = BZ["The Temple of Atal'Hakkar"],
		useval = showDropRate,
		quality = 3,
		sets = {
			  ["InstanceLoot.Sunken Temple.Weaver"] = BB["Weaver"],
			  ["InstanceLoot.Sunken Temple.Zolo"] = BB["Zolo"],
			  ["InstanceLoot.Sunken Temple.Loro"] = BB["Loro"],
			  ["InstanceLoot.Sunken Temple.Gasher"] = BB["Gasher"],
			  ["InstanceLoot.Sunken Temple.Hukku"] = BB["Hukku"],
			  ["InstanceLoot.Sunken Temple.Mijan"] = BB["Mijan"],
			  ["InstanceLoot.Sunken Temple.Zul'Lor"] = BB["Zul'Lor"],
			  ["InstanceLoot.Sunken Temple.Avatar of Hakkar"] = BB["Avatar of Hakkar"],
			  ["InstanceLoot.Sunken Temple.Shade of Eranikus"] = BB["Shade of Eranikus"],
			  ["InstanceLoot.Sunken Temple.Jammal'an the Prophet"] = BB["Jammal'an the Prophet"],
			  ["InstanceLoot.Sunken Temple.Atal'alarion"] = BB["Atal'alarion"],
			  ["InstanceLoot.Sunken Temple.Dreamscythe"] = BB["Dreamscythe"],
			  ["InstanceLoot.Sunken Temple.Ogom the Wretched"] = BB["Ogom the Wretched"],
			  ["InstanceLoot.Sunken Temple.Morphaz"] = BB["Morphaz"],
			  ["InstanceLoot.Sunken Temple.Hazzas"] = BB["Hazzas"],
			}
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Blackwing Lair"],
		setindex = "InstanceLoot.Blackwing Lair",
		colour = "|cffB0C4DE",
		header = BZ["Blackwing Lair"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Blackwing Lair.Nefarian"] = BB["Nefarian"],
			["InstanceLoot.Blackwing Lair.Vaelastrasz the Corrupt"] = BB["Vaelastrasz the Corrupt"],
			["InstanceLoot.Blackwing Lair.Razorgore the Untamed"] = BB["Razorgore the Untamed"],
			["InstanceLoot.Blackwing Lair.Broodlord Lashlayer"] = BB["Broodlord Lashlayer"],
			["InstanceLoot.Blackwing Lair.Chromaggus"] = BB["Chromaggus"],
			["InstanceLoot.Blackwing Lair.Ebonroc"] = BB["Ebonroc"],
			["InstanceLoot.Blackwing Lair.Firemaw"] = BB["Firemaw"],
			["InstanceLoot.Blackwing Lair.Flamegor"] = BB["Flamegor"],
			["InstanceLoot.Blackwing Lair.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Molten Core"],
		setindex = "InstanceLoot.Molten Core",
		colour = "|cffB0C4DE",
		header = BZ["Molten Core"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Molten Core.Majordomo Executus"]  = BB["Majordomo Executus"],
			["InstanceLoot.Molten Core.Magmadar"] = BB["Magmadar"],
			["InstanceLoot.Molten Core.Ragnaros"] = BB["Ragnaros"],
			["InstanceLoot.Molten Core.Baron Geddon"] = BB["Baron Geddon"],
			["InstanceLoot.Molten Core.Garr"] = BB["Garr"],
			["InstanceLoot.Molten Core.Golemagg the Incinerator"] = BB["Golemagg the Incinerator"],
			["InstanceLoot.Molten Core.Sulfuron Harbinger"] = BB["Sulfuron Harbinger"],
			["InstanceLoot.Molten Core.Shazzrah"] = BB["Shazzrah"],
			["InstanceLoot.Molten Core.Lucifron"] = BB["Lucifron"],
			["InstanceLoot.Molten Core.Gehennas"] = BB["Gehennas"],
			["InstanceLoot.Molten Core.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = L["Outdoor bosses"],
		setindex = "InstanceLoot.World Bosses",
		colour = "|cffB0C4DE",
		header = L["Outdoor bosses"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.World Bosses.Azuregos"] = BB["Azuregos"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = L["Four Dragons"],
		setindex = "InstanceLoot.World Bosses",
		colour = "|cffB0C4DE",
		header = L["Four Dragons"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.World Bosses.Ysondre"] = BB["Ysondre"],
			["InstanceLoot.World Bosses.Emeriss"] = BB["Emeriss"],
			["InstanceLoot.World Bosses.Taerar"] = BB["Taerar"],
			["InstanceLoot.World Bosses.Lethon"] = BB["Lethon"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Onyxia's Lair"],
		setindex = "InstanceLoot.Onyxia's Lair",
		colour = "|cffB0C4DE",
		header = BZ["Onyxia's Lair"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Onyxia's Lair.Onyxia"] = BB["Onyxia"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Zul'Gurub"],
		setindex = "InstanceLoot.Zul'Gurub",
		colour = "|cffB0C4DE",
		header = BZ["Zul'Gurub"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Zul'Gurub.High Priestess Jeklik"] = BB["High Priestess Jeklik"],
			["InstanceLoot.Zul'Gurub.High Priest Venoxis"] = BB["High Priest Venoxis"],
			["InstanceLoot.Zul'Gurub.High Priest Thekal"] = BB["High Priest Thekal"],
			["InstanceLoot.Zul'Gurub.High Priestess Arlokk"] = BB["High Priestess Arlokk"],
			["InstanceLoot.Zul'Gurub.High Priestess Mar'li"] = BB["High Priestess Mar'li"],
			["InstanceLoot.Zul'Gurub.Jin'do the Hexxer"] = BB["Jin'do the Hexxer"],
			["InstanceLoot.Zul'Gurub.Bloodlord Mandokir"] = BB["Bloodlord Mandokir"],
			["InstanceLoot.Zul'Gurub.Gahz'ranka"] = BB["Gahz'ranka"],
			["InstanceLoot.Zul'Gurub.Gri'lek"] = BB["Gri'lek"],
			["InstanceLoot.Zul'Gurub.Hazza'rah"] = BB["Hazza'rah"],
			["InstanceLoot.Zul'Gurub.Renataki"] = BB["Renataki"],
			["InstanceLoot.Zul'Gurub.Wushoolay"] = BB["Wushoolay"],
			["InstanceLoot.Zul'Gurub.Hakkar"] = BB["Hakkar"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Zul'Farrak"],
		setindex = "InstanceLoot.Zul'Farrak",
		colour = "|cffB0C4DE",
		header = BZ["Zul'Farrak"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Zul'Farrak.Antu'sul"] = BB["Antu'sul"],
			["InstanceLoot.Zul'Farrak.Chief Ukorz Sandscalp"] = BB["Chief Ukorz Sandscalp"],
			["InstanceLoot.Zul'Farrak.Gahz'rilla"] = BB["Gahz'rilla"],
			["InstanceLoot.Zul'Farrak.Hydromancer Velratha"] = BB["Hydromancer Velratha"],
			["InstanceLoot.Zul'Farrak.Nekrum Gutchewer"] = BB["Nekrum Gutchewer"],
			["InstanceLoot.Zul'Farrak.Ruuzlu"] = BB["Ruuzlu"],
			["InstanceLoot.Zul'Farrak.Sandfury Executioner"] = BB["Sandfury Executioner"],
			["InstanceLoot.Zul'Farrak.Sergeant Bly"] = BB["Sergeant Bly"],
			["InstanceLoot.Zul'Farrak.Theka the Martyr"] = BB["Theka the Martyr"],
			["InstanceLoot.Zul'Farrak.Witch Doctor Zum'rah"] = BB["Witch Doctor Zum'rah"],
			["InstanceLoot.Zul'Farrak.Zerillis"] = BB["Zerillis"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Ruins of Ahn'Qiraj"],
		setindex = "InstanceLoot.Ruins of Ahn'Qiraj",
		colour = "|cffB0C4DE",
		header = BZ["Ruins of Ahn'Qiraj"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Ruins of Ahn'Qiraj.Buru the Gorger"] = BB["Buru the Gorger"],
			["InstanceLoot.Ruins of Ahn'Qiraj.General Rajaxx"] = BB["General Rajaxx"],
			["InstanceLoot.Ruins of Ahn'Qiraj.Ossirian the Unscarred"] = BB["Ossirian the Unscarred"],
			["InstanceLoot.Ruins of Ahn'Qiraj.Kurinnaxx"] = BB["Kurinnaxx"],
			["InstanceLoot.Ruins of Ahn'Qiraj.Moam"] = BB["Moam"],
			["InstanceLoot.Ruins of Ahn'Qiraj.Ayamiss the Hunter"] = BB["Ayamiss the Hunter"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Temple of Ahn'Qiraj"],
		setindex = "InstanceLoot.Ahn'Qiraj",
		colour = "|cffB0C4DE",
		header = BZ["Temple of Ahn'Qiraj"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Ahn'Qiraj.Battleguard Sartura"] = BB["Battleguard Sartura"],
			["InstanceLoot.Ahn'Qiraj.The Prophet Skeram"] = BB["The Prophet Skeram"],
			["InstanceLoot.Ahn'Qiraj.Princess Huhuran"] = BB["Princess Huhuran"],
			["InstanceLoot.Ahn'Qiraj.Princess Yauj"] = BB["Princess Yauj"],
			["InstanceLoot.Ahn'Qiraj.Fankriss the Unyielding"] = BB["Fankriss the Unyielding"],
			["InstanceLoot.Ahn'Qiraj.Lord Kri"] = BB["Lord Kri"],
			["InstanceLoot.Ahn'Qiraj.C'Thun"] = BB["C'Thun"],
			["InstanceLoot.Ahn'Qiraj.Ouro"] = BB["Ouro"],
			["InstanceLoot.Ahn'Qiraj.Vem"] = BB["Vem"],
			["InstanceLoot.Ahn'Qiraj.Viscidus"] = BB["Viscidus"],
			["InstanceLoot.Ahn'Qiraj.Emperor Vek'lor"] = BB["Emperor Vek'lor"],
			["InstanceLoot.Ahn'Qiraj.Emperor Vek'nilash"] = BB["Emperor Vek'nilash"],
			["InstanceLoot.Ahn'Qiraj.Trash Mobs"]=L["Trash Mobs"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Uldaman"],
		setindex = "InstanceLoot.Uldaman",
		colour = "|cffB0C4DE",
		header = BZ["Uldaman"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Uldaman.Ancient Stone Keeper"] = BB["Ancient Stone Keeper"],
			["InstanceLoot.Uldaman.Archaedas"] = BB["Archaedas"],
			["InstanceLoot.Uldaman.Baelog"] = BB["Baelog"],
			["InstanceLoot.Uldaman.Digmaster Shovelphlange"] = BB["Digmaster Shovelphlange"],
			["InstanceLoot.Uldaman.Galgann Firehammer"] = BB["Galgann Firehammer"],
			["InstanceLoot.Uldaman.Grimlok"] = BB["Grimlok"],
			["InstanceLoot.Uldaman.Ironaya"] = BB["Ironaya"],
			["InstanceLoot.Uldaman.Obsidian Sentinel"] = BB["Obsidian Sentinel"],
			["InstanceLoot.Uldaman.Revelosh"] = BB["Revelosh"],
		},
	})