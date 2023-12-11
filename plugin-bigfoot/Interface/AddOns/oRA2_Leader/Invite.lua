assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 644 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALInvite")
local dewdrop = AceLibrary("Dewdrop-2.0")

local guildMemberList = {}
local guildRanks = {}

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Promote all"] = true,
	["Promote all members of your raid group automatically."] = true,
	["Promote guild"] = true,
	["Promote all guild members who join your raid group automatically."] = true,
	["Invite"] = true,
	["Leader/Invite"] = true,
	["<oRA> Sorry, the group is full."] = true,
	["Inviting: "] = true,
	["Autopromoting: "] = true,
	["Keyword inviting disabled."] = true,
	["Invitation keyword set to: "] = true,
	["To turn off keyword inviting set it to 'off'."] = true,
	["<oRA> Raid disbanding on request by: "] = true,
	["Disabling Auto-Promote for: "] = true,
	["Enabling Auto-Promote for: "] = true,
	["You have no-one in your Auto-Promote list"] = true,
	["Options for inviting people to your raid."] = true,
	["Autopromote"] = true,
	["Set/Unset an autopromotion."] = true,
	["<name>"] = true,
	["Keyword"] = true,
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = true,
	["<keyword>"] = true,
	["Disband"] = true,
	["Disband the raid."] = true,
	["List"] = true,
	["List autopromotions."] = true,
	["Invite Guild"] = true,
	["Invite all characters of the specified level in the guild to raid."] = true,
	["Invite Zone"] = true,
	["Invite all characters in guild in your current zone to raid."] = true,
	["<level or empty>"] = true,
	["You are not in a guild."] = true,
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = true,
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = true,
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = true,
	["Invalid guild rank specified: %s"] = true,
	["Invite Rank"] = true,
	["Invite all guild members of the specified rank and higher to the raid."] = true,
	["<rank name>"] = true,
	["off"] = true,
} end )

L:RegisterTranslations("deDE", function() return {
	["Promote all"] = "Alle befördern",
	["Promote all members of your raid group automatically."] = "Alle Mitglieder der Schlachtgruppe automatisch befördern.",
	["Promote guild"] = "Gilde befördern",
	["Promote all guild members who join your raid group automatically."] = "Alle Gildenmitglieder, die der Schlachtgruppe beitreten automatisch befördern.",
	["Invite"] = "Einladung",
	["Leader/Invite"] = "Anführer/Einladung",
	["<oRA> Sorry, the group is full."] = "<oRA> Sorry, die Gruppe ist voll.",
	["Inviting: "] = "Einladen von: ",
	["Autopromoting: "] = "Autobeförderung: ",
	["Keyword inviting disabled."] = "Einladungen per Schlüsselwort deaktiviert.",
	["Invitation keyword set to: "] = "Einladungsschlüsselwort gesetzt auf: ",
	["To turn off keyword inviting set it to 'off'."] = "Auf 'Aus' setzen um Schlüsselwort-Einladungen zu deaktivieren",
	["<oRA> Raid disbanding on request by: "] = "<oRA> Schlachtzug wird aufgelöst auf Anforderung von: ",
	["Disabling Auto-Promote for: "] = "Autobefördung deaktiviert für: ",
	["Enabling Auto-Promote for: "] = "Autobefördung aktiviert für: ",
	["You have no-one in your Auto-Promote list"] = "Ihr habt niemanden in eurer Autobeförderungsliste",
	["Options for inviting people to your raid."] = "Optionen für Schlachtzugs Einladungen.",
	["Autopromote"] = "Autobefördung",
	["Set/Unset an autopromotion."] = "Autobefördung setzen/löschen",
	["<name>"] = "<name>",
	["Keyword"] = "Schlüsselwort",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "Einladungsschlüsselwort setzen/löschen. Andere Spieler können Dich mit diesem Schlüsselwort anflüstern um automatisch in die Gruppe eingeladen zu werden.",
	["<keyword>"] = "<schlüsselwort>",
	["Disband"] = "Auflösen",
	["Disband the raid."] = "Schlachtgruppe auflösen.",
	["List"] = "Auflisten",
	["List autopromotions."] = "Autobeförderungen auflisten.",
	["Invite Guild"] = "Gilde einladen",
	["Invite all characters of the specified level in the guild to raid."] = "Alle Gildenmitglieder mit angegebenem Level in die Schlachtgruppe einladen.",
	["Invite Zone"] = "Zone Einladen",
	["Invite all characters in guild in your current zone to raid."] = "Alle Gildenmitglieder, die in Deiner momentanten Zone sind in die Schlachtgruppe einladen.",
	["<level or empty>"] = "<level oder leer lassen>",
	["You are not in a guild."] = "Ihr seid in keiner Gilde.",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "Alle Charakter der Stufe %d oder höher werden in 10 Sekunden in die Schlachtgruppe eingeladen. Bitte die Gruppe verlassen.",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "Alle Charakter in %s werden in 10 Sekunden in die Schlachtgruppe eingeladen. Bitte die Gruppe verlassen.",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "Alle Charakter mit Rang %s oder höher werden in 10 Sekunden in die Schlachtgruppe eingeladen. Bitte die Gruppe verlassen.",
	["Invalid guild rank specified: %s"] = "Ungültiger Gildenrang: %s",
	["Invite Rank"] = "Rang einladen",
	["Invite all guild members of the specified rank and higher to the raid."] = "Alle Gildenmitglieder mit angegebenem Rang oder höher in die Schlachtgruppe einladen.",
	["<rank name>"] = "<rangname>",
	["off"] = "Aus",
} end )


