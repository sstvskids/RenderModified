local isfile = isfile or pcall(function() return readfile(file) end)
local vapeAssert = function(argument, title, text, duration, hault, moduledisable, module) 
	if not argument then
    local suc, res = pcall(function()
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    end)
    if hault then 
        while true do task.wait() end end
    end
end

local function GetVoidwareFile(path, online)
    if not isfile("vape/CustomModules/"..path) and not online then 
        local success, bodydata = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/"..path) end)
        if success and bodydata ~= "404: Not Found" and bodydata ~= "400: Invalid Request" then 
            writefile("vape/CustomModules/"..path, bodydata)
            return "-- Voidware Custom Modules Signed File \n"..bodydata
        else
            bodydata = bodydata and " | "..bodydata or ""
            return 'error("[Voidware] Failed to load vape/CustomModules/gameplace.lua'..bodydata..'"'
        end
    end
    return online and ({pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/"..path) end)})[2] or readfile("vape/CustomModules/gameplace.lua")
end

if not shared.VapeFullyLoaded then 
    if pcall(function() loadstring(GetVoidwareFile("gameplace.lua"))() end) then
        shared.CustomSaveVape = file 
        else
        shared.CustomSaveVape = nil
        vapeAssert(false, "Voidware", "Failed to initiate vape/CustomModules/gameplace.lua", 10)
    end
end

return function(file) 
    file = file or game.PlaceId 
    local filepath = "vape/CustomModules/"..tostring(file)..".lua"
    if not isfile(filepath) then 
        print("writing placename")
        return pcall(writefile, filepath, GetVoidwareFile("System/placename.lua"))
    end
    return true
end 