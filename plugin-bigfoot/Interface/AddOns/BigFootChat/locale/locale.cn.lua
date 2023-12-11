local L = LibStub("AceLocale-3.0"):NewLocale("BigFootChat", "zhCN",true)
if not L then return end
L["BFChatTitle"]="KK魔兽聊天"
L["BFChat"]="KK魔兽聊天"
L["ChatFrame"]="聊天快捷栏"
L["IconFrame"]="聊天表情栏"
L["BFChat provides you convient tools like copy text, name highlight and timestamps"]="KK魔兽聊天增强为你提供复制聊天文字，高亮姓名以及聊天时间显示等各种功能。"
L["Enable BFChat"]="使用KK魔兽聊天增强"
L["Timestamp setting"]="聊天时间设置"
L["Enable timestamp"]="显示聊天时间"
L["Enable second"]="显示具体秒数"
L["Class setting"]="职业设置"
L["Enable Class Color"]="显示职业颜色"
L["Enable Level"]="显示级别"
L["Please Do Not Talk Too Fast"]="请不要过快发言。"
L["RollDice"] = "掷骰子"
L["Report"] = "个人属性通报"
L["Raiders"] = "KK魔兽一句话攻略"
L["Show BFC keybinding"] = "设置聊天频道快捷键"

L["BigFoot Channel has been blocked"] = "停止接收KK魔兽频道信息。"
L["BigFoot Channel has been unblocked"] = "继续接收KK魔兽频道信息。"

L["Channel setting"]="频道设置"
L["Use short channel names"]="使用短频道名"
L["Enable copy text"]="复制聊天文字"
L["Enable Old style Style"] = "不保存密语回复状态"
L["Use short channel names"]="使用短频道名"
L["Enable emotion icons"]="使用聊天图标"
L["Enable channel buttons"]="使用快捷频道切换"
L["Enable roll buttons"]="显示Roll点快捷图标"
L["Enable report buttons"]="显示属性通报快捷图标"
L["Enable raiders buttons"]="启用一句话攻略"
L["Enable channel buttons move"]="移动快捷频道栏"
L["Fast chat channel provides you easy access to different channels"] = "提供快速切换至不同聊天频道的按钮，并可以自定义快捷键"
L["this function allows you to use emtion icons in your chat, and others who has this addon enabled can see your emtion icons"]="为使用者提供可在聊天中使用的表情图标，并且其他有此插件的人可以看到这些图标"
L["Press Ctrl-C to Copy the text"]="使用Ctrl+C来复制文字"

--class names
L.Mage ="法师"
L.Druid ="德鲁伊"
L.Hunter="猎人"
L.Paladin ="圣骑士"
L.Priest ="牧师"
L.Rogue ="潜行者"
L.Shaman ="萨满祭司"
L.Warlock ="术士"
L.Warrior ="战士"
L.DeathKnight="死亡骑士"

--channels
L["Guild"]="公会"
L["Raid"]="团队"
L["Party"]="小队"
L["General"]="综合"
L["Trade"]="交易"
L["WorldDefense"]="世界防务"
L["LocalDefense"]="本地防务"
L["LFGChannel"]="寻求组队"
L["BattleGround"]="战场"
L["Yell"]="喊道"
L["Say"]="说"
L["WhisperTo"]="发送给"
L["WhisperFrom"]="悄悄地说"
L["BigFootChannel"] = "KK魔兽世界频道"
L["JoinChannel1"] = "进入频道"
L["JoinChannel2"] = "加入频道"
L["LeaveChannel"] = "离开频道"
L["OwnChannel"] = "频道所有者已变更为"
L["PasswordChange"] = "密码已被"
L["ModifyChannel"] = "获得了修改权限"
L["SayTooltip"] = "普通说话"
L["PartyTooltip"] = "小队发言"
L["RaidTooltip"] = "团队发言"
L["BGTooltip"] = "战场发言"
L["GuildTooltip"] = "公会发言"
L["YellTooltip"] = "大喊"
L["WhisperTooltip"] = "密语"
L["OfficerTooltip"] = "官员频道"
L["BigFootTooltip"] = "KK魔兽世界频道"

L["GuildShort"]="公"
L["RaidShort"]="团"
L["PartyShort"]="队"
L["YellShort"]="喊"
L["BattleGroundShort"]="战"
L["OfficerShort"]="官"
L["BigFootShort"]="世"
L["WhisperToShort"]="密"
L["WhisperFromShort"]="密"

