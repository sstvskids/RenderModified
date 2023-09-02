-- This AntiLogger should prevent most of the skids from logging you
repeat task.wait() until game:IsLoaded()
local httpService = game:GetService("HttpService")
local writefile = writefile or function() return "shit exploit" end 
local delfile = delfile or function() return "shit exploit" end 
local isfile = isfile or function(file) local file, data = pcall(function() return readfile(file) end) return file and data end
local identifyexecutor = identifyexecutor or function() return "Unknown" end
local httprequest = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function() return "shit exploit" end 
local place = "Unknown"
local protectionlog = true -- writes a log file whenever a threat has been stopped
local whitelistedlinks = {"github.com/", "pastebin.com/", "voidwareclient.xyz/", "luarmor.net/", "controlc.com/", "raw.githubusercontent.com/", "roblox.com"} -- add urls to ignore here. should look like this {"url1", "url2"}
if shared.AntiLogger == true then return end
shared.AntiLogger = true

task.spawn(function()
    place = game.MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

local function notificationFunction(title, text, duration)
    local suc = pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title or "AntiLogger",
            Text = text or "Successfully called function",
            Duration = duration or 7,
        })
    end)
    return suc
end

if hookfunction == nil or hookmetamethod == nil then 
    task.spawn(notificationFunction, "AntiLogger", "Failed to load, your exploit isn't supported. Try using another. Exploit: "..identifyexecutor(), 8)
    return
end

local function createlocalfilelog(url)
    if protectionlog then
        local filedata = (not isfile("quarantinedloggers.txt") or readfile("quarantinedloggers.txt") == "") and place.." - "..tostring(url) or readfile("quarantinedloggers.txt").."\n"..place.." - "..tostring(url)
        writefile("quarantinedloggers.txt", filedata)
    end
    return protectionlog
end

local safehttprequest = function() end
local safehttpPost = function() end
safehttprequest = hookfunction(httprequest, function(self) -- basic defense (blocks discord webhooks)
    if self and type(self) == "table" then 
        if self.Url then 
            local discord = string.split(tostring(self.Url), "discord.com/") or {}
            if #discord > 1 and not table.find(whitelistedlinks, tostring(self.Url)) and self.Method and self.Method == "POST" then
            local messagestring = "AntiLogger has stopped a discord webhook from tracking you."
            if protectionlog then 
                messagestring = messagestring.." A log file has been written to your workspace. (quarantinedloggers.txt)"
            end
            task.spawn(notificationFunction, "AntiLogger", messagestring, 15)
            task.spawn(createlocalfilelog, self.Url)
            return {Body = "Protected by SystemXVoid's AntiLogger. | .gg/voidware", StatusCode = 403, Headers = {}}
        end
        end
    end
    return safehttprequest(self)
end)

local oldhttpnamecall = function() end 
oldhttpnamecall = hookmetamethod(httpService, "__namecall", function(name, self, ...)
    local messagestring = "AntiLogger has stopped a discord webhook from tracking you."
    if protectionlog then 
        messagestring = messagestring.." A log file has been written to your workspace. (quarantinedloggers.txt)"
    end
    local callmethod = getnamecallmethod()
    if callmethod == "PostAsync" then 
        local discord = string.split(tostring(self), "discord.com/") or {}
        if #discord > 1 and not table.find(whitelistedlinks, tostring(self)) then
            task.spawn(notificationFunction, "AntiLogger", messagestring, 15)
            task.spawn(createlocalfilelog, self)
            return nil
        end
    elseif callmethod == "CallAsync" then
        for i,v in pairs(whitelistedlinks) do
            if tostring(self):find(v) then
                return oldhttpget(name, self, ...)
            end
        end
        task.spawn(notificationFunction, "AntiLogger", messagestring, 15)
        task.spawn(createlocalfilelog, self)
        return 'print("Protected by SystemXVoids AntiLogger")'
    end
    return oldhttpnamecall(name, self, ...)
end)

local oldhttpget = function() end 
oldhttpget = hookmetamethod(game, "__namecall", function(name, self, ...)
    local messagestring = "AntiLogger has stopped a suspicious url from tracking you."
    if protectionlog then 
        messagestring = messagestring.." A log file has been written to your workspace. (quarantinedloggers.txt)"
    end
    local callmethod = getnamecallmethod()
    if callmethod == "HttpGet" then
        for i,v in pairs(whitelistedlinks) do
            if tostring(self):find(v) then
                return oldhttpget(name, self, ...)
            end
        end
        task.spawn(notificationFunction, "AntiLogger", messagestring, 15)
        task.spawn(createlocalfilelog, self)
        return 'print("Protected by SystemXVoids AntiLogger")'
    end
    return oldhttpget(name, self, ...)
end)

warn("[AntiLogger] HTTP functions hooked! You are now protected.")