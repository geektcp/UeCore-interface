--==================================================
-- BigFootPopRange.lua
-- ����: 2008��5��23��
-- ����: ���°�ѩ
-- ����: �ṩһ����Slider�ķ�Χ���ڶԻ���. 
-- ��Ȩ����: ������˹���ҵ���
--================================================== 
--[[
	�� ��Ҫ����
		�ṩһ���򵥵�Slider�����Ի���, ���㵯���˵���Ҫ��Χ���ڵ�Ҫ��.

	�� �����ĵ�
		ԭ��: BigFoot_ShowPopRange(minV, maxV, value, step, showPrecent, func, onShow, onHide, tooltip)
		����: 
			minV				- <number>	 ����ֵ
			maxV			- <number>	 ����ֵ
			value				- <number>	 ��ǰֵ
			step				- <number>	 ��ֵ
			showPrecent	- <boolean>	 �Ƿ񰴰ٷֱ���ʽ��ʾ
			func				- <function>	 ��ֵ�ı�ʱ���õķ���
			onShow			- <function>	 ���Ի�����ʾʱ���õķ���
			onHide			- <function>	 ���Ի�������ʱ���õķ���(����������ı����ñ���ֵ)
			tooltip			- <function>  �����ʾ����
		����: �ṩһ����Slider�ķ�Χ���ڶԻ���. 
	
	�� ��Ҫʾ��
		�μ�[���°�ѩ]<<������˾����>>Options.lua�ļ�.
]]

local function BigFoot_CreatePopRange()	
	local frame = CreateFrame("Frame", "BigFoot_PopRangeFrame", UIParent);
	tinsert(UISpecialFrames, "BigFoot_PopRangeFrame");
	frame:SetWidth(280);
	frame:SetHeight(100);
	frame:SetToplevel(true);
	frame:EnableMouse(true);
	frame:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, 
		  insets = { left = 11, right = 12, top = 12, bottom = 11}});
	frame:SetPoint("TOP", UIParent, "TOP", 0, -120);
	frame:Hide();
	frame.slider = CreateFrame("Slider", "BigFoot_PopRangeSlider", frame, "OptionsSliderTemplate");
	frame.slider.highText = getglobal("BigFoot_PopRangeSliderHigh");
	frame.slider.lowText = getglobal("BigFoot_PopRangeSliderLow");
	frame.slider.valueText = getglobal("BigFoot_PopRangeSliderText");
	frame.slider.thumb = getglobal("BigFoot_PopRangeSliderThumb");
	frame.slider:SetWidth(180);
	frame.slider:SetPoint("TOP", frame, "TOP", 0, -30);
	frame.slider:SetScript("OnValueChanged", function(self)
		local value = self:GetValue();
		frame.curV = value;
		if (frame.showPrecent) then
			self.valueText:SetText(format("%d%%",floor( value*100)));
		else
			self.valueText:SetText(value);
		end
		frame.func(value);
	end);	
	frame.okay = CreateFrame("Button", "BigFoot_PopRangeOkay", frame, "UIPanelButtonTemplate2");
	frame.okay:SetText(TEXT(OKAY));
	frame.okay:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 30, 16 );
	frame.okay:SetWidth(100);
	frame.okay:SetScript("OnClick", function(self)
		frame:Hide();
	end);
	frame.okay:Show();
	frame.cancel = CreateFrame("Button", "BigFoot_PopRangeCancel", frame, "UIPanelButtonTemplate2");
	frame.cancel:SetText(TEXT(CANCEL));
	frame.cancel:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 16);
	frame.cancel:SetWidth(100);
	frame.cancel:SetScript("OnClick", function(self)		
		frame.func(frame.preV);
		frame:Hide();
	end);
	frame.cancel:Show();
	frame:SetScript("OnShow", function(self)
		PlaySound("igMainMenuClose");
		if (self.onShow and type(self.onShow) == "function") then
			self.onShow(self.curV);
		end
	end);
	frame:SetScript("OnHide", function(self)
		PlaySound("igMainMenuClose");
		if (self.onHide and type(self.onHide) == "function") then
			self.onHide(self.curV);
		end
	end);
	
	return frame;
end

function BigFoot_ShowPopRange(minV, maxV, value, step, showPrecent, func, onShow, onHide, tooltip)	
	local frame = getglobal("BigFoot_PopRangeFrame") or BigFoot_CreatePopRange();
	frame.onShow = onShow;
	frame.onHide = onHide;
	frame.func = func;	
	frame.preV = value or 0.5;
	frame.curV = value or 0.5;
	frame.minV = minV or 0;
	frame.maxV = maxV or 1;	
	frame.step = step or 0.1;
	frame.slider.tooltipText = tooltip;
	frame.showPrecent = showPrecent or nil; -- [nil|true] nil - ��ֵ��ʾ, true - ���ٷֱ���ʾ; 
	
	frame.slider:SetValueStep(frame.step);
	frame.slider:SetMinMaxValues(frame.minV, frame.maxV);
	frame.slider:SetValue(frame.curV);
	if (frame.showPrecent) then
		frame.slider.valueText:SetText(format("%d%%", floor(frame.curV*100)));
		frame.slider.highText:SetText(format("%d%%", floor(frame.maxV*100)));
		frame.slider.lowText:SetText(format("%d%%", floor(frame.minV*100)));
	else
		frame.slider.valueText:SetText(floor(frame.curV/(frame.maxV - frame.minV)));
		frame.slider.highText:SetText(frame.maxV);
		frame.slider.lowText:SetText(frame.minV);
	end

	frame:Show();
end