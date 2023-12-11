--[[
  Name: Recount Guessed Absorbs Module
  Heavily based on: Ideas and code posted by para11ax, reinga and Biffurmanno on http://www.wowhead.com/?forums&topic=68238
  Author: Elsia
]]

if not Recount then return end --  Forget about this if no Recount is present

local Recount = Recount

local RecountGuessedAbsorbs = Recount:NewModule("RecountGuessedAbsorbs", "AceEvent-3.0", "AceTimer-3.0","AceConsole-3.0")
RecountGuessedAbsorbs.Version = tonumber(string.sub("$Revision: 17 $", 12, -3))

local L = LibStub("AceLocale-3.0"):GetLocale("Recount")
--local L = LibStub("AceLocale-3.0"):GetLocale("RecountGuessedAbsorbs")

local DetailTitles={}
DetailTitles.GuessedAbsorbed={
	TopNames = L["Ability Name"],
	TopCount = L["Count"],
	TopAmount = L["Absorbed"],
	BotNames = "",
	BotMin = L["Min"],
	BotAvg = L["Avg"],
	BotMax = L["Max"],
	BotAmount = L["Count"]
}

DetailTitles.ShieldedWho={
	TopNames = L["Player/Mob Name"],
	TopCount = "",
	TopAmount = L["Count"],
	BotNames = L["Ability Name"],
	BotMin = "",
	BotAvg = "",
	BotMax = "",
	BotAmount = L["Count"]
}

-- Biffur: Keep track of active shields on each target
local AllShields={}
local Epsilon=0.000000000000000001


