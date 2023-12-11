-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.

function TotemTimers.GetSpells()
    wipe(TotemTimers.AvailableSpells)
    wipe(TotemTimers.AvailableSpellIDs)
	for i = 2, GetNumSpellTabs() do
		local _, _, offset, numSpells = GetSpellTabInfo(i)
        for s = offset + 1, offset + numSpells do
            local spell = GetSpellName(s, BOOKTYPE_SPELL)
            if spell then
                local name, rank = GetSpellInfo(spell)
                if name then
                    TotemTimers.AvailableSpells[name] = true
                    local link = GetSpellLink(s, BOOKTYPE_SPELL)
                    if link then
                        local _,_, id = string.find(link,"Hspell:(%d+)")
                        if id then
                            id = tonumber(id)
                            if not TotemTimers.MaxSpellIDs[name] or id > TotemTimers.MaxSpellIDs[name] then
                                TotemTimers.MaxSpellIDs[name] = id
                            end
                            TotemTimers.AvailableSpellIDs[id] = true
                        end
                    end
                end
            end
        end
	end
    return true
end

function TotemTimers.GetTalents()
    wipe(TotemTimers.AvailableTalents)
    local _,_,_,_,rank = GetTalentInfo(2,28)
    if rank > 0 then TotemTimers.AvailableTalents.Maelstrom = true end
end

function TotemTimers.GetMaxRank(spellid)
    local spellName = GetSpellInfo(spellid)
    if spellName then return TotemTimers.MaxSpellIDs[spellName] end
end

function TotemTimers.LearnedSpell(tab)
    if tab then
		local _, _, offset, numSpells = GetSpellTabInfo(tab)
        for s = offset + 1, offset + numSpells do
            local spell = GetSpellName(s, BOOKTYPE_SPELL)
            if spell then
                local name = GetSpellInfo(spell)
                if name then
                    TotemTimers.AvailableSpells[name] = true
                    local link = GetSpellLink(s, BOOKTYPE_SPELL)
                    if link then
                        local _,_, id = string.find(link,"Hspell:(%d+)")
                        if id then
                            id = tonumber(id)
                            if not TotemTimers.MaxSpellIDs[name] or id > TotemTimers.MaxSpellIDs[name] then
                                TotemTimers.MaxSpellIDs[name] = id
                            end
                            TotemTimers.AvailableSpellIDs[id] = true
                        end
                    end
                end
            end
        end
    end
    TotemTimers_SetCastButtonSpells()
    TotemTimers.SetWeaponTrackerSpells()
    TotemTimers.ProcessSetting("AnkhTracker")
    TotemTimers.ProcessSpecSetting("ShieldTracker")
    TotemTimers.ProcessSetting("EarthShieldTracker")
    TotemTimers.ProcessSetting("WeaponTracker")
    TotemTimers.ProcessSetting("Show")
    TotemTimers.SetMultiCastSpells()
    TotemTimers.MultiSpellActivate()
    TotemTimers_ProgramSetButtons()
    TotemTimers.SetupTotemButtons()
end


function TotemTimers.ChangedTalents()
	TotemTimers.GetSpells()
    TotemTimers.GetTalents()
    TotemTimers.ProcessSpecSetting("ShieldTracker")
    TotemTimers.ProcessSetting("EarthShieldTracker")
    TotemTimers.ProcessSetting("WeaponTracker")
    TotemTimers.SetupTotemCastButtons()
    TotemTimers_SetCastButtonSpells()
end
