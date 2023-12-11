local M = LibStub("AceAddon-3.0"):NewAddon("MBB","AceEvent-3.0","AceTimer-3.0","AceHook-3.0")
if not M then return end

local L = LibStub("AceLocale-3.0"):GetLocale("MBB")
local LDB = LibStub("LibDataBroker-1.1", true)

local db

local configDialog = LibStub("AceConfigDialog-3.0")

local ignored = {
	["MiniMapTrackingFrame"]=true,
	["MiniMapMeetingStoneFrame"]=true,
	["MiniMapMailFrame"]=true,
	["MiniMapPing"]=true,
	["MinimapBackdrop"]=true,
	["MinimapZoomIn"]=true,
	["MinimapZoomOut"]=true,
	["BookOfTracksFrame"]=true,
	["GatherNote"]=true,
	["FishingExtravaganzaMini"]=true,
	["MiniNotePOI"]=true,
	["RecipeRadarMinimapIcon"]=true,
	["FWGMinimapPOI"]=true,
	["CartographerNotesPOI"]=true,
	["GFW_TrackMenuFrame"]=true,
	["GFW_TrackMenuButton"]=true,
	["TDial_TrackingIcon"]=true,
	["TDial_TrackButton"]=true,
	["MiniMapTracking"]=true,
	["BFGPSButton"]=true,
	["TimeManagerClockButton"]=true,	
	['MiniMapBattlefieldFrame'] = true,
	["GatherMate"] = true,
	["MiniMapLFGFrame"] = true,
	
}

local options = {
	profile = {
		enabled = true,
		enablemousetip = true,
		enablemouseover = false,
		direction = "LEFT",
		itemperline = 0,		
		excludes = {
			['BigFootMinimapButton'] = true,
			['GameTimeFrame'] = true,
			["MiniMapVoiceChatFrame"] = true,
			["MiniMapWorldMapButton"] = true
		
		},
		
		MiniMap =
		{
			hide = false,
			minimapPos = 180,
			radius = 80,		
		}
	},
}

local function Obj(button)
	local obj
	if type(button)=='string' then 
		obj = _G[button]
	elseif type(button)=='table' then
		obj = button
	end
	return obj
end

local function Name(button)
	local name
	if type(button)=='string' then 
		name = button
	elseif type(button)=='table' then
		name = button:GetName()
	end
	return name
end


local launcher

local function IsButtonExcluded(button)
	local name = Name(button)
	local excluded = db.excludes
	if not excluded then return end
	return excluded[name]	
end

local function IsButtonIgnored(button)
	if Name(button)==M.realIcon:GetName() then return true end
	if  ignored[Name(button)] then return true end
	for ignoreName in pairs(ignored) do
		if Name(button):find(ignoreName) then return true end
	end
	return false
end

local function addButton(frame)

	local child = Obj(frame)
	if not child then return end
	if child.added then return end
	child.opoint = {child:GetPoint()};
	if( not child.opoint[1] ) then
		child.opoint = {"TOP", Minimap, "BOTTOM", 0, 0};
	end	
	child.osize = child.osize or {child:GetHeight(),child:GetWidth()};
	child.oisshown = child:IsShown()
	
	M:RawHook(child,"ClearAllPoints",function() end,true)
	M:RawHook(child,"SetPoint",function() end,true)
	M.hooks[child].Hide(child)
	child.added  = true
	M.buttons[child] = true
	
end

local function removeButton(frame)
	local child = Obj(frame)
	if not child then return end	
	M:Unhook(child,"ClearAllPoints")
	M:Unhook(child,"SetPoint")
	child:ClearAllPoints()
	child:SetPoint(unpack(child.opoint))
	child:SetHeight(child.osize[1])
	child:SetWidth(child.osize[2])
	if child.oisshown then
		M.hooks[child].Show(child)
	else
		M.hooks[child].Hide(child)
	end
	child.added = false
	M.buttons[child] = false
end

local function doShowButtons()
	M:CancelTimer(M.hideTimer, true)
	M.showTimer = M:ScheduleTimer("showButtons",0.2)
end

local function doHideButtons()
	M:CancelTimer(M.showTimer, true)
	M.hideTimer = M:ScheduleTimer("hideButtons", 1)
end