local AbsorbSpellDuration = 
{
	-- Death Knight
	[48707] = 5, -- Anti-Magic Shell (DK) Rank 1 -- Does not currently seem to show tracable combat log events. It shows energizes which do not reveal the amount of damage absorbed
	[51052] = 10, -- Anti-Magic Zone (DK)( Rank 1 (Correct spellID?)
		-- Does DK Spell Deflection show absorbs in the CL?
	-- Mage
	[11426] = 60, -- Ice Barrier (Mage) Rank 1
	[13031] = 60,
	[13032] = 60,
	[13033] = 60,
	[27134] = 60,
	[33405] = 60,
	[43038] = 60,
	[43039] = 60, -- Rank 8
	[6143] = 30, -- Frost Ward (Mage) Rank 1
	[8461] = 30, 
	[8462] = 30,  
	[10177] = 30,  
	[28609] = 30,
	[32796] = 30,
	[43012] = 30, -- Rank 7
	[1463] = 60, --  Mana shield (Mage) Rank 1
	[8494] = 60,
	[8495] = 60,
	[10191] = 60,
	[10192] = 60,
	[10193] = 60,
	[27131] = 60,
	[43019] = 60,
	[43020] = 60, -- Rank 9
	[543] = 30 , -- Fire Ward (Mage) Rank 1
	[8457] = 30,
	[8458] = 30,
	[10223] = 30,
	[10225] = 30,
	[27128] = 30,
	[43010] = 30, -- Rank 7
	-- Paladin
	[58597] = 6, -- Sacred Shield (Paladin) proc (Fixed, thanks to Julith)
	-- Priest
	[17] = 30, -- Power Word: Shield (Priest) Rank 1
	[592] = 30,
	[600] = 30,
	[3747] = 30,
	[6065] = 30,
	[6066] = 30,
	[10898] = 30,
	[10899] = 30,
	[10900] = 30,
	[10901] = 30,
	[25217] = 30,
	[25218] = 30,
	[48065] = 30,
	[48066] = 30, -- Rank 14
	[47509] = 12, -- Divine Aegis (Priest) Rank 1
	[47511] = 12,
	[47515] = 12, -- Divine Aegis (Priest) Rank 3 (Some of these are not actual buff spellIDs)
	[47753] = 12, -- Divine Aegis (Priest) Rank 1
	[54704] = 12, -- Divine Aegis (Priest) Rank 1
	[47788] = 10, -- Guardian Spirit  (Priest) (50 nominal absorb, this may not show in the CL)
	-- Warlock
	[7812] = 30, -- Sacrifice (warlock) Rank 1
	[19438] = 30,
	[19440] = 30,
	[19441] = 30,
	[19442] = 30,
	[19443] = 30,
	[27273] = 30,
	[47985] = 30,
	[47986] = 30, -- rank 9
	[6229] = 30, -- Shadow Ward (warlock) Rank 1
	[11739] = 30,
	[11740] = 30,
	[28610] = 30,
	[47890] = 30,
	[47891] = 30, -- Rank 6
	-- Consumables
	[29674] = 86400, -- Lesser Ward of Shielding
	[29719] = 86400, -- Greater Ward of Shielding (these have infinite duration, set for a day here :P)
	[29701] = 86400,
	[28538] = 120, -- Major Holy Protection Potion
	[28537] = 120, -- Major Shadow
	[28536] = 120, --  Major Arcane
	[28513] = 120, -- Major Nature
	[28512] = 120, -- Major Frost
	[28511] = 120, -- Major Fire
	[7233] = 120, -- Fire
	[7239] = 120, -- Frost
	[7242] = 120, -- Shadow Protection Potion
	[7245] = 120, -- Holy
	[6052] = 120, -- Nature Protection Potion
	[53915] = 120, -- Mighty Shadow Protection Potion
	[53914] = 120, -- Mighty Nature Protection Potion
	[53913] = 120, -- Mighty Frost Protection Potion
	[53911] = 120, -- Mighty Fire
	[53910] = 120, -- Mighty Arcane
	[17548] = 120, --  Greater Shadow
	[17546] = 120, -- Greater Nature
	[17545] = 120, -- Greater Holy
	[17544] = 120, -- Greater Frost
	[17543] = 120, -- Greater Fire
	[17549] = 120, -- Greater Arcane
	[28527] = 15, -- Fel Blossom
	[29432] = 3600, -- Frozen Rune usage (Naxx classic)
	-- Item usage
	[36481] = 4, -- Arcane Barrier (TK Kael'Thas) Shield
	[57350] = 6, -- Darkmoon Card: Illusion
	[17252] = 30, -- Mark of the Dragon Lord (LBRS epic ring) usage
	[25750] = 15, -- Defiler's Talisman/Talisman of Arathor Rank 1
	[25747] = 15,
	[25746] = 15,
	[23991] = 15,
	[31000] = 300, -- Pendant of Shadow's End Usage
	[30997] = 300, -- Pendant of Frozen Flame Usage
	[31002] = 300, -- Pendant of the Null Rune
	[30999] = 300, -- Pendant of Withering
	[30994] = 300, -- Pendant of Thawing
	[31000] = 300, -- 
	[23506]= 20, -- Arena Grand Master Usage (Aura of Protection)
	[12561] = 60, -- Goblin Construction Helmet usage
	[31771] = 20, -- Runed Fungalcap usage
	[21956] = 10, -- Mark of Resolution usage
	[29506] = 20, -- The Burrower's Shell
	[4057] = 60, -- Flame Deflector
	[4077] = 60, -- Ice Deflector
	[39228] = 20, -- Argussian Compass (may not be an actual absorb)
	-- Item procs
	[27779] = 30, -- Divine Protection - Priest dungeon set 1/2  Proc
	[11657] = 20, -- Jang'thraze (Zul Farrak) proc
	[10368] = 15, -- Uther's Strength proc
	[37515] = 15, -- Warbringer Armor Proc
	[42137] = 86400, -- Greater Rune of Warding Proc
	[26467] = 30, -- Scarab Brooch proc
	[27539] = 6, -- Thick Obsidian Breatplate proc
	[28810] = 30, -- Faith Set Proc Armor of Faith
	[54808] = 12, -- Noise Machine proc Sonic Shield 
	[55019] = 12, -- Sonic Shield (one of these too ought to be wrong)
	[64413] = 8, -- Val'anyr, Hammer of Ancient Kings proc Protection of Ancient Kings
	-- Misc
	[40322] = 30, -- Teron's Vengeful Spirit Ghost - Spirit Shield
}


-- global OnInit function, only called once during addon loading
function RecountGuessedAbsorbs:OnInitialize()
	Recount:AddModeTooltip(L["Guessed Absorbs"],RecountGuessedAbsorbs.DataModesGuessedAbsorbs,RecountGuessedAbsorbs.TooltipFuncsGuessedAbsorbs,nil,nil,nil,nil);
end

function RecountGuessedAbsorbs:CombatLogEvent(_,timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if not Recount.db.profile.GlobalDataCollect or not Recount.CurrentDataCollect then
		return
	end
	
	if not Recount:CheckRetentionFromFlags(srcFlags) and not Recount:CheckRetentionFromFlags(dstFlags) then
		return
	end

	if srcName == nil then
		srcName = "No One"
	else
		Recount:MatchGUID(srcName,srcGUID,srcFlags)
	end
	if dstName == nil then
		dstName = "No One"
	else
		Recount:MatchGUID(dstName,dstGUID,dstFlags)
	end
	
	if eventtype == "SPELL_AURA_APPLIED" then
		RecountGuessedAbsorbs:SpellAuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SPELL_AURA_REMOVED" then
		RecountGuessedAbsorbs:SpellAuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	end
	
	if eventtype == "SWING_DAMAGE" then
		RecountGuessedAbsorbs:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "RANGE_DAMAGE" or eventtype == "SPELL_DAMAGE" or eventtype == "SPELL_PERIODIC_DAMAGE" or eventtype == "DAMAGE_SHIELD" or eventtype == "DAMAGE_SPLIT" then
		RecountGuessedAbsorbs:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "ENVIRONMENTAL_DAMAGE" then
		RecountGuessedAbsorbs:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "SWING_MISSED" then -- Elsia: Missed block
		RecountGuessedAbsorbs:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	elseif eventtype == "RANGE_MISSED" or eventtype == "SPELL_MISSED" or eventtype == "SPELL_PERIODIC_MISSED" or eventtype == "DAMAGE_SHIELD_MISSED" then
		RecountGuessedAbsorbs:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,...)
	end
end

function RecountGuessedAbsorbs:SpellAuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType)

	-- Is this an absorb effect?
	if AbsorbSpellDuration[spellId] then
		-- Yes? Add shield
		AllShields[dstName] = AllShields[dstName] or {}
		Recount:DPrint("Assigning active " .. spellName .." on " .. dstName .." cast by " ..srcName)
		AllShields[dstName][spellId] = AllShields[dstName][spellId] or {}
		if AllShields[dstName][spellId][srcName] then
			Recount:DPrint("Valid shield is being rewritten without having been removed first: "..srcName.." "..dstName.." "..spellName)
		end
		AllShields[dstName][spellId][srcName] = timestamp + AbsorbSpellDuration[spellId]
		
		if not Recount.db2.combatants[srcName]  then
			Recount:DPrint("No source combatant!")
		else
			local sourceData=Recount.db2.combatants[srcName]
			Recount:AddTableDataSum(sourceData,"ShieldedWho",dstName,spellName,1)
		end
	end
end

function RecountGuessedAbsorbs:SpellAuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, auraType)

	-- Is this an absorb effect?
	if AbsorbSpellDuration[spellId] then
		-- Yes? Lets remove it if it was tracked
		if AllShields[dstName] and AllShields[dstName][spellId] and AllShields[dstName][spellId][srcName] then
			if AllShields[dstName][spellId][srcName] >= timestamp then
				Recount:DPrint("Removing " .. spellName .." from " .. dstName .. " at time ".. timestamp .. " old stamp was "..AllShields[dstName][spellId][srcName])
				
			else
				Recount:DPrint("Removing " .. spellName .." from " .. dstName .. " at time ".. timestamp .. " old stamp was "..AllShields[dstName][spellId][srcName].." EXPIRED!!")
			end
			
			-- Unfortunately last absorbs of a shield can show after the aura is removed in the combat log which is why we have to do the below, unfortunately
			local packagedargs = {dstName,spellId,srcName}
			RecountGuessedAbsorbs:ScheduleTimer("RemoveShield",0.1,packagedargs)
