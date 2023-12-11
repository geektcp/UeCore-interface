function EventAlert_LoadSpellArray()
	-- 职业技能提醒
	if EA_Items == nil then
		EA_Items = {};
	end
	-- 职业特殊技能提醒
	if EA_AltItems == nil then
		EA_AltItems = {};
	end
	-- 目标提醒
	if EA_TarItems == nil then
		EA_TarItems = {};
	end

-- 05/24 Remark this code. For saving the spells dynamically, and clear the CLASS_OTHER for the removed spells.
-- 04/29 Add this code. Clear the saved items to prevent alert the removed spells(old-trinket).
	-- EA_Items = {};
	-- EA_AltItems = {};
	-- EA_Items[EA_CLASS_OTHER] = {};

--------------------------------- Start Normal Items ---------------------------------
----------------------------------- 職業主要提醒區 -----------------------------------
-- Death Knight / 死亡騎士
if EA_Items[EA_CLASS_DK] == nil then EA_Items[EA_CLASS_DK] = {} end;
	-- Killing Machine
		if EA_Items[EA_CLASS_DK][51124] == nil then EA_Items[EA_CLASS_DK][51124] = true end;

	-- Rime (Freezing Fog)
		if EA_Items[EA_CLASS_DK][59052] == nil then EA_Items[EA_CLASS_DK][59052] = true end;

	-- Cinderglacier (Runeforge)
		if EA_Items[EA_CLASS_DK][53386] == nil then EA_Items[EA_CLASS_DK][53386] = true end;

-- Druid / 德魯依
if EA_Items[EA_CLASS_DRUID] == nil then EA_Items[EA_CLASS_DRUID] = {} end;
	-- Eclipse
		if EA_Items[EA_CLASS_DRUID][48517] == nil then EA_Items[EA_CLASS_DRUID][48517] = true end;
		if EA_Items[EA_CLASS_DRUID][48518] == nil then EA_Items[EA_CLASS_DRUID][48518] = true end;

	-- Nature's Grace
		if EA_Items[EA_CLASS_DRUID][16886] == nil then EA_Items[EA_CLASS_DRUID][16886] = true end;

    -- Omen of Clarity
		if EA_Items[EA_CLASS_DRUID][16870] == nil then EA_Items[EA_CLASS_DRUID][16870] = true end;

   	-- Owlkin Frenzy
		if EA_Items[EA_CLASS_DRUID][48391] == nil then EA_Items[EA_CLASS_DRUID][48391] = true end;

    -- Wrath of Elune (PvP Set Bonus)
		if EA_Items[EA_CLASS_DRUID][46833] == nil then EA_Items[EA_CLASS_DRUID][46833] = true end;

    -- Elune's Wrath (Tier 8 Set Bonus)
		if EA_Items[EA_CLASS_DRUID][64823] == nil then EA_Items[EA_CLASS_DRUID][64823] = true end;

	-- Predatory Strikes (掠食者迅捷)
		if EA_Items[EA_CLASS_DRUID][69369] == nil then EA_Items[EA_CLASS_DRUID][69369] = true end;

	-- Savage Roar / 兇蠻咆嘯
		if EA_Items[EA_CLASS_DRUID][52610] == nil then EA_Items[EA_CLASS_DRUID][52610] = false end;

	-- Berserk / 狂暴
		if EA_Items[EA_CLASS_DRUID][50334] == nil then EA_Items[EA_CLASS_DRUID][50334] = false end;

-- Hunter / 獵人
if EA_Items[EA_CLASS_HUNTER] == nil then EA_Items[EA_CLASS_HUNTER] = {} end;
	-- Improved Stead Shot
		if EA_Items[EA_CLASS_HUNTER][53220] == nil then EA_Items[EA_CLASS_HUNTER][53220] = true end;

    -- Lock and Load
		if EA_Items[EA_CLASS_HUNTER][56453] == nil then EA_Items[EA_CLASS_HUNTER][56453] = true end;

    -- Rapid Killing
		if EA_Items[EA_CLASS_HUNTER][35098] == nil then EA_Items[EA_CLASS_HUNTER][35098] = true end;
		if EA_Items[EA_CLASS_HUNTER][35099] == nil then EA_Items[EA_CLASS_HUNTER][35099] = true end;

	-- -- T10x2P / 攻擊弱點 / Exploit Weakness
	-- 	if EA_Items[EA_CLASS_HUNTER][70728] == nil then EA_Items[EA_CLASS_HUNTER][70728] = true end;
    --
	-- -- T10x4P / 釘刺 / Stinger
	-- 	if EA_Items[EA_CLASS_HUNTER][71007] == nil then EA_Items[EA_CLASS_HUNTER][71007] = true end;

