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
            writefile("vape/CustomModules/"..file, bodydata)
        else
            bodydata = bodydata and " | "..bodydata or ""
            vapeAssert(false, "Voidware", "Failed to load vape/CustomModules/"..file..""..bodydata)
            return 'warn([Voidware] Failed to load vape/CustomModules/'..file..''..bodydata
        end
    end
    return online and ({pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/"..path) end)})[2] or readfile("vape/CustomModules/"..path)
end

return function(file) 
    file = file or game.PlaceId 
    if pcall(function() loadstring(GetVoidwareFile(tostring(file).."lua"))() end) then
        shared.CustomSaveVape = file 
        else
        shared.CustomSaveVape = nil
        vapeAssert(false, "Voidware", "Failed to initiate vape/CustomModules/"..tostring(file)..".lua")
    end
end