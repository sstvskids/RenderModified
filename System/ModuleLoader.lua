local isfile = isfile or function(file)
    return pcall(function() return readfile(file) end)
end

local function errorNotification(title, text, duration) 
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
end

local function GetVoidwareFile()
    if not isfile("vape/CustomModules/placeID.lua") then 
        local success, body = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/System/placename.lua") end)
        if success and body ~= "404: Not Found" and body ~= "400: Invalid Request" then 
            pcall(writefile, "vape/CustomModules/placeID.lua", body)
            return body
        end
        return ""
    end
    return readfile("vape/CustomModules/placeID.lua")
end

if not shared.VapeFullyLoaded then 
    if pcall(function() loadstring(GetVoidwareFile())() end) then 
        shared.CustomSaveVape = placeID
    else
        errorNotification("Voidware", "Failed to load custom vape for placename.", 10)
    end
end