-- Mage / 法師
if EA_Items[EA_CLASS_MAGE] == nil then EA_Items[EA_CLASS_MAGE] = {} end;
	-- Arcane Concentration
		if EA_Items[EA_CLASS_MAGE][12536] == nil then EA_Items[EA_CLASS_MAGE][12536] = true end;

	-- Brain Freeze
		if EA_Items[EA_CLASS_MAGE][57761] == nil then EA_Items[EA_CLASS_MAGE][57761] = true end;

	-- Fingers of Frost
		if EA_Items[EA_CLASS_MAGE][74396] == nil then EA_Items[EA_CLASS_MAGE][74396] = true end;

	-- Firestarter
		if EA_Items[EA_CLASS_MAGE][54741] == nil then EA_Items[EA_CLASS_MAGE][54741] = true end;

	-- Hot Streak
		if EA_Items[EA_CLASS_MAGE][48108] == nil then EA_Items[EA_CLASS_MAGE][48108] = true end;

	-- Missile Barrage
		if EA_Items[EA_CLASS_MAGE][44401] == nil then EA_Items[EA_CLASS_MAGE][44401] = true end;

	-- Arcane Blast / 奧衝堆疊
		if EA_Items[EA_CLASS_MAGE][36032] == nil then EA_Items[EA_CLASS_MAGE][36032] = false end;

	-- -- T10x4P / Quad Core / 四重奧義
	-- 	if EA_Items[EA_CLASS_MAGE][70747] == nil then EA_Items[EA_CLASS_MAGE][70747] = true end;

-- Paladin / 聖騎士
if EA_Items[EA_CLASS_PALADIN] == nil then EA_Items[EA_CLASS_PALADIN] = {} end;

	-- Just used for testing  (DO NOT ENABLE THESE UNLESS YOU KNOW WHAT YOU ARE DOING).
		--  if EA_Items[EA_CLASS_PALADIN][27179] == nil then EA_Items[EA_CLASS_PALADIN][27179] = true end;
		--  if EA_Items[EA_CLASS_PALADIN][27151] == nil then EA_Items[EA_CLASS_PALADIN][27151] = true end;
		--  if EA_Items[EA_CLASS_PALADIN][27140] == nil then EA_Items[EA_CLASS_PALADIN][27140] = true end;

	-- Art of War
		if EA_Items[EA_CLASS_PALADIN][53489] == nil then EA_Items[EA_CLASS_PALADIN][53489] = true end;
		if EA_Items[EA_CLASS_PALADIN][59578] == nil then EA_Items[EA_CLASS_PALADIN][59578] = true end;

	-- Infusion of Light
		if EA_Items[EA_CLASS_PALADIN][53672] == nil then EA_Items[EA_CLASS_PALADIN][53672] = true end;
		if EA_Items[EA_CLASS_PALADIN][54149] == nil then EA_Items[EA_CLASS_PALADIN][54149] = true end;

	-- Sacred Shield
		if EA_Items[EA_CLASS_PALADIN][58597] == nil then EA_Items[EA_CLASS_PALADIN][58597] = true end;

	-- -- T10x4P 神聖 / Holiness / 虔聖
	-- 	if EA_Items[EA_CLASS_PALADIN][70757] == nil then EA_Items[EA_CLASS_PALADIN][70757] = true end;
    --
	-- -- T10x4P 防護 / Deliverance / 判決
	-- 	if EA_Items[EA_CLASS_PALADIN][70760] == nil then EA_Items[EA_CLASS_PALADIN][70760] = true end;

-- Priest / 牧師
if EA_Items[EA_CLASS_PRIEST] == nil then EA_Items[EA_CLASS_PRIEST] = {} end;
	-- Borrowed Time
		if EA_Items[EA_CLASS_PRIEST][59887] == nil then EA_Items[EA_CLASS_PRIEST][59887] = true end;
		if EA_Items[EA_CLASS_PRIEST][59888] == nil then EA_Items[EA_CLASS_PRIEST][59888] = true end;
		if EA_Items[EA_CLASS_PRIEST][59889] == nil then EA_Items[EA_CLASS_PRIEST][59889] = true end;
		if EA_Items[EA_CLASS_PRIEST][59890] == nil then EA_Items[EA_CLASS_PRIEST][59890] = true end;
		if EA_Items[EA_CLASS_PRIEST][59891] == nil then EA_Items[EA_CLASS_PRIEST][59891] = true end;

	-- Holy Concentration
		if EA_Items[EA_CLASS_PRIEST][34754] == nil then EA_Items[EA_CLASS_PRIEST][34754] = true end;
		if EA_Items[EA_CLASS_PRIEST][63724] == nil then EA_Items[EA_CLASS_PRIEST][63724] = true end;
		if EA_Items[EA_CLASS_PRIEST][63725] == nil then EA_Items[EA_CLASS_PRIEST][63725] = true end;

	-- Martyrdom
		if EA_Items[EA_CLASS_PRIEST][14743] == nil then EA_Items[EA_CLASS_PRIEST][14743] = true end;
		if EA_Items[EA_CLASS_PRIEST][27828] == nil then EA_Items[EA_CLASS_PRIEST][27828] = true end;

	-- Serendipity
		if EA_Items[EA_CLASS_PRIEST][63731] == nil then EA_Items[EA_CLASS_PRIEST][63731] = true end;
		if EA_Items[EA_CLASS_PRIEST][63734] == nil then EA_Items[EA_CLASS_PRIEST][63734] = true end;
		if EA_Items[EA_CLASS_PRIEST][63735] == nil then EA_Items[EA_CLASS_PRIEST][63735] = true end;

		if EA_Items["FUNKY"] == nil then EA_Items["FUNKY"] = {} end;
		if EA_Items["FUNKY"][63731] == nil then EA_Items["FUNKY"][63731] = true end;
		if EA_Items["FUNKY"][63734] == nil then EA_Items["FUNKY"][63734] = true end;
		if EA_Items["FUNKY"][63735] == nil then EA_Items["FUNKY"][63735] = true end;
    -- Surge of Light
		if EA_Items[EA_CLASS_PRIEST][33151] == nil then EA_Items[EA_CLASS_PRIEST][33151] = true end;