L:RegisterTranslations("koKR", function() return {
	["Promote all"] = "모두 승급",
	["Promote all members of your raid group automatically."] = "공격대 그룹의 모든 멤버를 자동적으로 승급합니다.",
	["Promote guild"] = "길드 승급",
	["Promote all guild members who join your raid group automatically."] = "공격대 그룹에 참여한 모든 길드 멤버를 자동적으로 승급합니다.",
	["Invite"] = "초대",
	["Leader/Invite"] = "공격대장/초대",
	["<oRA> Sorry, the group is full."] = "<oRA> 죄송합니다. 공격대의 정원이 찼습니다.",
	["Inviting: "] = "초대: ",
	["Autopromoting: "] = "자동승급: ",
	["Keyword inviting disabled."] = "키워드 초대 기능을 사용하지 않습니다.",
	["Invitation keyword set to: "] = "초대 키워드 설정: ",
	["To turn off keyword inviting set it to 'off'."] = "키워드를 '끔'으로 설정하면 키워드 초대 기능을 사용하지 않습니다.",
	["<oRA> Raid disbanding on request by: "] = "<oRA> 공격대 해산 요청: ",
	["Disabling Auto-Promote for: "] = "자동승급 사용안함: ",
	["Enabling Auto-Promote for: "] = "자동승급 사용: ",
	["You have no-one in your Auto-Promote list"] = "자동승급 목록이 비어 있습니다.",
	["Options for inviting people to your raid."] = "초대에 대한 설정입니다.",
	["Autopromote"] = "자동승급",
	["Set/Unset an autopromotion."] = "자동승급 대상을 설정/해제 합니다.",
	["<name>"] = "<이름>",
	["Keyword"] = "키워드",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "초대 키워드를 설정/해제 합니다.",
	["<keyword>"] = "<키워드>",	
	["Disband"] = "해산",
	["Disband the raid."] = "공격대를 해산합니다.",
	["List"] = "목록",
	["List autopromotions."] = "자동승급 목록을 출력합니다.",
	["Invite Guild"] = "길드원 초대",
	["Invite all characters of the specified level in the guild to raid."] = "길드내 지정된 레벨의 길드원 모두를 공격대에 초대합니다.",
	["Invite Zone"] = "지역 초대",
	["Invite all characters in guild in your current zone to raid."] = "현재 지역 내의 모든 길드원을 공격대에 초대합니다.",
	["<level or empty>"] = "<레벨 혹은 빈칸>",
	["You are not in a guild."] = "길드에 속해 있지 않습니다.",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "10초 동안 %d 레벨 이상인 길드원들을 공격대에 초대합니다. 파티에서 나와 주세요.",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "10초 동안 %s 내의 모든 길드원을 공격대에 초대합니다. 파티에서 나와 주세요.",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "10초 동안 %s 등급 이상인 길드원들을 공격대에 초대합니다. 파티에서 나와 주세요.",
	["Invalid guild rank specified: %s"] = "지정된 길드 등급이 잘못됨: %s",
	["Invite Rank"] = "등급 초대",
	["Invite all guild members of the specified rank and higher to the raid."] = "지정된 등급 이상의 모든 길드원을 공격대에 초대합니다. ",
	["<rank name>"] = "<등급 이름>",
	["off"] = "끔",
} end )

