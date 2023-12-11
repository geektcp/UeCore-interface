local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local UF = E:GetModule("UnitFrames")
local _, ns = ...
local ElvUF = ns.oUF
assert(ElvUF, "ElvUI was unable to locate oUF.")

--Lua functions
local _G = _G
local tinsert = tinsert
--WoW API / Variables

function UF:Construct_PetFrame(frame)
	frame.Health = self:Construct_HealthBar(frame, true, true, "RIGHT")
	frame.Health.frequentUpdates = true
	frame.Power = self:Construct_PowerBar(frame, true, true, "LEFT")
	frame.Name = self:Construct_NameText(frame)
	frame.Portrait3D = self:Construct_Portrait(frame, "model")
	frame.Portrait2D = self:Construct_Portrait(frame, "texture")
	frame.Buffs = self:Construct_Buffs(frame)
	frame.Debuffs = self:Construct_Debuffs(frame)
	frame.Castbar = self:Construct_Castbar(frame, L["Pet Castbar"])
	frame.Castbar.SafeZone = nil
	frame.Castbar.LatencyTexture:Hide()
	frame.ThreatIndicator = self:Construct_Threat(frame)
	frame.HealCommBar = self:Construct_HealComm(frame)
	frame.AuraWatch = self:Construct_AuraWatch(frame)
	frame.AuraBars = self:Construct_AuraBarHeader(frame)
	if E.myclass == "HUNTER" then
		frame.HappinessIndicator = self:Construct_Happiness(frame)
	end
	frame.InfoPanel = self:Construct_InfoPanel(frame)
	frame.MouseGlow = self:Construct_MouseGlow(frame)
	frame.TargetGlow = self:Construct_TargetGlow(frame)
	frame.Fader = self:Construct_Fader()
	frame.Cutaway = self:Construct_Cutaway(frame)
	frame.customTexts = {}

	frame:Point("BOTTOM", E.UIParent, "BOTTOM", 0, 118)
	E:CreateMover(frame, frame:GetName().."Mover", L["Pet Frame"], nil, nil, nil, "ALL,SOLO", nil, "unitframe,pet,generalGroup")

	frame.unitframeType = "pet"
end

function UF:Update_PetFrame(frame, db)
	frame.db = db

	do
		frame.ORIENTATION = db.orientation --allow this value to change when unitframes position changes on screen?
		frame.UNIT_WIDTH = db.width
		frame.UNIT_HEIGHT = db.infoPanel.enable and (db.height + db.infoPanel.height) or db.height

		frame.USE_POWERBAR = db.power.enable
		frame.POWERBAR_DETACHED = db.power.detachFromFrame
		frame.USE_INSET_POWERBAR = not frame.POWERBAR_DETACHED and db.power.width == "inset" and frame.USE_POWERBAR
		frame.USE_MINI_POWERBAR = (not frame.POWERBAR_DETACHED and db.power.width == "spaced" and frame.USE_POWERBAR)
		frame.USE_POWERBAR_OFFSET = db.power.offset ~= 0 and frame.USE_POWERBAR and not frame.POWERBAR_DETACHED
		frame.POWERBAR_OFFSET = frame.USE_POWERBAR_OFFSET and db.power.offset or 0

		frame.POWERBAR_HEIGHT = not frame.USE_POWERBAR and 0 or db.power.height
		frame.POWERBAR_WIDTH = frame.USE_MINI_POWERBAR and (frame.UNIT_WIDTH - (frame.BORDER*2))/2 or (frame.POWERBAR_DETACHED and db.power.detachedWidth or (frame.UNIT_WIDTH - ((frame.BORDER+frame.SPACING)*2)))

		frame.USE_PORTRAIT = db.portrait and db.portrait.enable
		frame.USE_PORTRAIT_OVERLAY = frame.USE_PORTRAIT and (db.portrait.overlay or frame.ORIENTATION == "MIDDLE")
		frame.PORTRAIT_WIDTH = (frame.USE_PORTRAIT_OVERLAY or not frame.USE_PORTRAIT) and 0 or db.portrait.width

		frame.USE_INFO_PANEL = not frame.USE_MINI_POWERBAR and not frame.USE_POWERBAR_OFFSET and db.infoPanel.enable
		frame.INFO_PANEL_HEIGHT = frame.USE_INFO_PANEL and db.infoPanel.height or 0

		frame.HAPPINESS_SHOWN = (db.happiness and db.happiness.enable) and frame.HappinessIndicator and frame.HappinessIndicator:IsShown()
		frame.HAPPINESS_WIDTH = frame.HAPPINESS_SHOWN and (db.happiness.width + (frame.BORDER*2)) or 0

		frame.BOTTOM_OFFSET = UF:GetHealthBottomOffset(frame)

		frame.VARIABLES_SET = true
	end

	frame.colors = ElvUF.colors
	frame.Portrait = frame.Portrait or (db.portrait.style == "2D" and frame.Portrait2D or frame.Portrait3D)
	frame:RegisterForClicks(self.db.targetOnMouseDown and "AnyDown" or "AnyUp")
	frame:Size(frame.UNIT_WIDTH, frame.UNIT_HEIGHT)
	_G[frame:GetName().."Mover"]:Size(frame:GetSize())

	UF:Configure_InfoPanel(frame)

	--Health
	UF:Configure_HealthBar(frame)

	--Name
	UF:UpdateNameSettings(frame)

	--Power
	UF:Configure_Power(frame)

	--Portrait
	UF:Configure_Portrait(frame)

	--Threat
	UF:Configure_Threat(frame)

	--Auras
	UF:EnableDisable_Auras(frame)
	UF:Configure_Auras(frame, "Buffs")
	UF:Configure_Auras(frame, "Debuffs")

	--Fader
	UF:Configure_Fader(frame)

	--Cutaway
	UF:Configure_Cutaway(frame)

	--Castbar
	UF:Configure_Castbar(frame)

	--OverHealing
	UF:Configure_HealComm(frame)

	--AuraBars
	UF:Configure_AuraBars(frame)

	if E.myclass == "HUNTER" then
		UF:Configure_Happiness(frame)
	end

	--CustomTexts
	UF:Configure_CustomTexts(frame)

	UF:UpdateAuraWatch(frame)
	frame:UpdateAllElements("ForceUpdate")
end

tinsert(UF.unitstoload, "pet")