-- Rogue / 盜賊
if EA_Items[EA_CLASS_ROGUE] == nil then EA_Items[EA_CLASS_ROGUE] = {} end;
		if EA_Items[EA_CLASS_ROGUE][6774] == nil then EA_Items[EA_CLASS_ROGUE][6774] = false end;
		if EA_Items[EA_CLASS_ROGUE][57993] == nil then EA_Items[EA_CLASS_ROGUE][57993] = false end;
		if EA_Items[EA_CLASS_ROGUE][63848] == nil then EA_Items[EA_CLASS_ROGUE][63848] = false end;

-- Shaman / 薩滿
if EA_Items[EA_CLASS_SHAMAN] == nil then EA_Items[EA_CLASS_SHAMAN] = {} end;
	-- Elemental Focus
		if EA_Items[EA_CLASS_SHAMAN][16246] == nil then EA_Items[EA_CLASS_SHAMAN][16246] = true end;

	-- Maelstrom Weapon (Fifth stack)
		if EA_Items[EA_CLASS_SHAMAN][53817] == nil then EA_Items[EA_CLASS_SHAMAN][53817] = true end;

	-- Tital Waves
		if EA_Items[EA_CLASS_SHAMAN][53390] == nil then EA_Items[EA_CLASS_SHAMAN][53390] = true end;

	-- -- T10x2P 增強 / Elemental Rage / 元素之怒
	-- 	if EA_Items[EA_CLASS_SHAMAN][70829] == nil then EA_Items[EA_CLASS_SHAMAN][70829] = true end;
    --
	-- -- T10x4P 增強 / Maelstrom Power / 氣漩威能
	-- 	if EA_Items[EA_CLASS_SHAMAN][70831] == nil then EA_Items[EA_CLASS_SHAMAN][70831] = true end;
    --
	-- -- T10x2P 恢復 / Rapid Currents / 急流
	-- 	if EA_Items[EA_CLASS_SHAMAN][70806] == nil then EA_Items[EA_CLASS_SHAMAN][70806] = true end;


-- Warlock / 術士
if EA_Items[EA_CLASS_WARLOCK] == nil then EA_Items[EA_CLASS_WARLOCK] = {} end;
	-- Backdraft
		if EA_Items[EA_CLASS_WARLOCK][54274] == nil then EA_Items[EA_CLASS_WARLOCK][54274] = true end;
		if EA_Items[EA_CLASS_WARLOCK][54276] == nil then EA_Items[EA_CLASS_WARLOCK][54276] = true end;
		if EA_Items[EA_CLASS_WARLOCK][54277] == nil then EA_Items[EA_CLASS_WARLOCK][54277] = true end;

	-- Backlash
		if EA_Items[EA_CLASS_WARLOCK][34936] == nil then EA_Items[EA_CLASS_WARLOCK][34936] = true end;

	-- Decimation
		if EA_Items[EA_CLASS_WARLOCK][63165] == nil then EA_Items[EA_CLASS_WARLOCK][63165] = true end;
		if EA_Items[EA_CLASS_WARLOCK][63167] == nil then EA_Items[EA_CLASS_WARLOCK][63167] = true end;

	-- Empowered Imp
		if EA_Items[EA_CLASS_WARLOCK][47283] == nil then EA_Items[EA_CLASS_WARLOCK][47283] = true end;

	-- Eradication
		if EA_Items[EA_CLASS_WARLOCK][64368] == nil then EA_Items[EA_CLASS_WARLOCK][64368] = true end;
		if EA_Items[EA_CLASS_WARLOCK][64370] == nil then EA_Items[EA_CLASS_WARLOCK][64370] = true end;
		if EA_Items[EA_CLASS_WARLOCK][64371] == nil then EA_Items[EA_CLASS_WARLOCK][64371] = true end;

	-- Molten Core (熔火之心)
		if EA_Items[EA_CLASS_WARLOCK][47383] == nil then EA_Items[EA_CLASS_WARLOCK][47383] = true end;
		if EA_Items[EA_CLASS_WARLOCK][71162] == nil then EA_Items[EA_CLASS_WARLOCK][71162] = true end;
		if EA_Items[EA_CLASS_WARLOCK][71165] == nil then EA_Items[EA_CLASS_WARLOCK][71165] = true end;

	-- Nightfall (夜幕)
		if EA_Items[EA_CLASS_WARLOCK][17941] == nil then EA_Items[EA_CLASS_WARLOCK][17941] = true end;

	-- Glyph of Life Tap (生命分流)
		if EA_Items[EA_CLASS_WARLOCK][63321] == nil then EA_Items[EA_CLASS_WARLOCK][63321] = true end;

	-- -- T10x4P / Devious Minds / 心靈沉淪
	-- 	if EA_Items[EA_CLASS_WARLOCK][70840] == nil then EA_Items[EA_CLASS_WARLOCK][70840] = true end;