--			AllShields[dstName][spellId][srcName]=0
		else
			Recount:DPrint("Shield "..spellName.." was removed on target "..dstName.." but wasn't detected as applied")
		end
	end
end

function RecountGuessedAbsorbs:RemoveShield(args)
	local dstName, spellId, srcName = unpack(args)
	Recount:DPrint("Removing "..dstName.." "..spellId.." "..srcName)
	AllShields[dstName][spellId][srcName]=nil
end

function RecountGuessedAbsorbs:SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
	if absorbed and absorbed > 0 then
		RecountGuessedAbsorbs:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,0, L["Melee"], SPELLSCHOOL_PHYSICAL, amount, overkill,school, resisted, blocked, absorbed, critical, glancing, crushing)
	end
end

function RecountGuessedAbsorbs:SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

	if absorbed and absorbed > 0 then
		local HitType="Hit" -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		if critical then
			HitType="Crit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		if eventtype == "SPELL_PERIODIC_DAMAGE" then
			HitType="Tick"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
			spellName = spellName .." ("..L["DoT"]..")"
		end
		if eventtype == "DAMAGE_SPLIT" then
			HitType="Split"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		if crushing then
			HitType="Crushing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		if glancing	then
			HitType="Glancing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
	--[[	if blocked then
			HitType="Block"
		end
		if absorbed then
			HitType="Absorbed"
		end--]]
		if eventtype == "RANGE_DAMAGE" then spellSchool = school end		
		RecountGuessedAbsorbs:AddAbsorbData(srcName, dstName, spellName, Recount.SpellSchoolName[spellSchool], HitType, amount, resisted, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed, timestamp)
	end
