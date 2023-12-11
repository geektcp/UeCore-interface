﻿-- Warsong mod v3.0
-- rewrite by Nitram and Tandanu
--
-- thanks to LeoLeal, DiabloHu and Са°ЧТВ


local Warsong	= DBM:NewMod("WarsongGulch", "DBM-PvP", 2)
local L			= Warsong:GetLocalizedStrings()

Warsong:RemoveOption("HealthFrame")

Warsong:SetZone(DBM_DISABLE_ZONE_DETECTION)

local bgzone = false
local FlagCarrier = {
	[1] = nil,
	[2] = nil
}
Warsong:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_REGEN_ENABLED",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"UPDATE_BATTLEFIELD_SCORE"
)

local startTimer = Warsong:NewTimer(62, "TimerStart")
local flagTimer = Warsong:NewTimer(23, "TimerFlag", "Interface\\Icons\\INV_Banner_02")

Warsong:AddBoolOption("ShowFlagCarrier", true, nil, function()
	if Warsong.Options.ShowFlagCarrier and bgzone then
		Warsong:ShowFlagCarrier()
	else
		Warsong:HideFlagCarrier()
	end	
end)
Warsong:AddBoolOption("ShowFlagCarrierErrorNote", false)

do
	local function WSG_Initialize()
		if select(2, IsInInstance()) == "pvp" and GetRealZoneText() == L.ZoneName then
			bgzone = true
			if Warsong.Options.ShowFlagCarrier then
				Warsong:ShowFlagCarrier()
				Warsong:CreateFlagCarrierButton()
			end

			Warsong.FlagCarrierFrame1Text:SetText("")
			Warsong.FlagCarrierFrame2Text:SetText("")
			FlagCarrier[1] = nil
			FlagCarrier[2] = nil

		elseif bgzone then
			bgzone = false
			if Warsong.Options.ShowFlagCarrier then
				Warsong:HideFlagCarrier()
			end
		end
	end
	Warsong.OnInitialize = WSG_Initialize
	Warsong.ZONE_CHANGED_NEW_AREA = WSG_Initialize
end

function Warsong:CHAT_MSG_BG_SYSTEM_NEUTRAL(arg1)
	if not bgzone then return end
	if arg1 == L.BgStart60 then
		startTimer:Start()
	elseif arg1 == L.BgStart30  then		
		startTimer:Update(31, 62)
	end
end


function Warsong:ShowFlagCarrier()
	if not Warsong.Options.ShowFlagCarrier then return end
	if AlwaysUpFrame3DynamicIconButton and AlwaysUpFrame3DynamicIconButton then
		if not self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame2DynamicIconButton)
			self.FlagCarrierFrame1:SetHeight(10)
			self.FlagCarrierFrame1:SetWidth(100)
			self.FlagCarrierFrame1:SetPoint("LEFT", "AlwaysUpFrame2DynamicIconButton", "RIGHT", 4, 0)
			self.FlagCarrierFrame1Text = self.FlagCarrierFrame1:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.FlagCarrierFrame1Text:SetAllPoints(self.FlagCarrierFrame1)
			self.FlagCarrierFrame1Text:SetJustifyH("LEFT")
		end
		if not self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame3DynamicIconButton)
			self.FlagCarrierFrame2:SetHeight(10)
			self.FlagCarrierFrame2:SetWidth(100)
			self.FlagCarrierFrame2:SetPoint("LEFT", "AlwaysUpFrame3DynamicIconButton", "RIGHT", 4, 0)
			self.FlagCarrierFrame2Text= self.FlagCarrierFrame2:CreateFontString(nil, nil, "GameFontNormalSmall")
			self.FlagCarrierFrame2Text:SetAllPoints(self.FlagCarrierFrame2)
			self.FlagCarrierFrame2Text:SetJustifyH("LEFT")
		end
		self.FlagCarrierFrame1:Show()		
		self.FlagCarrierFrame2:Show()
	end
end

function Warsong:CreateFlagCarrierButton()
	if not Warsong.Options.ShowFlagCarrier then return end
	if not self.FlagCarrierFrame1Button then
		self.FlagCarrierFrame1Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame1Button:SetHeight(15)
		self.FlagCarrierFrame1Button:SetWidth(150)
		self.FlagCarrierFrame1Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame1Button:SetPoint("LEFT", "AlwaysUpFrame2", "RIGHT", 28, 4)
	end
	if not self.FlagCarrierFrame2Button then
		self.FlagCarrierFrame2Button = CreateFrame("Button", nil, nil, "SecureActionButtonTemplate")
		self.FlagCarrierFrame2Button:SetHeight(15)
		self.FlagCarrierFrame2Button:SetWidth(150)
		self.FlagCarrierFrame2Button:SetAttribute("type", "macro")
		self.FlagCarrierFrame2Button:SetPoint("LEFT", "AlwaysUpFrame3", "RIGHT", 28, 4)
	end
	self.FlagCarrierFrame1Button:Show()		
	self.FlagCarrierFrame2Button:Show()