-- Warrior / 戰士
if EA_Items[EA_CLASS_WARRIOR] == nil then EA_Items[EA_CLASS_WARRIOR] = {} end;
	-- Bloodsurge (Slam)
		if EA_Items[EA_CLASS_WARRIOR][46916] == nil then EA_Items[EA_CLASS_WARRIOR][46916] = true end;

	-- Sudden Death
		if EA_Items[EA_CLASS_WARRIOR][52437] == nil then EA_Items[EA_CLASS_WARRIOR][52437] = true end;

	-- Sword and Board
		if EA_Items[EA_CLASS_WARRIOR][50227] == nil then EA_Items[EA_CLASS_WARRIOR][50227] = true end;

	-- Taste for Blood
		if EA_Items[EA_CLASS_WARRIOR][60503] == nil then EA_Items[EA_CLASS_WARRIOR][60503] = true end;

	-- Glyph of Revenge
		if EA_Items[EA_CLASS_WARRIOR][58363] == nil then EA_Items[EA_CLASS_WARRIOR][58363] = true end;

	-- -- T10x2P 傷害 / Blood Drinker / 飲血者
	-- 	if EA_Items[EA_CLASS_WARRIOR][70855] == nil then EA_Items[EA_CLASS_WARRIOR][70855] = true end;


-------------------------------- Start Other Items --------------------------------
-------------------------------- 跨職業共通提醒區 ---------------------------------
-- Other
if EA_Items[EA_CLASS_OTHER] == nil then EA_Items[EA_CLASS_OTHER] = {} end;
	-- Healing Trance
		-- if EA_Items[EA_CLASS_OTHER][37706] == nil then EA_Items[EA_CLASS_OTHER][37706] = true end;
		-- if EA_Items[EA_CLASS_OTHER][37721] == nil then EA_Items[EA_CLASS_OTHER][37721] = true end;
   		-- if EA_Items[EA_CLASS_OTHER][37722] == nil then EA_Items[EA_CLASS_OTHER][37722] = true end;
        -- if EA_Items[EA_CLASS_OTHER][37723] == nil then EA_Items[EA_CLASS_OTHER][37723] = true end;
        -- if EA_Items[EA_CLASS_OTHER][60512] == nil then EA_Items[EA_CLASS_OTHER][60512] = true end;
        -- if EA_Items[EA_CLASS_OTHER][60513] == nil then EA_Items[EA_CLASS_OTHER][60513] = true end;
        -- if EA_Items[EA_CLASS_OTHER][60514] == nil then EA_Items[EA_CLASS_OTHER][60514] = true end;
        -- if EA_Items[EA_CLASS_OTHER][60515] == nil then EA_Items[EA_CLASS_OTHER][60515] = true end;

	-- Libram of Blinding Light (Spellpower)
		-- if EA_Items[EA_CLASS_OTHER][71191] == nil then EA_Items[EA_CLASS_OTHER][71191] = true end;

	-- Priest - Power Infusion / 牧師 - 注入能量
		if EA_Items[EA_CLASS_OTHER][10060] == nil then EA_Items[EA_CLASS_OTHER][10060] = true end;

	-- Priest - Pain Suppression / 牧師 - 痛苦鎮壓
		if EA_Items[EA_CLASS_OTHER][33206] == nil then EA_Items[EA_CLASS_OTHER][33206] = true end;

	-- Druid-Innervate / 德魯依-啟動
		if EA_Items[EA_CLASS_OTHER][29166] == nil then EA_Items[EA_CLASS_OTHER][29166] = true end;

	-- -- Dislodged Foreign Object / Normal+Heroic / 異物逐除
	-- 	if EA_Items[EA_CLASS_OTHER][71601] == nil then EA_Items[EA_CLASS_OTHER][71601] = true end;
	-- 	if EA_Items[EA_CLASS_OTHER][71644] == nil then EA_Items[EA_CLASS_OTHER][71644] = true end;
    --
	-- -- ICC - Blood Princes / 血親王議會
	-- 	-- Shadow Prison / 暗影之牢 / Heroic
	-- 	if EA_Items[EA_CLASS_OTHER][72999] == nil then EA_Items[EA_CLASS_OTHER][72999] = true end;
    --
	-- -- ICC - Valithria Dreamwalker / 瓦莉絲瑞雅．夢行者
	-- 	-- Emerald Vigor / 翡翠精力
	-- 	if EA_Items[EA_CLASS_OTHER][70873] == nil then EA_Items[EA_CLASS_OTHER][70873] = true end;
	-- 	-- Twisted Nightmares / 扭曲夢魘 / Heroic
	-- 	if EA_Items[EA_CLASS_OTHER][71941] == nil then EA_Items[EA_CLASS_OTHER][71941] = true end;
    --
	-- -- ICC - Sindragosa / 辛德拉苟莎
	-- 	-- Unchained Magic / 無束魔法
	-- 	if EA_Items[EA_CLASS_OTHER][69762] == nil then EA_Items[EA_CLASS_OTHER][69762] = true end;
	-- 	-- Instability / 不穩定(無束魔法反衝)
	-- 	if EA_Items[EA_CLASS_OTHER][69766] == nil then EA_Items[EA_CLASS_OTHER][69766] = true end;
	-- 	-- Chilled to the Bone / 徹骨之寒(沁骨之寒反衝)
	-- 	if EA_Items[EA_CLASS_OTHER][70106] == nil then EA_Items[EA_CLASS_OTHER][70106] = true end;
	-- 	-- Mystic Buffet / 秘能連擊
	-- 	if EA_Items[EA_CLASS_OTHER][70127] == nil then EA_Items[EA_CLASS_OTHER][70127] = true end;
	-- 	if EA_Items[EA_CLASS_OTHER][70128] == nil then EA_Items[EA_CLASS_OTHER][70128] = true end;
	-- 	if EA_Items[EA_CLASS_OTHER][72528] == nil then EA_Items[EA_CLASS_OTHER][72528] = true end;
	-- 	if EA_Items[EA_CLASS_OTHER][72529] == nil then EA_Items[EA_CLASS_OTHER][72529] = true end;
	-- 	if EA_Items[EA_CLASS_OTHER][72530] == nil then EA_Items[EA_CLASS_OTHER][72530] = true end;
		if EA_Items[EA_CLASS_OTHER][57934] == nil then EA_Items[EA_CLASS_OTHER][57934] = true end;
		if EA_Items[EA_CLASS_OTHER][34477] == nil then EA_Items[EA_CLASS_OTHER][34477] = true end;
		if EA_Items[EA_CLASS_OTHER][32182] == nil then EA_Items[EA_CLASS_OTHER][32182] = true end;
		if EA_Items[EA_CLASS_OTHER][2825] == nil then EA_Items[EA_CLASS_OTHER][2825] = true end;
		if EA_Items[EA_CLASS_OTHER][1022] == nil then EA_Items[EA_CLASS_OTHER][1022] = true end;
		if EA_Items[EA_CLASS_OTHER][5599] == nil then EA_Items[EA_CLASS_OTHER][5599] = true end;
		if EA_Items[EA_CLASS_OTHER][10278] == nil then EA_Items[EA_CLASS_OTHER][10278] = true end;
		if EA_Items[EA_CLASS_OTHER][1044] == nil then EA_Items[EA_CLASS_OTHER][1044] = true end;
		if EA_Items[EA_CLASS_OTHER][64205] == nil then EA_Items[EA_CLASS_OTHER][64205] = true end;
		if EA_Items[EA_CLASS_OTHER][6940] == nil then EA_Items[EA_CLASS_OTHER][6940] = true end;
		if EA_Items[EA_CLASS_OTHER][49016] == nil then EA_Items[EA_CLASS_OTHER][49016] = true end;
		if EA_Items[EA_CLASS_OTHER][3411] == nil then EA_Items[EA_CLASS_OTHER][3411] = true end;

