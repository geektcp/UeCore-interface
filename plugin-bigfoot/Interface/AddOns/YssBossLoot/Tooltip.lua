
local YssBossLoot = YssBossLoot
local BB, BZ
do
    local lib_bb = LibStub('LibBabble-Boss-3.0')
    BB = lib_bb:GetLookupTable()
    local lib_bz = LibStub('LibBabble-Zone-3.0')
    BZ = lib_bz:GetLookupTable()
end

local lootdata = LibStub("LibInstanceLootData-1.0")

local r,g,b = 1, 0.75, 0 --our tooltip text color


local stringCache = {}
setmetatable(stringCache, {__mode = "kv"})
local origs = {}
local function OnTooltipSetItem(tooltip, ...)
	local name, link = tooltip:GetItem()
	if link then
		local itemID = string.match(link, "item:(%d+)")
		if stringCache[itemID] then
			local diffstr, instance, boss, droprate = string.match(stringCache[itemID], "([^|]+)|([^|]+)|([^|]+)|([^|]*)")
			tooltip:AddDoubleLine(diffstr, instance,r,g,b,r,g,b)
			tooltip:AddDoubleLine(boss, droprate,r,g,b,r,g,b)
		else
			local iType, instance, boss, difficulty, droprate = lootdata:FindItem(itemID)
            boss = boss and BB[boss] or boss
            instance = instance and BZ[instance] or instance
			if iType then
				local diffstr = lootdata:GetDifficultyString(iType, difficulty)
				local multiboss = lootdata:IsSubBoss(iType, instance, boss)
                multiboss = multiboss and BB[multiboss] or multiboss
				if multiboss and multiboss ~= boss then
					boss = multiboss..": "..boss
				end
				if tonumber(difficulty) == 0 then
					diffstr = YssBossLoot.BonusLocale['出处:']
                else
                    diffstr = diffstr and YssBossLoot.BonusLocale[diffstr] or diffstr
				end
				tooltip:AddDoubleLine(diffstr, instance,r,g,b,r,g,b)
				if tonumber(droprate) <= 0 then
					droprate = ''
				else
					droprate = droprate.."%"
				end
				tooltip:AddDoubleLine(boss, droprate,r,g,b,r,g,b)
				stringCache[itemID] = string.format("%s|%s|%s|%s", diffstr, instance, boss, droprate)
			end
		end
	end
	if origs[tooltip] then return origs[tooltip](tooltip, ...) end
end

function YssBossLoot:EnableTooltipInfo()
	for _,tooltip in pairs{GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2,AtlasLootTooltip} do
		if tooltip then
			origs[tooltip] = tooltip:GetScript("OnTooltipSetItem")
			tooltip:SetScript("OnTooltipSetItem", OnTooltipSetItem)
		end
	end
end

function YssBossLoot:DisableTooltipInfo()
	for _,tooltip in pairs{GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2,AtlasLootTooltip} do
		if tooltip and origs[tooltip] then
			tooltip:SetScript("OnTooltipSetItem", origs[tooltip])
			origs[tooltip] = nil
		end
	end
end