L["GeneralShort"]="综"
L["TradeShort"]="交"
L["LocalDefenseShort"]="本"
L["LFGChannelShort"]="寻"
L["WorldDefenseShort"]="世"
--- emo icons
L.Angel="天使"
L.Angry="生气"
L.Biglaugh="大笑"
L.Clap="鼓掌"
L.Cool="酷"
L.Cry="哭"
L.Cute="可爱"
L.Despise="鄙视"
L.Dreamsmile="美梦"
L.Embarras="尴尬"
L.Evil="邪恶"
L.Excited="兴奋"
L.Faint="晕"
L.Fight="打架"
L.Flu="流感"
L.Freeze="呆"
L.Frown="皱眉"
L.Greet="致敬"
L.Grimace="鬼脸"
L.Growl="龇牙"
L.Happy="开心"
L.Heart="心"
L.Horror="恐惧"
L.Ill="生病"
L.Innocent="无辜"
L.Kongfu="功夫"
L.Love="花痴"
L.Mail="邮件"
L.Makeup="化妆"
L.Mario="马里奥"
L.Meditate="沉思"
L.Miserable="可怜"
L.Okay="好"
L.Pretty="漂亮"
L.Puke="吐"
L.Shake="握手"
L.Shout="喊"
L.Silent="闭嘴"
L.Shy="害羞"
L.Sleep="睡觉"
L.Smile="微笑"
L.Suprise="吃惊"
L.Surrender="失败"
L.Sweat="流汗"
L.Tear="流泪"
L.Tears="悲剧"
L.Think="想"
L.Titter="偷笑"
L.Ugly="猥琐"
L.Victory="胜利"
L.Volunteer="雷锋"
L.Wronged="委屈"