-------------------------------- Start Alternate Items --------------------------------
----------------------------------- 職業額外提醒區 ------------------------------------
-- Death Knight / 死亡騎士
if EA_AltItems[EA_CLASS_DK] == nil then EA_AltItems[EA_CLASS_DK] = {} end;
	-- Rune Strike
    	if EA_AltItems[EA_CLASS_DK][56815] == nil then EA_AltItems[EA_CLASS_DK][56815] = true end;

-- Druid / 德魯依
if EA_AltItems[EA_CLASS_DRUID] == nil then EA_AltItems[EA_CLASS_DRUID] = {} end;

-- Hunter / 獵人
if EA_AltItems[EA_CLASS_HUNTER] == nil then EA_AltItems[EA_CLASS_HUNTER] = {} end;
	-- Kill Shot
		if EA_AltItems[EA_CLASS_HUNTER][53351] == nil then EA_AltItems[EA_CLASS_HUNTER][53351] = true end;
		if EA_AltItems[EA_CLASS_HUNTER][61005] == nil then EA_AltItems[EA_CLASS_HUNTER][61005] = true end;
		if EA_AltItems[EA_CLASS_HUNTER][61006] == nil then EA_AltItems[EA_CLASS_HUNTER][61006] = true end;

-- Mage / 法師
if EA_AltItems[EA_CLASS_MAGE] == nil then EA_AltItems[EA_CLASS_MAGE] = {} end;

-- Paladin / 聖騎士
if EA_AltItems[EA_CLASS_PALADIN] == nil then EA_AltItems[EA_CLASS_PALADIN] = {} end;
	-- Hammer of Wrath
		if EA_AltItems[EA_CLASS_PALADIN][24275] == nil then EA_AltItems[EA_CLASS_PALADIN][24275] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][24274] == nil then EA_AltItems[EA_CLASS_PALADIN][24274] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][24239] == nil then EA_AltItems[EA_CLASS_PALADIN][24239] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][27180] == nil then EA_AltItems[EA_CLASS_PALADIN][27180] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][48805] == nil then EA_AltItems[EA_CLASS_PALADIN][48805] = true end;
		if EA_AltItems[EA_CLASS_PALADIN][48806] == nil then EA_AltItems[EA_CLASS_PALADIN][48806] = true end;

-- Priest / 牧師
if EA_AltItems[EA_CLASS_PRIEST] == nil then EA_AltItems[EA_CLASS_PRIEST] = {} end;

-- Rogue / 盜賊
if EA_AltItems[EA_CLASS_ROGUE] == nil then EA_AltItems[EA_CLASS_ROGUE] = {} end;
	-- Riposte
		if EA_AltItems[EA_CLASS_ROGUE][14251] == nil then EA_AltItems[EA_CLASS_ROGUE][14251] = true end;

-- Shaman / 薩滿
if EA_AltItems[EA_CLASS_SHAMAN] == nil then EA_AltItems[EA_CLASS_SHAMAN] = {} end;

-- Warlock / 術士
if EA_AltItems[EA_CLASS_WARLOCK] == nil then EA_AltItems[EA_CLASS_WARLOCK] = {} end;

