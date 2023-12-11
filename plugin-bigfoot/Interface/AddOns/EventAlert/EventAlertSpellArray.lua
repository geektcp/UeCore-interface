function EventAlert_LoadSpellArray()

if EA_Items_BF == nil then
	EA_Items_BF = {};
end

if EA_AltItems == nil then
	EA_AltItems = {};
end

-- For buffs that have charges or are supposed to have charges, but instead re-cast themselves and mess up the frames.
	if EA_Items_BF[EA_CLASS_FUNKY] == nil then EA_Items_BF[EA_CLASS_FUNKY] = {} end;



-- Start Normal Items --

-- Death Knight
if EA_Items_BF[EA_CLASS_DK] == nil then EA_Items_BF[EA_CLASS_DK] = {} end;
	-- Killing Machine
		if EA_Items_BF[EA_CLASS_DK][51124] == nil then EA_Items_BF[EA_CLASS_DK][51124] = true end;

	-- Rime (Freezing Fog)
		if EA_Items_BF[EA_CLASS_DK][59052] == nil then EA_Items_BF[EA_CLASS_DK][59052] = true end;

	-- Cinderglacier (Runeforge)
		if EA_Items_BF[EA_CLASS_DK][53386] == nil then EA_Items_BF[EA_CLASS_DK][53386] = true end;

-- Druid
if EA_Items_BF[EA_CLASS_DRUID] == nil then EA_Items_BF[EA_CLASS_DRUID] = {} end;
	-- Eclipse
		if EA_Items_BF[EA_CLASS_DRUID][48517] == nil then EA_Items_BF[EA_CLASS_DRUID][48517] = true end;
		if EA_Items_BF[EA_CLASS_DRUID][48518] == nil then EA_Items_BF[EA_CLASS_DRUID][48518] = true end;

	-- Nature's Grace
		if EA_Items_BF[EA_CLASS_DRUID][16886] == nil then EA_Items_BF[EA_CLASS_DRUID][16886] = true end;

    -- Omen of Clarity
		if EA_Items_BF[EA_CLASS_DRUID][16870] == nil then EA_Items_BF[EA_CLASS_DRUID][16870] = true end;

   	-- Owlkin Frenzy
		if EA_Items_BF[EA_CLASS_DRUID][48391] == nil then EA_Items_BF[EA_CLASS_DRUID][48391] = true end;

    -- Wrath of Elune (PvP Set Bonus)
		if EA_Items_BF[EA_CLASS_DRUID][46833] == nil then EA_Items_BF[EA_CLASS_DRUID][46833] = true end;

    -- Elune's Wrath (Tier 8 Set Bonus)
		if EA_Items_BF[EA_CLASS_DRUID][64823] == nil then EA_Items_BF[EA_CLASS_DRUID][64823] = true end;
    -- ÂÓÊ³ÕßµÄÑ¸½Ý
	--Terry@bf
		if EA_Items_BF[EA_CLASS_DRUID][69369] == nil then EA_Items_BF[EA_CLASS_DRUID][69369] = true end;
		

-- Hunter
if EA_Items_BF[EA_CLASS_HUNTER] == nil then EA_Items_BF[EA_CLASS_HUNTER] = {} end;
	-- Improved Stead Shot
		if EA_Items_BF[EA_CLASS_HUNTER][53220] == nil then EA_Items_BF[EA_CLASS_HUNTER][53220] = true end;

    -- Lock and Load
		if EA_Items_BF[EA_CLASS_HUNTER][56453] == nil then EA_Items_BF[EA_CLASS_HUNTER][56453] = true end;

    -- Rapid Killing
		if EA_Items_BF[EA_CLASS_HUNTER][35098] == nil then EA_Items_BF[EA_CLASS_HUNTER][35098] = true end;
		if EA_Items_BF[EA_CLASS_HUNTER][35099] == nil then EA_Items_BF[EA_CLASS_HUNTER][35099] = true end;

