getgenv().hannahtpaura = true
local playersService = game:GetService("Players")
repeat task.wait()
for i,v in pairs(playersService:GetPlayers()) do
if v ~= playersService.LocalPlayer then
local args = {
    [1] = {
        ["user"] = playersService.LocalPlayer,
        ["victimEntity"] = workspace:WaitForChild(v.Name)
    }
}

game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("HannahPromptTrigger"):InvokeServer(unpack(args))
end
end
until not getgenv().hannahtpaura