-- Warrior / 戰士
if EA_AltItems[EA_CLASS_WARRIOR] == nil then EA_AltItems[EA_CLASS_WARRIOR] = {} end;
	-- Overpower 压制
    	if EA_AltItems[EA_CLASS_WARRIOR][7384] == nil then EA_AltItems[EA_CLASS_WARRIOR][7384] = true end;

	-- Execute 斩杀
    	if EA_AltItems[EA_CLASS_WARRIOR][5308] == nil then EA_AltItems[EA_CLASS_WARRIOR][5308] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20658] == nil then EA_AltItems[EA_CLASS_WARRIOR][20658] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20660] == nil then EA_AltItems[EA_CLASS_WARRIOR][20660] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20661] == nil then EA_AltItems[EA_CLASS_WARRIOR][20661] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][20662] == nil then EA_AltItems[EA_CLASS_WARRIOR][20662] = true end;
      	if EA_AltItems[EA_CLASS_WARRIOR][25234] == nil then EA_AltItems[EA_CLASS_WARRIOR][25234] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][25236] == nil then EA_AltItems[EA_CLASS_WARRIOR][25236] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][47470] == nil then EA_AltItems[EA_CLASS_WARRIOR][47470] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][47471] == nil then EA_AltItems[EA_CLASS_WARRIOR][47471] = true end;

	-- Revenge 复仇
    	if EA_AltItems[EA_CLASS_WARRIOR][6572] == nil then EA_AltItems[EA_CLASS_WARRIOR][6572] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][6574] == nil then EA_AltItems[EA_CLASS_WARRIOR][6574] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][7379] == nil then EA_AltItems[EA_CLASS_WARRIOR][7379] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][11600] == nil then EA_AltItems[EA_CLASS_WARRIOR][11600] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][11601] == nil then EA_AltItems[EA_CLASS_WARRIOR][11601] = true end;
      	if EA_AltItems[EA_CLASS_WARRIOR][25288] == nil then EA_AltItems[EA_CLASS_WARRIOR][25288] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][25269] == nil then EA_AltItems[EA_CLASS_WARRIOR][25269] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][30357] == nil then EA_AltItems[EA_CLASS_WARRIOR][30357] = true end;
    	if EA_AltItems[EA_CLASS_WARRIOR][57823] == nil then EA_AltItems[EA_CLASS_WARRIOR][57823] = true end;

	-- Victory Rush 乘胜追击
        if EA_AltItems[EA_CLASS_WARRIOR][34428] == nil then EA_AltItems[EA_CLASS_WARRIOR][34428] = true end;

--------------------------------- Start Target Items ---------------------------------
----------------------------------- 職業目標提醒區 -----------------------------------
-- Death Knight / 死亡騎士
if EA_TarItems[EA_CLASS_DK] == nil then EA_TarItems[EA_CLASS_DK] = {} end;

-- Druid / 德魯依
if EA_TarItems[EA_CLASS_DRUID] == nil then EA_TarItems[EA_CLASS_DRUID] = {} end;
	-- Faerie Fire / 精靈之火
		if EA_TarItems[EA_CLASS_DRUID][770] == nil then EA_TarItems[EA_CLASS_DRUID][770] = false end;

	-- Insect Swarm(Rank 5-7) / 蟲群(等級 5-7)
		-- if EA_TarItems[EA_CLASS_DRUID][5570] == nil then EA_TarItems[EA_CLASS_DRUID][5570] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][24974] == nil then EA_TarItems[EA_CLASS_DRUID][24974] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][24975] == nil then EA_TarItems[EA_CLASS_DRUID][24975] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][24976] == nil then EA_TarItems[EA_CLASS_DRUID][24976] = true end;
		if EA_TarItems[EA_CLASS_DRUID][24977] == nil then EA_TarItems[EA_CLASS_DRUID][24977] = false end;
		if EA_TarItems[EA_CLASS_DRUID][27013] == nil then EA_TarItems[EA_CLASS_DRUID][27013] = false end;
		if EA_TarItems[EA_CLASS_DRUID][48468] == nil then EA_TarItems[EA_CLASS_DRUID][48468] = false end;

	-- Moonfire(Rank 11-14) / 月火術(等級 11-14)
		-- if EA_TarItems[EA_CLASS_DRUID][8929] == nil then EA_TarItems[EA_CLASS_DRUID][8929] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][9833] == nil then EA_TarItems[EA_CLASS_DRUID][9833] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][9834] == nil then EA_TarItems[EA_CLASS_DRUID][9834] = true end;
		-- if EA_TarItems[EA_CLASS_DRUID][9835] == nil then EA_TarItems[EA_CLASS_DRUID][9835] = true end;
		if EA_TarItems[EA_CLASS_DRUID][26987] == nil then EA_TarItems[EA_CLASS_DRUID][26987] = false end;
		if EA_TarItems[EA_CLASS_DRUID][26988] == nil then EA_TarItems[EA_CLASS_DRUID][26988] = false end;
		if EA_TarItems[EA_CLASS_DRUID][48462] == nil then EA_TarItems[EA_CLASS_DRUID][48462] = false end;
		if EA_TarItems[EA_CLASS_DRUID][48463] == nil then EA_TarItems[EA_CLASS_DRUID][48463] = false end;

	-- Mangle(Bear) / 割碎(熊形態)
		if EA_TarItems[EA_CLASS_DRUID][48564] == nil then EA_TarItems[EA_CLASS_DRUID][48564] = false end;

	-- Mangle(Cat) / 割碎(獵豹形態)
		if EA_TarItems[EA_CLASS_DRUID][48566] == nil then EA_TarItems[EA_CLASS_DRUID][48566] = false end;

	-- Faerie Fire (Feral) / 精靈之火(野性)
		if EA_TarItems[EA_CLASS_DRUID][16857] == nil then EA_TarItems[EA_CLASS_DRUID][16857] = false end;

	-- Infected Wounds / 感染之傷
		if EA_TarItems[EA_CLASS_DRUID][58181] == nil then EA_TarItems[EA_CLASS_DRUID][58181] = false end;

	-- Lacerate / 割裂
		if EA_TarItems[EA_CLASS_DRUID][48568] == nil then EA_TarItems[EA_CLASS_DRUID][48568] = false end;

	-- Rake / 掃擊
		if EA_TarItems[EA_CLASS_DRUID][48574] == nil then EA_TarItems[EA_CLASS_DRUID][48574] = false end;

	-- Rip / 撕扯
		if EA_TarItems[EA_CLASS_DRUID][49800] == nil then EA_TarItems[EA_CLASS_DRUID][49800] = false end;

