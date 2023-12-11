if GetLocale()~='zhCN' then return end
local main= "3.3.0."
local minor = "266"
BIGFOOT_VERSION = "zhCN"..main..minor;

function GetMinorVersion()
	return minor
end

BigFootChangelog_ah();

	BigFootChangelog_at("2023/11/19 (3.3.0.266)")
	BigFootChangelog_ar("属性统计","修正穿透统计不正确的问题。")
	BigFootChangelog_ar("首领报警","修正红玉圣殿一个不报警问题。")
	BigFootChangelog_ar("法术计时","修正多个法术计时不正确显示的问题。")


	BigFootChangelog_at("2023/10/10 (3.3.0.265)")
	BigFootChangelog_ar("KK魔兽基本库","修正某些模块显示不正确的问题。")
	BigFootChangelog_ar("首领报警","更新至新版本，提供红玉圣殿的模块。")
	BigFootChangelog_ar("法术计时","修正某些法术移除不正确的问题。")
	BigFootChangelog_ar("团队警报","更新至新版本。")


	BigFootChangelog_at("2023/08/28 (3.3.0.264)")
	BigFootChangelog_ar("法术触发","添加法术书显示法术ID功能。")
	BigFootChangelog_ar("团队警报","更新至新版本，感谢论坛网友Shines提供帮助。")
	BigFootChangelog_ar("一句话攻略","增加了部分五人副本攻略。")


	BigFootChangelog_at("2023/07/21 (3.3.0.263)")
	BigFootChangelog_ar("聊天增强","增加设置快捷键的界面。")
	BigFootChangelog_ar("装备属性","修正为显示装备对人物直接加成的属性值。")


	BigFootChangelog_at("2023/04/13 (3.3.0.262)")
	BigFootChangelog_ar("职业助手","修正猎人不能自动取消豹守的问题。")
	BigFootChangelog_ar("职业助手","当猎人学习龙鹰守护以后会自动去掉灵猴和雄鹰守护。")
	BigFootChangelog_ar("KK魔兽基本库","修正子选项不能正常禁用的问题。")
	BigFootChangelog_ar("数据通告","调整部分通告数据。")


	BigFootChangelog_at("2022/04/08 (3.3.0.261)")
	BigFootChangelog_ar("职业助手","修复死亡骑士符文条与单体插件的冲突问题。")


	BigFootChangelog_at("2022/04/07 (3.3.0.260)")
	BigFootChangelog_ar("职业助手","修复死亡骑士符文条可能超出界面的问题，修正若干位置偏移的问题。")


	BigFootChangelog_at("2022/04/06 (3.3.0.259)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端版本升级至2.022。采用全新的界面，增加若干贴近玩家的客户端功能。")
	BigFootChangelog_ar("职业助手","优化死亡骑士符文条。")
	BigFootChangelog_ar("一句话攻略","新增一句话攻略功能，可为玩家提示简易的boss打法（目前仅支持新三本）。")
	BigFootChangelog_ar("任务通告","修正一个导致某些任务报错的问题。")


	BigFootChangelog_at("2022/03/28 (3.3.0.258)")
	BigFootChangelog_ar("KK魔兽基本库","增加搜索功能，修正小地图面板与单体插件冲突的问题。")
	BigFootChangelog_ar("KK魔兽基本库","修正部分服务器无法绑定角色的问题。")
	BigFootChangelog_ar("团队警报","更新至新版本。")
	BigFootChangelog_ar("数据通告","聊天增强功能新增玩家数据通告模块，点击数据通告快捷按钮可以在聊天框中显示玩家天赋及主要属性。")


	BigFootChangelog_at("2022/03/22 (3.3.0.257)")
	BigFootChangelog_ar("KK魔兽基本库","修正双采功能失效的问题。")
	BigFootChangelog_ar("战斗指示","修正战斗指示不显示的问题。")
	BigFootChangelog_ar("KK魔兽测试客户端","修正后台刷新时无法使用鼠标滚轮的问题。优化看帖速度。")


	BigFootChangelog_at("2021/03/21 (3.3.0.256)")
	BigFootChangelog_ar("KK魔兽基本库","新增小地图快捷面板。")
	BigFootChangelog_ar("法术触发","修正部分图标显示不正确的问题；牧师“好运”技能3层才显示提示。")


	BigFootChangelog_at("2021/03/11 (3.3.0.255)")
	BigFootChangelog_ar("法术触发","修正若干法术提示不显示的问题，修正与其他插件的冲突问题。")


	BigFootChangelog_at("2021/03/10 (3.3.0.254)")
	BigFootChangelog_ar("KK魔兽基本库","优化与修正基本模块。")
	BigFootChangelog_ar("法术触发","更新至新版本，增加自定义法术与(DE)BUFF监视功能，修正某些提示不消失的问题。")
	BigFootChangelog_ar("KK魔兽聊天","优化KK魔兽频道；聊天工具条新增roll点功能。")
	BigFootChangelog_ar("法术冷却","优化锁定功能。")


	BigFootChangelog_at("2021/03/03 (3.3.0.253)")
	BigFootChangelog_ar("法术计时","修正部分法术不正确计时的问题，修改框体移动方式。")
	BigFootChangelog_ar("KK魔兽聊天","优化聊天部分设置，聊天图标可以在所有聊天类型中显示。")
	BigFootChangelog_ar("伤害统计","增加盾吸收与治疗量总和统计模块。")
	BigFootChangelog_ar("坐骑增强","修正首次进游戏时可能出现的坐骑错位现象。")
	BigFootChangelog_ar("首领报警","修正重要技能报警模块。")


	BigFootChangelog_at("2021/02/23 (3.3.0.252)")
	BigFootChangelog_ar("法术触发","修正开启声音提示可能出现的卡死问题。")
	BigFootChangelog_ar("增益大师","重新增加精确显示时间秒数，默认为关闭。如有需要，请在设置里“增益法术”模块勾选相关选项。")


	BigFootChangelog_at("2020/02/22 (3.3.0.251)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端开放2.0测试，目前伊利丹以及阿迦玛甘服务器的KK魔兽玩家会收到测试邀请。")
	BigFootChangelog_ar("KK魔兽聊天增强","KK魔兽频道密码更改BUG修正。")
	BigFootChangelog_ar("法术触发","试图修正触发法术图标卡死的问题。")
	BigFootChangelog_ar("法术计时","修正某些法术时间不正确的问题。")


	BigFootChangelog_at("2020/02/18 (3.3.0.250)")
	BigFootChangelog_ar("KK魔兽聊天增强","增加防刷屏的处理。")
	BigFootChangelog_ar("增益大师","修正一个导致增益时间不显示的问题。")


	BigFootChangelog_at("2020/02/17 (3.3.0.249)")
	BigFootChangelog_ar("KK魔兽客户端","客户端版本升级至1.157，修复用户设置向导界面的错误。")
	BigFootChangelog_ar("KK魔兽基本库","升级和清理多余的基本库文件。")
	BigFootChangelog_ar("KK魔兽聊天增强","增加KK魔兽世界频道，为用户提供专用世界聊天频道。")
	BigFootChangelog_ar("萨满助手","添加计时图腾开关。")
	BigFootChangelog_ar("首领报警","升级至最新版本。")
	BigFootChangelog_ar("法术触发","修复某些触发法术图标不消失的问题。")
	BigFootChangelog_ar("KK魔兽头像","修复设置焦点时会同时出现系统焦点框体的问题。")
	BigFootChangelog_ar("竞技场助手","升级至最新版本。")
	BigFootChangelog_ar("增益大师","优化部分代码。")
	BigFootChangelog_ar("技能计时器","修复某些法术无法显示的问题。")


	BigFootChangelog_at("2020/01/30 (3.3.0.248)")
	BigFootChangelog_ar("插件界面","汉化人物选择界面插件管理列表。")
	BigFootChangelog_ar("一键换装","修正非正常下线引起登录时报错的问题。")
	BigFootChangelog_ar("金币统计","修正初始化窗体大小。")
	BigFootChangelog_ar("小队职业","调整小队头像职业图标位置。")
	BigFootChangelog_ar("法术触发","修正某些触发法术图标不消失的问题。")
	BigFootChangelog_ar("伤害统计","升级至最新版本。")
	BigFootChangelog_ar("首领报警","升级至最新版本。")


	BigFootChangelog_at("2019/01/24 (3.3.0.247)")
	BigFootChangelog_ar("坐骑增强","修正新增坐骑导致的召唤错误问题，修正显示图标。")
	BigFootChangelog_ar("团队框架","修正团队框架法力条显示不正确的问题。")
	BigFootChangelog_ar("法术触发","修正某些触发不提示的问题。")
	BigFootChangelog_ar("法术计时","修正某些法术的错误提示问题。")


	BigFootChangelog_at("2019/01/21 (3.3.0.246)")
	BigFootChangelog_ar("KK魔兽动作条","修正不能保存设置的问题。")
	BigFootChangelog_ar("聊天增强","修正密语回复状态的一个问题。")
	BigFootChangelog_ar("首领报警","修正首领报警无法关闭的问题。")
	BigFootChangelog_ar("团队框架","升级至3.3兼容版，增加ICC的减益模块。")
	BigFootChangelog_ar("玩家链接","增加好友备注的链接。")


	BigFootChangelog_at("2019/01/20 (3.3.0.245)")
	BigFootChangelog_ar("KK魔兽基本库","修正多处导致KK魔兽动作条和饰品管理错误的问题。")
	BigFootChangelog_ar("界面调整","界面调整兼容3.3。")
	BigFootChangelog_ar("萨满助手","使用新的萨满助手插件。")
	BigFootChangelog_ar("玩家链接","增加移除好友的链接。")
	BigFootChangelog_ar("装备比较","升级至3.3兼容版本。")
	BigFootChangelog_ar("法术计时","修正某些施法时的报错。")
	BigFootChangelog_ar("首领报警","升级至3.3兼容版本，增加新五人副本与ICC首领报警模块，感谢WOWUI提供的帮助。")


	BigFootChangelog_at("2019/01/19 (3.3.0.244)")
	BigFootChangelog_ar("KK魔兽客户端","客户端版本升级至1.156。针对国服3.3.5进行修正。当发现客户端中dll文件不正确，能够进行修复。")
	BigFootChangelog_ar("KK魔兽基本库","各项功均升级至3.3兼容。")
	BigFootChangelog_ar("地图专家","升级至3.3兼容版本。")
	BigFootChangelog_ar("任务信息","修改优化至与3.3任务系统兼容并可平滑切换。")
	BigFootChangelog_ar("聊天增强","添加不保存密语回复状态的选项。")
	BigFootChangelog_ar("团队框体","增加团队框体快捷点击模块。")
	BigFootChangelog_ar("法术计时","修正萨满的部分法术。")
	BigFootChangelog_ar("副本地图","从国服移除旧大陆副本地图。")
	BigFootChangelog_ar("任务助手","从国服移除。")


	BigFootChangelog_at("2019/01/12 (3.2.0.243)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端版本升级至1.155。强化安全防范机制，帮助玩家检查游戏环境的安全。")
	BigFootChangelog_ar("金团助手","新增金团助手插件，为玩家提供便捷的收入统计。")


	BigFootChangelog_at("2019/12/29 (3.2.0.242)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端版本升级至1.154。台服玩家将自动升级至台服版魔兽KK魔兽。")
	BigFootChangelog_ar("一键换装","修正切换人物角色导致的报错。")


	BigFootChangelog_at("2018/12/23 (3.2.0.241)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端版本升级至1.153。修正上个版本无法选择登陆魔兽客户端版本的BUG。")
	BigFootChangelog_ar("一键换装","修正保存退出设置，优化换装音效以及脱装备次序。")


	BigFootChangelog_at("2018/12/23 (3.2.0.240)")
	BigFootChangelog_ar("KK魔兽客户端","KK魔兽客户端版本升级至1.152。修正若干可能导致崩溃的问题。")
	BigFootChangelog_ar("任务信息","可以自动显示追踪的任务目标。")
	BigFootChangelog_ar("KK魔兽基本库","修改保存框体位置的设置。")
	BigFootChangelog_ar("目标增强","目标施法条位置调整。")
	BigFootChangelog_ar("邮件助手","增加移除联系人的确认。")


	BigFootChangelog_at("2018/12/16 (3.2.0.239)")
	BigFootChangelog_ar("小队增强","修正小队目标和小队信息条上下载具的问题。")
	BigFootChangelog_ar("小队增强","修正信息条的生命值和魔法值显示延迟的问题。")
	BigFootChangelog_ar("目标头像","调整和系统默认的目标的目标头像冲突的问题。")
	BigFootChangelog_ar("目标增强","修正修改增益尺寸造成的施法条错位问题。")
	BigFootChangelog_ar("目标增强","为百分比显示增添一个框体。")
	BigFootChangelog_ar("聊天增强","调整聊天框的默认位置。")
	BigFootChangelog_ar("邮件助手","增加快速添加联系人的按钮。")


	BigFootChangelog_at("2018/12/10 (3.2.0.238)")
	BigFootChangelog_ar("目标增强","修正目标增强造成的施法条下移的问题。")


	BigFootChangelog_at("2018/12/9 (3.2.0.237)")
	BigFootChangelog_ar("头像增强","使用新的头像增强插件，新增小队施法条以及小队目标。")
	BigFootChangelog_ar("目标增强","增加目标血量格式，调整血量百分比位置。")
	BigFootChangelog_ar("增益法术","解决一个造成系统污染的问题。")
	BigFootChangelog_ar("任务查询","银白日常数据修正以及补全。")


	BigFootChangelog_at("2018/12/3 (3.2.0.236)")
	BigFootChangelog_ar("团队标记助手","新增团队框体模块，提供团队标记的显示。")
	BigFootChangelog_ar("姿态条增强","法师可使用快捷键，调整猎人技能次序。")
	BigFootChangelog_ar("鼠标提示","修正一个可能导致观察时报错的问题。")
	BigFootChangelog_ar("冷却计时","调整目标增益和冷却计时的选项，修正某些技能不能计时的问题。")


	BigFootChangelog_at("2018/11/25 (3.2.0.235)")
	BigFootChangelog_ar("姿态条增强","调整位置至右边，修改法师和术士的法术列表，调整盗贼毒药次序。")
	BigFootChangelog_ar("符文条增强","上下载具时隐藏锚点。")


	BigFootChangelog_at("2018/11/24 (3.2.0.234)")
	BigFootChangelog_ar("法术触发","增加德鲁伊触发技能。")
	BigFootChangelog_ar("副本掉落","更新版本并添加物品出处查询。")
	BigFootChangelog_ar("头像增强","调整宠物条大小和德鲁伊的魔法条位置。")
	BigFootChangelog_ar("符文条增强","为死亡骑士制作符文增强条。")
	BigFootChangelog_ar("姿态条增强","为法师，猎人，术士以及盗贼制作的专用的物品和技能条。")
	BigFootChangelog_ar("一键换装","应用户要求，调整保存等细节。")


	BigFootChangelog_at("2018/11/18 (3.2.0.233)")
	BigFootChangelog_ar("一键换装","修正由于关闭系统换装而产生的问题。")


	BigFootChangelog_at("2018/11/17 (3.2.0.232)")
	BigFootChangelog_ar("任务查询","添加银白日常数据。")
	BigFootChangelog_ar("头像增强","修正德鲁伊变形时的经验条位置。")
	BigFootChangelog_ar("一键换装","一键换装换用系统自带的套装。")


	BigFootChangelog_at("2018/11/10 (3.2.0.231)")
	BigFootChangelog_ar("战斗指示","更新至新版本,支持3.2")
	BigFootChangelog_ar("法术指示","切天赋时不再显示新学法术。")
	BigFootChangelog_ar("焦点增强","现在可以用鼠标选定焦点目标为目标。")
	BigFootChangelog_ar("界面调整","处理界面调整导致的任务追踪问题，切换姿态主动作条失效问题。")
	BigFootChangelog_ar("NPC标记","增加和修正多处不正确和缺失的NPC位置。")
	BigFootChangelog_ar("团队记录","更新至3.1.8，修正十字军双子不记录的问题。")


	BigFootChangelog_at("2018/11/02 (3.2.0.230)")
	BigFootChangelog_ar("任务提示","增加任务进度提示。")
	BigFootChangelog_ar("组队工具","增加团队以及队伍进组提示。")
	BigFootChangelog_ar("猎人助手","增加所需基本库函数。")
	BigFootChangelog_ar("冷却助手","修正使用物品可能产生的报错。")


	BigFootChangelog_at("2018/10/29 (3.2.0.229)")
	BigFootChangelog_ar("猎人助手","去掉多余的逻辑，修正帧数降低的问题以及与载具有可能的冲突。")
	BigFootChangelog_ar("伤害统计","伤害统计更新至新版本，增加盾吸收等模块。")


	BigFootChangelog_at("2017/10/22 (3.2.0.228)")
	BigFootChangelog_ar("团队记录","更新至3.1.7，优化对单体插件的支持。")
	BigFootChangelog_ar("伤害统计","伤害统计更新至新版本，加入盾吸收等模块。")


	BigFootChangelog_at("2017/10/21 (3.2.0.227)")
	BigFootChangelog_ar("猎人助手","修正距离助手显示不正确的错误，守护条恢复到之前版本，在台服关闭。")
	BigFootChangelog_ar("数据收集","修正由于基本库迁移造成的收集报错。")


	BigFootChangelog_at("2017/10/20 (3.2.0.226)")
	BigFootChangelog_ar("KK魔兽基本库","修正4.0下的错误汇报机制，修正两个与任务相关的错误。")
	BigFootChangelog_ar("猎人助手","修正距离助手可能造成的帧数降低。")


	BigFootChangelog_at("2017/10/19 (3.2.0.225)")
	BigFootChangelog_ar("KK魔兽基本库","针对4.0对基本库做出调整，修复延时机制。")
	BigFootChangelog_ar("猎人助手","修正距离助手不生效的问题。")


	BigFootChangelog_at("2017/10/13 (3.2.0.224)")
	BigFootChangelog_ar("一键驱散","修正2.4.5无法正常使用的问题。")
	BigFootChangelog_ar("自动换装","修正了一个由于基本库变化引起的错误。")
	BigFootChangelog_ar("交易助手","修正不能翻页购买的错误。")


	BigFootChangelog_at("2017/10/12 (3.2.0.223)")
	BigFootChangelog_ar("KK魔兽基本库","调整部分文件位置，删除无用文件。")
	BigFootChangelog_ar("一键驱散","更新至3.2最新版(2.4.5)。")
	BigFootChangelog_ar("交易助手","合并了自动售卖和材料补充的功能，优化了界面。")
	BigFootChangelog_ar("副本掉落","修正了十字军部分首领掉落不显示的问题。")
	BigFootChangelog_ar("首领报警","更新至新版本，修正十字军部分首领不提示的问题。")
	BigFootChangelog_ar("团队记录","MiDKP增加了十字军试炼部分不记录的首领。")


	BigFootChangelog_at("2016/9/26 (3.2.0.222)")
	BigFootChangelog_ar("KK魔兽基本库","解决了小队头像以及动作条不正确的问题。")
	BigFootChangelog_ar("伤害统计","复原了打断，复活等数据统计。")
	BigFootChangelog_ar("聊天增强","使用系统职业颜色显示功能，减轻服务器负担。")
	BigFootChangelog_ar("KK魔兽坐骑","增加对冬握湖的处理，修正新学坐骑引发的坐骑错位问题。")
	BigFootChangelog_ar("焦点增强","焦点头像上Alt+右键改为清除焦点。")
	BigFootChangelog_ar("团队记录","MiDKP增加了奥杜尔部分不记录的首领。")


	BigFootChangelog_at("2016/9/20 (3.2.0.221)")
	BigFootChangelog_ar("KK魔兽客户端","版本升级至1.151。为了防止部分用户无法进行更新，启动改为需要管理员权限。")
	BigFootChangelog_ar("头像增强","修正了头像显示以及血量显示与载具的冲突。")
	BigFootChangelog_ar("KK魔兽基本库","添加基本库验证模块并去掉未被引用的基本库。")
	BigFootChangelog_ar("鼠标提示","修正有时查看角色报错的问题。")


	BigFootChangelog_at("2016/9/16 (3.2.0.220)")
	BigFootChangelog_ar("KK魔兽基本库","优化基本库装载次序。")
	BigFootChangelog_ar("团队记录","内核优化，修正忽略物品不能保存的问题，记录增加奥杜尔首领。")
	BigFootChangelog_ar("团队报警","打开团队报警时配置框可以正确显示。")
	BigFootChangelog_ar("NPC位置","默认的NPC显示现在会根据玩家角色调整。")


	BigFootChangelog_at("2016/9/15 (3.2.0.219)")
	BigFootChangelog_ar("KK魔兽客户端","版本升级至1.150，修正台服版本单体插件无法安装的问题，调整设置参数。")
	BigFootChangelog_ar("KK魔兽基本库","升级和清理多余的基本库文件。")
	BigFootChangelog_ar("战斗指示","修正某些开关失效的问题。")
	BigFootChangelog_ar("团队框架","修正诺森德副本减益模块不能正确装载的问题。")
	BigFootChangelog_ar("背包管理","优化了背包的显示效果。")


	BigFootChangelog_at("2016/9/14 (3.2.0.218)")
	BigFootChangelog_ar("KK魔兽基本库","调整队友头像显示。")
	BigFootChangelog_ar("KK魔兽基本库","清理多余的配置文件。")
	BigFootChangelog_ar("团队记录","MiDKP添加了对WLK首领的支持。")
	BigFootChangelog_ar("副本掉落","增加了奥妮克希亚的掉落。")
	BigFootChangelog_ar("伤害统计","更新伤害统计(recount)至国服最新版。")
	BigFootChangelog_ar("团队框体","更新团队框体(Grid)至国服最新版。")
	BigFootChangelog_ar("一键换装","优化一键换装设置,以及对宝石附魔的支持。")
	BigFootChangelog_ar("装备比较","调整装备比较的配色方案，使其更易辨别。")
	BigFootChangelog_ar("战斗指示","为技能预警功能添加开关。")
	BigFootChangelog_ar("法术助手","新学法术栏位添加至7个。")


	BigFootChangelog_at("2016/9/13 (3.2.0.217)")
	BigFootChangelog_ar("小地图按键","修正启动时的报错,以及对随机副本的支持。")
	BigFootChangelog_ar("KK魔兽基本库","试图修正战斗时不更新队友头像的问题。")


	BigFootChangelog_at("2016/9/10 (3.2.0.216)")
	BigFootChangelog_ar("小地图按键","修正对某些单体插件按钮的集成问题。")
	BigFootChangelog_ar("KK魔兽基本库","恢复在面板点选团队人员的功能。")
	BigFootChangelog_ar("法术计时","加入萨满的技能计时。")
	BigFootChangelog_ar("战斗指示","恢复战斗指示内 施法警告,盗贼点数等功能。")
	BigFootChangelog_ar("副本掉落","增加诺森德副本的掉落。")


	BigFootChangelog_at("2016/9/9 (3.2.0.215)")
	BigFootChangelog_ar("小地图按键","修正战场按钮不显示的问题,去掉某些按钮的默认集成。")
	BigFootChangelog_ar("法术计时","修正死亡骑士和牧师部分法术无法显示的问题。")
	BigFootChangelog_ar("战斗指示","修复战斗指示无法正常工作的问题。")


	BigFootChangelog_at("2016/9/8 (3.2.0.214)")
	BigFootChangelog_ar("团队报警","更新到最新语音版团队报警插件(DBM),兼容国服3.2。")
	BigFootChangelog_ar("一键换装","修正了更改附魔和宝石不能保存的问题。")
	BigFootChangelog_ar("KK魔兽基本库","为大部分选项提供了完整的鼠标提示说明。")
	BigFootChangelog_ar("KK魔兽基本库","去掉组队时的版本提示信息。")
	BigFootChangelog_ar("任务增强","追踪的任务会自动在地图上显示和更新。")
	BigFootChangelog_ar("任务增强","修正有的用户会重复载入的问题。")
	BigFootChangelog_ar("任务增强","提供了显示任务等级的选项。")
	BigFootChangelog_ar("小地图按键包","优化了菜单显示,解决某些按钮设置不正确的问题。")


	BigFootChangelog_at("2016/9/7 (3.2.0.213)")
	BigFootChangelog_ar("KK魔兽基本库","修复外服客户端不能保存设置的问题。")
	BigFootChangelog_ar("KK魔兽基本库","修正了猎人宝宝会消失的问题和字体显示不正确的问题。")
	BigFootChangelog_ar("KK魔兽基本库","试图修正载具卡死问题。")
	BigFootChangelog_ar("鼠标提示","增加了对任务怪和任务物品的提示。")
	BigFootChangelog_ar("任务增强","目前进行任务会在地图上指示。")
	BigFootChangelog_ar("任务增强","去掉台服多余的任务增强。")
	BigFootChangelog_ar("任务增强","修复重复提示重置插件的问题。")
	BigFootChangelog_ar("头像增强","修复设置焦点目标报错的问题。")


BigFootChangelog_af();


BF_VERSION_CHECKSUM = "51"