end

function Warsong:HideFlagCarrier()
	if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
		self.FlagCarrierFrame1:Hide()
		self.FlagCarrierFrame2:Hide()
		FlagCarrier[1] = nil
		FlagCarrier[2] = nil
	end
end

function Warsong:CheckFlagCarrier()
	if not UnitAffectingCombat("player") then
		if FlagCarrier[1] and self.FlagCarrierFrame1 then
			self.FlagCarrierFrame1Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[1])
		end
		if FlagCarrier[2] and self.FlagCarrierFrame2 then
			self.FlagCarrierFrame2Button:SetAttribute("macrotext", "/targetexact " .. FlagCarrier[2])
		end
	end
end

do
	local lastCarrier
	function Warsong:ColorFlagCarrier(carrier)
		local found = false
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, _, _, _, class = GetBattlefieldScore(i)
	 		if (name and class and RAID_CLASS_COLORS[class]) then
				if string.match( name, "-" )  then
					name = string.match(name, "([^%-]+)%-.+")
				end
				if name == carrier then
					if faction == 0 then
						self.FlagCarrierFrame2Text:SetTextColor(RAID_CLASS_COLORS[class].r, 
											RAID_CLASS_COLORS[class].g, 
											RAID_CLASS_COLORS[class].b)
					elseif faction == 1 then
						self.FlagCarrierFrame1Text:SetTextColor(RAID_CLASS_COLORS[class].r, 
											RAID_CLASS_COLORS[class].g, 
											RAID_CLASS_COLORS[class].b)
					end
					found = true
				end
			end
		end
		if not found then
			RequestBattlefieldScoreData()
			lastCarrier = carrier
		end
	end
	
	function Warsong:UPDATE_BATTLEFIELD_SCORE()
		if lastCarrier then
			self:ColorFlagCarrier(lastCarrier)
			lastCarrier = nil
		end
	end
end

function Warsong:PLAYER_REGEN_ENABLED()
	if bgzone then
		self:CheckFlagCarrier()
	end
end

do
	local function updateflagcarrier(self, event, arg1)
		if not self.Options.ShowFlagCarrier then return end
		if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
			if string.match(arg1, L.ExprFlagPickUp) then
				local sArg1, sArg2 =  string.match(arg1, L.ExprFlagPickUp)
				local mSide, mNick
				if( GetLocale() == "deDE") then
					mSide = sArg2
					mNick = sArg1
				else
					mSide = sArg1
					mNick = sArg2
				end
			
				if( GetLocale() == "koKR") then
					mSide = sArg2
					mNick = sArg1
				end
				
				if mSide == L.Alliance then
					FlagCarrier[2] = mNick
					self.FlagCarrierFrame2Text:SetText(mNick)
					self.FlagCarrierFrame2:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame2Button:SetAttribute( "macrotext", "/targetexact " .. mNick )
					end					

				elseif mSide == L.Horde then
					FlagCarrier[1] = mNick
					self.FlagCarrierFrame1Text:SetText(mNick)
					self.FlagCarrierFrame1:Show()
					self:ColorFlagCarrier(mNick)
					if UnitAffectingCombat("player") then
						if self.Options.ShowFlagCarrierErrorNote then
							self:AddMsg(L.InfoErrorText)
						end
					else
						self.FlagCarrierFrame1Button:SetAttribute( "macrotext", "/targetexact " .. mNick )
					end
				end
				
			elseif string.match(arg1, L.ExprFlagReturn) then
				if( GetLocale() == "ruRU") then
					local _, _, mNick, mSide =  string.find(arg1, L.ExprFlagReturn)
				else
					local _, _, mSide, mNick =  string.find(arg1, L.ExprFlagReturn)
				end
				
				if mSide == L.Alliance then
					self.FlagCarrierFrame2:Hide()
					FlagCarrier[2] = nil

				elseif mSide == L.Horde then
					self.FlagCarrierFrame1:Hide()
					FlagCarrier[1] = nil
				end
			end
		end
		if string.match(arg1, L.ExprFlagCaptured) then
			flagTimer:Start()
		
			if self.FlagCarrierFrame1 and self.FlagCarrierFrame2 then
				self.FlagCarrierFrame1:Hide()
				self.FlagCarrierFrame2:Hide()
				FlagCarrier[1] = nil
				FlagCarrier[2] = nil
			end
		end
	end
	function Warsong:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_ALLIANCE", ...)
	end
	function Warsong:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, "CHAT_MSG_BG_SYSTEM_HORDE", ...)
	end
end



