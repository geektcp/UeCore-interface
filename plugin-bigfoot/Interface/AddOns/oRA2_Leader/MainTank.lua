assert(oRA, "oRA not found!")
local revision = tonumber(("$Revision: 633 $"):match("%d+"))
if oRA.version < revision then oRA.version = revision end

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRALMainTank")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["MainTank"] = true,
	["Options for the maintanks."] = true,
	["Set"] = true,
	["Set a maintank."]= true,
	["<nr> <name>"] = true,
	["<nr>"] = true,
	["<name>"] = true,
	["Remove"] = true,
	["Remove a maintank."] = true,
	["Removed maintank: "] = true,
	["Set maintank: "] = true,
	["Leader/MainTank"] = true,
	["Broadcast"] = true,
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = true,

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear main tank targets."] = true,
	["Press |cffffffff%s|r to set the next main tank or |cffffffff%s|r to clear the last tank set."] = true,
	["<no binding>"] = true,

	["(%S+)%s*(.*)"] = true,

	["Set target on a free mt-slot"] = true,
	["Free"] = true,
	["All"] = true,
	["Delete all Maintanks"] = true,
	["<Not Assigned>"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["MainTank"] = "메인탱커",
	["Options for the maintanks."] = "메인탱커에 대한 설정입니다.",
	["Set"] = "메인탱커 지정",
	["Set a maintank."]= "메인탱커로 지정합니다.",
	["<nr> <name>"] = "<번호> <이름>",
	["<nr>"] = "<번호>",
	["<name>"] = "<이름>",
	["Remove"] = "메인탱커 삭제",
	["Remove a maintank."] = "메인탱커에서 삭제합니다.",
	["Removed maintank: "] = "메인탱커 삭제: ",
	["Set maintank: "] = "메인탱커 지정: ",
	["Leader/MainTank"] = "공격대장/메인탱커",
	["Broadcast"] = "메인탱커 알림",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "메인탱커를 공격대에 알립니다.",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear main tank targets."] = "|cffffffff블리자드 단축키 설정창|r을 열어 플레이어 타켓을 지우거나 단축키 지정등을 설정 하세요.",
	["Press |cffffffff%s|r to set the next main tank or |cffffffff%s|r to clear the last tank set."] = "|cffffffff%s|r 누르면 다음 메인 탱커 지정 , |cffffffff%s|r 누르면 마지막 탱커를 지웁니다.",
	["<no binding>"] = "<단축키 없음>",
	
	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["Set target on a free mt-slot"] = "대상을 공란에 지정합니다.",
	["Free"] = "공란",
	["All"] = "모두",
	["Delete all Maintanks"] = "모든 메인탱커를 삭제합니다.",
	["<Not Assigned>"] = "<지정되지 않음>",
} end)

L:RegisterTranslations("zhCN", function() return {
	["MainTank"] = "MT",
	["Options for the maintanks."] = "MT 选项。",
	["Set"] = "设定 MT",
	["Set a maintank."]= "设定 MT。",
	["<nr> <name>"] = "<数量> <名字>",
	["<nr>"] = "<数量>",
	["<name>"] = "<名字>",
	["Remove"] = "移除 MT",
	["Remove a maintank."] = "移除 MT。",
	["Removed maintank: "] = "移除 MT：",
	["Set maintank: "] = "设定 MT：",
	["Leader/MainTank"] = "团长/MT",
	["Broadcast"] = "广播 MT",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "向团队广播 MT。",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear main tank targets."] = "打开|cffffffff暴雪按键绑定界面|r设置或删除 MT 目标的按键绑定。",
	["Press |cffffffff%s|r to set the next main tank or |cffffffff%s|r to clear the last tank set."] = "按|cffffffff%s|r设置下一位 MT 或者|cffffffff%s|r清除最后 Tank 设置。",
	["<no binding>"] = "<没有绑定>",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["Set target on a free mt-slot"] = "设定当前目标为下一个空 MT 位置",
	["Free"] = "空",
	["All"] = "全部",
	["Delete all Maintanks"] = "移除所有 MT",
	["<Not Assigned>"] = "<还未设定>",
} end)