L:RegisterTranslations("zhCN", function() return {
	["Promote all"] = "提升全部",
	["Promote all members of your raid group automatically."] = "自动提升全部队友。",
	["Promote guild"] = "提升公会",
	["Promote all guild members who join your raid group automatically."] = "自动提升团队里的公会成员。",
	["Invite"] = "邀请",
	["Leader/Invite"] = "团长/邀请",
	["<oRA> Sorry, the group is full."] = "<oRA>抱歉，团队已满。",
	["Inviting: "] = "邀请：",
	["Autopromoting: "] = "自动提升：",
	["Keyword inviting disabled."] = "禁止关键字邀请。",
	["Invitation keyword set to: "] = "邀请关键字设置为：",
	["To turn off keyword inviting set it to 'off'."] = "要关掉关键词邀请的话，选择'关'。",
	["<oRA> Raid disbanding on request by: "] = "<oRA>解散团队请求：",
	["Disabling Auto-Promote for: "] = "禁止自动提升对：",
	["Enabling Auto-Promote for: "] = "允许自动提升对：",
	["You have no-one in your Auto-Promote list"] = "你的自动提升列表为空",
	["Options for inviting people to your raid."] = "邀请助手选项。",
	["Autopromote"] = "自动提升",
	["Set/Unset an autopromotion."] = "设定/取消自动提升。",
	["<name>"] = "<名字>",
	["Keyword"] = "关键字",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "设定/取消邀请关键字。",
	["<keyword>"] = "<关键词>",	
	["Disband"] = "解散",
	["Disband the raid."] = "解散团队。",
	["List"] = "列表",
	["List autopromotions."] = "自动提升列表。",
	["Invite Guild"] = "公会邀请",
	["Invite all characters of the specified level in the guild to raid."] = "邀请公会中所有特定级别的玩家、",
	["Invite Zone"] = "区域邀请",
	["Invite all characters in guild in your current zone to raid."] = "邀请公会中所有在你目前区域中的玩家。",
	["<level or empty>"] = "<等级或留空>",
	["You are not in a guild."] = "你不在一个公会中。",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "所有%d级或更高的玩家都将在10秒后邀请到团队中。请离开你当前队伍。",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "所有在%s的玩家都将在10秒后邀请到团队中。请离开你当前队伍。",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "所有公会级别为%s或更高的玩家都将在10秒后邀请到团队中。请离开你当前队伍。",
	["Invalid guild rank specified: %s"] = "无效公会级别：%s",
	["Invite Rank"] = "公会级别",
	["Invite all guild members of the specified rank and higher to the raid."] = "邀请所有特定级别以上的公会成员。",
	["<rank name>"] = "<级别名称>",
	["off"] = "关闭",
} end )

