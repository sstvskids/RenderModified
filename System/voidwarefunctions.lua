local VoidwareFunctions = {WhitelistLoaded = false, whitelistTable = {}, localWhitelist = {}, whitelistSuccess = false, playerWhitelists = {}, playerTags = {}, entityTable = {}}
local VoidwareLibraries = {}
local VoidwareConnections = {}
local players = game:GetService("Players")
local httpService = game:GetService("HttpService")
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local lplr = players.LocalPlayer
local GuiLibrary = shared.GuiLibrary
local rankTable = {DEFAULT = 0, STANDARD = 1, BETA = 1.5, INF = 2, OWNER = 3}

local isfile = isfile or function(file)
    local success, filecontents = pcall(function() return readfile(file) end)
    return success and type(filecontents) == "string"
end

local function errorNotification(title, text, duration)
    pcall(function()
         local notification = GuiLibrary.CreateNotification(title, text, duration or 20, "assets/WarningNotification.png")
         notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
         notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    end)
end

function VoidwareFunctions:CreateLocalDirectory(directory)
    local lastsplit = nil
    directory = directory or "vape/Voidware"
    for i,v in directory:split("/") do
        v = lastsplit and lastsplit.."/"..v or v 
        if not isfolder(v) then 
            makefolder(v)
            lastsplit = v
        end
    end
    return directory
end

function VoidwareFunctions:FindGithubCommit(repo, custom)
    repo = repo or "Voidware"
    custom = custom or "SystemXVoid"
    local success, response = pcall(function() return game:HttpGet("https://github.com/"..custom.."/"..repo, true) end)
    if success then 
        for i,v in response:split("\n") do 
            if v:find("commit") and v:find("fragment") then 
	            local commitgotten, commit = pcall(function() return v:split("/")[5]:sub(0, v:split("/")[5]:find('"') - 1) end)
                return commitgotten and commit or "main"
            end
        end
    end
    return "main"
end

local cachederrors = {}
function VoidwareFunctions:GetFile(file, onlineonly, custompath, customrepo)
    if not file or type(file) ~= "string" then 
        return ""
    end
    customrepo = customrepo or "Voidware"
    local filepath = (custompath and custompath.."/"..file or "vape/Voidware").."/"..file
    if not isfile(filepath) or onlineonly then 
        local voidwarecommit = VoidwareFunctions:FindGithubCommit(customrepo)
        local success, body = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/"..customrepo.."/"..voidwarecommit.."/"..file, true) end)
        if success and body ~= "404: Not Found" and body ~= "400: Invalid request" then 
            local directory = VoidwareFunctions:CreateLocalDirectory(custompath or "vape/Voidware")
            body = file:sub(#file - 3, #file) == ".lua" and body:sub(1, 35) ~= "Voidware Custom Vape Signed File" and "-- Voidware Custom Vape Signed File /n"..body or body
            if not onlineonly then 
                writefile(directory.."/"..file, body)
            end
            return body
        else
            task.spawn(error, "[Voidware] Failed to Download "..filepath..(body and " | "..body or ""))
            if table.find(cachederrors, file) == nil then 
                errorNotification("Voidware", "Failed to Download "..filepath..(body and " | "..body or ""), 30)
                table.insert(cachederrors, file)
            end
        end
    end
    return isfile(filepath) and readfile(filepath) or ""
end

local function playerfromID(id) -- players:GetPlayerFromUserId() didn't work for some reason :bruh:
    for i,v in players:GetPlayers() do 
        if v.UserId == id then 
            return v 
        end
    end
    return nil
end

function VoidwareFunctions:CreateWhitelistTable()
    local success, whitelistTable = pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("maintab.json", true, nil, "whitelist")) end)
    if success and type(whitelistTable) == "table" then 
        VoidwareFunctions.whitelistTable = whitelistTable
        for i,v in whitelistTable do 
            if i == HWID:split("-")[5] then 
                VoidwareFunctions.localWhitelist = v
                VoidwareFunctions.localWhitelist.HWID = i 
                VoidwareFunctions.localWhitelist.Priority = rankTable[v.Rank:upper()] or 1
                break
            end
        end
    end
    for i,v in whitelistTable do 
        for i2, v2 in v.Accounts do 
            local player = playerfromID(tonumber(v2))
            if player then 
                VoidwareFunctions.playerWhitelists[v2] = v
                VoidwareFunctions.playerWhitelists[v2].HWID = i 
                VoidwareFunctions.playerWhitelists[v2].Priority = rankTable[v.Rank:upper()] or 1
                if VoidwareFunctions:GetPlayerType(3) >= VoidwareFunctions:GetPlayerType(3, player) then
                    VoidwareFunctions.playerWhitelists[v2].Attackable = true
                end
                if not v.TagHidden then 
                    VoidwareFunctions:CreatePlayerTag(player, v.TagText, v.TagColor)
                end
            end
        end
        table.insert(VoidwareConnections, players.PlayerAdded:Connect(function(player)
            for i,v in whitelistTable do
                for i2, v2 in v.Accounts do 
                    if v2 == tostring(player.UserId) then 
                        VoidwareFunctions.playerWhitelists[v2] = v
                        VoidwareFunctions.playerWhitelists[v2].HWID = i 
                        VoidwareFunctions.playerWhitelists[v2].Priority = rankTable[v.Rank:upper()] or 1
                        if VoidwareFunctions:GetPlayerType(3) >= VoidwareFunctions:GetPlayerType(3, player) then
                            VoidwareFunctions.playerWhitelists[v2].Attackable = true
                        end
                    end
                end 
            end
         end))
    end
    return success
end

