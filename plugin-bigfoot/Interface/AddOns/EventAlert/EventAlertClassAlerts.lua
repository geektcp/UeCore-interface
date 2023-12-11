function Class_Events_OnLoad()
    UIPanelWindows["Class_Events_Frame"] = {area = "center", pushable = 0};

	Class_Events_Frame_EditBox:SetFontObject(ChatFontNormal);
	Class_Events_Frame_EditBox:SetText("http://www.wowhead.com/?spell=SPELLIDHERE")
end


function pairsByKeys (t, f)
	local a = {}
		for n in pairs(t) do table.insert(a, n) end
		table.sort(a, f)
		local i = 0      -- iterator variable
		local iter = function ()   -- iterator function
			i = i + 1
			if a[i] == nil then return nil
			else return a[i], t[a[i]]
			end
		end
	return iter
end





function Class_Events_Frame_MouseDown(button)
    if button == "LeftButton" then
        Class_Events_Frame:StartMoving();
    end
end

function Class_Events_Frame_MouseUp(button)
    if button == "LeftButton" then
        Class_Events_Frame:StopMovingOrSizing();
    end
end