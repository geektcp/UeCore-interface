-- (c) 2007 Nymbia.  see LGPLv2.1.txt for full details.
--DO NOT MAKE CHANGES TO THIS FILE BEFORE READING THE WIKI PAGE REGARDING CHANGING THESE FILES
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("InstanceLootHeroic", gsub("$Rev: 279 $", "(%d+)", function(n) return n+90000 end), {
	["InstanceLootHeroic.Auchindoun"]="m,InstanceLootHeroic.Auchenai Crypts,InstanceLootHeroic.Mana-Tombs,InstanceLootHeroic.Shadow Labyrinth,InstanceLootHeroic.Sethekk Halls",
	["InstanceLootHeroic.Auchenai Crypts.Exarch Maladaar"]="27523:130,27867:103,27869:125,27870:97,27871:129,27872:99,29244:217,29257:246,29354:104,30586:80,30587:75,30588:71",
	["InstanceLootHeroic.Auchenai Crypts.Shirrak the Dead Watcher"]="27493:124,27845:133,27846:131,27847:103,27865:99,27866:144,30586:50,30587:42,30588:46",

	["InstanceLootHeroic.Magisters' Terrace.Selin Fireheart"]="34601:208,34602:204,34603:202,34604:201,34697:12,34698:11,34699:10,34700:10,34701:10,34702:11,35275:14",
	["InstanceLootHeroic.Magisters' Terrace.Vexallus"]="34605:184,34606:190,34607:195,34608:184,34703:10,34705:10,34707:10,35275:13",
	["InstanceLootHeroic.Magisters' Terrace.Priestess Delrissa"]="34470:188,34471:188,34472:182,34473:179,34788:10,34789:10,35275:12,35756:184",
	["InstanceLootHeroic.Magisters' Terrace.Kael'thas Sunstrider"]="34609:201,34610:182,34611:187,34612:183,34613:188,34614:182,34615:189,34616:183,34625:10,34793:12,34794:10,34795:11,34796:11,34797:10,34798:10,34799:10,34807:11,34808:12,34810:10,35275:22,35504:61,35513:25",

	["InstanceLootHeroic.Mana-Tombs.Nexus-Prince Shaffar"]="22921:40,27798:113,27827:120,27828:119,27829:104,27831:127,27835:111,27837:116,27840:115,27842:110,27843:124,27844:128,28400:104,29240:199,29352:161,30535:188,30583:73,30584:55,30585:63,32082:102",
	["InstanceLootHeroic.Mana-Tombs.Pandemonius"]="27813:118,27814:125,27815:120,27816:145,27817:166,27818:136,30583:76,30584:86,30585:79",
	["InstanceLootHeroic.Mana-Tombs.Tavarok"]="27821:121,27822:128,27823:138,27824:141,27825:146,27826:108,30583:69,30584:61,30585:64",

	["InstanceLootHeroic.Shadow Labyrinth.Ambassador Hellmaw"]="27884:146,27885:159,27886:140,27887:140,27888:131,27889:162,30559:62,30560:64,30563:55",
	["InstanceLootHeroic.Shadow Labyrinth.Blackheart the Inciter"]="25728:36,27468:152,27890:131,27891:126,27892:145,27893:149,28134:122,30559:42,30560:49,30563:43",
	["InstanceLootHeroic.Shadow Labyrinth.Grandmaster Vorpil"]="27775:179,27897:145,27898:171,27900:189,27901:153,30559:41,30560:49,30563:43",
	["InstanceLootHeroic.Shadow Labyrinth.Murmur"]="24309:18,27778:124,27803:104,27902:142,27903:131,27905:119,27908:108,27909:135,27910:134,27912:128,27913:118,28230:141,28232:127,29261:137,29353:70,29357:125,30532:127,30559:46,30560:63,30563:55",
	["InstanceLootHeroic.Sethekk Halls.Darkweaver Syth"]="24160:21,27914:141,27915:133,27916:128,27917:151,27918:143,27919:153,30552:53,30553:62,30554:65",
	["InstanceLootHeroic.Sethekk Halls.Talon King Ikiss"]="27776:145,27838:132,27875:132,27925:157,27936:150,27946:130,27948:108,27980:121,27981:127,27985:113,27986:103,29249:181,29259:180,29355:76,30552:54,30553:63,30554:63,32073:136",
	["InstanceLootHeroic.Sethekk Halls.Anzu"]="30552:71,30553:82,30554:90,32769:176,32778:207,32779:164,32780:155,32781:180",

	["InstanceLootHeroic.Caverns of Time"]="m,InstanceLootHeroic.Old Hillsbrad Foothills,InstanceLootHeroic.The Black Morass",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Captain Skarloc"]="22927:59,28216:92,28217:112,28218:116,28219:104,28220:92,28221:108,30589:44,30590:49,30591:48",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Epoch Hunter"]="24173:18,27904:131,27911:100,28191:87,28222:106,28223:95,28224:118,28225:113,28226:101,28227:88,28233:89,28344:97,28401:110,29246:165,29250:144,30534:130,30536:127,30589:75,30590:58,30591:63",
	["InstanceLootHeroic.Old Hillsbrad Foothills.Lieutenant Drake"]="28210:106,28211:112,28212:115,28213:122,28214:124,28215:123,30589:50,30590:48,30591:52",
	["InstanceLootHeroic.The Black Morass.Aeonus"]="27509:152,27839:132,27873:122,27977:151,28188:131,28189:134,28190:140,28192:148,28193:146,28194:144,28206:155,28207:129,29247:181,29253:165,29356:94,30531:156,30555:47,30556:55,30558:51",
	["InstanceLootHeroic.The Black Morass.Chrono Lord Deja"]="27987:128,27988:136,27993:142,27994:131,27995:152,27996:144,29675:32,30555:56,30556:52,30558:47",
	["InstanceLootHeroic.The Black Morass.Temporus"]="28033:128,28034:146,28184:128,28185:140,28186:121,28187:119,30555:52,30556:54,30558:56",

	["InstanceLootHeroic.Coilfang Reservoir"]="m,InstanceLootHeroic.The Slave Pens,InstanceLootHeroic.The Steamvault,InstanceLootHeroic.The Underbog",
	["InstanceLootHeroic.The Slave Pens.Mennu the Betrayer"]="27541:128,27542:140,27543:152,27544:137,27545:149,27546:133,29674:21,30603:47,30604:55,30605:57",
	["InstanceLootHeroic.The Slave Pens.Quagmirran"]="27672:112,27673:137,27683:103,27712:117,27713:127,27714:113,27740:117,27741:113,27742:130,27796:118,27800:132,28337:114,29242:177,29349:93,30538:175,30603:68,30604:89,30605:81,32078:141",
	["InstanceLootHeroic.The Slave Pens.Rokmar the Crackler"]="27547:145,27548:129,27549:130,27550:146,27551:130,28124:130,30603:53,30604:56,30605:60",
	["InstanceLootHeroic.The Slave Pens.Ahune"]="35494:140,35495:60,35496:120,35497:100,35514:40,35498:150,34955:19,35507:80,35508:80,35509:80,35510:80,35511:80,",
	["InstanceLootHeroic.The Steamvault.Hydromancer Thespia"]="27508:178,27783:175,27784:155,27787:167,27789:158,29673:26,30549:49,30550:58,30551:51",
	["InstanceLootHeroic.The Steamvault.Mekgineer Steamrigger"]="23887:37,27790:172,27791:173,27792:154,27793:154,27794:166,30549:55,30550:61,30551:49",
	["InstanceLootHeroic.The Steamvault.Warlord Kalithresh"]="24313:22,27475:130,27510:117,27737:137,27738:131,27795:129,27799:140,27801:115,27804:118,27805:146,27806:140,27874:119,28203:121,29243:177,29351:95,29463:156,30543:150,30549:70,30550:73,30551:70",
	["InstanceLootHeroic.The Underbog.Ghaz'an"]="27755:131,27757:128,27758:152,27759:139,27760:124,27761:140,30606:58,30607:64,30608:57",
	["InstanceLootHeroic.The Underbog.Hungarfen"]="27743:151,27744:129,27745:149,27746:126,27747:145,27748:127,30606:61,30607:63,30608:64",
	["InstanceLootHeroic.The Underbog.Swamplord Musel'ek"]="27762:122,27763:139,27764:126,27765:145,27766:131,27767:123,30606:58,30607:63,30608:63",
	["InstanceLootHeroic.The Underbog.The Black Stalker"]="27768:109,27769:115,27770:107,27771:113,27772:120,27773:120,27779:118,27780:118,27781:128,27896:128,27907:104,27938:106,29265:187,29350:131,30541:179,30606:87,30607:92,30608:77,32081:79",

	["InstanceLootHeroic.Hellfire Citadel"]="m,InstanceLootHeroic.Hellfire Ramparts,InstanceLootHeroic.Magtheridon's Lair,InstanceLootHeroic.The Blood Furnace,InstanceLootHeroic.The Shattered Halls",
	["InstanceLootHeroic.Hellfire Ramparts.Nazan"]="",
	["InstanceLootHeroic.Hellfire Ramparts.Omor the Unscarred"]="27462:107,27463:129,27464:142,27465:135,27466:117,27467:111,27476:113,27477:128,27478:122,27539:105,27895:130,27906:124,30593:64,30594:59",
	["InstanceLootHeroic.Hellfire Ramparts.Vazruden"]="",
	["InstanceLootHeroic.Hellfire Ramparts.Watchkeeper Gargolmar"]="27447:175,27448:165,27449:151,27450:150,27451:164,30593:52,30594:59",
	["InstanceLootHeroic.The Blood Furnace.Broggok"]="27489:125,27490:150,27491:157,27492:162,27848:134,30600:54,30601:51,30602:57",
	["InstanceLootHeroic.The Blood Furnace.Keli'dan the Breaker"]="27494:108,27495:137,27497:96,27505:110,27506:122,27507:116,27512:112,27514:120,27522:104,27788:125,28121:125,28264:95,29239:171,29245:167,29347:78,30600:83,30601:91,30602:71,32080:118",
	["InstanceLootHeroic.The Blood Furnace.The Maker"]="27483:147,27484:149,27485:166,27487:158,27488:186,30600:59,30601:54,30602:61",
	["InstanceLootHeroic.The Shattered Halls.Grand Warlock Nethekurse"]="24312:24,27517:162,27518:171,27519:162,27520:174,27521:163,30546:52,30547:45,30548:55",
	["InstanceLootHeroic.The Shattered Halls.Warbringer O'mrogg"]="27524:163,27525:183,27526:171,27802:152,27868:163,30546:63,30547:52,30548:59",
	["InstanceLootHeroic.The Shattered Halls.Warchief Kargath Bladefist"]="27474:109,27527:127,27528:134,27529:119,27531:107,27533:116,27534:132,27535:112,27536:137,27537:128,27538:106,27540:128,29254:134,29255:180,29263:161,29348:81,30546:58,30547:59,30548:67",
	["InstanceLootHeroic.The Shattered Halls.Blood Guard Porung"]="30546:68,30547:53,30548:71,30705:176,30707:195,30708:158,30709:197,30710:77",

	["InstanceLootHeroic.Tempest Keep"]="m,InstanceLootHeroic.The Arcatraz,InstanceLootHeroic.The Mechanar,InstanceLootHeroic.The Botanica",
	["InstanceLootHeroic.The Arcatraz.Dalliah the Doomsayer"]="24308:43,28386:157,28387:160,28390:154,28391:170,28392:178,30575:84,30581:75,30582:62",
	["InstanceLootHeroic.The Arcatraz.Harbinger Skyriss"]="28205:129,28231:135,28403:132,28406:133,28407:132,28412:126,28413:136,28414:138,28415:124,28416:142,28418:112,28419:130,29241:153,29248:188,29252:175,29360:105,30575:64,30581:60,30582:59",
	["InstanceLootHeroic.The Arcatraz.Wrath-Scryer Soccothrates"]="28393:159,28394:160,28396:173,28397:146,28398:183,30575:71,30581:66,30582:61",
	["InstanceLootHeroic.The Arcatraz.Zereketh the Unbound"]="28372:151,28373:180,28374:175,28375:152,28384:161,30575:76,30581:65,30582:63",
	["InstanceLootHeroic.The Botanica.Commander Sarannis"]="28296:189,28301:154,28304:179,28306:181,28311:162,30572:56,30573:66,30574:60",
	["InstanceLootHeroic.The Botanica.High Botanist Freywinn"]="23617:37,28315:171,28316:153,28317:177,28318:176,28321:169,30572:62,30573:72,30574:61",
	["InstanceLootHeroic.The Botanica.Laj"]="27739:163,28328:169,28338:155,28339:156,28340:153,30572:69,30573:68,30574:69",
	["InstanceLootHeroic.The Botanica.Thorngrin the Tender"]="24310:40,28322:182,28323:171,28324:151,28325:158,28327:166,30572:75,30573:76,30574:68",
	["InstanceLootHeroic.The Botanica.Warp Splinter"]="24311:31,28228:119,28229:98,28341:105,28342:111,28343:128,28345:110,28347:121,28348:121,28349:138,28350:112,28367:125,28370:146,28371:135,29258:212,29262:202,29359:88,30572:64,30573:67,30574:55,32072:170",
	["InstanceLootHeroic.The Mechanar.Mechano-Lord Capacitus"]="28253:147,28254:152,28255:146,28256:126,28257:125,30564:60,30565:54,30566:62,35582:64",
	["InstanceLootHeroic.The Mechanar.Nethermancer Sepethrea"]="22920:70,28258:151,28259:165,28260:161,28262:162,28263:145,30564:66,30565:72,30566:66",
	["InstanceLootHeroic.The Mechanar.Pathaleon the Calculator"]="21907:79,27899:123,28202:152,28204:141,28265:109,28266:134,28267:129,28269:131,28275:133,28278:144,28285:116,28286:140,28288:122,29251:222,29362:98,30533:233,30564:64,30565:61,30566:67,32076:198",

-- -----
-- WotLK Instances
-- -----

	["InstanceLootHeroic.Azjol-Nerub Hub"]="m,InstanceLootHeroic.Ahn'kahet: The Old Kingdom,InstanceLootHeroic.Azjol-Nerub",
-- Ahn'kahet: The Old Kingdom
	["InstanceLootHeroic.Ahn'kahet: The Old Kingdom.Amanitar"]="43284:216,43285:217,43286:222,43287:212",
	["InstanceLootHeroic.Ahn'kahet: The Old Kingdom.Elder Nadox"]="37591:219,37592:217,37593:223,37594:212",
	["InstanceLootHeroic.Ahn'kahet: The Old Kingdom.Herald Volazj"]="37615:187,37616:191,37617:194,37618:193,37619:175,37620:174,37622:185,37623:192,41790:150",
	["InstanceLootHeroic.Ahn'kahet: The Old Kingdom.Jedoga Shadowseeker"]="43280:210,43281:217,43282:210,43283:198",
	["InstanceLootHeroic.Ahn'kahet: The Old Kingdom.Prince Taldaram"]="37595:199,37612:195,37613:203,37614:209,44731:15",
-- Azjol-Nerub
	["InstanceLootHeroic.Azjol-Nerub.Anub'arak"]="37232:188,37235:203,37236:196,37237:193,37238:181,37240:192,37241:182,37242:190,41796:113",
	["InstanceLootHeroic.Azjol-Nerub.Hadronox"]="37220:196,37221:197,37222:202,37230:201",
	["InstanceLootHeroic.Azjol-Nerub.Krik'thir the Gatewatcher"]="37216:212,37217:218,37218:205,37219:211",

	["InstanceLootHeroic.The Culling of Stratholme.Chrono-Lord Epoch"]="37685:219,37686:228,37687:222,37688:222",
	["InstanceLootHeroic.The Culling of Stratholme.Dark Runed Chest"]="37689:130,37690:131,37691:137,37692:131,37693:103,37694:97,37695:103,37696:103,43085:94",
	["InstanceLootHeroic.The Culling of Stratholme.Infinite Corruptor"]="43951:835",
	["InstanceLootHeroic.The Culling of Stratholme.Mal'Ganis"]="m,InstanceLootHeroic.The Culling of Stratholme.Dark Runed Chest",
	["InstanceLootHeroic.The Culling of Stratholme.Meathook"]="37675:219,37678:218,37679:211,37680:209",
	["InstanceLootHeroic.The Culling of Stratholme.Salramm the Fleshcrafter"]="37681:213,37682:216,37683:217,37684:213",

	["InstanceLootHeroic.Drak'Tharon Keep.King Dred"]="37723:214,37724:209,37725:197,37726:202",
	["InstanceLootHeroic.Drak'Tharon Keep.Novos the Summoner"]="37718:210,37721:216,37722:215,40490:208",
	["InstanceLootHeroic.Drak'Tharon Keep.The Prophet Tharon'ja"]="37732:198,37733:205,37734:208,37735:206,37784:188,37788:207,37791:202,37798:193,41795:129",
	["InstanceLootHeroic.Drak'Tharon Keep.Trollgore"]="37712:213,37714:215,37715:208,37717:214",

	["InstanceLootHeroic.Gundrak.Drakkari Colossus"]="m,InstanceLootHeroic.Gundrak.Drakkari Elemental",
	["InstanceLootHeroic.Gundrak.Drakkari Elemental"]="37634:194,37635:198,37636:203,37637:201",
	["InstanceLootHeroic.Gundrak.Eck the Ferocious"]="43310:224,43311:220,43312:228,43313:225",
	["InstanceLootHeroic.Gundrak.Gal'darah"]="37638:198,37639:196,37640:197,37641:189,37642:182,37643:189,37644:187,37645:191",
	["InstanceLootHeroic.Gundrak.Moorabi"]="37630:211,37631:218,37632:215,37633:213",
	["InstanceLootHeroic.Gundrak.Slad'ran"]="37626:197,37627:201,37628:201,37629:203",

	["InstanceLootHeroic.Naxxramas.Anub'Rekhan"]="39701:185,39702:180,39703:180,39704:192,39706:188,39712:230,39714:231,39716:239,39717:227,39718:185,39719:188,39720:189,39721:191,39722:188,40064:101,40065:99,40069:103,40071:107,40074:113,40075:105,40080:106,40107:102,40108:111",
	["InstanceLootHeroic.Naxxramas.Baron Rivendare"]="m,InstanceLootHeroic.Naxxramas.Four Horsemen Chest",
	["InstanceLootHeroic.Naxxramas.Four Horsemen Chest"]="40286:87,40343:84,40344:92,40345:91,40346:92,40347:78,40348:91,40349:96,40350:95,40352:90,40625:287,40626:277,40627:369",
	["InstanceLootHeroic.Naxxramas.Gluth"]="39714:13,39716:12,39717:15,39721:13,39733:12,39760:12,39761:11,39766:11,40185:13,40191:12,40193:12,40203:12,40204:12,40239:13,40242:12,40262:11,40265:11,40268:13,40271:11,40273:12,40274:14,40281:11,40289:13,40303:11,40334:12,40340:13,40346:13,40625:172,40626:189,40627:236,40634:179,40635:189,40636:242,40637:182,40638:196,40639:262",
	["InstanceLootHeroic.Naxxramas.Gothik the Harvester"]="40250:105,40251:102,40252:104,40253:111,40254:109,40255:103,40256:107,40257:106,40258:108,40328:188,40329:196,40330:189,40331:181,40332:182,40333:181,40334:193,40335:193,40336:186,40337:191,40338:190,40339:183,40340:187,40341:190,40342:195",
	["InstanceLootHeroic.Naxxramas.Grand Widow Faerlina"]="39723:230,39725:230,39726:236,39727:223,39728:186,39729:183,39730:184,39731:193,39732:185,39733:184,39734:181,39735:187,39756:194,39757:191,40064:100,40065:113,40069:99,40071:101,40074:110,40075:104,40080:109,40107:103,40108:108",
	["InstanceLootHeroic.Naxxramas.Grobbulus"]="40250:107,40251:106,40252:102,40253:107,40254:104,40255:101,40256:107,40257:99,40258:108,40274:175,40275:176,40277:177,40278:192,40279:182,40280:179,40281:191,40282:183,40283:187,40284:180,40285:185,40287:186,40288:189,40289:192,40351:184",
	["InstanceLootHeroic.Naxxramas.Heigan the Unclean"]="40201:177,40203:180,40204:181,40205:183,40206:185,40207:189,40208:183,40209:180,40210:185,40233:185,40234:183,40235:190,40236:186,40237:189,40238:185,40250:109,40251:103,40252:99,40253:104,40254:108,40255:103,40256:109,40257:102,40258:108",
	["InstanceLootHeroic.Naxxramas.Instructor Razuvious"]="40064:101,40065:106,40069:107,40071:105,40074:107,40075:109,40080:100,40107:107,40108:98,40305:177,40306:180,40315:179,40316:186,40317:183,40318:190,40319:191,40320:184,40321:180,40322:183,40323:178,40324:187,40325:181,40326:194,40327:194",
	["InstanceLootHeroic.Naxxramas.Kel'Thuzad"]="40383:173,40384:169,40385:167,40386:165,40387:168,40388:173,40395:175,40396:174,40398:172,40399:168,40400:170,40401:172,40402:174,40403:180,40405:175,40631:523,40632:556,40633:714",
	["InstanceLootHeroic.Naxxramas.Lady Blaumeux"]="m,InstanceLootHeroic.Naxxramas.Four Horsemen Chest",
	["InstanceLootHeroic.Naxxramas.Loatheb"]="40239:187,40240:182,40241:184,40242:185,40243:184,40244:188,40245:188,40246:175,40247:187,40249:192,40637:556,40638:575,40639:750",
	["InstanceLootHeroic.Naxxramas.Maexxna"]="39758:186,39759:176,39760:179,39761:169,39762:177,39763:187,39764:181,39765:178,39766:187,39767:185,39768:189,40060:181,40061:188,40062:181,40063:194,40250:110,40251:96,40252:100,40253:107,40254:107,40255:109,40256:109,40257:101,40258:110",
	["InstanceLootHeroic.Naxxramas.Noth the Plaguebringer"]="40064:99,40065:113,40069:102,40071:109,40074:108,40075:112,40080:103,40107:100,40108:102,40184:188,40185:188,40186:180,40187:183,40188:180,40189:186,40190:178,40191:189,40192:183,40193:196,40196:183,40197:188,40198:193,40200:188,40602:187",
	["InstanceLootHeroic.Naxxramas.Patchwerk"]="40064:98,40065:107,40069:103,40071:106,40074:107,40075:113,40080:103,40107:104,40108:108,40259:186,40260:183,40261:187,40262:186,40263:190,40264:186,40265:187,40266:189,40267:195,40268:181,40269:190,40270:184,40271:188,40272:193,40273:184",
	["InstanceLootHeroic.Naxxramas.Sapphiron"]="40362:168,40363:166,40365:174,40366:179,40367:179,40368:187,40369:174,40370:184,40371:170,40372:181,40373:188,40374:188,40375:188,40376:183,40377:168,40378:190,40379:185,40380:172,40381:180,40382:201,44577:902",
	["InstanceLootHeroic.Naxxramas.Sir Zeliek"]="m,InstanceLootHeroic.Naxxramas.Four Horsemen Chest",
	["InstanceLootHeroic.Naxxramas.Thaddius"]="40294:171,40296:175,40297:164,40298:176,40299:172,40300:189,40301:176,40302:160,40303:193,40304:182,40634:547,40635:565,40636:737",
	["InstanceLootHeroic.Naxxramas.Thane Korth'azz"]="m,InstanceLootHeroic.Naxxramas.Four Horsemen Chest",
	["InstanceLootHeroic.Naxxramas.Trash Mobs"]="40064,40065,40069,40071,40074,40075,40080,40107,40108,40250,40251,40252,40253,40254,40255,40256,40257,40258,40406,40407,40408,40409,40410,40412,40414",

	["InstanceLootHeroic.The Nexus Hub"]="m,InstanceLootHeroic.The Eye of Eternity,InstanceLootHeroic.The Nexus,InstanceLootHeroic.The Oculus",
-- The Eye of Eternity
	["InstanceLootHeroic.The Eye of Eternity.Alexstrasza's Gift"]="40194:83,40531:75,40532:82,40539:73,40541:80,40543:90,40549:77,40555:85,40558:64,40560:90,40561:83,40562:83,40564:85,40566:95,40588:83,40589:87,40590:86,40591:82,40592:91,40594:93,43952:11",
	["InstanceLootHeroic.The Eye of Eternity.Malygos"]="m,InstanceLootHeroic.The Eye of Eternity.Alexstrasza's Gift",
-- The Nexus
	["InstanceLootHeroic.The Nexus.Anomalus"]="37141:213,37144:219,37149:212,37150:219",
	["InstanceLootHeroic.The Nexus.Commander Stoutbeard"]="37728:197,37729:198,37730:193,37731:197",
	["InstanceLootHeroic.The Nexus.Grand Magus Telestra"]="37134:200,37135:211,37138:212,37139:211",
	["InstanceLootHeroic.The Nexus.Keristrasza"]="37162:199,37165:198,37166:195,37167:196,37169:184,37170:195,37171:189,37172:188,41794:91",
	["InstanceLootHeroic.The Nexus.Ormorok the Tree-Shaper"]="37151:221,37152:219,37153:214,37155:215",
-- The Oculus
	["InstanceLootHeroic.The Oculus.Cache of Eregos"]="37291:139,37292:148,37293:138,37294:138,37360:125,37361:135,37362:133,37363:131",
	["InstanceLootHeroic.The Oculus.Drakos the Interrogator"]="37255:228,37256:220,37257:223,37258:218",
	["InstanceLootHeroic.The Oculus.Ley-Guardian Eregos"]="m,InstanceLootHeroic.The Oculus.Cache of Eregos",
	["InstanceLootHeroic.The Oculus.Mage-Lord Urom"]="37195:189,37264:196,37288:174,37289:173",
	["InstanceLootHeroic.The Oculus.Varos Cloudstrider"]="37260:202,37261:212,37262:207,37263:204",

	["InstanceLootHeroic.The Violet Hold.Cyanigosa"]="37873:200,37874:213,37875:207,37876:213,37883:205,37884:198,37886:208,41791:79,43500:196",
	["InstanceLootHeroic.The Violet Hold.Erekem"]="43405:289,43406:286,43407:291",
	["InstanceLootHeroic.The Violet Hold.Ichoron"]="37862:282,37869:275,43401:277",
	["InstanceLootHeroic.The Violet Hold.Lavanthor"]="37870:290,37871:293,37872:290",
	["InstanceLootHeroic.The Violet Hold.Moragg"]="43408:287,43409:287,43410:286",
	["InstanceLootHeroic.The Violet Hold.Xevozz"]="37861:280,37867:285,37868:283",
	["InstanceLootHeroic.The Violet Hold.Zuramat the Obliterator"]="43402:271,43403:272,43404:273",

	["InstanceLootHeroic.The Obsidian Sanctum.Sartharion"]="40431:160,40432:205,40437:159,40438:202,40439:195,40446:158,40451:154,40453:160,40455:204,40628:498,40629:505,40630:653,43345:871,43346:909,43954:74,44000:62,44002:67,44003:76,44004:69,44005:36,44006:33,44007:34,44008:37,44011:31",

	["InstanceLootHeroic.Ulduar.Algalon the Observer"]="m,InstanceLootHeroic.Ulduar.Gift of the Observer",
	["InstanceLootHeroic.Ulduar.Assembly of Iron"]="m,InstanceLootHeroic.Ulduar.Steelbreaker,InstanceLootHeroic.Ulduar.Runemaster Molgeim,InstanceLootHeroic.Ulduar.Stormcaller Brundir,",
	["InstanceLootHeroic.Ulduar.Auriaya"]="45315:192,45319:192,45320:198,45325:192,45326:187,45327:201,45334:170,45434:197,45435:190,45436:204,45437:198,45438:194,45439:195,45440:199,45441:192",
	["InstanceLootHeroic.Ulduar.Cache of Innovation"]="45489:149,45490:166,45491:158,45492:163,45493:111,45496:2,45641:446,45642:538,45643:686",
	["InstanceLootHeroic.Ulduar.Cache of Living Stone"]="45261:164,45262:169,45263:189,45264:155,45265:159,45266:183,45267:180,45268:185,45269:163,45270:171,45271:175,45272:196,45273:172,45274:135,45275:190",
	["InstanceLootHeroic.Ulduar.Cache of Storms"]="45463:167,45466:173,45467:186,45468:165,45469:130,45470:9,45471:7,45472:11,45473:11,45474:16,45570:11,45638:506,45639:566,45640:694",
	["InstanceLootHeroic.Ulduar.Cache of Winter"]="45450:181,45451:151,45452:154,45453:167,45454:161,45632:516,45633:503,45634:692",
	["InstanceLootHeroic.Ulduar.Flame Leviathan"]="45086:177,45106:167,45107:171,45108:182,45109:175,45110:194,45111:171,45112:176,45113:189,45114:184,45115:180,45116:190,45117:188,45118:203,45119:199",
	["InstanceLootHeroic.Ulduar.Freya"]="m,InstanceLootHeroic.Ulduar.Freya's Gift",
	["InstanceLootHeroic.Ulduar.Freya's Gift"]="45479:188,45480:125,45481:154,45482:165,45483:159,45484:2,45487:3,45613:5,45653:428,45654:502,45655:676,46110:683",
	["InstanceLootHeroic.Ulduar.General Vezax"]="45145:195,45498:185,45501:179,45502:188,45503:199,45504:184,45505:186,45507:196,45508:199,45509:183,45511:180,45512:192,45513:184,45514:204,45515:212",
	["InstanceLootHeroic.Ulduar.Gift of the Observer"]="",
	["InstanceLootHeroic.Ulduar.Hodir"]="m,InstanceLootHeroic.Ulduar.Cache of Winter",
	["InstanceLootHeroic.Ulduar.Ignis the Furnace Master"]="45157:197,45158:190,45161:190,45162:180,45164:198,45165:192,45166:188,45167:181,45168:196,45169:208,45170:207,45171:205,45185:199,45186:184,45187:189",
	["InstanceLootHeroic.Ulduar.Kologarn"]="m,InstanceLootHeroic.Ulduar.Cache of Living Stone",
	["InstanceLootHeroic.Ulduar.Mimiron"]="m,InstanceLootHeroic.Ulduar.Cache of Innovation",
	["InstanceLootHeroic.Ulduar.Razorscale"]="45137:181,45138:199,45139:191,45140:191,45141:185,45142:188,45143:200,45144:193,45146:198,45147:195,45148:190,45149:209,45150:203,45151:190,45510:192",
	["InstanceLootHeroic.Ulduar.Runemaster Molgeim"]="45193:159,45224:188,45225:185,45226:192,45227:205,45228:185,45232:173,45233:192,45234:193,45235:195,45236:176,45237:219,45238:181,45239:175,45240:187,45857:937",
	["InstanceLootHeroic.Ulduar.Steelbreaker"]="45193:159,45224:138,45225:170,45226:180,45227:234,45228:127,45232:202,45233:202,45234:180,45235:191,45236:117,45237:202,45238:138,45239:191,45240:223,45241:148,45242:234,45243:106,45244:85,45245:117,45607:159,45857:914",
	["InstanceLootHeroic.Ulduar.Stormcaller Brundir"]="45193:193,45224:186,45225:184,45226:187,45227:202,45228:214,45232:193,45233:191,45234:185,45235:183,45236:192,45237:188,45238:197,45239:198,45240:203",
	["InstanceLootHeroic.Ulduar.Thorim"]="m,InstanceLootHeroic.Ulduar.Cache of Storms",
	["InstanceLootHeroic.Ulduar.XT-002 Deconstructor"]="45246:190,45247:191,45248:188,45249:178,45250:179,45251:178,45252:193,45253:195,45254:192,45255:195,45256:194,45257:198,45258:192,45259:184,45260:210",
	["InstanceLootHeroic.Ulduar.Yogg-Saron"]="45521:200,45522:200,45523:157,45524:128,45525:100,45527:85,45529:271,45530:171,45531:114,45532:171,45536:14,45537:14,45656:600,45657:514,45658:671",
	["InstanceLootHeroic.Ulduar.Trash Mobs"]="45538,45539,45540,45541,45542,45543,45544,45547,45548,45549,46138,45605",

	["InstanceLootHeroic.Ulduar Hub"]="m,InstanceLootHeroic.Halls of Lightning,InstanceLootHeroic.Halls of Stone",
-- Halls of Lightning
	["InstanceLootHeroic.Halls of Lightning.General Bjarngrim"]="37814:223,37818:223,37825:218,37826:227",
	["InstanceLootHeroic.Halls of Lightning.Ionar"]="37844:214,37845:212,37846:213,37847:211",
	["InstanceLootHeroic.Halls of Lightning.Loken"]="37848:202,37849:207,37850:202,37851:208,37852:199,37853:199,37854:198,37855:198,41799:89",
	["InstanceLootHeroic.Halls of Lightning.Volkhan"]="37840:227,37841:224,37842:220,37843:221",
-- Halls of Stone
	["InstanceLootHeroic.Halls of Stone.Krystallus"]="37650:272,37651:270,37652:278",
	["InstanceLootHeroic.Halls of Stone.Maiden of Grief"]="38615:203,38616:204,38617:217,38618:216,44731:17",
	["InstanceLootHeroic.Halls of Stone.Sjonnir The Ironshaper"]="37657:197,37658:193,37660:190,37666:192,37667:182,37668:186,37669:179,37670:183,41792:125",
	["InstanceLootHeroic.Halls of Stone.Tribunal Chest"]="37653:206,37654:204,37655:213,37656:207",

	["InstanceLootHeroic.Utgarde Keep Hub"]="m,InstanceLootHeroic.Utgarde Keep,InstanceLootHeroic.Utgarde Pinnacle",
-- Utgarde Keep
	["InstanceLootHeroic.Utgarde Keep.Dalronn the Controller"]="",
	["InstanceLootHeroic.Utgarde Keep.Ingvar the Plunderer"]="37186:197,37188:195,37189:187,37190:195,37191:193,37192:178,37193:184,37194:196,41793:83",
	["InstanceLootHeroic.Utgarde Keep.Prince Keleseth"]="37177:213,37178:219,37179:213,37180:212,44731:19",
	["InstanceLootHeroic.Utgarde Keep.Skarvald the Constructor"]="37181:207,37182:207,37183:209,37184:209",
-- Utgarde Pinnacle
	["InstanceLootHeroic.Utgarde Pinnacle.Gortok Palehoof"]="37371:212,37373:207,37374:215,37376:209",
	["InstanceLootHeroic.Utgarde Pinnacle.King Ymiron"]="37390:199,37395:193,37397:193,37398:196,37401:177,37407:192,37408:191,37409:188,41797:74",
	["InstanceLootHeroic.Utgarde Pinnacle.Skadi the Ruthless"]="37377:205,37379:211,37384:203,37389:202,44151:10",
	["InstanceLootHeroic.Utgarde Pinnacle.Svala Sorrowgrave"]="37367:217,37368:217,37369:207,37370:208",

	["InstanceLootHeroic.Vault of Archavon.Archavon the Stone Watcher"]="40415:71,40417:66,40418:63,40422:72,40423:60,40445:34,40448:33,40449:30,40454:35,40457:34,40458:29,40460:22,40462:21,40463:22,40466:21,40468:24,40469:21,40471:22,40472:23,40493:20,40495:60,40496:68,40500:63,40503:61,40504:72,40506:63,40508:21,40509:24,40512:19,40514:20,40515:23,40517:20,40520:25,40522:20,40523:22,40525:32,40527:38,40529:35,40544:31,40545:36,40547:32,40550:34,40552:34,40556:32,40559:32,40563:37,40567:32,40569:21,40570:22,40572:22,40574:20,40575:22,40577:21,40579:20,40580:24,40583:20,40784:67,40785:35,40786:64,40804:69,40805:32,40806:63,40844:66,40845:64,40846:30,40905:34,40926:35,40938:31,40990:20,40991:21,41000:20,41006:23,41026:23,41032:21,41080:23,41086:65,41136:21,41142:60,41198:20,41204:64,41286:25,41292:22,41297:21,41303:17,41309:21,41315:23,41649:63,41654:62,41660:20,41666:20,41766:66,41772:20,41858:33,41863:32,41873:32,41920:30,41926:32,41939:31,41951:62,41958:61,41970:64,41997:71,42004:64,42016:63",
	["InstanceLootHeroic.Vault of Archavon.Emalon the Storm Watcher"]="40807:58,40809:48,40847:37,40848:41,40849:25,40881:32,40882:23,40889:14,40927:55,40939:25,40976:23,40977:23,40983:35,41001:19,41051:17,41055:17,41060:12,41065:19,41137:14,41143:66,41199:17,41205:55,41225:21,41230:44,41235:25,41293:17,41298:17,41621:14,41630:16,41640:21,41655:37,41667:25,41767:57,41773:10,41832:28,41836:25,41840:37,41864:33,41874:30,41881:32,41885:25,41893:23,41898:26,41903:32,41909:19,41927:26,41940:25,41959:51,41971:46,42005:55,42017:33,42034:30,42035:30,42036:16,42039:17,42040:16,42069:12,42071:12,42074:16,42075:25,42116:23,42117:28,46113:42,46116:39,46119:67,46121:46,46124:100,46126:114,46132:101,46133:107,46135:94,46139:108,46142:96,46144:119,46148:41,46150:37,46153:35,46155:26,46158:33,46160:30,46163:44,46164:41,46169:51,46170:39,46174:23,46176:35,46179:25,46181:30,46183:41,46185:23,46188:44,46189:32,46192:37,46195:42,46199:30,46200:30,46202:37,46207:28,46208:35,46210:33",

-- Trial of the Champion
	["InstanceLootHeroic.Trial of the Champion.Grand Champions"]="m,InstanceLootHeroic.Trial of the Champion.Champion's Cache",
	["InstanceLootHeroic.Trial of the Champion.Champion's Cache"]="47243:142,47244:145,47248:143,47249:143,47250:150,47493:135",
	["InstanceLootHeroic.Trial of the Champion.Argent Confessor Paletress"]="m,InstanceLootHeroic.Trial of the Champion.Confessor's Cache",
	["InstanceLootHeroic.Trial of the Champion.Confessor's Cache"]="47498,47496,47245,47497,47514,47510,47495,47511,47494,47512,47500,47522",
	["InstanceLootHeroic.Trial of the Champion.Eadric the Pure"]="m,InstanceLootHeroic.Trial of the Champion.Eadric's Cache",
	["InstanceLootHeroic.Trial of the Champion.Eadric's Cache"]="47501,47496,47498,47504,47497,47502,47495,47503,47494,47500,47509,47508",
	["InstanceLootHeroic.Trial of the Champion.The Black Knight"]="47527:141,47529:140,47560:136,47561:138,47562:142,47563:140,47564:126,47565:125,47566:129,47567:127,47568:125,47569:123,49682:131",

-- Trial of the Crusader
	["InstanceLootHeroic.Trial of the Crusader.The Beasts of Northrend.10 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.The Beasts of Northrend.25 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Lord Jaraxxus.10 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Lord Jaraxxus.25 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Champions' Cache.10 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Champions' Cache.25 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Faction Champions.10 Man"]="m,InstanceLootHeroic.Trial of the Grand Crusader.Champions' Cache.10 Man",
	["InstanceLootHeroic.Trial of the Crusader.Faction Champions.25 Man"]="m,InstanceLootHeroic.Trial of the Grand Crusader.Champions' Cache.25 Man",
	["InstanceLootHeroic.Trial of the Crusader.The Twin Val'kyr.10 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.The Twin Val'kyr.25 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Anub'arak.10 Man"]="",
	["InstanceLootHeroic.Trial of the Crusader.Anub'arak.25 Man"]="",

-- Onyxia's Lair (Level 80)
	["InstanceLootHeroic.Onyxia's Lair.Onyxia.80"]="49491,49482,49483,49484,49481,49477,49472,49473,49471,49469,49468,49470,49480,49479,49478,49467,49466,49476,49475,49474,49492,49489,49464,49488,49490,49494,49465,49499,49495,49501,49498,49500,49496,49497,49493,49644,49485,49486,49487,49295,49294,49636",

-- Frozen Halls
	["InstanceLootHeroic.Frozen Halls Hub"]="m,InstanceLootHeroic.The Forge of Souls,InstanceLootHeroic.Pit of Saron,InstanceLootHeroic.Halls of Reflection",
-- The Forge of Souls
	["InstanceLootHeroic.The Forge of Souls.Bronjahm"]="50169:271,50191:281,50193:113,50194:109,50196:110,50197:103,50316:45,50317:243",
	["InstanceLootHeroic.The Forge of Souls.Devourer of Souls"]="50198:128,50203:309,50206:140,50207:136,50208:131,50209:133,50210:291,50211:135,50212:137,50213:144,50214:136,50215:129",
-- Pit of Saron
	["InstanceLootHeroic.Pit of Saron.Forgemaster Garfrost"]="50227:303,50228:140,50229:141,50230:138,50233:138,50234:131",
	["InstanceLootHeroic.Pit of Saron.Ick"]="50235:137,50262:302,50263:139,50264:137,50265:140,50266:142",
	["InstanceLootHeroic.Pit of Saron.Krick"]="m,InstanceLootHeroic.Pit of Saron.Ick",
	["InstanceLootHeroic.Pit of Saron.Scourgelord Tyrannus"]="50259:133,50267:270,50268:278,50269:107,50270:104,50271:107,50272:108,50273:295,50283:140,50284:134,50285:134,50286:132",
-- Halls of Reflection
	["InstanceLootHeroic.Halls of Reflection.Falric"]="50290:284,50291:252,50292:126,50293:108,50294:119,50295:106",
	["InstanceLootHeroic.Halls of Reflection.Marwyn"]="50260:137,50296:301,50297:139,50298:143,50299:140,50300:136",
	["InstanceLootHeroic.Halls of Reflection.The Lich King"]="m,InstanceLootHeroic.Halls of Reflection.The Captain's Chest",
	["InstanceLootHeroic.Halls of Reflection.The Captain's Chest"]="50302:230,50303:243,50304:95,50305:90,50306:96,50308:97,50309:139,50310:145,50311:146,50312:135,50313:141,50314:141",

-- Icecrown Citadel
-- The Lower Spire
	["InstanceLootHeroic.Icecrown Citadel.Lord Marrowgar.10 Man"]="50346,51928,51929,51930,51931,51932,51933,51934,51935,51936,51937,51938",
	["InstanceLootHeroic.Icecrown Citadel.Lord Marrowgar.25 Man"]="50604,50605:0,50606:0,50607:0,50608:0,50609:0,50610:0,50611:0,50612:0,50613:0,50614:0,50615:0,50616:0,50617:0,50709:0",
	["InstanceLootHeroic.Icecrown Citadel.Lady Deathwhisper.10 Man"]="51918,51921,51923,51925,51920,51926,51919,51924,51917,50343,51922,51927",
	["InstanceLootHeroic.Icecrown Citadel.Lady Deathwhisper.25 Man"]="50638:0,50639:0,50640:0,50641:0,50642:0,50643:0,50644:0,50645:0,50646:0,50647:0,50648:0,50649:0,50650:0,50651:0,50652:0",
	["InstanceLootHeroic.Icecrown Citadel.Gunship Armory.10 Man"]="51912,51908,51906,51911,51914,51907,51915,51913,50345,51910,51916,51909",
	["InstanceLootHeroic.Icecrown Citadel.Gunship Armory.25 Man"]="50349:0,50366:0,50653:0,50654:0,50655:0,50656:0,50657:0,50658:0,50659:0,50660:0,50661:0,50663:0,50664:0,50665:0,50667:0",
	["InstanceLootHeroic.Icecrown Citadel.Deathbringer's Cache.10 Man"]="51896,51899,51904,51897,51903,51902,51901,51895,51894,51900,52027,52026,52025,51905,51898",
	["InstanceLootHeroic.Icecrown Citadel.Deathbringer's Cache.25 Man"]="50363:0,50668:0,50670:0,50671:0,50672:0,52025:0,52026:0,52027:0,52028:0,52029:0,52030:0",
	["InstanceLootHeroic.Icecrown Citadel.Deathbringer Saurfang.10 Man"]="m,InstanceLootHeroic.Icecrown Citadel.Deathbringer's Cache.10 Man",
	["InstanceLootHeroic.Icecrown Citadel.Deathbringer Saurfang.25 Man"]="m,InstanceLootHeroic.Icecrown Citadel.Deathbringer's Cache.25 Man",
-- The Plagueworks
	["InstanceLootHeroic.Icecrown Citadel.Festergut"]="50226:0,50688:0,50689:0,50690:0,50691:0,50692:0,50693:0,50694:0,50695:0,50696:0,50697:0,50698:0,50699:0,50700:0,50701:0,50702:0,50703:0",
	["InstanceLootHeroic.Icecrown Citadel.Rotface"]="50231:0,50348:0,50673:0,50674:0,50675:0,50676:0,50677:0,50678:0,50679:0,50680:0,50681:0,50682:0,50684:0,50685:0,50686:0,50687:0",
	["InstanceLootHeroic.Icecrown Citadel.Professor Putricide"]="50704:0,50705:0,50706:0,50707:0,50708:0,52025:0,52026:0,52027:0,52028:0,52029:0,52030:0",
-- The Crimson Hall
	["InstanceLootHeroic.Icecrown Citadel.Prince Valanar"]="50172:0,50175:0,50176:0,50603:0,50710:0,50711:0,50713:0,50714:0,50717:0,50718:0,50719:0,50720:0,50721:0,50722:0,50723:0",
	["InstanceLootHeroic.Icecrown Citadel.Blood-Queen Lana'thel"]="50724:0,50725:0,50726:0,50727:0,50728:0,50729:0,52025:0,52026:0,52027:0,52028:0,52029:0,52030:0",
-- The Frostwing Halls
	["InstanceLootHeroic.Icecrown Citadel.Cache of the Dreamwalker"]="50183:0,50185:0,50186:0,50187:0,50188:0,50190:0,50192:0,50195:0,50199:0,50202:0,50205:0,50416:0,50417:0,50418:0,50472:0",
	["InstanceLootHeroic.Icecrown Citadel.Valithria Dreamwalker"]="m,InstanceLootHeroic.Icecrown Citadel.Cache of the Dreamwalker",
	["InstanceLootHeroic.Icecrown Citadel.Sindragosa"]="50364:0,50365:0,50633:0,50635:0,50636:0,52025:0,52026:0,52027:0,52028:0,52029:0,52030:0",
-- The Frozen Throne
	["InstanceLootHeroic.Icecrown Citadel.The Lich King"]="49426:0,50730:0,50731:0,50732:0,50733:0,50734:0,50735:0,50736:0,50737:0,50738:0,50818:0,52025:0,52026:0,52027:0,52028:0,52029:0,52030:0",
})
