-- Battleground mod v3.0
-- rewrite by Tandanu
--
-- thanks to LeoLeal and DiabloHu

local mod	= DBM:NewMod("Battlegrounds", "DBM-PvP", 2)
local L		= mod:GetLocalizedStrings()

mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:AddBoolOption("ColorByClass", true)
mod:AddBoolOption("ShowInviteTimer", true)
mod:AddBoolOption("AutoSpirit", false)
mod:RemoveOption("HealthFrame")

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_DEAD"
)

local inviteTimer = mod:NewTimer(60, "TimerInvite", nil, nil, false)

function mod:ZONE_CHANGED_NEW_AREA()
	if select(2, IsInInstance()) == "pvp" then
		SendAddonMessage("DBMv4-Ver", "Hi!", "BATTLEGROUND")
		self:Schedule(3, DBM.RequestTimers, DBM)
		inviteTimer:Stop()
		SetMapToCurrentZone() -- for GetMapLandmarkInfo()
	end
	for i, v in ipairs(DBM:GetModByName("AlteracValley").timers) do v:Stop() end
	for i, v in ipairs(DBM:GetModByName("EyeoftheStorm").timers) do v:Stop() end
	for i, v in ipairs(DBM:GetModByName("WarsongGulch").timers) do v:Stop() end
	for i, v in ipairs(DBM:GetModByName("ArathiBasin").timers) do v:Stop() end
	for i, v in ipairs(DBM:GetModByName("IsleofConquest").timers) do v:Stop() end
	DBM:GetModByName("AlteracValley"):Unschedule()
	DBM:GetModByName("EyeoftheStorm"):Unschedule()
	DBM:GetModByName("WarsongGulch"):Unschedule()
	DBM:GetModByName("ArathiBasin"):Unschedule()
	DBM:GetModByName("IsleofConquest"):Unschedule()
end
mod.PLAYER_ENTERING_WORLD = mod.ZONE_CHANGED_NEW_AREA
mod.OnInitialize = mod.ZONE_CHANGED_NEW_AREA

function mod:PLAYER_DEAD()
	if select(2, IsInInstance()) == "pvp" and not HasSoulstone() and self.Options.AutoSpirit then
		RepopMe()
	end
end

mod:RegisterOnUpdateHandler(function(self, elapsed)
	if self.Options.ShowInviteTimer and MAX_BATTLEFIELD_QUEUES and PVP_TEAMSIZE then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, mapName, instanceID, _, _, teamSize = GetBattlefieldStatus(i)
			if mapName and (instanceID > 0 or teamSize > 0) then
				if (teamSize > 0) then
					mapName = L.ArenaInvite.." "..format(PVP_TEAMSIZE, tostring(teamSize), tostring(teamSize))
				else
					mapName = mapName.." "..instanceID
				end
			end
			if status == "confirm" and inviteTimer:GetTime(mapName) == 0 and GetBattlefieldPortExpiration(i) >= 3 then	-- do not start a bar if less then 3 secs
				inviteTimer:Start(GetBattlefieldPortExpiration(i), mapName)
			end
		end
	end
end, 0.5)

hooksecurefunc("WorldStateScoreFrame_Update", function() --re-color the players in the score frame
	if not mod.Options.ColorByClass then
		return
	end
	local isArena = IsActiveBattlefieldArena()
	for i = 1, MAX_WORLDSTATE_SCORE_BUTTONS do
		local index = (FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame) or 0) + i
		local name, _, _, _, _, faction, _, _, _, class = GetBattlefieldScore(index)
		if (name ~= UnitName("player")) and class and RAID_CLASS_COLORS[class] and getglobal("WorldStateScoreButton"..i.."NameText") then
			getglobal("WorldStateScoreButton"..i.."NameText"):SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
			local playerName = getglobal("WorldStateScoreButton"..i.."NameText"):GetText()
			if playerName then
				local _, _, playerName, playerServer = string.find(playerName, "([^%-]+)%-(.+)")
				if playerServer and playerName then
					if faction == 0 then
						if isArena then --green team
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cff19ff19"..playerServer.."|r")
						else --horde
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cffff1919"..playerServer.."|r")
						end
					else
						if isArena then --golden team
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cffffd100"..playerServer.."|r")
						else --alliance
							getglobal("WorldStateScoreButton"..i.."NameText"):SetText(playerName.."|cffffffff-|r|cff00adf0"..playerServer.."|r")
						end
					end
				end
			end
		end
	end
end)



