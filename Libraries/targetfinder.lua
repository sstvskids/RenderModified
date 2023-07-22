-- most of the variable names are from vape, cause I'm just so used to it :)
local collectionService = game:GetService("CollectionService")
local replicatedStorageService = game:GetService("ReplicatedStorage")
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local VoidwareFunctions = shared.VoidwareFunctions -- messing with this will result in a blacklist.

local function isAlive(plr)
	plr = plr or lplr
	local charloaded, res = pcall(function()
		return plr and plr.Character and plr.Character.PrimaryPart and plr.Character.Humanoid and plr.Character.HumanoidRootPart and plr.Character.Head and plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and plr.Character.Humanoid.Health > 0
	end)
	return charloaded and res
end

local GetTarget = function(dist, raycastTab, otherentities)
local maxdistance = dist or math.huge
local entity = {}
for i,v in pairs(playersService:GetPlayers()) do
if v ~= lplr and ({VoidwareFunctions:GetPlayerType(v)})[2] and ({VoidwareFunctions:GetPlayerType(v)})[2] and v.Character and v.Team ~= lplr.Team and isAlive(v) and lplr.Character and lplr.Character.PrimaryPart and (raycastTab and workspace:Raycast(v.Character.PrimaryPart.Position, Vector3.new(0, -2000, 0), raycastTab) or not raycastTab) then
    local distance = math.floor(((lplr.Character.PrimaryPart.Position) - (v.Character.PrimaryPart.Position)).Magnitude)
    if distance < maxdistance then
        maxdistance = distance
        entity.Player = v
        entity.Human = true
        entity.Humanoid = v.Character.Humanoid
        entity.RootPart = v.Character.PrimaryPart
    end
end
end
if otherentities and shared.VoidwareStore and shared.VoidwareStore.ModuleType == "BedwarsMain" then
for i,v in pairs(collectionService:GetTagged("Drone")) do
    if v.PrimaryPart and v:GetAttribute("PlayerUserId") ~= tostring(lplr.UserId) and playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId")).Team ~= lplr.Team and isAlive() and (raycastTab and workspace:Raycast(v.PrimaryPart.Position, Vector3.new(0, -2000, 0), raycastTab) or not raycastTab) then
        local distance = math.floor(((lplr.Character.PrimaryPart.Position) - (v.PrimaryPart.Position)).Magnitude)
        if distance < maxdistance then
        maxdistance = distance
        entity.Human = false
        entity.Humanoid = v.Humanoid
        entity.RootPart = v.PrimaryPart
        entity.Player = {
            Name = "Drone",
            DisplayName = "Drone",
            UserId = 1,
            Character = v
        }
        end
    end
end
for i, v in pairs(collectionService:GetTagged("DiamondGuardian")) do
    if v.PrimaryPart and (raycastTab and workspace:Raycast(v.PrimaryPart.Position, Vector3.new(0, -2000, 0), raycastTab) or not raycastTab) then
        local distance = math.floor(((lplr.Character.PrimaryPart.Position) - (v.PrimaryPart.Position)).Magnitude)
        if distance < maxdistance then
        maxdistance = distance
        entity.Human = false
        entity.Humanoid = v.Humanoid
        entity.RootPart = v.PrimaryPart
        entity.Player = {
            Name = "DiamondGuardian",
            DisplayName = "DiamondGuardian",
            UserId = 1,
            Character = v
        }
        end
    end
end
for i, v in pairs(collectionService:GetTagged("Monster")) do
    if v.PrimaryPart and (v:GetAttribute("Team") ~= lplr:GetAttribute("Team")) and (raycastTab and workspace:Raycast(v.PrimaryPart.Position, Vector3.new(0, -2000, 0), raycastTab) or not raycastTab)  then
        local distance = math.floor(((lplr.Character.PrimaryPart.Position) - (v.PrimaryPart.Position)).Magnitude)
        if distance < maxdistance then
            maxdistance = distance
            entity.Player = v
            entity.Human = false
            entity.Humanoid = v.Humanoid
            entity.RootPart = v.PrimaryPart
            entity.Player = {
                Name = "Monster",
                DisplayName = "Monster",
                UserId = 1,
                Character = v
            }
        end
    end
end
for i, v in pairs(collectionService:GetTagged("GolemBoss")) do
    if v.PrimaryPart and (raycastTab and workspace:Raycast(v.PrimaryPart.Position, Vector3.new(0, -2000, 0), raycastTab) or not raycastTab) then
        local distance = math.floor(((lplr.Character.PrimaryPart.Position) - (v.PrimaryPart.Position)).Magnitude)
        if distance < maxdistance then
            maxdistance = distance
            entity.Player = v
            entity.Human = false
            entity.Humanoid = v.Humanoid
            entity.RootPart = v.PrimaryPart
            entity.Player = {
                Name = "Titan",
                DisplayName = "Titan",
                UserId = 1,
                Character = v
            }
        end
    end
end
end
return entity
end
return GetTarget