L:RegisterTranslations("zhTW", function() return {
	["Promote all"] = "提升全部",
	["Promote all members of your raid group automatically."] = "自動提升全部隊友",
	["Promote guild"] = "提升公會",
	["Promote all guild members who join your raid group automatically."] = "自動提升團隊裡的公會成員",
	["Invite"] = "邀請",
	["Leader/Invite"] = "領隊/邀請",
	["<oRA> Sorry, the group is full."] = "<oRA> 抱歉，團隊已滿。",
	["Inviting: "] = "正在邀請: ",
	["Autopromoting: "] = "自動提升: ",
	["Keyword inviting disabled."] = "禁止關鍵字邀請",
	["Invitation keyword set to: "] = "邀請關鍵字設定為: ",
	["To turn off keyword inviting set it to 'off'."] = "要關掉關鍵詞邀請的話，選擇'關閉'",
	["<oRA> Raid disbanding on request by: "] = "<oRA> 解散團隊請求: ",
	["Disabling Auto-Promote for: "] = "禁止自動提升助理: ",
	["Enabling Auto-Promote for: "] = "允許自動提升助理: ",
	["You have no-one in your Auto-Promote list"] = "你的自動提升列表為空",
	["Options for inviting people to your raid."] = "邀請助手選項",
	["Autopromote"] = "自動提升",
	["Set/Unset an autopromotion."] = "設定/取消自動提升",
	["<name>"] = "<名字>",
	["Keyword"] = "關鍵字",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "設定/取消邀請關鍵字，大家可以對你密語關鍵字來被邀請到團隊裡。",
	["<keyword>"] = "<關鍵詞>",
	["Disband"] = "解散",
	["Disband the raid."] = "解散團隊",
	["List"] = "列表",
	["List autopromotions."] = "自動提升列表",
	["Invite Guild"] = "公會邀請",
	["Invite all characters of the specified level in the guild to raid."] = "邀請公會中所有的特定等級玩家",
	["Invite Zone"] = "區域邀請",
	["Invite all characters in guild in your current zone to raid."] = "邀請公會中所有在你目前區域中的玩家",
	["<level or empty>"] = "<等級或留空>",
	["You are not in a guild."] = "你不在一個公會中",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "所有 %d 級人物都將在 10 秒後邀請到團隊中。請離開你當前隊伍。",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "所有在 %s 的玩家都將在10秒後邀請到團隊中。請離開你當前隊伍。",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "所有公會階級為 %s 或更高的玩家都將在 10 秒後邀請到團隊中。請離開你當前隊伍。",
	["Invalid guild rank specified: %s"] = "無效的公會階級",
	["Invite Rank"] = "公會階級",
	["Invite all guild members of the specified rank and higher to the raid."] = "邀請特定階級以上的工會成員",
	["<rank name>"] = "<階級名稱>",
	["off"] = "關閉",
} end )