end

function RecountGuessedAbsorbs:EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,enviromentalType, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)

	if absorbed and absorbed > 0 then
		local HitType = "Hit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		if critical then
			HitType="Crit"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		if crushing then
			HitType="Crushing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		if glancing	then
			HitType="Glancing"  -- Elsia: Do NOT localize this, it breaks functionality!!! If you need this localized contact me on WowAce or Curse.
		end
		--[[if blocked then
			HitType="Block"
		end
		if absorbed then
			HitType="Absorbed"
		end--]]

		RecountGuessedAbsorbs:AddAbsorbData("Environment", dstName, Recount:FixCaps(enviromentalType), Recount.SpellSchoolName[school], HitType, amount, resisted, srcGUID, 0, dstGUID, dstFlags, spellId, blocked, absorbed, timestamp)
	end
end

function RecountGuessedAbsorbs:SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, missType, missAmount)
	
	if missType == "ABSORB" then
		RecountGuessedAbsorbs:AddAbsorbData(srcName, dstName, L["Melee"], nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId, nil, missAmount, timestamp)
--		RecountGuessedAbsorbs:HandleAbsorbs(timestamp, dstName, dstGUID, dstFlags, L["Melee"], missAmount)
	end
end

function RecountGuessedAbsorbs:SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,spellId, spellName, spellSchool, missType, missAmount)

	if missType == "ABSORB" then
		RecountGuessedAbsorbs:AddAbsorbData(srcName, dstName, spellName, nil, Recount:FixCaps(missType),nil,nil, srcGUID, srcFlags, dstGUID, dstFlags, spellId, nil, missAmount, timestamp)
	end
end