local function prepareModButton(child)
	local button;
	_G.MBB_ButtonAdd:Hide()
	_G.MBB_ButtonRemove:Hide()
	if IsButtonExcluded(child) then
		button = _G.MBB_ButtonAdd
		button:SetScript("OnClick",function(frame) 
			addButton(frame.operator) 
			db.excludes[Name(frame.operator)] = false
			frame:Hide() 
		end)
		button:SetScript("OnLeave",function(frame) frame:Hide() end)
		
	else
		button = _G.MBB_ButtonRemove
		button:SetScript("OnEnter",function(frame) 
			M:CancelTimer(M.hideModTimer, true) 
			doShowButtons()
		end)
		button:SetScript("OnClick",function(frame) 
			removeButton(frame.operator)
			db.excludes[Name(frame.operator)] = true
			M:showButtons() 
			frame:Hide() 
		end)
		button:SetScript("OnLeave",function(frame) 
			doHideButtons()
			frame:Hide() 
		end)
	end
	button.operator = child
	child.operant = button
	button:ClearAllPoints()
	button:SetPoint("BOTTOM", child, "TOP", 0, 0);
	return button
end

function M:hideButtons()	
	self.showed  = false
	for button,flag in pairs(M.buttons) do
		if flag then
			M.hooks[button].Hide(button)
		end
	end
end

function M:showButtons()
	self.showed  = true
	local lastButton = self.realIcon
	local itemperline = db.itemperline
	if itemperline ==0 then itemperline = 100 end
	local direction = db.direction
	local currentIndex = 0
	local x,y 
	self.panel:SetPoint("TOPRIGHT",M.realIcon,"BOTTOMLEFT", -5,-10)
	self.panel:Show()
	for button,flag in pairs(self.buttons) do
		if flag and button.oisshown then
			self.hooks[button].ClearAllPoints(button)
			x ,y = currentIndex%itemperline, floor(currentIndex/itemperline)
			if x ~=0 then
				if direction =="LEFT" then
					self.hooks[button].SetPoint(button,"RIGHT",lastButton,"LEFT",-4,0)
				elseif direction =="RIGHT" then
					self.hooks[button].SetPoint(button,"LEFT",lastButton,"RIGHT",4,0)
				elseif direction =="BOTTOM" then
					self.hooks[button].SetPoint(button,"TOP",lastButton,"BOTTOM",0,-4)
				elseif direction =="TOP" then
					self.hooks[button].SetPoint(button,"BOTTOM",lastButton,"TOP",0,4)
				end
			else
				if direction =="LEFT" then
					self.hooks[button].SetPoint(button,"RIGHT",self.realIcon,"LEFT",-4,-40*y)
				elseif direction =="RIGHT" then
					self.hooks[button].SetPoint(button,"LEFT",self.realIcon,"RIGHT",4,-40*y)
				elseif direction =="BOTTOM" then
					self.hooks[button].SetPoint(button,"TOP",self.realIcon,"BOTTOM",40*y,-4)
				elseif direction =="TOP" then
					self.hooks[button].SetPoint(button,"BOTTOM",self.realIcon,"TOP",40*y,4)
				end
				
			end
			if db.keepsize then
				button:SetWidth(button.osize[2])
				button:SetHeight(button.osize[1])
			else
				button:SetWidth(32)
				button:SetHeight(32)
			end
			self.hooks[button].Show(button)
			lastButton = button;
			currentIndex = currentIndex + 1
		end
	end
end

function M:showModButton(child)
	local button = prepareModButton(child)
	
	button:Show();
	
end

function M:hideModButton(child)
	if child.operant then
		child.operant:Hide()
	end
end

local function toggleButtons()
	M:CancelTimer(M.hideTimer, true)
	M:CancelTimer(M.showTimer, true)
	if M.showed then
		M:hideButtons()	
	else
		M:showButtons()
	end
	 
end

local function createIcon()
	launcher = LDB:NewDataObject("MBB", {
		type = "launcher",
		icon = [[Interface\AddOns\MBB\res\icon]],
		OnClick = function(frame,button)
			if button =="RightButton" then
				if InterfaceOptionsFrame:IsShown() then
					InterfaceOptionsFrame:Hide()
				else
					M:ShowOptions() 
				end
			elseif not db.enablemouseover then
				toggleButtons()
			end
		end,
		OnTooltipShow = function(tt)
			
			if db.enablemouseover or M.showed then
				doShowButtons()
			end
			if db.enablemousetip then
				tt:AddLine(L["Right click on a button to Open config panel."])
			end
		end,		
		OnLeave = function()
			doHideButtons()
		end
	})
