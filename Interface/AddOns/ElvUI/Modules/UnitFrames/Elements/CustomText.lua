local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local UF = E:GetModule("UnitFrames")

--Lua functions
local pairs = pairs
--WoW API / Variables

function UF:Configure_CustomTexts(frame)
	local db = frame.db

	--Make sure CustomTexts are hidden if they don't exist in current profile
	for objectName, object in pairs(frame.customTexts) do
		if (not db.customTexts) or (db.customTexts and not db.customTexts[objectName]) then
			object:Hide()
			frame.customTexts[objectName] = nil
		end
	end

	if db.customTexts then
		local customFont = UF.LSM:Fetch("font", UF.db.font)
		for objectName, _ in pairs(db.customTexts) do
			if not frame.customTexts[objectName] then
				frame.customTexts[objectName] = frame.RaisedElementParent:CreateFontString(nil, "OVERLAY")
			end

			local objectDB = db.customTexts[objectName]

			if objectDB.font then
				customFont = UF.LSM:Fetch("font", objectDB.font)
			end

			local attachPoint = self:GetObjectAnchorPoint(frame, objectDB.attachTextTo)
			frame.customTexts[objectName]:FontTemplate(customFont, objectDB.size or UF.db.fontSize, objectDB.fontOutline or UF.db.fontOutline)
			frame.customTexts[objectName]:SetJustifyH(objectDB.justifyH or "CENTER")
			frame.customTexts[objectName]:ClearAllPoints()
			frame.customTexts[objectName]:Point(objectDB.justifyH or "CENTER", attachPoint, objectDB.justifyH or "CENTER", objectDB.xOffset, objectDB.yOffset)

			--This takes care of custom texts that were added before the enable option was added.
			if objectDB.enable == nil then
				objectDB.enable = true
			end

			if objectDB.enable then
				frame:Tag(frame.customTexts[objectName], objectDB.text_format or "")
				frame.customTexts[objectName]:Show()
			else
				frame:Untag(frame.customTexts[objectName])
				frame.customTexts[objectName]:Hide()
			end
		end
	end
end