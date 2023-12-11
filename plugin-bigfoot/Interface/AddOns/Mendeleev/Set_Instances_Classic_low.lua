	local BB = LibStub("LibBabble-Boss-3.0"):GetLookupTable()
	local BZ = LibStub("LibBabble-Zone-3.0"):GetLookupTable()
	local L = LibStub("AceLocale-3.0"):GetLocale("Mendeleev")
	
	local showDropRate = function (v)
		v = tonumber(v)
		return v and (" (%.1f%%)"):format(v / 10) or ""
	end

	table.insert(MENDELEEV_SETS, {
		name = BZ["Ragefire Chasm"],
		setindex = "InstanceLoot.Ragefire Chasm",
		colour = "|cffB0C4DE",
		header = BZ["Ragefire Chasm"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Ragefire Chasm.Bazzalan"] = BB["Bazzalan"],
			["InstanceLoot.Ragefire Chasm.Jergosh the Invoker"] = BB["Jergosh the Invoker"],
			["InstanceLoot.Ragefire Chasm.Maur Grimtotem"] = BB["Maur Grimtotem"],
			["InstanceLoot.Ragefire Chasm.Taragaman the Hungerer"] = BB["Taragaman the Hungerer"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["The Deadmines"],
		setindex = "InstanceLoot.The Deadmines",
		colour = "|cffB0C4DE",
		header = BZ["The Deadmines"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Deadmines.Brainwashed Noble"] = BB["Brainwashed Noble"],
			["InstanceLoot.The Deadmines.Captain Greenskin"] = BB["Captain Greenskin"],
			["InstanceLoot.The Deadmines.Cookie"] = BB["Cookie"],
			["InstanceLoot.The Deadmines.Edwin VanCleef"] = BB["Edwin VanCleef"],
			["InstanceLoot.The Deadmines.Gilnid"] = BB["Gilnid"],
			["InstanceLoot.The Deadmines.Marisa du'Paige"] = BB["Marisa du'Paige"],
			["InstanceLoot.The Deadmines.Miner Johnson"] = BB["Miner Johnson"],
			["InstanceLoot.The Deadmines.Mr. Smite"] = BB["Mr. Smite"],
			["InstanceLoot.The Deadmines.Rhahk'Zor"] = BB["Rhahk'Zor"],
			["InstanceLoot.The Deadmines.Sneed's Shredder"] = BB["Sneed's Shredder"],
			["InstanceLoot.The Deadmines.Sneed"] = BB["Sneed"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Wailing Caverns"],
		setindex = "InstanceLoot.Wailing Caverns",
		colour = "|cffB0C4DE",
		header = BZ["Wailing Caverns"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Wailing Caverns.Boahn"] = BB["Boahn"],
			["InstanceLoot.Wailing Caverns.Deviate Faerie Dragon"] = BB["Deviate Faerie Dragon"],
			["InstanceLoot.Wailing Caverns.Kresh"] = BB["Kresh"],
			["InstanceLoot.Wailing Caverns.Lady Anacondra"] = BB["Lady Anacondra"],
			["InstanceLoot.Wailing Caverns.Lord Cobrahn"] = BB["Lord Cobrahn"],
			["InstanceLoot.Wailing Caverns.Lord Pythas"] = BB["Lord Pythas"],
			["InstanceLoot.Wailing Caverns.Lord Serpentis"] = BB["Lord Serpentis"],
			["InstanceLoot.Wailing Caverns.Mad Magglish"] = BB["Mad Magglish"],
			["InstanceLoot.Wailing Caverns.Mutanus the Devourer"] = BB["Mutanus the Devourer"],
			["InstanceLoot.Wailing Caverns.Skum"] = BB["Skum"],
			["InstanceLoot.Wailing Caverns.Trigore the Lasher"] = BB["Trigore the Lasher"],
			["InstanceLoot.Wailing Caverns.Verdan the Everliving"] = BB["Verdan the Everliving"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Shadowfang Keep"],
		setindex = "InstanceLoot.Shadowfang Keep",
		colour = "|cffB0C4DE",
		header = BZ["Shadowfang Keep"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Shadowfang Keep.Archmage Arugal"] = BB["Archmage Arugal"],
			["InstanceLoot.Shadowfang Keep.Baron Silverlaine"] = BB["Baron Silverlaine"],
			["InstanceLoot.Shadowfang Keep.Commander Springvale"] = BB["Commander Springvale"],
			["InstanceLoot.Shadowfang Keep.Deathsworn Captain"] = BB["Deathsworn Captain"],
			["InstanceLoot.Shadowfang Keep.Fenrus the Devourer"] = BB["Fenrus the Devourer"],
			["InstanceLoot.Shadowfang Keep.Odo the Blindwatcher"] = BB["Odo the Blindwatcher"],
			["InstanceLoot.Shadowfang Keep.Razorclaw the Butcher"] = BB["Razorclaw the Butcher"],
			["InstanceLoot.Shadowfang Keep.Wolf Master Nandos"] = BB["Wolf Master Nandos"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["The Stockade"],
		setindex = "InstanceLoot.The Stockade",
		colour = "|cffB0C4DE",
		header = BZ["The Stockade"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.The Stockade.Bazil Thredd"] = BB["Bazil Thredd"],
			["InstanceLoot.The Stockade.Bruegal Ironknuckle"] = BB["Bruegal Ironknuckle"],
			["InstanceLoot.The Stockade.Dextren Ward"] = BB["Dextren Ward"],
			["InstanceLoot.The Stockade.Hamhock"] = BB["Hamhock"],
			["InstanceLoot.The Stockade.Kam Deepfury"] = BB["Kam Deepfury"],
			["InstanceLoot.The Stockade.Targorr the Dread"] = BB["Targorr the Dread"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Blackfathom Deeps"],
		setindex = "InstanceLoot.Blackfathom Deeps",
		colour = "|cffB0C4DE",
		header = BZ["Blackfathom Deeps"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Blackfathom Deeps.Aku'mai"] = BB["Aku'mai"],
			["InstanceLoot.Blackfathom Deeps.Baron Aquanis"] = BB["Baron Aquanis"],
			["InstanceLoot.Blackfathom Deeps.Gelihast"] = BB["Gelihast"],
			["InstanceLoot.Blackfathom Deeps.Ghamoo-ra"] = BB["Ghamoo-ra"],
			["InstanceLoot.Blackfathom Deeps.Lady Sarevess"] = BB["Lady Sarevess"],
			["InstanceLoot.Blackfathom Deeps.Twilight Lord Kelris"] = BB["Twilight Lord Kelris"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Gnomeregan"],
		setindex = "InstanceLoot.Gnomeregan",
		colour = "|cffB0C4DE",
		header = BZ["Gnomeregan"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Gnomeregan.Crowd Pummeler 9-60"] = BB["Crowd Pummeler 9-60"],
			["InstanceLoot.Gnomeregan.Dark Iron Ambassador"] = BB["Dark Iron Ambassador"],
			["InstanceLoot.Gnomeregan.Electrocutioner 6000"] = BB["Electrocutioner 6000"],
			["InstanceLoot.Gnomeregan.Grubbis"] = BB["Grubbis"],
			["InstanceLoot.Gnomeregan.Mekgineer Thermaplugg"] = BB["Mekgineer Thermaplugg"],
			["InstanceLoot.Gnomeregan.Techbot"] = BB["Techbot"],
			["InstanceLoot.Gnomeregan.Viscous Fallout"] = BB["Viscous Fallout"]
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Razorfen Kraul"],
		setindex = "InstanceLoot.Razorfen Kraul",
		colour = "|cffB0C4DE",
		header = BZ["Razorfen Kraul"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Razorfen Kraul.Agathelos the Raging"] = BB["Agathelos the Raging"],
			["InstanceLoot.Razorfen Kraul.Blind Hunter"] = BB["Blind Hunter"],
			["InstanceLoot.Razorfen Kraul.Charlga Razorflank"] = BB["Charlga Razorflank"],
			["InstanceLoot.Razorfen Kraul.Death Speaker Jargba"] = BB["Death Speaker Jargba"],
			["InstanceLoot.Razorfen Kraul.Earthcaller Halmgar"] = BB["Earthcaller Halmgar"],
			["InstanceLoot.Razorfen Kraul.Overlord Ramtusk"] = BB["Overlord Ramtusk"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Razorfen Downs"],
		setindex = "InstanceLoot.Razorfen Downs",
		colour = "|cffB0C4DE",
		header = BZ["Razorfen Downs"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Razorfen Downs.Amnennar the Coldbringer"] = BB["Amnennar the Coldbringer"],
			["InstanceLoot.Razorfen Downs.Glutton"] = BB["Glutton"],
			["InstanceLoot.Razorfen Downs.Mordresh Fire Eye"] = BB["Mordresh Fire Eye"],
			["InstanceLoot.Razorfen Downs.Plaguemaw the Rotting"] = BB["Plaguemaw the Rotting"],
			["InstanceLoot.Razorfen Downs.Ragglesnout"] = BB["Ragglesnout"],
			["InstanceLoot.Razorfen Downs.Tuten'kash"] = BB["Tuten'kash"],
		},
	})
	
	table.insert(MENDELEEV_SETS, {
		name = BZ["Scarlet Monastery"],
		setindex = "InstanceLoot.Scarlet Monastery",
		colour = "|cffB0C4DE",
		header = BZ["Scarlet Monastery"],
		useval = showDropRate,
		quality = 3,
		sets = {
			["InstanceLoot.Scarlet Monastery.Arcanist Doan"] = BB["Arcanist Doan"],
			["InstanceLoot.Scarlet Monastery.Azshir the Sleepless"] = BB["Azshir the Sleepless"],
			["InstanceLoot.Scarlet Monastery.Bloodmage Thalnos"] = BB["Bloodmage Thalnos"],
			["InstanceLoot.Scarlet Monastery.Fallen Champion"] = BB["Fallen Champion"],
			["InstanceLoot.Scarlet Monastery.Herod"] = BB["Herod"],
			["InstanceLoot.Scarlet Monastery.High Inquisitor Fairbanks"] = BB["High Inquisitor Fairbanks"],
			["InstanceLoot.Scarlet Monastery.High Inquisitor Whitemane"] = BB["High Inquisitor Whitemane"],
			["InstanceLoot.Scarlet Monastery.Houndmaster Loksey"] = BB["Houndmaster Loksey"],
			["InstanceLoot.Scarlet Monastery.Interrogator Vishas"] = BB["Interrogator Vishas"],
			["InstanceLoot.Scarlet Monastery.Ironspine"] = BB["Ironspine"],
			["InstanceLoot.Scarlet Monastery.Headless Horseman"] = BB["Headless Horseman"],
			["InstanceLoot.Scarlet Monastery.Scarlet Commander Mograine"] = BB["Scarlet Commander Mograine"],
		},
	})
