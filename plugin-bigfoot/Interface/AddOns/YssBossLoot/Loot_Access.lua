-- functions to get bosses and loot from our tables


local L = LibStub("AceLocale-3.0"):GetLocale("YssBossLoot", true)

local loot = YssBossLoot["Loot"]

local function pathExists(t, k, ...) -- recursive function to check if a table path exists
	if k then
		if t[k] then
			return pathExists(t[k], ...)
		else
			return false
		end
	else
		return true
	end
end

local function splitBosses(list) -- splits the boss string into a table
	local bosses = {}
	for boss in list:gmatch("([^@]+)") do
		bosses[#bosses+1] = boss
	end
	return bosses
end

local bosscache = {}
setmetatable(bosscache, {__mode = "kv"})
function YssBossLoot:GetBosses(instanceType, instance) -- returns all the main bosses in an instance (does not return subbosses)
	local key = instanceType..instance
	if bosscache[key] then return bosscache[key] end
	if pathExists(loot, instanceType, instance) then
		bosscache[key] = splitBosses(loot[instanceType][instance].BossList)
		return bosscache[key]
	else
		bosscache[key] = false
		return false
	end
end

local multibosscache = {}
setmetatable(multibosscache, {__mode = "kv"})
function YssBossLoot:IsMultiBoss(instanceType, instance, boss) -- checks if a boss is comprised of subbosses
	local key = instanceType..instance..boss
	if multibosscache[key] then return multibosscache[key] end
	if pathExists(loot, instanceType, instance, boss) and (type(loot[instanceType][instance][boss]) == "string") then
		multibosscache[key] = splitBosses(loot[instanceType][instance][boss])
		return multibosscache[key]
	else
		multibosscache[key] = false
		return false
	end
end

local function getLoot(t) -- parse the loot strings into a usable table
	local loot = {}
	local kills = {}
	for mode, list in pairs(t) do
		loot[mode] = {
			item = {},
			droprate = {},
		}
		kills[mode] = tonumber(list:match("(.+)@"))
		list = list:gsub(".+@", '')
		local i = 1
		for itemstring in list:gmatch("([^,]+)") do
			local id, value = itemstring:match("^([^:]+):(.+)$")
			id, value = tonumber(id) or tonumber(itemstring), tonumber(value) or true
			loot[mode].item[i] = id
			loot[mode].droprate[i] = value
			i=i+1
		end
	end
	return loot, kills
end

local instanceDifficulties = {
	Dungeon = {
		[1] = L['Normal Loot'],
		[2] = L['Heroic Loot'],
	},
	Raid = {
		[1] = L['Normal 10-man Loot'],
		[2] = L['Normal 25-man Loot'],
		[3] = L['Heroic 10-man Loot'],
		[4] = L['Heroic 25-man Loot'],
	},
	Fallback = L['Loot'],
}

local lootCache = {}
setmetatable(lootCache, {__mode = "kv"})
function YssBossLoot:GetLoot(instanceType, instance, boss, multiboss) -- get the raw loot of a boss
	boss = multiboss and "m:"..boss or boss
	local key = instanceType..instance..boss
	local mBoss = self:IsMultiBoss(instanceType, instance, boss)
	if not lootCache[key] then
		if pathExists(loot, instanceType, instance, boss) then
			if mBoss then
				return nil -- nothing to see here folks
			else
				lootCache[key] = getLoot(loot[instanceType][instance][boss])
			end
		else
			lootCache[key] = false
		end
	end
	local lootDesc = {}
	sortedloot = {}
	if lootCache[key] then
		for i in pairs(lootCache[key]) do
			sortedloot[#sortedloot+1] = i
			lootDesc[i] = instanceDifficulties[instanceType][i]
		end
	end
	table.sort(sortedloot)
	return lootCache[key], lootDesc, sortedloot, mBoss
end

local isBossCache = {}
setmetatable(isBossCache, {__mode = "kv"})
function YssBossLoot:IsBoss(instanceType, instance, boss) -- check if a boss exists
	local key = instanceType..instance..boss
	if isBossCache[key] then return isBossCache[key] end
	if pathExists(loot, instanceType, instance, boss) then
		isBossCache[key] = true
		return true
	else
		isBossCache[key] = false
		return false
	end

end
