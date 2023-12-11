--[===[@debug@
local DataVersion = 1
--@end-debug@]===]
--@non-debug@
local DataVersion = 20100912223826 or 1
--@end-non-debug@
local lib = LibStub:NewLibrary("LibInstanceLootData-1.0", DataVersion)

if not lib then
  return	-- already loaded and no upgrade necessary
end
--ILD = lib -- for standalone debugging

lib.data = LibStub("LibInstanceLootData_data-1.0")

--- Returns an alphabethicaly sorted table of available Instance Types.
-- @return table sorted list of Instance Types
function lib:GetInstanceTypeList()
	local typeList = {}
	for iType in pairs(lib.data.Loot) do
		typeList[#typeList+1] = iType
	end
	table.sort(typeList)
	return typeList
end

--- Returns an alpabethically sorted table of Intances found within a given Instance Type.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @return table sorted list of Instances within the given Instance Type 
function lib:GetInstanceList(iType)
	local instanceList = {}
	for instance in pairs(lib.data.Loot[iType]) do
		instanceList[#instanceList+1] = instance
	end
	table.sort(instanceList)
	return instanceList
end

--- Returns an sorted table of Bosses found within a given Instance.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @return table sorted list of Bosses within the given Instance
function lib:GetBossList(iType, instance)
	local bossList = {}
	for boss in string.gmatch(lib.data.Loot[iType][instance].SortedBossList, "([^|]+)") do
		bossList[#bossList+1] = boss
	end
	return bossList
end

--- Some bosses do not have loot (Most likey because they are new and wowhead doesn't have any data yet).
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param boss boss taken from :GetBossList(iType, instance)
-- @return boolean indicating if Boss has loot
function lib:HasLoot(iType, instance, boss)
	if lib.data.Loot[iType] and lib.data.Loot[iType][instance] and lib.data.Loot[iType][instance][boss] then
		return true
	else
		return false
	end
end

--- Returns a list of instance difficulties we have loot data for. Difficulties range from 0-4.
-- 0 is used for instances that do not have difficulties.
-- 1-4 follow the form of GetInstanceDifficulty()
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param boss boss taken from :GetBossList(iType, instance)
-- @return table containing all difficulties we have data for
function lib:GetBossDifficulties(iType, instance, boss)
	local difficultiesList = {}
	local bossstring = lib.data.Loot[iType][instance][boss]
	if bossstring then
		for difficulty in string.gmatch(bossstring, "(%d+)@[^|]+") do
			difficultiesList[#difficultiesList+1] = tonumber(difficulty)
		end
		table.sort(difficultiesList)
	end
	return difficultiesList
end

lib.instanceDifficulties = {
	Dungeon = {
		[0] = 'Loot',
		['s0'] = '',
		[1] = 'Normal Loot',
		['s1'] = 'N',
		[2] = 'Heroic Loot',
		['s2'] = 'H',
	},
	Raid = {
		[0] = 'Loot',
		['s0'] = '',
		[1] = 'Normal 10-man Loot',
		['s1'] = 'N10',
		[2] = 'Normal 25-man Loot',
		['s2'] = 'N25',
		[3] = 'Heroic 10-man Loot',
		['s3'] = 'H10',
		[4] = 'Heroic 25-man Loot',
		['s4'] = 'H25',
	},
	Fallback = 'Loot',
}

--- Returns a Localized string corresponding to each difficulty.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param difficulty Number 0-4
-- @return string Localized difficulty string i.e. "Heroic 10-man Loot"
function lib:GetDifficultyString(iType, difficulty, short)
	if not iType or not difficulty then
		return lib.L[lib.instanceDifficulties.Fallback]
	elseif short then
		return lib.L[lib.instanceDifficulties[iType]['s'..difficulty]]
	else
		return lib.L[lib.instanceDifficulties[iType][tonumber(difficulty)]]
	end
end

--- Returns a sorted list of item IDs.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param boss boss taken from :GetBossList(iType, instance)
-- @param difficulty difficulty taken from :GetBossDifficulties(iType, instance, boss)
-- @return table containing all items we have on record for the given boss and difficulty
function lib:GetBossLootByDifficulties(iType, instance, boss, difficulty)
	local itemlist = {}
	local items = string.match(lib.data.Loot[iType][instance][boss], "|*"..difficulty.."@([^|]+)")
	
	for itemID in string.gmatch(items, "(%d+):[^,]+") do
		itemlist[#itemlist+1] = itemID
	end
	return itemlist
end

--- Returns a sorted list of items.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param boss boss taken from :GetBossList(iType, instance)
-- @param difficulty difficulty taken from :GetBossDifficulties(iType, instance, boss)
-- @param itemID itemID taken from :GetBossLootByDifficulties(iType, instance, boss, difficulty)
-- @return number droprate for the given Item
function lib:GetBossLootDropRate(iType, instance, boss, difficulty, itemID)
	local items = string.match(lib.data.Loot[iType][instance][boss], "|*"..difficulty.."([^|]+)")
	local rate = tonumber(string.match(items, "[,@]+"..itemID..":([^,]+)"))
	if not rate or rate == -1 then 
		return nil
	else
		return rate/100
	end
end

--- Returns alphabethical list of Multibosses. A Multiboss is either a boss that has multible drop sources or modes such as Opra Event in Kara Sarth +1D +2D or +3D etc.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @return table of multibosses
function lib:GetMultiBosses(iType, instance)
	local bossList = {}
	if lib.data.MultiBosses[iType] and lib.data.MultiBosses[iType][instance] then
		for boss in pairs(lib.data.MultiBosses[iType][instance]) do
			bossList[#bossList+1] = boss
		end
	end
	return bossList
end

--- Returns a sorted list of Multiboss subBosses.
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param multiboss boss taken from :GetMultiBosses(iType, instance)
-- @return table returns subBosses
function lib:GetMultiSubBosses(iType, instance, multiboss)
	if lib.data.MultiBosses[iType] and lib.data.MultiBosses[iType][instance] and lib.data.MultiBosses[iType][instance][multiboss] then
		local bossList = {}
		for boss in string.gmatch(lib.data.MultiBosses[iType][instance][multiboss], "([^|]+)") do
			bossList[#bossList+1] = boss
		end
		return bossList
	end
end

--- Check to see if a Boss is part of a Multiboss. returns the Multiboss or nil
-- @param iType Instance Type taken from :GetInstanceTypeList()
-- @param instance Instance taken from :GetInstanceList(iType)
-- @param boss boss taken from :GetBossList(iType, instance)
-- @return string returns Multiboss or nil
function lib:IsSubBoss(iType, instance, boss)
	if lib.data.MultiBosses[iType] and lib.data.MultiBosses[iType][instance] then
		for multiboss, s in pairs(lib.data.MultiBosses[iType][instance]) do
			for subboss in string.gmatch(s, "([^|]+)") do
				if subboss == boss then
					return multiboss
				end
			end
		end
	end
end

local FindItemCache = {}
setmetatable(FindItemCache, {__mode = "kv"})
--- Checks to see if an item is found somewhere in our data. Any results are cached but are free to be GC'ed. returns the instance/boss with the highest droprate.
-- @param itemID itemID of the item to be searched for
-- @return instanceType Type of the instance we can  this item
-- @return instance name of the instance we can this itme
-- @return boss name of boss that drops this item
-- @return difficulty difficulty this item drops in
-- @return droprate droprate of item or nil
function lib:FindItem(itemID)
	if FindItemCache[itemID] then
		if FindItemCache[itemID] == 'nil' then
			return nil
		else
			local iType, instance, boss, difficulty, droprate = string.match(FindItemCache[itemID], "(.+)|(.+)|(.+)|(.+)|(.+)")
			return iType, instance, boss, difficulty, (tonumber(droprate) > 0 and droprate/100 or droprate)
		end
	else
		local iType, instance, boss, difficulty, droprate
		for t in pairs(lib.data.Loot) do
			for i in pairs(lib.data.Loot[t]) do
				for _, b in ipairs(lib:GetBossList(t, i)) do
					if lib.data.Loot[t][i][b] then
						for _, d in ipairs(lib:GetBossDifficulties(t, i, b)) do
							local items = string.match(lib.data.Loot[t][i][b], "|*"..d.."(@[^|]+)")
							local rate = string.match(items, "[,@]+"..itemID..":([^,]+)")
							if rate then
								if rate == -1 then
									rate = 0
								end
								if rate and (not droprate or rate > droprate) then
									iType, instance, boss, difficulty, droprate = t, i, b, d, rate
								end
							end
						end
					end
				end
			end
		end
		if iType then
			FindItemCache[itemID] = string.format("%s|%s|%s|%s|%s", iType, instance, boss, difficulty, tostring(droprate))
		else
			FindItemCache[itemID] = 'nil'
		end
		if iType then
			return iType, instance, boss, difficulty, (tonumber(droprate) > 0 and droprate/100 or droprate)
		else
			return nil
		end
	end
end

lib.L = {
	['Loot'] = 'Loot',
	['Normal Loot'] = 'Normal Loot',
	['Heroic Loot'] = 'Heroic Loot',
	['Normal 10-man Loot'] = 'Normal 10-man Loot',
	['Normal 25-man Loot'] = 'Normal 25-man Loot',
	['Heroic 10-man Loot'] = 'Heroic 10-man Loot',
	['Heroic 25-man Loot'] = 'Heroic 25-man Loot',
	['N'] = 'N',
	['H'] = 'H',
	['N10'] = 'N10',
	['N25'] = 'N25',
	['H10'] = 'H10',
	['H25'] = 'H25',
}

--[===[@debug@
function ILBTest()
	Spew("GetInstanceTypeList()", lib:GetInstanceTypeList())
	Spew("GetInstanceList('Raid')", lib:GetInstanceList('Raid'))
	Spew("GetBossList('Raid', 'Ulduar')", lib:GetBossList('Raid', 'Ulduar'))
	Spew("GetBossDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor')", lib:GetBossDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor'))
	Spew("GetDifficultyString('Raid', 1)", lib:GetDifficultyString('Raid', 1))
	Spew("GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 1)", lib:GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 1))
	Spew("GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 2)", lib:GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 2))
	Spew("GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 3)", lib:GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 3))
	Spew("GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 4)", lib:GetBossLootByDifficulties('Raid', 'Ulduar', 'XT-002 Deconstructor', 4))
	Spew("GetBossLootDropRate('Raid', 'Ulduar', 'XT-002 Deconstructor', 1, 40429)", lib:GetBossLootDropRate('Raid', 'Ulduar', 'XT-002 Deconstructor', 1, 40429))
	Spew("GetMultiBosses('Raid', 'Ulduar')", lib:GetMultiBosses('Raid', 'Ulduar'))
	Spew("GetMultiSubBosses('Raid', 'Ulduar', 'XT-002 Deconstructor')", lib:GetMultiSubBosses('Raid', 'Ulduar', 'XT-002 Deconstructor'))
	Spew("FindItem(40429)", lib:FindItem(40429))
	Spew("FindItem(3371)", lib:FindItem(3371))
end
print("ILD lib.lua loaded")
--@end-debug@]===]