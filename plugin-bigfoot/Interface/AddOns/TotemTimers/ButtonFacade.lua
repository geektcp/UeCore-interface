local lbf

function TotemTimers.SkinCallback(arg, SkinID,Gloss,Backdrop,Group,Button,Colors)
	TotemTimers_Settings.ButtonFacade = {
		["Skin"] = SkinID,
		["Gloss"] = Gloss,
		["Backdrop"] = Backdrop,
		["Colors"] = Colors,
	}
    
	local skins = lbf:GetSkins()
	if skins[SkinID].Icon then
        TotemTimers.ApplySkin(skins[SkinID])
	end
	if SkinID == "Blizzard" then
		for k,v in pairs(XiTimers.timers) do
			v.button:SetNormalTexture(nil)
            v.Animation.button:SetNormalTexture(nil)
		end
	end
end

function TotemTimers_InitButtonFacade()
	if not LibStub then return end
	lbf = LibStub("LibButtonFacade", true)
	if lbf then
		local group = lbf:Group("TotemTimers")
		for k,v in pairs(XiTimers.timers) do
            group:AddButton(v.button)
            group:AddButton(v.Animation.button)
        end 
        for i = 1,#TTActionBars.bars do
            for j = 1,#TTActionBars.bars[i].buttons do
                group:AddButton(TTActionBars.bars[i].buttons[j])
            end
        end
		for i=1,8 do
            --group:AddButton(getglobal("TotemTimers_SetButton"..i))
        end
        group:AddButton(TotemTimers_MultiSpell)
		lbf:RegisterSkinCallback("TotemTimers", TotemTimers.SkinCallback,nil)
		if TotemTimers_Settings.ButtonFacade then
			group:Skin(TotemTimers_Settings.ButtonFacade.Skin or "Blizzard", 
				TotemTimers_Settings.ButtonFacade.Gloss,
				TotemTimers_Settings.ButtonFacade.Backdrop,
				TotemTimers_Settings.ButtonFacade.Colors
			)
		end		
	end
end