-- Mage
if EA_Items_BF[EA_CLASS_MAGE] == nil then EA_Items_BF[EA_CLASS_MAGE] = {} end;
   -- Arcane Concentration
		if EA_Items_BF[EA_CLASS_MAGE][12536] == nil then EA_Items_BF[EA_CLASS_MAGE][12536] = true end;

   -- Brain Freeze
		if EA_Items_BF[EA_CLASS_MAGE][57761] == nil then EA_Items_BF[EA_CLASS_MAGE][57761] = true end;

   -- Fingers of Frost
		if EA_Items_BF[EA_CLASS_MAGE][74396] == nil then EA_Items_BF[EA_CLASS_MAGE][74396] = true end;

   -- Firestarter
		if EA_Items_BF[EA_CLASS_MAGE][54741] == nil then EA_Items_BF[EA_CLASS_MAGE][54741] = true end;

   -- Hot Streak
		if EA_Items_BF[EA_CLASS_MAGE][48108] == nil then EA_Items_BF[EA_CLASS_MAGE][48108] = true end;

   -- Missile Barrage
		if EA_Items_BF[EA_CLASS_MAGE][44401] == nil then EA_Items_BF[EA_CLASS_MAGE][44401] = true end;

-- Paladin
if EA_Items_BF[EA_CLASS_PALADIN] == nil then EA_Items_BF[EA_CLASS_PALADIN] = {} end;

	-- Just used for testing  (DO NOT ENABLE THESE UNLESS YOU KNOW WHAT YOU ARE DOING).
		--  if EA_Items_BF[EA_CLASS_PALADIN][27179] == nil then EA_Items_BF[EA_CLASS_PALADIN][27179] = true end;
		--  if EA_Items_BF[EA_CLASS_PALADIN][27151] == nil then EA_Items_BF[EA_CLASS_PALADIN][27151] = true end;
		--  if EA_Items_BF[EA_CLASS_PALADIN][27140] == nil then EA_Items_BF[EA_CLASS_PALADIN][27140] = true end;

	-- Art of War
		if EA_Items_BF[EA_CLASS_PALADIN][53489] == nil then EA_Items_BF[EA_CLASS_PALADIN][53489] = true end;
		if EA_Items_BF[EA_CLASS_PALADIN][59578] == nil then EA_Items_BF[EA_CLASS_PALADIN][59578] = true end;

	-- Infusion of Light
		if EA_Items_BF[EA_CLASS_PALADIN][53672] == nil then EA_Items_BF[EA_CLASS_PALADIN][53672] = true end;
		if EA_Items_BF[EA_CLASS_PALADIN][54149] == nil then EA_Items_BF[EA_CLASS_PALADIN][54149] = true end;

	-- Sacred Shield
		if EA_Items_BF[EA_CLASS_PALADIN][58597] == nil then EA_Items_BF[EA_CLASS_PALADIN][58597] = true end;

-- Priest
if EA_Items_BF[EA_CLASS_PRIEST] == nil then EA_Items_BF[EA_CLASS_PRIEST] = {} end;
	-- Borrowed Time
		if EA_Items_BF[EA_CLASS_PRIEST][59887] == nil then EA_Items_BF[EA_CLASS_PRIEST][59887] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][59888] == nil then EA_Items_BF[EA_CLASS_PRIEST][59888] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][59889] == nil then EA_Items_BF[EA_CLASS_PRIEST][59889] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][59890] == nil then EA_Items_BF[EA_CLASS_PRIEST][59890] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][59891] == nil then EA_Items_BF[EA_CLASS_PRIEST][59891] = true end;

	-- Holy Concentration
		if EA_Items_BF[EA_CLASS_PRIEST][34754] == nil then EA_Items_BF[EA_CLASS_PRIEST][34754] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][63724] == nil then EA_Items_BF[EA_CLASS_PRIEST][63724] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][63725] == nil then EA_Items_BF[EA_CLASS_PRIEST][63725] = true end;

	-- Martyrdom
		if EA_Items_BF[EA_CLASS_PRIEST][14743] == nil then EA_Items_BF[EA_CLASS_PRIEST][14743] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][27828] == nil then EA_Items_BF[EA_CLASS_PRIEST][27828] = true end;

	-- Serendipity
		if EA_Items_BF[EA_CLASS_PRIEST][63731] == nil then EA_Items_BF[EA_CLASS_PRIEST][63731] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][63734] == nil then EA_Items_BF[EA_CLASS_PRIEST][63734] = true end;
		if EA_Items_BF[EA_CLASS_PRIEST][63735] == nil then EA_Items_BF[EA_CLASS_PRIEST][63735] = true end;
	        if EA_Items_BF[EA_CLASS_FUNKY][63731] == nil then EA_Items_BF[EA_CLASS_FUNKY][63731] = true end;
			if EA_Items_BF[EA_CLASS_FUNKY][63734] == nil then EA_Items_BF[EA_CLASS_FUNKY][63734] = true end;
			if EA_Items_BF[EA_CLASS_FUNKY][63735] == nil then EA_Items_BF[EA_CLASS_FUNKY][63735] = true end;

    -- Surge of Light
		if EA_Items_BF[EA_CLASS_PRIEST][33151] == nil then EA_Items_BF[EA_CLASS_PRIEST][33151] = true end;

