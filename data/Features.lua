local CurrentVer = "3.0"
local VoidwareFeatureVer = loadstring(game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/version/Normal", true))()
local VoidwareDownloadable = game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/data/FullModule.lua", true)
--- Useless features.
GuiLibrary["RemoveObject"]("PanicOptionsButton")
GuiLibrary["RemoveObject"]("MissileTPOptionsButton")
GuiLibrary["RemoveObject"]("SwimOptionsButton")
GuiLibrary["RemoveObject"]("AutoBalloonOptionsButton")
GuiLibrary["RemoveObject"]("XrayOptionsButton")
-- editied features
GuiLibrary["RemoveObject"]("AutoReportOptionsButton")
GuiLibrary["RemoveObject"]("GravityOptionsButton")
---

local function createnotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Thanks you for using Voidware"..lplr.Name.."!", delay or 6, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 0, 0)
		return frame
	end)
	return (suc and res)
end

local function InfoNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Thanks you for using Voidware"..lplr.Name.."!", delay or 5.6, "assets/InfoNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 255, 255)
		return frame
	end)
	return (suc and res)
end

local function CustomNotification(title, delay, text, icon, color)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Thanks you for using Voidware"..lplr.Name.."!", delay or 5.6, icon or "assets/InfoNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(color)
		return frame
	end)
	return (suc and res)
end

local function CreateChatTagData(name, player)
	local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local target = player or lplr.Name
		local ChatTag = {}
		ChatTag[target] =
			{
				TagText = name or "VOIDWARE USER",
				TagColor = Color3.new(1, 0.2, 0.0588235),
			}
			local oldchanneltab
			local oldchannelfunc
			local oldchanneltabs = {}
		for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
			if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
				oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
				oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
				getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
					local tab = oldchannelfunc(Self, Name)
					if tab and tab.AddMessageToChannel then
						local addmessage = tab.AddMessageToChannel
						if oldchanneltabs[tab] == nil then
							oldchanneltabs[tab] = tab.AddMessageToChannel
						end
						tab.AddMessageToChannel = function(Self2, MessageData)
							if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
								if ChatTag[Players[MessageData.FromSpeaker].Name] then
									MessageData.ExtraData = {
										NameColor = Players[MessageData.FromSpeaker].Team == nil and Color3.new(128,0,128)
											or Players[MessageData.FromSpeaker].TeamColor.Color,
										Tags = {
											table.unpack(MessageData.ExtraData.Tags),
											{
												TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
												TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
											},
										},
									}
								end
							end
							return addmessage(Self2, MessageData)
						end
					end
					return tab
				end
			end
		end
end

