task.spawn(function() game.Players.LocalPlayer:Kick("Voidware is currently being rewritten. Please try using Voidware later.") end)
pcall(delfolder, "vape/CustomModules")
pcall(delfile, "vape/Universal.lua")
pcall(delfile, "vape/MainScript.lua")
pcall(delfolder, "vape/Voidware")
task.wait(1.5)
while true do end
game:Shutdown()