-- Rogue
if EA_Items_BF[EA_CLASS_ROGUE] == nil then EA_Items_BF[EA_CLASS_ROGUE] = {} end;

-- Shaman
if EA_Items_BF[EA_CLASS_SHAMAN] == nil then EA_Items_BF[EA_CLASS_SHAMAN] = {} end;
	-- Elemental Focus
		if EA_Items_BF[EA_CLASS_SHAMAN][16246] == nil then EA_Items_BF[EA_CLASS_SHAMAN][16246] = true end;

	-- Maelstrom Weapon (Fifth stack)
		if EA_Items_BF[EA_CLASS_SHAMAN][53817] == nil then EA_Items_BF[EA_CLASS_SHAMAN][53817] = true end;

	-- Tital Waves
		if EA_Items_BF[EA_CLASS_SHAMAN][53390] == nil then EA_Items_BF[EA_CLASS_SHAMAN][53390] = true end;

-- Warlock
if EA_Items_BF[EA_CLASS_WARLOCK] == nil then EA_Items_BF[EA_CLASS_WARLOCK] = {} end;
	-- Backdraft
		if EA_Items_BF[EA_CLASS_WARLOCK][54274] == nil then EA_Items_BF[EA_CLASS_WARLOCK][54274] = true end;
		if EA_Items_BF[EA_CLASS_WARLOCK][54276] == nil then EA_Items_BF[EA_CLASS_WARLOCK][54276] = true end;
		if EA_Items_BF[EA_CLASS_WARLOCK][54277] == nil then EA_Items_BF[EA_CLASS_WARLOCK][54277] = true end;

	-- Backlash
		if EA_Items_BF[EA_CLASS_WARLOCK][34936] == nil then EA_Items_BF[EA_CLASS_WARLOCK][34936] = true end;

	-- Decimation
		if EA_Items_BF[EA_CLASS_WARLOCK][63165] == nil then EA_Items_BF[EA_CLASS_WARLOCK][63165] = true end;
		if EA_Items_BF[EA_CLASS_WARLOCK][63167] == nil then EA_Items_BF[EA_CLASS_WARLOCK][63167] = true end;

	-- Empowered Imp
		if EA_Items_BF[EA_CLASS_WARLOCK][47283] == nil then EA_Items_BF[EA_CLASS_WARLOCK][47283] = true end;

	-- Eradication
		if EA_Items_BF[EA_CLASS_WARLOCK][64368] == nil then EA_Items_BF[EA_CLASS_WARLOCK][64368] = true end;
		if EA_Items_BF[EA_CLASS_WARLOCK][64370] == nil then EA_Items_BF[EA_CLASS_WARLOCK][64370] = true end;
		if EA_Items_BF[EA_CLASS_WARLOCK][64371] == nil then EA_Items_BF[EA_CLASS_WARLOCK][64371] = true end;

    -- Molten Core
		if EA_Items_BF[EA_CLASS_WARLOCK][71165] == nil then EA_Items_BF[EA_CLASS_WARLOCK][71165] = true end;

	-- Nightfall
		if EA_Items_BF[EA_CLASS_WARLOCK][17941] == nil then EA_Items_BF[EA_CLASS_WARLOCK][17941] = true end;

	-- Glyph of Life Tap
		if EA_Items_BF[EA_CLASS_WARLOCK][63321] == nil then EA_Items_BF[EA_CLASS_WARLOCK][63321] = true end;