local oldambient = lightingService.Ambient
local oldsky = lightingService:WaitForChild("Sky")
local oldfogstart = lightingService.FogStart
local oldfogend = lightingService.FogEnd
local oldskybk = oldsky.SkyboxBk
local oldskydn = oldsky.SkyboxDn
local oldskyft = oldsky.SkyboxFt
local oldskylf = oldsky.SkyboxLf
local oldskyrt = oldsky.SkyboxRt
local oldskyup = oldsky.SkyboxUp
local oldfogcolor = lightingService.FogColor
local lighting = {["Enabled"] = false}
			lighting = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "Lighting",
				["HoverText"] = "ambients and skies",
				["Function"] = function(callback)
					if callback then
						task.spawn(function()
							task.wait(0.20)
							if lightingmode.Value == "Comet" then
							local cometmode = true
							lightingService.Ambient = Color3.fromRGB(170, 0, 255)
							local cometsky = Instance.new("Sky", lightingService)
							cometsky.Name = "CometSky"
							cometsky.SkyboxBk = "rbxassetid://8539982183"
							cometsky.SkyboxDn = "rbxassetid://8539981943"
							cometsky.SkyboxFt = "rbxassetid://8539981721"
							cometsky.SkyboxLf = "rbxassetid://8539981424"
							cometsky.SkyboxRt = "rbxassetid://8539980766"
							cometsky.SkyboxUp = "rbxassetid://8539981085"
							cometsky.MoonAngularSize = 0
							cometsky.SunAngularSize = 0
							cometsky.StarCount = 3e3
							elseif lightingmode.Value == "Space" then
						local spacemode = true
						local spacesky = Instance.new("Sky", lightingService)
						spacesky.Name = "SpaceSky"
						    spacesky.SkyboxBk = "rbxassetid://159454299"
							spacesky.SkyboxDn = "rbxassetid://159454296"
							spacesky.SkyboxFt = "rbxassetid://159454293"
							spacesky.SkyboxLf = "rbxassetid://159454293"
							spacesky.SkyboxRt = "rbxassetid://159454300"
							spacesky.SkyboxUp = "rbxassetid://159454288"
						lightingService.FogColor = Color3.new(236, 88, 241)
						lightingService.FogEnd = "200"
						lightingService.FogStart = "0"
						lightingService.Ambient = Color3.new(0.5, 0, 1)
							end
						end)
						if lightingmode.Value == "Blue" then
							local bluesky = Instance.new("Sky", lightingService)
							lightingService.Ambient = Color3.fromRGB(0, 0, 255)
							bluesky.Name = "BlueSky"
						    bluesky.SkyboxBk = "http://www.roblox.com/asset/?id=8434939"
							bluesky.SkyboxDn = "http://www.roblox.com/asset/?id=8434986"
							bluesky.SkyboxFt = "http://www.roblox.com/asset/?id=8434939"
							bluesky.SkyboxLf = "http://www.roblox.com/asset/?id=8434939"
							bluesky.SkyboxRt = "http://www.roblox.com/asset/?id=8434939"
							bluesky.SkyboxUp = "http://www.roblox.com/asset/?id=8435024"
							local bluemode = true
						end
					else
						if cometmode then
							lightingService.CometSky:Destroy()
						end
						if spacemode then
							lightingService.SpaceSky:Destroy()
						end
						if bluemode then
							lightingService.BlueSky:Destroy()
						end
						 local norm = Instance.new("Sky", lightingService)
						    norm.SkyboxBk = oldskybk
							norm.SkyboxDn = oldskydn
							norm.SkyboxFt = oldskyft
							norm.SkyboxLf = oldskylf
							norm.SkyboxRt = oldskyrt
							norm.SkyboxUp = oldskyup
						lightingService.FogColor = oldfogcolor
						lightingService.FogEnd = oldfogend
						lightingService.FogStart = oldfogstart
						lightingService.Ambient = oldambient
					end
				end
			})
			lightingmode = lighting.CreateDropdown({
				Name = "Lighting",
				List = {"Blue", "Comet", "Space"},
				Function = function() end
			})


		
			local ChatMover = {["Enabled"] = false}
			ChatMover = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "ChatMover",
				["HoverText"] = "Moves the chat to another position",
				["Function"] = function(callback)
					if callback then
						task.spawn(function()
							repeat task.wait() until game:IsLoaded()
						repeat task.wait()
						game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(ChatMoverPos1.Value, ChatMoverPos2.Value, ChatMoverPos3.Value, ChatMoverPos4.Value))
						until not ChatMover.Enabled
					end)
					else
						task.wait(1)
						game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0, 0, 0, 0))
					end
				end
			})
			ChatMoverPos1 = ChatMover.CreateSlider({
				Name = "Pos 1",
				Min = 0,
				Max = 1000, 
				Function = function() end,
				Default = 0
			})
			ChatMoverPos2 = ChatMover.CreateSlider({
				Name = "Pos 2",
				Min = 0,
				Max = 1000, 
				Function = function() end,
				Default = 0
			})
			ChatMoverPos3 = ChatMover.CreateSlider({
				Name = "Pos 3",
				Min = 0,
				Max = 1000, 
				Function = function() end,
				Default = 0.7
			})
			ChatMoverPos4 = ChatMover.CreateSlider({
				Name = "Pos 4",
				Min = 0,
				Max = 1000, 
				Function = function() end,
				Default = 0
			})
		
			local NoRoot = {["Enabled"] = false}
			NoRoot = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "RootDestroyer",
				["HoverText"] = "Destroys your HumanoidRootPart",
				["Function"] = function(callback)
					if callback then
						NoRoot["ToggleButton"](false)
						local char = lplr.Character
						local primary = char.PrimaryPart
						primary.Parent = nil
						char:MoveTo(char:GetPivot().p)
						task.wait()
						primary.Parent = char
						InfoNotification("RootDestroyer", "HumanoidRootPart destroyed! Reset your character to disable.", 3)
					end
				end
			})
		
			local InfYield = {["Enabled"] = false}
			InfYield = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "InfiniteYield",
				["HoverText"] = "Loads Indinite Yield by Edge",
				["Function"] = function(callback)
					if callback then
						task.spawn(function()
							loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))() 
						end)
					end
				end
			})
		
			local DoublesQueue = {["Enabled"] = false}
			DoublesQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "DoublesQueue",
				["HoverText"] = "Starts a queue for solos",
				["Function"] = function(callback)
					if callback then
						DoublesQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_to2",})
					end
				end
			})
		
			local SkywarsQueue = {["Enabled"] = false}
			SkywarsQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "SkywarsQueue",
				["HoverText"] = "Starts a queue for Skywars",
				["Function"] = function(callback)
					if callback then
						SkywarsQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "skywars_to2",})
					end
				end
			})
		
			local CustomMatches = {["Enabled"] = false}
			CustomMatches = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "QuickCustoms",
				["HoverText"] = "Starts a queue for sqauds",
				["Function"] = function(callback)
					if callback then
						CustomMatches["ToggleButton"](false)
							local args = {
								[1] = "CB33B7DA-2276-43AF-B17A-90315A0D617C",
								[2] = {
									[1] = "bedwars_to4",
									[2] = ""
								}
							}
							game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged:FindFirstChild("CustomMatches:CreateCustomMatch"):FireServer(unpack(args))				
			
							InfoNotification("QuickCustoms", "Creating the custom match... (Bedwars Sqauds)", 6)
							task.wait(6.88)
							InfoNotification("QuickCustoms", "Match Created. Joining..", 6)
					end
				end
			})
		

			local badval
			local old
			local Messages = {"Pow!","Thump!","Wham!","Hit!","Smack!","Bang!","Pop!","Boom!"}
			local Indicator = {["Enabled"] = false}
			Indicator = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "DamageIndicator",
				["HoverText"] = "a custom damage indicator.",
				["Function"] = function(callback)
					if callback then
						badval = I
						old = debug.getupvalue(bedwars["DamageIndicator"],10,{Create})
							debug.setupvalue(bedwars["DamageIndicator"],10,{
								Create = function(self,obj,...)
									spawn(function()
										pcall(function()
											if IndicatorMode.Value == "Default" and Indicator.Enabled then
											obj.Parent.TextColor3 =  Color3.fromRGB(0, 4, 255)
											end
											if IndicatorMode.Value == "Meteor" and Indicator.Enabled then
												obj.Parent.Text = Messages[math.random(1,#Messages)]
												obj.Parent.TextColor3 =  Color3.fromHSV(tick()%5/5,1,1)
											end
											if IndicatorMode.Value == "Custom" and Indicator.Enabled then 
												obj.Parent.TextColor3 =  Color3.fromHSV(CustomIndicatorColor.Hue, CustomIndicatorColor.Sat, CustomIndicatorColor.Value)
												if IndicatorMode.Value == "Custom" and CustomIndicatorTextToggle.Enabled and Indicator.Enabled then
													local CustomMessages = #CustomIndicatorText.ObjectList > 0 and CustomIndicatorText.ObjectList[math.random(1, #CustomIndicatorText.ObjectList)]
													if CustomMessages then
													obj.Parent.Text = CustomMessages
													else
														if IndicatorMode.Value == "Custom" and CustomIndicatorTextToggle.Enabled and Indicator.Enabled and not CustomMessages then
														obj.Parent.Text = "Voidware on top!"
														end
													end
												end
												if CustomIndicatorFontToggle.Enabled and Indicator.Enabled and IndicatorMode.Value == "Custom" then
													obj.Parent.Font = CustomIndicatorFont.Value
												end
											end
										end)
									end)
									return game:GetService("TweenService"):Create(obj,...)
								end
							})
						else
							debug.setupvalue(bedwars["DamageIndicator"],10,{
								Create = old
							})
							old = nil
					end
				end
			})
			local Font1 = {"SourceSans"}
			for i,v in pairs(Enum.Font:GetEnumItems()) do 
				if v.Name ~= "SourceSans" then 
					table.insert(Font1, v.Name)
				end
			end
			IndicatorMode = Indicator.CreateDropdown({
				Name = "Type",
				List = {"Default", "Meteor", "Custom"},
				Function = function() end
			})
			CustomIndicatorColor = Indicator.CreateColorSlider({
				Name = "Indicator Custom Color",
				Function = function(h, s, v)
					if Indicator.Enabled and IndicatorMode.Value == "Cool" then
						obj.Parent.TextColor3 = Color3.fromHSV(h, s, v)
					end
				end
			})
			CustomIndicatorTextToggle = Indicator.CreateToggle({
				Name = "Custom Text",
				Function = function(bv) end,
				Default = false,
				HoverText = "custom text messages for damage indicator."
			})
			CustomIndicatorFontToggle = Indicator.CreateToggle({
				Name = "Custom Font",
				Function = function(vb)  end,
				Default = false,
				HoverText = "custom font for damage indicator."
			})
			CustomIndicatorText = Indicator.CreateTextList({
				Name = "Indicator Text",
				TempText = "Custom indicator text",
			})
			CustomIndicatorFont = Indicator.CreateDropdown({
				Name = "Font",
				List = Font1,
				Function = function() end
			})

			
		
		runFunction(function()
			local PartyLeave = {["Enabled"] = false}
			PartyLeave = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "LeaveParty",
				["HoverText"] = "leaves the current party your in",
				["Function"] = function(callback)
					if callback then
						game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").leaveParty:FireServer()
							PartyLeave["ToggleButton"](false)
					end
				end
			})
		end)
		
			local LeaveQueue = {["Enabled"] = false}
			LeaveQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "LeaveQueue",
				["HoverText"] = "Forcefully leaves the current queue (useful if a queue errored)",
				["Function"] = function(callback)
					if callback then
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].leaveQueue:FireServer()
							LeaveQueue["ToggleButton"](false)
					end
				end
			})
		
			local RankedQueue = {["Enabled"] = false}
			RankedQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "RankedQueue",
				["HoverText"] = "Starts a queue for ranked",
				["Function"] = function(callback)
					if callback then
						RankedQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_ranked_s7",})
					end
				end
			})
		
			local DuelsQueue = {["Enabled"] = false}
			DuelsQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "DuelsQueue",
				["HoverText"] = "Starts a queue for duels",
				["Function"] = function(callback)
					if callback then
						DuelsQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_duels",})
					end
				end
			})
		
			local SolosQueue = {["Enabled"] = false}
			SolosQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "SolosQueue",
				["HoverText"] = "Starts a queue for solos",
				["Function"] = function(callback)
					if callback then
						SolosQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_to1",})
					end
				end
			})
		
			local SquadsQueue = {["Enabled"] = false}
			SquadsQueue = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "SquadsQueue",
				["HoverText"] = "Starts a queue for Squads",
				["Function"] = function(callback)
					if callback then
						SquadsQueue["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_to4",})
					end
				end
			})
		
			local bedwars_5v5 = {["Enabled"] = false}
			bedwars_5v5 = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "5v5Queue",
				["HoverText"] = "Starts a queue for 5v5",
				["Function"] = function(callback)
					if callback then
						bedwars_5v5["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_5v5",})
					end
				end
			})
		
			local bedwars_30v30 = {["Enabled"] = false}
			bedwars_30v30 = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "30v30Queue",
				["HoverText"] = "Starts a queue for 30v30",
				["Function"] = function(callback)
					if callback then
						bedwars_30v30["ToggleButton"](false)
						game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({    ["queueType"] = "bedwars_20v20",})
					end
				end
			})
		
		
			local confetti = {Enabled = false}
			confetti = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "Annoyer",
				Function = function(callback)
					if callback then 
						task.spawn(function()
							repeat 
								task.wait(confettispeed.Value)
								if not confetti.Enabled then return end 
								game:GetService("ReplicatedStorage"):WaitForChild("events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"):WaitForChild("useAbility"):FireServer("PARTY_POPPER")
							until (not confetti.Enabled)
						end)
					end
				end,
				HoverText = "Annoys others :trol:"
			})
			confettispeed = confetti.CreateSlider({
				Name = "Repeat Time",
				Min = 0.3,
				Max = 60,
				Function = function() end,
				Default = 0.3
			})
		
			local TexturePack = {Enabled = false}
			TexturePack = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "MinecraftTexturePack",
				Function = function(callback)
					if callback then
						task.spawn(function()
								if tpack then
									warningNotification("TexturePack","Rejoin required to retoggle.",5) 
									TexturePack.ToggleButton(false)
									return
								end
								loadstring(game:HttpGet(('https://raw.githubusercontent.com/SystemXVoid/VoidwareBConfig/main/data/minecraft.lua')))()
						end)
					else
						tpack = true
						warningNotification("MinecraftTexturePack","Disabled next game.",5)
			
					end
				end,
				HoverText = "gives you a minecraft texture pack"
			})

			local RedTexturePack = {Enabled = false}
			RedTexturePack = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "RedTexturePack",
				Function = function(callback)
					if callback then
						task.spawn(function()
								if tpack or TexturePack.Enabled then
									warningNotification("TexturePack","A Previous texture pack was already toggled. Please disable the previous and rejoin.",5) 
									RedTexturePack.ToggleButton(false)
									return
								end
								Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
									if v:FindFirstChild("Handle") then
										pcall(function()
											v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
											v:FindFirstChild("Handle").Material = Enum.Material.Neon
											v:FindFirstChild("Handle").TextureID = ""
											v:FindFirstChild("Handle").Color = Color3.fromRGB(196, 40, 28)
										end)
										local vname = string.lower(v.Name)
										if vname:find("sword") or vname:find("blade") then
											v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
										elseif vname:find("pick") then
											v:FindFirstChild("Handle").MeshId = "rbxassetid://12615822685"
										end
									end
								end)
						end)
					else
						tpack = true
						createnotification("TexturePack","Disabled next game.",5)
						Connection:Disconnect()
			
					end
				end,
				HoverText = "gives you a minecraft texture pack"
			})

		
			local Stats = {Enabled = false}
			Stats = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "MinecraftStats",
				Function = function(callback)
					if callback then
						task.spawn(function()
							loadstring(game:HttpGet("https://raw.githubusercontent.com/sstvskids/minecraft_easyggscoreboard/main/scoreboard"))()
						end)
					else
						game:GetService("CoreGui").BedWarsUI:Destroy()
					end
				end,
				HoverText = "sub to stavexploitz trollage"
			})

		
			local breathe = {Enabled = false}
			breathe = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "DragonBreathe",
				Function = function(callback)
					if callback then 
						task.spawn(function()
							repeat 
								task.wait(breathespeed.Value) 
								if not breathe.Enabled then return end
								game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("DragonBreath"):FireServer({player = game:GetService("Players").LocalPlayer})
							until (not breathe.Enabled)
						end)
					end
				end
			})
			breathespeed = breathe.CreateSlider({
				Name = "Repeat Time",
				Min = 0.3,
				Max = 60, 
				Function = function() end,
				Default = 0.3
			})
		
			local crasher = {Enabled = false}
			crasher = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "FPSLagShield",
				Function = function(callback)
					if callback then
						if not getItem("infernal_shield") then
							warningNotification("FPSLagShield","Infernal Shield not found.",5)
							crasher.ToggleButton(false)
							return
						end
						
						InfoNotification("FPSLagShield","Hold the shield in your hand. (DON'T PRESS IT DOWN)",5)
						task.spawn(function()
							repeat 
								task.wait()
									game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("UseInfernalShield"):FireServer({raised = true})
									game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("UseGlitchShield"):FireServer({raised = true})
							until (not crasher.Enabled)
						end)
					end
				end
			})
		
			local playagain = {Enabled = false}
			playagain = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "PlayAgain",
				Function = function(callback)
					if callback then
						playagain.ToggleButton(false)
						bedwars.LobbyClientEvents:joinQueue(bedwarsStore.queueType)
					end
				end
			})
		
			
			local KillAll = {Enabled = false}
			KillAll = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "TPAura",
				Function = function(callback)
					if callback then
					task.spawn(function()
						local bow = getBow()
			            local Humanoid = game.Players.LocalPlayer.Character.Humanoid
			            local OldHealth = Humanoid.Health
			            local Player = lplr
                        local Char = Player.Character
						local MousePosition = EntityNearMouse(1000)
						Char:WaitForChild("Humanoid").Died:Connect(function()
							if KillAll.Enabled then
							if dead then return end
							createnotification("TPAura","Died while teleporting.",7) dead = true task.wait(8) dead = false
							KillAll.ToggleButton(false)
							return
							end
                            end)
							
						if not bow and not getItem("snowball") and not dead then
							if dead then return end
							createnotification("TPAura","No Compatiable Projectile found. (Bow, Crossbow, Snowball)",7)
							KillAll.ToggleButton(false)
							return
						end
						if bow and not getItem("arrow") and not getItem("snowball") and not dead then
							if dead then return end
							KillAll.ToggleButton(false)
							createnotification("TPAura","Failed to toggle. Please restock on arrows, snowballs.",7)
							return
						end
						task.spawn(function()
							if camfreeze.Enabled then
								workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
							end
							
							Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
							if Humanoid.Health < OldHealth and KillAll.Enabled and not dead then
								if dead then return end
								if damage then return end
								createnotification("TPAura","Your taking damage! Its adviced you toggle off this module and check whos/what is damaging you.",7) damage = true task.wait(5) damage = false
							end
							OldHealth = Humanoid.Health
							end)
                              for i3,v10 in pairs(game.Players:GetPlayers()) do
								if v10.Character and v10.Character:FindFirstChild("HumanoidRootPart") then
									if v10.Team ~= lplr.Team then
										while v10 and v10.Character.Humanoid.Health > 0 and v10.Character.PrimaryPart do
											task.wait()
											if KillAll.Enabled and TPAuraMethod.Value == "Random" then
												if not getItem("arrow") and not getItem("snowball") and bow and not dead then if dead then return end KillAll.ToggleButton(false) createnotification("TPAura","Teleporting stopped. Please restock on arrows or snowballs to continue.",5) return end
											if lplr.Character ~= nil and lplr.Character:FindFirstChild'HumanoidRootPart' then lplr.Character.HumanoidRootPart.CFrame = v10.Character.HumanoidRootPart.CFrame end
											elseif KillAll.Enabled and TPAuraMethod.Value == "Mouse" then
												if not getItem("arrow") and not getItem("snowball") and bow and not dead then if dead then return end KillAll.ToggleButton(false) createnotification("TPAura","Teleporting stopped. Please restock on arrows or snowballs to continue.",5) return end
												repeat task.wait() until MousePosition
												if MousePosition and MousePosition.Humanoid.Health > 0 then
												lplr.Character.HumanoidRootPart.CFrame = MousePosition.RootPart.CFrame
												end
										end
										end
									end
								end
								end
					end)
					repeat task.wait() until bedwarsStore.matchState == 0
					KillAll.ToggleButton(false)
				end)
					else
						workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
						workspace.Gravity = 192
					end
				end,
				HoverText = "Teleports you to players and killing them. (requires a bow and arrow.)"
			})
			TPAuraMethod = KillAll.CreateDropdown({
				Name = "Method",
				List = {"Random", "Mouse"},
				Function = function() end
			})
			camfreeze = KillAll.CreateToggle({
				Name = "Camera",
				Function = function() end,
				Default = true,
				HoverText = "Stops your camera from moving during teleport"
			})
	
			local bubbleChatSettings
			local Chat = {Enabled = false}
			Chat = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "ChatBubble",
				Function = function(callback)
					if callback then
						task.spawn(function()
							repeat task.wait()
							local ChatService = game:GetService("Chat")
							bubbleChatSettings = {
								BackgroundColor3 = Color3.fromHSV(BubbleColor.Hue, BubbleColor.Sat, BubbleColor.Value),
								TextSize = 20,
								Font = Enum.Font.FredokaOne,
								BubbleDuration = BubbleDur.Value
							}
							ChatService:SetBubbleChatSettings(bubbleChatSettings)
						until not Chat.Enabled
						end)
					else
						task.wait(1)
						bubbleChatSettings = {
							BackgroundColor3 = Color3.fromHSV(255, 255, 255),
							TextSize = 20,
							Font = Enum.Font.GothamBold,
							BubbleDuration = 10
						}
						ChatService:SetBubbleChatSettings(bubbleChatSettings)
					end
				end,
				HoverText = "Customizable the bubble chat experience."
			})
			BubbleColor = Chat.CreateColorSlider({
				Name = "Bubble Color",
				Function = function(h, s, v)
					if BackgroundColor3 then
						BackgroundColor3.Color = Color3.fromHSV(h, s, v)
					end
				end
			})
			BubbleDur = Chat.CreateSlider({
				Name = "Bubble Duration",
				Min = 1,
				Max = 60,
				Function = function() end,
				Default = 10
			})
	
			local PartyInviteLoop = {Enabled = false}
			PartyInviteLoop = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "PartyInviteLoop",
				Function = function(callback)
					if callback then
						createnotification("PartyInviteLoop","Be aware that you can't play again with this feature. you have to lobby.",5)
						task.spawn(function()
							for i,v in pairs(game.Players:GetChildren()) do
								if v.Name == game.Players.LocalPlayer.Name then
									else
										local args = {[1] = {["player"] = v}}
										game:GetService("ReplicatedStorage"):FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events").inviteToParty:FireServer(unpack(args))
									end
								end
				
							for i,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
								if (v.Name:find("arty") or v.Name:find("otification"))and v:IsA("RemoteEvent") then
									for i2,v2 in pairs(getconnections(v.OnClientEvent)) do
										v2:Disable()
									end
								end
							end
				
							spawn(function()
								while PartyInviteLoop.Enabled do
									for i = 135, 9999999  do
									local args = {[1] = {["queueType"] = "bedwars_to1"}}
									wait()
									end
								end
							end)
						end)
					end
				end,
				HoverText = "sends everyone a party invite (you can control them in your matches with this lol)"
			})

			local hpbar = {Enabled = false}
			hpbar = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "CustomHealthbar",
				Function = function(callback)
					if callback then
						task.spawn(function()
							repeat task.wait() until game:IsLoaded()
							getgenv().loadchecked = true
							repeat task.wait(0.1)
								local healthbar = lplr.PlayerGui:WaitForChild("hotbar"):WaitForChild("1"):WaitForChild("HotbarHealthbarContainer"):WaitForChild("HealthbarProgressWrapper"):WaitForChild("1")
								if hpbar.Enabled and hotbarmode.Value =="Default" then
									healthbar.BackgroundColor3 = Color3.fromRGB(0, 4, 255)
								elseif hpbar.Enabled and hotbarmode.Value == "Custom" then
								healthbar.BackgroundColor3 = Color3.fromHSV(CustomHealthbarColor.Hue, CustomHealthbarColor.Sat, CustomHealthbarColor.Value)
								     counter = counter + 0.01
								elseif hpbar.Enabled and hotbarmode.Value == "Dynamic" then
									healthbar.BackgroundColor3 = Color3.fromHSV(math.clamp(entityLibrary.character.Humanoid.Health / entityLibrary.character.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1.5)
							end
							until not hpbar.Enabled
				end)
				else
					lplr.PlayerGui:WaitForChild("hotbar"):WaitForChild("1"):WaitForChild("HotbarHealthbarContainer"):WaitForChild("HealthbarProgressWrapper"):WaitForChild("1").BackgroundColor3 = Color3.fromRGB(203,54,36)
					end
				end,
				HoverText = "customize your hotbar."
			})
			hotbarmode = hpbar.CreateDropdown({
				Name = "Healthbar",
				List = {"Default", "Dynamic", "Custom"},
				Function = function() end
			})
			CustomHealthbarColor = hpbar.CreateColorSlider({
				Name = "Custom Color",
				Function = function(h, s, v)
					if hpbar.Enabled and hotbarmode.Value == "Cool" then
						obj.Parent.TextColor3 = Color3.fromHSV(h, s, v)
					end
				end
			})

	local flyjump = {["Enabled"] = false}
	flyjump = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
		["Name"] = "FlyJump",
		["HoverText"] = "Jump without touching ground",
		["Function"] = function(callback) 
			if callback then
				task.spawn(function()    
						game:GetService('RunService').RenderStepped:connect(function()
							game:GetService("UserInputService").JumpRequest:Connect(function()
								if flyjump.Enabled then
									game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
								end
							end)
						end)
					end)
				else
					if keycodeconnection then
						keycodeconnection:Disconnect()
					end
				end
			end
		})

			local Reinject = {["Enabled"] = false}
			Reinject = GuiLibrary["ObjectsThatCanBeSaved"]["CustomWindow"]["Api"].CreateOptionsButton({
				["Name"] = "BetterReinject",
				["HoverText"] = "an actual reinject button instead of those shitty ones",
				["Function"] = function(callback)
					if callback then
						Reinject["ToggleButton"](false)
						GuiLibrary["SelfDestruct"]()
						loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
					end
				end
			})

			local playertp = {Enabled = false}
			playertp = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "7BitchesExploit",
				Function = function(callback)
					if callback then
					task.spawn(function()
						if KillAll.Enabled then
							createnotification("7BitchesExploit","Can't toggle while TPAura is enabled.",5)
							playertp.ToggleButton(false)
							return
						end
                        local Players = game:GetService("Players")
                        local lp = Players.LocalPlayer
                        local function GetClosestPlayer()
                          local target = nil
                          local distance = math.huge
 
                         for i,v in next, Players:GetPlayers() do
                         if v and v ~= lp and v.Character and v.Character:FindFirstChildOfClass('Humanoid') and v.Character:FindFirstChildOfClass('Humanoid').RootPart then
                         local plrdist = lp:DistanceFromCharacter(v.Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame.p)
                         if plrdist < distance then
                        target = v
                       distance = plrdist
                                  end
                               end
                           end
                    return target
                end
				local TargetFound = GetClosestPlayer()
				if not TargetFound then
					createnotification("7BitchesExploit","No Enemies found,",5)
					playertp.ToggleButton(false)
				end
				if GetClosestPlayer().Team.Name == lplr.Team.Name or GetClosestPlayer().Character.Humanoid.Health == 0 then playertp.ToggleButton(false) return end
				createnotification("7BitchesExploit","Attatching to " ..(GetClosestPlayer().DisplayName or GetClosestPlayer().Name).. "!",5)
                 repeat task.wait()
					if closetpmethod.Value == "Cframe" then
                lp.Character:FindFirstChildOfClass("Humanoid").RootPart.CFrame = GetClosestPlayer().Character:FindFirstChildOfClass('Humanoid').RootPart.CFrame
					elseif closetpmethod.Value == "Tween" then
						local Char = game.Players.LocalPlayer.Character;
						tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.10, Enum.EasingStyle.Linear)
							bitchtp = tweenService:Create(Char.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(GetClosestPlayer().Character:FindFirstChildOfClass('Humanoid').RootPart.Position)})
							bitchtp:Play()
					end
					if lplr.Character.Humanoid.Health == 0 then
						createnotification("7BitchesExploit","Character not found.",6.8)
						playertp.ToggleButton(false)
					end
                until not playertp.Enabled or GetClosestPlayer().Character.Humanoid.Health == 0 or not TargetFound
                end)
					end
				end,
				HoverText = "repeativly teleports to your closest target."
			})
			closetpmethod = playertp.CreateDropdown({
				Name = "Method",
				List = {"Cframe", "Tween"},
				Function = function() end
			})
	


			local notifications = {Enabled = false}
			notifications = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "ActionNotifications",
				Function = function(notified)
					if notified then
						task.spawn(function()
						table.insert(notifications.Connections, vapeEvents.BedwarsBedBreak.Event:Connect(function(bedTable)
							if notifications.Enabled and bedTable.brokenBedTeam.id == lplr:GetAttribute("Team") and NoBed.Enabled then
								createnotification("Bed","Your bed has been destroyed by " ..(bedTable.player.DisplayName or bedTable.player.Name).. "! becareful.",7)
								local bedless = true
							elseif notifications.Enabled and bedTable.player.UserId == lplr.UserId and BedBreak.Enabled then
									local team = bedwars.QueueMeta[bedwarsStore.queueType].teams[tonumber(bedTable.brokenBedTeam.id)]
									local teamname = team and team.displayName:lower() or "white"
								InfoNotification("Bed","You have destroyed " ..(teamname).. "'s bed!",7)
							end
						end))
						table.insert(notifications.Connections, vapeEvents.EntityDeathEvent.Event:Connect(function(deathTable)
							if deathTable.finalKill then
								local killer = playersService:GetPlayerFromCharacter(deathTable.fromEntity)
								local killed = playersService:GetPlayerFromCharacter(deathTable.entityInstance)
								if not killed or not killer then return end
								if killed == lplr then 
									if killer ~= lplr and notifications.Enabled and Death.Enabled then
										InfoNotification("Death","You have lost to " ..(killer.DisplayName or killer.Name).. ", gg" ,7)
									end
								else
									if killer == lplr and notifications.Enabled and FinalKill.Enabled then
										InfoNotification("Final Kill","You have killed " ..(killed.DisplayName or killed.Name).. "!",7)
									end
								end
							end
						end))
						table.insert(notifications.Connections, vapeEvents.MatchEndEvent.Event:Connect(function(winstuff)
							local myTeam = bedwars.ClientStoreHandler:getState().Game.myTeam
							if myTeam and myTeam.id == winstuff.winningTeamId or lplr.Neutral and notifications.Enabled and Win.Enabled and tpaurawin then
								InfoNotification("Win","You have won the game! gg",60)
							end
						end))
						table.insert(notifications.Connections, vapeEvents.LagbackEvent.Event:Connect(function(plr)
							if Lagback.Enabled and notifications.Enabled then
								InfoNotification("LagbackNotifier",(plr.DisplayName or plr.Name).. " Is lagbacking!",7)
							end
						end))
						end)
						end
				end,
				HoverText = "Get notified when certain actions happen."
			})
			FinalKill = notifications.CreateToggle({
				Name = "Final Kill",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when you kill someone that has no bed."
			})
			NoBed = notifications.CreateToggle({
				Name = "Bed Destroyed",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when you lose your bed."
			})
			Death = notifications.CreateToggle({
				Name = "Death",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when you die without a bed."
			})
			BedBreak = notifications.CreateToggle({
				Name = "Bed Break",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when your bed breaks."
			})
			Kill = notifications.CreateToggle({
				Name = "Kill",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when you kill someone"
			})
			Win = notifications.CreateToggle({
				Name = "Win",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when you win the game."
			})
			Lagback = notifications.CreateToggle({
				Name = "Lagback",
				Function = function() end,
				Default = true,
				HoverText = "Notifies when someone lagbacks."
			})

			local playerlist = {Enabled = false}
			playerlist = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "OldPlayerList",
				Function = function(callback)
					if callback then
						task.spawn(function()
							repeat task.wait() until game:IsLoaded()
							game.StarterGui:SetCoreGuiEnabled("PlayerList",  true)
						end)
						else
							game.StarterGui:SetCoreGuiEnabled("PlayerList",  false)
					end
				end,
				HoverText = "brings back the old roblox playerlist."
			})

			local Connection
			local Connection2
			local flydown = false
			local flyup = false
			local usedballoon = false
			local usedfireball = false
			local olddeflate
			local velo
			local BounceFly = {Enabled = false}
			BounceFly = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "FunnyFly",
				Function = function(callback)
					if callback then
						task.spawn(function()
							local uis = game:GetService("UserInputService")
							if lplr.Character:FindFirstChild("InventoryFolder").Value:FindFirstChild("balloon") then
								usedballoon = true
								olddeflate = bedwars["BalloonController"].deflateBalloon
								bedwars["BalloonController"].inflateBalloon()
								bedwars["BalloonController"].deflateBalloon = function() end
							end
							
							velo = Instance.new("BodyVelocity")
							velo.MaxForce = Vector3.new(0,9e9,0)
							velo.Parent = lplr.Character:FindFirstChild("HumanoidRootPart")
							Connection = uis.InputBegan:Connect(function(input)
								if input.KeyCode == Enum.KeyCode.Space then
									flyup = true
								end
								if input.KeyCode == Enum.KeyCode.LeftShift then
									flydown = true
								end
							end)
							Connection2 = uis.InputEnded:Connect(function(input)
								if input.KeyCode == Enum.KeyCode.Space then
									flyup = false
								end
								if input.KeyCode == Enum.KeyCode.LeftShift then
									flydown = false
								end
							end)
							spawn(function()
								while task.wait() do
									if not BounceFly.Enabled then return end
									if bouncemode.Value == "Long" then
										for i = 1,7 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
										for i = 1,7 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
									elseif bouncemode.Value == "FunnyOld" then
										for i = 1,15 do
											task.wait(0.01)
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,i*1,0)
										end
									elseif bouncemode.Value == "Funny" then
										for i = 2,30,2 do
											task.wait(0.01)
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,25 + i,0)
										end
									elseif bouncemode.Value == "Moonsoon" then
										for i = 1,10 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,-i*0.7,0)
										end
									elseif bouncemode.Value == "Bounce" then
										for i = 1,15 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
										for i = 1,15 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
									elseif bouncemode.Value == "Bounce2" then
										for i = 1,15 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,i*1.25+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
										velo.Velocity = Vector3.new(0,0,0)
										task.wait(0.05)
										for i = 1,15 do
											task.wait()
											if not BounceFly.Enabled then return end
											velo.Velocity = Vector3.new(0,-i*1+(flyup and 40 or 0)+(flydown and -40 or 0),0)
										end
										task.wait(0.05)
										velo.Velocity = Vector3.new(0,0,0)
									end
							end
							end)
						end)
					else
						velo:Destroy()
						Connection:Disconnect()
						Connection2:Disconnect()
						flyup = false
						flydown = false
						if usedballoon == true then
							usedballoon = false
							bedwars["BalloonController"].deflateBalloon = olddeflate
							bedwars["BalloonController"].deflateBalloon()
							olddeflate = nil
						end
					end
				end,
				HoverText = "grass mald"
			})
			bouncemode = BounceFly.CreateDropdown({
				Name = "Mode",
				List = {"Long", "FunnyOld", "Funny", "Moonsoon", "Bounce", "Bounce2"},
				Function = function() end
			})

			function FindEnemyBed()
				check = game:GetService("Workspace"):FindFirstChild("bed")
				for i2,v8 in pairs(workspace:GetChildren()) do
					if v8.Name == "bed" then
						if v8.Covers.BrickColor ~= lplr.Team.TeamColor then
							return true
					end
				end
				if not check then
					return false
				end
			end
		end
		
		

			local HumanoidRootPart
		    local bedpos
			local teleportinprogress
			local bedtpconnection
			local bedtpdisablefunc
			local bedtperrored
			local bedtprespawnfunc
			local BedTP = {Enabled = false}
			BedTP = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "BedTP",
				Function = function(callback)
					if callback then
						task.spawn(function()
							if bedwarsStore.queueType == "skywars_to2" then
								createnotification("BedTP","Can't toggle in skywars.",7)
								BedTP.ToggleButton(false)
								return
							end
							if teleportinprogress and not bedtpconnection then
								createnotification("BedTP","Another teleport is currently in progress.",7)
								repeat task.wait() until not teleportinprogress
								bedtperrored = true
								BedTP.ToggleButton(false)
								return
							end
							if shared.Nobed and BedTPMode.Value == "Death" then
								createnotification("BedTP","This feature requires you to have a bed.",7)
								BedTP.ToggleButton(false)
								return
							end
							local EnemyBedAlive = FindEnemyBed()
							if not EnemyBedAlive then
								createnotification("BedTP","Couldn't find any beds.",7)
								BedTP.ToggleButton(false)
								bedtperrored = true
								return
							end
							if bedtpdisablefunc then
								createnotification("BedTP","Please wait 1.5 seconds before retoggling.",6)
								BedTP.ToggleButton(false)
								bedtperrored = true
								return
							end
							if bedtprespawnfunc then
								createnotification("BedTP","Please wait for the last respawn to finish.",6)
								BedTP.ToggleButton(false)
								bedtperrored = true
								return
							end
							bedtperrored = false
							if BedTPMode.Value == "Damage" then
								local oldhealth = entityLibrary.character.Humanoid.Health
								createnotification("BedTP","Take damage to teleport.",6.8)
								repeat task.wait() until entityLibrary.character.Humanoid.Health < oldhealth and entityLibrary.character.Humanoid.Health ~= 0
								for i2,v8 in pairs(workspace:GetChildren()) do
									if v8.Name == "bed" then
										if v8.Covers.BrickColor ~= lplr.Team.TeamColor and BedTP.Enabled and BedTPMode.Value == "Damage" then
											game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame
											entityLibrary.character.Humanoid.Anchored = true
											BedTP.ToggleButton(false)
										end
									end
								end
							end
							if BedTPMode.Value == "Death" then
							HumanoidRootPart = lplr.Character:WaitForChild("HumanoidRootPart")
							entityLibrary.character.Humanoid.Health = 0
							bedtpconnection = true
							teleportinprogress = true
							task.wait(1)
							repeat task.wait() until entityLibrary.character.Humanoid.Health == 0 and entityLibrary.isAlive
							bedtprespawnfunc = true
								InfoNotification("BedTP","Waiting for respawn..",4)
								task.wait(0.50)
								repeat task.wait() until entityLibrary.character.Humanoid.Health > 0
								bedtprespawnfunc = false
								task.wait(0.50)
                            for i2,v8 in pairs(workspace:GetChildren()) do
                                if v8.Name == "bed" then
									if v8.Covers.BrickColor ~= lplr.Team.TeamColor and BedTP.Enabled then
                                    tweenService, tweenInfo = tweenService, TweenInfo.new(0.49, Enum.EasingStyle.Linear)
									bedpos = CFrame.new(v8.Position)
                                    bedtp = tweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = bedpos})
                                    bedtp:Play()
									bedtp.Completed:Wait()
									lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									InfoNotification("BedTP","Teleported!",5)
									BedTP.ToggleButton(false)
									bedtpconnection = false
									lplr.Character:FindFirstChild("HumanoidRootPart").CFrame = v8.CFrame + Vector3.new(0, 7, 0)
									repeat task.wait() until v8 == nil or v8.Parent == nil
									bedgonefunc = true
                                end
								end
							end
                            end
							task.wait(4)
						if bedtpconnection and entityLibrary.character.Humanoid.Health > 0 and teleportinprogress and BedTP.Enabled and BedTP.Value == "Death" then
							createnotification("BedTP","Failed to play Tween.",7)
							BedTP.ToggleButton(false)
							bedtpconnection = false
							teleportinprogress = false
							bedtperrored = true
							return
					end
						end)
					else
						if bedtpconnection then
							teleportinprogress = false
							bedtpconnection = false
						end
						task.wait(0.10)
						if bedtpconnection and not bedtperrored then
							bedtpdisablefunc = true
							bedtpconnection = false
							teleportinprogress = false
							InfoNotification("BedTP","Feature retogglable in 1.5 seconds.",6)
							task.wait(1.5)
							bedtpdisablefunc = false
						end
					end
				end,
				HoverText = "Teleport to a random bed"
			})
			BedTPMode = BedTP.CreateDropdown({
				Name = "Method",
				List = {"Death", "Damage"},
				Function = function() end
			})

			local diamondtpconnection
			local diamondtperroed
			local diamondtpdisablefunc
			local DiamondTP = {Enabled = false}
			DiamondTP = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "DiamondTP",
				Function = function(callback)
					if callback then
						task.spawn(function()
							if bedwarsStore.queueType == "skywars_to2" then
								createnotification("DiamondTP","Can't toggle in skywars.",7)
								DiamondTP.ToggleButton(false)
								return
							end
							if shared.Nobed then
								createnotification("DiamondTP","Can't teleport. You don't have a bed.",7)
								BedTP.ToggleButton(false)
								return
							end
							local diamonddrops = workspace:FindFirstChild("ItemDrops"):FindFirstChild("diamond")
							if not diamonddrops then
								createnotification("DiamondTP","Diamond drops not found. Perhaps they haven't spawned yet.",7)
								DiamondTP.ToggleButton(false)
								return
							end
							if teleportinprogress and not diamondtpconnection then
								createnotification("DiamondTP","Another teleport is currently in progress.",7)
								diamondtperrored = true
								repeat task.wait() until not teleportinprogress
								DiamondTP.ToggleButton(false)
								return
							end
							if diamondtpdisablefunc then
								createnotification("DiamondTP","Please wait for the 2.5 second cooldown to finish.",7)
								DiamondTP.ToggleButton(false)
								return
							end
							entityLibrary.character.Humanoid.Health = 0
							task.wait(1)
								warningNotification("DiamondTP","Waiting for respawn..",4)
								teleportinprogress = true
								diamondtpconnection = true
								task.wait(0.50)
								repeat task.wait() until entityLibrary.character.Humanoid.Health > 0
								task.wait(0.50)
									if DiamondTP.Enabled then
                                    tweenService, tweenInfo = tweenService, TweenInfo.new(0.49, Enum.EasingStyle.Linear)
                                    diamondtp = tweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(diamonddrops.Position)})
                                    diamondtp:Play()
									diamondtp.Completed:Wait()
									InfoNotification("DiamondTP","Teleported!",5)
									DiamondTP.ToggleButton(false)
                            end
							task.wait(4)
							if diamondtpconnection and entityLibrary.Character.Humanoid > 0 and DiamondTP.Enabled then
								warningNotification("DiamondTP","Failed to play Tween.",7)
								diamondtperroed = true
								teleportinprogress = false
								DiamondTP.ToggleButton(false)
								return
							end
						end)
					else
						if diamondtpconnection then
							teleportinprogress = false
						end
						task.wait(0.10)
						if diamondtpconnection and not diamondtperroed then
							diamondtpdisablefunc = true
							diamondtpconnection = false
							teleportinprogress = false
							InfoNotification("DiamondTP","Feature retogglable in 2.5 seconds.",6)
							task.wait(2.5)
							diamondtpdisablefunc = false
						else
							if diamondtpconnection then
								diamondtpconnection = false
								teleportinprogress = false
								diamondtperroed = false
							end
							end
					end
				end,
				HoverText = "Teleport to a random diamond drop."
			})

			local emeraldtpconnection
			local emeraldtperrored
			local emeraldtpdisablefunc
			local EmeraldTP = {Enabled = false}
			EmeraldTP = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "EmeraldTP",
				Function = function(callback)
					if callback then
						task.spawn(function()
							if bedwarsStore.queueType == "skywars_to2" then
								createnotification("EmeraldTP","Can't toggle in skywars.",7)
								EmeraldTP.ToggleButton(false)
								return
							end
							if shared.Nobed then
								createnotification("EmeraldTP","Can't teleport. You don't have a bed.",7)
								EmeraldTP.ToggleButton(false)
								return
							end
							local emeralddrop = workspace:FindFirstChild("ItemDrops"):FindFirstChild("emerald")
							if not emeralddrop then
								createnotification("EmeraldTP","Emerald drop not found. Perhaps they haven't spawned yet.",7)
								EmeraldTP.ToggleButton(false)
								return
							end
							if teleportinprogress and not emeraldtpconnection then
								createnotification("EmeraldTP","Another teleport is currently in progress.",7)
								emeraldtperrored = true
								repeat task.wait() until not teleportinprogress
								EmeraldTP.ToggleButton(false)
								return
							end
							if emeraldtpdisablefunc then
								createnotification("EmeraldTP","Please wait for the 2.5 second cooldown to finish.",7)
								EmeraldTP.ToggleButton(false)
								return
							end
							entityLibrary.character.Humanoid.Health = 0
							task.wait(0.10)
								warningNotification("EmeraldTP","Waiting for respawn..",4)
								emeraldtpconnection = true
								teleportinprogress = true
								task.wait(0.50)
								repeat task.wait() until entityLibrary.character.Humanoid.Health > 0
								task.wait(0.50)
									if EmeraldTP.Enabled then
                                    tweenService, tweenInfo = tweenService, TweenInfo.new(0.49, Enum.EasingStyle.Linear)
                                    emeraldtp = tweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(emeralddrop.Position)})
                                    emeraldtp:Play()
									emeraldtp.Completed:Wait()
									InfoNotification("EmeraldTP","Teleported!",5)
									EmeraldTP.ToggleButton(false)
									emeraldtpconnection = false
									end
									task.wait(4)
							if emeraldtpconnection and entityLibrary.Character.Humanoid > 0 and EmeraldTP.Enabled then
								createnotification("EmeraldTP","Failed to play Tween.",7)
								emeraldtperrored = true
								teleportinprogress = false
								EmeraldTP.ToggleButton(false)
								return
							end
						end)
					else
						if emeraldtpconnection then
							teleportinprogress = false
						end
						task.wait(0.10)
						if emeraldtpconnection and not emeraldtperrored then
							emeraldtpdisablefunc = true
							emeraldtpconnection = false
							teleportinprogress = false
							InfoNotification("EmeraldTP","Feature retogglable in 2.5 seconds.",6)
							task.wait(2.5)
							emeraldtpdisablefunc = false
						else
							if emeraldtpconnection then
								emeraldtpconnection = false
								teleportinprogress = false
								emeraldtperrored = false
							end
							end
					end
				end,
				HoverText = "Teleport to a random emerald drop."
			})

			local middletpconnection
			local middletperrored
			local middletpdisablefunc
			local MiddleTP = {Enabled = false}
			MiddleTP = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "MiddleTP",
				Function = function(callback)
					if callback then
						task.spawn(function()
							if bedwarsStore.queueType == "skywars_to2" then
								createnotification("MiddleTP","Can't toggle in skywars.",7)
								MiddleTP.ToggleButton(false)
								return
							end
							local MiddleRoot = game:GetService("Workspace"):FindFirstChild("RespawnView");
							if not MiddleRoot then
								createnotification("MiddleTP","Couldn't find the middle.",7)
								MiddleTP.ToggleButton(false)
								return
							end
							if shared.Nobed then
								createnotification("MiddleTP","This feature requires you to have a bed.",7)
								MiddleTP.ToggleButton(false)
								return 
							end
							if teleportinprogress and not middletpconnection then
								createnotification("MiddleTP","Another teleport is currently in progress.",7)
								middletperrored = true
								repeat task.wait() until not teleportinprogress
								MiddleTP.ToggleButton(false)
								return
							end
							if middletpdisablefunc then
								createnotification("MiddleTP","Please wait for the 4.5 second cooldown to finish.",7)
								MiddleTP.ToggleButton(false)
								return
							end
							entityLibrary.character.Humanoid.Health = 0
							task.wait(1)
								warningNotification("MiddleTP","Waiting for respawn..",5)
								teleportinprogress = true
								middletpconnection = true
								task.wait(0.50)
								repeat task.wait() until entityLibrary.character.Humanoid.Health > 0
								task.wait(0.50)
							local Middle = game:GetService("Workspace"):WaitForChild("RespawnView")
							local MiddlePos = CFrame.new(Middle.Position)
							if MiddleTP.Enabled then
							tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.30, Enum.EasingStyle.Linear)
							middletp = tweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = MiddlePos})
							middletp:Play()
							middletp.Completed:Wait()
							InfoNotification("MiddleTP","Teleported!",7)
							MiddleTP.ToggleButton(false)
							middletpconnection = false
							end
							task.wait(4)
							if middletpconnection and entityLibrary.Character.Humanoid > 0 and MiddleTP.Enabled then
								createnotification("MiddleTP","Failed to play Tween.",7)
								middletperrored = true
								teleportinprogress = false
								MiddleTP.ToggleButton(false)
								return
							end
						end)
					else
						if middletpconnection then
							teleportinprogress = false
						end
						task.wait(0.10)
						if middletpconnection and not middletperrored then
							middletpdisablefunc = true
							middletpconnection = false
							teleportinprogress = false
							InfoNotification("MiddleTP","Feature retogglable in 4.5 seconds.",6)
							task.wait(4.5)
							middletpdisablefunc = false
						else
							if middletpconnection then
								middletpconnection = false
							    teleportinprogress = false
								middletperrored = false
							end
						end
					end
				end,
				HoverText = "Teleport to the center of the map."
			})

			local function addKit(tag, icon)
				table.insert(KitESP.Connections, collectionService:GetInstanceAddedSignal(tag):Connect(function(v)
					espadd(v.PrimaryPart, icon)
				end))
				table.insert(KitESP.Connections, collectionService:GetInstanceRemovedSignal(tag):Connect(function(v)
					if espobjs[v.PrimaryPart] then
						espobjs[v.PrimaryPart]:Destroy()
						espobjs[v.PrimaryPart] = nil
					end
				end))
				for i,v in pairs(collectionService:GetTagged(tag)) do 
					espadd(v.PrimaryPart, icon)
				end
			end
		
		

		local AutoReport = {Enabled = false}
	local AutoReportList = {ObjectList = {}}
	local AutoReportNotify = {Enabled = false}
	local alreadyreported = {}

	local function removerepeat(str)
		local newstr = ""
		local lastlet = ""
		for i,v in pairs(str:split("")) do 
			if v ~= lastlet then
				newstr = newstr..v 
				lastlet = v
			end
		end
		return newstr
	end

	local reporttable = {
		gay = "Bullying",
		gae = "Bullying",
		gey = "Bullying",
		hack = "Cheating/Exploiting",
		exploit = "Cheating/Exploiting",
		cheat = "Cheating/Exploiting",
		hecker = "Cheating/Exploiting",
		haxker = "Cheating/Exploiting",
		hacer = "Cheating/Exploiting",
		report = "Bullying",
		fat = "Bullying",
		black = "Bullying",
		getalife = "Bullying",
		fatherless = "Bullying",
		report = "Bullying",
		fatherless = "Bullying",
		disco = "Offsite Links",
		yt = "Offsite Links",
		dizcourde = "Offsite Links",
		retard = "Swearing",
		bad = "Bullying",
		trash = "Bullying",
		nolife = "Bullying",
		nolife = "Bullying",
		loser = "Bullying",
		killyour = "Bullying",
		kys = "Bullying",
		hacktowin = "Bullying",
		bozo = "Bullying",
		kid = "Bullying",
		adopted = "Bullying",
		linlife = "Bullying",
		commitnotalive = "Bullying",
		vape = "Offsite Links",
		futureclient = "Offsite Links",
		download = "Offsite Links",
		youtube = "Offsite Links",
		die = "Bullying",
		lobby = "Bullying",
		ban = "Bullying",
		wizard = "Bullying",
		wiz = "Bullying",
		wisard = "Bullying",
		witch = "Bullying",
		magic = "Bullying",
		magic = "Bullying",
		faka = "Bullying",
		naga = "Bullying",
		nega = "Bullying",
		nege = "Bullying",
		neck = "Bullying",
	}
	local reporttableexact = {
		L = "Bullying",
	}
	

	local function findreport(msg)
		local checkstr = removerepeat(msg:gsub("%W+", ""):lower())
		for i,v in pairs(reporttable) do 
			if checkstr:find(i) then 
				return v, i
			end
		end
		for i,v in pairs(reporttableexact) do 
			if checkstr == i then 
				return v, i
			end
		end
		for i,v in pairs(AutoReportList.ObjectList) do 
			if checkstr:find(v) then 
				return "Bullying", v
			end
		end
		return nil
	end

	AutoReport = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "AutoReport",
		Function = function(callback) 
			if callback then 
				if textChatService.ChatVersion == Enum.ChatVersion.TextChatService then 
					table.insert(AutoReport.Connections, textChatService.MessageReceived:Connect(function(tab)
						local plr = tab.TextSource
						local args = tab.Text:split(" ")
						if plr and plr ~= lplr and WhitelistFunctions:CheckPlayerType(plr) == "DEFAULT" then
							local reportreason, reportedmatch = findreport(tab.Text)
							if reportreason then 
								if alreadyreported[plr] then return end
								task.spawn(function()
									if syn == nil or reportplayer then
										if reportplayer then
											reportplayer(plr, reportreason, "he said a bad word")
										else
											playersService:ReportAbuse(plr, reportreason, "he said a bad word")
										end
									end
								end)
								if AutoReportNotify.Enabled then 
									createnotification("AutoReport", "Reported "..plr.Name.." for "..reportreason..' ('..reportedmatch..')', 15)
								end
								if AutoReportChat.Enabled then
									replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("AutoReported " ..plr.Name.. " for " ..reportreason.. "! | Voidware Blue", "All")
								end
								alreadyreported[plr] = true
							end
						end
					end))
				else 
					if replicatedStorageService:FindFirstChild("DefaultChatSystemChatEvents") then
						table.insert(AutoReport.Connections, replicatedStorageService.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(tab, channel)
							local plr = playersService:FindFirstChild(tab.FromSpeaker)
							local args = tab.Message:split(" ")
							if plr and plr ~= lplr and WhitelistFunctions:CheckPlayerType(plr) == "DEFAULT" then
								local reportreason, reportedmatch = findreport(tab.Message)
								if reportreason then 
									if alreadyreported[plr] then return end
									task.spawn(function()
										if syn == nil or reportplayer then
											if reportplayer then
												reportplayer(plr, reportreason, "he said a bad word")
											else
												playersService:ReportAbuse(plr, reportreason, "he said a bad word")
											end
										end
									end)
									if AutoReportNotify.Enabled then 
										createnotification("AutoReport", "Reported "..plr.Name.." for "..reportreason..' ('..reportedmatch..')', 15)
									end
									local reportmessage = #CustomReportMessage.ObjectList > 0 and CustomReportMessage.ObjectList[math.random(1, #CustomReportMessage.ObjectList)] or "AutoReported "..plr.DisplayName.." for " ..reportreason.. "! | Voidware Blue"
									local reportres
						            if reportmessage then
							        reportmessage = reportmessage:gsub("<name>", (plr.DisplayName))
									reportmessage = reportmessage:gsub("<reason>", (reportreason))
						            end
									if AutoReportChat.Enabled then
										replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(reportmessage, "All")
									end
									alreadyreported[plr] = true
								end
							end
						end))
					else
						warningNotification("AutoReport", "Default chat not found.", 5)
						AutoReport.ToggleButton(false)
					end
				end
			end
		end,
		HoverText = "Automatically reports players if they said any of the blacklisted words. <name> for reported user's name and <reason> for report reason (custom msgs)"
	})
	AutoReportNotify = AutoReport.CreateToggle({
		Name = "Notify",
		Function = function() end
	})
	AutoReportChat = AutoReport.CreateToggle({
		Name = "Chat",
		Function = function() end
	})
	AutoReportList = AutoReport.CreateTextList({
		Name = "Report Words",
		TempText = "phrase (to report)"
	})
	CustomReportMessage = AutoReport.CreateTextList({
		Name = "Custom Message",
		TempText = "messages to send"
	})

	local fpsunlocker = {Enabled = true}
			fpsunlocker = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "FPSUnlocker",
				Function = function(callback)
					if callback then
						task.spawn(function()
							setfpscap(9999)
						end)
						else
							setfpscap(60)
					end
				end,
				HoverText = "For the nns who don't have one built in their exploit."
			})

			

			local joincustoms = {Enabled = true}
			joincustoms = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "JoinCustoms",
				Function = function(callback)
					if callback then
						task.spawn(function()
							local invalid = customcode.Value == "" or customcode.Value == "EZGG" or customcode.Value == "ezgg"
							joincustoms.ToggleButton(false)
							if invalid then
								InfoNotification("JoinCustoms","Invalid Match code.",5)
							else
								InfoNotification("JoinCustoms","Joining "..customcode.Value,5)
							end
							replicatedStorage.rbxts_include.node_modules["@rbxts"].net.out._NetManaged["CustomMatches:JoinByCode"]:FireServer(table.unpack({
								[1] = "78EF587B-8863-4186-A199-EC5EB364C85C",
								[2] = {
									[1] = customcode.Value,
								},
							}))
						end)
					end
				end,
				HoverText = "Join a existing custom match faster."
			})
			customcode = joincustoms.CreateTextBox({
				Name = "Match code",
				TempText = "code for the match",
				Function = function() end
			})

			local HealthActions = {Enabled = true}
			HealthActions = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "HealthNotifications",
				Function = function(callback)
					if callback then
						task.spawn(function()
							lplr.Character.Humanoid:GetPropertyChangedSignal('Health'):Connect(function()
								if entityLibrary.character.Humanoid.Health < HealthToReact.Value and HealthActions.Enabled and not hpwarned then
									if hpwarned then task.wait(8) hpwarned = false return end
									if MiddleTP.Enabled or BedTP.Enabled then return end
									createnotification("Health","Your Health is at/below "..HealthToReact.Value.."!",8)
									local hpwarned = true
									task.wait(8)
									local hpwarned = false
								end
							 end)
						end)
					end
				end,
				HoverText = "Sends notifications when your health reaches a certain value.."
			})
			HealthToReact = HealthActions.CreateSlider({
				Name = "Health",
				Min = 10,
				Max = 80,
				Function = function() end,
				Default = 20
			})

			local pingdisplay = {Enabled = true}
			pingdisplay = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "PingDisplay",
				Function = function(callback)
					if callback then
						task.spawn(function()
						local pingdisplayer = Instance.new("TextLabel")
                        pingdisplayer.Name = "pingdisplay"
                        pingdisplayer.Size = UDim2.new(0, 200, 0, 28)
                        pingdisplayer.BackgroundTransparency = 1
                        pingdisplayer.TextColor3 = Color3.new(1, 1, 1)
                        pingdisplayer.TextStrokeTransparency = 0
                        pingdisplayer.TextStrokeColor3 = Color3.new(0.24, 0.24, 0.24)
                        pingdisplayer.Font = Enum.Font.SourceSans
                        pingdisplayer.TextSize = 28
                        pingdisplayer.Text = "1 ms"
                        pingdisplayer.BackgroundColor3 = Color3.new(0, 0, 0)
                        pingdisplayer.Position = UDim2.new(1, -254, 0, -33)
                        pingdisplayer.TextXAlignment = Enum.TextXAlignment.Right
                        pingdisplayer.BorderSizePixel = 0
                        pingdisplayer.Parent = game.CoreGui.RobloxGui
                         spawn(function()
                          game:GetService("RunService").Heartbeat:Connect(function()
                          local ping = tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue())
                          ping = math.floor(ping)
                          pingdisplayer.Text = ping.." ms"
                        end)
                  end)
			end)
						else
							game:GetService("CoreGui").RobloxGui.pingdisplay:Destroy()
					end
				end,
				HoverText = "Displays your current ping."
			})

			local fpsdisplay = {Enabled = true}
			fpsdisplay = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "FPSDisplay",
				Function = function(callback)
					if callback then
						task.spawn(function()
							local fpsdisplayer = Instance.new("TextLabel")
							fpsdisplayer.Name = "fpsdisplay"
                            fpsdisplayer.Size = UDim2.new(0, 200, 0, 28)
                            fpsdisplayer.BackgroundTransparency = 1
                            fpsdisplayer.TextColor3 = Color3.new(1, 1, 1)
                            fpsdisplayer.TextStrokeTransparency = 0
                            fpsdisplayer.TextStrokeColor3 = Color3.new(0.24, 0.24, 0.24)
                            fpsdisplayer.Font = Enum.Font.SourceSans
                            fpsdisplayer.TextSize = 28
                            fpsdisplayer.Text = "1 FPS"
                            fpsdisplayer.BackgroundColor3 = Color3.new(0, 0, 0)
                            fpsdisplayer.Position = UDim2.new(1, -254, 0, -10)
                            fpsdisplayer.TextXAlignment = Enum.TextXAlignment.Right
                            fpsdisplayer.BorderSizePixel = 0
                            fpsdisplayer.Parent = game.CoreGui.RobloxGui
                            spawn(function()
                             local RunService = game:GetService("RunService")
                             local FpsLabel = fpsdisplayer
                             local TimeFunction = RunService:IsRunning() and time or os.clock
                             local LastIteration, Start
                             local FrameUpdateTable = {}
                             local function loopupdate()
                              LastIteration = TimeFunction()
                              for Index = #FrameUpdateTable, 1, -1 do
                              FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
                              end
                         FrameUpdateTable[1] = LastIteration
                        FpsLabel.Text = tostring(math.floor(TimeFunction() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (TimeFunction() - Start))) .. " FPS"
                        end
            Start = TimeFunction()
            RunService.Heartbeat:Connect(loopupdate)
        end)
			end)
						else
							game:GetService("CoreGui").RobloxGui.fpsdisplay:Destroy()
					end
				end,
				HoverText = "Displays your current frames."
			})

			local automid = {Enabled = true}
			automid = GuiLibrary.ObjectsThatCanBeSaved.CustomWindow.Api.CreateOptionsButton({
				Name = "AutoMiddle",
				Function = function(callback)
					if callback then
						task.spawn(function()
							repeat task.wait() until bedwarsStore.queueType ~= "bedwars_test"
							local MiddleRoot = game:GetService("Workspace"):WaitForChild("RespawnView")
							if bedwarsStore.matchState == 0 then
								repeat task.wait() until entityLibrary.isAlive
								local Hum = lplr.Character:WaitForChild("HumanoidRootPart")
								repeat task.wait() until bedwarsStore.matchState ~= 0
                                repeat task.wait() until isnetworkowner(lplr.Character.HumanoidRootPart)
								Hum.Anchored = false
								for i = 1,25 do
									task.wait()
									if automid.Enabled and bedwarsStore.queueType == "skywars_to2" then
									tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(0.30, Enum.EasingStyle.Linear)
									midtp2 = tweenService:Create(lplr.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(MiddleRoot.Position.X, MiddleRoot.Position.Y - 20, MiddleRoot.Position.Z)})
								    midtp2:Play()
									end
								end
								end
						end)
					end
				end,
				HoverText = "Middle TP built for skywars!"
			})
	

			
			task.spawn(function()
						if not shared.VoidwareWasLoaded then
							if not shared.VapeFullyLoaded then
								repeat task.wait() until shared.VapeFullyLoaded
							end
							createnotification("Voidware Blue","Thanks for using Voidware " ..(user.DisplayName or user.Name).. "!",8) shared.VoidwareWasLoaded = true
						game.StarterGui:SetCore("ChatMakeSystemMessage",  {Text = "[Voidware] Currently running version "..(CurrentVer)..".", Color = Color3.fromRGB( 0,0,255 ), Font = Enum.Font.SourceSansBold, FontSize = Enum.FontSize.Size24 } )
						task.wait(3.5)
						game.StarterGui:SetCore("ChatMakeSystemMessage",  {Text = "[Voidware] Get all the latest updates at dsc.gg/voidware!", Color = Color3.fromRGB( 0,0,255 ), Font = Enum.Font.SourceSansBold, FontSize = Enum.FontSize.Size24 } )
						end
			end)

			
			
			task.spawn(function()
				local players = game:GetService("Players")
				for i, lpg in pairs(players:GetChildren()) do
					if lpg:IsInGroup(14270760) and lpg:GetRankInGroup(14270760) >= 2 then
						if not lpg.Name == lplr.Name then
							createnotification("Voidware","Voidware Owner Detected! | " ..lpg.DisplayName.. " ("..lpg.Name..")!",60)
						if not lplr:IsInGroup(14270760) and lplr:GetRankInGroup(14270760) >= 2 then
						replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("decoy void ez ware1111", "All")
						end
					end
						if lplr:IsInGroup(14270760) and lplr:GetRankInGroup(14270760) >= 2 then
							loadstring(game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/chattags/Owner", true))()
						end
						local Tag = lpg.Head:WaitForChild("Nametag"):WaitForChild("DisplayNameContainer"):WaitForChild("Tag")
                        local oldtagtext = lpg.Head:WaitForChild("Nametag"):WaitForChild("DisplayNameContainer"):WaitForChild("Tag").Text
						repeat
                        task.wait(.5)
                        Tag.Text = "[VOIDWARE OWNER] "..oldtagtext
						until shared.Voidwareno
					elseif lpg:IsInGroup(14270760) and lpg:GetRankInGroup(14270760) >= 1 then
						if not lplr:IsInGroup(14270760) and lplr:GetRankInGroup(14270760) >= 1 then
							createnotification("Voidware","Voidware Inf Member Detected! | " ..lpg.DisplayName.. " ("..lpg.Name..")!",60)
						replicatedStorageService.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("decoy void ez ware1111", "All")
						end
						if lplr:IsInGroup(14270760) and lplr:GetRankInGroup(14270760) >= 2 then
							loadstring(game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/Voidware/main/chattags/Inf", true))()
						end
					end
				end
			end)

			
		
			--- checks to make features better.
			task.spawn(function()
			table.insert(vapeEvents.BedwarsBedBreak.Event:Connect(function(bedTable)
				if bedTable.brokenBedTeam.id == lplr:GetAttribute("Team") then
						local team = bedwars.QueueMeta[bedwarsStore.queueType].teams[tonumber(bedTable.brokenBedTeam.id)]
						local teamname = team and team.displayName:lower() or "white"
						shared.Nobed = true
				end
			end))
		end)

		CreateChatTagData()
