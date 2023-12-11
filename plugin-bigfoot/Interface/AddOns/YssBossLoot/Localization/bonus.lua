do
    local L = {}
    if GetLocale() == 'zhCN' then
        L["Classic"] = '经典旧世'
        L["The Burning Crusade"] = '燃烧的远征'
        L["Wrath of the Lich King"] = '巫妖王之怒'
    elseif GetLocale() == 'zhTW' then
        L["Classic"] = '經典旧世'
        L["The Burning Crusade"] = '燃燒的遠征'
        L["Wrath of the Lich King"] = '巫妖王之怒'
    end

    setmetatable(L, {__index = function(t, i) return i end})
        
    local addon = YssBossLoot
    addon.BonusLocale = L

end

do
    local lib = LibStub('LibInstanceLootData-1.0')
    --local lib = LibStub:NewLibrary("LibInstanceLootData-1.0", 99999) -- oh yeah
    if lib then
        local loc = GetLocale()
        lib.L = setmetatable(loc == 'zhCN' and {
            ['Loot'] = '战利品',
            ['Normal Loot'] = '普通模式掉落',
            ['Heroic Loot'] = '英雄模式掉落',
            ['Normal 10-man Loot'] = '10人普通模式掉落',
            ['Normal 25-man Loot'] = '25人普通模式掉落',
            ['Heroic 10-man Loot'] = '10人英雄模式掉落',
            ['Heroic 25-man Loot'] = '25人英雄模式掉落',
			["Non Boss Drops"] = "非BOSS掉落",
            ['N'] = '普通',
            ['H'] = '英雄',
            ['N10'] = '普通10',
            ['N25'] = '普通25',
            ['H10'] = '英雄10',
            ['H25'] = '英雄25',
        } or loc == 'zhTW' and {
            ['Loot'] = '戰利品',
            ['Normal Loot'] = '普通模式戰利品',
            ['Heroic Loot'] = '英雄模式戰利品',
            ['Normal 10-man Loot'] = '10人普通模式戰利品',
            ['Normal 25-man Loot'] = '25人普通模式戰利品',
            ['Heroic 10-man Loot'] = '10人英雄模式戰利品',
            ['Heroic 25-man Loot'] = '25人英雄模式戰利品',
			["Non Boss Drops"] = "非BOSS戰利品",
            ['N'] = '普通',
            ['H'] = '英雄',
            ['N10'] = '普通10',
            ['N25'] = '普通25',
            ['H10'] = '英雄10',
            ['H25'] = '英雄25',
        } or {}, {__index = lib.L})
    end
    
end