-- Warrior
if EA_Items_BF[EA_CLASS_WARRIOR] == nil then EA_Items_BF[EA_CLASS_WARRIOR] = {} end;
	-- Bloodsurge
		if EA_Items_BF[EA_CLASS_WARRIOR][46916] == nil then EA_Items_BF[EA_CLASS_WARRIOR][46916] = true end;

	-- Sudden Death
		if EA_Items_BF[EA_CLASS_WARRIOR][52437] == nil then EA_Items_BF[EA_CLASS_WARRIOR][52437] = true end;

	-- Sword and Board
		if EA_Items_BF[EA_CLASS_WARRIOR][50227] == nil then EA_Items_BF[EA_CLASS_WARRIOR][50227] = true end;

	-- Taste for Blood
		if EA_Items_BF[EA_CLASS_WARRIOR][60503] == nil then EA_Items_BF[EA_CLASS_WARRIOR][60503] = true end;

	-- Glyph of Revenge
		if EA_Items_BF[EA_CLASS_WARRIOR][58363] == nil then EA_Items_BF[EA_CLASS_WARRIOR][58363] = true end;

-- Other
if EA_Items_BF[EA_CLASS_OTHER] == nil then EA_Items_BF[EA_CLASS_OTHER] = {} end;
	-- Healing Trance
		if EA_Items_BF[EA_CLASS_OTHER][37706] == nil then EA_Items_BF[EA_CLASS_OTHER][37706] = true end;
		if EA_Items_BF[EA_CLASS_OTHER][37721] == nil then EA_Items_BF[EA_CLASS_OTHER][37721] = true end;
   		if EA_Items_BF[EA_CLASS_OTHER][37722] == nil then EA_Items_BF[EA_CLASS_OTHER][37722] = true end;
        if EA_Items_BF[EA_CLASS_OTHER][37723] == nil then EA_Items_BF[EA_CLASS_OTHER][37723] = true end;
        if EA_Items_BF[EA_CLASS_OTHER][60512] == nil then EA_Items_BF[EA_CLASS_OTHER][60512] = true end;
        if EA_Items_BF[EA_CLASS_OTHER][60513] == nil then EA_Items_BF[EA_CLASS_OTHER][60513] = true end;
        if EA_Items_BF[EA_CLASS_OTHER][60514] == nil then EA_Items_BF[EA_CLASS_OTHER][60514] = true end;
        if EA_Items_BF[EA_CLASS_OTHER][60515] == nil then EA_Items_BF[EA_CLASS_OTHER][60515] = true end;

	-- Quagmirran's Eye (Spell Haste)
		if EA_Items_BF[EA_CLASS_OTHER][33370] == nil then EA_Items_BF[EA_CLASS_OTHER][33370] = true end;



-- Start Alternate Items --

--Death Knight
if EA_AltItems[EA_CLASS_DK] == nil then EA_AltItems[EA_CLASS_DK] = {} end;
	-- Rune Strike
    	if EA_AltItems[EA_CLASS_DK][56815] == nil then EA_AltItems[EA_CLASS_DK][56815] = true end;

-- Druid
if EA_AltItems[EA_CLASS_DRUID] == nil then EA_AltItems[EA_CLASS_DRUID] = {} end;

-- Hunter
if EA_AltItems[EA_CLASS_HUNTER] == nil then EA_AltItems[EA_CLASS_HUNTER] = {} end;
	-- Kill Shot
		if EA_AltItems[EA_CLASS_HUNTER][53351] == nil then EA_AltItems[EA_CLASS_HUNTER][53351] = true end;
		if EA_AltItems[EA_CLASS_HUNTER][61005] == nil then EA_AltItems[EA_CLASS_HUNTER][61005] = true end;
		if EA_AltItems[EA_CLASS_HUNTER][61006] == nil then EA_AltItems[EA_CLASS_HUNTER][61006] = true end;

-- Mage
if EA_AltItems[EA_CLASS_MAGE] == nil then EA_AltItems[EA_CLASS_MAGE] = {} end;

-- Paladin
if EA_AltItems[EA_CLASS_PALADIN] == nil then EA_AltItems[EA_CLASS_PALADIN] = {} end;
	-- Hammer of Wrath
		if EA_AltItems[EA_CLASS_PALADIN][24275] == nil then EA_AltItems[EA_CLASS_PALADIN][24275] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][24274] == nil then EA_AltItems[EA_CLASS_PALADIN][24274] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][24239] == nil then EA_AltItems[EA_CLASS_PALADIN][24239] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][27180] == nil then EA_AltItems[EA_CLASS_PALADIN][27180] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][48805] == nil then EA_AltItems[EA_CLASS_PALADIN][48805] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][48806] == nil then EA_AltItems[EA_CLASS_PALADIN][48806] = true end;