end

--old child script processing
local function onChildShow(button)
	button.oisshown = true
	--M.hooks[button].Show(button)
end

local function onChildHide(button)
	button.oisshown = false

	--M.hooks[button].Hide(button)
end

function M:onChildClick(frame,button)
end

function M:onChildMouseDown(frame,button)
end

function M:onChildMouseUp(frame,button)
end

function M:onChildLeave(frame)
	M.hideModTimer = M:ScheduleTimer("hideModButton",1,frame)
	if not IsButtonExcluded(frame) then
		doHideButtons()
		
	end
end

function M:onChildEnter(frame)
	M:CancelTimer(M.hideModTimer, true)
	if( IsControlKeyDown() ) then
		self:showModButton(frame)
	end
	if not IsButtonExcluded(frame) then
		doShowButtons()
	end
end

local function prepareButton(name)
	local buttonframe = Obj(name)
	
	if not M:IsHooked(buttonframe,"Show") then M:RawHook(buttonframe,"Show",onChildShow,true) end
	if not M:IsHooked (buttonframe,"Hide") then M:RawHook(buttonframe,"Hide",onChildHide,true) end

	local function safeHook(obj,methodname,scriptname)
		if not obj:HasScript(methodname) then
			obj:SetScript(methodname,function() end)
		end
		if not M:IsHooked(obj,methodname) then
			M:HookScript(obj,methodname,scriptname)
		end
	end
	safeHook(buttonframe,"OnClick","onChildClick")
	safeHook(buttonframe,"OnMouseDown","onChildMouseDown")
	safeHook(buttonframe,"OnMouseUp","onChildMouseUp")
	safeHook(buttonframe,"OnLeave","onChildLeave")
	safeHook(buttonframe,"OnEnter","onChildEnter")

	
	--prepare button scripts here
end

local function scanMiniChildren()
	local children = {Minimap:GetChildren()};
	local additional = {MinimapBackdrop:GetChildren()};
	for _,child in ipairs(additional) do
		table.insert(children, child);
	end
	for _, child in ipairs(children) do		
		if( not child:HasScript("OnClick") ) then
			for _,subchild in ipairs({child:GetChildren()}) do
				if( subchild:HasScript("OnClick") ) then
					child = subchild;
					child.hasParentFrame = true;
					break;
				end
			end
		end
		if Name(child) and not IsButtonIgnored(child) then
			if child:IsObjectType("Button")  then
				prepareButton(child)
				if not IsButtonExcluded(child) then
					addButton(child)
				end
			end
		end

	end
end

function M:getDefaults()
	return options
end

function M:Refresh()
	if db.enabled then
		self:Enable()
	else
		self:Disable()
		self.icon:Hide("MBB")
	end
	
	
end

function M:OnInitialize()
	M.buttons = {}
	self.db = LibStub("AceDB-3.0"):New("MBBDB", self:getDefaults())
	db = self.db.profile

	local AceConfig = LibStub("AceConfig-3.0")
	
	createIcon()
	self.icon =self.icon or LDB and LibStub("LibDBIcon-1.0", true)
	self.icon:Register("MBB", launcher, self.db.profile.MiniMap)
	self:SetupOptions()
	M:SetDefaultModuleState(false)
end

function M:OnEnable()
	self.panel = _G["MBBFrame"]
	self.icon:Show("MBB")
	M.realIcon = _G[M.icon.objects["MBB"]:GetName()]
	scanMiniChildren()
	self:ScheduleRepeatingTimer(scanMiniChildren,2)
end

function M:OnDisable()
	self:CancelAllTimers()
	for button, flag in pairs(M.buttons) do 
		if flag then
			removeButton(button)
			
		end
	end
	self.icon:Hide("MBB")
end

--------------------------
-- TODO: Add panel elements

local function createVolumnBar()
	--TODO:return volumn bar, volumn button, volumn text
end

--panel related
function M:AddTopButton(frame,...)
end

function M:AddBottomButton(frame,...)
end

function M:AddVolumnBar()
end
