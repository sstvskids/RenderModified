local gamesupported = false
local gametable = {
    bedwars = {
        placeinfo = (#game:GetService("CollectionService"):GetTagged("block") > 1 or #game:GetService("CollectionService"):GetTagged("bed") > 1 or tonumber(game.PlaceId) == 8444591321 or tonumber(game.PlaceId) == 8560631822) and tonumber(game.PlaceId) ~= 6872265039 or false,
        module = "Bedwars"
    },
    skywars = {
        placeinfo = tonumber(game.PlaceId) == 855499080,
        module = "Skywars"
    }
}
for i,v in pairs(gametable) do 
    if v.placeinfo then 
        gamesupported = v.module
        break
    end
end

assert(gamesupported, "[Voidware Trial] - Game not supported.")

local successful, response = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/System/Trial/Modules/"..gamesupported..".lua", true) end)
if successful == false or response == "400: Invalid Request" or response == "404: Not Found" then 
    response = response or "Unknown Error"
    error("[Voidware Trial] - Failed to load custom modules for "..gamesupported..". | "..response)
end

return pcall(function() loadstring(response)() end)