L:RegisterTranslations("frFR", function() return {
	["Promote all"] = "Nommer tous assistant",
	["Promote all members of your raid group automatically."] = "Nomme automatiquement assistants tous les membres de votre groupe de raid.",
	["Promote guild"] = "Nommer la guilde assistant",
	["Promote all guild members who join your raid group automatically."] = "Nomme automatiquement assistants tous les membres de votre guilde de votre groupe de raid.",
	["Invite"] = "Invitation",
	["Leader/Invite"] = "Chef/Invitation",
	["<oRA> Sorry, the group is full."] = "<oRA> Désolé, le groupe est complet.",
	["Inviting: "] = "Invitation : ",
	["Autopromoting: "] = "Promotion automatique : ",
	["Keyword inviting disabled."] = "Invitation par mot-clé désactivée.",
	["Invitation keyword set to: "] = "Mot-clé d'invitation défini à : ",
	["To turn off keyword inviting set it to 'off'."] = "Pour désactiver l'invitation par mot-clé, définissez ce dernier à 'off'.",
	["<oRA> Raid disbanding on request by: "] = "<oRA> Dissolution du raid à la demande de : ",
	["Disabling Auto-Promote for: "] = "Retrait du nommage auto. en assistant de : ",
	["Enabling Auto-Promote for: "] = "Ajout du nommage auto. en assistant de : ",
	["You have no-one in your Auto-Promote list"] = "Vous n'avez personne dans votre liste des personnes nommées automatiquement assistants.",
	["Options for inviting people to your raid."] = "Options concernant les invitations.",
	["Autopromote"] = "Assistant auto.",
	["Set/Unset an autopromotion."] = "Ajoute/enlève une personne de la liste des personnes nommées automatiquement assistants.",
	["<name>"] = "<nom>",
	["Keyword"] = "Mot-clé",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "Définit/enlève le mot-clé d'invitation. Les joueurs peuvent vous chuchoter ce mot-clé pour être invité automatiquement dans votre groupe.",
	["<keyword>"] = "<mot-clé>",
	["Disband"] = "Dissoudre",
	["Disband the raid."] = "Dissout le raid.",
	["List"] = "Liste",
	["List autopromotions."] = "Affiche la liste des personnes nommées automatiquement assistants.",
	["Invite Zone"] = "Inviter la zone",
	["Invite all characters in guild in your current zone to raid."] = "Invite tous les personnages de la guilde se trouvant dans votre zone actuelle dans le raid.",
	["Invite Guild"] = "Inviter la guilde",
	["Invite all characters of the specified level in the guild to raid."] = "Invite tous les personnages du niveau spécifié de la guilde dans le raid.",
	["<level or empty>"] = "<niveau ou laisser vide>",
	["You are not in a guild."] = "Vous n'êtes pas dans une guilde.",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "Tous les personnages de niveau %d ou supérieur seront invités dans le raid dans 10 secondes. Veuillez quitter vos groupes.",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "Tous les personnages se trouvant dans la zone %s seront invités dans le raid dans 10 secondes. Veuillez quitter vos groupes.",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "Tous les personnages du rang %s ou supérieur seront invités dans le raid dans 10 secondes. Veuillez quitter vos groupes.",
	["Invalid guild rank specified: %s"] = "Rang de guilde spécifié invalide : %s",
	["Invite Rank"] = "Inviter le rang",
	["Invite all guild members of the specified rank and higher to the raid."] = "Invite tous les membres de la guilde du rang spécifié et supérieur dans le raid.",
	["<rank name>"] = "<nom du rang>",
	--["off"] = true,
} end )
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["Promote all"] = "Повысить всех",
	["Promote all members of your raid group automatically."] = "Повысить всех игроков вашей рейд группы автоматически",
	["Promote guild"] = "Повысить согульчан",
	["Promote all guild members who join your raid group automatically."] = "Повысить всех участников гильдии вступающих в вашу рейдовую группу автоматически",
	["Invite"] = "Пригласить",
	["Leader/Invite"] = "Лидер/Пригласить",
	["<oRA> Sorry, the group is full."] = "<oRA> Извините, эта группа полна.",
	["Inviting: "] = "Приглашение: ",
	["Autopromoting: "] = "Автоповышение: ",
	["Keyword inviting disabled."] = "Приглошение по фразе отключено.",
	["Invitation keyword set to: "] = "Ключевые слова для приглашения: ",
	["To turn off keyword inviting set it to 'off'."] = "Чтобы отключить приглашение, введите 'откл'.",
	["<oRA> Raid disbanding on request by: "] = "<oRA> Отключение запросов в рейд: ",
	["Disabling Auto-Promote for: "] = "Выключить Автоповышение для: ",
	["Enabling Auto-Promote for: "] = "Включить Автоповышение для: ",
	["Autopromoting: "] = "Автоповышение: ",
	["You have no-one in your Auto-Promote list"] = "Никого нет в списке Автоповышения",
	["Options for inviting people to your raid."] = "Опции для приглашения людей в ваш рейд.",
	["Autopromote"] = "Автоповышение",
	["Set/Unset an autopromotion."] = "Выбрать/Скинуть автоповышение.",
	["<name>"] = "<имя>",
	["Keyword"] = "Ключевые слова",
	["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."] = "Набрать/Скинуть ключевое слово для автоприглашения. Люди могут вам шепнуть данное ключевое слово для приглошения в вашу группу автоматически",
	["<keyword>"] = "<Ключевое слово>",
	["Disband"] = "Распустить",
	["Disband the raid."] = "Распустить рейд.",
	["List"] = "Список",
	["List autopromotions."] = "Список автоповышения.",
	["Invite Guild"] = "Пригласить из гильдии",
	["Invite all characters of the specified level in the guild to raid."] = "Пригласить всех персонажей из гильдии по заданному уровню.",
	["Invite Zone"] = "Пригласть с Зоны",
	["Invite all characters in guild in your current zone to raid."] = "Пригласить в рейд всех персонажей из гильдии находящихся в вашей зоне.",
	["<level or empty>"] = "<уровень или пусто>",
	["You are not in a guild."] = "Вы не в гильдии.",
	["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."] = "Все уровни %d или выше будут приглашены в рейд через 10 секунд. Пожалуйста покиньте свои группы.",
	["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."] = "Все игроки в %s будут приглашены в рейд через 10 секунд. Пожалуйста покиньте свои группы.",
	["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."] = "Все игроки звания %s и выше будут приглашены в рейд через 10 секунд. Пожалуйста покиньте свои группы.",
	["Invalid guild rank specified: %s"] = "Заданно неверное звание: %s",
	["Invite Rank"] = "Пригласить по рангу",
	["Invite all guild members of the specified rank and higher to the raid."] = "Пригласить в рейд всех участников гильдии по заданному званию и выше его.",
	["<rank name>"] = "<имя ранга>",
	["off"] = "откл",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = oRA:NewModule("LeaderInvite")