L:RegisterTranslations("zhTW", function() return {
	["MainTank"] = "主坦",
	["Options for the maintanks."] = "主坦選項",
	["Set"] = "設定",
	["Set a maintank."]= "設定一位主坦",
	["<nr> <name>"] = "<數量> <名字>",
	["<nr>"] = "<數量>",
	["<name>"] = "<名字>",
	["Remove"] = "移除",
	["Remove a maintank."] = "移除一位主坦",
	["Removed maintank: "] = "移除主坦",
	["Set maintank: "] = "設定主坦: ",
	["Leader/MainTank"] = "領隊/主坦",
	["Broadcast"] = "廣播主坦",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "向團隊廣播主坦列表，如果某人沒自動更新到列表時。",

	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["Set target on a free mt-slot"] = "設定目標至空閒主坦位置",
	["Free"] = "空",
	["All"] = "全部",
	["Delete all Maintanks"] = "移除所有主坦",
	["<Not Assigned>"] = "<未設定>",
} end)

L:RegisterTranslations("frFR", function() return {
	["MainTank"] = "Tanks principaux",
	["Options for the maintanks."] = "Options concernant les tanks principaux.",
	["Set"] = "Définir",
	["Set a maintank."]= "Définit un tank principal.",
	["<nr> <name>"] = "<n°> <nom>",
	["<nr>"] = "<n°>",
	["<name>"] = "<nom>",
	["Remove"] = "Enlever",
	["Remove a maintank."] = "Enlève un tank principal.",
	["Removed maintank: "] = "Tank principal enlevé : ",
	["Set maintank: "] = "Tank principal définit : ",
	["Leader/MainTank"] = "Chef/Tanks principaux",
	["Broadcast"] = "Diffuser",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "Diffuse votre liste des tanks principaux au raid, au cas où quelqu'un ne les a pas reçus automatiquement.",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["Set target on a free mt-slot"] = "Ajoute la cible à un emplacement libre des tanks principaux.",
	["Free"] = "Libre",
	["All"] = "Tous",
	["Delete all Maintanks"] = "Supprime tous les tanks principaux.",
	["<Not Assigned>"] = "<Non assigné>",
} end)