-- Priest
if EA_AltItems[EA_CLASS_PRIEST] == nil then EA_AltItems[EA_CLASS_PRIEST] = {} end;

-- Rogue
if EA_AltItems[EA_CLASS_ROGUE] == nil then EA_AltItems[EA_CLASS_ROGUE] = {} end;
	-- Riposte
		if EA_AltItems[EA_CLASS_ROGUE][14251] == nil then EA_AltItems[EA_CLASS_ROGUE][14251] = true end;

-- Shaman
if EA_AltItems[EA_CLASS_SHAMAN] == nil then EA_AltItems[EA_CLASS_SHAMAN] = {} end;

-- Warlock
if EA_AltItems[EA_CLASS_WARLOCK] == nil then EA_AltItems[EA_CLASS_WARLOCK] = {} end;

-- Warrior
if EA_AltItems[EA_CLASS_WARRIOR] == nil then EA_AltItems[EA_CLASS_WARRIOR] = {} end;
	-- Overpower
    	if EA_AltItems[EA_CLASS_WARRIOR][7384] == nil then EA_AltItems[EA_CLASS_WARRIOR][7384] = true end;

	-- Execute
    	if EA_AltItems[EA_CLASS_WARRIOR][5308] == nil then EA_AltItems[EA_CLASS_WARRIOR][5308] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20658] == nil then EA_AltItems[EA_CLASS_WARRIOR][20658] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20660] == nil then EA_AltItems[EA_CLASS_WARRIOR][20660] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20661] == nil then EA_AltItems[EA_CLASS_WARRIOR][20661] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20662] == nil then EA_AltItems[EA_CLASS_WARRIOR][20662] = true end;
      	if EA_AltItems[EA_CLASS_WARRIOR][25234] == nil then EA_AltItems[EA_CLASS_WARRIOR][25234] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][25236] == nil then EA_AltItems[EA_CLASS_WARRIOR][25236] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][47470] == nil then EA_AltItems[EA_CLASS_WARRIOR][47470] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][47471] == nil then EA_AltItems[EA_CLASS_WARRIOR][47471] = true end;

	-- Revenge
    	if EA_AltItems[EA_CLASS_WARRIOR][6572] == nil then EA_AltItems[EA_CLASS_WARRIOR][6572] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][6574] == nil then EA_AltItems[EA_CLASS_WARRIOR][6574] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][7379] == nil then EA_AltItems[EA_CLASS_WARRIOR][7379] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][11600] == nil then EA_AltItems[EA_CLASS_WARRIOR][11600] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][11601] == nil then EA_AltItems[EA_CLASS_WARRIOR][11601] = true end;
      	if EA_AltItems[EA_CLASS_WARRIOR][25288] == nil then EA_AltItems[EA_CLASS_WARRIOR][25288] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][25269] == nil then EA_AltItems[EA_CLASS_WARRIOR][25269] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][30357] == nil then EA_AltItems[EA_CLASS_WARRIOR][30357] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][57823] == nil then EA_AltItems[EA_CLASS_WARRIOR][57823] = true end;

	-- Victory Rush
        if EA_AltItems[EA_CLASS_WARRIOR][34428] == nil then EA_AltItems[EA_CLASS_WARRIOR][34428] = true end;
       
end



function EventAlert_RemoveOldSpells()
    if EA_Items_BF[EA_CLASS_PALADIN][27179] == true then EA_Items_BF[EA_CLASS_PALADIN][27179] = nil end;
	if EA_Items_BF[EA_CLASS_PALADIN][27151] == true then EA_Items_BF[EA_CLASS_PALADIN][27151] = nil end;
	if EA_Items_BF[EA_CLASS_WARLOCK][47274] == true then EA_Items_BF[EA_CLASS_WARLOCK][47274] = nil end;
	if EA_Items_BF[EA_CLASS_PRIEST][34754] == true then EA_Items_BF[EA_CLASS_PRIEST][34754] = nil end;
	if EA_Items_BF[EA_CLASS_MAGE][44544] == true then EA_Items_BF[EA_CLASS_MAGE][44544] = nil end;
	if EA_Items_BF[EA_CLASS_WARLOCK][47383] == true then EA_Items_BF[EA_CLASS_WARLOCK][47383] = nil end;
	if EA_Items_BF[EA_CLASS_DK][50466] == true then EA_Items_BF[EA_CLASS_DK][50466] = nil end;

    EA_Items_BF["Other"] = nil;
end