mod.defaults = {
	promotes = {},
	promoteAll = nil,
	promoteGuild = nil,
	keyword = nil,
}
mod.leader = true
mod.name = L["Leader/Invite"]
mod.shouldEnable = true -- Prevents the module from disabling when out of raids.
mod.consoleCmd = "invite"

local function inviteDisabled()
	if not IsInGuild() then return true end
	if not UnitInRaid("player") and GetNumPartyMembers() > 0 and not IsPartyLeader() then
		return true
	end
end

mod.consoleOptions = {
	type = "group",
	desc = L["Options for inviting people to your raid."],
	name = L["Invite"],
	handler = mod,
	args = {
		promoteAuto = {
			name = L["Autopromote"], type = "text",
			desc = L["Set/Unset an autopromotion."],
			order = 100,
			usage = L["<name>"],
			get = false,
			set = "SetAutoPromote",
			get = false,
			validate = function(v)
				return not v:find("%s")
			end,
		},
		promoteAll = {
			name = L["Promote all"], type = "toggle",
			desc = L["Promote all members of your raid group automatically."],
			order = 101,
			get = function() return mod.db.profile.promoteAll end,
			set = function(v) mod.db.profile.promoteAll = v end,
		},
		promoteGuild = {
			name = L["Promote guild"], type = "toggle",
			desc = L["Promote all guild members who join your raid group automatically."],
			order = 102,
			get = function() return mod.db.profile.promoteGuild end,
			set = function(v) mod.db.profile.promoteGuild = v end,
		},
		promoteList = {
			name = L["List"], type = "execute",
			desc = L["List autopromotions."],
			order = 103,
			func = "ShowPromoteList",
		},
		spacer1 = {
			name = " ", type = "header",
			order = 150,
		},
		inviteGuild = {
			name = L["Invite Guild"], type = "text",
			desc = L["Invite all characters of the specified level in the guild to raid."],
			order = 200,
			usage = L["<level or empty>"],
			get = false,
			set = "InviteGuild",
			validate = function(input)
				return (input == nil or input == "") or (tonumber(input) ~= nil and (tonumber(input) > 1 and tonumber(input) <= MAX_PLAYER_LEVEL))
			end,
			disabled = inviteDisabled,
		},
		inviteRank = {
			name = L["Invite Rank"], type = "text",
			desc = L["Invite all guild members of the specified rank and higher to the raid."],
			order = 201,
			get = function() return false end,
			set = "GInviteRank",
			multiToggle = true,
			validate = guildRanks,
			disabled = inviteDisabled,
		},
		inviteZone = {
			name = L["Invite Zone"], type = "execute",
			desc = L["Invite all characters in guild in your current zone to raid."],
			order = 202,
			func = "GInviteZone",
			disabled = inviteDisabled,
		},
		spacer2 = {
			name = " ", type = "header",
			order = 250,
		},
		keyword = {
			name = L["Keyword"], type = "text",
			desc = L["Set/Unset an invitation keyword. People can whisper you this keyword to be invited to your group automatically."],
			order = 300,
			usage = L["<keyword>"],
			get = function() return mod.db.profile.keyword or "" end,
			set = "SetKeyword",
			validate = function(v)
				return not v:find("%s")
			end,
		},
		disband = {
			name = L["Disband"], type = "execute",
			desc = L["Disband the raid."],
			order = 301,
			func = "DisbandRaid",
			disabled = function() return not UnitInRaid("player") or not oRA:IsPromoted() end,
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

local peopleToInvite = {}

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_WHISPER")
	self:RegisterEvent("GUILD_ROSTER_UPDATE")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "CheckPromotes")

	self:RegisterShorthand("rakw", "SetKeyword")
	self:RegisterShorthand("rakeyword", "SetKeyword")
	self:RegisterShorthand("radisband", "DisbandRaid")
	self:RegisterShorthand("rainvite", "InviteGuild")
	self:RegisterShorthand("razinvite", "GInviteZone")
	self:RegisterShorthand("rarinvite", "GInviteRank")

	if IsInGuild() then GuildRoster() end

	self:CheckPromotes()
end

----------------------
--  Event Handlers  --
----------------------

function mod:GUILD_ROSTER_UPDATE()
	for k in pairs(guildRanks) do guildRanks[k] = nil end
	for i = 1, GuildControlGetNumRanks() do
		table.insert(guildRanks, GuildControlGetRankName(i))
	end
	for k, v in pairs(guildMemberList) do guildMemberList[k] = nil end
	local numGuildMembers = GetNumGuildMembers()
	for i = 1, numGuildMembers do
		local name = GetGuildRosterInfo(i)
		if name then
			guildMemberList[name] = true
		end
	end
end

function mod:CHAT_MSG_WHISPER(msg, author)
	if self.db.profile.keyword and msg:lower() == self.db.profile.keyword:lower() then
		local isIn, instanceType = IsInInstance()
		local party = GetNumPartyMembers()
		local raid = GetNumRaidMembers()
		if isIn and instanceType == "party" and party == 4 then
			SendChatMessage(L["<oRA> Sorry, the group is full."], "WHISPER", nil, author)
		elseif party == 4 and raid == 0 then
			ConvertToRaid()
			self:ScheduleEvent(InviteUnit, 2, author)
		else
			if raid == 40 then
				SendChatMessage(L["<oRA> Sorry, the group is full."], "WHISPER", nil, author)
			else
				InviteUnit(author)
			end
		end
	end
end

local doActualInvites

local function partyMembersChanged()
	if GetNumPartyMembers() > 0 then
		ConvertToRaid()
		mod:UnregisterEvent("PARTY_MEMBERS_CHANGED")
		mod:ScheduleEvent("DoActualInvites", doActualInvites, 2)
	end
end

function doActualInvites()
	if not UnitInRaid("player") then
		local pNum = GetNumPartyMembers()
		if pNum == 0 then
			-- This means we have to first invite up to the party size (4), and
			-- then wait for someone to join before we convert to a party and
			-- invite the rest.
			mod:RegisterEvent("PARTY_MEMBERS_CHANGED", partyMembersChanged)
			for i = 1, 4 do
				local u = table.remove(peopleToInvite)
				if u then InviteUnit(u) end
			end
			-- We've invited as many people as we can, now we need to wait
			-- for a raid group.
			return
		else
			ConvertToRaid()
			mod:ScheduleEvent("DoActualInvites", doActualInvites, 2)
			return
		end
	end
	-- Either we're in a raid, or we only want to invite enough people that
	-- we can fit in our group anyway.
	for i, v in ipairs(peopleToInvite) do
		InviteUnit(v)
	end
	for k in pairs(peopleToInvite) do
		peopleToInvite[k] = nil
	end
end

do
	local promotes = {}
	local function promote()
		mod:UnregisterEvent("RAID_ROSTER_UPDATE")
		for k in pairs(promotes) do
			PromoteToAssistant(k)
			promotes[k] = nil
		end
		mod:RegisterEvent("RAID_ROSTER_UPDATE", "CheckPromotes")
	end
	local function shouldPromote(name)
		if mod.db.profile.promoteAll then return true
		elseif mod.db.profile.promoteGuild and guildMemberList[name] then return true
		elseif mod.db.profile.promotes[name:lower()] then return true
		end
	end
	function mod:CheckPromotes()
		if not IsRaidLeader() then return end
		for i = 1, GetNumRaidMembers() do
			local n, r = GetRaidRosterInfo(i)
			if n and r == 0 and shouldPromote(n) then
				promotes[n] = true
			end
		end
		if next(promotes) then
			self:ScheduleEvent("oRALAutoPromote", promote, 4)
		end
	end
end

----------------------
-- Command Handlers --
----------------------

local function doGuildInvites(level, zone, rank)
	for i = 1, GetNumGuildMembers() do
		local name, _, rankIndex, unitLevel, _, unitZone, _, _, online = GetGuildRosterInfo(i)
		if name and online and not UnitInParty(name) and not UnitInRaid(name) then
			if level and level <= unitLevel then
				table.insert(peopleToInvite, name)
			elseif zone and zone == unitZone then
				table.insert(peopleToInvite, name)

			-- See the wowwiki docs for GetGuildRosterInfo, need to add +1 to
			-- the rank index
			elseif rank and (rankIndex + 1) <= rank then
				table.insert(peopleToInvite, name)
			end
		end
	end
	doActualInvites()
end

function mod:InviteGuild(level)
	oRA:ToggleModuleActive(self, true)

	if not level or not tonumber(level) or level == "" then level = MAX_PLAYER_LEVEL end
	level = tonumber(level)
	SendChatMessage(L["All level %d or higher characters will be invited to raid in 10 seconds. Please leave your groups."]:format(level), "GUILD")
	self:ScheduleEvent(doGuildInvites, 10, level, nil, nil)
end

function mod:GInviteZone()
	oRA:ToggleModuleActive(self, true)

	local currentZone = GetRealZoneText()
	SendChatMessage(L["All characters in %s will be invited to raid in 10 seconds. Please leave your groups."]:format(currentZone), "GUILD")
	self:ScheduleEvent(doGuildInvites, 10, nil, currentZone, nil)
end

function mod:GInviteRank(rank)
	oRA:ToggleModuleActive(self, true)

	local rankId = 0
	local rankName = nil
	local num = GuildControlGetNumRanks()
	local r = tonumber(rank)
	if r and r > 0 and r < num then
		rankId = r
		rankName = GuildControlGetRankName(r)
	else
		rank = rank:lower()
		for i = 1, num do
			local rName = GuildControlGetRankName(i)
			if rank == rName:lower() then
				rankId = i
				rankName = rName
				break
			end
		end
	end
	if rankId == 0 or not rankName then
		self:Print(L["Invalid guild rank specified: %s"]:format(rank))
		return
	end

	GuildControlSetRank(rankId)
	local _, _, ochat = GuildControlGetRankFlags()
	local channel = ochat and "OFFICER" or "GUILD"
	SendChatMessage(L["All characters of rank %s or higher will be invited to raid in 10 seconds. Please leave your groups."]:format(rankName), channel)
	self:ScheduleEvent(doGuildInvites, 10, nil, nil, rankId)
end

function mod:SetKeyword(keyword)
	if keyword == nil or keyword == "" or keyword:lower() == L["off"] then
		self.db.profile.keyword = nil
		self:Print(L["Keyword inviting disabled."])
	else
		self.db.profile.keyword = keyword
		self:Print(L["Invitation keyword set to: "] .. keyword)
		self:Print(L["To turn off keyword inviting set it to 'off'."])
	end
end

function mod:DisbandRaid()
	if not oRA:IsPromoted() then return end
	local pName = UnitName("player")
	SendChatMessage(L["<oRA> Raid disbanding on request by: "] .. pName, "RAID")
	for i = 1, GetNumRaidMembers() do
		local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
		if online and name ~= pName then
			UninviteUnit(name)
		end
	end
	oRA:SendMessage("DB")
	LeaveParty()
	dewdrop:Close()
end

function mod:SetAutoPromote(pname)
	if pname ~= nil and pname ~= "" then
		pname = pname:lower()
		if self.db.profile.promotes[pname] then
			self.db.profile.promotes[pname] = nil
			self:Print(L["Disabling Auto-Promote for: "] .. pname)
		else
			self.db.profile.promotes[pname] = 1
			self:Print(L["Enabling Auto-Promote for: "] .. pname)
			if IsRaidLeader() and UnitInRaid(pname) then
				self:Print(L["Autopromoting: "] .. pname)
				PromoteToAssistant(pname)
			end
		end
	end
end

function mod:ShowPromoteList()
	if next(self.db.profile.promotes) then
		local i = 0
		local list = ""
		self:Print(L["Autopromoting: "])
		for name, yesno in pairs(self.db.profile.promotes) do
			i = i + 1
			list = list .. name .. " "
			if i == 5 then
				self:Print(list)
				i = 0
				list = ""
			end
		end
		if list ~= "" then
			self:Print(list)
		end
	else
		self:Print(L["You have no-one in your Auto-Promote list"])
	end
end