L:RegisterTranslations("deDE", function() return {
	["MainTank"] = "MainTank",
	["Options for the maintanks."] = "Optionen für MainTanks.",
	["Set"] = "Setze MainTank",
	["Set a maintank."] = "Fügt einen MainTank hinzu.",
	["<nr> <name>"] = "<nr> <name>",
	["<nr>"] = "<nr>",
	["<name>"] = "<name>",
	["Remove"] = "Entferne MainTank",
	["Remove a maintank."] = "Entfernt einen MainTank aus der Liste.",
	["Removed maintank: "] = "MainTank gelöscht: ",
	["Set maintank: "] = "MainTank gesetzt: ",
	["Leader/MainTank"] = "Anführer/MainTank",
	["Broadcast"] = "Verbreite MainTanks",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "Sendet dem Schlachtzug Deine MainTank List, falls diese nicht automatisch übertragen wurde.",

	["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear main tank targets."] = "Öffne die |cffffffffBlizzard Tastaturbelegung|r um für oRA2 Tasten zuzuweisen, mit welchen du die Main Tanks setzen und löschen kannst.",
	["Press |cffffffff%s|r to set the next main tank or |cffffffff%s|r to clear the last tank set."] = "Drück |cffffffff%s|r um den nächsten Main Tank zu setzen oder |cffffffff%s|r um den zuletzt gesetzten Main Tank zu löschen.",
	["<no binding>"] = "<keine belegung>",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["Set target on a free mt-slot"] = "Setzt Dein Ziel auf einen freien MainTank Platz.",
	["Free"] = "Freier MT Platz",
	["All"] = "Alle",
	["Delete all Maintanks"] = "Lösche alle MainTanks",
	["<Not Assigned>"] = "<nicht zugewiesen>",
} end)
-- Translated by by StingerSoft (Эритнулл aka Шептун)
L:RegisterTranslations("ruRU", function() return {
	["MainTank"] = "Главный танк",
	["Options for the maintanks."] = "Опции ГТ.",
	["Set"] = "Назначить",
	["Set a maintank."]= "Назначить гланого танка",
	["<nr> <name>"] = "<№> <имя>",
	["<nr>"] = "<№>",
	["<name>"] = "<имя>",
	["Remove"] = "Удалить",
	["Remove a maintank."] = "Удалить ГТ.",
	["Removed maintank: "] = "Удалённый ГТ: ",
	["Set maintank: "] = "Назначенные танки: ",
	["Leader/MainTank"] = "Лидер/ГТ",
	["Broadcast"] = "Передача списка ГТов",
	["Send the raid your main tank list, in case someone didn't pick it up automatically."] = "Показывать рейду список танков, в случае, если у когото это не зделалось автоматически.",

	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["Set target on a free mt-slot"] = "Поставить цель в свободный ГТ-слот",
	["Free"] = "Свободный",
	["All"] = "Всех",
	["Delete all Maintanks"] = "Удалить всех ГТ",
	["<Not Assigned>"] = "<Не задан>",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local function validateSet(a, b)
	if b then -- We're in dewdrop.
		return b:find("^(%S+)$")
	else -- We're in AceConsole
		return a:find("^(%S+)$")
	end
end

local mod = oRA:NewModule("LeaderMT")
mod.leader = true
mod.name = L["Leader/MainTank"]
mod.consoleCmd = "mt"
mod.consoleOptions = {
	type = "group",
	desc = L["Options for the maintanks."],
	name = L["MainTank"],
	disabled = function() return not oRA:IsActive() end,
	handler = mod,
	args = {
		set = {
			name = L["Set"], type = "group",
			desc = L["Set a maintank."],
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
			pass = true,
			get = function(key)
				return oRA.maintanktable[key]
			end,
			set = "Set",
			order = 100,
			args = {
				[1] = {
					name = "1.", type = "text", desc = L["Set"].." 1",
					validate = validateSet,
					usage = L["<name>"],
					order = 1,
				},
				[2] = {
					name = "2.", type = "text", desc = L["Set"].." 2",
					validate = validateSet,
					usage = L["<name>"],
					order = 2,
				},
				[3] = {
					name = "3.", type = "text", desc = L["Set"].." 3",
					validate = validateSet,
					usage = L["<name>"],
					order = 3,
				},
				[4] = {
					name = "4.", type = "text", desc = L["Set"].." 4",
					validate = validateSet,
					usage = L["<name>"],
					order = 4,
				},
				[5] = {
					name = "5.", type = "text", desc = L["Set"].." 5",
					validate = validateSet,
					usage = L["<name>"],
					order = 5,
				},
				[6] = {
					name = "6.", type = "text", desc = L["Set"].." 6",
					validate = validateSet,
					usage = L["<name>"],
					order = 6,
				},
				[7] = {
					name = "7.", type = "text", desc = L["Set"].." 7",
					validate = validateSet,
					usage = L["<name>"],
					order = 7,
				},
				[8] = {
					name = "8.", type = "text", desc = L["Set"].." 8",
					validate = validateSet,
					usage = L["<name>"],
					order = 8,
				},
				[9] = {
					name = "9.", type = "text", desc = L["Set"].." 9",
					validate = validateSet,
					usage = L["<name>"],
					order = 9,
				},
				[10] = {
					name = "10.", type = "text", desc = L["Set"].." 10",
					validate = validateSet,
					usage = L["<name>"],
					order = 10,
				},
				free = {
					name = L["Free"], type = "execute", desc = L["Set target on a free mt-slot"],
					func = function()
						if not UnitInRaid("target") then
							return
						end
						local name = UnitName("target")
						for i = 1, 10 do
							if not oRA.maintanktable[i] then
								mod:Set(i, name)
								break
							end
						end
					end,
					order = 11,
				},
			},
		},
		remove = {
			name = L["Remove"], type = "group",
			desc = L["Remove a maintank."],
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
			pass = true,
			func = function(key)
				if type(key) == "number" then
					mod:Remove(key)
				else
					for i = 1, 10 do
						mod:Remove(i)
					end
				end
			end,
			order = 101,
			args = {
				[1] = {
					name = "1.", type = "execute", desc = L["Remove"].." 1",
					disabled = function() return not oRA.maintanktable[1] end,
					order = 1,
				},
				[2] = {
					name = "2.", type = "execute", desc = L["Remove"].." 2",
					disabled = function() return not oRA.maintanktable[2] end,
					order = 2,
				},
				[3] = {
					name = "3.", type = "execute", desc = L["Remove"].." 3",
					disabled = function() return not oRA.maintanktable[3] end,
					order = 3,
				},
				[4] = {
					name = "4.", type = "execute", desc = L["Remove"].." 4",
					disabled = function() return not oRA.maintanktable[4] end,
					order = 4,
				},
				[5] = {
					name = "5.", type = "execute", desc = L["Remove"].." 5",
					disabled = function() return not oRA.maintanktable[5] end,
					order = 5,
				},
				[6] = {
					name = "6.", type = "execute", desc = L["Remove"].." 6",
					disabled = function() return not oRA.maintanktable[6] end,
					order = 6,
				},
				[7] = {
					name = "7.", type = "execute", desc = L["Remove"].." 7",
					disabled = function() return not oRA.maintanktable[7] end,
					order = 7,
				},
				[8] = {
					name = "8.", type = "execute", desc = L["Remove"].." 8",
					disabled = function() return not oRA.maintanktable[8] end,
					order = 8,
				},
				[9] = {
					name = "9.", type = "execute", desc = L["Remove"].." 9",
					disabled = function() return not oRA.maintanktable[9] end,
					order = 9,
				},
				[10] = {
					name = "10.", type = "execute", desc = L["Remove"].." 10",
					disabled = function() return not oRA.maintanktable[10] end,
					order = 10,
				},
				all = {
					name = L["All"], type="execute", desc = L["Delete all Maintanks"],
					order = 10,
				},
			},
		},
		broadcast = {
			name = L["Broadcast"], type = "execute",
			desc = L["Send the raid your main tank list, in case someone didn't pick it up automatically."],
			func = "oRA_Broadcast",
			disabled = function() return not oRA:IsModuleActive(mod) or not oRA:IsPromoted() end,
			order = 102,
		},
	},
}

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("oRA_MainTankUpdate")
	self:RegisterEvent("oRA_JoinedRaid", "oRA_MainTankUpdate")
	self:RegisterCheck("GETMT", "oRA_Broadcast")
end

-------------------------------
--       Event Handlers      --
-------------------------------

local nameString = "%d. %s"
function mod:oRA_MainTankUpdate()
	if not oRA.maintanktable then return end
	local opt = oRA.consoleOptions.args.mt.args
	for k = 1, 10 do
		local mt = oRA.maintanktable[k]
		if mt then
			local n = nameString:format(k, self.coloredNames[mt])
			opt.remove.args[k].name = n 
			opt.set.args[k].name = n
		else
			opt.remove.args[k].name = tostring(k).."."
			opt.set.args[k].name = tostring(k).."."
		end
	end
end

-------------------------------
--      Command Handlers     --
-------------------------------

function mod:Set(index, player)
	if not oRA:IsPromoted() then return end
	local name = UnitExists(player) and UnitName(player) or player:gsub("^%l", string.upper)
	oRA:SendMessage("SET " .. index .. " " .. name)
	self:Print(L["Set maintank: "] .. "[".. index .. "] [" .. name .."]")
end

function mod:Remove(num)
	if not oRA:IsPromoted() then return end
	local name = oRA.maintanktable[num]
	if not name then return end
	oRA:SendMessage("R "..name)
	self:Print(L["Removed maintank: "] .. num .." "..name)
end

function mod:oRA_Broadcast()
	if not oRA:IsPromoted() then return end
	for k, v in pairs(oRA.maintanktable) do
		if UnitInRaid(v) then
			oRA:SendMessage("SET "..k.." "..v)
		end
	end
end

function mod:SetNextMainTank()
	local name = UnitName("target")
	if not name then name = UnitName("mouseover") end
	if not name or not UnitInRaid(name) then return end
	for i = 1, 10 do
		if not oRA.maintanktable[i] then
			self:Set(i, name)
			break
		end
	end
end

function mod:ClearLastMainTank()
	for i = 10, 1, -1 do
		if oRA.maintanktable[i] then
			self:Remove(i)
			break
		end
	end
end

------------------------------
--      Tooltip Updating    --
------------------------------

do
	local l = L["Press |cffffffff%s|r to set the next main tank or |cffffffff%s|r to clear the last tank set."]
	local no = L["Open the |cffffffffBlizzard Keybinding Interface|r to assign keybindings to set and clear main tank targets."]
	local noBinding = L["<no binding>"]
	function mod:OnTooltipUpdate(tt)
		--if not oRA:IsPromoted() then return end
		local set = GetBindingKey("Set Next MT")
		local clear = GetBindingKey("Clear Last MT")
		if set then set = GetBindingText(set, "KEY_") end
		if clear then clear = GetBindingText(clear, "KEY_") end
		if set or clear then
			tt:AddLine(l:format(set or noBinding, clear or noBinding), nil, nil, nil, 1)
		else
			tt:AddLine(no, nil, nil, nil, 1)
		end
		tt:AddLine(" ")
	end
end