-- Hunter / 獵人
if EA_TarItems[EA_CLASS_HUNTER] == nil then EA_TarItems[EA_CLASS_HUNTER] = {} end;

-- Mage / 法師
if EA_TarItems[EA_CLASS_MAGE] == nil then EA_TarItems[EA_CLASS_MAGE] = {} end;
	-- Frostbite / 霜寒刺骨
		if EA_TarItems[EA_CLASS_MAGE][12494] == nil then EA_TarItems[EA_CLASS_MAGE][12494] = false end;

	-- Winter's Chill / 深冬之寒
		if EA_TarItems[EA_CLASS_MAGE][12579] == nil then EA_TarItems[EA_CLASS_MAGE][12579] = false end;

	-- Slow / 減速術
		if EA_TarItems[EA_CLASS_MAGE][31589] == nil then EA_TarItems[EA_CLASS_MAGE][31589] = false end;

	-- Living Bomb(Rank 1) / 活體爆彈(等級 1)
		if EA_TarItems[EA_CLASS_MAGE][44457] == nil then EA_TarItems[EA_CLASS_MAGE][44457] = false end;

-- Paladin / 聖騎士
if EA_TarItems[EA_CLASS_PALADIN] == nil then EA_TarItems[EA_CLASS_PALADIN] = {} end;

-- Priest / 牧師
if EA_TarItems[EA_CLASS_PRIEST] == nil then EA_TarItems[EA_CLASS_PRIEST] = {} end;
	-- Weakened Soul / 虛弱靈魂
		if EA_TarItems[EA_CLASS_PRIEST][6788] == nil then EA_TarItems[EA_CLASS_PRIEST][6788] = false end;

	-- Shadow Weaving (Rank 1) / 暗影交織(等級 1)
		if EA_TarItems[EA_CLASS_PRIEST][15258] == nil then EA_TarItems[EA_CLASS_PRIEST][15258] = false end;

	-- Misery (Rank 1-3) / 苦難(等級 1-3)
		if EA_TarItems[EA_CLASS_PRIEST][33196] == nil then EA_TarItems[EA_CLASS_PRIEST][33196] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][33197] == nil then EA_TarItems[EA_CLASS_PRIEST][33197] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][33198] == nil then EA_TarItems[EA_CLASS_PRIEST][33198] = false end;

	-- Shadow Word: Pain (Rank 10-12) / 暗言術:痛(等級 10-12)
		-- if EA_TarItems[EA_CLASS_PRIEST][10892] == nil then EA_TarItems[EA_CLASS_PRIEST][10892] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][10893] == nil then EA_TarItems[EA_CLASS_PRIEST][10893] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][10894] == nil then EA_TarItems[EA_CLASS_PRIEST][10894] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][25367] == nil then EA_TarItems[EA_CLASS_PRIEST][25367] = true end;
		if EA_TarItems[EA_CLASS_PRIEST][25368] == nil then EA_TarItems[EA_CLASS_PRIEST][25368] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48124] == nil then EA_TarItems[EA_CLASS_PRIEST][48124] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48125] == nil then EA_TarItems[EA_CLASS_PRIEST][48125] = false end;

	-- Vampiric Touch (Rank 3-5) / 吸血之觸(等級 3-5)
		-- if EA_TarItems[EA_CLASS_PRIEST][34914] == nil then EA_TarItems[EA_CLASS_PRIEST][34914] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][34916] == nil then EA_TarItems[EA_CLASS_PRIEST][34916] = true end;
		if EA_TarItems[EA_CLASS_PRIEST][34917] == nil then EA_TarItems[EA_CLASS_PRIEST][34917] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48159] == nil then EA_TarItems[EA_CLASS_PRIEST][48159] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48160] == nil then EA_TarItems[EA_CLASS_PRIEST][48160] = false end;

	-- Devouring Plague (Rank 9) / 噬靈瘟疫(等級 9)
		-- if EA_TarItems[EA_CLASS_PRIEST][19278] == nil then EA_TarItems[EA_CLASS_PRIEST][19278] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][19279] == nil then EA_TarItems[EA_CLASS_PRIEST][19279] = true end;
		-- if EA_TarItems[EA_CLASS_PRIEST][19280] == nil then EA_TarItems[EA_CLASS_PRIEST][19280] = true end;
		if EA_TarItems[EA_CLASS_PRIEST][25467] == nil then EA_TarItems[EA_CLASS_PRIEST][25467] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48299] == nil then EA_TarItems[EA_CLASS_PRIEST][48299] = false end;
		if EA_TarItems[EA_CLASS_PRIEST][48300] == nil then EA_TarItems[EA_CLASS_PRIEST][48300] = false end;

	-- Psychic Horror / 心靈恐慌
		if EA_TarItems[EA_CLASS_PRIEST][64058] == nil then EA_TarItems[EA_CLASS_PRIEST][64058] = false end;

