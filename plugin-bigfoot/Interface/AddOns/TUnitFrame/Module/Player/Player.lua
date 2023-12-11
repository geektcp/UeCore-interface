--[[
	Player.lua

	Terry@bf
	2010 - 9 -30
	ʵ���� ģ�岢װ�ص�PlayerFrame��

	Terry@bf
	2010 -11 -5	
	����3dģ�����Ϣģ��Ĵ���
	
	Terry@bf
	2010-11-29
	�ṩ���أ��ƶ�������������Ӧ��Ϣ��
	
]]


local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end 

local M = T:GetModule("Player",true) or T:NewModule("Player")
if not M then return end
M:SetDefaultModuleState(false)

-- ʹ��ģ�壬ʵ����3dͷ��
local __3DPor = T.Templates and T.Templates.ThreeDportrait and T.Templates.ThreeDportrait:new()

--ʹ��ģ�壬ʵ������Ϣ��
local __InfoPane = T.Templates and T.Templates.InfoPane and T.Templates.InfoPane:new()

--move druids alternate mana bar
local function __MoveAlterManaBar()
	if PlayerFrameAlternateManaBar and PlayerFrameAlternateManaBar:IsShown() then
		PlayerFrameAlternateManaBar:SetPoint("TOPLEFT", PlayerFrame, "BOTTOMLEFT", 226, 35)
		PlayerFrameAlternateManaBarText:SetFont("Fonts\\FRIZQT__.TTF",10)
	end
end

--reset druids alternate mana bar
local function __ResetAlterManaBar()
	if PlayerFrameAlternateManaBar and PlayerFrameAlternateManaBar:IsShown() then
		PlayerFrameAlternateManaBar:SetPoint("TOPLEFT", PlayerFrame, "BOTTOMLEFT", 114, 34)
		PlayerFrameAlternateManaBarText:SetFont("Fonts\\FRIZQT__.TTF",12)
	end
end

-- 3dͷ��Ŀ���
function M:Toggle3DPor(flag)
	assert(__3DPor,"3D portrait for PlayerFrame does not exist!")
	if flag then
		__3DPor:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 46, -17)
		__3DPor:Enable()
	else
		__3DPor:Disable()
	end
end

-- ��Ϣ���Ŀ���
function M:ToggleInfoPane(flag)
	assert(__InfoPane,"InfoPane for PlayerFrame does not exist!")
	if flag then
		TargetFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",292,-4)
		__InfoPane:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 224, -20)
		__InfoPane:Enable()
		__InfoPane:SwitchInfoBar(true)
		
		__InfoPane:SwitchBarText(false)
		__MoveAlterManaBar()
	else
		__InfoPane:SwitchInfoBar(false)
		__InfoPane:SwitchBarText(true)
		TargetFrame:SetPoint("TOPLEFT",UIParent,"TOPLEFT",250,-4)
		__ResetAlterManaBar()
	end
end

--�������Ŀ���
function M:ToggleExpBar(flag)
	local eb = M:GetModule("ExpBar")
	assert(eb,"ExpBar for PlayerFrame does not exist!")
	if flag then
		eb:Enable()
	else
		eb:Disable()
	end
end

function M:ToggleColorize(flag)
	if flag then
		__InfoPane:Enable()
		__InfoPane:SwitchColorize(true)
	else
		__InfoPane:SwitchColorize(false)
	end
end

function M:ToggleFormattedText(flag)
	if flag then
		__InfoPane:Enable()
		__InfoPane:ToggleFormattedText(true)
	else
		__InfoPane:ToggleFormattedText(false)
	end
end

--�������ģ��
function M:OnInitialize()
	__3DPor:Create("Player",PlayerFrame,PlayerPortrait)
	
	__InfoPane:Create("Player",PlayerFrame)
	
	
	T:Debug("Player Module Initialized")	
end

--�����κ��������ͷ�������޸ģ���������
function M:OnEnable()
	T:Debug("Player Module Enabled")	
end

function M:OnDisable()
	T:Debug("Player Module Disabled")	
end