if GetLocale()=="zhCN" then
	BINDING_HEADER_BFCTITLE="KK魔兽聊天增强"
	BINDING_NAME_BFCSAY="说话"
	BINDING_NAME_BFCPARTYCHANNEL="小队频道发言"
	BINDING_NAME_BFCRAIDCHANNEL="团队频道发言"
	BINDING_NAME_BFCBGCHANNEL="战场频道发言"
	BINDING_NAME_BFCGUILDCHANNEL="公会频道发言"
	BINDING_NAME_BFCYELL="大喊"
	BINDING_NAME_BFCWHISPER="密聊"
	BINDING_NAME_BFCOFFICER="官员频道发言"
	BINDING_NAME_BFBIGFOOTCHANNEL= "KK魔兽世界频道发言"
	BFCHANNEL_MUTE_LABEL = "屏蔽KK魔兽世界频道"
	BFCHANNEL_MUTE_DESC = "屏蔽KK魔兽世界频道，不再收到此频道的消息。"
	------个人属性通报
	StatReport_Strings_COMMA 		= "，";
	StatReport_Strings_END			= "。";
	StatReport_Strings_LV 			= "等级";
	StatReport_Strings_CLASS 		= "职业";
	StatReport_Strings_HP 			= "生命";
	StatReport_Strings_MP 			= "法力";
	StatReport_Strings_TALENT 		= "天赋";
	StatReport_Strings_STR 			= "力量";
	StatReport_Strings_AGI 			= "敏捷";
	StatReport_Strings_STA 			= "耐力";
	StatReport_Strings_INT 			= "智力";
	StatReport_Strings_SPI 			= "精神";
	StatReport_Strings_AP 			= "强度";
	StatReport_Strings_HIT 			= "命中";
	StatReport_Strings_CRIT			= "爆击";
	StatReport_Strings_EXPER		= "精准";
	StatReport_Strings_SSP			= "法伤";
	StatReport_Strings_SHP			= "治疗";
	StatReport_Strings_HASTE		= "急速";
	StatReport_Strings_SMR			= "5秒法力回复";
	StatReport_Strings_ARMOR		= "护甲";
	StatReport_Strings_DEF			= "防御";
	StatReport_Strings_DODGE		= "躲闪";
	StatReport_Strings_PARRY		= "招架";
	StatReport_Strings_BLOCK		= "格挡";
	StatReport_Strings_CRDEF		= "韧性";
	StatReport_Strings_NONE			= "无";
	StatReport_Strings_ILVL			= "装备等级";
	StatReport_Strings_MRPEN		= "护甲穿透";
	StatReport_Strings_SPEN			= "法术穿透";
	StatReport_Preview				= "个人属性通报预览:(若要发送请激活聊天框体)";
	--------------------一句话攻略-------------------------
	Raid_List = {
		["灵魂洪炉"]	= {
			{name = "布隆亚姆", raiders = "P1被点名远离BOSS，DPS集火紫色灵魂球，球吃控制；P2靠近BOSS，被恐惧进入风暴者迅速返回中心，治疗加好被恐惧者。"},
			{name = "噬魂者", raiders = "男人脸注意打断“魅影冲击”技能，红色连线出现时立即停止攻击；胖子脸远离鬼魂；女人脸躲开正面“哀嚎之魂”技能的扫射范围。"},
		},
		["萨隆矿坑"]	= {
			{name = "熔炉领主加费斯特", raiders = "BOSS“投掷萨钢”时躲开地上阴影；在萨钢石后面可以卡视角消除“极寒冰霜”DEBUFF，DEBUFF也可以驱散，切勿超过10层。"},
			{name = "依克和科瑞克", raiders = "“毒气新星”时远离BOSS；被点名“失序追击”人员头上有箭头速度远离BOSS；“爆裂弹幕”时躲开紫色爆炸范围；绿水有毒不要站。"},
			{name = "天灾领主泰兰努斯", raiders = "点名“白霜”远离人群；点名“霸主的烙纹”有红色连线，立即停止攻击；BOSS变大后伤害增加，坦克开技能或风筝BOSS在冰面。"},
		},
		["映像大厅"]	= {
			{name = "小怪", raiders = "战斗前站在墙角卡小怪视野，等坦克建立好仇恨再分散；尽量控制法师或者猎人怪单点击杀；及时驱散队友魔法和诅咒。"},
			{name = "法瑞克", raiders = "优先驱散队友DEBUFF，BOSS释放恐惧前保证队友高血量，坦克中“颤栗打击”后注意开技能保命，“颤栗打击”也可驱散。"},
			{name = "玛维恩", raiders = "所有人远离黑水；治疗加好中“苦难共享”技能的队友，但不要驱散该DEBUFF；“血肉腐化”技能期间注意自保。"},
			{name = "逃离巫妖王", raiders = "远离巫妖王，靠近冰墙进行战斗；坦克拉憎恶怪背对人群；优先击杀法系怪，注意打断其施法，及时驱散队友诅咒。"},
		},
		["冠军的试炼"]	= {
			{name = "阵营勇士", raiders = "P1，使用“冲锋”和“戳刺”配合“破盾”击杀敌人，BOSS落马起身及时踩踏；P2，躲好DZ的“毒药瓶”ZS的“旋风斩”，打断萨满治疗术，法师急速BUFF及时偷取或驱散。"},
			{name = "银色神官帕尔崔丝", raiders = "“忏悔”之后转火召唤的回忆幻象，打断或驱散”神圣之火“，偷取或驱散BOSS与回忆幻象身上的“恢复”。"},
			{name = "纯洁者耶德瑞克", raiders = "当使用“光辉”技能时背对BOSS防止致盲，BOSS使用“正义之锤”时及时驱散BOSS目标身上的“制裁之锤”。"},
			{name = "黑骑士", raiders = "驱散T的疾病，加好“缓刑”，躲好食尸鬼爆炸；P2，驱散T的疾病，跑开“亵渎”范围，躲好食尸鬼爆炸；P3，加好“死亡印记”目标，保持全队满血。"},
		},
		["乌特加德城堡"]	= {
			{name = "凯雷塞斯王子", raiders = "BOSS“召唤骷髅”出现时T拉好A掉，治疗加好中了“冰之坟墓”的人，DPS第一时间转火“冰之坟墓”，闪现、冰箱、无敌、徽章可解除。"},
			{name = "建筑师斯卡瓦尔德&控制者达尔隆", raiders = "拉好控制者召唤的小怪，建筑师施放“激怒”时注意保命，加好被“冲锋”的人血，BOSS死后会复活但无法杀死，成功击杀另外一个以后获胜。"},
			{name = "劫掠者因格瓦尔", raiders = "BOSS释放“恐怖咆哮”的时候不要施法，T拉BOSS背对人群防止“顺劈斩”和“黑暗打击”，P2阶段注意跑开暗影战斧的“旋风斩”范围。"},
		},
		["魔枢"]	= {
			{name = "阵营指挥官", raiders = "躲好BOSS的“旋风斩”，加好被“冲锋”的目标，拉离其他未引到的小怪，防止BOSS“群体恐惧”冲进怪堆。"},
			{name = "大魔导师泰蕾丝塔", raiders = "远离中“火焰炸弹”的目标，BOSS施放“重力之井”用瞬发治疗和DPS，BOSS血量66%和33%会使用“分身”，躲好冰分身的“暴风雪”，驱散奥分身“变羊术”。"},
			{name = "阿诺玛鲁斯", raiders = "BOSS血量降低到50%会“裂隙充能”并召唤“混乱裂隙”，转火“混乱裂隙”，注意加好中“奥术吸引”的目标以及全队的血。"},
			{name = "塑树者奥莫洛克", raiders = "BOSS施放“法术反射”所有法系停手，跑好“水晶尖刺”，秒掉BOSS召唤的“小花”防止被定身，BOSS血量20%会“激怒”，T开技能保命。"},
			{name = "克莉斯塔萨", raiders = "DPS不要站龙头和龙尾防止“扫尾”和“水晶喷吐”，“极度寒冷”DEBUFF会无限叠加通过跳跃和移动人物来及时解除，“冻结”后及时驱散，血量20%以下“激怒”所有人开技能保命。"},
		},
		["艾卓-尼鲁布"]	= {
			{name = "看门者克里克希尔", raiders = "3位守护者，优先击杀法系怪，BOSS战加好当前T的血，驱散“疲劳诅咒”，BOSS召唤小虫治疗尽量向T靠拢方便群拉，10%血BOSS“激怒”开技能自保。"},
			{name = "哈多诺克斯", raiders = "及时跑开“毒云”，第一时间驱散“吸血毒药”并且在DEBUFF持续期间别死人，BOSS使用“穿刺护甲”治疗注意加好T，T开技能保命。"},
			{name = "阿努巴拉克", raiders = "“虫群风暴”期间加好全队和T血，别站BOSS面前防止被“猛击”秒，BOSS每减少25%血会下地，T注意拉好精英小怪，小心地面突起的白刺，可以提前躲开。"},
		},
		["安卡赫特：古代王国"]	= {
			{name = "纳多克斯长老", raiders = "驱散“巢穴热疫”疾病，T群拉好BOSS召唤的小虫，BOSS每减少25%血量召唤“安卡哈尔守护者”，迅速转火守护者，治疗自己保命。"},
			{name = "塔达拉姆王子", raiders = "召唤“火焰之球”所有人尽量站分散减少治疗压力，BOSS每减少25%血量会对某一玩家使用“吸血鬼拥抱”，无法治疗但可以套盾，所有人打BOSS4W血以后停止。"},
			{name = "埃曼尼塔(英雄模式)", raiders = "T靠墙拉BOSS以防被击飞，注意解毒、解魔法，BOSS施放“迷你”所有人靠近健康的蘑菇并打掉以解DEBUFF，所有人禁止释放AOE技能。"},
			{name = "耶戈达·觅影者", raiders = "近战注意躲避“飓风打击”，迅速跑开“雷霆震击”范围，BOSS每减少25%血量会升空召唤“暮光志愿者”，转火志愿者，若没杀掉T注意开技能。"},
			{name = "传令官沃拉兹", raiders = "加好“暗影箭雨”造成的伤害，BOSS每减少33%血会使用“疯狂”，所有人优先击杀治疗者化身，输出低的注意保命等别人帮杀，打断职业注意打断鞭笞。"},
		},
		["达克萨隆要塞"]	= {
			{name = "托尔戈", raiders = "分散站位，小怪死了T把BOSS拉开以防尸爆，注意及时驱散“感染之伤”。"},
			{name = "召唤者诺沃斯", raiders = "迅速清理小怪，优先击杀法系怪，解除“痛苦之怒”诅咒效果，及时躲开“暴风雪”范围。打断寒冰箭，治疗注意团血。"},
			{name = "暴龙之王爵德", raiders = "尽量驱散“低吼咆哮”，T中了“穿刺猛击”注意开技能保命，治疗给中“悲惨撕咬”的人抬满血，BOSS召唤小龙T注意拉住不让小龙打治疗，看见提示“爵德阴险的举起爪子”时T注意保命。"},
			{name = "先知萨隆亚", raiders = "驱散“生命诅咒”效果，及时躲开“毒云”，骷髅阶段T用“嘲讽”+“白骨护盾”技能(2、3技能)，其他人用“杀戮打击”+“生命之触”技能(1、4技能)输出。"},
		},
	}
end

