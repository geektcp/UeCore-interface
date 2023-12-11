 
local __enableScroll = nil; 
function ScrollChatFrame_OnMouseWheel(self, __delta) 
	if (not __enableScroll) then 
		return; 
	end 
	local __parent = self:GetParent(); 
	if (__delta) then 
		if (__delta > 0) then
			if (IsShiftKeyDown() or IsControlKeyDown()) then
				__parent:PageUp();
			else
				__parent:ScrollUp();
			end
			
		elseif (__delta < 0) then 
			if (IsShiftKeyDown() or IsControlKeyDown()) then
				__parent:PageDown();
			else
				__parent:ScrollDown();
			end			
		end 
	end 
end 

function ScrollChatFrame_OnShow(self) 
	if (not __enableScroll) then 
		return 
	end 
	if (self and self:GetParent()) then 
		local __level = self:GetParent():GetFrameLevel() 
		if (__level > 1) then 
			self:SetFrameLevel(__level + 1) 
		end 
	end 
end 

function ChatEnahnce_Toggle(__switch) 
	if (__switch) then 
		__enableScroll = true 
	else 
		__enableScroll = nil 
	end 
end
--ChatEnahnce_Toggle(1)
