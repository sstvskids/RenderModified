local isfile = isfile or function(file)
    return pcall(function() return readfile(file) end)
end

local function errorNotification(title, text, duration) 
    local notification = shared.GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
end

if isfile("vape/CustomModules/placeID.lua") and not shared.VapeFullyLoaded then 
    if pcall(function() loadstring(readfile("vape/CustomModules/placeID.lua"))() end) then 
        shared.CustomSaveVape = placeID
    else
        errorNotification("Voidware", "Failed to load custom vape for placename.", 10)
    end
end