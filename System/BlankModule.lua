--[[
    Remember not to Add built in vape modules to this config. Doing so may result in crashes/corrupted settings.
    https://github.com/7GrandDadPGN/VapeV4ForRoblox/wiki/Documentation -- Documentation on how you could create modules,
    Don't add th stuff in getting started, I've already setted everything up on that.
]]
local GuiLibrary = shared.GuiLibrary
local playersService = game:GetService("Players")
local textService = game:GetService("TextService")
local lightingService = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local inputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local collectionService = game:GetService("CollectionService")
local replicatedStorageService = game:GetService("ReplicatedStorage")
local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local vapeConnections = {}
local vapeCachedAssets = {}
local vapeEvents = setmetatable({}, {
	__index = function(self, index)
		self[index] = Instance.new("BindableEvent")
		return self[index]
	end
})
local vapeTargetInfo = shared.VapeTargetInfo
local vapeInjected = true

table.insert(vapeConnections, GuiLibrary.SelfDestructEvent.Event:Connect(function()
    vapeInjected = false
end))

-- start skidding/coding here