function RecountGuessedAbsorbs:AddAbsorbData(source, victim, ability, element, hittype, damage, resist, srcGUID, srcFlags, dstGUID, dstFlags, spellId, blocked, absorbed, timestamp)
	local shieldref = AllShields[victim]
	local currenttime = timestamp
	local mintime = 900000
	local minspell
	local minsrc
	
	if not shieldref then
		return
	end
	-- AllShields[dstName][spellId][srcName] = timestamp + AbsorbSpellDuration[spellId]
	-- k : spellId
	-- k2 : srcName
	-- v2 : endTime
	for k,v in pairs(shieldref) do
		for k2,v2 in pairs(v) do
			if v2-currenttime < mintime then	
				if v2-currenttime < -1.0 then
					shieldref[k][k2]=nil
					Recount:DPrint("Removing old "..k.." "..k2.." on "..victim)
				else
					mintime = v2-currenttime
					minsrc = k2
					minspell = k
				end
			end
			Recount:DPrint(k2.." "..v2.." "..currenttime.." "..v2-currenttime)
		end
	end

	if not minsrc then
		Recount:DPrint("Failed to find a minsource for absorb on "..victim.." "..absorbed)
	else
		local spellName = GetSpellInfo(minspell)
		local source = minsrc
		Recount:DPrint("Guessing that the absorb goes to "..minsrc.." having used spell "..minspell ..":"..absorbed)
		if not Recount.db2.combatants[source] then
			Recount:DPrint("No source combatant!")
		else
			local sourceData=Recount.db2.combatants[source]
			Recount:AddAmount(sourceData,"GuessedAbsorbs",absorbed)
			Recount:AddTableDataStats(sourceData,"GuessedAbsorbed",spellName,victim,absorbed)
			-----------------
			-- ÎüÊÕÒ²ËãÖÎÁÆ
			Recount:AddHealData(source, victim, spellName, "Hit", absorbed, 0,dstGUID,dstFlags, dstGUID,dstFlags,minspell, nil);
		end
	end
end

-- global OnEnable
function RecountGuessedAbsorbs:OnEnable()

	if not Recount then return end -- No recount found

	-- register callbacks and events

	--Parser Events
	RecountGuessedAbsorbs:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED","CombatLogEvent")
	
	-- fill upvalues with meaningful data
end

-- global OnDisable
function RecountGuessedAbsorbs:OnDisable()
	Recount:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

function RecountGuessedAbsorbs:DataModesGuessedAbsorbs(data, num)	
	if not data then return 0, 0 end
	if num==1 then
		return (data.Fights[Recount.db.profile.CurDataSet].GuessedAbsorbs or 0), (data.Fights[Recount.db.profile.CurDataSet].GuessedAbsorbs or 0)/((data.Fights[Recount.db.profile.CurDataSet].ActiveTime or 0) + Epsilon)
	else
		return (data.Fights[Recount.db.profile.CurDataSet].GuessedAbsorbs or 0), {
			{data.Fights[Recount.db.profile.CurDataSet].GuessedAbsorbed,L["'s Guessed Absorbs"],DetailTitles.GuessedAbsorbed},
			{data.Fights[Recount.db.profile.CurDataSet].ShieldedWho," "..L["Shielded Who"],DetailTitles.ShieldedWho}
		}
	end
end

-- Not using this, but allows to set special totals
--function RecountGuessedAbsorbs:SpecialTotalsGuessedAbsorbs()
--end

function RecountGuessedAbsorbs:TooltipFuncsGuessedAbsorbs(name,data)
	local SortedData,total
	GameTooltip:ClearLines()
	GameTooltip:AddLine(name)
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Guessed Absorbs"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].GuessedAbsorbed,3)
	GameTooltip:AddLine("")
	Recount:AddSortedTooltipData(L["Top 3"].." "..L["Shielded"],data and data.Fights[Recount.db.profile.CurDataSet] and data.Fights[Recount.db.profile.CurDataSet].ShieldedWho,3)
	GameTooltip:AddLine("<"..L["Click for more Details"]..">",0,0.9,0)
end