-- Rogue / 盜賊
if EA_TarItems[EA_CLASS_ROGUE] == nil then EA_TarItems[EA_CLASS_ROGUE] = {} end;
		if EA_TarItems[EA_CLASS_ROGUE][8647] == nil then EA_TarItems[EA_CLASS_ROGUE][8647] = false end;
		if EA_TarItems[EA_CLASS_ROGUE][48672] == nil then EA_TarItems[EA_CLASS_ROGUE][48672] = false end;

-- Shaman / 薩滿
if EA_TarItems[EA_CLASS_SHAMAN] == nil then EA_TarItems[EA_CLASS_SHAMAN] = {} end;

-- Warlock / 術士
if EA_TarItems[EA_CLASS_WARLOCK] == nil then EA_TarItems[EA_CLASS_WARLOCK] = {} end;
	-- Immolate (Rank 9-11) / 獻祭(等級 9-11)
		-- if EA_TarItems[EA_CLASS_WARLOCK][11667] == nil then EA_TarItems[EA_CLASS_WARLOCK][11667] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11668] == nil then EA_TarItems[EA_CLASS_WARLOCK][11668] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][25309] == nil then EA_TarItems[EA_CLASS_WARLOCK][25309] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][27215] == nil then EA_TarItems[EA_CLASS_WARLOCK][27215] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47810] == nil then EA_TarItems[EA_CLASS_WARLOCK][47810] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47811] == nil then EA_TarItems[EA_CLASS_WARLOCK][47811] = false end;

	-- Corruption (Rank 10) / 腐蝕術(等級 8-10)
		-- if EA_TarItems[EA_CLASS_WARLOCK][11671] == nil then EA_TarItems[EA_CLASS_WARLOCK][11671] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11672] == nil then EA_TarItems[EA_CLASS_WARLOCK][11672] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][25311] == nil then EA_TarItems[EA_CLASS_WARLOCK][25311] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][27216] == nil then EA_TarItems[EA_CLASS_WARLOCK][27216] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47812] == nil then EA_TarItems[EA_CLASS_WARLOCK][47812] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47813] == nil then EA_TarItems[EA_CLASS_WARLOCK][47813] = false end;

	-- Curse of Tongues (Rank 2) / 語言詛咒(等級 2)
		-- if EA_TarItems[EA_CLASS_WARLOCK][1714] == nil then EA_TarItems[EA_CLASS_WARLOCK][1714] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][11719] == nil then EA_TarItems[EA_CLASS_WARLOCK][11719] = false end;

	-- Curse of Agony (Rank 7-9) / 痛苦詛咒(等級 7-9)
		-- if EA_TarItems[EA_CLASS_WARLOCK][11711] == nil then EA_TarItems[EA_CLASS_WARLOCK][11711] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11712] == nil then EA_TarItems[EA_CLASS_WARLOCK][11712] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11713] == nil then EA_TarItems[EA_CLASS_WARLOCK][11713] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][27218] == nil then EA_TarItems[EA_CLASS_WARLOCK][27218] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47863] == nil then EA_TarItems[EA_CLASS_WARLOCK][47863] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47864] == nil then EA_TarItems[EA_CLASS_WARLOCK][47864] = false end;

	-- Curse of the Elements (Rank 3-5) / 元素詛咒(等級 3-5)
		-- if EA_TarItems[EA_CLASS_WARLOCK][1490] == nil then EA_TarItems[EA_CLASS_WARLOCK][1490] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11721] == nil then EA_TarItems[EA_CLASS_WARLOCK][11721] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][11722] == nil then EA_TarItems[EA_CLASS_WARLOCK][11722] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][27228] == nil then EA_TarItems[EA_CLASS_WARLOCK][27228] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][47865] == nil then EA_TarItems[EA_CLASS_WARLOCK][47865] = false end;

	-- Curse of Weakness (Rank 7-9) / 虛弱詛咒(等級 7-9)
		-- if EA_TarItems[EA_CLASS_WARLOCK][7646] == nil then EA_TarItems[EA_CLASS_WARLOCK][7646] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11707] == nil then EA_TarItems[EA_CLASS_WARLOCK][11707] = true end;
		-- if EA_TarItems[EA_CLASS_WARLOCK][11708] == nil then EA_TarItems[EA_CLASS_WARLOCK][11708] = true end;
		if EA_TarItems[EA_CLASS_WARLOCK][27224] == nil then EA_TarItems[EA_CLASS_WARLOCK][27224] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][30909] == nil then EA_TarItems[EA_CLASS_WARLOCK][30909] = false end;
		if EA_TarItems[EA_CLASS_WARLOCK][50511] == nil then EA_TarItems[EA_CLASS_WARLOCK][50511] = false end;

-- Warrior / 戰士
if EA_TarItems[EA_CLASS_WARRIOR] == nil then EA_TarItems[EA_CLASS_WARRIOR] = {} end;

end