local function __BigFoot_ActionButton_UpdateUsable(self)
	local icon = getglobal(self:GetName().."Icon");
	local normalTexture = getglobal(self:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(self));
	if ( isUsable ) then
		if (  BigFoot_DistanceAlert and IsActionInRange( ActionButton_GetPagedID(self)) == 0 ) then
			icon:SetVertexColor(BigFoot_DistanceAlert.color.r, BigFoot_DistanceAlert.color.g, BigFoot_DistanceAlert.color.b);
		else	
			icon:SetVertexColor(1.0, 1.0, 1.0);
		end
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	elseif ( notEnoughMana ) then
		if (  BigFoot_DistanceAlert and IsActionInRange( ActionButton_GetPagedID(self)) == 0 ) then
			icon:SetVertexColor(BigFoot_DistanceAlert.color.r, BigFoot_DistanceAlert.color.g, BigFoot_DistanceAlert.color.b);
		else	
			icon:SetVertexColor(0.5, 0.5, 1.0);
		end
		normalTexture:SetVertexColor(0.5, 0.5, 1.0);
	else
		if (  BigFoot_DistanceAlert and IsActionInRange( ActionButton_GetPagedID(self)) == 0 ) then
			icon:SetVertexColor(BigFoot_DistanceAlert.color.r, BigFoot_DistanceAlert.color.g, BigFoot_DistanceAlert.color.b);
		else	
			icon:SetVertexColor(0.4, 0.4, 0.4);
		end

		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end
end

local function __BigFoot_ActionButton_OnUpdate(self, elapsed)
	if (not BigFoot_DistanceAlert) then
		return;
	end

	if ( self.rangeTimer ) then
		self.checkTimer = self.checkTimer and (self.checkTimer - elapsed) or -1;
		if ( self.checkTimer <= 0 ) then
			local count = getglobal(self:GetName().."HotKey");			
			local icon = getglobal(self:GetName().."Icon");
			if ( count:GetText() == RANGE_INDICATOR ) then
				count:SetAlpha(0);
			else
				count:SetAlpha(1);
			end
			if ( IsActionInRange( ActionButton_GetPagedID(self)) == 0 ) then
				if ( BigFoot_DistanceAlert ) then
					icon:SetVertexColor(BigFoot_DistanceAlert.color.r, BigFoot_DistanceAlert.color.g, BigFoot_DistanceAlert.color.b);
				end
				count:SetVertexColor(1.0, 0.1, 0.1);
			else
				if ( BigFoot_DistanceAlert ) then
					__BigFoot_ActionButton_UpdateUsable(self);
				end
				count:SetVertexColor(0.6, 0.6, 0.6);
			end
			self.checkTimer = TOOLTIP_UPDATE_TIME; -- TOOLTIP_UPDATE_TIME = 0.2s;
		end
	end	
end

function DistanceAlert_Toggle(flag)
	if (flag == 1) then
		BigFoot_DistanceAlert = {};
		BigFoot_DistanceAlert.color = {};
		BigFoot_DistanceAlert.color.r = 0.5;
		BigFoot_DistanceAlert.color.g = 0.1;
		BigFoot_DistanceAlert.color.b = 0.1;

		if (not __ActionButton_OnUpdate) then
			hooksecurefunc("ActionButton_OnUpdate", __BigFoot_ActionButton_OnUpdate);
			__ActionButton_OnUpdate = true
		end
	else
		BigFoot_DistanceAlert = nil;
	end
end