function VoidwareFunctions:GetPlayerType(position, plr)
    plr = plr or lplr
    local positionTable = {"Rank", "Attackable", "Priority", "TagText", "TagColor", "TagHidden", "UID", "HWID"}
    local defaultTab = {"DEFAULT", true, 1, "SPECIAL USER", "FFFFFF", true, 0, "ABCDEFGH"}
    local tab = VoidwareFunctions.playerWhitelists[tostring(plr.UserId)]
    if tab then 
        return tab[positionTable[tonumber(position or 1)]]
    end
    return defaultTab[tonumber(position or 1)]
end

function VoidwareFunctions:SpecialNearPosition(maxdistance, bypass)
    maxdistance = maxdistance or 30
    local specialtable = {}
    for i,v in players:GetPlayers() do 
        if v == lplr then 
            continue
        end
        if VoidwareFunctions:GetPlayerType(3, v) < 2 then 
            continue
        end
        if VoidwareFunctions:GetPlayerType(2, v) and not bypass then 
            continue
        end
        if not lplr.Character or not lplr.Character.PrimaryPart then 
            continue
        end 
        if not v.Character or not v.Character.PrimaryPart then 
            continue
        end
        local magnitude = (lplr.Character.PrimaryPart - v.Character.PrimaryPart).Magnitude
        if magnitude <= distance then 
            table.insert(specialtable, v)
        end
    end
    return #specialtable > 1 and specialtable or nil
end

function VoidwareFunctions:SpecialInGame()
    for i,v in players:GetPlayers() do 
        if v ~= lplr and VoidwareFunctions:GetPlayerType(3, v) > 1.5 then 
            return true
        end
    end 
    return false
end

task.spawn(function()
	repeat 
	for i,v in {"base64", "Hex2Color3"} do 
		task.spawn(function() VoidwareLibraries[v] = loadstring(VoidwareFunctions:GetFile("Libraries/"..v..".lua"))() end)
	end
	task.wait(3)
	until getgenv().VoidwareFunctions == nil
end)

function VoidwareFunctions:RunFromLibrary(tablename, func, argstable)
	if VoidwareLibraries[tablename] == nil then repeat task.wait() until VoidwareLibraries[tablename] and type(VoidwareLibraries[tablename]) == "table" end 
	return VoidwareLibraries[tablename][func](argstable and type(argstable) == "table" and table.unpack(argstable) or argstable or "nil")
end

function VoidwareFunctions:CreatePlayerTag(plr, text, color)
    plr = plr or lplr 
    VoidwareFunctions.playerTags[plr] = {}
    VoidwareFunctions.playerTags[plr].Text = text 
    VoidwareFunctions.playerTags[plr].Color = color 
    return VoidwareFunctions.playerTags[plr]
end

local loadtime = 0

task.spawn(function()
    repeat task.wait() until shared.VapeFullyLoaded
    loadtime = tick()
end)

pcall(function()
    GuiLibrary.SelfDestructEvent.Event:Connect(function()
        getgenv().VoidwareFunctions = nil
        for i,v in VoidwareConnections do 
            pcall(function() v:Disconnect() end)
        end
    end)
end)

function VoidwareFunctions:LoadTime()
    return loadtime ~= 0 and (tick() - loadtime) or 0
end

function VoidwareFunctions:AddEntity(ent)
    local tabpos = (#VoidwareFunctions.entityTable + 1)
    table.insert(VoidwareFunctions.entityTable, {Name = v.Name, DisplayName = v.Name, Character = v})
    return tabpos
end

function VoidwareFunctions:RemoveEntity(position)
    local entTable = VoidwareFunctions.entityTable[position]
    if entTable then 
        table.remove(VoidwareFunctions.entityTable, entTable)
        return true
    end
    return nil
end

task.spawn(function() -- poop code lol
    for i,v in workspace:GetChildren() do 
        if players:FindFirstChild(v.Name) then 
            continue
        end
        if v:FindFirstChildWhichIsA("Humanoid") and v.PrimaryPart and v:FindFirstChild("Head") then 
            local pos = VoidwareFunctions:AddEntity(v)
            task.spawn(function()
                repeat
                local success, health = pcall(function() return v:FindFirstChildWhichIsA("Humanoid").Health end)
                local alivecheck = v:FindFirstChildWhichIsA("Humanoid") and v.PrimaryPart and v:FindFirstChild("Head") and (success and health <= 0 or not success and true)
                if not alivecheck then 
                    VoidwareFunctions:RemoveEntity(pos)
                    return
                end
                task.wait()
                until getgenv().VoidwareFunctions == nil
            end)
        end
    end
    table.insert(VoidwareConnections, workspace.ChildAdded:Connect(function(v)
        if players:FindFirstChild(v.Name) then 
            return 
        end
        if v:FindFirstChildWhichIsA("Humanoid") and v.PrimaryPart and v:FindFirstChild("Head") then 
            local pos = VoidwareFunctions:AddEntity(v)
            task.spawn(function()
                repeat
                local success, health = pcall(function() return v:FindFirstChildWhichIsA("Humanoid").Health end)
                local alivecheck = v:FindFirstChildWhichIsA("Humanoid") and v.PrimaryPart and v:FindFirstChild("Head") and (success and health <= 0 or not success and true)
                if not alivecheck then 
                    VoidwareFunctions:RemoveEntity(pos)
                    return
                end
                task.wait()
                until getgenv().VoidwareFunctions == nil
            end)
        end
    end))
end)

task.spawn(function()
    local whitelistsuccess = VoidwareFunctions:CreateWhitelistTable()
    VoidwareFunctions.whitelistSuccess = whitelistsuccess
    VoidwareFunctions.WhitelistLoaded = true
    if not whitelistsuccess then 
        errorNotification("Voidware", "Failed to create the whitelist table.", 10)
    end
end)

getgenv().VoidwareFunctions = VoidwareFunctions

return VoidwareFunctions