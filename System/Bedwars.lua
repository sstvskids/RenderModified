local GuiLibrary = shared.GuiLibrary
local vapeonlineresponse = false

task.delay(10, function()
	if not vapeonlineresponse and not isfile("vape/Voidware/oldvape/Bedwars.lua") then 
		GuiLibrary.CreateNotification("Voidware", "The Connection to Github is taking a while. If vape doesn't load within 15 seconds, please reinject.", 10)
	end
end)

if isfile("vape/Voidware/oldvape/Bedwars.lua") then
	local manualfileload = pcall(function() loadstring(readfile("vape/Voidware/oldvape/Bedwars.lua"))() end)
	if not manualfileload then 
		loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872274481.lua"))()
	end
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872274481.lua"))()
end

local vapeAssert = function(argument, title, text, duration, hault, moduledisable, module) 
	if not argument then
    local suc, res = pcall(function()
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    if moduledisable and (module and GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.Enabled) then GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.ToggleButton(false) end
    end)
    if hault then while true do task.wait() end end
end
end
local identifyexecutor = identifyexecutor or function() return "Unknown" end
local getconnections = getconnections or function() return {} end
local httprequest = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	return {Body = tab.Method == "GET" and game:HttpGet(tab.Url, true) or "shit exploit", Headers = {["content-type"] = "application/json"}, StatusCode = 404}
end
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local setclipboard = setclipboard or function(data) writefile("clipboard.txt", data) end
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local delfolder = delfolder or function() end
local antiguibypass = GuiLibrary.SelfDestruct
local httpService = game:GetService("HttpService")
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
local VoidwareFunctions = {WhitelistLoaded = false, WhitelistRefreshEvent = Instance.new("BindableEvent"), WhitelistSucceeded = false, WhitelistLoadTime = tick()}
local VoidwareLibraries = {}
local VoidwareWhitelistStore = {
	Hash = "voidwaremoment",
	BlacklistTable = {},
	Tab = {},
	Rank = "Standard",
	Priority = {
		DEFAULT = 0,
		STANDARD = 1,
		BETA = 1.5,
		INF = 2,
		OWNER = 3
	},
	RankChangeEvent = Instance.new("BindableEvent"),
	chatstrings = {
		voidwaremoment = "Voidware",
		blackwaremoment = "Blackware",
		voidwarelitemoment = "Voidware Lite"
	},
	LocalPlayer = {Rank = "STANDARD", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "0000FF", TagHidden = true, HWID = "ABCDEFG", Accounts = {}, BlacklistedProducts = {}, UID = 0},
	Players = {}
}
local tags = {}
local VoidwareStore = {
	maindirectory = "vape/Voidware",
	VersionInfo = {
        MainVersion = "3.3",
        PatchVersion = "0",
        Nickname = "Universal Update",
		BuildType = "Stable",
		VersionID = "3.3"
    },
	FolderTable = {"vape/Voidware", "vape/Voidware/data"},
	SystemFiles = {"vape/NewMainScript.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua", "vape/Universal.lua"},
	teleportinprogress = false,
	watermark = function(text) return ("[Voidware] "..text) end,
	Tweening = false,
	TimeLoaded = tick(),
	ServerRegion = "none",
	GameStarted = nil,
	GameFinished = shared.VoidwareStore and shared.VoidwareStore.GameFinished or false,
	CurrentPing = 0,
	TargetObject = shared.VoidwareTargetObject,
	bedtable = {},
	entityIDs = shared.VoidwareStore and type(shared.VoidwareStore.entityIDs) == "table" and shared.VoidwareStore.entityIDs or {fakeIDs = {}},
	HumanoidDied = Instance.new("BindableEvent"),
	ReceivedTick = tick(),
	ServerDelay = 0,
	scytheMoveVec = false,
	SentTick = tick(),
	MobileInUse = (inputService:GetPlatform() == Enum.Platform.Android or inputService:GetPlatform() == Enum.Platform.IOS),
	vapePrivateCommands = {},
	Enums = {},
	ChatCommands = {},
	jumpTick = tick(),
	Api = {},
	AverageFPS = 60,
	FrameRate = 60,
	AliveTick = tick(),
	DeathFunction = nil,
	switchItemTick = tick(),
	vapeupdateroutine = nil,
	MatchEndEvent = Instance.new("BindableEvent"),
	BedShieldEnd = Instance.new("BindableEvent"),
	TargetUpdateLoopDelay = tick(),
	playerFriends = {},
	movementDisabled = false
}
VoidwareStore.FolderTable = {"vape/Voidware", VoidwareStore.maindirectory, VoidwareStore.maindirectory.."/".."data"}
local VoidwareGlobe = shared.VoidwareStore or {ConfigUsers = {}, BlatantModules = {}, Messages = {}, GameFinished = false, WhitelistChatSent = {}, HookedFunctions = {}, UpdateTargetInfo = function() end, targetInfo = {}, entityIDs = {fakeIDs = {}}}
local VoidwareQueueStore = {LiteMode = false}
task.spawn(function()
	repeat 
	if not shared.VoidwareStore or type(shared.VoidwareStore) ~= "table" then 
		shared.VoidwareStore = VoidwareGlobe
	end
	task.wait()
	until not vapeInjected
end)

if not shared.VoidwareStore or type(shared.VoidwareStore) ~= "table" then 
	shared.VoidwareStore = VoidwareGlobe
end
GuiLibrary.ToggleModuleEvent = GuiLibrary.ToggleModuleEvent or Instance.new("BindableEvent")
shared.VoidwareStore.ModuleType = "BedwarsMain"
local VoidwareRank = VoidwareWhitelistStore.Rank
local VoidwarePriority = VoidwareWhitelistStore.Priority
local bedwars = {}
local bedwarsStore = {
	attackReach = 0,
	attackReachUpdate = tick(),
	blocks = {},
	blockPlacer = {},
	blockPlace = tick(),
	blockRaycast = RaycastParams.new(),
	equippedKit = "none",
	forgeMasteryPoints = 0,
	forgeUpgrades = {},
	grapple = tick(),
	inventories = {},
	localInventory = {
		inventory = {
			items = {},
			armor = {}
		},
		hotbar = {}
	},
	localHand = {},
	matchState = 0,
	matchStateChanged = tick(),
	pots = {},
	queueType = "bedwars_test",
	scythe = tick(),
	scythespeed = 40,
	daoboost = tick(),
	statistics = {
		beds = 0,
		kills = 0,
		lagbacks = 0,
		lagbackEvent = Instance.new("BindableEvent"),
		reported = 0,
		universalLagbacks = 0
	},
	whitelist = {
		chatStrings1 = {helloimusinginhaler = "vape"},
		chatStrings2 = {vape = "helloimusinginhaler"},
		clientUsers = {},
		oldChatFunctions = {}
	},
	zephyrOrb = 0,
	hannahExecutions = {}
}
bedwarsStore.blockRaycast.FilterType = Enum.RaycastFilterType.Include
local AutoLeave = {Enabled = false}

table.insert(vapeConnections, workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	gameCamera = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera") or {}
end))

shared.VoidwareQueueStore = nil

for i,v in pairs(playersService:GetPlayers()) do 
	local GenerateGUID = false
	for i2, v2 in pairs(VoidwareStore.entityIDs) do 
		if v2 == v.UserId then
			GenerateGUID = true 
		end
	end 
	if not GenerateGUID then
		local generatedid = httpService:GenerateGUID(true)
		VoidwareStore.entityIDs[generatedid] = v.UserId
	end
end

table.insert(vapeConnections, lplr.OnTeleport:Connect(function()
	local queuestore = shared.VoidwareQueueStore
	local success, newqueuestore = pcall(function() return httpService:JSONEncode(queuestore) end)
	if success and newqueuestore then
		queueonteleport("shared.VoidwareQueueStore = '"..newqueuestore.."'")
	end
end))

table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(plr)
	local GenerateGUID = false
	for i2, v2 in pairs(VoidwareStore.entityIDs) do 
		if v2 == plr.UserId then
			GenerateGUID = true 
			break
		end
	end
	if not GenerateGUID then 
		local generatedid = httpService:GenerateGUID(true)
		VoidwareStore.entityIDs[generatedid] = plr.UserId
	end
end))

task.spawn(function()
	repeat task.wait()
	   shared.VoidwareStore.entityIDs = VoidwareStore.entityIDs
	until not vapeInjected
end)

GuiLibrary.SelfDestructEvent.Event:Connect(function()
	vapeInjected = false
	for i, v in pairs(vapeConnections) do
		pcall(function() v:Disconnect() end)
	end
	shared.VoidwareStore.ManualTargetUpdate = nil
	shared.VoidwareCustomProfile = nil
	shared.VoidwareQueued = nil
	pcall(function() getgenv().VoidwareFunctions = nil end)
end)

local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end

local function antikickbypass(data, watermark)
	local bypassed = true
	pcall(function() task.spawn(GuiLibrary.SelfDestruct) end)
	task.spawn(function() settings().Network.IncomingReplicationLag = math.huge end)
	task.spawn(function() 
		lplr:Kick(data or "Voidware has requested player disconnect.") 
		if watermark then
		   pcall(function() game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt.TitleFrame.ErrorTitle.Text = "Voidware Error" end)
		end
		bypassed = false 
	end)
	task.wait(0.2)
	pcall(function() bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer() end)
	task.wait(1.5)
	if bypassed then
	task.spawn(function() game:Shutdown() end)
	end
	task.wait(1.5)
	for i,v in pairs(lplr.PlayerGui:GetChildren()) do 
		v.Parent = game:GetService("CoreGui")
	end
	task.spawn(function() lplr:Destroy() end) 
	task.wait(1.5)
	if lplr then 
	repeat print() until false
	end
end


function VoidwareFunctions:GetLocalEntityID(player, fakeuser)
	for i,v in pairs(VoidwareStore.entityIDs) do 
		if v == (fakeuser or player.UserId) then 
			return i
		end
	end
	return nil
end

function VoidwareFunctions:CreateLocalTag(player, text, color)
	local plr = VoidwareFunctions:GetLocalEntityID(player or lplr)
	if plr then
		tags[plr] = {}
		tags[plr].Text = text
		tags[plr].Color = color 
		return tags[plr]
	end
	return nil
end

function VoidwareFunctions:GenerateFakeUserID(player)
	if VoidwareStore.entityIDs.fakeIDs[player] == nil then
		local fakeid = math.random(1, 8)
		for i = 1, 5 do 
			fakeid = tostring(fakeid)..""..tostring(math.random(1, 8))
		end
		return tonumber(fakeid)
	end
	return VoidwareStore.entityIDs.fakeIDs[player]
end

function VoidwareFunctions:GetLocalTag(player)
	local plr = VoidwareFunctions:GetLocalEntityID(player or lplr)
	if plr and tags[plr] then
		return tags[plr]
	end
	return {Text = "", Color = "FFFFFF"}
end

function VoidwareFunctions:LoadTime()
	if shared.VapeFullyLoaded then
		return (tick() - VoidwareStore.TimeLoaded)
	else
		return 0
	end
end

function VoidwareFunctions:GetMainDirectory()
	for i,v in pairs({"vape", "vape/Voidware"}) do 
		if not isfolder(v) then 
			makefolder(v)
		end
	end
	if not isfolder(VoidwareStore.maindirectory) then 
		makefolder(VoidwareStore.maindirectory)
	end
	return VoidwareStore.maindirectory or "vape/Voidware"
end

function VoidwareFunctions:SpecialNearPosition(distance)
	distance = distance or 100
	local specialplayers = VoidwareFunctions:SpecialInGame() or {}
	for i,v in pairs(specialplayers) do 
		if lplr.Character and lplr.Character.PrimaryPart and v.Character and v.Character.PrimaryPart then 
			if ({VoidwareFunctions:GetPlayerType(v)})[2] then 
				continue
			end
			if ({VoidwareFunctions:GetPlayerType()})[3] >= ({VoidwareFunctions:GetPlayerType(v)})[3] then
				continue 
			end
			local magnitude = (lplr.Character.PrimaryPart.Position - v.Character.PrimaryPart.Position).Magnitude
			if magnitude < distance and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then 
				return true
			end
		end
	end
	return nil
end

local function isEnabled(toggle)
	if not toggle then return false end
	toggle = GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"] and GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"].Api
	return toggle and toggle.Enabled or false
end

local function isObject(object)
	object = object or ""
	return GuiLibrary.ObjectsThatCanBeSaved[object] and true or false
end

task.spawn(function()
	local lastrank = VoidwareWhitelistStore.Rank:upper()
	repeat
	VoidwareRank = VoidwareWhitelistStore.Rank:upper()
	if VoidwareRank ~= lastrank then
		VoidwareWhitelistStore.RankChangeEvent:Fire(VoidwareRank)
		lastrank = VoidwareRank
	end
	task.wait()
	until not vapeInjected
end)

task.spawn(function()
	for i,v in pairs(collectionService:GetTagged("Monster")) do 
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakseid
		end
	end
	for i,v in pairs(collectionService:GetTagged("Drone")) do 
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end
	for i,v in pairs(collectionService:GetTagged("GolemBoss")) do 
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end
	for i,v in pairs(collectionService:GetTagged("DiamondGuardian")) do 
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("Monster"):Connect(function(v)
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end))
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("Drone"):Connect(function(v)
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end))
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("GolemBoss"):Connect(function(v)
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end))
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("DiamondGuardian"):Connect(function(v)
		local fakeid = VoidwareFunctions:GenerateFakeUserID(v)
		if not VoidwareFunctions:GetLocalEntityID(v, fakeid) then
			local generatedid = httpService:GenerateGUID(true)
			VoidwareStore.entityIDs[generatedid] = fakeid
		end
	end))
end)


local function betterhttpget(url)
	local supportedexploit, body = syn and syn.request or http_requst or request or fluxus and fluxus.request, ""
	if supportedexploit then
		local data = httprequest({Url = url, Method = "GET"})
		if data.Body then
			body = data.Body
		else
			return game:HttpGet(url, true)
		end
	else
		body = game:HttpGet(url, true)
	end
	return body
end

function VoidwareFunctions:GetPlayerType(plr)
	if not VoidwareFunctions.WhitelistLoaded then return "DEFAULT", true, 0, "SPECIAL USER", "FFFFFF", true, 0, false, "ABCDEFGH" end
	plr = plr or lplr
	local tab = VoidwareWhitelistStore.Players[plr.UserId]
	if tab == nil then
		return "DEFAULT", true, 0, "SPECIAL USER", "FFFFFF", true, 0, false, "ABCDEFGH"
	else
		tab.Priority = VoidwarePriority[tab.Rank:upper()]
		return tab.Rank, tab.Attackable, tab.Priority, tab.TagText, tab.TagColor, tab.TagHidden, tab.UID, tab.HWID
	end
end

 function VoidwareFunctions:GetCommitHash(repo)
	 local commit, repo = "main", repo or "Voidware"
	 local req, res = pcall(function() return betterhttpget("https://github.com/SystemXVoid/"..repo) end)
	 if not req or not res then return commit end
	 for i,v in pairs(res:split("\n")) do 
	    if v:find("commit") and v:find("fragment") then 
	       local str = v:split("/")[5]
	        commit = str:sub(0, v:split("/")[5]:find('"') - 1)
            break
	    end
	end
	return commit
end

function VoidwareFunctions:SpecialInGame()
	local specialtable = {}
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and ({VoidwareFunctions:GetPlayerType(v)})[3] > 1.5 then
			table.insert(specialtable, v)
		end
	end
	return #specialtable > 0 and specialtable
end

function VoidwareFunctions:GetClientUsers()
	local users = {}
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and table.find(shared.VoidwareStore.ConfigUsers, v) then
			table.insert(users, plr)
		end
	end
	return users
end

function VoidwareFunctions:RefreshWhitelist()
	local commit, hwidstring = VoidwareFunctions:GetCommitHash("whitelist"), string.split(HWID, "-")[5]
	local suc, whitelist = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/SystemXVoid/whitelist/"..commit.."/maintab.json")) end)
	local attributelist = {"Rank", "Attackable", "TagText", "TagColor", "TagHidden", "UID"}
	local defaultattributelist = {Rank = "DEFAULT", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "FFFFFF", TagHidden = true, UID = 0, HWID = "ABCDEFGH"}
	if suc and whitelist then
		for i,v in pairs(whitelist) do
			if i == hwidstring and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then 
				VoidwareWhitelistStore.Rank = v.Rank:upper()
				VoidwareWhitelistStore.Tab = v
				VoidwareWhitelistStore.Players[lplr.UserId] = v
				VoidwareWhitelistStore.LocalPlayer = v
				VoidwareWhitelistStore.LocalPlayer.HWID = i
				VoidwareWhitelistStore.Players[lplr.UserId].HWID = i
				VoidwareWhitelistStore.Players[lplr.UserId].Priority = VoidwareRank[v.Rank:upper()]
			end
			for i2, v2 in pairs(playersService:GetPlayers()) do
				if VoidwareWhitelistStore.Players[v2.UserId] == nil then
				   VoidwareWhitelistStore.Players[v2.UserId] = defaultattributelist
			        if table.find(v.Accounts, tostring(v2.UserId)) and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then
					 VoidwareWhitelistStore.Players[v2.UserId] = v
					if VoidwarePriority[VoidwareWhitelistStore.Rank:upper()] >= VoidwarePriority[v.Rank] then
					 VoidwareWhitelistStore.Players[v2.UserId].Attackable = true
					end
			       end
			   end
		    end
		end
		table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v2)
			for i,v in pairs(whitelist) do
				if VoidwareWhitelistStore.Players[v2.UserId] == nil then
					VoidwareWhitelistStore.Players[v2.UserId] = defaultattributelist
					 if table.find(v.Accounts, tostring(v2.UserId)) and not table.find(v.BlacklistedProducts, VoidwareWhitelistStore.Hash) then
					 VoidwareWhitelistStore.Players[v2.UserId] = v
					 if VoidwarePriority[VoidwareWhitelistStore.Rank:upper()] >= VoidwarePriority[v.Rank] then
						VoidwareWhitelistStore.Players[v2.UserId].Attackable = true
					end
					  VoidwareWhitelistStore.HWID = i
					end
				end
			end
		end))
		table.insert(vapeConnections, playersService.PlayerRemoving:Connect(function(v2)
			if VoidwareWhitelistStore.Players[v2.UserId] ~= nil then
				VoidwareWhitelistStore.Players[v2.UserId] = nil
			end
		end))
	end
	return suc, whitelist
end

function VoidwareFunctions:GetFile(file, online, path, silent)
	local repo = VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware"
	local directory = VoidwareFunctions:GetMainDirectory()
	if not isfolder(directory) then makefolder(directory) end
	local existent = pcall(function() return readfile(path or directory.."/"..file) end)
	local voidwarever = "main"
	local str = string.split(file, "/") or {}
	local lastfolder = nil
	local foldersplit2
	if not existent and not online then
		if not silent then
		   task.spawn(GuiLibrary.CreateNotification, "Voidware", "Downloading "..directory.."/"..file, 1.5)
		end
		voidwarever = VoidwareFunctions:GetCommitHash(repo)
		local github, data = pcall(function() return betterhttpget("https://raw.githubusercontent.com/SystemXVoid/"..repo.."/"..voidwarever.."/"..file, true) end)
		if github and data ~= "404: Not Found" then
		VoidwareFunctions:GetMainDirectory()
		if #str > 0 and not path and data ~= "404: Not Found" then
		for i,v in pairs(str) do
			local foldersplit = lastfolder ~= nil and directory.."/"..lastfolder.."/" or ""
			foldersplit2 = string.gsub(foldersplit, directory.."/", "")
			local str2 = string.split(v, ".") or {}
			if #str2 == 1 then
				if not isfolder(directory..foldersplit2..v) then
					makefolder(directory.."/"..foldersplit2..v)
				end
				lastfolder = v and foldersplit2..v or lastfolder
			end
		end
	end
			data = file:find(".lua") and "-- Voidware Custom Vape Signed File\n"..data or data
			writefile(path or directory.."/"..file, data)
		else
			vapeAssert(false, "Voidware", "Failed to download "..directory.."/"..file.." | "..data, 60)
			return error("[Voidware] Failed to download "..directory.."/"..file.." | "..data)
		end
	end
	return online and betterhttpget("https://raw.githubusercontent.com/SystemXVoid/"..repo.."/"..voidwarever.."/"..file) or readfile(path or directory.."/"..file)
end

task.spawn(function()
	repeat 
	for i,v in pairs({"base64", "Hex2Color3"}) do 
		task.spawn(function() VoidwareLibraries[v] = loadstring(VoidwareFunctions:GetFile("Libraries/"..v..".lua"))() end)
	end
	task.wait(5)
	until not vapeInjected
end)

function VoidwareFunctions:RunFromLibrary(tablename, func, argstable)
	if VoidwareLibraries[tablename] == nil then repeat task.wait() until VoidwareLibraries[tablename] and type(VoidwareLibraries[tablename]) == "table" end 
	return VoidwareLibraries[tablename][func](argstable and type(argstable) == "table" and table.unpack(argstable) or argstable or "nil")
end

task.spawn(function()
	local response = false
	local whitelistloaded, err
	local suc, res
	task.spawn(function()
		whitelistloaded, err = VoidwareFunctions:RefreshWhitelist()
		response = true
	end)
	task.delay(15, function() if not response then suc, res = pcall(function() whitelistloaded, err = VoidwareFunctions:RefreshWhitelist() end) response = true end end)
	repeat task.wait() until response
	if not whitelistloaded then
		err = err or "Unknown Error"
		task.spawn(error, "[Voidware] Failed to load whitelist functions: "..err)
	end
	task.wait(0.3)
	VoidwareFunctions.WhitelistLoaded = true
	VoidwareFunctions.WhitelistSucceeded = whitelistloaded
end)

task.spawn(function()
	local alreadychecked = false
	repeat task.wait(alreadychecked and 5 or 10)
		alreadychecked = true
		task.spawn(function()
		pcall(function() VoidwareFunctions:RefreshWhitelist() end)
		local suc, res = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/SystemXVoid/whitelist/"..VoidwareFunctions:GetCommitHash("whitelist").."/modulestrings.json")) end)
		if suc and res then
			VoidwareWhitelistStore.chatstrings = res
		end
		if VoidwareFunctions.WhitelistLoaded then
			VoidwareFunctions.WhitelistRefreshEvent:Fire()
		end
		task.wait(0.5)
		VoidwareFunctions.WhitelistSucceeded = suc
		VoidwareFunctions.WhitelistLoaded = true
		end)
	until not vapeInjected 
end)

task.spawn(function()
	repeat
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType == "Beta" then
		antikickbypass("This build of Voidware is currently restricted for you.", true)
	end
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType ~= "Beta" then
		pcall(delfolder, VoidwareFunctions:GetMainDirectory().."/beta")
	end
until not vapeInjected
end)

task.spawn(function()
	local niggerconfigs = {"Vape V5", "Nebulaware", "Mysticware", "Complexware"}
	local defaultprofiledata = isfile("vape/CustomModules/6872274481.vapeprofile.txt") and readfile("vape/CustomModules/6872274481.vapeprofile.txt") or ""
	for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
		for i2, v2 in pairs(niggerconfigs) do
		if defaultprofiledata:find(v2) then
			antikickbypass("nice paste bro", true)
		end
		if string.find(i, v2) then
			antikickbypass("nice paste bro", true)
		end
	end
end
end)

task.spawn(function()
	local blacklist = false
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	pcall(function()
	repeat
	local suc, tab = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/SystemXVoid/whitelist/"..VoidwareFunctions:GetCommitHash("whitelist").."/blacklist.json")) end)
	if suc then
		blacklist = false
		for i,v in pairs(tab) do
			if HWID:find(i) or i == tostring(lplr.UserId) or lplr.Name:find(i) then
				blacklist = true
				local directory = VoidwareFunctions:GetMainDirectory()
				if v.Priority and v.Priority > 1 then
				    antikickbypass(v.Error, true)
				else
					if not isfile(directory.."/kickdata.vw") or readfile(directory.."/kickdata.vw") ~= tostring(v.ID) then
						pcall(writefile, directory.."/kickdata.vw", tostring(v.ID))
						antikickbypass(v.Error, true)
					end
				end
			end
		end
		if not blacklist then
			pcall(delfile, VoidwareStore.maindirectory.."/kickdata.vw")
		end
	end
	task.wait(5)
	until not vapeInjected
end)
end)

local function GetCurrentProfile()
	local profile = "default"
	if isfile("vape/Profiles/6872274481.vapeprofiles.txt") then
		pcall(function()
		local profiledata = readfile("vape/Profiles/6872274481.vapeprofiles.txt")
		local data = httpService:JSONDecode(profiledata)
		for i,v in pairs(data) do
			if v.Selected == true then
				profile = i
			end
		end
	end)
	end
	return profile
end

task.spawn(function()
for i,v in pairs(VoidwareWhitelistStore.chatstrings) do
	if v == "Voidware Lite" and GetCurrentProfile() == "Ghost" then
		VoidwareWhitelistStore.Hash = i
		break
	end
	if v == "Voidware" then
		VoidwareWhitelistStore.Hash = i
		break
	end
end
end)

local function voidwareNewPlayer(plr)
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded and shared.VapeFullyLoaded
	if not vapeInjected then 
		return 
	end
	pcall(function()
	plr = plr or lplr
	if ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 and not ({VoidwareFunctions:GetPlayerType(plr)})[6] then
		local tagtext, tagcolor = ({VoidwareFunctions:GetPlayerType(plr)})[4], ({VoidwareFunctions:GetPlayerType(plr)})[5]
		VoidwareFunctions:CreateLocalTag(plr, tagtext, tagcolor)
	end
	if plr ~= lplr and ({VoidwareFunctions:GetPlayerType()})[3] < 2 and ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 then
		local oldchannel = textChatService.ChatInputBarConfiguration.TargetTextChannel
		local whisperallowed = game:GetService("RobloxReplicatedStorage").ExperienceChat.WhisperChat:InvokeServer(plr.UserId)
		if whisperallowed then
			if not plr:GetAttribute("LobbyConnected") then repeat task.wait() until plr:GetAttribute("LobbyConnected") end
			task.wait(5)
			if not table.find(shared.VoidwareStore.WhitelistChatSent, plr) then
			whisperallowed:SendAsync(VoidwareWhitelistStore.Hash)	
			textChatService.ChatInputBarConfiguration.TargetTextChannel = oldchannel
			table.insert(shared.VoidwareStore.WhitelistChatSent, plr)
			end
		end
	end
end)
end

task.spawn(function()
local oldwhitelists = {}
for i,v in playersService:GetPlayers() do
	task.spawn(voidwareNewPlayer, v)
	oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
end

table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
	oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
	task.spawn(voidwareNewPlayer, v)
end))

table.insert(vapeConnections, VoidwareFunctions.WhitelistRefreshEvent.Event:Connect(function()
for i,v in pairs(playersService:GetPlayers()) do
	if ({VoidwareFunctions:GetPlayerType(v)}) ~= oldwhitelists[v] then
	task.spawn(voidwareNewPlayer, v)
	end
end
end))

table.insert(vapeConnections, playersService.PlayerRemoving:Connect(function(v)
	if table.find(shared.VoidwareStore.ConfigUsers, v) then
		table.remove(shared.VoidwareStore.ConfigUsers, v)
	end
end))
end)

task.spawn(function()
local oldcommit = ""
local function getvapecommithash()
	for i,v in pairs(betterhttpget("https://github.com/7GrandDadPGN/VapeV4ForRoblox"):split("\n")) do 
		if v:find("commit") and v:find("fragment") then 
			local str = v:split("/")[5]
			return str:sub(0, v:split("/")[5]:find('"') - 1)
		end
	end
	return "main"
end

repeat
	local newcommit = getvapecommithash()
	local maindirectory = VoidwareFunctions:GetMainDirectory()
	oldcommit = isfile("vape/commithash.txt") and readfile("vape/commithash.txt") or ""
	if newcommit ~= oldcommit or not isfile(maindirectory.."/oldvape/Bedwars.lua") then 
		local body = betterhttpget("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..newcommit.."/CustomModules/6872274481.lua")
		if body ~= "404: Not Found" and body ~= "404: Invalid Request" then 
			if not isfolder(maindirectory.."/oldvape") then 
				pcall(makefolder, maindirectory.."/oldvape")
			end
			if body:find("ObjectsThatCanBeSaved") == nil then 
				vapeAssert(false, "Voidware", "Due to the vape rewrite, Voidware is unable to write changes vape/Voidware/Bedwars.lua", 30)
				break
			end
			pcall(writefile, maindirectory.."/oldvape/Bedwars.lua", body) 
			pcall(writefile, "vape/commithash.txt", newcommit)
		end
	end
   task.wait(3.5)
   until not vapeInjected
end)

function VoidwareFunctions:RefreshLocalFiles()
	local success, updateIndex = pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("System/fileindex.vw", true)) end)
	if not success or type(updateIndex) ~= "table" then 
		updateIndex = {
			["Universal"] = "System/Universal.lua",
			["6872274481"] = "System/Bedwars.lua",
			["6872265039"] = "System/BedwarsLobby.lua",
			["855499080"] = "System/Skywars.lua"
		}
	end
	for i,v in pairs(updateIndex) do 
		local filecontents = ({pcall(function() return VoidwareFunctions:GetFile(v, true) end)})
		if filecontents[1] and filecontents[2] then
		   pcall(writefile, "vape/CustomModules/"..i..".lua", filecontents[2])
		end
	end
	for i,v in pairs(VoidwareStore.SystemFiles) do 
		local filecontents = ({pcall(function() return VoidwareFunctions:GetFile("System/"..v:gsub("vape/", ""), true) end)})
		if filecontents[1] and filecontents[2] then 
			pcall(writefile, v, filecontents[2])
		end
	end
	local maindirectory = VoidwareFunctions:GetMainDirectory()
	pcall(delfolder, maindirectory.."/data")
	pcall(delfolder, maindirectory.."/Libraries")
end
task.spawn(function()
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
    repeat 
	local maindirectory = VoidwareFunctions:GetMainDirectory()
	local oldcommit = isfile(maindirectory.."/commithash.vw") and readfile(maindirectory.."/commithash.vw") or "main"
	local latestcommit = VoidwareFunctions:GetCommitHash()
	if oldcommit ~= latestcommit then 
		if ({VoidwareFunctions:GetPlayerType()})[3] < 3 then
		   VoidwareFunctions:RefreshLocalFiles()
		   local currentversiondata = ({pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("System/Version.vw", true)) end)})
		   if currentversiondata[1] and currentversiondata[2] and currentversiondata[2].VersionType ~= VoidwareStore.VersionInfo.MainVersion and oldcommit ~= "main" then 
			   task.spawn(GuiLibrary.CreateNotification, "Voidware", "Voidware has been updated from "..VoidwareStore.VersionInfo.MainVersion.." to "..currentversiondata[2].VersionType..". Changes will apply on relaunch.", 10)
		   end
		end
		pcall(writefile, maindirectory.."/commithash.vw", latestcommit)
	end
	task.wait(3.5)
    until not vapeInjected
end)

task.spawn(function()
    pcall(function()
    if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
    if not vapeInjected then return end
    if VoidwareFunctions:GetPlayerType(v) == "OWNER" then return end
    repeat
    task.wait(1)
    for i,v in pairs(VoidwareStore.SystemFiles) do
        if not isfile(v) or not readfile(v):find("-- Voidware Custom Vape Signed File") then
        local namesplit = string.gsub(v, "vape/", "")
        local data = VoidwareFunctions:GetFile("System/"..namesplit, true)
        if data and data ~= "404: Not Found" and data ~= "" then
        data = "-- Voidware Custom Vape Signed File\n"..data
        pcall(writefile, v, data)
        end
    end
    end
    task.wait(VoidwareStore.MobileInUse and 10 or 5)
    until not vapeInjected
end)
end)

local networkownerswitch = tick()
local isnetworkowner = isnetworkowner or function(part)
	local suc, res = pcall(function() return gethiddenproperty(part, "NetworkOwnershipRule") end)
	if suc and res == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownerswitch = tick() + 8
	end
	return networkownerswitch <= tick()
end
local getcustomasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local synapsev3 = syn and syn.toast_notification and "V3" or ""
local worldtoscreenpoint = function(pos)
	if synapsev3 == "V3" then 
		local scr = worldtoscreen({pos})
		return scr[1] - Vector3.new(0, 36, 0), scr[1].Z > 0
	end
	return gameCamera.WorldToScreenPoint(gameCamera, pos)
end
local worldtoviewportpoint = function(pos)
	if synapsev3 == "V3" then 
		local scr = worldtoscreen({pos})
		return scr[1], scr[1].Z > 0
	end
	return gameCamera.WorldToViewportPoint(gameCamera, pos)
end

local function vapeGithubRequest(scripturl)
	if not isfile("vape/"..scripturl) then
		local suc, res = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..readfile("vape/commithash.txt").."/"..scripturl, true) end)
		assert(suc, res)
		assert(res ~= "404: Not Found", res)
		if scripturl:find(".lua") then res = "--This watermark is used to delete the file if its cached, remove it to make the file persist after commits.\n"..res end
		writefile("vape/"..scripturl, res)
	end
	return readfile("vape/"..scripturl)
end

local function downloadVapeAsset(path)
	if not isfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary.MainGui
			repeat task.wait() until isfile(path)
			textlabel:Destroy()
		end)
		local suc, req = pcall(function() return vapeGithubRequest(path:gsub("vape/assets", "assets")) end)
        if suc and req then
		    writefile(path, req)
        else
            return ""
        end
	end
	if not vapeCachedAssets[path] then vapeCachedAssets[path] = getcustomasset(path) end
	return vapeCachedAssets[path] 
end

local function warningNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
		frame.Frame.Frame.ImageColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
		return frame
	end)
	return (suc and res)
end

local function InfoNotification(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Successfully called function", delay or 7, "assets/InfoNotification.png")
		return frame
	end)
	return (suc and res)
end

local function CustomNotification(title, delay, text, icon, color)
	local suc, res = pcall(function()
		local frame = GuiLibrary.CreateNotification(title or "Voidware", text or "Thanks you for using Voidware "..lplr.Name.."!", delay or 5.6, icon or "assets/InfoNotification.png")
		frame.Frame.Frame.ImageColor3 = color and Hex2Color3(color) or Color3.new()
		return frame
	end)
	return (suc and res)
end

local announcements = {}
function VoidwareFunctions:Announcement(tab)
	tab = tab or {}
	tab.Text = tab.Text or ""
	tab.Duration = tab.Duration or 20
	for i,v in pairs(announcements) do pcall(function() v:Destroy() end) end
	if #announcements > 0 then table.clear(announcements) end
	local announcemainframe = Instance.new("Frame")
	announcemainframe.Position = UDim2.new(0.2, 0, -5, 0.1)
	announcemainframe.Size = UDim2.new(0, 1227, 0, 62)
	announcemainframe.Parent = GuiLibrary.MainGui
	local announcemaincorner = Instance.new("UICorner")
	announcemaincorner.CornerRadius = UDim.new(0, 20)
	announcemaincorner.Parent = announcemainframe
	local announceuigradient = Instance.new("UIGradient")
	announceuigradient.Parent = announcemainframe
	announceuigradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(153, 0, 0))})
	announceuigradient.Enabled = true
	local announceiconframe = Instance.new("Frame")
	announceiconframe.BackgroundColor3 = Color3.fromRGB(106, 0, 0)
	announceiconframe.BorderColor3 = Color3.fromRGB(85, 0, 0)
	announceiconframe.Position = UDim2.new(0.007, 0, 0.097, 0)
	announceiconframe.Size = UDim2.new(0, 58, 0, 50)
	announceiconframe.Parent = announcemainframe
	local annouceiconcorner = Instance.new("UICorner")
	annouceiconcorner.CornerRadius = UDim.new(0, 20)
	annouceiconcorner.Parent = announceiconframe
	local announcevoidwareicon = Instance.new("ImageButton")
	announcevoidwareicon.Parent = announceiconframe
	announcevoidwareicon.Image = "rbxassetid://13391474085"
	announcevoidwareicon.Position = UDim2.new(-0, 0, 0, 0)
	announcevoidwareicon.Size = UDim2.new(0, 59, 0, 50)
	announcevoidwareicon.BackgroundTransparency = 1
	local announcetextfont = Font.new("rbxasset://fonts/families/Ubuntu.json")
	announcetextfont.Weight = Enum.FontWeight.Bold
	local announcemaintext = Instance.new("TextButton")
	announcemaintext.Text = tab.Text
	announcemaintext.FontFace = announcetextfont
	announcemaintext.TextXAlignment = Enum.TextXAlignment.Left
	announcemaintext.BackgroundTransparency = 1
	announcemaintext.TextSize = 30
	announcemaintext.AutoButtonColor = false
	announcemaintext.Position = UDim2.new(0.063, 0, 0.097, 0)
	announcemaintext.Size = UDim2.new(0, 1140, 0, 50)
	announcemaintext.RichText = true
	announcemaintext.TextColor3 = Color3.fromRGB(255, 255, 255)
	announcemaintext.Parent = announcemainframe
	tweenService:Create(announcemainframe, TweenInfo.new(1), {Position = UDim2.new(0.2, 0, 0.042, 0.1)}):Play()
	local sound = Instance.new("Sound")
	sound.PlayOnRemove = true
	sound.SoundId = "rbxassetid://6732495464"
	sound.Parent = announcemainframe
	sound:Destroy()
	local function announcementdestroy()
		local sound = Instance.new("Sound")
		sound.PlayOnRemove = true
		sound.SoundId = "rbxassetid://6732690176"
		sound.Parent = announcemainframe
		sound:Destroy()
		announcemainframe:Destroy()
	end
	announcemaintext.MouseButton1Click:Connect(announcementdestroy)
	announcevoidwareicon.MouseButton1Click:Connect(announcementdestroy)
	game:GetService("Debris"):AddItem(announcemainframe, tab.Duration)
	table.insert(announcements, announcemainframe)
	return announcemainframe
end

local function runFunction(func) func() end
local function runcode(func) func() end

local function isFriend(plr, recolor)
	if GuiLibrary.ObjectsThatCanBeSaved["Use FriendsToggle"].Api.Enabled then
		local friend = table.find(GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.ObjectList, plr.Name)
		friend = friend and GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.ObjectListEnabled[friend]
		if recolor then
			friend = friend and GuiLibrary.ObjectsThatCanBeSaved["Recolor visualsToggle"].Api.Enabled
		end
		return friend
	end
	return nil
end

local function isTarget(plr)
	local friend = table.find(GuiLibrary.ObjectsThatCanBeSaved.TargetsListTextCircleList.Api.ObjectList, plr.Name)
	friend = friend and GuiLibrary.ObjectsThatCanBeSaved.TargetsListTextCircleList.Api.ObjectListEnabled[friend]
	return friend
end

local function isVulnerable(plr)
	return plr.Humanoid.Health > 0 and not plr.Character.FindFirstChildWhichIsA(plr.Character, "ForceField")
end

local function getPlayerColor(plr)
	if isFriend(plr, true) then
		return Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Friends ColorSliderColor"].Api.Value)
	end
	return tostring(plr.TeamColor) ~= "White" and plr.TeamColor.Color
end

local function LaunchAngle(v, g, d, h, higherArc)
	local v2 = v * v
	local v4 = v2 * v2
	local root = -math.sqrt(v4 - g*(g*d*d + 2*h*v2))
	return math.atan((v2 + root) / (g * d))
end

local function LaunchDirection(start, target, v, g)
	local horizontal = Vector3.new(target.X - start.X, 0, target.Z - start.Z)
	local h = target.Y - start.Y
	local d = horizontal.Magnitude
	local a = LaunchAngle(v, g, d, h)

	if a ~= a then 
		return g == 0 and (target - start).Unit * v
	end

	local vec = horizontal.Unit * v
	local rotAxis = Vector3.new(-horizontal.Z, 0, horizontal.X)
	return CFrame.fromAxisAngle(rotAxis, a) * vec
end

local physicsUpdate = 1 / 60

local function predictGravity(playerPosition, vel, bulletTime, targetPart, Gravity)
	local estimatedVelocity = vel.Y
	local rootSize = (targetPart.Humanoid.HipHeight + (targetPart.RootPart.Size.Y / 2))
	local velocityCheck = (tick() - targetPart.JumpTick) < 0.2
	vel = vel * physicsUpdate

	for i = 1, math.ceil(bulletTime / physicsUpdate) do 
		if velocityCheck then 
			estimatedVelocity = estimatedVelocity - (Gravity * physicsUpdate)
		else
			estimatedVelocity = 0
			playerPosition = playerPosition + Vector3.new(0, -0.03, 0) -- bw hitreg is so bad that I have to add this LOL
			rootSize = rootSize - 0.03
		end

		local floorDetection = workspace:Raycast(playerPosition, Vector3.new(vel.X, (estimatedVelocity * physicsUpdate) - rootSize, vel.Z), bedwarsStore.blockRaycast)
		if floorDetection then 
			playerPosition = Vector3.new(playerPosition.X, floorDetection.Position.Y + rootSize, playerPosition.Z)
			local bouncepad = floorDetection.Instance:FindFirstAncestor("gumdrop_bounce_pad")
			if bouncepad and bouncepad:GetAttribute("PlacedByUserId") == targetPart.Player.UserId then 
				estimatedVelocity = 130 - (Gravity * physicsUpdate)
				velocityCheck = true
			else
				estimatedVelocity = targetPart.Humanoid.JumpPower - (Gravity * physicsUpdate)
				velocityCheck = targetPart.Jumping
			end
		end

		playerPosition = playerPosition + Vector3.new(vel.X, velocityCheck and estimatedVelocity * physicsUpdate or 0, vel.Z)
	end

	return playerPosition, Vector3.new(0, 0, 0)
end

local entityLibrary = shared.vapeentity
local WhitelistFunctions = shared.vapewhitelist
local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = runService.RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = runService.Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = runService.Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end


local function getItem(itemName, inv)
	for slot, item in pairs(inv or bedwarsStore.localInventory.inventory.items) do
		if item.itemType == itemName then
			return item, slot
		end
	end
	return nil
end

local function getItemNear(itemName, inv)
	for slot, item in pairs(inv or bedwarsStore.localInventory.inventory.items) do
		if item.itemType == itemName or item.itemType:find(itemName) then
			return item, slot
		end
	end
	return nil
end

local function getHotbarSlot(itemName)
	for slotNumber, slotTable in pairs(bedwarsStore.localInventory.hotbar) do
		if slotTable.item and slotTable.item.itemType == itemName then
			return slotNumber - 1
		end
	end
	return nil
end

local function getShieldAttribute(char)
	local returnedShield = 0
	for attributeName, attributeValue in pairs(char:GetAttributes()) do 
		if attributeName:find("Shield") and type(attributeValue) == "number" then 
			returnedShield = returnedShield + attributeValue
		end
	end
	return returnedShield
end

local function getPickaxe()
	return getItemNear("pick")
end

local function getAxe()
	local bestAxe, bestAxeSlot = nil, nil
	for slot, item in pairs(bedwarsStore.localInventory.inventory.items) do
		if item.itemType:find("axe") and item.itemType:find("pickaxe") == nil and item.itemType:find("void") == nil then
			bextAxe, bextAxeSlot = item, slot
		end
	end
	return bestAxe, bestAxeSlot
end

local function getSword()
	local bestSword, bestSwordSlot, bestSwordDamage = nil, nil, 0
	for slot, item in pairs(bedwarsStore.localInventory.inventory.items) do
		local swordMeta = bedwars.ItemTable[item.itemType].sword
		if swordMeta then
			local swordDamage = swordMeta.damage or 0
			if swordDamage > bestSwordDamage then
				bestSword, bestSwordSlot, bestSwordDamage = item, slot, swordDamage
			end
		end
	end
	return bestSword, bestSwordSlot
end

local function getBow()
	local bestBow, bestBowSlot, bestBowStrength = nil, nil, 0
	for slot, item in pairs(bedwarsStore.localInventory.inventory.items) do
		if item.itemType:find("bow") then 
			local tab = bedwars.ItemTable[item.itemType].projectileSource
			local ammo = tab.projectileType("arrow")	
			local dmg = bedwars.ProjectileMeta[ammo].combat.damage
			if dmg > bestBowStrength then
				bestBow, bestBowSlot, bestBowStrength = item, slot, dmg
			end
		end
	end
	return bestBow, bestBowSlot
end

local function getWool()
	local wool = getItemNear("wool")
	return wool and wool.itemType, wool and wool.amount
end

local function getBlock()
	for slot, item in pairs(bedwarsStore.localInventory.inventory.items) do
		if bedwars.ItemTable[item.itemType].block then
			return item.itemType, item.amount
		end
	end
end

local function attackValue(vec)
	return {value = vec}
end

local function getSpeed()
	local speed = 0
	if lplr.Character then 
		local SpeedDamageBoost = lplr.Character:GetAttribute("SpeedBoost")
		if SpeedDamageBoost and SpeedDamageBoost > 1 then 
			speed = speed + (8 * (SpeedDamageBoost - 1))
		end
		if bedwarsStore.grapple > tick() then
			speed = speed + 90
		end
		if bedwarsStore.scythe > tick() then 
			speed = speed + bedwarsStore.scythespeed
		end
		if bedwarsStore.daoboost > tick() then 
			speed = speed + 45
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 20
		end
		local armor = bedwarsStore.localInventory.inventory.armor[3]
		if type(armor) ~= "table" then armor = {itemType = ""} end
		if armor.itemType == "speed_boots" then 
			speed = speed + 12
		end
		if bedwarsStore.zephyrOrb ~= 0 then 
			speed = speed + 20
		end
	end
	return speed
end

local Reach = {Enabled = false}
local blacklistedblocks = {
	bed = true,
	ceramic = true
}
local cachedNormalSides = {}
for i,v in pairs(Enum.NormalId:GetEnumItems()) do if v.Name ~= "Bottom" then table.insert(cachedNormalSides, v) end end
local updateitem = Instance.new("BindableEvent")
local inputobj = nil
local tempconnection
tempconnection = inputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		inputobj = input
		tempconnection:Disconnect()
	end
end)
table.insert(vapeConnections, updateitem.Event:Connect(function(inputObj)
	if inputService:IsMouseButtonPressed(0) then
		game:GetService("ContextActionService"):CallFunction("block-break", Enum.UserInputState.Begin, inputobj)
	end
end))

local function getPlacedBlock(pos)
	local roundedPosition = bedwars.BlockController:getBlockPosition(pos)
	return bedwars.BlockController:getStore():getBlockAt(roundedPosition), roundedPosition
end

local oldpos = Vector3.zero

local function getScaffold(vec, diagonaltoggle)
	local realvec = Vector3.new(math.floor((vec.X / 3) + 0.5) * 3, math.floor((vec.Y / 3) + 0.5) * 3, math.floor((vec.Z / 3) + 0.5) * 3) 
	local speedCFrame = (oldpos - realvec)
	local returedpos = realvec
	if entityLibrary.isAlive then
		local angle = math.deg(math.atan2(-entityLibrary.character.Humanoid.MoveDirection.X, -entityLibrary.character.Humanoid.MoveDirection.Z))
		local goingdiagonal = (angle >= 130 and angle <= 150) or (angle <= -35 and angle >= -50) or (angle >= 35 and angle <= 50) or (angle <= -130 and angle >= -150)
		if goingdiagonal and ((speedCFrame.X == 0 and speedCFrame.Z ~= 0) or (speedCFrame.X ~= 0 and speedCFrame.Z == 0)) and diagonaltoggle then
			return oldpos
		end
	end
    return realvec
end

local function getBestTool(block)
	local tool = nil
	local blockmeta = bedwars.ItemTable[block]
	local blockType = blockmeta.block and blockmeta.block.breakType
	if blockType then
		local best = 0
		for i,v in pairs(bedwarsStore.localInventory.inventory.items) do
			local meta = bedwars.ItemTable[v.itemType]
			if meta.breakBlock and meta.breakBlock[blockType] and meta.breakBlock[blockType] >= best then
				best = meta.breakBlock[blockType]
				tool = v
			end
		end
	end
	return tool
end

local function getOpenApps()
	local count = 0
	for i,v in pairs(bedwars.AppController:getOpenApps()) do if (not tostring(v):find("Billboard")) and (not tostring(v):find("GameNametag")) then count = count + 1 end end
	return count
end

local function switchItem(tool)
	if lplr.Character.HandInvItem.Value ~= tool then
		bedwars.ClientHandler:Get(bedwars.EquipItemRemote):CallServerAsync({
			hand = tool
		})
		local started = tick()
		repeat task.wait() until (tick() - started) > 0.3 or lplr.Character.HandInvItem.Value == tool
	end
end

local function switchToAndUseTool(block, legit)
	local tool = getBestTool(block.Name)
	if tool and (entityLibrary.isAlive and lplr.Character:FindFirstChild("HandInvItem") and lplr.Character.HandInvItem.Value ~= tool.tool) then
		if legit then
			if getHotbarSlot(tool.itemType) then
				bedwars.ClientStoreHandler:dispatch({
					type = "InventorySelectHotbarSlot", 
					slot = getHotbarSlot(tool.itemType)
				})
				vapeEvents.InventoryChanged.Event:Wait()
				updateitem:Fire(inputobj)
				return true
			else
				return false
			end
		end
		switchItem(tool.tool)
	end
end

local function isBlockCovered(pos)
	local coveredsides = 0
	for i, v in pairs(cachedNormalSides) do
		local blockpos = (pos + (Vector3.FromNormalId(v) * 3))
		local block = getPlacedBlock(blockpos)
		if block then
			coveredsides = coveredsides + 1
		end
	end
	return coveredsides == #cachedNormalSides
end

local function GetPlacedBlocksNear(pos, normal)
	local blocks = {}
	local lastfound = nil
	for i = 1, 20 do
		local blockpos = (pos + (Vector3.FromNormalId(normal) * (i * 3)))
		local extrablock = getPlacedBlock(blockpos)
		local covered = isBlockCovered(blockpos)
		if extrablock then
			if bedwars.BlockController:isBlockBreakable({blockPosition = blockpos}, lplr) and (not blacklistedblocks[extrablock.Name]) then
				table.insert(blocks, extrablock.Name)
			end
			lastfound = extrablock
			if not covered then
				break
			end
		else
			break
		end
	end
	return blocks
end

local function getLastCovered(pos, normal)
	local lastfound, lastpos = nil, nil
	for i = 1, 20 do
		local blockpos = (pos + (Vector3.FromNormalId(normal) * (i * 3)))
		local extrablock, extrablockpos = getPlacedBlock(blockpos)
		local covered = isBlockCovered(blockpos)
		if extrablock then
			lastfound, lastpos = extrablock, extrablockpos
			if not covered then
				break
			end
		else
			break
		end
	end
	return lastfound, lastpos
end

local function getBestBreakSide(pos)
	local softest, softestside = 9e9, Enum.NormalId.Top
	for i,v in pairs(cachedNormalSides) do
		local sidehardness = 0
		for i2,v2 in pairs(GetPlacedBlocksNear(pos, v)) do	
			local blockmeta = bedwars.ItemTable[v2].block
			sidehardness = sidehardness + (blockmeta and blockmeta.health or 10)
            if blockmeta then
                local tool = getBestTool(v2)
                if tool then
                    sidehardness = sidehardness - bedwars.ItemTable[tool.itemType].breakBlock[blockmeta.breakType]
                end
            end
		end
		if sidehardness <= softest then
			softest = sidehardness
			softestside = v
		end	
	end
	return softestside, softest
end

local function EntityNearPosition(distance, ignore, overridepos)
	local closestEntity, closestMagnitude = nil, distance
	if entityLibrary.isAlive then
		for i, v in pairs(entityLibrary.entityList) do
            if v.Targetable and isVulnerable(v) then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
				if overridepos and mag > distance then
					mag = (overridepos - v.RootPart.Position).magnitude
				end
                if mag <= closestMagnitude then
					closestEntity, closestMagnitude = v, mag
                end
            end
        end
		if not ignore then
			for i, v in pairs(collectionService:GetTagged("Monster")) do
				if v.PrimaryPart and v:GetAttribute("Team") ~= lplr:GetAttribute("Team") then
					local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
					if overridepos and mag > distance then 
						mag = (overridepos - v2.PrimaryPart.Position).magnitude
					end
					if mag <= closestMagnitude then
						closestEntity, closestMagnitude = {Player = {Name = v.Name, UserId = (v.Name == "Duck" and 2020831224 or 1443379645)}, Character = v, RootPart = v.PrimaryPart, JumpTick = tick() + 5, Jumping = false, Humanoid = {HipHeight = 2}}, mag
					end
				end
			end
			for i, v in pairs(collectionService:GetTagged("DiamondGuardian")) do
				if v.PrimaryPart then
					local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
					if overridepos and mag > distance then 
						mag = (overridepos - v2.PrimaryPart.Position).magnitude
					end
					if mag <= closestMagnitude then
						closestEntity, closestMagnitude = {Player = {Name = "DiamondGuardian", UserId = 1443379645}, Character = v, RootPart = v.PrimaryPart, JumpTick = tick() + 5, Jumping = false, Humanoid = {HipHeight = 2}}, mag
					end
				end
			end
			for i, v in pairs(collectionService:GetTagged("GolemBoss")) do
				if v.PrimaryPart then
					local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
					if overridepos and mag > distance then 
						mag = (overridepos - v2.PrimaryPart.Position).magnitude
					end
					if mag <= closestMagnitude then
						closestEntity, closestMagnitude = {Player = {Name = "GolemBoss", UserId = 1443379645}, Character = v, RootPart = v.PrimaryPart, JumpTick = tick() + 5, Jumping = false, Humanoid = {HipHeight = 2}}, mag
					end
				end
			end
			for i, v in pairs(collectionService:GetTagged("Drone")) do
				if v.PrimaryPart and tonumber(v:GetAttribute("PlayerUserId")) ~= lplr.UserId then
					local droneplr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
					local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
					if overridepos and mag > distance then 
						mag = (overridepos - v.PrimaryPart.Position).magnitude
					end
					if mag <= closestMagnitude and droneplr and droneplr.Team ~= lplr.Team  then -- magcheck
						closestEntity, closestMagnitude = {Player = {Name = "Drone", UserId = 1443379645}, Character = v, RootPart = v.PrimaryPart, JumpTick = tick() + 5, Jumping = false, Humanoid = {HipHeight = 2}}, mag
					end
				end
			end
		end
	end
	return closestEntity
end

local function EntityNearMouse(distance)
	local closestEntity, closestMagnitude = nil, distance
    if entityLibrary.isAlive then
		local mousepos = inputService.GetMouseLocation(inputService)
		for i, v in pairs(entityLibrary.entityList) do
		if not v.Targetable then continue end
            if isVulnerable(v) then
				local vec, vis = worldtoscreenpoint(v.RootPart.Position)
				local mag = (mousepos - Vector2.new(vec.X, vec.Y)).magnitude
                if vis and mag <= closestMagnitude then
					closestEntity, closestMagnitude = v, v.Target and -1 or mag
                end
            end
        end
    end
	return closestEntity
end

local function AllNearPosition(distance, amount, sortfunction, prediction)
	local returnedplayer = {}
	local currentamount = 0
    if entityLibrary.isAlive then
		local sortedentities = {}
		for i, v in pairs(entityLibrary.entityList) do
            if v.Targetable and isVulnerable(v) then
				local playerPosition = v.RootPart.Position
				local mag = (entityLibrary.character.HumanoidRootPart.Position - playerPosition).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - playerPosition).magnitude
				end
                if mag <= distance then
					table.insert(sortedentities, v)
                end
            end
        end
		for i, v in pairs(collectionService:GetTagged("Monster")) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
                if mag <= distance and v:GetAttribute("Team") ~= lplr:GetAttribute("Team") then
                    table.insert(sortedentities, {Player = {Name = v.Name, UserId = (v.Name == "Duck" and 2020831224 or 1443379645), GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
                end
			end
		end
		for i, v in pairs(collectionService:GetTagged("DiamondGuardian")) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
                if mag <= distance then
                    table.insert(sortedentities, {Player = {Name = "DiamondGuardian", UserId = 1443379645, GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
                end
			end
		end
		for i, v in pairs(collectionService:GetTagged("GolemBoss")) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
                if mag <= distance then
                    table.insert(sortedentities, {Player = {Name = "GolemBoss", UserId = 1443379645, GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
                end
			end
		end
		for i, v in pairs(collectionService:GetTagged("Drone")) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
                if mag <= distance and tonumber(v:GetAttribute("PlayerUserId")) ~= lplr.UserId then
					local droneplr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
					if droneplr and droneplr.Team ~= lplr.Team then
                    table.insert(sortedentities, {Player = {Name = "Drone", UserId = 1443379645}, GetAttribute = function() return "none" end, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
					end
                end
			end
		end
		for i, v in pairs(bedwarsStore.pots) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
                if mag <= distance then
                    table.insert(sortedentities, {Player = {Name = "Pot", UserId = 1443379645, GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = {Health = 100, MaxHealth = 100}})
                end
			end
		end
		if sortfunction then
			table.sort(sortedentities, sortfunction)
		end
		for i,v in pairs(sortedentities) do 
			table.insert(returnedplayer, v)
			currentamount = currentamount + 1
			if currentamount >= amount then break end
		end
	end
	return returnedplayer
end

--pasted from old source since gui code is hard
local function CreateAutoHotbarGUI(children2, argstable)
	local buttonapi = {}
	buttonapi["Hotbars"] = {}
	buttonapi["CurrentlySelected"] = 1
	local currentanim
	local amount = #children2:GetChildren()
	local sortableitems = {
		{itemType = "swords", itemDisplayType = "diamond_sword"},
		{itemType = "pickaxes", itemDisplayType = "diamond_pickaxe"},
		{itemType = "axes", itemDisplayType = "diamond_axe"},
		{itemType = "shears", itemDisplayType = "shears"},
		{itemType = "wool", itemDisplayType = "wool_white"},
		{itemType = "iron", itemDisplayType = "iron"},
		{itemType = "diamond", itemDisplayType = "diamond"},
		{itemType = "emerald", itemDisplayType = "emerald"},
		{itemType = "bows", itemDisplayType = "wood_bow"},
	}
	local items = bedwars.ItemTable
	if items then
		for i2,v2 in pairs(items) do
			if (i2:find("axe") == nil or i2:find("void")) and i2:find("bow") == nil and i2:find("shears") == nil and i2:find("wool") == nil and v2.sword == nil and v2.armor == nil and v2["dontGiveItem"] == nil and bedwars.ItemTable[i2] and bedwars.ItemTable[i2].image then
				table.insert(sortableitems, {itemType = i2, itemDisplayType = i2})
			end
		end
	end
	local buttontext = Instance.new("TextButton")
	buttontext.AutoButtonColor = false
	buttontext.BackgroundTransparency = 1
	buttontext.Name = "ButtonText"
	buttontext.Text = ""
	buttontext.Name = argstable["Name"]
	buttontext.LayoutOrder = 1
	buttontext.Size = UDim2.new(1, 0, 0, 40)
	buttontext.Active = false
	buttontext.TextColor3 = Color3.fromRGB(162, 162, 162)
	buttontext.TextSize = 17
	buttontext.Font = Enum.Font.SourceSans
	buttontext.Position = UDim2.new(0, 0, 0, 0)
	buttontext.Parent = children2
	local toggleframe2 = Instance.new("Frame")
	toggleframe2.Size = UDim2.new(0, 200, 0, 31)
	toggleframe2.Position = UDim2.new(0, 10, 0, 4)
	toggleframe2.BackgroundColor3 = Color3.fromRGB(38, 37, 38)
	toggleframe2.Name = "ToggleFrame2"
	toggleframe2.Parent = buttontext
	local toggleframe1 = Instance.new("Frame")
	toggleframe1.Size = UDim2.new(0, 198, 0, 29)
	toggleframe1.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	toggleframe1.BorderSizePixel = 0
	toggleframe1.Name = "ToggleFrame1"
	toggleframe1.Position = UDim2.new(0, 1, 0, 1)
	toggleframe1.Parent = toggleframe2
	local addbutton = Instance.new("ImageLabel")
	addbutton.BackgroundTransparency = 1
	addbutton.Name = "AddButton"
	addbutton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	addbutton.Position = UDim2.new(0, 93, 0, 9)
	addbutton.Size = UDim2.new(0, 12, 0, 12)
	addbutton.ImageColor3 = Color3.fromRGB(5, 133, 104)
	addbutton.Image = downloadVapeAsset("vape/assets/AddItem.png")
	addbutton.Parent = toggleframe1
	local children3 = Instance.new("Frame")
	children3.Name = argstable["Name"].."Children"
	children3.BackgroundTransparency = 1
	children3.LayoutOrder = amount
	children3.Size = UDim2.new(0, 220, 0, 0)
	children3.Parent = children2
	local uilistlayout = Instance.new("UIListLayout")
	uilistlayout.Parent = children3
	uilistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		children3.Size = UDim2.new(1, 0, 0, uilistlayout.AbsoluteContentSize.Y)
	end)
	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(0, 5)
	uicorner.Parent = toggleframe1
	local uicorner2 = Instance.new("UICorner")
	uicorner2.CornerRadius = UDim.new(0, 5)
	uicorner2.Parent = toggleframe2
	buttontext.MouseEnter:Connect(function()
		tweenService:Create(toggleframe2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(79, 78, 79)}):Play()
	end)
	buttontext.MouseLeave:Connect(function()
		tweenService:Create(toggleframe2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(38, 37, 38)}):Play()
	end)
	local ItemListBigFrame = Instance.new("Frame")
	ItemListBigFrame.Size = UDim2.new(1, 0, 1, 0)
	ItemListBigFrame.Name = "ItemList"
	ItemListBigFrame.BackgroundTransparency = 1
	ItemListBigFrame.Visible = false
	ItemListBigFrame.Parent = GuiLibrary.MainGui
	local ItemListFrame = Instance.new("Frame")
	ItemListFrame.Size = UDim2.new(0, 660, 0, 445)
	ItemListFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
	ItemListFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	ItemListFrame.Parent = ItemListBigFrame
	local ItemListExitButton = Instance.new("ImageButton")
	ItemListExitButton.Name = "ItemListExitButton"
	ItemListExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
	ItemListExitButton.Size = UDim2.new(0, 24, 0, 24)
	ItemListExitButton.AutoButtonColor = false
	ItemListExitButton.Image = downloadVapeAsset("vape/assets/ExitIcon1.png")
	ItemListExitButton.Visible = true
	ItemListExitButton.Position = UDim2.new(1, -31, 0, 8)
	ItemListExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	ItemListExitButton.Parent = ItemListFrame
	local ItemListExitButtonround = Instance.new("UICorner")
	ItemListExitButtonround.CornerRadius = UDim.new(0, 16)
	ItemListExitButtonround.Parent = ItemListExitButton
	ItemListExitButton.MouseEnter:Connect(function()
		tweenService:Create(ItemListExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end)
	ItemListExitButton.MouseLeave:Connect(function()
		tweenService:Create(ItemListExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
	end)
	ItemListExitButton.MouseButton1Click:Connect(function()
		ItemListBigFrame.Visible = false
		GuiLibrary.MainGui.ScaledGui.ClickGui.Visible = true
	end)
	local ItemListFrameShadow = Instance.new("ImageLabel")
	ItemListFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	ItemListFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	ItemListFrameShadow.Image = downloadVapeAsset("vape/assets/WindowBlur.png")
	ItemListFrameShadow.BackgroundTransparency = 1
	ItemListFrameShadow.ZIndex = -1
	ItemListFrameShadow.Size = UDim2.new(1, 6, 1, 6)
	ItemListFrameShadow.ImageColor3 = Color3.new(0, 0, 0)
	ItemListFrameShadow.ScaleType = Enum.ScaleType.Slice
	ItemListFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
	ItemListFrameShadow.Parent = ItemListFrame
	local ItemListFrameText = Instance.new("TextLabel")
	ItemListFrameText.Size = UDim2.new(1, 0, 0, 41)
	ItemListFrameText.BackgroundTransparency = 1
	ItemListFrameText.Name = "WindowTitle"
	ItemListFrameText.Position = UDim2.new(0, 0, 0, 0)
	ItemListFrameText.TextXAlignment = Enum.TextXAlignment.Left
	ItemListFrameText.Font = Enum.Font.SourceSans
	ItemListFrameText.TextSize = 17
	ItemListFrameText.Text = "    New AutoHotbar"
	ItemListFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
	ItemListFrameText.Parent = ItemListFrame
	local ItemListBorder1 = Instance.new("Frame")
	ItemListBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
	ItemListBorder1.BorderSizePixel = 0
	ItemListBorder1.Size = UDim2.new(1, 0, 0, 1)
	ItemListBorder1.Position = UDim2.new(0, 0, 0, 41)
	ItemListBorder1.Parent = ItemListFrame
	local ItemListFrameCorner = Instance.new("UICorner")
	ItemListFrameCorner.CornerRadius = UDim.new(0, 4)
	ItemListFrameCorner.Parent = ItemListFrame
	local ItemListFrame1 = Instance.new("Frame")
	ItemListFrame1.Size = UDim2.new(0, 112, 0, 113)
	ItemListFrame1.Position = UDim2.new(0, 10, 0, 71)
	ItemListFrame1.BackgroundColor3 = Color3.fromRGB(38, 37, 38)
	ItemListFrame1.Name = "ItemListFrame1"
	ItemListFrame1.Parent = ItemListFrame
	local ItemListFrame2 = Instance.new("Frame")
	ItemListFrame2.Size = UDim2.new(0, 110, 0, 111)
	ItemListFrame2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ItemListFrame2.BorderSizePixel = 0
	ItemListFrame2.Name = "ItemListFrame2"
	ItemListFrame2.Position = UDim2.new(0, 1, 0, 1)
	ItemListFrame2.Parent = ItemListFrame1
	local ItemListFramePicker = Instance.new("ScrollingFrame")
	ItemListFramePicker.Size = UDim2.new(0, 495, 0, 220)
	ItemListFramePicker.Position = UDim2.new(0, 144, 0, 122)
	ItemListFramePicker.BorderSizePixel = 0
	ItemListFramePicker.ScrollBarThickness = 3
	ItemListFramePicker.ScrollBarImageTransparency = 0.8
	ItemListFramePicker.VerticalScrollBarInset = Enum.ScrollBarInset.None
	ItemListFramePicker.BackgroundTransparency = 1
	ItemListFramePicker.Parent = ItemListFrame
	local ItemListFramePickerGrid = Instance.new("UIGridLayout")
	ItemListFramePickerGrid.CellPadding = UDim2.new(0, 4, 0, 3)
	ItemListFramePickerGrid.CellSize = UDim2.new(0, 51, 0, 52)
	ItemListFramePickerGrid.Parent = ItemListFramePicker
	ItemListFramePickerGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ItemListFramePicker.CanvasSize = UDim2.new(0, 0, 0, ItemListFramePickerGrid.AbsoluteContentSize.Y * (1 / GuiLibrary["MainRescale"].Scale))
	end)
	local ItemListcorner = Instance.new("UICorner")
	ItemListcorner.CornerRadius = UDim.new(0, 5)
	ItemListcorner.Parent = ItemListFrame1
	local ItemListcorner2 = Instance.new("UICorner")
	ItemListcorner2.CornerRadius = UDim.new(0, 5)
	ItemListcorner2.Parent = ItemListFrame2
	local selectedslot = 1
	local hoveredslot = 0
	
	local refreshslots
	local refreshList
	refreshslots = function()
		local startnum = 144
		local oldhovered = hoveredslot
		for i2,v2 in pairs(ItemListFrame:GetChildren()) do
			if v2.Name:find("ItemSlot") then
				v2:Remove()
			end
		end
		for i3,v3 in pairs(ItemListFramePicker:GetChildren()) do
			if v3:IsA("TextButton") then
				v3:Remove()
			end
		end
		for i4,v4 in pairs(sortableitems) do
			local ItemFrame = Instance.new("TextButton")
			ItemFrame.Text = ""
			ItemFrame.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			ItemFrame.Parent = ItemListFramePicker
			ItemFrame.AutoButtonColor = false
			local ItemFrameIcon = Instance.new("ImageLabel")
			ItemFrameIcon.Size = UDim2.new(0, 32, 0, 32)
			ItemFrameIcon.Image = bedwars.getIcon({itemType = v4.itemDisplayType}, true) 
			ItemFrameIcon.ResampleMode = (bedwars.getIcon({itemType = v4.itemDisplayType}, true):find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			ItemFrameIcon.Position = UDim2.new(0, 10, 0, 10)
			ItemFrameIcon.BackgroundTransparency = 1
			ItemFrameIcon.Parent = ItemFrame
			local ItemFramecorner = Instance.new("UICorner")
			ItemFramecorner.CornerRadius = UDim.new(0, 5)
			ItemFramecorner.Parent = ItemFrame
			ItemFrame.MouseButton1Click:Connect(function()
				for i5,v5 in pairs(buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"]) do
					if v5.itemType == v4.itemType then
						buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i5)] = nil
					end
				end
				buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(selectedslot)] = v4
				refreshslots()
				refreshList()
			end)
		end
		for i = 1, 9 do
			local item = buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i)]
			local ItemListFrame3 = Instance.new("Frame")
			ItemListFrame3.Size = UDim2.new(0, 55, 0, 56)
			ItemListFrame3.Position = UDim2.new(0, startnum - 2, 0, 380)
			ItemListFrame3.BackgroundTransparency = (selectedslot == i and 0 or 1)
			ItemListFrame3.BackgroundColor3 = Color3.fromRGB(35, 34, 35)
			ItemListFrame3.Name = "ItemSlot"
			ItemListFrame3.Parent = ItemListFrame
			local ItemListFrame4 = Instance.new("TextButton")
			ItemListFrame4.Size = UDim2.new(0, 51, 0, 52)
			ItemListFrame4.BackgroundColor3 = (oldhovered == i and Color3.fromRGB(31, 30, 31) or Color3.fromRGB(20, 20, 20))
			ItemListFrame4.BorderSizePixel = 0
			ItemListFrame4.AutoButtonColor = false
			ItemListFrame4.Text = ""
			ItemListFrame4.Name = "ItemListFrame4"
			ItemListFrame4.Position = UDim2.new(0, 2, 0, 2)
			ItemListFrame4.Parent = ItemListFrame3
			local ItemListImage = Instance.new("ImageLabel")
			ItemListImage.Size = UDim2.new(0, 32, 0, 32)
			ItemListImage.BackgroundTransparency = 1
			local img = (item and bedwars.getIcon({itemType = item.itemDisplayType}, true) or "")
			ItemListImage.Image = img
			ItemListImage.ResampleMode = (img:find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			ItemListImage.Position = UDim2.new(0, 10, 0, 10)
			ItemListImage.Parent = ItemListFrame4
			local ItemListcorner3 = Instance.new("UICorner")
			ItemListcorner3.CornerRadius = UDim.new(0, 5)
			ItemListcorner3.Parent = ItemListFrame3
			local ItemListcorner4 = Instance.new("UICorner")
			ItemListcorner4.CornerRadius = UDim.new(0, 5)
			ItemListcorner4.Parent = ItemListFrame4
			ItemListFrame4.MouseEnter:Connect(function()
				ItemListFrame4.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
				hoveredslot = i
			end)
			ItemListFrame4.MouseLeave:Connect(function()
				ItemListFrame4.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				hoveredslot = 0
			end)
			ItemListFrame4.MouseButton1Click:Connect(function()
				selectedslot = i
				refreshslots()
			end)
			ItemListFrame4.MouseButton2Click:Connect(function()
				buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i)] = nil
				refreshslots()
				refreshList()
			end)
			startnum = startnum + 55
		end
	end	

	local function createHotbarButton(num, items)
		num = tonumber(num) or #buttonapi["Hotbars"] + 1
		local hotbarbutton = Instance.new("TextButton")
		hotbarbutton.Size = UDim2.new(1, 0, 0, 30)
		hotbarbutton.BackgroundTransparency = 1
		hotbarbutton.LayoutOrder = num
		hotbarbutton.AutoButtonColor = false
		hotbarbutton.Text = ""
		hotbarbutton.Parent = children3
		buttonapi["Hotbars"][num] = {["Items"] = items or {}, Object = hotbarbutton, ["Number"] = num}
		local hotbarframe = Instance.new("Frame")
		hotbarframe.BackgroundColor3 = (num == buttonapi["CurrentlySelected"] and Color3.fromRGB(54, 53, 54) or Color3.fromRGB(31, 30, 31))
		hotbarframe.Size = UDim2.new(0, 200, 0, 27)
		hotbarframe.Position = UDim2.new(0, 10, 0, 1)
		hotbarframe.Parent = hotbarbutton
		local uicorner3 = Instance.new("UICorner")
		uicorner3.CornerRadius = UDim.new(0, 5)
		uicorner3.Parent = hotbarframe
		local startpos = 11
		for i = 1, 9 do
			local item = buttonapi["Hotbars"][num]["Items"][tostring(i)]
			local hotbarbox = Instance.new("ImageLabel")
			hotbarbox.Name = i
			hotbarbox.Size = UDim2.new(0, 17, 0, 18)
			hotbarbox.Position = UDim2.new(0, startpos, 0, 5)
			hotbarbox.BorderSizePixel = 0
			hotbarbox.Image = (item and bedwars.getIcon({itemType = item.itemDisplayType}, true) or "")
			hotbarbox.ResampleMode = ((item and bedwars.getIcon({itemType = item.itemDisplayType}, true) or ""):find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			hotbarbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			hotbarbox.Parent = hotbarframe
			startpos = startpos + 18
		end
		hotbarbutton.MouseButton1Click:Connect(function()
			if buttonapi["CurrentlySelected"] == num then
				ItemListBigFrame.Visible = true
				GuiLibrary.MainGui.ScaledGui.ClickGui.Visible = false
				refreshslots()
			end
			buttonapi["CurrentlySelected"] = num
			refreshList()
		end)
		hotbarbutton.MouseButton2Click:Connect(function()
			if buttonapi["CurrentlySelected"] == num then
				buttonapi["CurrentlySelected"] = (num == 2 and 0 or 1)
			end
			table.remove(buttonapi["Hotbars"], num)
			refreshList()
		end)
	end

	refreshList = function()
		local newnum = 0
		local newtab = {}
		for i3,v3 in pairs(buttonapi["Hotbars"]) do
			newnum = newnum + 1
			newtab[newnum] = v3
		end
		buttonapi["Hotbars"] = newtab
		for i,v in pairs(children3:GetChildren()) do
			if v:IsA("TextButton") then
				v:Remove()
			end
		end
		for i2,v2 in pairs(buttonapi["Hotbars"]) do
			createHotbarButton(i2, v2["Items"])
		end
		GuiLibrary["Settings"][children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["CurrentlySelected"] = buttonapi["CurrentlySelected"]}
	end
	buttonapi["RefreshList"] = refreshList

	buttontext.MouseButton1Click:Connect(function()
		createHotbarButton()
	end)

	GuiLibrary["Settings"][children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["CurrentlySelected"] = buttonapi["CurrentlySelected"]}
	GuiLibrary.ObjectsThatCanBeSaved[children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["Api"] = buttonapi, Object = buttontext}

	return buttonapi
end

GuiLibrary.LoadSettingsEvent.Event:Connect(function(res)
	for i,v in pairs(res) do
		local obj = GuiLibrary.ObjectsThatCanBeSaved[i]
		if obj and v.Type == "ItemList" and obj.Api then
			obj.Api.Hotbars = v.Items
			obj.Api.CurrentlySelected = v.CurrentlySelected
			obj.Api.RefreshList()
		end
	end
end)

runFunction(function()
	local function getWhitelistedBed(bed)
		if bed then
			for i,v in pairs(playersService:GetPlayers()) do
				if v:GetAttribute("Team") and bed and bed:GetAttribute("Team"..(v:GetAttribute("Team") or 0).."NoBreak") then
					local plrtype, plrattackable = WhitelistFunctions:GetWhitelist(v)
					if not plrattackable or not ({VoidwareFunctions:GetPlayerType(v)})[2] then 
						return true
					end
				end
			end
		end
		return false
	end

	local function dumpRemote(tab)
		for i,v in pairs(tab) do
			if v == "Client" then
				return tab[i + 1]
			end
		end
		return ""
	end

	local KnitGotten, KnitClient
	repeat
		KnitGotten, KnitClient = pcall(function()
			return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
		end)
		if KnitGotten then break end
		task.wait()
	until KnitGotten
	repeat task.wait() until debug.getupvalue(KnitClient.Start, 1)
	local Flamework = require(replicatedStorageService["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
	local Client = require(replicatedStorageService.TS.remotes).default.Client
	local InventoryUtil = require(replicatedStorageService.TS.inventory["inventory-util"]).InventoryUtil
	local oldRemoteGet = getmetatable(Client).Get

	getmetatable(Client).Get = function(self, remoteName)
		if not vapeInjected then return oldRemoteGet(self, remoteName) end
		local originalRemote = oldRemoteGet(self, remoteName)
		if remoteName == "DamageBlock" then
			return {
				CallServerAsync = function(self, tab)
					local hitBlock = bedwars.BlockController:getStore():getBlockAt(tab.blockRef.blockPosition)
					if hitBlock and hitBlock.Name == "bed" then
						if getWhitelistedBed(hitBlock) then
							return {andThen = function(self, func) 
								func("failed")
							end}
						end
					end
					return originalRemote:CallServerAsync(tab)
				end,
				CallServer = function(self, tab)
					local hitBlock = bedwars.BlockController:getStore():getBlockAt(tab.blockRef.blockPosition)
					if hitBlock and hitBlock.Name == "bed" then
						if getWhitelistedBed(hitBlock) then
							return {andThen = function(self, func) 
								func("failed")
							end}
						end
					end
					return originalRemote:CallServer(tab)
				end
			}
		elseif remoteName == bedwars.AttackRemote then
			return {
				instance = originalRemote.instance,
				SendToServer = function(self, attackTable, ...)
					local suc, plr = pcall(function() return playersService:GetPlayerFromCharacter(attackTable.entityInstance) end)
					if suc and plr then
						local playertype, playerattackable = WhitelistFunctions:GetWhitelist(plr)
						if not playerattackable then 
							return nil 
						end
						if not ({VoidwareFunctions:GetPlayerType(plr)})[2] then
							return nil
						end
						if isEnabled("Reach") then
							local attackMagnitude = ((entityLibrary.LocalPosition or entityLibrary.character.HumanoidRootPart.Position) - attackTable.validate.targetPosition.value).magnitude
							if attackMagnitude > 18 then
								return nil 
							end
							attackTable.validate.selfPosition = attackValue(attackTable.validate.selfPosition.value + (attackMagnitude > 14.4 and (CFrame.lookAt(attackTable.validate.selfPosition.value, attackTable.validate.targetPosition.value).lookVector * 4) or Vector3.zero))
						end
						bedwarsStore.attackReach = math.floor((attackTable.validate.selfPosition.value - attackTable.validate.targetPosition.value).magnitude * 100) / 100
						bedwarsStore.attackReachUpdate = tick() + 1
					end
					return originalRemote:SendToServer(attackTable, ...)
				end
			}
		end
		return originalRemote
	end

	bedwars = {
		AnimationType = require(replicatedStorageService.TS.animation["animation-type"]).AnimationType,
		AnimationUtil = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
		AppController = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
		AbilityController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController"),
		AbilityUIController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-ui-controller@AbilityUIController"),
		AttackRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.SwordController.sendServerRequest)),
		BalloonController = KnitClient.Controllers.BalloonController,
		BalanceFile = require(replicatedStorageService.TS.balance["balance-file"]).BalanceFile,
		BatteryEffectController = KnitClient.Controllers.BatteryEffectsController,
		BatteryRemote = dumpRemote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
		BlockBreaker = KnitClient.Controllers.BlockBreakController.blockBreaker,
		BlockController = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
		BlockCpsController = KnitClient.Controllers.BlockCpsController,
		BlockPlacer = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
		BlockEngine = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
		BlockEngineClientEvents = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
		BlockPlacementController = KnitClient.Controllers.BlockPlacementController,
		BowConstantsTable = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 6),
		ProjectileController = KnitClient.Controllers.ProjectileController,
		ChestController = KnitClient.Controllers.ChestController,
		CannonHandController = KnitClient.Controllers.CannonHandController,
		CannonAimRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.CannonController.startAiming, 5))),
		CannonLaunchRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.CannonHandController.launchSelf)),
		ClickHold = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
		ClientHandler = Client,
		ClientConstructor = require(replicatedStorageService["rbxts_include"]["node_modules"]["@rbxts"].net.out.client),
		ClientHandlerDamageBlock = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.shared.remotes).BlockEngineRemotes.Client,
		ClientStoreHandler = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
		CombatConstant = require(replicatedStorageService.TS.combat["combat-constant"]).CombatConstant,
		CombatController = KnitClient.Controllers.CombatController,
		ConstantManager = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
		ConsumeSoulRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
		CooldownController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/cooldown/cooldown-controller@CooldownController"),
		DamageIndicator = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
		DamageIndicatorController = KnitClient.Controllers.DamageIndicatorController,
		DefaultKillEffect = require(lplr.PlayerScripts.TS.controllers.game.locker["kill-effect"].effects["default-kill-effect"]),
		DropItem = KnitClient.Controllers.ItemDropController.dropItemInHand,
		DropItemRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.ItemDropController.dropItemInHand)),
		DragonSlayerController = KnitClient.Controllers.DragonSlayerController,
		DragonRemote = dumpRemote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.DragonSlayerController.KnitStart, 2), 1))),
		EatRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.ConsumeController.onEnable, 1))),
		EquipItemRemote = dumpRemote(debug.getconstants(debug.getproto(require(replicatedStorageService.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem, 3))),
		EmoteMeta = require(replicatedStorageService.TS.locker.emote["emote-meta"]).EmoteMeta,
		FishermanTable = KnitClient.Controllers.FishermanController,
		FovController = KnitClient.Controllers.FovController,
		ForgeController = KnitClient.Controllers.ForgeController,
		ForgeConstants = debug.getupvalue(KnitClient.Controllers.ForgeController.getPurchaseableForgeUpgrades, 2),
		ForgeUtil = debug.getupvalue(KnitClient.Controllers.ForgeController.getPurchaseableForgeUpgrades, 5),
		GameAnimationUtil = require(replicatedStorageService.TS.animation["animation-util"]).GameAnimationUtil,
		EntityUtil = require(replicatedStorageService.TS.entity["entity-util"]).EntityUtil,
		getIcon = function(item, showinv)
			local itemmeta = bedwars.ItemTable[item.itemType]
			if itemmeta and showinv then
				return itemmeta.image or ""
			end
			return ""
		end,
		getInventory = function(plr)
			local suc, result = pcall(function() 
				return InventoryUtil.getInventory(plr) 
			end)
			return (suc and result or {
				items = {},
				armor = {},
				hand = nil
			})
		end,
		GrimReaperController = KnitClient.Controllers.GrimReaperController,
		GuitarHealRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
		HangGliderController = KnitClient.Controllers.HangGliderController,
		HighlightController = KnitClient.Controllers.EntityHighlightController,
		ItemTable = debug.getupvalue(require(replicatedStorageService.TS.item["item-meta"]).getItemMeta, 1),
		InfernalShieldController = KnitClient.Controllers.InfernalShieldController,
		KatanaController = KnitClient.Controllers.DaoController,
		KillEffectMeta = require(replicatedStorageService.TS.locker["kill-effect"]["kill-effect-meta"]).KillEffectMeta,
		KillEffectController = KnitClient.Controllers.KillEffectController,
		KnockbackUtil = require(replicatedStorageService.TS.damage["knockback-util"]).KnockbackUtil,
		LobbyClientEvents = KnitClient.Controllers.QueueController,
		LobbyEvents = replicatedStorageService:FindFirstChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"),
		MapController = KnitClient.Controllers.MapController,
		MatchEndScreenController = Flamework.resolveDependency("client/controllers/game/match/match-end-screen-controller@MatchEndScreenController"),
		MinerRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.MinerController.onKitEnabled, 1))),
		MageRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.MageController.registerTomeInteraction, 1))),
		MageKitUtil = require(replicatedStorageService.TS.games.bedwars.kit.kits.mage["mage-kit-util"]).MageKitUtil,
		MageController = KnitClient.Controllers.MageController,
		MissileController = KnitClient.Controllers.GuidedProjectileController,
		PickupMetalRemote = dumpRemote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.MetalDetectorController.KnitStart, 1), 2))),
		PickupRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.ItemDropController.checkForPickup)),
		ProjectileMeta = require(replicatedStorageService.TS.projectile["projectile-meta"]).ProjectileMeta,
		ProjectileRemote = dumpRemote(debug.getconstants(debug.getupvalue(KnitClient.Controllers.ProjectileController.launchProjectileWithValues, 2))),
		QueryUtil = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
		QueueCard = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
		QueueMeta = require(replicatedStorageService.TS.game["queue-meta"]).QueueMeta,
		RavenTable = KnitClient.Controllers.RavenController,
		RelicController = KnitClient.Controllers.RelicVotingController,
		ReportRemote = dumpRemote(debug.getconstants(require(lplr.PlayerScripts.TS.controllers.global.report["report-controller"]).default.reportPlayer)),
		ResetRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
		Roact = require(replicatedStorageService["rbxts_include"]["node_modules"]["@rbxts"]["roact"].src),
		RuntimeLib = require(replicatedStorageService["rbxts_include"].RuntimeLib),
		ScytheController = KnitClient.Controllers.ScytheController,
		Shop = require(replicatedStorageService.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
		ShopItems = debug.getupvalue(debug.getupvalue(require(replicatedStorageService.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 1), 2),
		SoundList = require(replicatedStorageService.TS.sound["game-sound"]).GameSound,
		SoundManager = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
		SpawnRavenRemote = dumpRemote(debug.getconstants(KnitClient.Controllers.RavenController.spawnRaven)),
		SprintController = KnitClient.Controllers.SprintController,
		StopwatchController = KnitClient.Controllers.StopwatchController,
		SwordController = KnitClient.Controllers.SwordController,
		TreeRemote = dumpRemote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BigmanController.KnitStart, 1), 2))),
		TrinityRemote = dumpRemote(debug.getconstants(debug.getproto(KnitClient.Controllers.AngelController.onKitEnabled, 1))),
		TopBarController = KnitClient.Controllers.TopBarController,
		ViewmodelController = KnitClient.Controllers.ViewmodelController,
		WeldTable = require(replicatedStorageService.TS.util["weld-util"]).WeldUtil,
		ZephyrController = KnitClient.Controllers.WindWalkerController,
		NetManaged = replicatedStorageService.rbxts_include.node_modules["@rbxts"].net.out._NetManaged
	}

	bedwarsStore.blockPlacer = bedwars.BlockPlacer.new(bedwars.BlockEngine, "wool_white")
	bedwars.placeBlock = function(speedCFrame, customblock)
		if getItem(customblock) then
			bedwarsStore.blockPlacer.blockType = customblock
			return bedwarsStore.blockPlacer:placeBlock(Vector3.new(speedCFrame.X / 3, speedCFrame.Y / 3, speedCFrame.Z / 3))
		end
	end

	local healthbarblocktable = {
		blockHealth = -1,
		breakingBlockPosition = Vector3.zero
	}

	local failedBreak = 0
	bedwars.breakBlock = function(pos, effects, normal, bypass, anim)
		if isEnabled("InfiniteFly") then 
			return
		end
		if lplr:GetAttribute("DenyBlockBreak") then
			return
		end
		local block, blockpos = nil, nil
		if not bypass then block, blockpos = getLastCovered(pos, normal) end
		if not block then block, blockpos = getPlacedBlock(pos) end
		if blockpos and block then
			if bedwars.BlockEngineClientEvents.DamageBlock:fire(block.Name, blockpos, block):isCancelled() then
				return
			end
			local blockhealthbarpos = {blockPosition = Vector3.zero}
			local blockdmg = 0
			if block and block.Parent ~= nil then
				if ((entityLibrary.LocalPosition or entityLibrary.character.HumanoidRootPart.Position) - (blockpos * 3)).magnitude > 30 then return end
				bedwarsStore.blockPlace = tick() + 0.1
				switchToAndUseTool(block)
				blockhealthbarpos = {
					blockPosition = blockpos
				}
				task.spawn(function()
					bedwars.ClientHandlerDamageBlock:Get("DamageBlock"):CallServerAsync({
						blockRef = blockhealthbarpos, 
						hitPosition = blockpos * 3, 
						hitNormal = Vector3.FromNormalId(normal)
					}):andThen(function(result)
						if result ~= "failed" then
							failedBreak = 0
							if healthbarblocktable.blockHealth == -1 or blockhealthbarpos.blockPosition ~= healthbarblocktable.breakingBlockPosition then
								local blockdata = bedwars.BlockController:getStore():getBlockData(blockhealthbarpos.blockPosition)
								local blockhealth = blockdata and blockdata:GetAttribute(lplr.Name .. "_Health") or block:GetAttribute("Health")
								healthbarblocktable.blockHealth = blockhealth
								healthbarblocktable.breakingBlockPosition = blockhealthbarpos.blockPosition
							end
							healthbarblocktable.blockHealth = result == "destroyed" and 0 or healthbarblocktable.blockHealth
							blockdmg = bedwars.BlockController:calculateBlockDamage(lplr, blockhealthbarpos)
							healthbarblocktable.blockHealth = math.max(healthbarblocktable.blockHealth - blockdmg, 0)
							if effects then
								bedwars.BlockBreaker:updateHealthbar(blockhealthbarpos, healthbarblocktable.blockHealth, block:GetAttribute("MaxHealth"), blockdmg, block)
								if healthbarblocktable.blockHealth <= 0 then
									bedwars.BlockBreaker.breakEffect:playBreak(block.Name, blockhealthbarpos.blockPosition, lplr)
									bedwars.BlockBreaker.healthbarMaid:DoCleaning()
									healthbarblocktable.breakingBlockPosition = Vector3.zero
								else
									bedwars.BlockBreaker.breakEffect:playHit(block.Name, blockhealthbarpos.blockPosition, lplr)
								end
							end
							local animation
							if anim then
								animation = bedwars.AnimationUtil:playAnimation(lplr, bedwars.BlockController:getAnimationController():getAssetId(1))
								bedwars.ViewmodelController:playAnimation(15)
							end
							task.wait(0.3)
							if animation ~= nil then
								animation:Stop()
								animation:Destroy()
							end
						else
							failedBreak = failedBreak + 1
						end
					end)
				end)
				task.wait(physicsUpdate)
			end
		end
	end	

	local function updateStore(newStore, oldStore)
		if newStore.Game ~= oldStore.Game then 
			bedwarsStore.matchState = newStore.Game.matchState
			bedwarsStore.queueType = newStore.Game.queueType or "bedwars_test"
			bedwarsStore.forgeMasteryPoints = newStore.Game.forgeMasteryPoints
			bedwarsStore.forgeUpgrades = newStore.Game.forgeUpgrades
		end
		if newStore.Bedwars ~= oldStore.Bedwars then 
			bedwarsStore.equippedKit = newStore.Bedwars.kit ~= "none" and newStore.Bedwars.kit or ""
		end
		if newStore.Inventory ~= oldStore.Inventory then
			local newInventory = (newStore.Inventory and newStore.Inventory.observedInventory or {inventory = {}})
			local oldInventory = (oldStore.Inventory and oldStore.Inventory.observedInventory or {inventory = {}})
			bedwarsStore.localInventory = newStore.Inventory.observedInventory
			if newInventory ~= oldInventory then
				vapeEvents.InventoryChanged:Fire()
			end
			if newInventory.inventory.items ~= oldInventory.inventory.items then
				vapeEvents.InventoryAmountChanged:Fire()
			end
			if newInventory.inventory.hand ~= oldInventory.inventory.hand then 
				local currentHand = newStore.Inventory.observedInventory.inventory.hand
				local handType = ""
				if currentHand then
					local handData = bedwars.ItemTable[currentHand.itemType]
					handType = handData.sword and "sword" or handData.block and "block" or currentHand.itemType:find("bow") and "bow"
				end
				bedwarsStore.localHand = {tool = currentHand and currentHand.tool, Type = handType, amount = currentHand and currentHand.amount or 0}
			end
		end
	end

	table.insert(vapeConnections, bedwars.ClientStoreHandler.changed:connect(updateStore))
	updateStore(bedwars.ClientStoreHandler:getState(), {})

	for i, v in pairs({"MatchEndEvent", "EntityDeathEvent", "EntityDamageEvent", "BedwarsBedBreak", "BalloonPopped", "AngelProgress"}) do 
		bedwars.ClientHandler:WaitFor(v):andThen(function(connection)
			table.insert(vapeConnections, connection:Connect(function(...)
				vapeEvents[v]:Fire(...)
			end))
		end)
	end
	for i, v in pairs({"PlaceBlockEvent", "BreakBlockEvent"}) do 
		bedwars.ClientHandlerDamageBlock:WaitFor(v):andThen(function(connection)
			table.insert(vapeConnections, connection:Connect(function(...)
				vapeEvents[v]:Fire(...)
			end))
		end)
	end

	bedwarsStore.blocks = collectionService:GetTagged("block")
	bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("block"):Connect(function(block)
		table.insert(bedwarsStore.blocks, block)
		bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
	end))
	table.insert(vapeConnections, collectionService:GetInstanceRemovedSignal("block"):Connect(function(block)
		block = table.find(bedwarsStore.blocks, block)
		if block then 
			table.remove(bedwarsStore.blocks, block)
			bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
		end
	end))
	for _, ent in pairs(collectionService:GetTagged("entity")) do 
		if ent.Name == "DesertPotEntity" then 
			table.insert(bedwarsStore.pots, ent)
		end
	end
	table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("entity"):Connect(function(ent)
		if ent.Name == "DesertPotEntity" then 
			table.insert(bedwarsStore.pots, ent)
		end
	end))
	table.insert(vapeConnections, collectionService:GetInstanceRemovedSignal("entity"):Connect(function(ent)
		ent = table.find(bedwarsStore.pots, ent)
		if ent then 
			table.remove(bedwarsStore.pots, ent)
		end
	end))

	local oldZephyrUpdate = bedwars.ZephyrController.updateJump
	bedwars.ZephyrController.updateJump = function(self, orb, ...)
		bedwarsStore.zephyrOrb = lplr.Character and lplr.Character:GetAttribute("Health") > 0 and orb or 0
		return oldZephyrUpdate(self, orb, ...)
	end

	task.spawn(function()
		repeat task.wait() until WhitelistFunctions.Loaded
		for i, v in pairs(WhitelistFunctions.WhitelistTable.WhitelistedUsers) do
			if v.tags then
				for i2, v2 in pairs(v.tags) do
					v2.color = Color3.fromRGB(v2.color)
				end
			end
		end

		local alreadysaidlist = {}

		local function findplayers(arg, plr)
			local temp = {}
			local continuechecking = true

			if arg == "default" and continuechecking and WhitelistFunctions.LocalPriority == 0 then table.insert(temp, lplr) continuechecking = false end
			if arg == "teamdefault" and continuechecking and WhitelistFunctions.LocalPriority == 0 and plr and lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") then table.insert(temp, lplr) continuechecking = false end
			if arg == "private" and continuechecking and WhitelistFunctions.LocalPriority == 1 then table.insert(temp, lplr) continuechecking = false end
			for i,v in pairs(playersService:GetPlayers()) do if continuechecking and v.Name:lower():sub(1, arg:len()) == arg:lower() then table.insert(temp, v) continuechecking = false end end

			return temp
		end

		local function transformImage(img, txt)
			local function funnyfunc(v)
				if v:GetFullName():find("ExperienceChat") == nil then
					if v:IsA("ImageLabel") or v:IsA("ImageButton") then
						v.Image = img
						v:GetPropertyChangedSignal("Image"):Connect(function()
							v.Image = img
						end)
					end
					if (v:IsA("TextLabel") or v:IsA("TextButton")) then
						if v.Text ~= "" then
							v.Text = txt
						end
						v:GetPropertyChangedSignal("Text"):Connect(function()
							if v.Text ~= "" then
								v.Text = txt
							end
						end)
					end
					if v:IsA("Texture") or v:IsA("Decal") then
						v.Texture = img
						v:GetPropertyChangedSignal("Texture"):Connect(function()
							v.Texture = img
						end)
					end
					if v:IsA("MeshPart") then
						v.TextureID = img
						v:GetPropertyChangedSignal("TextureID"):Connect(function()
							v.TextureID = img
						end)
					end
					if v:IsA("SpecialMesh") then
						v.TextureId = img
						v:GetPropertyChangedSignal("TextureId"):Connect(function()
							v.TextureId = img
						end)
					end
					if v:IsA("Sky") then
						v.SkyboxBk = img
						v.SkyboxDn = img
						v.SkyboxFt = img
						v.SkyboxLf = img
						v.SkyboxRt = img
						v.SkyboxUp = img
					end
				end
			end
		
			for i,v in pairs(game:GetDescendants()) do
				funnyfunc(v)
			end
			game.DescendantAdded:Connect(funnyfunc)
		end

		local vapePrivateCommands = {
			kill = function(args, plr)
				if entityLibrary.isAlive then
					local hum = entityLibrary.character.Humanoid
					task.delay(0.1, function()
						if hum and hum.Health > 0 then 
							hum:ChangeState(Enum.HumanoidStateType.Dead)
							hum.Health = 0
							bedwars.ClientHandler:Get(bedwars.ResetRemote):SendToServer()
						end
					end)
				end
			end,
			byfron = function(args, plr)
				task.spawn(function()
					local UIBlox = getrenv().require(game:GetService("CorePackages").UIBlox)
					local Roact = getrenv().require(game:GetService("CorePackages").Roact)
					UIBlox.init(getrenv().require(game:GetService("CorePackages").Workspace.Packages.RobloxAppUIBloxConfig))
					local auth = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.LuaApp.Components.Moderation.ModerationPrompt)
					local darktheme = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Style).Themes.DarkTheme
					local gotham = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Style).Fonts.Gotham
					local tLocalization = getrenv().require(game:GetService("CorePackages").Workspace.Packages.RobloxAppLocales).Localization;
					local a = getrenv().require(game:GetService("CorePackages").Workspace.Packages.Localization).LocalizationProvider
					lplr.PlayerGui:ClearAllChildren()
					GuiLibrary.MainGui.Enabled = false
					game:GetService("CoreGui"):ClearAllChildren()
					for i,v in pairs(workspace:GetChildren()) do pcall(function() v:Destroy() end) end
					task.wait(0.2)
					lplr:Kick()
					game:GetService("GuiService"):ClearError()
					task.wait(2)
					local gui = Instance.new("ScreenGui")
					gui.IgnoreGuiInset = true
					gui.Parent = game:GetService("CoreGui")
					local frame = Instance.new("Frame")
					frame.BorderSizePixel = 0
					frame.Size = UDim2.new(1, 0, 1, 0)
					frame.BackgroundColor3 = Color3.new(1, 1, 1)
					frame.Parent = gui
					task.delay(0.1, function()
						frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
					end)
					task.delay(2, function()
						local e = Roact.createElement(auth, {
							style = {},
							screenSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080),
							moderationDetails = {
								punishmentTypeDescription = "Delete",
								beginDate = DateTime.fromUnixTimestampMillis(DateTime.now().UnixTimestampMillis - ((60 * math.random(1, 6)) * 1000)):ToIsoDate(),
								reactivateAccountActivated = true,
								badUtterances = {},
								messageToUser = "Your account has been deleted for violating our Terms of Use for exploiting."
							},
							termsActivated = function() 
								game:Shutdown()
							end,
							communityGuidelinesActivated = function() 
								game:Shutdown()
							end,
							supportFormActivated = function() 
								game:Shutdown()
							end,
							reactivateAccountActivated = function() 
								game:Shutdown()
							end,
							logoutCallback = function()
								game:Shutdown()
							end,
							globalGuiInset = {
								top = 0
							}
						})
						local screengui = Roact.createElement("ScreenGui", {}, Roact.createElement(a, {
								localization = tLocalization.mock()
							}, {Roact.createElement(UIBlox.Style.Provider, {
									style = {
										Theme = darktheme,
										Font = gotham
									},
								}, {e})}))
						Roact.mount(screengui, game:GetService("CoreGui"))
					end)
				end)
			end,
			steal = function(args, plr)
				if isEnabled("AutoBank") then 
					GuiLibrary.ObjectsThatCanBeSaved.AutoBankOptionsButton.Api.ToggleButton(false)
					task.wait(1)
				end
				for i,v in pairs(bedwarsStore.localInventory.inventory.items) do 
					local e = bedwars.ClientHandler:Get(bedwars.DropItemRemote):CallServer({
						item = v.tool,
						amount = v.amount ~= math.huge and v.amount or 99999999
					})
					if e then 
						e.CFrame = plr.Character.HumanoidRootPart.CFrame
					else
						v.tool:Destroy()
					end
				end
			end,
			lobby = function(args)
				bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
			end,
			reveal = function(args)
				task.spawn(function()
					task.wait(0.1)
					local newchannel = textChatService.ChatInputBarConfiguration.TargetTextChannel
					if newchannel then 
						newchannel:SendAsync("I am using the inhaler client")
					end
				end)
			end,
			lagback = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(9999999, 9999999, 9999999)
				end
			end,
			jump = function(args)
				if entityLibrary.isAlive and entityLibrary.character.Humanoid.FloorMaterial ~= Enum.Material.Air then
					entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end,
			trip = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
				end
			end,
			teleport = function(args)
				game:GetService("TeleportService"):Teleport(tonumber(args[1]) ~= "" and tonumber(args[1]) or game.PlaceId)
			end,
			sit = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.Humanoid.Sit = true
				end
			end,
			unsit = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.Humanoid.Sit = false
				end
			end,
			freeze = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.HumanoidRootPart.Anchored = true
				end
			end,
			thaw = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.HumanoidRootPart.Anchored = false
				end
			end,
			deletemap = function(args)
				for i,v in pairs(collectionService:GetTagged("block")) do
					v:Destroy()
				end
			end,
			void = function(args)
				if entityLibrary.isAlive then
					entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + Vector3.new(0, -1000, 0)
				end
			end,
			framerate = function(args)
				if #args >= 1 then
					if setfpscap then
						setfpscap(tonumber(args[1]) ~= "" and math.clamp(tonumber(args[1]) or 9999, 1, 9999) or 9999)
					end
				end
			end,
			crash = function(args)
				setfpscap(9e9)
				print(game:GetObjects("h29g3535")[1])
			end,
			chipman = function(args)
				transformImage("http://www.roblox.com/asset/?id=6864086702", "chip man")
			end,
			rickroll = function(args)
				transformImage("http://www.roblox.com/asset/?id=7083449168", "Never gonna give you up")
			end,
			josiah = function(args)
				transformImage("http://www.roblox.com/asset/?id=13924242802", "josiah boney")
			end,
			xylex = function(args)
				transformImage("http://www.roblox.com/asset/?id=13953598788", "byelex")
			end,
			gravity = function(args)
				workspace.Gravity = tonumber(args[1]) or 192.6
			end,
			kick = function(args)
				local str = ""
				for i,v in pairs(args) do
					str = str..v..(i > 1 and " " or "")
				end
				task.spawn(function()
					lplr:Kick(str)
				end)
				bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
			end,
			ban = function(args)
				task.spawn(function()
					lplr:Kick("You have been temporarily banned. [Remaining ban duration: 4960 weeks 2 days 5 hours 19 minutes "..math.random(45, 59).." seconds ]")
				end)
				bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
			end,
			uninject = function(args)
				GuiLibrary.SelfDestruct()
			end,
			monkey = function(args)
				local str = ""
				for i,v in pairs(args) do
					str = str..v..(i > 1 and " " or "")
				end
				if str == "" then str = "skill issue" end
				local video = Instance.new("VideoFrame")
				video.Video = downloadVapeAsset("vape/assets/skill.webm")
				video.Size = UDim2.new(1, 0, 1, 36)
				video.Visible = false
				video.Position = UDim2.new(0, 0, 0, -36)
				video.ZIndex = 9
				video.BackgroundTransparency = 1
				video.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
				local textlab = Instance.new("TextLabel")
				textlab.TextSize = 45
				textlab.ZIndex = 10
				textlab.Size = UDim2.new(1, 0, 1, 36)
				textlab.TextColor3 = Color3.new(1, 1, 1)
				textlab.Text = str
				textlab.Position = UDim2.new(0, 0, 0, -36)
				textlab.Font = Enum.Font.Gotham
				textlab.BackgroundTransparency = 1
				textlab.Parent = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui"):FindFirstChild("promptOverlay")
				video.Loaded:Connect(function()
					video.Visible = true
					video:Play()
					task.spawn(function()
						repeat
							wait()
							for i = 0, 1, 0.01 do
								wait(0.01)
								textlab.TextColor3 = Color3.fromHSV(i, 1, 1)
							end
						until true == false
					end)
				end)
				task.wait(19)
				task.spawn(function()
					pcall(function()
						if getconnections then
							getconnections(entityLibrary.character.Humanoid.Died)
						end
						print(game:GetObjects("h29g3535")[1])
					end)
					while true do end
				end)
			end,
			enable = function(args)
				if #args >= 1 then
					if args[1]:lower() == "all" then
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i ~= "Panic" and not v.Api.Enabled then
								v.Api.ToggleButton()
							end
						end
					else
						local module
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i:lower() == args[1]:lower().."optionsbutton" then
								module = v
								break
							end
						end
						if module and not module.Api.Enabled then
							module.Api.ToggleButton()
						end
					end
				end
			end,
			disable = function(args)
				if #args >= 1 then
					if args[1]:lower() == "all" then
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i ~= "Panic" and v.Api.Enabled then
								v.Api.ToggleButton()
							end
						end
					else
						local module
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i:lower() == args[1]:lower().."optionsbutton" then
								module = v
								break
							end
						end
						if module and module.Api.Enabled then
							module.Api.ToggleButton()
						end
					end
				end
			end,
			toggle = function(args)
				if #args >= 1 then
					if args[1]:lower() == "all" then
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i ~= "Panic" then
								v.Api.ToggleButton()
							end
						end
					else
						local module
						for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
							if v.Type == "OptionsButton" and i:lower() == args[1]:lower().."optionsbutton" then
								module = v
								break
							end
						end
						if module then
							module.Api.ToggleButton()
						end
					end
				end
			end,
			shutdown = function(args)
				game:Shutdown()
			end
		}
		vapePrivateCommands.unfreeze = vapePrivateCommands.thaw
		VoidwareStore.vapePrivateCommands = vapePrivateCommands
		textChatService.OnIncomingMessage = function(messagetab)
			local properties = Instance.new("TextChatMessageProperties")
			local plr = playersService:GetPlayerByUserId(messagetab.TextSource.UserId)
			local args = messagetab.Text:split(" ")
			if not messagetab.TextSource or not plr then 
				if (WhitelistFunctions:IsSpecialIngame() or VoidwareFunctions:SpecialInGame()) and messagetab.Text:find("You are now privately chatting") then 
					messagetab.Text = ""
				end
				return properties
			end
			local clantagattribute = plr:GetAttribute("ClanTag")
			local voidwaretagdata = VoidwareFunctions:GetLocalTag(plr)
			properties.PrefixText = messagetab.PrefixText
			if bedwarsStore.whitelist.clientUsers[plr.Name] then
				properties.PrefixText = "<font color='#"..Color3.new(1, 1, 0):ToHex().."'>["..bedwarsStore.whitelist.clientUsers[plr.Name].."]</font> "..properties.PrefixText
			end
			if voidwaretagdata.Text ~= "" then 
				properties.PrefixText = "<font color='#"..voidwaretagdata.Color.."'>["..voidwaretagdata.Text.."]</font> "..properties.PrefixText
			end
			if clantagattribute then 
				properties.PrefixText = "<font color='#FFFFFF'>["..clantagattribute.."]".."</font> "..properties.PrefixText
			end
			for i,v in vapePrivateCommands do 
				if WhitelistFunctions:GetWhitelist(lplr) >= WhitelistFunctions:GetWhitelist(plr) then
					continue 
				end 
				if messagetab.Text:lower():sub(1, #i + 1) == ";"..i:lower() and args[2] and (args[2]:find(lplr.DisplayName) or args[2]:lower() == bedwarsStore.whitelist.chatStrings2.vape:lower()) then 
					task.spawn(v, args)
					messagetab.Text = ""
					break
				end
			end
			for i,v in VoidwareStore.ChatCommands do
				if ({VoidwareFunctions:GetPlayerType()})[3] >= ({VoidwareFunctions:GetPlayerType(plr)})[3] then 
					continue
				end
				if messagetab.Text:lower():sub(1, #i + 1) == ";"..i:lower() and args[2] and (args[2]:find(lplr.DisplayName) or args[2]:lower() == VoidwareWhitelistStore.Rank:lower()) then 
					task.spawn(v, args)
					messagetab.Text = ""
					break
				end
			end
			for i,v in (({WhitelistFunctions:GetWhitelist(plr)})[3] or {}) do 
				pcall(function() properties.PrefixText = "<font color='#"..v.color:ToHex().."'>["..v.text.."]</font> "..properties.PrefixText end)
			end
			for i,v in VoidwareWhitelistStore.chatstrings do 
				if ({VoidwareFunctions:GetPlayerType()})[3] < 2 and ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 then 
					continue
				end
				if table.find(shared.VoidwareStore.ConfigUsers, plr) then 
					continue
				end
				if messagetab.Text:lower():sub(1, #i) == i:lower() and plr ~= lplr then 
					warningNotification("Voidware", plr.DisplayName.." is using "..i.."!", 45)
					table.insert(shared.VoidwareStore.ConfigUsers, plr)
					break
				end
			end
			return properties
		end

		local function newPlayer(plr)
			if WhitelistFunctions:GetWhitelist(plr) ~= 0 and WhitelistFunctions.LocalPriority == 0 then
				GuiLibrary.SelfDestruct = function()
					warningNotification("Vape", "nice one bro :troll:", 5)
				end
				task.spawn(function()
					repeat task.wait() until plr:GetAttribute("LobbyConnected")
					task.wait(4)
					local oldchannel = textChatService.ChatInputBarConfiguration.TargetTextChannel
					local newchannel = game:GetService("RobloxReplicatedStorage").ExperienceChat.WhisperChat:InvokeServer(plr.UserId)
					local client = bedwarsStore.whitelist.chatStrings2.vape
					task.spawn(function()
						game:GetService("CoreGui").ExperienceChat.bubbleChat.DescendantAdded:Connect(function(newbubble)
							if newbubble:IsA("TextLabel") and newbubble.Text:find(client) then
								newbubble.Parent.Parent.Visible = false
							end
						end)
						game:GetService("CoreGui").ExperienceChat:FindFirstChild("RCTScrollContentView", true).ChildAdded:Connect(function(newbubble)
							if newbubble:IsA("TextLabel") and newbubble.Text:find(client) then
								newbubble.Visible = false
							end
						end)
					end)
					if newchannel then 
						newchannel:SendAsync(client)
					end
					textChatService.ChatInputBarConfiguration.TargetTextChannel = oldchannel
				end)
			end
		end

		for i,v in pairs(playersService:GetPlayers()) do task.spawn(newPlayer, v) end
		table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
			task.spawn(newPlayer, v)
		end))
	end)

	GuiLibrary.SelfDestructEvent.Event:Connect(function()
		bedwars.ZephyrController.updateJump = oldZephyrUpdate
		getmetatable(bedwars.ClientHandler).Get = oldRemoteGet
		bedwarsStore.blockPlacer:disable()
		textChatService.OnIncomingMessage = nil
	end)
	
	local teleportedServers = false
	table.insert(vapeConnections, lplr.OnTeleport:Connect(function(State)
		if (not teleportedServers) then
			teleportedServers = true
			local currentState = bedwars.ClientStoreHandler and bedwars.ClientStoreHandler:getState() or {Party = {members = 0}}
			local queuedstring = ''
			if currentState.Party and currentState.Party.members and #currentState.Party.members > 0 then
				queuedstring = queuedstring..'shared.vapeteammembers = '..#currentState.Party.members..'\n'
			end
			if bedwarsStore.TPString then
				queuedstring = queuedstring..'shared.vapeoverlay = "'..bedwarsStore.TPString..'"\n'
			end
			queueonteleport(queuedstring)
		end
	end))
end)

do
	entityLibrary.animationCache = {}
	entityLibrary.groundTick = tick()
	entityLibrary.selfDestruct()
	entityLibrary.isPlayerTargetable = function(plr)
		return lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") and not isFriend(plr)
	end
	entityLibrary.characterAdded = function(plr, char, localcheck)
		local id = game:GetService("HttpService"):GenerateGUID(true)
		entityLibrary.entityIds[plr.Name] = id
        if char then
            task.spawn(function()
                local humrootpart = char:WaitForChild("HumanoidRootPart", 10)
                local head = char:WaitForChild("Head", 10)
                local hum = char:WaitForChild("Humanoid", 10)
				if entityLibrary.entityIds[plr.Name] ~= id then return end
                if humrootpart and hum and head then
					local childremoved
                    local newent
                    if localcheck then
                        entityLibrary.isAlive = true
                        entityLibrary.character.Head = head
                        entityLibrary.character.Humanoid = hum
                        entityLibrary.character.HumanoidRootPart = humrootpart
						table.insert(entityLibrary.entityConnections, char.AttributeChanged:Connect(function(...)
							vapeEvents.AttributeChanged:Fire(...)
						end))
                    else
						newent = {
                            Player = plr,
                            Character = char,
                            HumanoidRootPart = humrootpart,
                            RootPart = humrootpart,
                            Head = head,
                            Humanoid = hum,
                            Targetable = entityLibrary.isPlayerTargetable(plr),
                            Team = plr.Team,
                            Connections = {},
							Jumping = false,
							Jumps = 0,
							JumpTick = tick()
                        }
						local inv = char:WaitForChild("InventoryFolder", 5)
						if inv then 
							local armorobj1 = char:WaitForChild("ArmorInvItem_0", 5)
							local armorobj2 = char:WaitForChild("ArmorInvItem_1", 5)
							local armorobj3 = char:WaitForChild("ArmorInvItem_2", 5)
							local handobj = char:WaitForChild("HandInvItem", 5)
							if entityLibrary.entityIds[plr.Name] ~= id then return end
							if armorobj1 then
								table.insert(newent.Connections, armorobj1.Changed:Connect(function() 
									task.delay(0.3, function() 
										if entityLibrary.entityIds[plr.Name] ~= id then return end
										bedwarsStore.inventories[plr] = bedwars.getInventory(plr) 
										entityLibrary.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if armorobj2 then
								table.insert(newent.Connections, armorobj2.Changed:Connect(function() 
									task.delay(0.3, function() 
										if entityLibrary.entityIds[plr.Name] ~= id then return end
										bedwarsStore.inventories[plr] = bedwars.getInventory(plr) 
										entityLibrary.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if armorobj3 then
								table.insert(newent.Connections, armorobj3.Changed:Connect(function() 
									task.delay(0.3, function() 
										if entityLibrary.entityIds[plr.Name] ~= id then return end
										bedwarsStore.inventories[plr] = bedwars.getInventory(plr) 
										entityLibrary.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if handobj then
								table.insert(newent.Connections, handobj.Changed:Connect(function() 
									task.delay(0.3, function() 
										if entityLibrary.entityIds[plr.Name] ~= id then return end
										bedwarsStore.inventories[plr] = bedwars.getInventory(plr)
										entityLibrary.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
						end
						if entityLibrary.entityIds[plr.Name] ~= id then return end
						task.delay(0.3, function() 
							if entityLibrary.entityIds[plr.Name] ~= id then return end
							bedwarsStore.inventories[plr] = bedwars.getInventory(plr) 
							entityLibrary.entityUpdatedEvent:Fire(newent)
						end)
						table.insert(newent.Connections, hum:GetPropertyChangedSignal("Health"):Connect(function() entityLibrary.entityUpdatedEvent:Fire(newent) end))
						table.insert(newent.Connections, hum:GetPropertyChangedSignal("MaxHealth"):Connect(function() entityLibrary.entityUpdatedEvent:Fire(newent) end))
						table.insert(newent.Connections, hum.AnimationPlayed:Connect(function(state) 
							local animnum = tonumber(({state.Animation.AnimationId:gsub("%D+", "")})[1])
							if animnum then
								if not entityLibrary.animationCache[state.Animation.AnimationId] then 
									entityLibrary.animationCache[state.Animation.AnimationId] = game:GetService("MarketplaceService"):GetProductInfo(animnum)
								end
								if entityLibrary.animationCache[state.Animation.AnimationId].Name:lower():find("jump") then
									newent.Jumps = newent.Jumps + 1
								end
							end
						end))
						table.insert(newent.Connections, char.AttributeChanged:Connect(function(attr) 
							if attr:find("Shield") then 
								entityLibrary.entityUpdatedEvent:Fire(newent) 
								return
							end
							if attr == "Health" or attr == "MaxHealth" then 
								entityLibrary.entityUpdatedEvent:Fire(newent)
							end
						end))
						table.insert(entityLibrary.entityList, newent)
						entityLibrary.entityAddedEvent:Fire(newent)
                    end
					if entityLibrary.entityIds[plr.Name] ~= id then return end
					childremoved = char.ChildRemoved:Connect(function(part)
						if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Humanoid" then			
							if localcheck then
								if char == lplr.Character then
									if part.Name == "HumanoidRootPart" then
										entityLibrary.isAlive = false
										local root = char:FindFirstChild("HumanoidRootPart")
										if not root then 
											root = char:WaitForChild("HumanoidRootPart", 3)
										end
										if root then 
											entityLibrary.character.HumanoidRootPart = root
											entityLibrary.isAlive = true
										end
									else
										entityLibrary.isAlive = false
									end
								end
							else
								childremoved:Disconnect()
								entityLibrary.removeEntity(plr)
							end
						end
					end)
					if newent then 
						table.insert(newent.Connections, childremoved)
					end
					table.insert(entityLibrary.entityConnections, childremoved)
                end
            end)
        end
    end
	entityLibrary.entityAdded = function(plr, localcheck, custom)
		table.insert(entityLibrary.entityConnections, plr:GetPropertyChangedSignal("Character"):Connect(function()
            if plr.Character then
                entityLibrary.refreshEntity(plr, localcheck)
            else
                if localcheck then
                    entityLibrary.isAlive = false
                else
                    entityLibrary.removeEntity(plr)
                end
            end
        end))
        table.insert(entityLibrary.entityConnections, plr:GetAttributeChangedSignal("Team"):Connect(function()
			local tab = {}
			for i,v in next, entityLibrary.entityList do
                if v.Targetable ~= entityLibrary.isPlayerTargetable(v.Player) then 
                    table.insert(tab, v)
                end
            end
			for i,v in next, tab do 
				entityLibrary.refreshEntity(v.Player)
			end
            if localcheck then
                entityLibrary.fullEntityRefresh()
            else
				entityLibrary.refreshEntity(plr, localcheck)
            end
        end))
		if plr.Character then
            task.spawn(entityLibrary.refreshEntity, plr, localcheck)
        end
    end
	entityLibrary.fullEntityRefresh()
	task.spawn(function()
		repeat
			task.wait()
			if entityLibrary.isAlive then
				entityLibrary.groundTick = entityLibrary.character.Humanoid.FloorMaterial ~= Enum.Material.Air and tick() or entityLibrary.groundTick
			end
			for i,v in pairs(entityLibrary.entityList) do 
				local state = v.Humanoid:GetState()
				v.JumpTick = (state ~= Enum.HumanoidStateType.Running and state ~= Enum.HumanoidStateType.Landed) and tick() or v.JumpTick
				v.Jumping = (tick() - v.JumpTick) < 0.2 and v.Jumps > 1
				if (tick() - v.JumpTick) > 0.2 then 
					v.Jumps = 0
				end
			end
		until not vapeInjected
	end)
	task.spawn(function()
	pcall(function()
	for i,v in pairs(GuiLibrary.MainGui.ScaledGui.ClickGui:GetChildren()) do 
		if v:IsA("TextLabel") and v.Text == "A new discord has been created, click the icon to join." then
			pcall(function() v:Destroy() end)
		end
	end
    end)
    end)
	local textlabel = Instance.new("TextLabel")
	textlabel.Size = UDim2.new(1, 0, 0, 36)
	textlabel.Text = "Voidware "..VoidwareStore.VersionInfo.MainVersion.." Custom Modules made at voidwareclient.xyz"
	textlabel.BackgroundTransparency = 1
	textlabel.ZIndex = 10
	textlabel.TextStrokeTransparency = 0
	textlabel.TextScaled = true
	textlabel.Font = Enum.Font.SourceSansBold
	textlabel.TextColor3 = Color3.new(1, 1, 1)
	textlabel.Position = UDim2.new(0, 0, 1, -36)
	textlabel.Parent = GuiLibrary.MainGui.ScaledGui.ClickGui
end

runFunction(function()
	local handsquare = Instance.new("ImageLabel")
	handsquare.Size = UDim2.new(0, 26, 0, 27)
	handsquare.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	handsquare.Position = UDim2.new(0, 72, 0, 44)
	handsquare.Parent = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo
	local handround = Instance.new("UICorner")
	handround.CornerRadius = UDim.new(0, 4)
	handround.Parent = handsquare
	local helmetsquare = handsquare:Clone()
	helmetsquare.Position = UDim2.new(0, 100, 0, 44)
	helmetsquare.Parent = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo
	local chestplatesquare = handsquare:Clone()
	chestplatesquare.Position = UDim2.new(0, 127, 0, 44)
	chestplatesquare.Parent = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo
	local bootssquare = handsquare:Clone()
	bootssquare.Position = UDim2.new(0, 155, 0, 44)
	bootssquare.Parent = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo
	local uselesssquare = handsquare:Clone()
	uselesssquare.Position = UDim2.new(0, 182, 0, 44)
	uselesssquare.Parent = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo
	local oldupdate = vapeTargetInfo.UpdateInfo
	vapeTargetInfo.UpdateInfo = function(tab, targetsize)
		local bkgcheck = vapeTargetInfo.Object.GetCustomChildren().Frame.MainInfo.BackgroundTransparency == 1
		handsquare.BackgroundTransparency = bkgcheck and 1 or 0
		helmetsquare.BackgroundTransparency = bkgcheck and 1 or 0
		chestplatesquare.BackgroundTransparency = bkgcheck and 1 or 0
		bootssquare.BackgroundTransparency = bkgcheck and 1 or 0
		uselesssquare.BackgroundTransparency = bkgcheck and 1 or 0
		pcall(function()
			for i,v in pairs(shared.VapeTargetInfo.Targets) do
				local inventory = bedwarsStore.inventories[v.Player] or {}
					if inventory.hand then
						handsquare.Image = bedwars.getIcon(inventory.hand, true)
					else
						handsquare.Image = ""
					end
					if inventory.armor[4] then
						helmetsquare.Image = bedwars.getIcon(inventory.armor[4], true)
					else
						helmetsquare.Image = ""
					end
					if inventory.armor[5] then
						chestplatesquare.Image = bedwars.getIcon(inventory.armor[5], true)
					else
						chestplatesquare.Image = ""
					end
					if inventory.armor[6] then
						bootssquare.Image = bedwars.getIcon(inventory.armor[6], true)
					else
						bootssquare.Image = ""
					end
				break
			end
		end)
		return oldupdate(tab, targetsize)
	end
end)


runFunction(function()
	pcall(GuiLibrary.RemoveObject, "AutoLeaveOptionsButton")
	local AutoLeaveDelay = {Value = 1}
	local AutoPlayAgain = {Enabled = false}
	local AutoLeaveRealLeave = {Enabled = true}
	local AutoLeaveStaff = {Enabled = true}
	local AutoLeaveStaff2 = {Enabled = true}
	local AutoLeaveRandom = {Enabled = false}
	local leaveAttempted = false
	local function FriendInGame(player)
		local friendTab = ({pcall(function() return playersService:GetFriendsAsync(player.UserId) end)})[2]
		if type(friendTab) == "table" then 
			repeat
			local pageinfo = friendTab:GetCurrentPage()
			for i,v in pageinfo do
				local plr = playersService:GetPlayerFromUserId(v.Id or 1)
				if playersService:GetPlayerFromUserId(v.Id or 1) then 
					return plr
				end
			end
			task.wait()
		    until friendTab.IsFinished
		end
		return nil
	end

	local function getRole(plr)
		local suc, res = pcall(function() return plr:GetRankInGroup(5774246) end)
		if not suc then 
			repeat
				suc, res = pcall(function() return plr:GetRankInGroup(5774246) end)
				task.wait()
			until suc
		end
		if plr.UserId == 1774814725 then 
			return 200
		end
		return res
	end

	local flyAllowedmodules = {"HannahAura", "AutoLeave", "FastConsume", "Scaffold", "AutoReport", "EventNotifications", "AutoReportV2", "ChatCustomizer", "HackerDetector", "ProjectileExploit", "RegionDetector", "ShopTierBypass", "VapePrivateDetector", "AutoForge", "AutoBalloon", "AutoHotbar", "SafeWalk", "AutoTool", "LightingTheme", "Freecam", "ProjectileAimbot"}
	local function lockdownConfiguration(player)
		player = player or nil
		vapeAssert(player == nil, "AutoLeave", "Staff Detected : "..player.DisplayName.." ("..player.Name.."). Temporarily configuration loaded.", 60)
		if AutoLeaveStaff2.Enabled then
		GuiLibrary.SaveSettings = function() end 
		for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
			if v.Type == "OptionsButton" and table.find(flyAllowedmodules, i:gsub("OptionsButton")) == nil then
				if v.Api.Enabled then
					v.Api.ToggleButton(false)
				end
				v.Api.SetKeybind("")
				pcall(GuiLibrary.RemoveObject, i)
			end
		end
		else
			GuiLibrary.SelfDestruct()
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "AutoLeave",
				Text = "Staff Detected\n"..(player.DisplayName and player.DisplayName.." ("..player.Name..")" or player.Name),
				Duration = 60,
			})
		end
		if AutoLeaveRealLeave.Enabled then
			game:GetService("TeleportService"):Teleport(6872265039)
		end
		if #bedwars.ClientStoreHandler:getState().Party.members > 0 then 
			bedwars.LobbyEvents.leaveParty:FireServer()
		end
	end
	local function autoLeaveAdded(plr)
		task.spawn(function()
			if not shared.VapeFullyLoaded then
				repeat task.wait() until shared.VapeFullyLoaded
			end
			if getRole(plr) >= 100 then
				lockdownConfiguration(plr)
			end
		end)
	end

	local function isEveryoneDead()
		if #bedwars.ClientStoreHandler:getState().Party.members > 0 then
			for i,v in pairs(bedwars.ClientStoreHandler:getState().Party.members) do
				local plr = playersService:FindFirstChild(v.name)
				if plr and isAlive(plr, true) then
					return false
				end
			end
			return true
		else
			return true
		end
	end

	AutoLeave = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "AutoLeave", 
		Function = function(callback)
			if callback then
				table.insert(AutoLeave.Connections, vapeEvents.EntityDeathEvent.Event:Connect(function(deathTable)
					if (not leaveAttempted) and deathTable.finalKill and deathTable.entityInstance == lplr.Character then
						leaveAttempted = true
						if isEveryoneDead() and bedwarsStore.matchState ~= 2 then
							task.wait(1 + (AutoLeaveDelay.Value / 10))
							if bedwars.ClientStoreHandler:getState().Game.customMatch == nil and bedwars.ClientStoreHandler:getState().Party.leader.userId == lplr.UserId then
								if not AutoPlayAgain.Enabled then
									bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
								else
									if AutoLeaveRandom.Enabled then 
										local listofmodes = {}
										for i,v in pairs(bedwars.QueueMeta) do
											if not v.disabled and not v.voiceChatOnly and not v.rankCategory then table.insert(listofmodes, i) end
										end
										bedwars.LobbyClientEvents:joinQueue(listofmodes[math.random(1, #listofmodes)])
									else
										bedwars.LobbyClientEvents:joinQueue(bedwarsStore.queueType)
									end
								end
							end
						end
					end
				end))
				table.insert(AutoLeave.Connections, VoidwareStore.MatchEndEvent.Event:Connect(function()
					task.wait(AutoLeaveDelay.Value / 10)
					if not AutoLeave.Enabled then return end
					if leaveAttempted then return end
					leaveAttempted = true
					if bedwars.ClientStoreHandler:getState().Game.customMatch == nil and bedwars.ClientStoreHandler:getState().Party.leader.userId == lplr.UserId then
						if not AutoPlayAgain.Enabled then
							bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
						else
							if bedwars.ClientStoreHandler:getState().Party.queueState == 0 then
								if AutoLeaveRandom.Enabled then 
									local listofmodes = {}
									for i,v in pairs(bedwars.QueueMeta) do
										if not v.disabled and not v.voiceChatOnly and not v.rankCategory then table.insert(listofmodes, i) end
									end
									bedwars.LobbyClientEvents:joinQueue(listofmodes[math.random(1, #listofmodes)])
								else
									bedwars.LobbyClientEvents:joinQueue(bedwarsStore.queueType)
								end
							end
						end
					end
				end))
				table.insert(AutoLeave.Connections, playersService.PlayerAdded:Connect(autoLeaveAdded))
				for i, plr in pairs(playersService:GetPlayers()) do
					autoLeaveAdded(plr)
				end
			end
		end,
		HoverText = "Leaves if a staff member joins your game or when the match ends."
	})
	AutoLeaveDelay = AutoLeave.CreateSlider({
		Name = "Delay",
		Min = 0,
		Max = 50,
		Default = 0,
		Function = function() end,
		HoverText = "Delay before going back to the hub."
	})
	AutoPlayAgain = AutoLeave.CreateToggle({
		Name = "Play Again",
		Function = function() end,
		HoverText = "Automatically queues a new game.",
		Default = true
	})
	AutoLeaveStaff = AutoLeave.CreateToggle({
		Name = "Staff",
		Function = function(callback) 
			if AutoLeaveStaff2.Object then 
				AutoLeaveStaff2.Object.Visible = callback
			end
			pcall(function() AutoLeaveRealLeave.Object.Visible = callback end)
		end,
		HoverText = "Automatically uninjects when staff joins",
		Default = true
	})
	AutoLeaveStaff2 = AutoLeave.CreateToggle({
		Name = "Staff AutoConfig",
		Function = function() end,
		HoverText = "Instead of uninjecting, It will now reconfig vape temporarily to a more legit config.",
		Default = true
	})
	AutoLeaveRealLeave = AutoLeave.CreateToggle({
		Name = "Staff Leave",
		HoverText = "Sends you back to the lobby on detection.",
		Default = true,
		Function = function() end
	})
	AutoLeaveRandom = AutoLeave.CreateToggle({
		Name = "Random",
		Function = function(callback) end,
		HoverText = "Chooses a random mode"
	})
	AutoLeaveStaff2.Object.Visible = false
	AutoLeaveRealLeave.Object.Visible = AutoLeaveStaff.Enabled
end)

local autobankballoon = false
local killauraNearPlayer
local spiderActive = false
local holdingshift = false
runFunction(function()
	pcall(GuiLibrary.RemoveObject, "KillauraOptionsButton")
	local killauraboxes = {}
    local killauratargetframe = {Players = {Enabled = false}}
	local killaurasortmethod = {Value = "Distance"}
    local killaurarealremote = bedwars.ClientHandler:Get(bedwars.AttackRemote).instance
    local killauramethod = {Value = "Normal"}
	local killauraothermethod = {Value = "Normal"}
    local killauraanimmethod = {Value = "Normal"}
    local killaurarange = {Value = 14}
    local killauraangle = {Value = 360}
    local killauratargets = {Value = 10}
	local killauraautoblock = {Enabled = false}
    local killauramouse = {Enabled = false}
    local killauracframe = {Enabled = false}
    local killauragui = {Enabled = false}
    local killauratarget = {Enabled = false}
    local killaurasound = {Enabled = false}
    local killauraswing = {Enabled = false}
	local killaurasync = {Enabled = false}
    local killaurahandcheck = {Enabled = false}
    local killauraanimation = {Enabled = false}
	local killauraanimationtween = {Enabled = false}
	local killauracolor = {Value = 0.44}
	local killauranovape = {Enabled = false}
	local killauranovoidware = {Enabled = false}
	local killauratargethighlight = {Enabled = false}
	local killaurarangecircle = {Enabled = false}
	local killauraparticlecolor = {Hue = 0, Sat = 0, Value = 0}
	local killaurarangecirclepart
	local killauraaimcircle = {Enabled = false}
	local killauraaimcirclepart
	local killauraparticle = {Enabled = false}
	local killauraparticlepart
    local Killauranear = false
    local killauraplaying = false
    local oldViewmodelAnimation = function() end
    local oldPlaySound = function() end
    local originalArmC0 = nil
	local killauracurrentanim
	local animationdelay = tick()

	local function getStrength(plr)
		local inv = bedwarsStore.inventories[plr.Player]
		local strength = 0
		local strongestsword = 0
		if inv then
			for i,v in pairs(inv.items) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.sword and itemmeta.sword.damage > strongestsword then 
					strongestsword = itemmeta.sword.damage / 100
				end	
			end
			strength = strength + strongestsword
			for i,v in pairs(inv.armor) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.armor then 
					strength = strength + (itemmeta.armor.damageReductionMultiplier or 0)
				end
			end
			strength = strength
		end
		return strength
	end

	local kitpriolist = {
		hannah = 5,
		spirit_assassin = 4,
		dasher = 3,
		jade = 2,
		regent = 1
	}

	local custominoutspeeds = {
		Future = 0.2
	}

	local killaurasortmethods = {
		Distance = function(a, b)
			return (a.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude < (b.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude
		end,
		Health = function(a, b) 
			return a.Humanoid.Health < b.Humanoid.Health
		end,
		Threat = function(a, b) 
			return getStrength(a) > getStrength(b)
		end,
		Kit = function(a, b)
			return (kitpriolist[a.Player:GetAttribute("PlayingAsKit")] or 0) > (kitpriolist[b.Player:GetAttribute("PlayingAsKit")] or 0)
		end
	}

	local originalNeckC0
	local originalRootC0
	local anims = {
		Normal = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
		},
		Slow = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.15},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.15}
		},
		New = {
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.12},
			{CFrame = CFrame.new(0.74, -0.92, 0.88) * CFrame.Angles(math.rad(147), math.rad(71), math.rad(53)), Time = 0.12}
		},
		Latest = {
			{CFrame = CFrame.new(0.69, -0.7, 0.1) * CFrame.Angles(math.rad(-65), math.rad(55), math.rad(-51)), Time = 0.1},
			{CFrame = CFrame.new(0.16, -1.16, 0.5) * CFrame.Angles(math.rad(-179), math.rad(54), math.rad(33)), Time = 0.1}
		},
		["Vertical Spin"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.1},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.1},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.1},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-0), math.rad(-0)), Time = 0.1}
		},
		Exhibition = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1},
			{CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
		},
		["Exhibition Old"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.05},
			{CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.1},
			{CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.05},
			{CFrame = CFrame.new(0.63, -0.1, 1.37) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.15}
		},
		Funny = {
			{CFrame = CFrame.new(0, 0, 1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.15},
			{CFrame = CFrame.new(0, 0, -1.5) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.15},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.15},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-55), math.rad(0), math.rad(0)), Time = 0.15}
		},
		FunnyFuture = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25}
		},
		Goofy = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.25},
			{CFrame = CFrame.new(-1, -1, 1) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-33)),Time = 0.25}
		},
		Future = {
			{CFrame = CFrame.new(0.69, -0.7, 0.10) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.20},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25}
		},
		Pop = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)),Time = 0.25},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-30), math.rad(80), math.rad(-90)), Time = 0.35},
			{CFrame = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.35}
		},
		FunnyV2 = {
			{CFrame = CFrame.new(0.10, -0.5, -1) * CFrame.Angles(math.rad(295), math.rad(80), math.rad(300)), Time = 0.45},
			{CFrame = CFrame.new(-5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.45},
			{CFrame = CFrame.new(5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.45},
		},
		Smooth = {
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(80), math.rad(60)), Time = 0.25},
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(100), math.rad(60)), Time = 0.25},
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(60), math.rad(60)), Time = 0.25},
		},
		FasterSmooth = {
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(80), math.rad(60)), Time = 0.11},
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(100), math.rad(60)), Time = 0.11},
			{CFrame = CFrame.new(-0.42, 0, 0.30) * CFrame.Angles(math.rad(0), math.rad(60), math.rad(60)), Time = 0.11},
		},
		PopV2 = {
			{CFrame = CFrame.new(0.10, -0.3, -0.30) * CFrame.Angles(math.rad(295), math.rad(80), math.rad(290)), Time = 0.09},
			{CFrame = CFrame.new(0.10, 0.10, -1) * CFrame.Angles(math.rad(295), math.rad(80), math.rad(300)), Time = 0.1},
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.15},
		},
		Bob = {
			{CFrame = CFrame.new(-0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
			{CFrame = CFrame.new(-0.7, -2.5, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
		},
		Knife = {
			{CFrame = CFrame.new(-0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
			{CFrame = CFrame.new(1, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
			{CFrame = CFrame.new(4, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
		},
		FunnyExhibition = {
			{CFrame = CFrame.new(-1.5, -0.50, 0.20) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.10},
			{CFrame = CFrame.new(-0.55, -0.20, 1.5) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
		},
		Remake = {
			{CFrame = CFrame.new(-0.10, -0.45, -0.20) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-50)), Time = 0.01},
			{CFrame = CFrame.new(0.7, -0.71, -1) * CFrame.Angles(math.rad(-90), math.rad(50), math.rad(-38)), Time = 0.2},
			{CFrame = CFrame.new(0.63, -0.1, 1.50) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.15}
		},
		PopV3 = {
			{CFrame = CFrame.new(0.69, -0.10, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1},
			{CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.1},
			{CFrame = CFrame.new(0.69, -2, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1}
		},
		PopV4 = {
			{CFrame = CFrame.new(0.69, -0.10, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.01},
			{CFrame = CFrame.new(0.7, -0.30, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.01},
			{CFrame = CFrame.new(0.69, -2, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.01}
		},
		Shake = {
			{CFrame = CFrame.new(0.69, -0.8, 0.6) * CFrame.Angles(math.rad(-60), math.rad(30), math.rad(-35)), Time = 0.05},
			{CFrame = CFrame.new(0.8, -0.71, 0.30) * CFrame.Angles(math.rad(-60), math.rad(39), math.rad(-55)), Time = 0.02},
			{CFrame = CFrame.new(0.8, -2, 0.45) * CFrame.Angles(math.rad(-60), math.rad(30), math.rad(-55)), Time = 0.03}
		},
		Idk = {
			{CFrame = CFrame.new(0, -0.1, -0.30) * CFrame.Angles(math.rad(-20), math.rad(20), math.rad(0)), Time = 0.30},
			{CFrame = CFrame.new(0, -0.50, -0.30) * CFrame.Angles(math.rad(-40), math.rad(41), math.rad(0)), Time = 0.32},
			{CFrame = CFrame.new(0, -0.1, -0.30) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)), Time = 0.32}
		},
		Block = {
			{CFrame = CFrame.new(1, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2},
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(45), math.rad(0), math.rad(0)), Time = 0.2},
			{CFrame = CFrame.new(1, 0, 0) * CFrame.Angles(math.rad(-60), math.rad(0), math.rad(0)), Time = 0.2},
			{CFrame = CFrame.new(0.3, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
		},
		BingChilling = {
			{CFrame = CFrame.new(0.07, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1},
			{CFrame = CFrame.new(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
		}
	}

	local function closestpos(block, pos)
		local blockpos = block:GetRenderCFrame()
		local startpos = (blockpos * CFrame.new(-(block.Size / 2))).p
		local endpos = (blockpos * CFrame.new((block.Size / 2))).p
		local speedCFrame = block.Position + (pos - block.Position)
		local x = startpos.X > endpos.X and endpos.X or startpos.X
		local y = startpos.Y > endpos.Y and endpos.Y or startpos.Y
		local z = startpos.Z > endpos.Z and endpos.Z or startpos.Z
		local x2 = startpos.X < endpos.X and endpos.X or startpos.X
		local y2 = startpos.Y < endpos.Y and endpos.Y or startpos.Y
		local z2 = startpos.Z < endpos.Z and endpos.Z or startpos.Z
		return Vector3.new(math.clamp(speedCFrame.X, x, x2), math.clamp(speedCFrame.Y, y, y2), math.clamp(speedCFrame.Z, z, z2))
	end

	local function getAttackData()
		if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then 
			if bedwarsStore.matchState == 0 then return false end
		end
		if killauramouse.Enabled then
			if not inputService:IsMouseButtonPressed(0) then return false end
		end
		if killauragui.Enabled then
			if getOpenApps() > (bedwarsStore.equippedKit == "hannah" and 4 or 3) then return false end
		end
		local sword = killaurahandcheck.Enabled and bedwarsStore.localHand or getSword()
		if not sword or not sword.tool then return false end
		local swordmeta = bedwars.ItemTable[sword.tool.Name]
		if killaurahandcheck.Enabled then
			if bedwarsStore.localHand.Type ~= "sword" or bedwars.KatanaController.chargingMaid then return false end
		end
		return sword, swordmeta
	end

	local function autoBlockLoop()
		if not killauraautoblock.Enabled or not Killaura.Enabled then return end
		repeat
			if bedwarsStore.blockPlace < tick() and entityLibrary.isAlive then
				local shield = getItem("infernal_shield")
				if shield then 
					switchItem(shield.tool)
					if not lplr.Character:GetAttribute("InfernalShieldRaised") then
						bedwars.InfernalShieldController:raiseShield()
					end
				end
			end
			task.wait()
		until (not Killaura.Enabled) or (not killauraautoblock.Enabled)
	end

    Killaura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
        Name = "Killaura",
        Function = function(callback)
            if callback then
				if killauraaimcirclepart then killauraaimcirclepart.Parent = gameCamera end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = gameCamera end
				if killauraparticlepart then killauraparticlepart.Parent = gameCamera end
				task.spawn(function()
					local oldNearPlayer
					repeat
						task.wait()
						if killauraanimation.Enabled then
							if killauraNearPlayer then
								pcall(function()
									if originalArmC0 == nil then
										originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
									end
									if killauraplaying == false then
										killauraplaying = true
										for i,v in pairs(anims[killauraanimmethod.Value]) do 
											if (not Killaura.Enabled) or (not killauraNearPlayer) then break end
											if not oldNearPlayer and killauraanimationtween.Enabled then
												gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0 * v.CFrame
												continue
											end
											killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = originalArmC0 * v.CFrame})
											killauracurrentanim:Play()
											task.wait(v.Time - 0.01)
										end
										killauraplaying = false
									end
								end)	
							end
							oldNearPlayer = killauraNearPlayer
						end
					until Killaura.Enabled == false
				end)

                oldViewmodelAnimation = bedwars.ViewmodelController.playAnimation
                oldPlaySound = bedwars.SoundManager.playSound
                bedwars.SoundManager.playSound = function(tab, soundid, ...)
                    if (soundid == bedwars.SoundList.SWORD_SWING_1 or soundid == bedwars.SoundList.SWORD_SWING_2) and Killaura.Enabled and killaurasound.Enabled and killauraNearPlayer then
                        return nil
                    end
                    return oldPlaySound(tab, soundid, ...)
                end
                bedwars.ViewmodelController.playAnimation = function(Self, id, ...)
                    if id == 15 and killauraNearPlayer and killauraswing.Enabled and entityLibrary.isAlive then
                        return nil
                    end
                    if id == 15 and killauraNearPlayer and killauraanimation.Enabled and entityLibrary.isAlive then
                        return nil
                    end
                    return oldViewmodelAnimation(Self, id, ...)
                end

				local targetedPlayer
				RunLoops:BindToHeartbeat("Killaura", function()
					for i,v in pairs(killauraboxes) do 
						if v:IsA("BoxHandleAdornment") and v.Adornee then
							local cf = v.Adornee and v.Adornee.CFrame
							local onex, oney, onez = cf:ToEulerAnglesXYZ() 
							v.CFrame = CFrame.new() * CFrame.Angles(-onex, -oney, -onez)
						end
					end
					if entityLibrary.isAlive then
						if killauraaimcirclepart then 
							killauraaimcirclepart.Position = targetedPlayer and closestpos(targetedPlayer.RootPart, entityLibrary.character.HumanoidRootPart.Position) or Vector3.new(99999, 99999, 99999)
						end
						if killauraparticlepart then 
							killauraparticlepart.Position = targetedPlayer and targetedPlayer.RootPart.Position or Vector3.new(99999, 99999, 99999)
						end
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							if killaurarangecirclepart then 
								killaurarangecirclepart.Position = Root.Position - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight, 0)
							end
							local Neck = entityLibrary.character.Head:FindFirstChild("Neck")
							local LowerTorso = Root.Parent and Root.Parent:FindFirstChild("LowerTorso")
							local RootC0 = LowerTorso and LowerTorso:FindFirstChild("Root")
							if Neck and RootC0 then
								if originalNeckC0 == nil then
									originalNeckC0 = Neck.C0.p
								end
								if originalRootC0 == nil then
									originalRootC0 = RootC0.C0.p
								end
								if originalRootC0 and killauracframe.Enabled then
									if targetedPlayer ~= nil then
										local targetPos = targetedPlayer.RootPart.Position + Vector3.new(0, 2, 0)
										local direction = (Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - entityLibrary.character.Head.Position).Unit
										local direction2 = (Vector3.new(targetPos.X, Root.Position.Y, targetPos.Z) - Root.Position).Unit
										local lookCFrame = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction)))
										local lookCFrame2 = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction2)))
										Neck.C0 = CFrame.new(originalNeckC0) * CFrame.Angles(lookCFrame.LookVector.Unit.y, 0, 0)
										RootC0.C0 = lookCFrame2 + originalRootC0
									else
										Neck.C0 = CFrame.new(originalNeckC0)
										RootC0.C0 = CFrame.new(originalRootC0)
									end
								end
							end
						end
					end
				end)
				if killauraautoblock.Enabled then 
					task.spawn(autoBlockLoop)
				end
                task.spawn(function()
					repeat
						task.wait()
						if not Killaura.Enabled then break end
						vapeTargetInfo.Targets.Killaura = nil
						local plrs = AllNearPosition(killaurarange.Value, 10, killaurasortmethods[killaurasortmethod.Value], true)
						local firstPlayerNear
						if #plrs > 0 then
							local sword, swordmeta = getAttackData()
							if sword then
								task.spawn(switchItem, sword.tool)
								for i, plr in pairs(plrs) do
									local root = plr.RootPart
									if not root then 
										continue
									end
									local localfacing = entityLibrary.character.HumanoidRootPart.CFrame.lookVector
									local vec = (plr.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).unit
									local angle = math.acos(localfacing:Dot(vec))
									if angle >= (math.rad(killauraangle.Value) / 2) then
										continue
									end
									local selfrootpos = entityLibrary.character.HumanoidRootPart.Position
									if killauratargetframe.Walls.Enabled then
										if not bedwars.SwordController:canSee({player = plr.Player, getInstance = function() return plr.Character end}) then continue end
									end
									if not ({WhitelistFunctions:GetWhitelist(plr.Player)})[2] then
										continue
									end
									if not ({VoidwareFunctions:GetPlayerType(plr.Player)})[2] then 
										continue
									end
									if killauranovape.Enabled and bedwarsStore.whitelist.clientUsers[plr.Player.Name] then
										continue
									end
									if killauranovoidware.Enabled and table.find(shared.VoidwareStore.ConfigUsers, plr.Player) then
									   continue
									end
									if not firstPlayerNear then 
										firstPlayerNear = true 
										killauraNearPlayer = true
										targetedPlayer = plr
										vapeTargetInfo.Targets.Killaura = {
											Humanoid = {
												Health = (plr.Character:GetAttribute("Health") or plr.Humanoid.Health) + getShieldAttribute(plr.Character),
												MaxHealth = plr.Character:GetAttribute("MaxHealth") or plr.Humanoid.MaxHealth
											},
											Player = plr.Player
										}
										if animationdelay <= tick() then
											animationdelay = tick() + (swordmeta.sword.respectAttackSpeedForEffects and swordmeta.sword.attackSpeed or (killaurasync.Enabled and 0.24 or 0.14))
											if not killauraswing.Enabled then 
												bedwars.SwordController:playSwordEffect(swordmeta, false)
											end
											if swordmeta.displayName:find(" Scythe") then 
												--bedwars.ScytheController:playLocalAnimation()
											end
										end
									end
									if (workspace:GetServerTimeNow() - bedwars.SwordController.lastAttack) < 0.02 then 
										break
									end
									local selfpos = selfrootpos + (killaurarange.Value > 14 and (selfrootpos - root.Position).magnitude > 14.4 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * ((selfrootpos - root.Position).magnitude - 14)) or Vector3.zero)
									bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
									bedwarsStore.attackReach = math.floor((selfrootpos - root.Position).magnitude * 100) / 100
									bedwarsStore.attackReachUpdate = tick() + 1
									killaurarealremote:FireServer({
										weapon = sword.tool,
										chargedAttack = {chargeRatio = swordmeta.sword.chargedAttack and not swordmeta.sword.chargedAttack.disableOnGrounded and 0.999 or 0},
										entityInstance = plr.Character,
										validate = {
											raycast = {
												cameraPosition = attackValue(root.Position), 
												cursorDirection = attackValue(CFrame.new(selfpos, root.Position).lookVector)
											},
											targetPosition = attackValue(root.Position),
											selfPosition = attackValue(selfpos)
										}
									})
									break
								end
							end
						end
						if not firstPlayerNear then 
							targetedPlayer = nil
							killauraNearPlayer = false
							pcall(function()
								if originalArmC0 == nil then
									originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
								end
								if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
									pcall(function()
										killauracurrentanim:Cancel()
									end)
									if killauraanimationtween.Enabled then 
										gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0
									else
										killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(custominoutspeeds[killauraanimmethod.Value] or 0.1), {C0 = originalArmC0})
										killauracurrentanim:Play()
									end
								end
							end)
						end
						for i,v in pairs(killauraboxes) do 
							local attacked = killauratarget.Enabled and plrs[i] or nil
							v.Adornee = attacked and ((not killauratargethighlight.Enabled) and attacked.RootPart or (not GuiLibrary.ObjectsThatCanBeSaved.ChamsOptionsButton.Api.Enabled) and attacked.Character or nil)
						end
					until (not Killaura.Enabled)
				end)
            else
				vapeTargetInfo.Targets.Killaura = nil
				RunLoops:UnbindFromHeartbeat("Killaura") 
                killauraNearPlayer = false
				for i,v in pairs(killauraboxes) do v.Adornee = nil end
				if killauraaimcirclepart then killauraaimcirclepart.Parent = nil end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = nil end
				if killauraparticlepart then killauraparticlepart.Parent = nil end
                bedwars.ViewmodelController.playAnimation = oldViewmodelAnimation
                bedwars.SoundManager.playSound = oldPlaySound
                oldViewmodelAnimation = nil
                pcall(function()
					if entityLibrary.isAlive then
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							local Neck = Root.Parent.Head.Neck
							if originalNeckC0 and originalRootC0 then 
								Neck.C0 = CFrame.new(originalNeckC0)
								Root.Parent.LowerTorso.Root.C0 = CFrame.new(originalRootC0)
							end
						end
					end
                    if originalArmC0 == nil then
                        originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
                    end
                    if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
						pcall(function()
							killauracurrentanim:Cancel()
						end)
						if killauraanimationtween.Enabled then 
							gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0
						else
							killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = originalArmC0})
							killauracurrentanim:Play()
						end
                    end
                end)
            end
        end,
        HoverText = "Attack players around you\nwithout aiming at them."
    })
    killauratargetframe = Killaura.CreateTargetWindow({})
	local sortmethods = {"Distance"}
	for i,v in pairs(killaurasortmethods) do if i ~= "Distance" then table.insert(sortmethods, i) end end
	killaurasortmethod = Killaura.CreateDropdown({
		Name = "Sort",
		Function = function() end,
		List = sortmethods
	})
    killaurarange = Killaura.CreateSlider({
        Name = "Attack range",
        Min = 1,
        Max = 18,
        Function = function(val) 
			if killaurarangecirclepart then 
				killaurarangecirclepart.Size = Vector3.new(val * 0.7, 0.01, val * 0.7)
			end
		end, 
        Default = 18
    })
    killauraangle = Killaura.CreateSlider({
        Name = "Max angle",
        Min = 1,
        Max = 360,
        Function = function(val) end,
        Default = 360
    })
	local animmethods = {}
	for i,v in pairs(anims) do table.insert(animmethods, i) end
    killauraanimmethod = Killaura.CreateDropdown({
        Name = "Animation", 
        List = animmethods,
        Function = function(val) end
    })
	local oldviewmodel
	local oldraise
	local oldeffect
	killauraautoblock = Killaura.CreateToggle({
		Name = "AutoBlock",
		Function = function(callback)
			if callback then 
				oldviewmodel = bedwars.ViewmodelController.setHeldItem
				bedwars.ViewmodelController.setHeldItem = function(self, newItem, ...)
					if newItem and newItem.Name == "infernal_shield" then 
						return
					end
					return oldviewmodel(self, newItem)
				end
				oldraise = bedwars.InfernalShieldController.raiseShield
				bedwars.InfernalShieldController.raiseShield = function(self)
					if os.clock() - self.lastShieldRaised < 0.4 then
						return
					end
					self.lastShieldRaised = os.clock()
					self.infernalShieldState:SendToServer({raised = true})
					self.raisedMaid:GiveTask(function()
						self.infernalShieldState:SendToServer({raised = false})
					end)
				end
				oldeffect = bedwars.InfernalShieldController.playEffect
				bedwars.InfernalShieldController.playEffect = function()
					return
				end
				if bedwars.ViewmodelController.heldItem and bedwars.ViewmodelController.heldItem.Name == "infernal_shield" then 
					local sword, swordmeta = getSword()
					if sword then 
						bedwars.ViewmodelController:setHeldItem(sword.tool)
					end
				end
				task.spawn(autoBlockLoop)
			else
				bedwars.ViewmodelController.setHeldItem = oldviewmodel
				bedwars.InfernalShieldController.raiseShield = oldraise
				bedwars.InfernalShieldController.playEffect = oldeffect
			end
		end,
		Default = true
	})
    killauramouse = Killaura.CreateToggle({
        Name = "Require mouse down",
        Function = function() end,
		HoverText = "Only attacks when left click is held.",
        Default = false
    })
    killauragui = Killaura.CreateToggle({
        Name = "GUI Check",
        Function = function() end,
		HoverText = "Attacks when you are not in a GUI."
    })
    killauratarget = Killaura.CreateToggle({
        Name = "Show target",
        Function = function(callback) 
			if killauratargethighlight.Object then 
				killauratargethighlight.Object.Visible = callback
			end
		end,
		HoverText = "Shows a red box over the opponent."
    })
	killauratargethighlight = Killaura.CreateToggle({
		Name = "Use New Highlight",
		Function = function(callback) 
			for i,v in pairs(killauraboxes) do 
				v:Remove()
			end
			for i = 1, 10 do 
				local killaurabox
				if callback then 
					killaurabox = Instance.new("Highlight")
					killaurabox.FillTransparency = 0.39
					killaurabox.FillColor = Color3.fromHSV(killauracolor.Hue, killauracolor.Sat, killauracolor.Value)
					killaurabox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					killaurabox.OutlineTransparency = 1
					killaurabox.Parent = GuiLibrary.MainGui
				else
					killaurabox = Instance.new("BoxHandleAdornment")
					killaurabox.Transparency = 0.39
					killaurabox.Color3 = Color3.fromHSV(killauracolor.Hue, killauracolor.Sat, killauracolor.Value)
					killaurabox.Adornee = nil
					killaurabox.AlwaysOnTop = true
					killaurabox.Size = Vector3.new(3, 6, 3)
					killaurabox.ZIndex = 11
					killaurabox.Parent = GuiLibrary.MainGui
				end
				killauraboxes[i] = killaurabox
			end
		end
	})
	killauratargethighlight.Object.BorderSizePixel = 0
	killauratargethighlight.Object.BackgroundTransparency = 0
	killauratargethighlight.Object.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	killauratargethighlight.Object.Visible = false
	killauracolor = Killaura.CreateColorSlider({
		Name = "Target Color",
		Function = function(hue, sat, val) 
			for i,v in pairs(killauraboxes) do 
				v[(killauratargethighlight.Enabled and "FillColor" or "Color3")] = Color3.fromHSV(hue, sat, val)
			end
			if killauraaimcirclepart then 
				killauraaimcirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
			if killaurarangecirclepart then 
				killaurarangecirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
		end,
		Default = 1
	})
	for i = 1, 10 do 
		local killaurabox = Instance.new("BoxHandleAdornment")
		killaurabox.Transparency = 0.5
		killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
		killaurabox.Adornee = nil
		killaurabox.AlwaysOnTop = true
		killaurabox.Size = Vector3.new(3, 6, 3)
		killaurabox.ZIndex = 11
		killaurabox.Parent = GuiLibrary.MainGui
		killauraboxes[i] = killaurabox
	end
    killauracframe = Killaura.CreateToggle({
        Name = "Face target",
        Function = function() end,
		HoverText = "Makes your character face the opponent."
    })
	killaurarangecircle = Killaura.CreateToggle({
		Name = "Range Visualizer",
		Function = function(callback)
			if callback then 
				killaurarangecirclepart = Instance.new("MeshPart")
				killaurarangecirclepart.MeshId = "rbxassetid://3726303797"
				killaurarangecirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killaurarangecirclepart.CanCollide = false
				killaurarangecirclepart.Anchored = true
				killaurarangecirclepart.Material = Enum.Material.Neon
				killaurarangecirclepart.Size = Vector3.new(killaurarange.Value * 0.7, 0.01, killaurarange.Value * 0.7)
				if Killaura.Enabled then 
					killaurarangecirclepart.Parent = gameCamera
				end
				bedwars.QueryUtil:setQueryIgnored(killaurarangecirclepart, true)
			else
				if killaurarangecirclepart then 
					killaurarangecirclepart:Destroy()
					killaurarangecirclepart = nil
				end
			end
		end
	})
	killauraaimcircle = Killaura.CreateToggle({
		Name = "Aim Visualizer",
		Function = function(callback)
			if callback then 
				killauraaimcirclepart = Instance.new("Part")
				killauraaimcirclepart.Shape = Enum.PartType.Ball
				killauraaimcirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killauraaimcirclepart.CanCollide = false
				killauraaimcirclepart.Anchored = true
				killauraaimcirclepart.Material = Enum.Material.Neon
				killauraaimcirclepart.Size = Vector3.new(0.5, 0.5, 0.5)
				if Killaura.Enabled then 
					killauraaimcirclepart.Parent = gameCamera
				end
				bedwars.QueryUtil:setQueryIgnored(killauraaimcirclepart, true)
			else
				if killauraaimcirclepart then 
					killauraaimcirclepart:Destroy()
					killauraaimcirclepart = nil
				end
			end
		end
	})
	killauraparticle = Killaura.CreateToggle({
		Name = "Crit Particle",
		Function = function(callback)
			if callback then 
				killauraparticlepart = Instance.new("Part")
				killauraparticlepart.Transparency = 1
				killauraparticlepart.CanCollide = false
				killauraparticlepart.Anchored = true
				killauraparticlepart.Size = Vector3.new(3, 6, 3)
				killauraparticlepart.Parent = cam
				bedwars.QueryUtil:setQueryIgnored(killauraparticlepart, true)
				local particle = Instance.new("ParticleEmitter")
				particle.Lifetime = NumberRange.new(0.5)
				particle.Rate = 500
				particle.Speed = NumberRange.new(0)
				particle.RotSpeed = NumberRange.new(180)
				particle.Enabled = true
				particle.Size = NumberSequence.new(0.3)
				particle.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(67, 10, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 98, 255))})
				particle.Parent = killauraparticlepart
				task.spawn(function()
					repeat task.wait() until killauraparticlecolor.Object
					particle.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(killauraparticlecolor.Hue, killauraparticlecolor.Sat, killauraparticlecolor.Value)), ColorSequenceKeypoint.new(1, Color3.fromHSV(killauraparticlecolor.Hue, killauraparticlecolor.Sat, killauraparticlecolor.Value))})
				end)
			else
				if killauraparticlepart then 
					killauraparticlepart:Destroy()
					killauraparticlepart = nil
				end
			end
		end
	})
	killauraparticlecolor = Killaura.CreateColorSlider({
		Name = "Crit Particle Color",
		Function = function(h, s, v)
			pcall(function() killauraparticlepart.ParticleEmitter.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(h, s, v)), ColorSequenceKeypoint.new(1, Color3.fromHSV(h, s, v))}) end)
		end
	})
    killaurasound = Killaura.CreateToggle({
        Name = "No Swing Sound",
        Function = function() end,
		HoverText = "Removes the swinging sound."
    })
    killauraswing = Killaura.CreateToggle({
        Name = "No Swing",
        Function = function() end,
		HoverText = "Removes the swinging animation."
    })
    killaurahandcheck = Killaura.CreateToggle({
        Name = "Limit to items",
        Function = function() end,
		HoverText = "Only attacks when your sword is held."
    })
    killauraanimation = Killaura.CreateToggle({
        Name = "Custom Animation",
        Function = function(callback)
			if killauraanimationtween.Object then killauraanimationtween.Object.Visible = callback end
		end,
		HoverText = "Uses a custom animation for swinging"
    })
	killauraanimationtween = Killaura.CreateToggle({
		Name = "No Tween",
		Function = function() end,
		HoverText = "Disable's the in and out ease"
	})
	killauraanimationtween.Object.Visible = false
	killaurasync = Killaura.CreateToggle({
        Name = "Synced Animation",
        Function = function() end,
		HoverText = "Times animation with hit attempt"
    })
	killauranovape = Killaura.CreateToggle({
		Name = "No Vape",
		Function = function() end,
		HoverText = "no hit vape user"
	})
	killauranovoidware = Killaura.CreateToggle({
		Name = "Ignore Voidware",
		Function = function() if Killaura.Enabled then Killaura.ToggleButton(false) Killaura.ToggleButton(false) end end,
		HoverText = "ignores voidware users under your rank.\n(they can't attack you back :omegalol:)"
	})
	killauranovape.Object.Visible = false
	killauranovoidware.Object.Visible = false
	task.spawn(function()
		repeat task.wait() until WhitelistFunctions.Loaded
		killauranovape.Object.Visible = WhitelistFunctions.LocalPriority ~= 0
	end)
	task.spawn(function()
		repeat task.wait() until VoidwareFunctions.WhitelistLoaded
		killauranovoidware.Object.Visible = ({VoidwareFunctions:GetPlayerType()})[3] > 1.5
	end)
end)

local antivoidvelo
runFunction(function()
	pcall(GuiLibrary.RemoveObject, "SpeedOptionsButton")
	local Speed = {Enabled = false}
	local SpeedMode = {Value = "CFrame"}
	local SpeedValue = {Value = 1}
	local SpeedValueLarge = {Value = 1}
	local SpeedScythe = {Value = 38}
	local SpeedDamageBoost = {Enabled = false}
	local SpeedJump = {Enabled = false}
	local SpeedJumpHeight = {Value = 20}
	local SpeedJumpAlways = {Enabled = false}
	local SpeedJumpSound = {Enabled = false}
	local SpeedJumpVanilla = {Enabled = false}
	local SpeedAnimation = {Enabled = false}
	local raycastparameters = RaycastParams.new()
	local damagetick = tick()

	local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B"}
	Speed = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "Speed",
		Function = function(callback)
			if callback then
				table.insert(Speed.Connections, vapeEvents.EntityDamageEvent.Event:Connect(function(damageTable)
					if damageTable.entityInstance == lplr.Character and (damageTable.damageType ~= 0 or damageTable.extra and damageTable.extra.chargeRatio ~= nil) and (not (damageTable.knockbackMultiplier and damageTable.knockbackMultiplier.disabled or damageTable.knockbackMultiplier and damageTable.knockbackMultiplier.horizontal == 0)) and SpeedDamageBoost.Enabled then 
						damagetick = tick() + 0.30
					end
				end))
				RunLoops:BindToHeartbeat("Speed", function(delta)
					if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then
						if bedwarsStore.matchState == 0 then return end
					end
					if entityLibrary.isAlive then
						if not (isnetworkowner(entityLibrary.character.HumanoidRootPart) and entityLibrary.character.Humanoid:GetState() ~= Enum.HumanoidStateType.Climbing and (not spiderActive) and (not GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.Enabled) and (not GuiLibrary.ObjectsThatCanBeSaved.FlyOptionsButton.Api.Enabled)) then return end
						if GuiLibrary.ObjectsThatCanBeSaved.GrappleExploitOptionsButton and GuiLibrary.ObjectsThatCanBeSaved.GrappleExploitOptionsButton.Api.Enabled then return end
						if isEnabled("LongJump") then return end
						if SpeedAnimation.Enabled then
							for i, v in pairs(entityLibrary.character.Humanoid:GetPlayingAnimationTracks()) do
								if v.Name == "WalkAnim" or v.Name == "RunAnim" then
									v:AdjustSpeed(entityLibrary.character.Humanoid.WalkSpeed / 16)
								end
							end
						end

						local speedValue = (not VoidwareStore.movementDisabled and SpeedValue.Value + getSpeed() or 1)
						if damagetick > tick() then speedValue = speedValue + 25 end

						local speedVelocity = entityLibrary.character.Humanoid.MoveDirection * (SpeedMode.Value == "Normal" and SpeedValue.Value or 20)
						entityLibrary.character.HumanoidRootPart.Velocity = antivoidvelo or Vector3.new(speedVelocity.X, entityLibrary.character.HumanoidRootPart.Velocity.Y, speedVelocity.Z)
						if SpeedMode.Value ~= "Normal" then 
							local speedCFrame = entityLibrary.character.Humanoid.MoveDirection * (speedValue - 20) * delta
							raycastparameters.FilterDescendantsInstances = {lplr.Character}
							local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, speedCFrame, raycastparameters)
							if ray then speedCFrame = (ray.Position - entityLibrary.character.HumanoidRootPart.Position) end
							entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + speedCFrame
						end

						if SpeedJump.Enabled and (not Scaffold.Enabled) and (SpeedJumpAlways.Enabled or killauraNearPlayer) then
							if (entityLibrary.character.Humanoid.FloorMaterial ~= Enum.Material.Air) and entityLibrary.character.Humanoid.MoveDirection ~= Vector3.zero then
								if SpeedJumpSound.Enabled then 
									pcall(function() entityLibrary.character.HumanoidRootPart.Jumping:Play() end)
								end
								if SpeedJumpVanilla.Enabled then 
									entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
								else
									entityLibrary.character.HumanoidRootPart.Velocity = Vector3.new(entityLibrary.character.HumanoidRootPart.Velocity.X, SpeedJumpHeight.Value, entityLibrary.character.HumanoidRootPart.Velocity.Z)
								end
							end 
						end
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("Speed")
			end
		end, 
		HoverText = "Increases your movement.",
		ExtraText = function() 
			return "Heatseeker"
		end
	})
	SpeedValue = Speed.CreateSlider({
		Name = "Speed",
		Min = 1,
		Max = 23,
		Function = function(val) end,
		Default = 23
	})
	SpeedScythe = Speed.CreateSlider({
		Name = "Scythe Speed",
		Min = 1, 
		Max = 30,
		Default = 30,
		Function = function() end
	})
	SpeedValueLarge = Speed.CreateSlider({
		Name = "Big Mode Speed",
		Min = 1,
		Max = 23,
		Function = function(val) end,
		Default = 23
	})
	SpeedDamageBoost = Speed.CreateToggle({
		Name = "Damage Boost",
		Function = function() end,
		Default = true
	})
	SpeedJump = Speed.CreateToggle({
		Name = "AutoJump", 
		Function = function(callback) 
			if SpeedJumpHeight.Object then SpeedJumpHeight.Object.Visible = callback end
			if SpeedJumpAlways.Object then
				SpeedJump.Object.ToggleArrow.Visible = callback
				SpeedJumpAlways.Object.Visible = callback
			end
			if SpeedJumpSound.Object then SpeedJumpSound.Object.Visible = callback end
			if SpeedJumpVanilla.Object then SpeedJumpVanilla.Object.Visible = callback end
		end,
		Default = true
	})
	SpeedJumpHeight = Speed.CreateSlider({
		Name = "Jump Height",
		Min = 0,
		Max = 30,
		Default = 25,
		Function = function() end
	})
	SpeedJumpAlways = Speed.CreateToggle({
		Name = "Always Jump",
		Function = function() end
	})
	SpeedJumpSound = Speed.CreateToggle({
		Name = "Jump Sound",
		Function = function() end
	})
	SpeedJumpVanilla = Speed.CreateToggle({
		Name = "Real Jump",
		Function = function() end
	})
	SpeedAnimation = Speed.CreateToggle({
		Name = "Slowdown Anim",
		Function = function() end
	})
end)

local bypassclone 
local bypasswaiting
local bypasstpdelay = tick()
runFunction(function()
	pcall(GuiLibrary.RemoveObject, "InfiniteFlyOptionsButton")
	local InfiniteFly = {Enabled = false}
	local InfiniteFlyMode = {Value = "CFrame"}
	local InfiniteFlySpeed = {Value = 23}
	local InfiniteFlyVerticalSpeed = {Value = 40}
	local InfiniteFlyVertical = {Enabled = true}
	local InfiniteFlyUp = false
	local InfiniteFlyDown = false
	local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B"}
	local clonesuccess = false
	local disabledproper = true
	local oldcloneroot
	local cloned
	local clone
	local bodyvelo
	local FlyOverlap = OverlapParams.new()
	FlyOverlap.MaxParts = 9e9
	FlyOverlap.FilterDescendantsInstances = {}
	FlyOverlap.RespectCanCollide = true

	local function disablefunc()
		if bodyvelo then bodyvelo:Destroy() end
		RunLoops:UnbindFromHeartbeat("InfiniteFlyOff")
		disabledproper = true
		if not oldcloneroot or not oldcloneroot.Parent then return end
		lplr.Character.Parent = game
		oldcloneroot.Parent = lplr.Character
		lplr.Character.PrimaryPart = oldcloneroot
		lplr.Character.Parent = workspace
		oldcloneroot.CanCollide = true
		for i,v in pairs(lplr.Character:GetDescendants()) do 
			if v:IsA("Weld") or v:IsA("Motor6D") then 
				if v.Part0 == clone then v.Part0 = oldcloneroot end
				if v.Part1 == clone then v.Part1 = oldcloneroot end
			end
			if v:IsA("BodyVelocity") then 
				v:Destroy()
			end
		end
		for i,v in pairs(oldcloneroot:GetChildren()) do 
			if v:IsA("BodyVelocity") then 
				v:Destroy()
			end
		end
		local oldclonepos = clone.Position.Y
		if clone then 
			clone:Destroy()
			clone = nil
		end
		lplr.Character.Humanoid.HipHeight = hip or 2
		local origcf = {oldcloneroot.CFrame:GetComponents()}
		origcf[2] = oldclonepos
		oldcloneroot.CFrame = CFrame.new(unpack(origcf))
		oldcloneroot = nil
	end

	InfiniteFly = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "InfiniteFly",
		Function = function(callback)
			if callback then
				if not entityLibrary.isAlive then 
					disabledproper = true
				end
				if not disabledproper then 
					warningNotification("InfiniteFly", "Wait for the last fly to finish", 3)
					InfiniteFly.ToggleButton(false)
					return 
				end
				if bypassclone then 
					bypassclone.Destroy()
					bypassclone = nil
				end
				table.insert(InfiniteFly.Connections, inputService.InputBegan:Connect(function(input1)
					if InfiniteFlyVertical.Enabled and inputService:GetFocusedTextBox() == nil then
						if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
							InfiniteFlyUp = true
						end
						if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
							InfiniteFlyDown = true
						end
					end
				end))
				table.insert(InfiniteFly.Connections, inputService.InputEnded:Connect(function(input1)
					if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
						InfiniteFlyUp = false
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
						InfiniteFlyDown = false
					end
				end))
				if inputService.TouchEnabled then
					pcall(function()
						local jumpButton = lplr.PlayerGui.TouchGui.TouchControlFrame.JumpButton
						table.insert(InfiniteFly.Connections, jumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
							InfiniteFlyUp = jumpButton.ImageRectOffset.X == 146
						end))
						InfiniteFlyUp = jumpButton.ImageRectOffset.X == 146
					end)
				end
				clonesuccess = false
				if entityLibrary.isAlive and entityLibrary.character.Humanoid.Health > 0 and isnetworkowner(entityLibrary.character.HumanoidRootPart) then
					cloned = lplr.Character
					oldcloneroot = entityLibrary.character.HumanoidRootPart
					if not lplr.Character.Parent then 
						InfiniteFly.ToggleButton(false)
						return
					end
					lplr.Character.Parent = game
					clone = oldcloneroot:Clone()
					clone.Parent = lplr.Character
					oldcloneroot.Parent = gameCamera
					bedwars.QueryUtil:setQueryIgnored(oldcloneroot, true)
					clone.CFrame = oldcloneroot.CFrame
					lplr.Character.PrimaryPart = clone
					lplr.Character.Parent = workspace
					for i,v in pairs(lplr.Character:GetDescendants()) do 
						if v:IsA("Weld") or v:IsA("Motor6D") then 
							if v.Part0 == oldcloneroot then v.Part0 = clone end
							if v.Part1 == oldcloneroot then v.Part1 = clone end
						end
						if v:IsA("BodyVelocity") then 
							v:Destroy()
						end
					end
					for i,v in pairs(oldcloneroot:GetChildren()) do 
						if v:IsA("BodyVelocity") then 
							v:Destroy()
						end
					end
					if hip then 
						lplr.Character.Humanoid.HipHeight = hip
					end
					hip = lplr.Character.Humanoid.HipHeight
					clonesuccess = true
				end
				if not clonesuccess then 
					warningNotification("InfiniteFly", "Character missing", 3)
					InfiniteFly.ToggleButton(false)
					return 
				end
				local goneup = false
				RunLoops:BindToHeartbeat("InfiniteFly", function(delta) 
					if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then 
						if bedwarsStore.matchState == 0 then return end
					end
					if entityLibrary.isAlive then
						if isnetworkowner(oldcloneroot) then 
							local playerMass = (entityLibrary.character.HumanoidRootPart:GetMass() - 1.4) * (delta * 100)
							
							local flyVelocity = entityLibrary.character.Humanoid.MoveDirection * (InfiniteFlyMode.Value == "Normal" and InfiniteFlySpeed.Value or 20)
							entityLibrary.character.HumanoidRootPart.Velocity = flyVelocity + (Vector3.new(0, playerMass + (InfiniteFlyUp and InfiniteFlyVerticalSpeed.Value or 0) + (InfiniteFlyDown and -InfiniteFlyVerticalSpeed.Value or 0), 0))
							if InfiniteFlyMode.Value ~= "Normal" then
								entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + (entityLibrary.character.Humanoid.MoveDirection * ((InfiniteFlySpeed.Value + getSpeed()) - 20)) * delta
							end

							local speedCFrame = {oldcloneroot.CFrame:GetComponents()}
							speedCFrame[1] = clone.CFrame.X
							if speedCFrame[2] < 1000 or (not goneup) then 
								task.spawn(warningNotification, "InfiniteFly", "Teleported Up", 3)
								speedCFrame[2] = 100000
								goneup = true
							end
							speedCFrame[3] = clone.CFrame.Z
							oldcloneroot.CFrame = CFrame.new(unpack(speedCFrame))
							oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, oldcloneroot.Velocity.Y, clone.Velocity.Z)
						else
							InfiniteFly.ToggleButton(false)
						end
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("InfiniteFly")
				if clonesuccess and oldcloneroot and clone and lplr.Character.Parent == workspace and oldcloneroot.Parent ~= nil and disabledproper and cloned == lplr.Character then 
					local rayparams = RaycastParams.new()
					rayparams.FilterDescendantsInstances = {lplr.Character, gameCamera}
					rayparams.RespectCanCollide = true
					local ray = workspace:Raycast(Vector3.new(oldcloneroot.Position.X, clone.CFrame.p.Y, oldcloneroot.Position.Z), Vector3.new(0, -1000, 0), rayparams)
					local origcf = {clone.CFrame:GetComponents()}
					origcf[1] = oldcloneroot.Position.X
					origcf[2] = ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y
					origcf[3] = oldcloneroot.Position.Z
					oldcloneroot.CanCollide = true
					bodyvelo = Instance.new("BodyVelocity")
					bodyvelo.MaxForce = Vector3.new(0, 9e9, 0)
					bodyvelo.Velocity = Vector3.new(0, -1, 0)
					bodyvelo.Parent = oldcloneroot
					oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, -1, clone.Velocity.Z)
					RunLoops:BindToHeartbeat("InfiniteFlyOff", function(dt)
						if oldcloneroot then 
							oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, -1, clone.Velocity.Z)
							local bruh = {clone.CFrame:GetComponents()}
							bruh[2] = oldcloneroot.CFrame.Y
							local newcf = CFrame.new(unpack(bruh))
							FlyOverlap.FilterDescendantsInstances = {lplr.Character, gameCamera}
							local allowed = true
							for i,v in pairs(workspace:GetPartBoundsInRadius(newcf.p, 2, FlyOverlap)) do 
								if (v.Position.Y + (v.Size.Y / 2)) > (newcf.p.Y + 0.5) then 
									allowed = false
									break
								end
							end
							if allowed then
								oldcloneroot.CFrame = newcf
							end
						end
					end)
					oldcloneroot.CFrame = CFrame.new(unpack(origcf))
					entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
					disabledproper = false
					if isnetworkowner(oldcloneroot) then 
						warningNotification("InfiniteFly", "Waiting 1.5s to not flag", 3)
						task.delay(1.5, disablefunc)
					else
						disablefunc()
					end
				end
				InfiniteFlyUp = false
				InfiniteFlyDown = false
			end
		end,
		HoverText = "Makes you go zoom",
		ExtraText = function()
			return "Heatseeker"
		end
	})
	InfiniteFlySpeed = InfiniteFly.CreateSlider({
		Name = "Speed",
		Min = 1,
		Max = 23,
		Function = function(val) end, 
		Default = 23
	})
	InfiniteFlyVerticalSpeed = InfiniteFly.CreateSlider({
		Name = "Vertical Speed",
		Min = 1,
		Max = 100,
		Function = function(val) end, 
		Default = 44
	})
	InfiniteFlyVertical = InfiniteFly.CreateToggle({
		Name = "Y Level",
		Function = function() end, 
		Default = true
	})
end)

local autobankapple = false
local denyregions = {}

runFunction(function()
	pcall(GuiLibrary.RemoveObject, "ProjectileExploitOptionsButton")
	local BowExploit = {Enabled = false}
	local BowExploitTarget = {Value = "Mouse"}
	local BowExploitAutoShootFOV = {Value = 1000}
	local oldrealremote
	local noveloproj = {
		"fireball",
		"telepearl"
	}

	BowExploit = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "ProjectileExploit",
		Function = function(callback)
			if callback then 
				oldrealremote = bedwars.ClientConstructor.Function.new
				bedwars.ClientConstructor.Function.new = function(self, ind, ...)
					local res = oldrealremote(self, ind, ...)
					local oldRemote = res.instance
					if oldRemote and oldRemote.Name == bedwars.ProjectileRemote then 
						res.instance = {InvokeServer = function(self, shooting, proj, proj2, launchpos1, launchpos2, launchvelo, tag, tab1, ...) 
							local plr
							if BowExploitTarget.Value == "Mouse" then 
								plr = EntityNearMouse(10000)
							else
								plr = EntityNearPosition(BowExploitAutoShootFOV.Value, true)
							end
							if plr then	
								if not ({WhitelistFunctions:GetWhitelist(plr.Player)})[2] then 
									return oldRemote:InvokeServer(shooting, proj, proj2, launchpos1, launchpos2, launchvelo, tag, tab1, ...)
								end
								if not ({VoidwareFunctions:GetPlayerType(plr.Player)})[2] then
									return oldRemote:InvokeServer(shooting, proj, proj2, launchpos1, launchpos2, launchvelo, tag, tab1, ...)
								end
								tab1.drawDurationSeconds = 1
								repeat
									task.wait(0.03)
									local offsetStartPos = plr.RootPart.CFrame.p - plr.RootPart.CFrame.lookVector
									local pos = plr.RootPart.Position
									local playergrav = workspace.Gravity
									local balloons = plr.Character:GetAttribute("InflatedBalloons")
									if balloons and balloons > 0 then 
										playergrav = (workspace.Gravity * (1 - ((balloons >= 4 and 1.2 or balloons >= 3 and 1 or 0.975))))
									end
									if plr.Character.PrimaryPart:FindFirstChild("rbxassetid://8200754399") then 
										playergrav = (workspace.Gravity * 0.3)
									end
									local newLaunchVelo = bedwars.ProjectileMeta[proj2].launchVelocity
									local shootpos, shootvelo = predictGravity(pos, plr.RootPart.Velocity, (pos - offsetStartPos).Magnitude / newLaunchVelo, plr, playergrav)
									if proj2 == "telepearl" then
										shootpos = pos
										shootvelo = Vector3.zero
									end
									local newlook = CFrame.new(offsetStartPos, shootpos) * CFrame.new(Vector3.new(-bedwars.BowConstantsTable.RelX, -bedwars.BowConstantsTable.RelY, -bedwars.BowConstantsTable.RelZ))
									shootpos = newlook.p + (newlook.lookVector * (offsetStartPos - shootpos).magnitude)
									local calculated = LaunchDirection(offsetStartPos, shootpos, newLaunchVelo, workspace.Gravity, false)
									if calculated then 
										launchvelo = calculated
										launchpos1 = offsetStartPos
										launchpos2 = offsetStartPos
										tab1.drawDurationSeconds = 1
									else
										break
									end
									if oldRemote:InvokeServer(shooting, proj, proj2, launchpos1, launchpos2, launchvelo, tag, tab1, workspace:GetServerTimeNow() - 0.045) then break end
								until false
							else
								return oldRemote:InvokeServer(shooting, proj, proj2, launchpos1, launchpos2, launchvelo, tag, tab1, ...)
							end
						end}
					end
					return res
				end
			else
				bedwars.ClientConstructor.Function.new = oldrealremote
				oldrealremote = nil
			end
		end
	})
	BowExploitTarget = BowExploit.CreateDropdown({
		Name = "Mode",
		List = {"Mouse", "Range"},
		Function = function() end
	})
	BowExploitAutoShootFOV = BowExploit.CreateSlider({
		Name = "FOV",
		Function = function() end,
		Min = 1,
		Max = 1000,
		Default = 1000
	})
end)

runFunction(function()
	pcall(GuiLibrary.RemoveObject, "FlyOptionsButton")
	local Fly = {Enabled = false}
	local FlyMode = {Value = "CFrame"}
	local FlyVerticalSpeed = {Value = 40}
	local FlyVertical = {Enabled = true}
	local FlyAutoPop = {Enabled = true}
	local FlyAnyway = {Enabled = false}
	local FlyAnywayProgressBar = {Enabled = false}
	local FlyDamageAnimation = {Enabled = false}
	local FlyTP = {Enabled = false}
	local FlyAnywayProgressBarFrame
	local olddeflate
	local FlyUp = false
	local FlyDown = false
	local FlyCoroutine
	local groundtime = tick()
	local onground = false
	local lastonground = false
	local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B"}

	local function inflateBalloon()
		if not Fly.Enabled then return end
		if entityLibrary.isAlive and (lplr.Character:GetAttribute("InflatedBalloons") or 0) < 1 then
			autobankballoon = true
			if getItem("balloon") then
				bedwars.BalloonController:inflateBalloon()
				return true
			end
		end
		return false
	end

	Fly = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "Fly",
		Function = function(callback)
			if callback then
				olddeflate = bedwars.BalloonController.deflateBalloon
				bedwars.BalloonController.deflateBalloon = function() end

				table.insert(Fly.Connections, inputService.InputBegan:Connect(function(input1)
					if FlyVertical.Enabled and inputService:GetFocusedTextBox() == nil then
						if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
							FlyUp = true
						end
						if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
							FlyDown = true
						end
					end
				end))
				table.insert(Fly.Connections, inputService.InputEnded:Connect(function(input1)
					if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
						FlyUp = false
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
						FlyDown = false
					end
				end))
				if inputService.TouchEnabled then
					pcall(function()
						local jumpButton = lplr.PlayerGui.TouchGui.TouchControlFrame.JumpButton
						table.insert(Fly.Connections, jumpButton:GetPropertyChangedSignal("ImageRectOffset"):Connect(function()
							FlyUp = jumpButton.ImageRectOffset.X == 146
						end))
						FlyUp = jumpButton.ImageRectOffset.X == 146
					end)
				end
				table.insert(Fly.Connections, vapeEvents.BalloonPopped.Event:Connect(function(poppedTable)
					if poppedTable.inflatedBalloon and poppedTable.inflatedBalloon:GetAttribute("BalloonOwner") == lplr.UserId then 
						lastonground = not onground
						repeat task.wait() until (lplr.Character:GetAttribute("InflatedBalloons") or 0) <= 0 or not Fly.Enabled
						inflateBalloon() 
					end
				end))
				table.insert(Fly.Connections, vapeEvents.AutoBankBalloon.Event:Connect(function()
					repeat task.wait() until getItem("balloon")
					inflateBalloon()
				end))

				local balloons
				if entityLibrary.isAlive and (not bedwarsStore.queueType:find("mega")) then
					balloons = inflateBalloon()
				end
				local megacheck = bedwarsStore.queueType:find("mega") or bedwarsStore.queueType == "winter_event"

				task.spawn(function()
					repeat task.wait() until bedwarsStore.queueType ~= "bedwars_test" or (not Fly.Enabled)
					if not Fly.Enabled then return end
					megacheck = bedwarsStore.queueType:find("mega") or bedwarsStore.queueType == "winter_event"
				end)

				local flyAllowed = entityLibrary.isAlive and ((lplr.Character:GetAttribute("InflatedBalloons") and lplr.Character:GetAttribute("InflatedBalloons") > 0) or bedwarsStore.matchState == 2 or megacheck) and 1 or 0
				if flyAllowed <= 0 and shared.damageanim and (not balloons) then 
					shared.damageanim()
					bedwars.SoundManager:playSound(bedwars.SoundList["DAMAGE_"..math.random(1, 3)])
				end

				if FlyAnywayProgressBarFrame and flyAllowed <= 0 and (not balloons) then 
					FlyAnywayProgressBarFrame.Visible = true
					FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
				end

				groundtime = tick() + (2.6 + (entityLibrary.groundTick - tick()))
				FlyCoroutine = coroutine.create(function()
					repeat
						repeat task.wait() until (groundtime - tick()) < 0.6 and not onground
						flyAllowed = ((lplr.Character and lplr.Character:GetAttribute("InflatedBalloons") and lplr.Character:GetAttribute("InflatedBalloons") > 0) or bedwarsStore.matchState == 2 or megacheck) and 1 or 0
						if (not Fly.Enabled) then break end
						local Flytppos = -99999
						if flyAllowed <= 0 and FlyTP.Enabled and entityLibrary.isAlive then 
							local ray = workspace:Raycast(entityLibrary.character.HumanoidRootPart.Position, Vector3.new(0, -1000, 0), bedwarsStore.blockRaycast)
							if ray then 
								Flytppos = entityLibrary.character.HumanoidRootPart.Position.Y
								local args = {entityLibrary.character.HumanoidRootPart.CFrame:GetComponents()}
								args[2] = ray.Position.Y + (entityLibrary.character.HumanoidRootPart.Size.Y / 2) + entityLibrary.character.Humanoid.HipHeight
								entityLibrary.character.HumanoidRootPart.CFrame = CFrame.new(unpack(args))
								task.wait(0.12)
								if (not Fly.Enabled) then break end
								flyAllowed = ((lplr.Character and lplr.Character:GetAttribute("InflatedBalloons") and lplr.Character:GetAttribute("InflatedBalloons") > 0) or bedwarsStore.matchState == 2 or megacheck) and 1 or 0
								if flyAllowed <= 0 and Flytppos ~= -99999 and entityLibrary.isAlive then 
									local args = {entityLibrary.character.HumanoidRootPart.CFrame:GetComponents()}
									args[2] = Flytppos
									entityLibrary.character.HumanoidRootPart.CFrame = CFrame.new(unpack(args))
								end
							end
						end
					until (not Fly.Enabled)
				end)
				coroutine.resume(FlyCoroutine)

				RunLoops:BindToHeartbeat("Fly", function(delta) 
					if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then 
						if bedwars.matchState == 0 then return end
					end
					if entityLibrary.isAlive then
						local playerMass = (entityLibrary.character.HumanoidRootPart:GetMass() - 1.4) * (delta * 100)
						flyAllowed = ((lplr.Character:GetAttribute("InflatedBalloons") and lplr.Character:GetAttribute("InflatedBalloons") > 0) or bedwarsStore.matchState == 2 or megacheck) and 1 or 0
						playerMass = playerMass + (flyAllowed > 0 and 4 or 0) * (tick() % 0.4 < 0.2 and -1 or 1)

						if FlyAnywayProgressBarFrame then
							FlyAnywayProgressBarFrame.Visible = flyAllowed <= 0
							FlyAnywayProgressBarFrame.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
							FlyAnywayProgressBarFrame.Frame.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
						end

						if flyAllowed <= 0 then 
							local newray = getPlacedBlock(entityLibrary.character.HumanoidRootPart.Position + Vector3.new(0, (entityLibrary.character.Humanoid.HipHeight * -2) - 1, 0))
							onground = newray and true or false
							if lastonground ~= onground then 
								if (not onground) then 
									groundtime = tick() + (2.6 + (entityLibrary.groundTick - tick()))
									if FlyAnywayProgressBarFrame then 
										FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(0, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, groundtime - tick(), true)
									end
								else
									if FlyAnywayProgressBarFrame then 
										FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
									end
								end
							end
							if FlyAnywayProgressBarFrame then 
								FlyAnywayProgressBarFrame.TextLabel.Text = math.max(onground and 2.5 or math.floor((groundtime - tick()) * 10) / 10, 0).."s"
							end
							lastonground = onground
						else
							onground = true
							lastonground = true
						end

						local flyVelocity = entityLibrary.character.Humanoid.MoveDirection * (FlyMode.Value == "Normal" and FlySpeed.Value or 20)
						entityLibrary.character.HumanoidRootPart.Velocity = flyVelocity + (Vector3.new(0, playerMass + (FlyUp and FlyVerticalSpeed.Value or 0) + (FlyDown and -FlyVerticalSpeed.Value or 0), 0))
						if FlyMode.Value ~= "Normal" then
							entityLibrary.character.HumanoidRootPart.CFrame = entityLibrary.character.HumanoidRootPart.CFrame + (entityLibrary.character.Humanoid.MoveDirection * ((not VoidwareStore.movementDisabled and FlySpeed.Value + getSpeed() or 0) - 20)) * delta
						end
					end
				end)
			else
				pcall(function() coroutine.close(FlyCoroutine) end)
				autobankballoon = false
				waitingforballoon = false
				lastonground = nil
				FlyUp = false
				FlyDown = false
				RunLoops:UnbindFromHeartbeat("Fly")
				if FlyAnywayProgressBarFrame then 
					FlyAnywayProgressBarFrame.Visible = false
				end
				if FlyAutoPop.Enabled then
					if entityLibrary.isAlive and lplr.Character:GetAttribute("InflatedBalloons") then
						for i = 1, lplr.Character:GetAttribute("InflatedBalloons") do
							olddeflate()
						end
					end
				end
				bedwars.BalloonController.deflateBalloon = olddeflate
				olddeflate = nil
			end
		end,
		HoverText = "Makes you go zoom (longer Fly discovered by exelys and Cqded)",
		ExtraText = function() 
			return "Heatseeker"
		end
	})
	FlySpeed = Fly.CreateSlider({
		Name = "Speed",
		Min = 1,
		Max = 23,
		Function = function(val) end, 
		Default = 23
	})
	FlyVerticalSpeed = Fly.CreateSlider({
		Name = "Vertical Speed",
		Min = 1,
		Max = 100,
		Function = function(val) end, 
		Default = 44
	})
	FlyVertical = Fly.CreateToggle({
		Name = "Y Level",
		Function = function() end, 
		Default = true
	})
	FlyAutoPop = Fly.CreateToggle({
		Name = "Pop Balloon",
		Function = function() end, 
		HoverText = "Pops balloons when Fly is disabled."
	})
	local oldcamupdate
	local camcontrol
	local Flydamagecamera = {Enabled = false}
	FlyDamageAnimation = Fly.CreateToggle({
		Name = "Damage Animation",
		Function = function(callback) 
			if Flydamagecamera.Object then 
				Flydamagecamera.Object.Visible = callback
			end
			if callback then 
				task.spawn(function()
					repeat
						task.wait(0.1)
						for i,v in pairs(getconnections(gameCamera:GetPropertyChangedSignal("CameraType"))) do 
							if v.Function then
								camcontrol = debug.getupvalue(v.Function, 1)
							end
						end
					until camcontrol
					local caminput = require(lplr.PlayerScripts.PlayerModule.CameraModule.CameraInput)
					local num = Instance.new("IntValue")
					local numanim
					shared.damageanim = function()
						if numanim then numanim:Cancel() end
						if Flydamagecamera.Enabled then
							num.Value = 1000
							numanim = tweenService:Create(num, TweenInfo.new(0.5), {Value = 0})
							numanim:Play()
						end
					end
					oldcamupdate = camcontrol.Update
					camcontrol.Update = function(self, dt) 
						if camcontrol.activeCameraController then
							camcontrol.activeCameraController:UpdateMouseBehavior()
							local newCameraCFrame, newCameraFocus = camcontrol.activeCameraController:Update(dt)
							gameCamera.CFrame = newCameraCFrame * CFrame.Angles(0, 0, math.rad(num.Value / 100))
							gameCamera.Focus = newCameraFocus
							if camcontrol.activeTransparencyController then
								camcontrol.activeTransparencyController:Update(dt)
							end
							if caminput.getInputEnabled() then
								caminput.resetInputForFrameEnd()
							end
						end
					end
				end)
			else
				shared.damageanim = nil
				if camcontrol then 
					camcontrol.Update = oldcamupdate
				end
			end
		end
	})
	Flydamagecamera = Fly.CreateToggle({
		Name = "Camera Animation",
		Function = function() end,
		Default = true
	})
	Flydamagecamera.Object.BorderSizePixel = 0
	Flydamagecamera.Object.BackgroundTransparency = 0
	Flydamagecamera.Object.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Flydamagecamera.Object.Visible = false
	FlyAnywayProgressBar = Fly.CreateToggle({
		Name = "Progress Bar",
		Function = function(callback) 
			if callback then 
				FlyAnywayProgressBarFrame = Instance.new("Frame")
				FlyAnywayProgressBarFrame.AnchorPoint = Vector2.new(0.5, 0)
				FlyAnywayProgressBarFrame.Position = UDim2.new(0.5, 0, 1, -200)
				FlyAnywayProgressBarFrame.Size = UDim2.new(0.2, 0, 0, 20)
				FlyAnywayProgressBarFrame.BackgroundTransparency = 0.5
				FlyAnywayProgressBarFrame.BorderSizePixel = 0
				FlyAnywayProgressBarFrame.BackgroundColor3 = Color3.new(0, 0, 0)
				FlyAnywayProgressBarFrame.Visible = Fly.Enabled
				FlyAnywayProgressBarFrame.Parent = GuiLibrary.MainGui
				local FlyAnywayProgressBarFrame2 = FlyAnywayProgressBarFrame:Clone()
				FlyAnywayProgressBarFrame2.AnchorPoint = Vector2.new(0, 0)
				FlyAnywayProgressBarFrame2.Position = UDim2.new(0, 0, 0, 0)
				FlyAnywayProgressBarFrame2.Size = UDim2.new(1, 0, 0, 20)
				FlyAnywayProgressBarFrame2.BackgroundTransparency = 0
				FlyAnywayProgressBarFrame2.Visible = true
				FlyAnywayProgressBarFrame2.Parent = FlyAnywayProgressBarFrame
				local FlyAnywayProgressBartext = Instance.new("TextLabel")
				FlyAnywayProgressBartext.Text = "2s"
				FlyAnywayProgressBartext.Font = Enum.Font.Gotham
				FlyAnywayProgressBartext.TextStrokeTransparency = 0
				FlyAnywayProgressBartext.TextColor3 =  Color3.new(0.9, 0.9, 0.9)
				FlyAnywayProgressBartext.TextSize = 20
				FlyAnywayProgressBartext.Size = UDim2.new(1, 0, 1, 0)
				FlyAnywayProgressBartext.BackgroundTransparency = 1
				FlyAnywayProgressBartext.Position = UDim2.new(0, 0, -1, 0)
				FlyAnywayProgressBartext.Parent = FlyAnywayProgressBarFrame
				local FlyProgressbarUICorner = Instance.new("UICorner")
				FlyProgressbarUICorner.CornerRadius = UDim.new(0, 5)
				FlyProgressbarUICorner.Parent = FlyAnywayProgressBarFrame
				local FlyProgressbarUICorner2 = FlyProgressbarUICorner:Clone()
				FlyProgressbarUICorner2.Parent = FlyAnywayProgressBarFrame2
			else
				if FlyAnywayProgressBarFrame then FlyAnywayProgressBarFrame:Destroy() FlyAnywayProgressBarFrame = nil end
			end
		end,
		HoverText = "show amount of Fly time",
		Default = true
	})
	FlyTP = Fly.CreateToggle({
		Name = "TP Down",
		Function = function() end,
		Default = true
	})
end)

runFunction(function()
	pcall(GuiLibrary.RemoveObject, "NameTagsOptionsButton")
	local function floorNameTagPosition(pos)
		return Vector2.new(math.floor(pos.X), math.floor(pos.Y))
	end

	local function removeTags(str)
        str = str:gsub("<br%s*/>", "\n")
        return (str:gsub("<[^<>]->", ""))
    end

	local NameTagsFolder = Instance.new("Folder")
	NameTagsFolder.Name = "NameTagsFolder"
	NameTagsFolder.Parent = GuiLibrary.MainGui
	local nametagsfolderdrawing = {}
	local NameTagsColor = {Value = 0.44}
	local NameTagsDisplayName = {Enabled = false}
	local NameTagsHealth = {Enabled = false}
	local NameTagsDistance = {Enabled = false}
	local NameTagsBackground = {Enabled = true}
	local NameTagsScale = {Value = 10}
	local NameTagsFont = {Value = "SourceSans"}
	local NameTagsTeammates = {Enabled = true}
	local NameTagsShowInventory = {Enabled = false}
	local NameTagsRangeLimit = {Value = 0}
	local fontitems = {"SourceSans"}
	local nametagstrs = {}
	local nametagsizes = {}
	local kititems = {
		jade = "jade_hammer",
		archer = "tactical_crossbow",
		angel = "",
		cowgirl = "lasso",
		dasher = "wood_dao",
		axolotl = "axolotl",
		yeti = "snowball",
		smoke = "smoke_block",
		trapper = "snap_trap",
		pyro = "flamethrower",
		davey = "cannon",
		regent = "void_axe", 
		baker = "apple",
		builder = "builder_hammer",
		farmer_cletus = "carrot_seeds",
		melody = "guitar",
		barbarian = "rageblade",
		gingerbread_man = "gumdrop_bounce_pad",
		spirit_catcher = "spirit",
		fisherman = "fishing_rod",
		oil_man = "oil_consumable",
		santa = "tnt",
		miner = "miner_pickaxe",
		sheep_herder = "crook",
		beast = "speed_potion",
		metal_detector = "metal_detector",
		cyber = "drone",
		vesta = "damage_banner",
		lumen = "light_sword",
		ember = "infernal_saber",
		queen_bee = "bee"
	}

	local nametagfuncs1 = {
		Normal = function(plr)
			if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = Instance.new("TextLabel")
			thing.BackgroundColor3 = Color3.new()
			thing.BorderSizePixel = 0
			thing.Visible = false
			thing.RichText = true
			thing.AnchorPoint = Vector2.new(0.5, 1)
			thing.Name = plr.Player.Name
			thing.Font = Enum.Font[NameTagsFont.Value]
			thing.TextSize = 14 * (NameTagsScale.Value / 10)
			thing.BackgroundTransparency = NameTagsBackground.Enabled and 0.5 or 1
			nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
			if NameTagsHealth.Enabled then
				local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				nametagstrs[plr.Player] = nametagstrs[plr.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.round(plr.Humanoid.Health).."</font>"
			end
			if NameTagsDistance.Enabled then 
				nametagstrs[plr.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[plr.Player]
			end
			local nametagSize = textService:GetTextSize(removeTags(nametagstrs[plr.Player]), thing.TextSize, thing.Font, Vector2.new(100000, 100000))
			thing.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
			thing.Text = nametagstrs[plr.Player]
			thing.TextColor3 = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			thing.Parent = NameTagsFolder
			local hand = Instance.new("ImageLabel")
			hand.Size = UDim2.new(0, 30, 0, 30)
			hand.Name = "Hand"
			hand.BackgroundTransparency = 1
			hand.Position = UDim2.new(0, -30, 0, -30)
			hand.Image = ""
			hand.Parent = thing
			local helmet = hand:Clone()
			helmet.Name = "Helmet"
			helmet.Position = UDim2.new(0, 5, 0, -30)
			helmet.Parent = thing
			local chest = hand:Clone()
			chest.Name = "Chestplate"
			chest.Position = UDim2.new(0, 35, 0, -30)
			chest.Parent = thing
			local boots = hand:Clone()
			boots.Name = "Boots"
			boots.Position = UDim2.new(0, 65, 0, -30)
			boots.Parent = thing
			local kit = hand:Clone()
			kit.Name = "Kit"
			task.spawn(function()
				repeat task.wait() until plr.Player:GetAttribute("PlayingAsKit") ~= ""
				if kit then
					kit.Image = kititems[plr.Player:GetAttribute("PlayingAsKit")] and bedwars.getIcon({itemType = kititems[plr.Player:GetAttribute("PlayingAsKit")]}, NameTagsShowInventory.Enabled) or ""
				end
			end)
			kit.Position = UDim2.new(0, -30, 0, -65)
			kit.Parent = thing
			nametagsfolderdrawing[plr.Player] = {entity = plr, Main = thing}
		end,
		Drawing = function(plr)
			if NameTagsTeammates.Enabled and (not plr.Targetable) and (not plr.Friend) then return end
			local thing = {Main = {}, entity = plr}
			thing.Main.Text = Drawing.new("Text")
			thing.Main.Text.Size = 17 * (NameTagsScale.Value / 10)
			thing.Main.Text.Font = (math.clamp((table.find(fontitems, NameTagsFont.Value) or 1) - 1, 0, 3))
			thing.Main.Text.ZIndex = 2
			thing.Main.BG = Drawing.new("Square")
			thing.Main.BG.Filled = true
			thing.Main.BG.Transparency = 0.5
			thing.Main.BG.Visible = NameTagsBackground.Enabled
			thing.Main.BG.Color = Color3.new()
			thing.Main.BG.ZIndex = 1
			nametagstrs[plr.Player] = WhitelistFunctions:GetTag(plr.Player)..(NameTagsDisplayName.Enabled and plr.Player.DisplayName or plr.Player.Name)
			if NameTagsHealth.Enabled then
				local color = Color3.fromHSV(math.clamp(plr.Humanoid.Health / plr.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
				nametagstrs[plr.Player] = nametagstrs[plr.Player]..' '..math.round(plr.Humanoid.Health)
			end
			if NameTagsDistance.Enabled then 
				nametagstrs[plr.Player] = '[%s] '..nametagstrs[plr.Player]
			end
			thing.Main.Text.Text = nametagstrs[plr.Player]
			thing.Main.BG.Size = Vector2.new(thing.Main.Text.TextBounds.X + 4, thing.Main.Text.TextBounds.Y)
			thing.Main.Text.Color = getPlayerColor(plr.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			nametagsfolderdrawing[plr.Player] = thing
		end
	}

	local nametagfuncs2 = {
		Normal = function(ent)
			local v = nametagsfolderdrawing[ent]
			nametagsfolderdrawing[ent] = nil
			if v then 
				v.Main:Destroy()
			end
		end,
		Drawing = function(ent)
			local v = nametagsfolderdrawing[ent]
			nametagsfolderdrawing[ent] = nil
			if v then 
				for i2,v2 in pairs(v.Main) do
					pcall(function() v2.Visible = false v2:Remove() end)
				end
			end
		end
	}

	local nametagupdatefuncs = {
		Normal = function(ent)
			local v = nametagsfolderdrawing[ent.Player]
			if v then 
				nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
				local tagdata = VoidwareFunctions:GetLocalTag(ent.Player)
				if tagdata.Text ~= "" then 
					nametagstrs[ent.Player] = "<font color='#"..tagdata.Color.."'>["..tagdata.Text.."]</font> "..nametagstrs[ent.Player]
				end
				if NameTagsHealth.Enabled then
					local color = Color3.fromHSV(math.clamp(ent.Humanoid.Health / ent.Humanoid.MaxHealth, 0, 1) / 2.5, 0.89, 1)
					nametagstrs[ent.Player] = nametagstrs[ent.Player]..' <font color="rgb('..tostring(math.floor(color.R * 255))..','..tostring(math.floor(color.G * 255))..','..tostring(math.floor(color.B * 255))..')">'..math.floor(ent.Player.Character:GetAttribute("Health") or ent.Humanoid.Health).."</font>"
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[ent.Player] = '<font color="rgb(85, 255, 85)">[</font><font color="rgb(255, 255, 255)">%s</font><font color="rgb(85, 255, 85)">]</font> '..nametagstrs[ent.Player]
				end
				if NameTagsShowInventory.Enabled then 
					local inventory = bedwarsStore.inventories[ent.Player] or {armor = {}}
					if inventory.hand then
						v.Main.Hand.Image = bedwars.getIcon(inventory.hand, NameTagsShowInventory.Enabled)
						if v.Main.Hand.Image:find("rbxasset://") then
							v.Main.Hand.ResampleMode = Enum.ResamplerMode.Pixelated
						end
					else
						v.Main.Hand.Image = ""
					end
					if inventory.armor[4] then
						v.Main.Helmet.Image = bedwars.getIcon(inventory.armor[4], NameTagsShowInventory.Enabled)
						if v.Main.Helmet.Image:find("rbxasset://") then
							v.Main.Helmet.ResampleMode = Enum.ResamplerMode.Pixelated
						end
					else
						v.Main.Helmet.Image = ""
					end
					if inventory.armor[5] then
						v.Main.Chestplate.Image = bedwars.getIcon(inventory.armor[5], NameTagsShowInventory.Enabled)
						if v.Main.Chestplate.Image:find("rbxasset://") then
							v.Main.Chestplate.ResampleMode = Enum.ResamplerMode.Pixelated
						end
					else
						v.Main.Chestplate.Image = ""
					end
					if inventory.armor[6] then
						v.Main.Boots.Image = bedwars.getIcon(inventory.armor[6], NameTagsShowInventory.Enabled)
						if v.Main.Boots.Image:find("rbxasset://") then
							v.Main.Boots.ResampleMode = Enum.ResamplerMode.Pixelated
						end
					else
						v.Main.Boots.Image = ""
					end
				end
				local nametagSize = textService:GetTextSize(removeTags(nametagstrs[ent.Player]), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
				v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
				v.Main.Text = nametagstrs[ent.Player]
			end
		end,
		Drawing = function(ent)
			local v = nametagsfolderdrawing[ent.Player]
			if v then 
				nametagstrs[ent.Player] = WhitelistFunctions:GetTag(ent.Player)..(NameTagsDisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name)
				local tagdata = VoidwareFunctions:GetLocalTag(ent.Player)
				if tagdata.Text ~= "" then 
					nametagstrs[ent.Player] = "["..tagdata.Text.."] "..nametagstrs[ent.Player]
				end
				if NameTagsHealth.Enabled then
					nametagstrs[ent.Player] = nametagstrs[ent.Player]..' '..math.floor(ent.Player.Character:GetAttribute("Health") or ent.Humanoid.Health)
				end
				if NameTagsDistance.Enabled then 
					nametagstrs[ent.Player] = '[%s] '..nametagstrs[ent.Player]
					v.Main.Text.Text = entityLibrary.isAlive and string.format(nametagstrs[ent.Player], math.floor((entityLibrary.character.HumanoidRootPart.Position - ent.RootPart.Position).Magnitude)) or nametagstrs[ent.Player]
				else
					v.Main.Text.Text = nametagstrs[ent.Player]
				end
				v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
				v.Main.Text.Color = getPlayerColor(ent.Player) or Color3.fromHSV(NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
			end
		end
	}

	local nametagcolorfuncs = {
		Normal = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(nametagsfolderdrawing) do 
				v.Main.TextColor3 = getPlayerColor(v.entity.Player) or color
			end
		end,
		Drawing = function(hue, sat, value)
			local color = Color3.fromHSV(hue, sat, value)
			for i,v in pairs(nametagsfolderdrawing) do 
				v.Main.Text.Color = getPlayerColor(v.entity.Player) or color
			end
		end
	}

	local nametagloop = {
		Normal = function()
			for i,v in pairs(nametagsfolderdrawing) do 
				local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
				if not headVis then 
					v.Main.Visible = false
					continue
				end
				local mag = entityLibrary.isAlive and math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude) or 0
				if NameTagsRangeLimit.Value ~= 0 and mag > NameTagsRangeLimit.Value then 
					v.Main.Visible = false
					continue
				end
				if NameTagsDistance.Enabled then
					local stringsize = tostring(mag):len()
					if nametagsizes[v.entity.Player] ~= stringsize then 
						local nametagSize = textService:GetTextSize(removeTags(string.format(nametagstrs[v.entity.Player], mag)), v.Main.TextSize, v.Main.Font, Vector2.new(100000, 100000))
						v.Main.Size = UDim2.new(0, nametagSize.X + 4, 0, nametagSize.Y)
					end
					nametagsizes[v.entity.Player] = stringsize
					v.Main.Text = string.format(nametagstrs[v.entity.Player], mag)
				end
				v.Main.Position = UDim2.new(0, headPos.X, 0, headPos.Y)
				v.Main.Visible = true
			end
		end,
		Drawing = function()
			for i,v in pairs(nametagsfolderdrawing) do 
				local headPos, headVis = worldtoscreenpoint((v.entity.RootPart:GetRenderCFrame() * CFrame.new(0, v.entity.Head.Size.Y + v.entity.RootPart.Size.Y, 0)).Position)
				if not headVis then 
					v.Main.Text.Visible = false
					v.Main.BG.Visible = false
					continue
				end
				local mag = entityLibrary.isAlive and math.floor((entityLibrary.character.HumanoidRootPart.Position - v.entity.RootPart.Position).Magnitude) or 0
				if NameTagsRangeLimit.Value ~= 0 and mag > NameTagsRangeLimit.Value then 
					v.Main.Text.Visible = false
					v.Main.BG.Visible = false
					continue
				end
				if NameTagsDistance.Enabled then
					local stringsize = tostring(mag):len()
					v.Main.Text.Text = string.format(nametagstrs[v.entity.Player], mag)
					if nametagsizes[v.entity.Player] ~= stringsize then 
						v.Main.BG.Size = Vector2.new(v.Main.Text.TextBounds.X + 4, v.Main.Text.TextBounds.Y)
					end
					nametagsizes[v.entity.Player] = stringsize
				end
				v.Main.BG.Position = Vector2.new(headPos.X - (v.Main.BG.Size.X / 2), (headPos.Y + v.Main.BG.Size.Y))
				v.Main.Text.Position = v.Main.BG.Position + Vector2.new(2, 0)
				v.Main.Text.Visible = true
				v.Main.BG.Visible = NameTagsBackground.Enabled
			end
		end
	}

	local methodused

	local NameTags = {Enabled = false}
	NameTags = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "NameTags", 
		Function = function(callback) 
			if callback then
				methodused = NameTagsDrawing.Enabled and "Drawing" or "Normal"
				if nametagfuncs2[methodused] then
					table.insert(NameTags.Connections, entityLibrary.entityRemovedEvent:Connect(nametagfuncs2[methodused]))
				end
				if nametagfuncs1[methodused] then
					local addfunc = nametagfuncs1[methodused]
					for i,v in pairs(entityLibrary.entityList) do 
						if nametagsfolderdrawing[v.Player] then nametagfuncs2[methodused](v.Player) end
						addfunc(v)
					end
					table.insert(NameTags.Connections, entityLibrary.entityAddedEvent:Connect(function(ent)
						if nametagsfolderdrawing[ent.Player] then nametagfuncs2[methodused](ent.Player) end
						addfunc(ent)
					end))
				end
				if nametagupdatefuncs[methodused] then
					table.insert(NameTags.Connections, entityLibrary.entityUpdatedEvent:Connect(nametagupdatefuncs[methodused]))
					for i,v in pairs(entityLibrary.entityList) do 
						nametagupdatefuncs[methodused](v)
					end
				end
				if nametagcolorfuncs[methodused] then 
					table.insert(NameTags.Connections, GuiLibrary.ObjectsThatCanBeSaved.FriendsListTextCircleList.Api.FriendColorRefresh.Event:Connect(function()
						nametagcolorfuncs[methodused](NameTagsColor.Hue, NameTagsColor.Sat, NameTagsColor.Value)
					end))
				end
				if nametagloop[methodused] then 
					RunLoops:BindToRenderStep("NameTags", nametagloop[methodused])
				end
			else
				RunLoops:UnbindFromRenderStep("NameTags")
				if nametagfuncs2[methodused] then
					for i,v in pairs(nametagsfolderdrawing) do 
						nametagfuncs2[methodused](i)
					end
				end
			end
		end,
		HoverText = "Renders nametags on entities through walls."
	})
	for i,v in pairs(Enum.Font:GetEnumItems()) do 
		if v.Name ~= "SourceSans" then 
			table.insert(fontitems, v.Name)
		end
	end
	NameTagsFont = NameTags.CreateDropdown({
		Name = "Font",
		List = fontitems,
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
	})
	NameTagsColor = NameTags.CreateColorSlider({
		Name = "Player Color", 
		Function = function(hue, sat, val) 
			if NameTags.Enabled and nametagcolorfuncs[methodused] then 
				nametagcolorfuncs[methodused](hue, sat, val)
			end
		end
	})
	NameTagsScale = NameTags.CreateSlider({
		Name = "Scale",
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = 10,
		Min = 1,
		Max = 50
	})
	NameTagsRangeLimit = NameTags.CreateSlider({
		Name = "Range",
		Function = function() end,
		Min = 0,
		Max = 1000,
		Default = 0
	})
	NameTagsBackground = NameTags.CreateToggle({
		Name = "Background", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsDisplayName = NameTags.CreateToggle({
		Name = "Use Display Name", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsHealth = NameTags.CreateToggle({
		Name = "Health", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
	})
	NameTagsDistance = NameTags.CreateToggle({
		Name = "Distance", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end
	})
	NameTagsShowInventory = NameTags.CreateToggle({
		Name = "Equipment",
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsTeammates = NameTags.CreateToggle({
		Name = "Teammates", 
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
		Default = true
	})
	NameTagsDrawing = NameTags.CreateToggle({
		Name = "Drawing",
		Function = function() if NameTags.Enabled then NameTags.ToggleButton(false) NameTags.ToggleButton(false) end end,
	})
end)

VoidwareStore.TargetUpdateEvent = Instance.new("BindableEvent")
local currentTargetConnections = {}
local oldtarget = vapeTargetInfo.Targets.Killaura
local oldtargetplayer = vapeTargetInfo.Targets.Killaura and vapeTargetInfo.Targets.Killaura.Player
local targethealthloops = {}
local targetloopstobreak = 0
task.spawn(function()
	repeat
		if vapeTargetInfo.Targets.Killaura ~= oldtarget or (oldtarget and vapeTargetInfo.Targets.Killaura and vapeTargetInfo.Targets.Killaura.Player ~= oldtargetplayer) then
			oldtarget = vapeTargetInfo.Targets.Killaura
			local plr = vapeTargetInfo.Targets.Killaura and vapeTargetInfo.Targets.Killaura.Player
			oldtargetplayer = plr
			VoidwareStore.TargetUpdateEvent:Fire(plr)
		end
	task.wait()
	until not vapeInjected
end)

task.spawn(function()
    local tweenmodules = {"BedTP", "EmeraldTP", "DiamondTP", "MiddleTP", "Autowin", "PlayerTP"}
    local tweening = false
    repeat
    for i,v in pairs(tweenmodules) do
        pcall(function()
        if GuiLibrary.ObjectsThatCanBeSaved[v.."OptionsButton"].Api.Enabled then
            tweening = true
        end
        end)
    end
    VoidwareStore.Tweening = tweening
    tweening = false
    task.wait()
  until not vapeInjected
end)

local function dumptable(tab, tabtype, sortfunction)
	local data = {}
	for i,v in pairs(tab) do
		local tabtype = tabtype and tabtype == 1 and i or v
		table.insert(data, tabtype)
	end
	if sortfunction and type(sortfunction) == "function" then
		table.sort(data, sortfunction)
	end
	return data
end

local function getTablePosition(tab, object, first)
	local count = 0
	for i,v in tab do 
		count = count + 1
		if (first and i or v) == object then 
			break
		end
	end
	return count
end

task.spawn(function()
	repeat task.wait()
	pcall(shared.VoidwareStore.UpdateTargetInfo, vapeTargetInfo.Targets.Killaura)
	until not vapeInjected
end)

local LegitMode = {Enabled = false}
runFunction(function()
	local moduleshidden = false
	local whitelistedmodules = {"HannahAura", "AutoLeave", "Killaura", "FastConsume", "Scaffold", "AutoReport", "EventNotifications", "AutoReportV2", "AutoKit", "ChatCustomizer", "HackerDetector", "ProjectileExploit", "RegionDetector", "ShopTierBypass", "VapePrivateDetector", "AutoForge", "AutoBalloon", "AutoHotbar", "SafeWalk", "AutoTool", "LightingTheme", "Freecam", "AutoBank", "OpenEnderchest", "ProjectileAimbot"}
	if GetCurrentProfile() == "Ghost" then
	LegitMode = GuiLibrary.CreateLegitModule({
		Name = "Hide Blatant",
		Function = function(callback) 
			task.spawn(function()
				if callback then
				if not shared.VapeFullyLoaded then 
				    repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected
			    end
				if not vapeInjected then return end
				if #shared.VoidwareStore.BlatantModules > 0 then table.clear(shared.VoidwareStore.BlatantModules) end
				for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
				  if v.Type == "OptionsButton" then
					if (not tostring(v.Object.Parent.Parent):find("Render") and not tostring(v.Object.Parent.Parent):find("Combat") or i == "GamingChairOptionsButton" or i == "NoClickDelayOptionsButton") then
						local modulename = string.gsub(i, "OptionsButton", "")
						if not table.find(whitelistedmodules, modulename) then
							if v.Api.Enabled then
								v.Api.ToggleButton(false)
								table.insert(shared.VoidwareStore.BlatantModules, i)
							end
							GuiLibrary.RemoveObject(i)
						end
					  end
				    end
				end
				moduleshidden = true
			else
				task.wait(1.5)
				if not vapeInjected then return end
				if moduleshidden then
					local uninjected = pcall(antiguibypass)
					if uninjected then
						if isfile("vape/NewMainScript.lua") then
							loadstring(readfile("vape/NewMainScript.lua"))()
						else
							task.wait(VoidwareStore.MobileInUse and 0.30 or 0.1)
							loadstring(VoidwareFunctions:GetFile("System/NewMainScript.lua", true))() 
						end
					end
				end
			end
			end)
		end
	})
end
end)

task.spawn(function()
local regionfetched, res = pcall(function() return bedwars.ClientHandler:Get("FetchServerRegion"):CallServer() end)
if regionfetched and res then
	VoidwareStore.ServerRegion = res
end
end)

task.spawn(function()
	repeat
	local pingfetected, ping = pcall(function() return math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue()) end)
	if pingfetected then VoidwareStore.CurrentPing = ping end
	task.wait()
 until not vapeInjected
end)

task.spawn(function()
	if not shared.VapeFullyLoaded then 
		repeat task.wait() until shared.VapeFullyLoaded 
	end
	if LegitMode.Enabled then return end
	for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
		if v.Type == "OptionsButton" and table.find(shared.VoidwareStore.BlatantModules, i) and GetCurrentProfile() == "Ghost" then
			if not v.Api.Enabled then
				v.Api.ToggleButton(false)
			end
		end
	end
end)

pcall(function() getgenv().VoidwareFunctions = VoidwareFunctions end)

pcall(function()
	GuiLibrary.ObjectsThatCanBeSaved.FlyOptionsButton.Api.NoSave = true
	GuiLibrary.ObjectsThatCanBeSaved.InfiniteFlyOptionsButton.Api.NoSave = true
end)

local oldannounce = {}
local function runvoidwaredata()
	local datatable = ({pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("maintab.vw", true)) end)})[2]
	if datatable and type(datatable) == "table" then 
		if datatable.Announcement and datatable.AnnouncementText ~= oldannounce.AnnouncementText and vapeInjected then 
			task.spawn(function() VoidwareFunctions:Announcement({Text = datatable.AnnouncementText, Duration = datatable.AnnouncementDuration}) end)
		end
		if datatable.Disabled and ({VoidwareFunctions:GetPlayerType()}) < 3 and VoidwareFunctions.WhitelistLoaded then 
			task.spawn(antiguibypass)
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware",
				Text = "Voidware is currently disabled. Check for updates at voidwareclient.xyz",
				Duration = 10,
			})
		end
		oldannounce = datatable
		writefile(VoidwareFunctions:GetMainDirectory().."/maintab.vw", httpService:JSONEncode(datatable))
	end
	task.wait(5)
end

task.spawn(function() 
	repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected
	if not vapeInjected then 
		return 
	end
	local oldtab = ({pcall(function() return httpService:JSONDecode(readfile(VoidwareFunctions:GetMainDirectory().."/maintab.vw")) end)})[2] 
	if oldtab and type(oldtab) == "table" then 
		oldannounce = oldtab
	end
	repeat runvoidwaredata() until not vapeInjected
end)

task.spawn(function()
	local removed = {"ServerHop", "PerformanceBooster", "AutoRejoin"}
	for i,v in removed do 
		pcall(GuiLibrary.RemoveObject, v.."OptionsButton")
	end
end)

pcall(function()
	table.insert(vapeConnections, replicatedStorageService["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].abilityUsed.OnClientEvent:Connect(function(ability, char)
		vapeEvents.AbilityUsed:Fire(char, ability)
	end))
end)

task.spawn(function()
	VoidwareStore.GameFinished = shared.VoidwareStore.GameFinished
	repeat
	shared.VoidwareStore.GameFinished = VoidwareStore.GameFinished
	task.wait()
	until not vapeInjected
end)

task.spawn(function()
	pcall(function()
		VoidwareStore.map = workspace:WaitForChild("Map"):WaitForChild("Worlds"):GetChildren()[1].Name
		VoidwareStore.map = string.gsub(string.split(VoidwareStore.map, "_")[2] or VoidwareStore.map, "-", "") or "Blank"
	end)
end)

task.spawn(function()
	if not shared.VapeFullyLoaded then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not vapeInjected then return end
	for i,v in pairs(shared.VoidwareStore.Messages) do
		task.spawn(InfoNotification, "Voidware", v, 8)
	end
	table.clear(shared.VoidwareStore.Messages)
end)

task.spawn(function()
	repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected
	if GetCurrentProfile() ~= "Ghost" then shared.VoidwareStore.LiteNotification = nil end
	if vapeInjected and GetCurrentProfile() == "Ghost" and not shared.VoidwareStore.LiteNotification then 
		InfoNotification("Voidware Lite", "Voidware is currently in closet cheating mode.", 7)
		shared.VoidwareStore.LiteNotification = true
	end
end)

local function getrandomvalue(tab)
	return tab and type(tab) == "table" and #tab > 0 and tab[math.random(1, #tab)] or ""
end

table.insert(vapeConnections, VoidwareStore.MatchEndEvent.Event:Connect(function()
	VoidwareStore.GameFinished = true
	shared.VoidwareStore.GameFinished = true

end))

table.insert(vapeConnections, vapeEvents.MatchEndEvent.Event:Connect(function()
	if not VoidwareStore.GameFinished then 
	  VoidwareStore.GameFinished = true
	  shared.VoidwareStore.MatchEndEvent = true
	  VoidwareStore.MatchEndEvent:Fire()
	end
end))

local function GetMagnitudeOf2Objects(part, part2, bypass)
	local magnitude, partcount = 0, 0
	if not bypass then 
		local suc, res = pcall(function() return part.Position end)
		partcount = suc and partcount + 1 or partcount
		suc, res = pcall(function() return part2.Position end)
		partcount = suc and partcount + 1 or partcount
	end
	if partcount > 1 or bypass then 
		magnitude = bypass and (part - part2).magnitude or (part.Position - part2.Position).magnitude
	end
	return magnitude
end

local function GetClanTag(plr)
	local atr, res = pcall(function()
		return plr:GetAttribute("ClanTag")
	end)
	return atr and res ~= nil and res
end

local function GetEnumItems(EnumType)
	local items = {}
	for i,v in pairs(Enum[EnumType]:GetEnumItems()) do
		table.insert(items, v.Name)
	end
	return items
end

local function isAlive(plr, healthblacklist)
	plr = plr or lplr
	local alive = false 
	if plr.Character and plr.Character.PrimaryPart and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Head") then 
		alive = true
	end
	if (not plr:GetAttribute("LobbyConnected") or not plr:GetAttribute("PlayerConnected")) and alive then 
		alive = false
	end
	if not healthblacklist and alive and plr.Character.Humanoid.Health <= 0 then 
		alive = false
	end
	return alive
end

local function GetAllLocalProjectiles(otherprojectiles)
	local projectiletab = {}
	local novelprojectiles = {"fireball", "glue_projectile", "snowball", "throwing_knife", "spear", "sticky_firework"}
	local function isprojectileitem(projectile)
		return projectile:find("bow") or projectile:find("headhunter") or otherprojectiles and table.find(novelprojectiles, projectile) or false
	end
	for i,v in pairs(bedwarsStore.localInventory.inventory.items) do
		if v.itemType and isprojectileitem(v.itemType) then
			projectiletab[v.itemType] = {mainprojectile = v.itemType, ammo = (v.itemType:find("bow") or v.itemType:find("headhunter")) and "arrow" or v.itemType}
		end
	end
	return projectiletab
end

local function GetTopBlock(position, smart, raycast, customvector)
	position = position or isAlive(lplr, true) and lplr.Character.HumanoidRootPart.Position
	if not position then 
		return nil 
	end
	if raycast and not workspace:Raycast(position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast) then
	    return nil
    end
	local lastblock = nil
	for i = 1, 500 do 
		local newray = workspace:Raycast(lastblock and lastblock.Position or position, customvector or Vector3.new(0.55, 999999, 0.55), bedwarsStore.blockRaycast)
		local smartest = newray and smart and workspace:Raycast(lastblock and lastblock.Position or position, Vector3.new(0, 5.5, 0), bedwarsStore.blockRaycast) or not smart
		if newray and smartest then
			lastblock = newray
		else
			break
		end
	end
	return lastblock
end


local function FindEnemyBed(maxdistance, highest)
	local target = nil
	local distance = maxdistance or math.huge
	local whitelistuserteams = {}
	local badbeds = {}
	if not lplr:GetAttribute("Team") then return nil end
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr then
			local type, attackable = VoidwareFunctions:GetPlayerType(v)
			if not attackable then
			whitelistuserteams[v:GetAttribute("Team")] = true
			end
		end
	end
	for i,v in pairs(collectionService:GetTagged("bed")) do
			local bedteamstring = string.split(v:GetAttribute("id"), "_")[1]
			if whitelistuserteams[bedteamstring] ~= nil then
			   badbeds[v] = true
		    end
	    end
	for i,v in pairs(collectionService:GetTagged("bed")) do
		if v:GetAttribute("id") and v:GetAttribute("id") ~= lplr:GetAttribute("Team").."_bed" and badbeds[v] == nil and lplr.Character and lplr.Character.PrimaryPart then
			if v:GetAttribute("NoBreak") or v:GetAttribute("PlacedByUserId") and v:GetAttribute("PlacedByUserId") ~= 0 then continue end
			local magdist = GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, v)
			if magdist < distance then
				target = v
				distance = magdist
			end
		end
	end
	local coveredblock = highest and target and GetTopBlock(target.Position, true)
	if coveredblock then
		target = coveredblock.Instance
	end
	return target
end

function RunLoops:BindToFunction(argstable)
	local connectiontable = {}
	local connectiondisabled = false
	function connectiontable:Disconnect() connectiondisabled = true end
	task.spawn(function()
		if not argstable.BindFunction or not argstable.Function then return end
		repeat
		local currentres = argstable.BindFunction()
		local oldres = argstable.BindFunction()
		if argstable.Response == false or argstable.Response then
			repeat currentres = argstable.BindFunction(argstable.BindFunctionArgs) task.wait() until currentres == argstable.Response or connectiondisabled
		else
			repeat currentres = argstable.BindFunction(argstable.BindFunctionArgs) task.wait() until not currentres or connectiondisabled
		end
		if not connectiondisabled and (argstable.Loop and currentres ~= oldres or not argstable.Loop) then 
			task.spawn(argstable.Function, argstable.FunctionArgs)
		end
		oldres = currentres
		if connectiondisabled or not argstable.Loop then
			break
		end
	   task.wait() 
	   until connectiondisabled
	end)
	return connectiontable
end

table.insert(vapeConnections, RunLoops:BindToFunction({
	BindFunction = isAlive, 
	BindFunctionArgs = table.unpack({lplr, true}),
	Response = false,
	Function = function() VoidwareStore.HumanoidDied:Fire() end,
	FunctionArgs = {},
	Loop = true
}))

runFunction(function()
	local function bedshieldsactive()
		if bedwarsStore.matchState == 0 then repeat task.wait() until bedwarsStore.matchState ~= 0 end
		local bed = FindEnemyBed()
		if bed and bed:GetAttribute("BedShieldEndTime")  then
			if bed:GetAttribute("BedShieldEndTime") >= workspace:GetServerTimeNow() then 
				return true
			else
				return false
			end
		end
		return nil
	end
	table.insert(vapeConnections, RunLoops:BindToFunction({
		BindFunction = bedshieldsactive, 
		BindFunctionArgs = {},
		Response = false,
		Function = function() 
			VoidwareStore.BedShieldEnd:Fire()
		end,
		FunctionArgs = {}
	}))
end)

local function GetBedByTeam(plr)
	if not plr or not plr.Team or not plr.Team.TeamColor then return nil end 
	for i,v in pairs(collectionService:GetTagged("bed")) do 
		if v:FindFirstChild("Covers") and v.Covers.BrickColor == plr.Team.TeamColor then 
			return v
		end
	end
	return nil
end

local function matchEndSignal()
	local aliveplayers = 0
	for i,v in pairs(playersService:GetPlayers()) do 
		if v ~= lplr and lplr.Team and lplr.Team.Name ~= "Spectators" then 
			aliveplayers = aliveplayers + 1
			if not isAlive(v, true) and v.Team and v.Team.Name == "Spectators" and GetBedByTeam(v) == nil and bedwarsStore.matchState ~= 0 and bedwarsStore.queueType ~= "bedwars_test" then 
				aliveplayers = aliveplayers - 1
			end
		end
	end
	return aliveplayers == 0
end

table.insert(vapeConnections, RunLoops:BindToFunction({
	BindFunction = matchEndSignal, 
	BindFunctionArgs = {},
	Response = true,
	Function = function() 
	task.wait(0.2)
	if bedwars.ClientStoreHandler:getState().Game.customMatch == nil and not VoidwareStore.GameFinished then 
		VoidwareStore.MatchEndEvent:Fire()
	  end
   end,
	FunctionArgs = {},
	Loop = true
}))

table.insert(vapeConnections, lplr.CharacterAdded:Connect(function()
	if not isAlive() then repeat task.wait() until isAlive() end
	VoidwareStore.AliveTick = tick()
end))

local animations = {}
local function playAnimation(animid, loop, onstart, onend)
	for i,v in pairs(animations) do pcall(function() v:Stop() end) end
	table.clear(animations)
	local playedanim
	local loopcheck = loop and true or false
	local animid = animid or ""
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://"..animid
	local animation, animationgotten = pcall(function() playedanim = lplr.Character.Humanoid.Animator:LoadAnimation(anim) end)
	if animation then
		playedanim.Priority = Enum.AnimationPriority.Action4
		playedanim.Looped = loopcheck
		playedanim:Play()
		pcall(function() onstart() end)
		if onend then table.insert(vapeConnections, playedanim.Ended:Connect(onend)) end
		table.insert(animations, playedanim)
		return playedanim, anim
	end
	return nil
end


local function GetRaycast(player)
	plr = player or lplr 
	return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and workspace:Raycast(plr.Character.HumanoidRootPart.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast) or false
end

local function ShopItemAvailable(itemType)
	for i,v in pairs(bedwars.ShopItems) do 
		if v.itemType == itemType then return v end
	end
	return false
end

local function GetBedTeam(bedtomark)
    for i,v in pairs(game.Teams:GetChildren()) do
        if bedtomark.Covers.BrickColor == v.TeamColor then
	        VoidwareStore.bedtable[bedtomark] = v.Name
	       break
      end
    end
end

table.insert(vapeConnections, collectionService:GetInstanceAddedSignal("bed"):Connect(function(bed)
	task.spawn(GetBedTeam, bed)
end))

task.spawn(function()
	pcall(function()
		for i,v in pairs(collectionService:GetTagged("bed")) do
		pcall(GetBedTeam, v)
		end
	end)
end)

local function getNearestBlock()
	local block = nil
	local distance = math.huge
	for i,v in pairs(collectionService:GetTagged("block")) do
			local magdist = GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, v)
			if magdist < distance then
				blockpos = v
				distance = magdist
			end
		end
	return block
end

local function GetItemAmount(item)
	for i,v in pairs(bedwars.getInventory(lplr).items) do
		if v.itemType == item then
		return v.amount
		end
	end
	return 0
end

task.spawn(function()
	if shared.VoidwareStore.playerFriends == nil or type(shared.VoidwareStore.playerFriends) ~= "table" then
		shared.VoidwareStore.playerFriends = {}
	end
	local function assignfriends(plr)
		local success, friendsPage 
		repeat success, friendsPage = pcall(function() return playersService:GetFriendsAsync(plr.UserId) end) task.wait() until success and friendsPage
		local friends = {}
		repeat 
		for i,v in pairs(friendsPage:GetCurrentPage()) do 
			table.insert(friends, v)
		end
		if not friendsPage.IsFinished then
			friendsPage:AdvanceToNextPageAsync()
		end
		task.wait()
		until friendsPage.IsFinished 
		shared.VoidwareStore.playerFriends[plr.UserId] = friends
		
	end
	table.insert(vapeConnections, playersService.PlayerAdded:Connect(function(v)
		if bedwarsStore.matchState ~= 0 then
		   task.spawn(assignfriends, v)
		end
	end))
end)

local function FindNearestBlock(dist)
	local blockdist = dist or math.huge
	local block = nil
	for i,v in pairs(collectionService:GetTagged("block")) do
		local distance = GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, v)
		if distance < blockdist then
			blockdist = distance
			block = v
		end
	end
	return block
end

local function GetHandItem()
	local hand, invitem = pcall(function() return tostring(lplr.Character.HandInvItem.Value) end)
	return hand and invitem
end

local function GetCurrentKit(plr)
	local atr, res = pcall(function()
	    return plr:GetAttribute("PlayingAsKit")
	end)
	if atr and res ~= nil then
		return atr and res
	end
	return ""
end

local function GetAllQueueDescriptions(data)
	local queuedata, queueids = {}, {}
	local rankedunlocked = lplr:GetAttribute("PlayerLevel") and tonumber(lplr:GetAttribute("PlayerLevel")) >= 10 and tonumer(lplr.AccountAge) >= 7
	for i,v in pairs(bedwars.QueueMeta) do 
		if v.rankCategory and not rankedunlocked then
			continue
		end
		if v.voiceChatOnly and not game:GetService("VoiceChatService"):IsVoiceEnabledForUserIdAsync(lplr.UserId) then
			continue
		end
		if not v.disabled then
			table.insert(queuedata, data and v[data] or i)
			queueids[i] = v.title
		end
	end
	return queuedata, queueids
end

local function FindTeamBed()
	local bedstate, res = pcall(function()
		return lplr.leaderstats.Bed.Value
	end)
	return bedstate and res and res ~= nil and res == "✅"
end


local function FindItemDrop(item)
	local itemdist = nil
	local dist = math.huge
	local function abletocalculate() return lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") end
    for i,v in pairs(collectionService:GetTagged("ItemDrop")) do
		if v and v.Name == item and abletocalculate() then
			local itemdistance = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v)
			if itemdistance < dist then
			itemdist = v
			dist = itemdistance
		end
		end
	end
	return itemdist
end

local function FindTarget(dist, blockRaycast, includemobs, healthmethod)
	local sort, entity = healthmethod and math.huge or dist or math.huge, {}
	local function abletocalculate() return lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") end
	local sortmethods = {Normal = function(entityroot, entityhealth) return abletocalculate() and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, entityroot) < sort end, Health = function(entityroot, entityhealth) return abletocalculate() and entityhealth < sort end}
	local sortmethod = healthmethod and "Health" or "Normal"
	local function raycasted(entityroot) return abletocalculate() and blockRaycast and workspace:Raycast(entityroot.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast) or not blockRaycast and true or false end
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and abletocalculate() and isAlive(v) and ({VoidwareFunctions:GetPlayerType(v)})[2] and v.Team ~= lplr.Team then
			if not ({WhitelistFunctions:GetWhitelist(v)})[2] then 
				continue
			end
			if sortmethods[sortmethod](v.Character.HumanoidRootPart, v.Character:GetAttribute("Health") or v.Character.Humanoid.Health) and raycasted(v.Character.HumanoidRootPart) then
				sort = healthmethod and v.Character.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.Character.HumanoidRootPart)
				entity.Player = v
				entity.Human = true 
				entity.RootPart = v.Character.HumanoidRootPart
				entity.Humanoid = v.Character.Humanoid
			end
		end
	end
	if includemobs then
		local maxdistance = dist or math.huge
		for i,v in pairs(bedwarsStore.pots) do
			if abletocalculate() and v.PrimaryPart and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart) < maxdistance then
			entity.Player = {Character = v, Name = "PotEntity", DisplayName = "PotEntity", UserId = 1}
			entity.Human = false
			entity.RootPart = v.PrimaryPart
			entity.Humanoid = {Health = 1, MaxHealth = 1}
			end
		end
		for i,v in pairs(collectionService:GetTagged("DiamondGuardian")) do 
			if v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health and abletocalculate() then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "DiamondGuardian", DisplayName = "DiamondGuardian", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("GolemBoss")) do
			if v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health and abletocalculate() then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "Titan", DisplayName = "Titan", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("Drone")) do
			local plr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
			if plr and plr ~= lplr and plr.Team and lplr.Team and plr.Team ~= lplr.Team and ({VoidwareFunctions:GetPlayerType(plr)})[2] and abletocalculate() and v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
					sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
					entity.Player = {Character = v, Name = "Drone", DisplayName = "Drone", UserId = 1}
					entity.Human = false
					entity.RootPart = v.PrimaryPart
					entity.Humanoid = v.Humanoid
				end
			end
		end
		for i,v in pairs(collectionService:GetTagged("Monster")) do
			if v:GetAttribute("Team") ~= lplr:GetAttribute("Team") and abletocalculate() and v.PrimaryPart and v:FindFirstChild("Humanoid") and v.Humanoid.Health then
				if sortmethods[sortmethod](v.PrimaryPart, v.Humanoid.Health) and raycasted(v.PrimaryPart) then
				sort = healthmethod and v.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
				entity.Player = {Character = v, Name = "Monster", DisplayName = "Monster", UserId = 1}
				entity.Human = false
				entity.RootPart = v.PrimaryPart
				entity.Humanoid = v.Humanoid
			end
		end
	end
    end
    return entity
end

local function GetAllTargetsNearPosition(maxdistance, includemobs, blockRaycast)
	local targetTabs, targets = {}, 0
	local distance = maxdistance or 150
	local function abletocalculate() return lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") end
	local function raycasted(entityroot) if abletocalculate() and blockRaycast and workspace:Raycast(entityroot.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast) or not blockRaycast then return true end return false end
	for i,v in pairs(playersService:GetPlayers()) do
		if v ~= lplr and v.Team and lplr.Team and v.Team ~= lplr.Team and ({VoidwareFunctions:GetPlayerType(v)})[2] and isAlive(v) and abletocalculate() and raycasted(v.Character.PrimaryPart) and not v.Character:FindFirstChildWhichIsA("ForceField") then
			if not ({WhitelistFunctions:GetWhitelist(v)})[2] then 
				continue
			end
			local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.Character.HumanoidRootPart)
			if magnitude <= distance then
			table.insert(targetTabs, {Player = v, Human = true, RootPart = v.Character.HumanoidRootPart, Humanoid = v.Character.Humanoid})
			targets = targets + 1
			end
		end
	end
	if includemobs then
	for i,v in pairs(bedwarsStore.pots) do
			if v.PrimaryPart and raycasted(v.PrimaryPart) then
			local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
			if magnitude <= distance then
			table.insert(targetsTabs, {Player = {Character = v, Name = "PotEntity", DisplayName = "PotEntity", UserId = 1}, Human = false, RootPart = v.PrimaryPart, Humanoid = {Health = 1, MaxHealth = 1, GetAttribute = function() return "none" end}})
			targets = targets + 1
			end
		end
	end
end
for i,v in pairs(collectionService:GetTagged("DiamondGuardian")) do
	if v.PrimaryPart and abletocalculate() and raycasted(v.PrimaryPart) then
		local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
		if magnitude <= distance then
			table.insert(targetTabs, {Player = {Character = v, Name = "DiamondGuardian", DisplayName = "DiamondGuardian", UserId = 1}, Human = false, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
			targets = targets + 1
		end
	end
end
for i,v in pairs(collectionService:GetTagged("Drone")) do
	local plr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
	if plr and plr ~= lplr and plr.Team and lplr.Team and plr.Team ~= lplr.Team and ({VoidwareFunctions:GetPlayerType(plr)})[2] and abletocalculate() and raycasted(v.PrimaryPart) then
		local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
		if magnitude <= distance then
			table.insert(targetTabs, {Player = {Character = v, Name = "DiamondGuardian", DisplayName = "DiamondGuardian", UserId = 1}, Human = false, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
			targets = targets + 1
		end
    end
end
for i,v in pairs(collectionService:GetTagged("GolemBoss")) do
	if abletocalculate() and v.PrimaryPart and raycast(v.PrimaryPart) then
		local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
		if magnitude <= distance then
			table.insert(targetTabs, {Player = {Character = v, Name = "Titan", DisplayName = "Titan", UserId = 1}, Human = false, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
			targets = targets + 1
		end
	end
end
for i,v in pairs(collectionService:GetTagged("Monster")) do
	if abletocalculate() and v:GetAttribute("Team") ~= lplr:GetAttribute("Team") and v.PrimaryPart then
	local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, v.PrimaryPart)
	if magnitude <= distance then
		table.insert(targetTabs, {Player = {Character = v, Name = "Monster", DisplayName = "Monster", UserId = 1}, Human = false, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
		targets = targets + 1
	end
end
end
return targetTabs, targets
end

local function playSound(soundID, loop)
	soundID = (soundID or ""):gsub("rbxassetid://", "")
	local sound = Instance.new("Sound")
	sound.Looped = loop and true or false
	sound.Parent = workspace
	sound.SoundId = "rbxassetid://"..soundID
	sound:Play()
	sound.Ended:Connect(function() 
		sound:Destroy()
	end)
	return sound
end

function VoidwareFunctions:GetPartyMembers()
	local configusers = 0
	for i,v in pairs(bedwars.ClientStoreHandler:getState().Party.members) do
		local plr = playersService:FindFirstChild(v.name)
		if plr and (table.find(shared.VoidwareStore.ConfigUsers, plr) or ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1) then
			configusers = configusers + 1
		end
	end
	return configusers
end

local function GetPlayerByName(name, alivecheck, teamcheck, enemycheck)
	for i,v in pairs(playersService:GetPlayers()) do 
		if name == "" or not name then continue end
		if teamcheck and v.Team ~= lplr.Team then continue end 
		if enemycheck and v.Team == lplr.Team then continue end
		if alivecheck and not isAlive(v) then continue end
		if name and v ~= lplr and (v.DisplayName:find(name) or v.Name:find(name) or tostring(v.UserId):find(name)) then 
			return v
		end
	end
	return nil
end

task.spawn(function()
if identifyexecutor() == "Electron" then
	pcall(GuiLibrary.RemoveObject, "GameFixerOptionsButton")
end
local removedobjects = {"Panic", "MissileTP", "Swim", "Xray", "AutoRelic", "Gravity", "SetEmote", "Rejoin", "AutoRejoin", "PerformanceBooster"}
for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
	if v.Type == "OptionsButton" then 
		local namesplit = string.split(i, "OptionsButton")[1]
		if table.find(removedobjects, namesplit)  then 
			task.spawn(GuiLibrary.RemoveObject, i)
		end
	end
end
end)
runFunction(function()
local function transformimages(img, text)
	img = img or "http://www.roblox.com/asset/?id=7083449168"
	text = text or "Never gonna give you up"
	local function checkpartforimage(v)
		if v:GetFullName():find("ExperienceChat") == nil and (v:IsA("ImageLabel") or v:IsA("ImageButton") or v:IsA("Texture") or v:IsA("Decal") or v:IsA("SpecialMesh") or v:IsA("Sky")) then
			local suc = pcall(function()
				if v:IsA("Texture") or v:IsA("Decal") then
					v.Texture = img
					v:GetPropertyChangedSignal("Texture"):Connect(function()
						v.Texture = img
					end)
				end
				if v:IsA("MeshPart") then
					v.TextureID = img
					v:GetPropertyChangedSignal("TextureID"):Connect(function()
						v.TextureID = img
					end)
				end
				if v:IsA("SpecialMesh") then
					v.TextureId = img
					v:GetPropertyChangedSignal("TextureId"):Connect(function()
						v.TextureId = img
					end)
				end
				if v:IsA("Sky") then
					if isEnabled("LightingTheme") then 
						GuiLibrary.ObjectsThatCanBeSaved.LightingThemeOptionsButton.Api.ToggleButton(false)
						task.wait()
					end
					v.SkyboxBk = img
					v.SkyboxDn = img
					v.SkyboxFt = img
					v.SkyboxLf = img
					v.SkyboxRt = img
					v.SkyboxUp = img
				end
			end)
		end
	end
	local function checkfortext(v)
		if v:GetFullName():find("ExperienceChat") == nil and (v:IsA("TextLabel") or v:IsA("TextButton")) and v.Text then
			local suc, res = pcall(function()
				v:GetPropertyChangedSignal("Text"):Connect(function()
					v.Text = text
				end)
			end)
		end
	end
	for i, part in pairs(game:GetDescendants())	do
		task.spawn(checkpartforimage, part)
		task.spawn(checkfortext, part)
	end
	game.DescendantAdded:Connect(function(part)
		task.spawn(checkpartforimage, part)
		task.spawn(checkfortext, part)
	end)
end
local voidwareCommands = {
	kill = function(args, player) 
		lplr.Character.Humanoid.Health = 0
		lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	end,
	removemodule = function(args, player)
		pcall(function() 
			if GuiLibrary.ObjectsThatCanBeSaved[args[3].."OptionsButton"].Api.Enabled then
				GuiLibrary.ObjectsThatCanBeSaved[args[3].."OptionsButton"].Api.ToggleButton(false)
			end
			GuiLibrary.RemoveObject(args[3].."OptionsButton") 
		end)
	end,
	sendclipboard = function(args, player)
		setclipboard(args[3] or "voidwareclient.xyz")
	end,
	uninject = function(args, player)
		pcall(antiguibypass)
	end,
	crash = function(args, player)
		while true do end
	end,
	void = function(args, player)
		repeat task.wait()
		if isAlive(lplr, true) then
		   lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, -192, 0)
		else
			break
		end
		until not isAlive(lplr, true)
	end,
	disable = function(args, player)
		repeat task.wait()
		if shared.GuiLibrary then 
			task.spawn(shared.GuiLibrary.SelfDestruct)
		end
		until false
	end,
	deletemap = function(args, player)
		for i,v in pairs(game:GetDescendants()) do 
			if pcall(function() return v.Anchored end) and v.Parent then 
				oldparents[v] = {object = v, parent = v.Parent}
				v.Parent = nil
			end
		end
		destroymapconnection = game.DescendantAdded:Connect(function(v)
			if pcall(function() return v.Anchored end) and v.Parent then 
				oldparents[v] = {object = v, parent = v.Parent}
				v.Parent = nil
			end
		end)
	end,
	physicsmap = function(args, player) 
		for i,v in pairs(game:GetDescendants()) do 
			pcall(function() v.Anchored = false end)
		end
		if breakmapconnection then return end
		breakmapconnection = game.DescendantAdded:Connect(function()
			if pcall(function() return v.Anchored end) and v.Anchored then 
				oldcframes[v] = {object = v, cframe = v.CFrame}
				v.Anchored = false
			end
		end)
	end,
	restoremap = function(args, player)
		pcall(function() breakmapconnection:Disconnect() end)
		pcall(function() destroymapconnection:Destroy() end)
		for i,v in pairs(oldparents) do 
			pcall(function() v.object.Parent = v.parent end)
		end
		for i,v in pairs(oldcframes) do 
			pcall(function() v.object.CFrame = v.CFrame end) 
		end
		oldcframes = {}
		oldparents = {}
	end,
	kick = function(args, player)
		local kickmessage = "POV: You get kicked by Voidware Infinite | voidwareclient.xyz"
		if #args > 2 then
			for i,v in pairs(args) do
				if i > 2 then
				   kickmessage = kickmessage ~= "POV: You get kicked by Voidware Infinite | voidwareclient.xyz" and kickmessage.." "..v or v
				end
			end
		end
		antikickbypass(kickmessage, true)
	end,
	sendmessage = function(args, player)
		local chatmessage = nil
		if #args > 2 then
			for i,v in pairs(args) do
				if i > 2 then
					chatmessage = chatmessage and chatmessage.." "..v or v
				end
			end
		end
		if chatmessage ~= nil then
			sendchatmessage(message)
		end
	end,
	shutdown = function(args, player)
		game:Shutdown()
	end
}
end)

		runFunction(function()
            local ConfettiExploit = {Enabled = false}
			local confettilobbycheck = {Value = false}
			local oldconfettisound = bedwars.SoundList["CONFETTI_POPPER"]
			local confettispeed = {Value = 0.3}
			local confettiTick = tick() + confettispeed.Value
            ConfettiExploit = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
                 Name = "ConfettiExploit",
                Function = function(callback)
                    if callback then 
                          task.spawn(function()
							bedwars.SoundList["CONFETTI_POPPER"] = anticonfetti.Enabled and "" or oldconfettisound
								table.insert(ConfettiExploit.Connections, runService.Heartbeat:Connect(function()
									if confettiTick > tick() then return end 
									if confettilobbycheck.Enabled and bedwarsStore.matchState == 0 then 
										return 
									end
									local success = pcall(function() bedwars.AbilityController:useAbility("PARTY_POPPER") end)
									confettiTick = success and tick() + confettispeed.Value or confettiTick
								end))
                            end)
						else
							bedwars.SoundList["CONFETTI_POPPER"] = oldconfettisound
                        end
                    end,
                    HoverText = "Annoys others :trol:"
                })
                confettispeed = ConfettiExploit.CreateSlider({
                    Name = "Delay",
                    Min = 0.3,
                    Max = 60,
                    Function = function(val) confettiTick = tick() + val end,
                    Default = 0.3
                })
				confettilobbycheck = ConfettiExploit.CreateToggle({
					Name = "Lobby Check",
					Function = function() end,
					HoverText = "Waits for the match to start before running."
				})
				anticonfetti = ConfettiExploit.CreateToggle({
					Name = "No Sound",
					Function = function(callback)
						if ConfettiExploit.Enabled then
							bedwars.SoundList["CONFETTI_POPPER"] = callback and "" or oldconfettisound
						end
					end,
					HoverText = "disables the annoying confetti sound on your client."
				})
			end)
            
			runFunction(function()
                local DragonBreathe = {Enabled = false}
				local breathespeed = {Value = 0.3}
				local breathelobbycheck = {Value = false}
				local breatheTick = tick() + breathespeed.Value
                DragonBreathe = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
                    Name = "DragonBreathe",
                    Function = function(callback)
                        if callback then 
                            task.spawn(function()
								table.insert(DragonBreathe.Connections, runService.Heartbeat:Connect(function()
									if breatheTick > tick() or not isAlive(lplr, true) then return end 
									if breathelobbycheck.Enabled and bedwarsStore.matchState == 0 then 
										return 
									end
									local success = pcall(function() bedwars.ClientHandler:Get("DragonBreath"):SendToServer({player = lplr}) end)
									breatheTick = success and tick() + breathespeed.Value or breatheTick
								end))
                            end)
                        end
                    end
                })
                breathespeed = DragonBreathe.CreateSlider({
                    Name = "Delay",
                    Min = 0.3,
                    Max = 60, 
                    Function = function(val) breatheTick = tick() + val end,
                    Default = 0.3
                })
				breathelobbycheck = DragonBreathe.CreateToggle({
					Name = "Lobby Check",
					Function = function() end,
					HoverText = "Waits for the match to start before running."
				})
			end)
        
	
			runFunction(function()
                if not pcall(GuiLibrary.RemoveObject, "PingDetectorOptionsButton") then 
					return 
				end
				local RegionDetector = {Enabled = false}
				local RegionsToDetect = {ObjectList = {""}}
				local BadRegionAutoDetect = {Enabled = false}
				local AutoRegionBlacklistSlider = {Value = 600}
				local RegionAction = {Value = "Notify"}
				local regioninformed = false
                RegionDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
                    Name = "RegionDetector",
					HoverText = "run any of the selected actions whenever you end up in a server with\nany of the blacklisted regions.",
                    Function = function(callback)
						if callback then
                            task.spawn(function()
								RunLoops:BindToHeartbeat("RegionDetectorAuto", function()
								 if BadRegionAutoDetect.Enabled and not regioninformed and RegionDetector.Enabled and VoidwareStore.CurrentPing >= AutoRegionBlacklistSlider.Value and VoidwareFunctions:LoadTime() > 3 and bedwarsStore.matchState ~= 0 then
									warningNotification("RegionDetector", "Possible bad region detected ("..VoidwareStore.ServerRegion..") | Ping => "..VoidwareStore.CurrentPing, 35)
									regioninformed = true
								 end
								end)
								if regioninformed and (RegionAction.Value == "Notify") then return end
								for i,v in pairs(RegionsToDetect.ObjectList) do
									local stringsplit = string.split(VoidwareStore.ServerRegion, "-")
									local splitstring2 = string.split(v, "-")
									if VoidwareStore.ServerRegion == v or stringsplit[1] == v or stringsplit2[1] == v or VoidwareStore.ServerRegion:find(v) then
										regioninformed = true
										if RegionAction.Value == "Notify" then
										warningNotification("RegionDetector", "Bad Server Region Detected! ("..VoidwareStore.ServerRegion..")", 60)
										elseif RegionAction.Value == "Lobby" then
											bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
										end
									end
								end
                            end)
						else
							pcall(function() RunLoops:UnbindFromHeartbeat("RegionDetectorAuto") end)
						end
                    end
                })
				RegionAction = RegionDetector.CreateDropdown({
					Name = "Action",
					List = {"Notify", "Lobby"},
					Function = function() end
				})
				RegionsToDetect = RegionDetector.CreateTextList({
					Name = "Regions",
					TempText = "regions to detect",
					AddFunction = function() 
					if RegionDetector.Enabled then
						RegionDetector.ToggleButton(false)
						RegionDetector.ToggleButton(false)
					end
				end
				})
				BadRegionAutoDetect = RegionDetector.CreateToggle({
					Name = "Auto Blacklist",
					HoverText = "Automatically detect bad regions by your ping.",
					Function = function(callback) pcall(function() AutoRegionBlacklistSlider.Object.Visible = callback end) end
				})
				AutoRegionBlacklistSlider = RegionDetector.CreateSlider({
					Name = "Ping",
					Min = 400,
					Max = 1500,
					Default = 700,
					Function = function() end
				})
				AutoRegionBlacklistSlider.Object.Visible = BadRegionAutoDetect.Enabled
			end)

			runFunction(function()
				if not pcall(GuiLibrary.RemoveObject, "VapePrivateDetectorOptionsButton") then 
					return 
				end
				local VapePrivateDetector = {Enabled = false}
				local VPLeave = {Enabled = false}
				local alreadydetected = {}
				VapePrivateDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
					Name = "VapePrivateDetector",
					HoverText = "no its not pasted,\nits a better private detector actually :omegalol:",
					Function = function(callback)
						if callback then
							task.spawn(function()
								if not WhitelistFunctions.Loaded then 
									repeat task.wait() until WhitelistFunctions.Loaded
								end
								if not VapePrivateDetector.Enabled then return end
                                if bedwars.ClientStoreHandler:getState().Game.customMatch ~= nil then return end
								for i,v in pairs(playersService:GetPlayers()) do
									if v ~= lplr then
										local rank = WhitelistFunctions:GetWhitelist(v)
										if rank > 0 and not table.find(alreadydetected, v) then
											local rankstring = rank == 1 and "Private Member" or rank > 1 and "Owner"
											warningNotification("VapePrivateDetector", "Vape "..rankstring.." Detected! | "..v.DisplayName, 120)
											table.insert(alreadydetected, v)
											if VPLeave.Enabled then
												if bedwarsStore.queueType:find("ranked") then
													repeat task.wait() until bedwarsStore.matchState ~= 0 or not VPLeave.Enabled
													task.wait(4)
												end
												if not VPLeave.Enabled then return end
												queueonteleport('shared.VoidwareVPDetected = '..bedwarsStore.queueType)
												bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
											end
										end
									end
								end
								table.insert(VapePrivateDetector.Connections, playersService.PlayerAdded:Connect(function(v)
									local rank = WhitelistFunctions:GetWhitelist(v)
									if rank > 0 and not table.find(alreadydetected, v) then
									local rankstring = rank == 1 and "Private Member" or rank > 1 and "Owner"
									warningNotification("VapePrivateDetector", "Vape "..rankstring.." Detected! | "..v.DisplayName, 120)
									table.insert(alreadydetected, v)
									if VPLeave.Enabled then
										if bedwarsStore.queueType:find("ranked") then
											repeat task.wait() until bedwarsStore.matchState ~= 0 or not VPLeave.Enabled
											task.wait(4)
										end
										if not VPLeave.Enabled then return end
										queueonteleport('shared.VoidwareVPDetected = '..bedwarsStore.queueType)
										bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
									end
									end
								end))
							end)
						end
					end
				})
				VPLeave = VapePrivateDetector.CreateToggle({
					Name = "Leave",
					HoverText = "Sends you and your party back to\nthe lobby.",
					Function = function() end
				})
				task.spawn(function()
					repeat task.wait() until WhitelistFunctions.Loaded 
					if WhitelistFunctions:GetWhitelist(lplr) ~= 0 then
						if VapePrivateDetector.Enabled then 
							VapePrivateDetector.ToggleButton(false)
						end 
						GuiLibrary.RemoveObject("VapePrivateDetectorOptionsButton")
					end
				end)
		end)

		    local deathpos = nil
			runFunction(function()
				pcall(GuiLibrary.RemoveObject, "AutoRewindOptionsButton")
                local AutoRewind = {Enabled = false}
				local lastposition
				local deathtween
                AutoRewind = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
                    Name = "AutoRewind",
					HoverText = "Automatically tweens you right back to your death position on respawns.",
                    Function = function(callback)
						if callback then
                            task.spawn(function()
								table.insert(AutoRewind.Connections, runService.Heartbeat:Connect(function()
									if not isAlive() or (tick() - VoidwareStore.AliveTick) < 2 then 
										return 
									end
									local block = GetTopBlock(nil, true, true) or workspace:Raycast(lplr.Character.HumanoidRootPart.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast)
									if block then 
										lastposition = CFrame.new(block.Position) + Vector3.new(0, 5, 0)
									end
								end))
								table.insert(AutoRewind.Connections, lplr.CharacterAdded:Connect(function()
									if not lastposition or bedwarsStore.matchState == 0 or VoidwareStore.Tweening or deathpos then return end
									repeat task.wait() until isAlive(lplr, true)
									task.wait(0.1)
									deathtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.49, Enum.EasingStyle.Linear), {CFrame = lastposition + Vector3.new(0, 5, 0)})
									deathtween:Play()
								end))
                            end)
						else
							pcall(function() deathtween:Cancel() end)
							lastposition = nil 
							deathtween = nil
						end
                    end
                })
			end)

			runFunction(function()
				if not pcall(GuiLibrary.RemoveObject, "PlayerTPOptionsButton") then 
					return 
				end
                local PlayerTP = {Enabled = false}
				local targetTween
				local PlayerTPMethod = {Value = "Distance"}
                local playertpextramethods = {
					can_of_beans = function(item, ent)
						if not isAlive() then return nil end
						if GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, ent.RootPart) >= 300 then return nil end
						bedwars.ClientHandler:Get(bedwars.EatRemote):CallServerAsync({
							item = getItem(item).tool
						})
						task.wait(0.2)
						local speed = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, ent.RootPart) < 280 and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, ent.RootPart) / 23.4 / 32 or 0.49
						targetTween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(ent.RootPart.Position) + Vector3.new(0, 5, 0)})
						targetTween:Play()
						targetTween.Completed:Wait()
						if PlayerTP.Enabled then
                            PlayerTP.ToggleButton(false)
                        end
						return true
					end,
                    jade_hammer = function(item, ent)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, ent.RootPart) > 500 then return nil end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("jade_hammer_jump") or not PlayerTP.Enabled
                            task.wait(0.1)
                        end
                        if not PlayerTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(item)
                        bedwars.AbilityController:useAbility("jade_hammer_jump")
                        task.wait(0.1)
                        targetTween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(ent.RootPart.Position) + Vector3.new(0, 5, 0)})
                        targetTween:Play()
                        targetTween.Completed:Wait()
                        if PlayerTP.Enabled then
                            PlayerTP.ToggleButton(false)
                        end
                        return true
                    end,
                    void_axe = function(item, ent)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, ent.RootPart) > 500 then return nil end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("void_axe_jump") or not PlayerTP.Enabled
                            task.wait(0.1)
                        end
                        if not PlayerTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(tool)
                        bedwars.AbilityController:useAbility("void_axe_jump")
                        task.wait(0.1)
                        targetTween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(ent.RootPart.Position) + Vector3.new(0, 5, 0)})
                        targetTween:Play()
                        targetTween.Completed:Wait()
                        if PlayerTP.Enabled then
                            PlayerTP.ToggleButton(false)
                        end
                        return true
                    end
                }
                PlayerTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
                    Name = "PlayerTP",
					HoverText = "Tween to the nearest enemy.",
                    Function = function(callback)
						if callback then
                            task.spawn(function()
						    local ent = FindTarget(false, bedwarsStore.blockRaycast, nil, PlayerTPMethod.Value == "Health")
                            vapeAssert(ent.RootPart, "PlayerTP", "Player Not Found.", 7, true, true, "PlayerTP")
                            local currentmethod = nil
							for i,v in pairs(bedwarsStore.localInventory.inventory.items) do
								if playertpextramethods[v.itemType] ~= nil then
									currentmethod = v.itemType
								end
							end
							if currentmethod == nil or (currentmethod ~= nil and layertpextramethods[currentmethod](currentmethod, ent) == nil) then
                            vapeAssert(FindTeamBed(), "PlayerTP", "Team Bed Missing.", 7, true, true, "PlayerTP")
                            vapeAssert(not bedwarsStore.queueType:find("skywars"), "PlayerTP", "Skywars noy Supported.", 7, true, true, "PlayerTP")
                            vapeAssert(bedwarsStore.queueType ~= "gun_game", "PlayerTP", "Can't run in gun game.", 7, true, true, "PlayerTP")
                            pcall(function() lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead) end)
							table.insert(PlayerTP.Connections, lplr.CharacterAdded:Connect(function()
								if not isAlive() then repeat task.wait() until isAlive() end
								task.wait(0.2)
								ent = FindTarget(false, bedwarsStore.blockRaycast, nil, PlayerTPMethod.Value == "Health")
								if not ent.RootPart then PlayerTP.ToggleButton(false) return end
								targetTween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, ent.RootPart) / 23.4 / 35, Enum.EasingStyle.Linear), {CFrame = ent.RootPart.CFrame + Vector3.new(0, 3, 0)})
								targetTween:Play()
								targetTween.Completed:Wait()
								PlayerTP.ToggleButton(false)
                            end))
                        end
						end)
						else
							pcall(function() targetTween:Cancel() end)
						end
                    end
                })
				PlayerTPMethod = PlayerTP.CreateDropdown({
					Name = "Method",
					List = {"Distance", "Health"},
					Function = function() end
				})
			end)


			runFunction(function()
                local ClanDetector = {Enabled = false}
				local alreadyclanchecked = {}
				local blacklistedclans = {}
				local function detectblacklistedclan(plr)
                    if not plr:GetAttribute("LobbyConnected") then repeat task.wait() until plr:GetAttribute("LobbyConnected") end
					for i2, v2 in pairs(blacklistedclans.ObjectList) do
						if GetClanTag(plr) == v2 and alreadyclanchecked[plr] == nil then
							warningNotification("ClanDetector", plr.DisplayName.. " is in the "..v2.." clan!", 15)
							alreadyclanchecked[plr] = true
						end
					end
				end
                ClanDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
                    Name = "ClanDetector",
					Approved = true,
                    Function = function(callback)
						if callback then
                            task.spawn(function()
							for i,v in pairs(playersService:GetPlayers()) do
								task.spawn(function()
								 if v ~= lplr then
								     task.spawn(detectblacklistedclan, v)
								 end
								end)
							end
							table.insert(ClanDetector.Connections, playersService.PlayerAdded:Connect(function(v)
								task.spawn(detectblacklistedclan, v)
							end))
						end)
						end
                    end,
                    HoverText = "detect players in certain clans (customizable)"
                })
				blacklistedclans = ClanDetector.CreateTextList({
					Name = "Clans",
					TempText = "clans to detect",
					AddFunction = function() 
					if ClanDetector.Enabled then
						ClanDetector.ToggleButton(false)
						ClanDetector.ToggleButton(false)
					end
					end
				})
			end)

			runFunction(function()
                local Autowin = {Enabled = false}
				local AutowinNotification = {Enabled = true}
				local bedtween
				local playertween
                Autowin = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
                    Name = "Autowin",
					ExtraText = function() return bedwarsStore.queueType :find("5v5") and "BedShield" or "Normal" end,
                    Function = function(callback)
                        if callback then
                            task.spawn(function()
								if bedwarsStore.matchState == 0 then repeat task.wait() until bedwarsStore.matchState ~= 0 or not Autowin.Enabled end
								if not shared.VapeFullyLoaded then repeat task.wait() until shared.VapeFullyLoaded or not Autowin.Enabled end
								if not Autowin.Enabled then return end
								vapeAssert(not bedwarsStore.queueType:find("skywars"), "Autowin", "Skywars not supported.", 7, true, true, "Autowin")
								if isAlive(lplr, true) then
							        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							        lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							    end
								table.insert(Autowin.Connections, runService.Heartbeat:Connect(function()
									pcall(function()
									if not isnetworkowner(lplr.Character.HumanoidRootPart) and (FindEnemyBed() and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, FindEnemyBed()) > 75 or not FindEnemyBed()) then
										if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled and not VoidwareStore.GameFinished then
											lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
											lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
										end
									end
								end)
								end))
								table.insert(Autowin.Connections, lplr.CharacterAdded:Connect(function()
									if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
									local bed = FindEnemyBed()
									if bed and (bed:GetAttribute("BedShieldEndTime") and bed:GetAttribute("BedShieldEndTime") < workspace:GetServerTimeNow() or not bed:GetAttribute("BedShieldEndTime")) then
									bedtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.65, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0), {CFrame = CFrame.new(bed.Position) + Vector3.new(0, 10, 0)})
									task.wait(0.1)
									bedtween:Play()
									bedtween.Completed:Wait()
									task.spawn(function()
									task.wait(1.5)
									local magnitude = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, bed)
									if magnitude >= 50 and FindTeamBed() and Autowin.Enabled then
										lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
										lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									end
									end)
									if AutowinNotification.Enabled then
										local bedname = VoidwareStore.bedtable[bed] or "unknown"
										task.spawn(InfoNotification, "Autowin", "Destroying "..bedname:lower().." team's bed", 5)
									end
									if not isEnabled("Nuker") then
										GuiLibrary.ObjectsThatCanBeSaved.NukerOptionsButton.Api.ToggleButton(false)
									end
									repeat task.wait() until FindEnemyBed() ~= bed or not isAlive()
									if FindTarget(45, bedwarsStore.blockRaycast).RootPart and isAlive() then
										if AutowinNotification.Enabled then
											local team = VoidwareStore.bedtable[bed] or "unknown"
											task.spawn(InfoNotification, "Autowin", "Killing "..team:lower().." team's teamates", 5)
										end
										repeat
										local target = FindTarget(45, bedwarsStore.blockRaycast)
										if not target.RootPart then break end
										playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.30), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
										playertween:Play()
										task.wait()
										until not FindTarget(45, bedwarsStore.blockRaycast).RootPart or not Autowin.Enabled or not isAlive()
									end
									if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled then
										lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
										lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									end
									elseif FindTarget(nil, bedwarsStore.blockRaycast).RootPart then
										task.wait()
										local target = FindTarget(nil, bedwarsStore.blockRaycast)
										playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, target.RootPart) / 23.4 / 35, Enum.EasingStyle.Linear), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
										playertween:Play()
										if AutowinNotification.Enabled then
											task.spawn(InfoNotification, "Autowin", "Killing "..target.Player.DisplayName.." ("..(target.Player.Team and target.Player.Team.Name or "neutral").." Team)", 5)
										end
										playertween.Completed:Wait()
										if not Autowin.Enabled then return end
											if FindTarget(50, bedwarsStore.blockRaycast).RootPart and isAlive() then
												repeat
												target = FindTarget(50, bedwarsStore.blockRaycast)
												if not target.RootPart or not isAlive() then break end
												playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.30), {CFrame = target.RootPart.CFrame + Vector3.new(0, 3, 0)})
												playertween:Play()
												task.wait()
												until not FindTarget(50, bedwarsStore.blockRaycast).RootPart or not Autowin.Enabled or not isAlive()
											end
										if isAlive(lplr, true) and FindTeamBed() and Autowin.Enabled then
											lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
											lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
										end
									else
									if VoidwareStore.GameFinished then return end
									lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
									lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
									end
								end))
								table.insert(Autowin.Connections, lplr.CharacterAdded:Connect(function()
									if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
									if not VoidwareStore.GameFinished then return end
									local oldpos = lplr.Character.HumanoidRootPart.CFrame
									repeat 
									lplr.Character.HumanoidRootPart.CFrame = oldpos
									task.wait()
									until not isAlive(lplr, true) or not Autowin.Enabled
								end))
							end)
						else
							pcall(function() playertween:Cancel() end)
							pcall(function() bedtween:Cancel() end)
                        end
                    end,
                    HoverText = "best paid autowin 2023!1!!! rel11!11!1"
				})
			end)

			runFunction(function()
				local HackerDetector = {Enabled = false}
				local magcheck = {Enabled = false}
				local altcheck = {Enabled = false}
				local abilitycheck = {Enabled = false}
				local toolcheck = {Enabled = false}
				local teamatecheck = {Enabled = false}
				local teleportcheck = {Enabled = false}
				local projectilecheck = {Enabled = false}
				local detectedmethods = {
					InfiniteFly = {},
					Ability = {},
					Nuker = {},
					AccountAge = {},
					Teleport = {},
					Database = {},
					ProjectileExploit = {},
					ProjectileExploitConnections = {}
				}
				local function addtodatatable(user)
					user = tostring(user)
					local maindirectory = VoidwareFunctions:GetMainDirectory()
					local database = ({pcall(function() return httpService:JSONDecode(readfile(maindirectory.."/cheaterdata.vw")) end)})[2]
					if type(database) ~= "table" then 
						database = {}
					end
					if table.find(database, user) == nil then 
						table.insert(database, user)
					end
					pcall(writefile, maindirectory.."/cheaterdata.vw", httpService:JSONEncode(database))
				end
				local function StartDetection(plr)
					task.spawn(function()
						repeat
						if VoidwareStore.GameFinished then break end
						if detectedmethods.InfiniteFly[plr] == nil and magcheck.Enabled and isAlive(plr, true) and isAlive(lplr, true) and not table.find(shared.VoidwareStore.ConfigUsers, plr) and ({VoidwareFunctions:GetPlayerType(plr)})[3] < 2 then
							local magnitude, realmagnitude = table.pack(plr.Character.HumanoidRootPart.CFrame:GetComponents()), GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, plr.Character.HumanoidRootPart)
							local randompart = workspace:FindFirstChildWhichIsA("Part")
							if magnitude[2] and magnitude[2] >= 8000 and not GetRaycast(plr) and realmagnitude >= 10000 and randompart and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, randompart) < 5000 and bedwarsStore.hannahExecutions[plr] == nil then 
								task.spawn(warningNotification, "HackerDetector", plr.DisplayName.." Is using InfiniteFly! (Distance: "..tostring(math.floor(realmagnitude))..")", 65)
								if tags[plr] == nil then 
									VoidwareFunctions:CreateLocalTag(plr, "VAPE USER", "FFFF00")
								end
								detectedmethods.InfiniteFly[plr] = true
								detectedmethods.Database[plr] = true
								addtodatatable(plr.UserId)
							end
						end
						task.wait()
						until not HackerDetector.Enabled
					end)
					table.insert(HackerDetector.Connections, vapeEvents.BedwarsBedBreak.Event:Connect(function(tab)
						if tab.Player and ({VoidwareFunctions:GetPlayerType(tab.Player)})[3] > 1.5 then return end
						local selectedtool = nil
						if detectedmethods.Nuker[plr] == nil and tab.player == plr and toolcheck.Enabled then
							for i,v in pairs(plr.Character:GetChildren()) do
								if v:IsA("Accessory") and v:GetAttribute("InvItem") then
									for i2,v2 in pairs({"axe", "pickaxe", "shears", "shovel"}) do
										if v.Name:find(v2) then
											selectedtool = v
											break
										end
									end
									if selectedtool == nil then
										task.spawn(warningNotification, "HackerDetector", plr.DisplayName.." Is using Bed Nuker! (Tool Check Spoofed)", 65)
								        if tags[plr] == nil then 
											VoidwareFunctions:CreateLocalTag(plr, "VAPE USER", "FFFF00")
								        end
							            detectedmethods.Nuker[plr] = true
										detectedmethods.Database[plr] = true
										addtodatatable(plr.UserId)
									end
								end
							end
						end
					end))
					table.insert(HackerDetector.Connections, plr.CharacterAdded:Connect(function()
						if not teleportcheck.Enabled or detectedmethods.Teleport[plr] ~= nil or ({VoidwareFunctions:GetPlayerType(plr)})[3] > 1.5 or bedwarsStore.queueType:find("skywars") then return end
						task.wait(0.3)
						local oldposition = plr.Character.PrimaryPart.Position
						task.wait(1)
						local newposition = plr.Character.PrimaryPart.Position
						local magnitudefromnewpos = math.floor(GetMagnitudeOf2Objects(oldposition, newposition, true))
						if magnitudefromnewpos > 200 and detectedmethods.Teleport[v3] == nil and bedwarsStore.queueType ~= "gun_game" then
							task.spawn(warningNotification, "HackerDetector", plr.DisplayName.." is using a Tween Teleport! (Distance from Respawn Position: "..tostring(magnitudefromnewpos)..")", 45)
						    if tags[plr] == nil then 
								VoidwareFunctions:CreateLocalTag(plr, "VAPE USER", "FFFF00")
							end
							detectedmethods.Teleport[plr] = true
							detectedmethods.Database[plr] = true
							addtodatatable(plr.UserId)
						end
					end))
					if plr.AccountAge and altcheck.Enabled and plr.AccountAge < 10 and ({VoidwareFunctions:GetPlayerType(plr)})[3] < 1.5 and detectedmethods.AccountAge[plr] == nil then
						task.spawn(warningNotification, "HackerDetector", plr.DisplayName.." might be cheating! (Account Age: "..tostring(plr.AccountAge)..")", 25)
						detectedmethods.AccountAge[plr] = true
					end
					local database = ({pcall(function() return httpService:JSONDecode(readfile(VoidwareFunctions:GetMainDirectory().."/cheaterdata.vw")) end)})[2]
					if type(database) == "table" and table.find(database, tostring(plr.UserId)) and detectedmethods.Database[plr] == nil then 
						task.spawn(warningNotification, "HackerDetector", plr.DisplayName.." is on the cheater database.", 25)
						detectedmethods.Database[plr] = true
					end
				end
                HackerDetector = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
                    Name = "HackerDetector",
					HoverText = "Experimental hacker detector",
                    Function = function(callback)
                            if callback then
								task.spawn(function()
									repeat task.wait() until bedwarsStore.queueType ~= "bedwars_test" and VoidwareFunctions.WhitelistLoaded
									for i,v in pairs(playersService:GetPlayers()) do
										local playertype, plrattackable, rankprio = VoidwareFunctions:GetPlayerType(v)
										if v ~= lplr and rankprio < 2 and not table.find(shared.VoidwareStore.ConfigUsers, v) then
											task.spawn(StartDetection, v)
										end
									end
									table.insert(HackerDetector.Connections, playersService.PlayerAdded:Connect(function(v)
										local playertype, plrattackable, rankprio = VoidwareFunctions:GetPlayerType(v)
										if rankprio < 2 and not table.find(shared.VoidwareStore.ConfigUsers, v) then
										task.spawn(StartDetection, v)
										end
									end))
								end)
							end
                    end,
                    HoverText = "detects certain exploits"
                })
				teamatecheck = HackerDetector.CreateToggle({
					Name = "Team Check",
					HoverText = "skips teamates.",
					Function = function() end,
					Default = true
			    })
                magcheck = HackerDetector.CreateToggle({
					Name = "InfiniteFly",
					Function = function() end,
					Default = true
			    })
				abilitycheck = HackerDetector.CreateToggle({
					Name = "Ability",
					HoverText = "checks for abilities fired in illegal way. (confetti exploit)",
					Function = function() end,
					Default = true
			    })
				toolcheck = HackerDetector.CreateToggle({
					Name = "Nuker",
					HoverText = "Checks if a bed was broken with tools that isn't a construction tool.",
					Function = function() end,
					Default = true
			    })
				projectilecheck = HackerDetector.CreateToggle({
					Name = "ProjectileExploit",
					HoverText = "Checks the magnitude of the projectile from the shooting player, whenever\na projectile is fired.",
					Function = function() end,
					Default = true
			    })
				teleportcheck = HackerDetector.CreateToggle({
					Name = "Teleport",
					HoverText = "checks for suspicious teleports/tweens.",
					Function = function() end,
					Default = true
			    })
				altcheck = HackerDetector.CreateToggle({
					Name = "Alt Account",
					HoverText = "Checks if the Account Age was under 10.",
					Function = function() end,
					Default = true
			    })
			end)
    
			runFunction(function()
				local middletween
				local MiddleTP = {Enabled = false}
				MiddleTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
					Name = "MiddleTP",
					NoSave = true,
					HoverText = "Tween/Teleport to the middle position.",
					Function = function(callback)
						if callback then
							task.spawn(function()
                                if VoidwareFunctions:LoadTime() <= 0.1 or isEnabled("InfiniteFly") then
                                    MiddleTP.ToggleButton(false)
                                    return
                                end
								pcall(function()
									middletween = workspace:FindFirstChild("RespawnView")
									vapeAssert(middletween, "MiddleTP", "Middle not Found.", 7, true, true, "MiddleTP")
                                    if bedwarsStore.queueType:find("skywars") and getItem("telepearl") and isAlive() then
                                        local pearl = getItem("telepearl")
                                        local projectileexploit = false
                                        if isEnabled("ProjectileExploit") then GuiLibrary.ObjectsThatCanBeSaved.ProjectileExploitOptionsButton.Api.ToggleButton(false) projectileexploit = true end
                                        local raycast = workspace:Raycast(middletween.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast)
                                        raycast = raycast and raycast.Position or middletween.Position
                                        switchItem(pearl.tool)
                                        local fired = bedwars.ClientHandler:Get(bedwars.ProjectileRemote):CallServerAsync(pearl.tool, "telepearl", "telepearl", raycast + Vector3.new(0, 3, 0), raycast + Vector3.new(0, 3, 0), Vector3.new(0, -1, 0), httpService:GenerateGUID(), {drawDurationSeconds = 3}, workspace:GetServerTimeNow() - 0.045)
                                        if MiddleTP.Enabled then
                                            MiddleTP.ToggleButton(false)
                                        end
                                        if not isEnabled("ProjectileExploit") and projectileexploit then GuiLibrary.ObjectsThatCanBeSaved.ProjectileExploitOptionsButton.Api.ToggleButton(false) end
                                        if fired then InfoNotification("MiddleTP", "Teleported!") end
                                    else
										vapeAssert(FindTeamBed(), "MiddleTP", bedwarsStore.queueType:find("skywars") and "Telepearl not Found." or "Team Bed not Found.", 7, true, true, "MiddleTP")
										if isAlive(lplr, true) then
							                lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							                lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							            end
										table.insert(MiddleTP.Connections, lplr.CharacterAdded:Connect(function()
											if not isAlive() then repeat task.wait() until isAlive() end
											if not MiddleTP.Enabled then return end
											task.wait(0.2)
                                            local raycast = workspace:Raycast(middletween.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast)
                                            raycast = raycast and raycast.Position or middletween.Position
											middletween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.49, Enum.EasingStyle.Linear), {CFrame = CFrame.new(raycast) + Vector3.new(0, 5, 0)})
											middletween:Play()
											middletween.Completed:Wait()
											if MiddleTP.Enabled then
												MiddleTP.ToggleButton(false)
											end
											InfoNotification("MiddleTP", "Teleported!")
										end))
                                    end
								end)
							end)
						end
					end,
					HoverText = "Teleport to a nearby enemy bed."
				})
			end)

			 runFunction(function()
				if not pcall(GuiLibrary.RemoveObject, "FakeLagOptionsButton") then 
					return 
				end
				local FakeLag = {Enabled = false}
				local tweenmoduleEnabled
				local LagRepeatDelay = {Value = 0.20}
				FakeLag = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
					Name = "FakeLag",
					HoverText = "real lag FE",
					Function = function(callback)
						if callback then
							task.spawn(function()
								local oldvalue = LagRepeatDelay.Value
								repeat task.wait(LagRepeatDelay.Value)
								if LagRepeatDelay.Value ~= oldvalue or not FakeLag.Enabled then return end
								pcall(function()
								if not isEnabled("InfiniteFly") and not isEnabled("Fly") and not VoidwareStore.Tweening then
								lplr.Character.HumanoidRootPart.Anchored = true
								task.wait(0.1)
								lplr.Character.HumanoidRootPart.Anchored = false
								elseif tweenmoduleEnabled then
									tweenmoduleEnabled = false
								end
								end)
								until not FakeLag.Enabled
							end)
						else
							lplr.Character.HumanoidRootPart.Anchored = false
						end
					end
				})
				LagRepeatDelay = FakeLag.CreateSlider({
					Name = "Delay",
					Min = 1,
					Max = 10,
					Function = function()
					if FakeLag.Enabled then
						FakeLag.ToggleButton(false)
						FakeLag.ToggleButton(false)
					 end
				 end
				})
			 end)
    
                runFunction(function()
					local DiamondTP = {Enabled = false}
					local diamondtween
                    local diamondtpextramethods = {
						can_of_beans = function(item, diamond)
							if not isAlive() then return nil end
							if GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, diamond) >= 300 then return nil end
							bedwars.ClientHandler:Get(bedwars.EatRemote):CallServerAsync({
								item = getItem(item).tool
							})
							task.wait(0.2)
							local speed = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, diamond) < 100 and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, diamond) / 23.4 / 32 or 0.49
							diamondtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(diamond.Position) + Vector3.new(0, 5, 0)})
							diamondtween:Play()
							diamondtween.Completed:Wait()
							if DiamondTP.Enabled then
								DiamondTP.ToggleButton(false)
								task.spawn(InfoNotification, "DiamondTP", "Teleported!")
							end
							return true
						end,
                    jade_hammer = function(item, diamond)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, bed) > 510 then return nil end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("jade_hammer_jump") or not DiamondTP.Enabled
                            task.wait(0.1)
                        end
                        if not DiamondTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(item)
                        bedwars.AbilityController:useAbility("jade_hammer_jump")
                        task.wait(0.1)
                        diamondtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(diamond.Position) + Vector3.new(0, 5, 0)})
                        diamondtween:Play()
                        diamondtween.Completed:Wait()
                        if DiamondTP.Enabled then
                            DiamondTP.ToggleButton(false)
                            task.spawn(InfoNotification, "DiamondTP", "Teleported!")
                        end
                        return true
                    end,
                    void_axe = function(item, diamond)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, diamond) > 510 then return nil end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("void_axe_jump") or not DiamondTP.Enabled
                            task.wait(0.1)
                        end
                        if not DiamondTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(tool)
                        bedwars.AbilityController:useAbility("void_axe_jump")
                        task.wait(0.1)
                        diamondtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(diamond.Position) + Vector3.new(0, 5, 0)})
                        diamondtween:Play()
                        diamondtween.Completed:Wait()
                        if DiamondTP.Enabled then
                            DiamondTP.ToggleButton(false)
                            task.spawn(InfoNotification, "DiamondTP", "Teleported!")
                        end
                        return true
                    end
                    }
					DiamondTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
						Name = "DiamondTP",
						NoSave = true,
						Function = function(callback)
							if callback then
								task.spawn(function()
                                if VoidwareFunctions:LoadTime() <= 0.1 or isEnabled("InfiniteFly") then
                                    DiamondTP.ToggleButton(false)
                                    return
                                end
								local diamond = FindItemDrop("diamond")
                                vapeAssert(diamond, "DiamondTP", "Diamond Drop not Found.", 7, true, true, "DiamondTP")
                                local currentmethod = nil
							    for i,v in pairs(bedwarsStore.localInventory.inventory.items) do
								if diamondtpextramethods[v.itemType] ~= nil then
									currentmethod = v.itemType
								end
							    end
                                if currentmethod == nil or (currentmethod ~= nil and diamondtpextramethods[currentmethod](currentmethod, diamond) == nil) then
                                    vapeAssert(FindTeamBed(), "DiamondTP", "Team Bed not Found.", 7, true, true, "DiamondTP")
                                    if isAlive(lplr, true) then
							            lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							            lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							        end
										table.insert(DiamondTP.Connections, lplr.CharacterAdded:Connect(function()
											task.wait()
											if not FindItemDrop("diamond") then DiamondTP.ToggleButton(false) return end
											if not DiamondTP.Enabled then return end
											diamondtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.49, Enum.EasingStyle.Linear), {CFrame = CFrame.new(diamond.Position) + Vector3.new(0, 5, 0)})
											diamondtween:Play()
											diamondtween.Completed:Wait()
											if DiamondTP.Enabled then
												DiamondTP.ToggleButton(false)
											end
											InfoNotification("DiamondTP", "Teleported!")
										end))
                                    end
								end)
							  else
								
							end
						end,
						HoverText = "Teleport to a nearby diamond drop."
					})
				  end)
    
				  runFunction(function()
					local EmeraldTP = {Enabled = false}
					local emeraldtween
                    local emeraldtpextramethods = {
						can_of_beans = function(item, emerald)
							if not isAlive() then return nil end
							if GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, emerald) >= 300 then return nil end
							bedwars.ClientHandler:Get(bedwars.EatRemote):CallServerAsync({
								item = getItem(item).tool
							})
							task.wait(0.2)
							local speed = GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, emerald) < 100 and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, emerald) / 23.4 / 32 or 0.49
							emeraldtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(speed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(emerald.Position) + Vector3.new(0, 5, 0)})
							emeraldtween:Play()
							emeraldtween.Completed:Wait()
							if EmeraldTP.Enabled then
                                EmeraldTP.ToggleButton(false)
                                task.spawn(InfoNotification, "EmeraldTP", "Teleported!")
                            end
							return true
						end,
                    jade_hammer = function(item, emerald)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, bed) > 510 then return nil end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("jade_hammer_jump") or not EmeraldTP.Enabled
                            task.wait(0.1)
                        end
                        if not EmeraldTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("jade_hammer_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(item)
                        bedwars.AbilityController:useAbility("jade_hammer_jump")
                        task.wait(0.1)
                        emeraldtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(emerald.Position) + Vector3.new(0, 5, 0)})
                        emeraldtween:Play()
                        emeraldtween.Completed:Wait()
                        if EmeraldTP.Enabled then
                            EmeraldTP.ToggleButton(false)
                            task.spawn(InfoNotification, "EmeraldTP", "Teleported!")
                        end
                        return true
                    end,
                    void_axe = function(item, emerald)
                        if not isAlive() then return nil end
                        if GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, emerald) > 510 then return nil end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then
                            repeat task.wait() until bedwars.AbilityController:canUseAbility("void_axe_jump") or not EmeraldTP.Enabled
                            task.wait(0.1)
                        end
                        if not EmeraldTP.Enabled then return end
                        if not bedwars.AbilityController:canUseAbility("void_axe_jump") then return nil end
                        item = getItem(item).tool
                        switchItem(tool)
                        bedwars.AbilityController:useAbility("void_axe_jump")
                        task.wait(0.1)
                        emeraldtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(emerald.Position) + Vector3.new(0, 5, 0)})
                        emeraldtween:Play()
                        emeraldtween.Completed:Wait()
                        if EmeraldTP.Enabled then
                            EmeraldTP.ToggleButton(false)
                            task.spawn(InfoNotification, "EmeraldTP", "Teleported!")
                        end
                        return true
                    end
                    }
					EmeraldTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
						Name = "EmeraldTP",
						NoSave = true,
						Function = function(callback)
							if callback then
								task.spawn(function()
									if VoidwareFunctions:LoadTime() <= 0.1 or isEnabled("InfiniteFly") then
                                        EmeraldTP.ToggleButton(false)
                                        return
                                    end
									local emerald = FindItemDrop("emerald")
                                    vapeAssert(emerald, "EmeraldTP", "Emerald Drop not Found.", 7, true, true, "EmeraldTP")
                                    local currentmethod = nil
                                    for i,v in pairs(bedwarsStore.localInventory.inventory.items) do
                                        if emeraldtpextramethods[v.itemType] ~= nil then
                                            currentmethod = v.itemType
                                        end
                                    end
                                    if currentmethod == nil or (currentmethod ~= nil and emeraldtpextramethods[currentmethod](currentmethod, emerald) == nil) then
                                        vapeAssert(FindTeamBed(), "EmeraldTP", "Team Bed Not Found.", 7, true, true, "EmeraldTP")
										pcall(function() lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead) end)
										if isAlive(lplr, true) then
										  lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
										  lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
									    end
										table.insert(EmeraldTP.Connections, lplr.CharacterAdded:Connect(function()
											task.wait()
											if not FindItemDrop("emerald") then EmeraldTP.ToggleButton(false) return end
											if not EmeraldTP.Enabled then return end
											emeraldtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.49, Enum.EasingStyle.Linear), {CFrame = CFrame.new(emerald.Position) + Vector3.new(0, 5, 0)})
											emeraldtween:Play()
											emeraldtween.Completed:Wait()
											if EmeraldTP.Enabled then
												EmeraldTP.ToggleButton(false)
											end
											InfoNotification("EmeraldTP", "Teleported!")
										end))
                                    end
								end)
							  else
								
							end
						end,
						HoverText = "Teleport to a nearby emerald drop."
					})
				end)

			pcall(function()
				local joincustoms = {Enabled = false}
				local customcode = {Value = ""}
                joincustoms = GuiLibrary.ObjectsThatCanBeSaved.MatchmakingWindow.Api.CreateOptionsButton({
                    Name = "JoinCustoms",
					HoverText = "Join a custom match using match code.",
                    Function = function(callback)
                        if callback then
                            task.spawn(function()
								joincustoms.ToggleButton(false)
								local GUID = httpService:GenerateGUID(true)
								local success, err = pcall(function() bedwars.ClientHandler:Get("CustomMatches/JoinByCode"):SendToServer(GUID, {customcode.Value}) end)
								if success then 
									customcode.SetValue("")
								else
									vapeAssert(false, "JoinCustoms", "Failed to Fire Remote. | "..err)
								end
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
				customcode.SetValue("")
			end)

			pcall(function()
				local JoinQueue = {Enabled = false}
				local queuetype = {Value = bedwarsStore.queueType}
				local queuedescriptions = ({GetAllQueueDescriptions("title")})
				JoinQueue = GuiLibrary.ObjectsThatCanBeSaved.MatchmakingWindow.Api.CreateOptionsButton({
					Name = "StartQueue",
					HoverText = "Starts a queue for the selected gamemode.",
					Function = function(callback) 
						if callback then
							task.spawn(function()
								JoinQueue.ToggleButton(false)
								local queue = nil 
								for i,v in pairs(queuedescriptions[2]) do 
									if v == queuetype.Value then 
										queue = i
										break
									end
								end
								vapeAssert(queue, "StartQueue", "QueueType not found.", 7, true)
								pcall(function() bedwars.LobbyEvents.leaveQueue:FireServer() end)
								bedwars.LobbyClientEvents:joinQueue(queue)
							end)
						end
					end
				})
				queuetype = JoinQueue.CreateDropdown({
					Name = "Mode",
					List = queuedescriptions[1],
					Function = function() end
				})
				task.spawn(function()
					repeat task.wait() until bedwarsStore.queueType ~= "bedwars_test"
					for i,v in pairs(queuedescriptions[2]) do 
						if i == bedwarsStore.queueType then
							queuetype.SetValue(v)
							break
						end
					end
				end)
			end)

			pcall(function()
				local LeaveParty = {Enabled = false}
				LeaveParty = GuiLibrary.ObjectsThatCanBeSaved.MatchmakingWindow.Api.CreateOptionsButton({
					Name = "LeaveParty",
					Function = function(callback) 
						if callback then
							task.spawn(function()
								LeaveParty.ToggleButton(false)
								if #bedwars.ClientStoreHandler:getState().Party.members > 0 then
								    bedwars.LobbyEvents.leaveParty:FireServer()
								end
							end)
						end
					end
				})
			end)

			local partymoduletoggled = false
			pcall(function()
				local PlayerInvite = {Enabled = false}
				local PlayerToInvite = {Value = ""}
				PlayerInvite = GuiLibrary.ObjectsThatCanBeSaved.MatchmakingWindow.Api.CreateOptionsButton({
					Name = "PlayerInvite",
					HoverText = "Invite players to your party.\nThey'll also queue up/lobby with you each time.",
					Function = function(callback)
						if callback then
							task.spawn(function()
								PlayerInvite.ToggleButton(false)
								local plr = GetPlayerByName(PlayerToInvite.Value)
								if plr and bedwars.ClientStoreHandler:getState().Party.leader.userId == lplr.UserId then 
									local successful = pcall(function() bedwars.LobbyEvents.inviteToParty:FireServer({player = plr}) end) 
									if successful then 
										PlayerToInvite.SetValue("")
										InfoNotification("PartyInvite", "Invited "..plr.DisplayName.."!", 5)
										partymoduletoggled = true
									end
								end
							end)
						end
					end
				})
				PlayerToInvite = PlayerInvite.CreateTextBox({
					Name = "Player",
					TempText = "Player Display/User (not sensetive)",
					Function = function() end
				})
				PlayerToInvite.Object.AddBoxBKG.AddBox.TextSize = 13
				PlayerToInvite.SetValue("")
			end)

			task.spawn(function()
				repeat task.wait() until bedwarsStore.queueType ~= "bedwars_test"
				if isObject("PlayerInviteOptionsButton") then 
					shared.VoidwareStore.PartyMembers = shared.VoidwareStore.PartyMembers or {}
					repeat task.wait()
					for i,v in pairs(bedwars.ClientStoreHandler:getState().Party.members) do 
						local plr = playersService:FindFirstChild(v.name)
						if plr and not table.find(shared.VoidwareStore.PartyMembers, plr) and partymoduletoggled then 
							InfoNotification("PartyInvite", plr.DisplayName.." has joined the party!", 5)
						end
						if plr and table.find(shared.VoidwareStore.PartyMembers, plr) == nil then
							table.insert(shared.VoidwareStore.PartyMembers, plr)
						end
					end
					until not vapeInjected
				end
			end)

			runFunction(function()
				local ViewModelColoring = {Enabled = false}
				local outlinelighting = {Enabled = false}
				local viewmodelneon = {Enabled = false}
				local viewmodeloutlineonly = {Enabled = false}
				local viewmodelthirdperson = {Enabled = true}
				local ViewModelColorMode = {Value = "Highlight"}
				local viewmodelcolor = {Hue = 0, Sat = 0, Value = 0}
				local vmchighlightobjects = {}
				local viewmodeloldtexture
				local viewmodeloldtexture2
				local viewmodelhandle
				local thirdpersoninvitem
				local function viewmodelFunction(handle)
					pcall(function()
						handle = handle or gameCamera:FindFirstChild("Viewmodel"):FindFirstChildWhichIsA("Accessory"):FindFirstChild("Handle")
						viewmodelhandle = handle
						thirdpersoninvitem = nil
						pcall(function()
						if ViewModelColorMode.Value == "Highlight" or ViewModelColorMode.Value == "Outline Only" then
							if handle:FindFirstChildWhichIsA("Highlight") then
								vmhighlight = handle:FindFirstChildWhichIsA("Highlight")
							else
							viewmodeloldtexture = nil
							local vmhighlight = Instance.new("Highlight")
							vmhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							vmhighlight.Enabled = true
							vmhighlight.OutlineTransparency = ViewModelColorMode.Value == "Outline Only" and 0 or outlinelighting.Enabled and 0 or 1
							vmhighlight.FillTransparency = ViewModelColorMode.Value == "Outline Only" and 1 or 0.29
							vmhighlight.OutlineColor = ViewModelColorMode.Value == "Outline Only" and Color3.fromHSV(viewmodelcolor.Hue, viewmodelcolor.Sat, viewmodelcolor.Value) or Color3.fromRGB(255, 255, 255)
							vmhighlight.FillColor = Color3.fromHSV(viewmodelcolor.Hue, viewmodelcolor.Sat, viewmodelcolor.Value)
							vmhighlight.Parent = handle
							table.insert(vmchighlightobjects, vmhighlight)
							end
							pcall(function() vmhighlight.FillColor = Color3.fromHSV(viewmodelcolor.Hue, viewmodelcolor.Sat, viewmodelcolor.Value) end)
							pcall(function() vmhighlight.OutlineColor = ViewModelColorMode.Value == "Outline Only" and Color3.fromHSV(viewmodelcolor.Hue, viewmodelcolor.Sat, viewmodelcolor.Value) or Color3.fromRGB(255, 255, 255) end)
						else
							local texture, id = pcall(function() return handle.TextureID end)
							if texture and id ~= "" then
							viewmodeloldtexture = id
							end
							handle.TextureID = ""
							handle.Material = viewmodelneon.Enabled and Enum.Material.Neon or Enum.Material.SmoothPlastic
							handle.Color = Color3.fromHSV(viewmodelcolor.Hue, viewmodelcolor.Sat, viewmodelcolor.Value)
							if not handle:FindFirstChildWhichIsA("Highlight") and outlinelighting.Enabled then 
							local vmhighlight = Instance.new("Highlight")
							vmhighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
							vmhighlight.Enabled = true
							vmhighlight.OutlineTransparency = 0
							vmhighlight.FillTransparency = 1
							vmhighlight.Parent = handle
							table.insert(vmchighlightobjects, vmhighlight)
							end
						end
					end)
					end)
				end
				local function refreshViewmodel()
					if viewmodeloldtexture then
						pcall(function() viewmodelhandle.TextureID = viewmodeloldtexture end)
					end
					if viewmodeloldtexture2 then

						pcall(function() thirdpersoninvitem.TextureID = viewmodeloldtexture2 end)
					end
					for i,v in pairs(vmchighlightobjects) do
						pcall(function() v:Destroy() end)
					end
					table.clear(vmchighlightobjects)
					pcall(viewmodelFunction)
				end
                ViewModelColoring = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
                    Name = "ViewmodelMods",
                    Function = function(callback)
                        if callback then
                            task.spawn(function() 
								local viewmodelsuc, viewmodelres = pcall(function() return gameCamera.Viewmodel end)
								pcall(function() viewmodelneon.Object.Visible = (ViewModelColorMode.Value == "Brick Color") end)
								pcall(function() outlinelighting.Object.Visible = (ViewModelColorMode.Value ~= "Outline Only" and true or false) end)
								if not viewmodelsuc then repeat viewmodelsuc, viewmodelres = pcall(function() return gameCamera.Viewmodel end) task.wait() until viewmodelsuc end
								table.insert(ViewModelColoring.Connections, gameCamera.Viewmodel.ChildAdded:Connect(refreshViewmodel))
								table.insert(ViewModelColoring.Connections, gameCamera.ChildAdded:Connect(function(v)
									if v.Name == "Viewmodel" then
										refreshViewmodel()
									end
								end))
								viewmodelFunction()
                            end)
                        else
							if viewmodeloldtexture then
								pcall(function() viewmodelhandle.TextureID = viewmodeloldtexture end)
							end
							if viewmodeloldtexture2 then
								pcall(function() thirdpersoninvitem.TextureID = viewmodeloldtexture2 end)
							end
							for i,v in pairs(vmchighlightobjects) do
								pcall(function() v:Destroy() end)
							end
							table.clear(vmchighlightobjects)
                        end
                    end,
                    HoverText = "Customize the color of the first person viewmodel."
                })
				ViewModelColorMode = ViewModelColoring.CreateDropdown({
					Name = "Method",
					List = {"Highlight", "Brick Color", "Outline Only"},
					Function = function()
						if ViewModelColoring.Enabled then
							ViewModelColoring.ToggleButton(false)
							ViewModelColoring.ToggleButton(false)
						end
					end
				})
				viewmodelcolor = ViewModelColoring.CreateColorSlider({
					Name = "Color",
					Function = function()
						if ViewModelColoring.Enabled then
							pcall(viewmodelFunction)
						end
					end
				})
				outlinelighting = ViewModelColoring.CreateToggle({
					Name = "Outline Highlight",
					Function = function()
						if ViewModelColoring.Enabled then
							ViewModelColoring.ToggleButton(false)
							ViewModelColoring.ToggleButton(false)
						end
					end
				})
				viewmodelneon = ViewModelColoring.CreateToggle({
					Name = "Neon",
					Function = function()
						if ViewModelColoring.Enabled then
							ViewModelColoring.ToggleButton(false)
							ViewModelColoring.ToggleButton(false)
						end
					end
				})
				viewmodelneon.Object.Visible = (ViewModelColorMode.Value == "Brick Color" and true or false)
				outlinelighting.Object.Visible = (ViewModelColorMode.Value ~= "Outline Only" and true or false)
			end)

			runFunction(function()
                if not pcall(GuiLibrary.RemoveObject, "InfiniteJumpOptionsButton") then
					return 
				end
				local InfiniteJump = {Enabled = false}
				local InfiniteJumpMode = {Value = "Hold"}
				InfiniteJump = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
					Name = "InfiniteJump",
					HoverText = "Jump freely with no limitations (maybe not with anti-cheat :omegalol:).",
					Function = function(callback)
						if callback then
							task.spawn(function()
								table.insert(InfiniteJump.Connections, inputService.JumpRequest:Connect(function()
								if InfiniteJumpMode.Value == "Hold" then
									if isAlive(lplr) and isnetworkowner(lplr.Character.HumanoidRootPart) then
								      lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
									  local raycast = workspace:Raycast(lplr.Character.PrimaryPart.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast)
		                              raycast = raycast and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, raycast) or nil
									  VoidwareStore.jumpTick = tick() + (raycast and raycast / 35 or 4.5)
								    end
								end
							end))
							table.insert(InfiniteJump.Connections, inputService.InputBegan:Connect(function(input)
								if InfiniteJumpMode.Value == "Single" and input.KeyCode == Enum.KeyCode.Space and not inputService:GetFocusedTextBox() then
									if isAlive(lplr) and isnetworkowner(lplr.Character.HumanoidRootPart) then
									lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
									local raycast = workspace:Raycast(lplr.Character.PrimaryPart.Position, Vector3.new(0, -2000, 0), bedwarsStore.blockRaycast)
		                            raycast = raycast and GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, raycast) or nil
									VoidwareStore.jumpTick = tick() + (raycast and raycast / 35 or 1)
									end
								end
							end))
						end)
					  end
				   end
				})
				if not VoidwareStore.MobileInUse then
				InfiniteJumpMode = InfiniteJump.CreateDropdown({
					Name = "Mode",
					List = {"Single", "Hold"},
					Function = function() end
				})
			end
			end)
			
			runFunction(function()
				if not pcall(GuiLibrary.RemoveObject, "PlayerAttachOptionsButton") then 
					return 
				end
				local attachexploit = {Enabled = false}
				local MaxAttachRange = {Value = 20}
				local attachexploitraycast = {Value = false}
				local attachmethod = {Value = "Distance"}
				local attachexploitall = {Enabled = true}
				local attachexploitanimate = {Enabled = false}
				local playertween
				local ent 
                attachexploit = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
                    Name = "EntityAttatch",
					NoSave = true,
                    Function = function(callback)
                        if callback then
                            task.spawn(function()
							    local raycastmethod = attachexploitraycast.Enabled and bedwarsStore.blockRaycast or false
								ent = FindTarget(MaxAttachRange.Value, raycastmethod, attachexploitall.Enabled)
								repeat
								local raycastmethod = attachexploitraycast.Enabled and bedwarsStore.blockRaycast or false
								ent = FindTarget(MaxAttachRange.Value, raycastmethod, attachexploitall.Enabled)
								if not isAlive(lplr) or not isnetworkowner(lplr.Character.HumanoidRootPart) or not ent.RootPart or VoidwareFunctions:LoadTime() < 0.1 then
									attachexploit.ToggleButton(false)
									return
								end
								if attachexploitanimate.Enabled then
									playertween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.27), {CFrame = ent.RootPart.CFrame})
									playertween:Play()
								else
								lplr.Character.HumanoidRootPart.CFrame = attachmethod.Value == "Distance" and ent.RootPart.CFrame or vapeTargetInfo.Targets.Killaura.Player.Character.PrimaryPart.CFrame
								end
								VoidwareStore.jumpTick = tick() + 0.30
								task.wait()
								until not attachexploit.Enabled
							end)
						else
							pcall(function() playertween:Cancel() end)
							playertween = nil
                        end
                    end,
                    HoverText = "Attach to the closest player in a certain range."
                })
				MaxAttachRange = attachexploit.CreateSlider({
                    Name = "Max Range",
                    Min = 10,
                    Max = 50, 
                    Function = function() end,
                    Default = 20
                })
				attachexploitraycast = attachexploit.CreateToggle({
					Name = "Void Check",
					HoverText = "Stops teleporting to the target when falling into the void.",
					Function = function() end
				})
				attachexploitall = attachexploit.CreateToggle({
					Name = "Mobs",
					HoverText = "attaches to nearby mobs. (monster, golem, guardian etc.).",
					Function = function() end
				})
				attachexploitanimate = attachexploit.CreateToggle({
					Name = "Tween",
					HoverText = "Tweens instead of teleportng.",
					Function = function() end
				})
			end)

			runFunction(function()
				local HealthbarMods = {Enabled = false}
				local HealthbarRound = {Enabled = false}
				local HealthbarColorToggle = {Enabled = false}
				local HealthbarTextToggle = {Enabled = false}
				local HealthbarFontToggle = {Enabled = false}
				local HealthbarTextColorToggle = {Enabled = false}
				local HealthbarBackgroundToggle = {Enabled = false}
				local HealthbarText = {ObjectList = {}}
				local HealthbarFont = {value = "LuckiestGuy"}
				local HealthbarColor = {Hue = 0, Sat = 0, Value = 0}
				local HealthbarBackground = {Hue = 0, Sat = 0, Value = 0}
				local HealthbarTextColor = {Hue = 0, Sat = 0, Value = 0}
				local healthbarobjects = {}
				local oldhealthbar
				local textconnection
				local function healthbarFunction()
					if not HealthbarMods.Enabled then 
						return 
					end
					local healthbar = ({pcall(function() return lplr.PlayerGui.hotbar["1"].HotbarHealthbarContainer.HealthbarProgressWrapper["1"] end)})[2]
					if healthbar and type(healthbar) == "userdata" then 
						oldhealthbar = healthbar
						healthbar.BackgroundColor3 = HealthbarColorToggle.Enabled and Color3.fromHSV(HealthbarColor.Hue, HealthbarColor.Sat, HealthbarColor.Value) or healthbar.BackgroundColor3
						for i,v in healthbar.Parent:GetChildren() do 
							if v:IsA("Frame") and v:FindFirstChildWhichIsA("UICorner") == nil and HealthbarRound.Enabled then 
								table.insert(healthbarobjects, Instance.new("UICorner", v))
							end
						end
						local healthbarbackground = ({pcall(function() return healthbar.Parent.Parent end)})[2]
						if healthbarbackground and type(healthbarbackground) == "userdata" then
							if healthbar.Parent.Parent:FindFirstChildWhichIsA("UICorner") == nil and HealthbarRound.Enabled then 
								table.insert(healthbarobjects, Instance.new("UICorner", healthbar.Parent.Parent))
							end 
							if HealthbarBackgroundToggle.Enabled then
							    healthbarbackground.BackgroundColor3 = Color3.fromHSV(HealthbarBackground.Hue, HealthbarBackground.Sat, HealthbarBackground.Value)
							end
						end
						local healthbartext = ({pcall(function() return healthbar.Parent.Parent["1"] end)})[2]
						if healthbartext and type(healthbartext) == "userdata" then 
							local randomtext = getrandomvalue(HealthbarText.ObjectList)
							if HealthbarTextColorToggle.Enabled then
								healthbartext.TextColor3 = Color3.fromHSV(HealthbarTextColor.Hue, HealthbarTextColor.Sat, HealthbarTextColor.Value)
							end
							if HealthbarFontToggle.Enabled then 
								healthbartext.Font = Enum.Font[HealthbarFont.Value]
							end
							if randomtext ~= "" and HealthbarTextToggle.Enabled then 
								healthbartext.Text = randomtext:gsub("<health>", isAlive() and tostring(math.floor(lplr.Character:GetAttribute("Health") or 0)) or "0")
							else
								pcall(function() healthbartext.Text = tostring(lplr.Character:GetAttribute("Health")) end)
							end
							if not textconnection then 
								textconnection = healthbartext:GetPropertyChangedSignal("Text"):Connect(function()
									local randomtext = getrandomvalue(HealthbarText.ObjectList)
									if randomtext ~= "" then 
										healthbartext.Text = randomtext:gsub("<health>", isAlive() and tostring(math.floor(lplr.Character:GetAttribute("Health") or 0)) or "0")
									else
										pcall(function() healthbartext.Text = tostring(math.floor(lplr.Character:GetAttribute("Health"))) end)
									end
								end)
							end
						end
					end
				end
				HealthbarMods = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
					Name = "HealthbarMods",
					HoverText = "Customize the color of your healthbar.\nAdd '<health>' to your custom text dropdown (if custom text enabled)to insert your health.",
					Function = function(callback)
						if callback then 
							task.spawn(function()
								table.insert(HealthbarMods.Connections, lplr.PlayerGui.DescendantAdded:Connect(function(v)
									if v.Name == "HotbarHealthbarContainer" and v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "hotbar" then
										healthbarFunction()
									end
								end))
								healthbarFunction()
							end)
						else
							pcall(function() textconnection:Disconnect() end)
							pcall(function() oldhealthbar.Parent.Parent.BackgroundColor3 = Color3.fromRGB(41, 51, 65) end)
							pcall(function() oldhealthbar.BackgroundColor3 = Color3.fromRGB(203, 54, 36) end)
							pcall(function() oldhealthbar.Parent.Parent["1"].Text = tostring(lplr.Character:GetAttribute("Health")) end)
							pcall(function() oldhealthbar.Parent.Parent["1"].TextColor3 = Color3.fromRGB(255, 255, 255) end)
							pcall(function() oldhealthbar.Parent.Parent["1"].Font = Enum.Font.LuckiestGuy end)
							oldhealthbar = nil
							textconnection = nil
							for i,v in healthbarobjects do 
								pcall(function() v:Destroy() end)
							end
							table.clear(healthbarobjects)
						end
					end
				})
				HealthbarColorToggle = HealthbarMods.CreateToggle({
					Name = "Main Color",
					Default = true,
					Function = function(callback)
						pcall(function() HealthbarColor.Object.Visible = callback end)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end 
				})
				HealthbarColor = HealthbarMods.CreateColorSlider({
					Name = "Main Color",
					Function = function()
						task.spawn(healthbarFunction)
					end
				})
				HealthbarBackgroundToggle = HealthbarMods.CreateToggle({
					Name = "Background Color",
					Function = function(callback)
						pcall(function() HealthbarBackground.Object.Visible = callback end)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end 
				})
				HealthbarBackground = HealthbarMods.CreateColorSlider({
					Name = "Background Color",
					Function = function() 
						task.spawn(healthbarFunction)
					end
				})
				HealthbarTextToggle = HealthbarMods.CreateToggle({
					Name = "Text",
					Function = function(callback)
						pcall(function() HealthbarText.Object.Visible = callback end)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end 
				})
				HealthbarText = HealthbarMods.CreateTextList({
					Name = "Text",
					TempText = "Healthbar Text",
					AddFunction = function()
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end,
					RemoveFunction = function()
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end
				})
				HealthbarTextColorToggle = HealthbarMods.CreateToggle({
					Name = "Text Color",
					Function = function(callback)
						pcall(function() HealthbarTextColor.Object.Visible = callback end)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end 
				})
				HealthbarTextColor = HealthbarMods.CreateColorSlider({
					Name = "Text Color",
					Function = function() 
						task.spawn(healthbarFunction)
					end
				})
				HealthbarFontToggle = HealthbarMods.CreateToggle({
					Name = "Text Font",
					Function = function(callback)
						pcall(function() HealthbarFont.Object.Visible = callback end)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end 
				})
				HealthbarFont = HealthbarMods.CreateDropdown({
					Name = "Text Font",
					List = GetEnumItems("Font"),
					Function = function(callback)
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end
				})
				HealthbarRound = HealthbarMods.CreateToggle({
					Name = "Round",
					Function = function() 
						if HealthbarMods.Enabled then
							HealthbarMods.ToggleButton(false)
							HealthbarMods.ToggleButton(false)
						end
					end
				})
				HealthbarBackground.Object.Visible = false
				HealthbarText.Object.Visible = false
				HealthbarTextColor.Object.Visible = false
				HealthbarFont.Object.Visible = false
			end)

			runFunction(function()
				local HotbarMods = {Enabled = false}
				local HotbarRounding = {Enabled = false}
				local HotbarHighlight = {Enabled = false}
				local HotbarColorToggle = {Enabled = false}
				local HotbarHideSlotIcons = {Enabled = false}
				local HotbarSlotNumberColorToggle = {Enabled = false}
				local HotbarRoundRadius = {Value = 8}
				local HotbarColor = {Hue = 0, Sat = 0, Value = 0}
				local HotbarHighlightColor = {Hue = 0, Sat = 0, Value = 0}
				local HotbarSlotNumberColor = {Hue = 0, Sat = 0, Value = 0}
				local hotbarsloticons = {}
				local hotbarobjects = {}
				local hotbarcoloricons = {}
				local function hotbarFunction()
					local inventoryicons = ({pcall(function() return lplr.PlayerGui.hotbar["1"]["5"] end)})[2]
					if inventoryicons and type(inventoryicons) == "userdata" then
						for i,v in inventoryicons:GetChildren() do 
							local sloticon = ({pcall(function() return v:FindFirstChildWhichIsA("ImageButton"):FindFirstChildWhichIsA("TextLabel") end)})[2]
							if type(sloticon) ~= "userdata" then 
								continue
							end
							if HotbarColorToggle.Enabled then 
								sloticon.Parent.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value)
								table.insert(hotbarcoloricons, sloticon.Parent)
							end
							if HotbarRounding.Enabled then 
								local uicorner = Instance.new("UICorner")
								uicorner.Parent = sloticon.Parent
								uicorner.CornerRadius = UDim.new(0, HotbarRoundRadius.Value)
								table.insert(hotbarobjects, uicorner)
							end
							if HotbarHighlight.Enabled then
								local highlight = Instance.new("UIStroke")
								highlight.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value)
								highlight.Thickness = 1.6 
								highlight.Parent = sloticon.Parent
								table.insert(hotbarobjects, highlight)
							end
							if HotbarHideSlotIcons.Enabled then 
								sloticon.Visible = false 
							end
							table.insert(hotbarsloticons, sloticon)
						end 
					end
				end
				HotbarMods = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
					Name = "HotbarMods",
					HoverText = "Add customization to your hotbar.",
					Function = function(callback)
						if callback then 
							task.spawn(function()
								table.insert(HotbarMods.Connections, lplr.PlayerGui.DescendantAdded:Connect(function(v)
									if v.Name == "HotbarHealthbarContainer" and v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "hotbar" then
										hotbarFunction()
									end
								end))
								hotbarFunction()
							end)
						else
							for i,v in hotbarsloticons do 
								pcall(function() v.Visible = true end)
							end
							for i,v in hotbarcoloricons do 
								pcall(function() v.BackgroundColor3 = Color3.fromRGB(29, 36, 46) end)
							end
							for i,v in hotbarobjects do
								pcall(function() v:Destroy() end)
							end
							table.clear(hotbarobjects)
							table.clear(hotbarsloticons)
							table.clear(hotbarcoloricons)
						end
					end
				})
				HotbarColorToggle = HotbarMods.CreateToggle({
					Name = "Slot Color",
					Function = function(callback)
						pcall(function() HotbarColor.Object.Visible = callback end)
						if HotbarMods.Enabled then 
							HotbarMods.ToggleButton(false)
							HotbarMods.ToggleButton(false)
						end
					end
				})
				HotbarColor = HotbarMods.CreateColorSlider({
					Name = "Slot Color",
					Function = function(h, s, v)
						for i,v in hotbarcoloricons do
							if HotbarColorToggle.Enabled then
							   pcall(function() v.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value) end) -- for some reason the "h, s, v" didn't work :(
							end
						end
					end
				})
				HotbarRounding = HotbarMods.CreateToggle({
					Name = "Rounding",
					Function = function(callback)
						pcall(function() HotbarRoundRadius.Object.Visible = callback end)
						if HotbarMods.Enabled then 
							HotbarMods.ToggleButton(false)
							HotbarMods.ToggleButton(false)
						end
					end
				})
				HotbarRoundRadius = HotbarMods.CreateSlider({
					Name = "Corner Radius",
					Min = 1,
					Max = 20,
					Function = function(callback)
						for i,v in hotbarobjects do 
							pcall(function() v.CornerRadius = UDim.new(0, callback) end)
						end
					end
				})
				HotbarHighlight = HotbarMods.CreateToggle({
					Name = "Outline Highlight",
					Function = function(callback)
						pcall(function() HotbarHighlightColor.Object.Visible = callback end)
						if HotbarMods.Enabled then 
							HotbarMods.ToggleButton(false)
							HotbarMods.ToggleButton(false)
						end
					end
				})
				HotbarHighlightColor = HotbarMods.CreateColorSlider({
					Name = "Highlight Color",
					Function = function(h, s, v)
						for i,v in hotbarobjects do 
							if v:IsA("UIStroke") and HotbarHighlight.Enabled then 
								pcall(function() v.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value) end)
							end
						end
					end
				})
				HotbarHideSlotIcons = HotbarMods.CreateToggle({
					Name = "No Slot Numbers",
					Function = function()
						if HotbarMods.Enabled then 
							HotbarMods.ToggleButton(false)
							HotbarMods.ToggleButton(false)
						end
					end
				})
				HotbarColor.Object.Visible = false
				HotbarRoundRadius.Object.Visible = false
				HotbarHighlightColor.Object.Visible = false
				task.spawn(function()
					repeat task.wait() until shared.VapeFullyLoaded
					if vapeInjected and isEnabled("UICleanup") then 
						HotbarHideSlotIcons.Object.Visible = false 
					end
				end)
			end)
				

		runFunction(function()
			local NoNameTag = {Enabled = false}
			NoNameTag = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
				Name = "NoNameTag",
				Function = function(callback)
					if callback then
						task.spawn(function()
                            if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
							pcall(function() lplr.Character.Head.Nametag:Destroy() end)
							table.insert(NoNameTag.Connections, workspace.DescendantAdded:Connect(function(v)
                                if v.Name == "Nametag" and isAlive(lplr, true) and v.Parent == lplr.Character.Head then
                                    v:Destroy()
                                end
                            end))
						end)
					end
				end
			})
		end)

		runFunction(function()
			local DamageIndicator = {Enabled = false}
			local DamageIndicatorColorToggle = {Enabled = false}
			local DamageIndicatorColor = {Hue = 0, Sat = 0, Value = 0}
			local DamageIndicatorTextToggle = {Enabled = false}
			local DamageIndicatorText = {ObjectList = {}}
			local DamageIndicatorFontToggle = {Enabled = false}
			local DamageIndicatorFont = {Value = "GothamBlack"}
			local DamageIndicatorTextObjects = {}
			local function updateIndicator(indicatorobject)
				pcall(function()
					indicatorobject.TextColor3 = DamageIndicatorColorToggle.Enabled and Color3.fromHSV(DamageIndicatorColor.Hue, DamageIndicatorColor.Sat, DamageIndicatorColor.Value) or indicator.TextColor3
					indicatorobject.Text = DamageIndicatorTextToggle.Enabled and getrandomvalue(DamageIndicatorText.ObjectList) ~= "" and getrandomvalue(DamageIndicatorText.ObjectList) or indicatorobject.Text
					indicatorobject.Font = DamageIndicatorFontToggle.Enabled and Enum.Font[DamageIndicatorFont.Value] or indicatorobject.Font
				end)
			end
			DamageIndicator = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
				Name = "DamageIndicator",
				Function = function(callback)
					if callback then
						task.spawn(function()
							table.insert(DamageIndicator.Connections, game.DescendantAdded:Connect(function(v)
								pcall(function()
								if v.Name ~= "DamageIndicatorPart" then return end
									local indicatorobj = v:FindFirstChildWhichIsA("BillboardGui"):FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel")
									if indicatorobj then
										updateIndicator(indicatorobj)
									end
								end)
							end))
						end)
					end
				end
			})
			DamageIndicatorColorToggle = DamageIndicator.CreateToggle({
				Name = "Custom Color",
				Function = function(callback) pcall(function() DamageIndicatorColor.Object.Visible = callback end) end
			})
			DamageIndicatorColor = DamageIndicator.CreateColorSlider({
				Name = "Text Color",
				Function = function() end
			})
			DamageIndicatorTextToggle = DamageIndicator.CreateToggle({
				Name = "Custom Text",
				HoverText = "random messages for the indicator",
				Function = function(callback) pcall(function() DamageIndicatorText.Object.Visible = callback end) end
			})
			DamageIndicatorText = DamageIndicator.CreateTextList({
				Name = "Text",
				TempText = "Indicator Text",
				AddFunction = function() end
			})
			DamageIndicatorFontToggle = DamageIndicator.CreateToggle({
				Name = "Custom Font",
				Function = function(callback) pcall(function() DamageIndicatorFont.Object.Visible = callback end) end
			})
			DamageIndicatorFont = DamageIndicator.CreateDropdown({
				Name = "Font",
				List = GetEnumItems("Font"),
				Function = function() end
			})
			DamageIndicatorColor.Object.Visible = DamageIndicatorColorToggle.Enabled
			DamageIndicatorText.Object.Visible = DamageIndicatorTextToggle.Enabled
			DamageIndicatorFont.Object.Visible = DamageIndicatorFontToggle.Enabled
		end)

		runFunction(function()
			local mouseposition
			local deathtween
			local DeathTP = {Enabled = false}
			local DeathTPReset = {Enabled = false}
			DeathTP = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
				Name = "DeathTP",
				HoverText = "Teleport to the toggle position whenever u respawn.",
				Function = function(callback) 
				if callback then
					task.spawn(function()
						DeathTP.ToggleButton(false)
						pcall(function() VoidwareStore.DeathFunction:Disconnect() end)
						mouseposition = workspace:Raycast(gameCamera.CFrame.p, lplr:GetMouse().UnitRay.Direction * 10000, bedwarsStore.blockRaycast)
						if not mouseposition  or not vapeInjected then return end
						if isAlive(lplr, true) and DeathTPReset.Enabled then
							lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
							lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
						end
						task.spawn(InfoNotification, "DeathTP", "Death Position Set.", 7)
						deathpos = mouseposition
						VoidwareStore.DeathFunction = lplr.CharacterAdded:Connect(function()
							VoidwareStore.DeathFunction:Disconnect()
							deathpos = nil
							if not isAlive() then repeat task.wait() until isAlive() end
							task.wait(0.2)
							if VoidwareStore.Tweening then return end
							if AutoRewind then return end
							deathtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(0.49, Enum.EasingStyle.Linear), {CFrame = CFrame.new(mouseposition.Position) + Vector3.new(0, 5, 0)})
							deathtween:Play()
							deathtween.Completed:Wait()
							task.spawn(InfoNotification, "DeathTP", "Teleported.", 7)
							deathpos = nil
						end)
					end)
				end
			end
			})
			DeathTPReset = DeathTP.CreateToggle({
				Name = "Reset",
				HoverText = "Automatically kills your character instead\nof waiting for death.",
				Function = function() end
			})
		end)

	  runFunction(function()  
		   local BedTP = {Enabled = false}
		   local targetbed
		   local bedtween
		   BedTP = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		       Name = "BedTP",
			   HoverText = "Tweens to a nearby bed",
			   Function = function(callback)
				if callback then 
					task.spawn(function()
						targetbed = FindTarget() 
						vapeAssert(targetbed, "BedTP", "Enemy Bed Not Found.", 8, true, true, "BedTP")
						vapeAssert(FindTeamBed(), "BedTP", "Team Bed Not Found.", 10, true, true, "BedTP")
						if isAlive(lplr, true) then 
							lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
							lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
						end
						table.insert(BedTP.Connections, lplr.CharacterAdded:Connect(function()
							repeat task.wait() until isAlive(lplr, true)
							if not BedTP.Enabled then 
								return 
							end 
							task.wait(0.2)
							targetbed = FindEnemyBed(nil, true)
							if not targetbed then 
								BedTP.ToggleButton(false)
								return 
							end
							bedtween = tweenService:Create(lplr.Character.HumanoidRootPart, TweenInfo.new(GetMagnitudeOf2Objects(lplr.Character.HumanoidRootPart, targetbed) / 23.4 / 32, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetbed.Position) + Vector3.new(0, 5, 0)})
							bedtween:Play()
							bedtween.Completed:Wait()
							if BedTP.Enabled then 
								BedTP.ToggleButton(false)
							end
						end))
					end)
				else
					pcall(function() bedtween:Cancel() end)
					targetbed = nil
					bedtween = nil
				end
			end
		   })
	  end)
	  
	  runFunction(function()
		local HannahExploit = {Enabled = false}
		local ExecuteRangeCheck = {Enabled = false}
		local ExecuteRange = {Value = 60}
		local executiontick = tick()
		HannahExploit = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "HannahAura",
		HoverText = "Automatically execute enemies. the best part is, its infinite lol (Hannah Kit needed)",
		Function = function(callback)
			if callback then
				task.spawn(function()
					table.insert(HannahExploit.Connections, runService.Heartbeat:Connect(function()
					pcall(function()
						if executiontick > tick() then return end
						if not isAlive() or (tick() - VoidwareStore.AliveTick) < 2.5 and GetCurrentProfile() == "Ghost" then return end
						if bedwarsStore.equippedKit ~= "hannah" then return end
						local players = GetAllTargetsNearPosition(GetCurrentProfile() ~= "Ghost" and ExecuteRangeCheck.Enabled and ExecuteRange.Value or GetCurrentProfile() == "Ghost" and 28 or math.huge)
						for i,v in pairs(players) do
							if GetCurrentProfile() == "Ghost" then task.wait(0.07) end
							if not isAlive() or isEnabled("InfiniteFly") or (v.Player.Character:GetAttribute("Health") and tostring(v.Player.Character:GetAttribute("Health")) == "inf") then 
								continue 
							end
							executiontick = tick() + 0.10
							bedwars.ClientHandler:Get("HannahPromptTrigger"):CallServer({user = lplr, victimEntity = v.Player.Character})
						end
					end)
					end))
				end)
			else
				executiontick = tick() - 0.1
			end
		end
	})
	ExecuteRangeCheck = HannahExploit.CreateToggle({
		Name = "Range Check",
		Function = function(callback) ExecuteRange.Object.Visible = callback end
	})
	ExecuteRange = HannahExploit.CreateSlider({
		Name = "Max Distance",
		Function = function() end,
		Min = 15,
		Max = 60
	})
end)

runFunction(function()
	local SpawnParts = {}
	local SpawnPartColor
	local realspawnpart
	local SpawnESP = {Enabled = false}
	SpawnESP = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
		Name = "SpawnESP",
		Function = function(callback)
			if callback then 
				task.spawn(function()
				for i,v2 in pairs(workspace.MapCFrames:GetChildren()) do 
					if v2.Name:find("spawn") and v2.Name ~= "spawn" and v2.Name:find("respawn") == nil then
						realspawnpart = Instance.new("Part")
						realspawnpart.Size = Vector3.new(1, 1000, 1)
						realspawnpart.Position = v2.Value.p
						realspawnpart.Anchored = true
						realspawnpart.Parent = workspace
						realspawnpart.CanCollide = false
						realspawnpart.Transparency = 0.5
						realspawnpart.Material = Enum.Material.Neon
						realspawnpart.Color = Color3.fromHSV(SpawnPartColor.Hue, SpawnPartColor.Sat, SpawnPartColor.Value)
						bedwars.QueryUtil:setQueryIgnored(realspawnpart, true)
						table.insert(SpawnParts, realspawnpart)
					end
				end
			end)
			else
				for i,v in pairs(SpawnParts) do pcall(function() v:Destroy() end) end
				table.clear(SpawnParts)
			end
		end
	})
	SpawnPartColor = SpawnESP.CreateColorSlider({
		Name = "Color",
		Function = function(h, s, v) if SpawnESP.Enabled then for i,v in pairs(SpawnParts) do pcall(function() v.Color = Color3.fromHSV(SpawnPartColor.Hue, SpawnPartColor.Sat, SpawnPartColor.Value) end) end end end
	})
end)

		runFunction(function()
			if not pcall(GuiLibrary.RemoveObject, "HealthNotificationsOptionsButton") then 
				return
			end
			local HealthNotifications = {Enabled = false}
			local HealthSlider = {Value = 65}
			local HealthSound = {Enabled = false}
			local strikedhealth
			HealthNotifications = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
				Name = "HealthNotifications",
				HoverText = "runs actions whenever your health was under threshold.",
				ExtraText = function() return "Bedwars" end,
				Function = function(callback)
					if callback then
						task.spawn(function()
							table.insert(HealthNotifications.Connections, vapeEvents.EntityDamageEvent.Event:Connect(function(tab)
								if not isAlive() or tab.entityInstance ~= lplr.Character then return end
								local health = lplr.Character and (lplr.Character:GetAttribute("Health") or lplr.Character.Humanoid.Health)
								local maxhealth = lplr.Character and (lplr.Character:GetAttribute("MaxHealth") or lplr.Character.Humanoid.MaxHealth)
								if strikedhealth and health > strikedhealth then
									strikedhealth = nil
								end
								if health == maxhealth or strikedhealth and health <= strikedhealth and health < maxhealth then return end
								if health <= HealthSlider.Value then
									task.spawn(function()
										if not HealthSound.Enabled then return end
										playSound(bedwars.SoundList.BED_ALARM)
									end)
									strikedhealth = health + 35
									local healthcheck = health < HealthSlider.Value and "below" or "at"
									InfoNotification("HealthNotifications", "Your health is "..healthcheck.." "..HealthSlider.Value, 10)
							    end
							end))
						end)
					else
						strikedhealth = nil
					end
				end
			})
			HealthSlider = HealthNotifications.CreateSlider({
				Name = "Health",
				Min = 30,
				Max = 200,
				Default = 65,
				Function = function() end
			})
			HealthSound = HealthNotifications.CreateToggle({
				Name = "Sound",
				HoverText = "Plays a bed alarm sound on trigger.",
				Default = true,
				Function = function() end
			})
		end)

		runFunction(function()
			local ProjectileAura = {Enabled = false}
			local ProjectileAuraSkywars = {Enabled = false}
			local ProjectileAuraMobs = {Enabled = false}
			local ProjectileAuraNovel = {Enabled = false}
			local ProjectileAuraAnimation = {Enabled = false}
			local ProjectileTargetMethod = {Value = "Distance"}
			local mobprotectedprojectiles = {"spear", "sticky_firework"}
			local lastswitch = tick()
			ProjectileAura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
				Name = "ProjectileAura",
				HoverText = "Projectile exploit but automatic yes. FPS drops on bad devices.",
				ExtraText = function() return "Switch" end,
				Function = function(callback)
					if callback then
						task.spawn(function()
							table.insert(ProjectileAura.Connections, runService.Heartbeat:Connect(function()
								if bedwarsStore.queueType:find("skywars") == nil and ProjectileAuraSkywars.Enabled then
									return
								end
								if bedwarsStore.matchState == 0 then return end
								local projectiles, ent = GetAllLocalProjectiles(ProjectileAuraNovel.Enabled), FindTarget(nil, true, ProjectileAuraMobs.Enabled, ProjectileTargetMethod.Value == "Health")
								if not ent.RootPart or lastswitch > tick() or VoidwareStore.switchItemTick > tick() then return end
								if FindTarget(25, nil, true).RootPart and getSword() then
									switchItem(getSword().tool)
								end
								if FindTarget(25.50, nil, true).RootPart or killauraNearPlayer then return end
								for i,v in pairs(projectiles) do
									local cooldown = VoidwareStore.FrameRate > 35 and VoidwareStore.FrameRate < 80 and VoidwareStore.FrameRate / 45 or VoidwareStore.FrameRate > 80 and 0.15 or 2
									lastswitch = tick() + cooldown
									if not getItem(v.ammo) or VoidwareStore.Tweening then continue end
									if not ent.Human and table.find(mobprotectedprojectiles, i) or VoidwareStore.switchItemTick > tick() then continue end
									switchItem(getItem(i).tool)
									if ProjectileAuraAnimation.Enabled then
									   bedwars.ViewmodelController:playAnimation(15)
									end
									bedwars.ProjectileController:createLocalProjectile(bedwars.ProjectileMeta[i], v.ammo, v.ammo, ent.RootPart.Position + Vector3.new(0, 3, 0), "", Vector3.new(0, -60, 0), {drawDurationSeconds = 1})
									bedwars.ClientHandler:Get(bedwars.ProjectileRemote):CallServerAsync(getItem(i).tool, v.ammo, v.ammo, ent.RootPart.Position + Vector3.new(0, 3, 0), ent.RootPart.Position + Vector3.new(0, 3, 0), Vector3.new(0, -1, 0), httpService:GenerateGUID(), {drawDurationSeconds = 1}, workspace:GetServerTimeNow() - 0.045)
									didshoot = true
								end
								   originalitem = nil
							end))
						end)
					else
						lastswitch = tick()
					end
				end
			})
			ProjectileAuraAnimation = ProjectileAura.CreateToggle({
				Name = "Viewmodel Animation",
				Default = true,
				Function = function() end
			})
			ProjectileAuraSkywars = ProjectileAura.CreateToggle({
				Name = "Skywars Only",
				Function = function() end
			})
			ProjectileAuraNovel = ProjectileAura.CreateToggle({
				Name = "Other Projectiles",
				HoverText = "Also uses other projectiles. (fireball, gloop etc.)",
				Function = function() end,
				Default = true
			})
			ProjectileAuraMobs = ProjectileAura.CreateToggle({
				Name = "Mobs",
				HoverText = "Also targets npcs.",
				Function = function() end
			})
			ProjectileTargetMethod = ProjectileAura.CreateDropdown({
				Name = "Method",
				List = {"Distance", "Health"},
				Function = function() end
			})
		end)

		runFunction(function()
			local ArmorColoring = {Enabled = false}
			local armorcolorboots = {Enabled = false}
			local armorcolorchestplate = {Enabled = false}
			local armorcolorhelmet = {Enabled = false}
			local armorcolorneon = {Enabled = false}
			local armorcolor = {Hue = 0, Sat = 0, Value = 0}
			local oldarmortextures = {}
			local transformedobjects = {}
			local function isArmor(tool) return armorcolorhelmet.Enabled and tool.Name:find("_helmet") or armorcolorchestplate.Enabled and tool.Name:find("_chestplate") or armorcolorboots.Enabled and tool.Name:find("_boots") or nil end
			local function refresharmor()
				return pcall(function()
					for i,v in pairs(lplr.Character:GetChildren()) do
						if v:IsA("Accessory") and v:GetAttribute("ArmorSlot") and isArmor(v) then
							local handle = v:FindFirstChild("Handle")
							if not handle then continue end
							if oldarmortextures[v] == nil then oldarmortextures[v] = handle.TextureID end
							handle.TextureID = ""
							handle.Color = Color3.fromHSV(armorcolor.Hue, armorcolor.Sat, armorcolor.Value)
							handle.Material = armorcolorneon.Enabled and Enum.Material.Neon or Enum.Material.SmoothPlastic
							table.insert(transformedobjects, handle)
						end 
					end
				end)
			end
			ArmorColoring = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
				Name = "ArmorColoring",
				HoverText = "add some glow up to your armor.",
				Function = function(callback)
					if callback then
						task.spawn(function()
							if not isAlive() then repeat task.wait() until isAlive() end
							task.spawn(refresharmor)
							table.insert(ArmorColoring.Connections, lplr.CharacterAdded:Connect(function()
								if not isAlive() then repeat task.wait() until isAlive() end
								ArmorColoring.ToggleButton(false)
								ArmorColoring.ToggleButton(false)
							end))
							table.insert(ArmorColoring.Connections, lplr.Character.ChildAdded:Connect(function(v)
								if v:IsA("Accessory") and v:GetAttribute("ArmorSlot") and isArmor(v) then
									refresharmor()
								end
							end))
						end)
					else
						for i,v in pairs(transformedobjects) do
							if v.Parent and oldarmortextures[v.Parent] then
								pcall(function() v.TextureID = oldarmortextures[v.Parent] end)
							end
						end
						transformedobjects = {}
					end
				end
			})
			armorcolor = ArmorColoring.CreateColorSlider({
				Name = "Color",
				Function = function()
					if ArmorColoring.Enabled then
						refresharmor()
					end
				end
			})
			armorcolorneon = ArmorColoring.CreateToggle({
				Name = "Neon",
				Function = function()
				if ArmorColoring.Enabled then
					ArmorColoring.ToggleButton(false)
					ArmorColoring.ToggleButton(false)
				end
			    end
			})
			armorcolorhelmet = ArmorColoring.CreateToggle({
				Name = "Helmet",
				Function = function()
				if ArmorColoring.Enabled then
					ArmorColoring.ToggleButton(false)
					ArmorColoring.ToggleButton(false)
				end
			    end
			})
			armorcolorchestplate = ArmorColoring.CreateToggle({
				Name = "Chestplate",
				Function = function()
				if ArmorColoring.Enabled then
					ArmorColoring.ToggleButton(false)
					ArmorColoring.ToggleButton(false)
				end
			    end
			})
			armorcolorboots = ArmorColoring.CreateToggle({
				Name = "Boots",
				Default = true,
				Function = function()
				if ArmorColoring.Enabled then
					ArmorColoring.ToggleButton(false)
					ArmorColoring.ToggleButton(false)
				end
			    end
			})
		end)
		
	--[[runFunction(function()
		local AutoEmber = {Enabled = false}
		AutoEmber = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
			Name = "4BigGuysExploit",
			HoverText = "Automatically uses the ember ability.",
			Function = function(callback)
				if callback then 
					task.spawn(function()
						repeat 
							local saber = getItem("infernal_saber")
							if killauraNearPlayer and saber and not VoidwareFunctions:SpecialNearPosition(30) then 
								bedwars.ClientHandler:Get("HellBladeRelease"):SendToServer({chargeTime = 0.5, player = lplr, weapon = saber.tool})
							end
							task.wait()
						until not AutoEmber.Enabled
					end)
				end
			end
		})
	end)]]

	runFunction(function()
		local EventNotifications = {Enabled = false}
		local EventNotificationKill, EventNotificationKillList = {Enabled = false}, {ObjectList = {}}
		local EventNotificationBedBreak, EventNotificationBedBreakList = {Enabled = false}, {ObjectList = {}}
		local EventNotificationRageQuit, EventNotificationRageQuitList, EventNotificationRageQuitTick = {Enabled = false}, {ObjectList = {}}, tick()
		local EventNotificationBedShield = {Enabled = false}
		EventNotifications = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
			Name = "EventNotifications",
			HoverText = "Get notified when certain events take place.",
			Function = function(callback)
				if callback then 
					task.spawn(function()
						table.insert(EventNotifications.Connections, vapeEvents.EntityDeathEvent.Event:Connect(function(tab)
							if tab and type(tab) == "table" and tab.fromEntity and tab.entityInstance and EventNotificationKill.Enabled then 
								local enemy, victim = playersService:GetPlayerFromCharacter(tab.fromEntity), playersService:GetPlayerFromCharacter(tab.entityInstance)
								if enemy and victim and victim ~= enemy and enemy == lplr and not tab.finalKill then
									local objectlist = EventNotificationKillList.ObjectList
									local text = getrandomvalue(objectlist) ~= "" and getrandomvalue(objectlist) or "Since You've killed <name>, he might start malding :troll:"
									text = string.gsub(text, "<name>", victim.DisplayName)
									InfoNotification("EventNotifications", text, 5)
								end
							end
						end))
						table.insert(EventNotifications.Connections, vapeEvents.BedwarsBedBreak.Event:Connect(function(tab)
							if tab and type(tab) == "table" and EventNotificationBedBreak.Enabled then 
								if tab.player == lplr then 
									local objectlist = EventNotificationBedBreakList.ObjectList
									local bedteam = bedwars.QueueMeta[bedwarsStore.queueType].teams[tonumber(tab.brokenBedTeam.id)]
									local bedteamname = bedteam and bedteam.displayName or ""
									local text = getrandomvalue(objectlist) ~= "" and getrandomvalue(objectlist) or "You've destroyed "..bedteamname.." Team's Bed"
									if bedteam and bedteamname ~= "" then 
										text = string.gsub(text, "<bedteam>", bedteamname)
										InfoNotification("EventNotifications", text, 5)
									end
								end
							end
						end))
						table.insert(EventNotifications.Connections, VoidwareStore.BedShieldEnd.Event:Connect(function()
							if EventNotificationBedShield.Enabled then
							   InfoNotification("EventNotifications", "Bed Shields have expired, Beds are now breakable.", 10)
							end
						end))
						table.insert(EventNotifications.Connections, playersService.PlayerRemoving:Connect(function(player)
							if bedwarsStore.matchState == 0 or VoidwareStore.GameFinished then return end
							if EventNotificationRageQuit.Enabled and player.Team and player.Team.Name ~= "Spectators" and EventNotificationRageQuitTick <= tick() then
								local objectlist = EventNotificationRageQuitList.ObjectList
								local text = getrandomvalue(objectlist) ~= "" and getrandomvalue(objectlist) or "<name> has left the game."
								text = string.gsub(text, "<name>", player.DisplayName)
								InfoNotification("EventNotifications", text, 5)
								EventNotificationRageQuitTick = tick() + 0.5
							end
						end))
					end)
				end
			end
		})
		EventNotificationKill = EventNotifications.CreateToggle({
			Name = "Kill",
			Default = true,
			Function = function(callback) pcall(function() EventNotificationKillList.Object.Visible = callback end) end
		})
		EventNotificationKillList = EventNotifications.CreateTextList({
			Name = "EventNotificationKillList",
			TempText = "Kill Messages | <name>",
			AddFunction = function() end
		})
		EventNotificationBedBreak = EventNotifications.CreateToggle({
			Name = "Bed Break",
			Default = true,
			Function = function(callback) pcall(function() EventNotificationBedBreakList.Object.Visible = callback end) end
		})
		EventNotificationBedBreakList = EventNotifications.CreateTextList({
			Name = "EventNotificationBedBreakList",
			TempText = "Bed Break Messages | <bedteam>",
			AddFunction = function() end
		})
		EventNotificationRageQuit = EventNotifications.CreateToggle({
			Name = "Leave",
			HoverText = "Notifies when a player leaves while still being alive.",
			Default = true,
			Function = function(callback) pcall(function() EventNotificationRageQuitList.Object.Visible = callback end) end
		})
		EventNotificationRageQuitList = EventNotifications.CreateTextList({
			Name = "EventNotificationRageQuitList",
			TempText = "Leave Messages | <name>",
			AddFunction = function() end
		})
		EventNotificationBedShield = EventNotifications.CreateToggle({
			Name = "Bed Shield",
			HoverText = "Notifies when all bed shields have expired.",
			Default = true,
			Function = function() end
		})
		EventNotificationKillList.Object.Visible = EventNotificationKill.Enabled 
		EventNotificationBedBreakList.Object.Visible = EventNotificationBedBreak.Enabled 
		EventNotificationRageQuitList.Object.Visible = EventNotificationRageQuit.Enabled
		EventNotificationBedBreakList.Object.AddBoxBKG.AddBox.TextSize = 13
	end)

	runFunction(function()
		local HostPanelExploit = {Enabled = false}
		local oldhostattribute = nil
		HostPanelExploit = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
			Name = "HostPanel",
			HoverText = "yes real host panel no client side!1!1! 1000%",
			Function = function(callback)
				task.spawn(function()
					if oldhostattribute == nil then 
						oldhostattribute = (lplr:GetAttribute("Cohost") or lplr:GetAttribute("Host")) and true or false
					end
					if not callback and bedwars.ClientStoreHandler:getState().Game.customMatch and oldhostattribute then 
						return
					end
					lplr:SetAttribute("Cohost", callback)
				end)
			end
		})
	end)

	runFunction(function()
		if not pcall(GuiLibrary.RemoveObject, "BoostHighJumpOptionsButton") then 
			return 
		end
		local lastToggled = tick()
		local SmoothHighJump = {Enabled = false}
		local SmoothJumpTick = {Value = 5}
		local SmoothJumpTime = {Value = 1.2}
		local boostTick = 5
		SmoothHighJump = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "BoostHighJump",
		NoSave = true,
		Function = function(callback)
			if callback then
				task.spawn(function()
					if tick() >= lastToggled then 
						lastToggled = tick() + SmoothJumpTime.Value
					end
					if isAlive() and lplr.Character.Humanoid.FloorMaterial == Enum.Material.Air and tick() > bedwarsStore.scythe then 
						SmoothHighJump.ToggleButton(false)
						return 
					end
					repeat
					if not isAlive() or not isnetworkowner(lplr.Character.HumanoidRootPart) or VoidwareFunctions:LoadTime() < 0.1 then
						SmoothHighJump.ToggleButton(false) 
						return 
					end
					if isEnabled("Fly") or isEnabled("InfiniteFly") or tick() > lastToggled then
						SmoothHighJump.ToggleButton(false) 
						return 
				    end
					lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, boostTick, 0)
					boostTick = boostTick + SmoothJumpTick.Value
					if VoidwareStore.jumpTick <= tick() then
					   VoidwareStore.jumpTick = tick() + 3
					end
					task.wait()
					until not SmoothHighJump.Enabled
				end)
			else
				lastToggled = tick()
				VoidwareStore.jumpTick = tick() + (boostTick / 30)
				boostTick = 5
			end
		end
	})
	SmoothJumpTick = SmoothHighJump.CreateSlider({
		Name = "Power",
		Min = 2,
		Max = 10,
		Default = 3,
		Function = function() end
	})
	SmoothJumpTime = SmoothHighJump.CreateSlider({
		Name = "Time",
		Min = 0.2,
		Max = 2,
		Default = 1.2,
		Function = function() end
	})
end)

runFunction(function()
	if not pcall(GuiLibrary.RemoveObject, "FlyTPOptionsButton") then 
		return 
	end
	local FlyTP = {Enabled = false}
	local FlyTPSurfaceCheck = {Enabled = true}
	local FlyTPVertical = {Value = 15}
	FlyTP = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "FlyTP",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					repeat 
					   if not isAlive() or not isnetworkowner(lplr.Character.HumanoidRootPart) then
						   FlyTP.ToggleButton(false) 
						   return 
					   end
					   if isEnabled("InfiniteFly") then 
						   FlyTP.ToggleButton(false)
						   return 
					   end
					   lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + Vector3.new(0, FlyTPVertical.Value <= 0 and 0.01 or FlyTPVertical.Value, 0)
					   lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0)
					   task.wait(0.1)
					until not FlyTP.Enabled
				end)
			end
		end
	})
	FlyTPVertical = FlyTP.CreateSlider({
		Name = "Vertical",
		Min = 15,
		Max = 60,
		Default = 25,
		Function = function() end
	})
end)

runFunction(function()
	local DoubleHighJump = {Enabled = false}
	local DoubleHighJumpHeight = {Value = 500}
	local DoubleHighJumpHeight2 = {Value = 500}
	local jumps = 0
	DoubleHighJump = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "DoubleHighJump",
		NoSave = true,
		HoverText = "A very interesting high jump.",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					if isAlive() and lplr.Character.Humanoid.FloorMaterial == Enum.Material.Air or jumps > 0 then 
						DoubleHighJump.ToggleButton(false) 
						return
					end
					for i = 1, 2 do 
						if not isAlive() then
							DoubleHighJump.ToggleButton(false) 
							return  
						end
						if i == 2 and lplr.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then 
							continue
						end
						lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, i == 1 and DoubleHighJumpHeight.Value or DoubleHighJumpHeight2.Value, 0)
						jumps = i
						task.wait(i == 1 and 1 or 0.30)
					end
					task.spawn(function()
						for i = 1, 20 do 
							if isAlive() then 
								lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
							end
						end
					end)
					task.delay(1.6, function() jumps = 0 end)
					if DoubleHighJump.Enabled then
					   DoubleHighJump.ToggleButton(false)
					end
				end)
			else
				VoidwareStore.jumpTick = tick() + 5
			end
		end
	})
	DoubleHighJumpHeight = DoubleHighJump.CreateSlider({
		Name = "First Jump",
		Min = 50,
		Max = 500,
		Default = 500,
		Function = function() end
	})
	DoubleHighJumpHeight2 = DoubleHighJump.CreateSlider({
		Name = "Second Jump",
		Min = 50,
		Max = 450,
		Default = 450,
		Function = function() end
	})
end)

runFunction(function()
	pcall(GuiLibrary.RemoveObject, "FirewallBypassOptionsButton")
	local FirewallBypass = {Enabled = false}
	local bypassdirection = Vector3.new(9e9, 9e9, 9e9)
	FirewallBypass = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "FirewallBypass",
		HoverText = "Bypass speed and float check with scythe.",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					repeat
						local scythe = getItemNear("_scythe")
						if scythe and isAlive(lplr, true) then
							local movevec, lookvec = lplr.Character.Humanoid.MoveDirection, lplr.Character.HumanoidRootPart.CFrame.LookVector
							bypassdirection = (movevec ~= Vector3.zero and movevec or lookvec) * 9e9
							local oldtool = GetHandItem()
							switchItem(scythe.tool)
							bedwars.ClientHandler:Get("ScytheDash"):SendToServer({direction = bypassdirection})
							if lplr:GetAttribute("ScytheSpinning") then 
								bedwarsStore.scythespeed = GuiLibrary.ObjectsThatCanBeSaved["SpeedScythe SpeedSlider"].Api.Value 
								if isEnabled("Killaura") and FindTarget(25, nil, true).RootPart or killauraNearPlayer then
									bedwarsStore.scythespeed = bedwarsStore.scythespeed / 3
								end
								bedwarsStore.scythe = tick() + 1.1
								oldtool = getItem(oldtool)
								if oldtool then 
									switchItem(oldtool.tool)
								end
							end
						end
					    task.wait()
					until not FirewallBypass.Enabled
				end)
			end
		end
	})
end)

runFunction(function()
	local WolfExploit = {Enabled = false}
	WolfExploit = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		Name = "WolfExploit",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					repeat task.wait()
						if FindTarget(25).RootPart and not VoidwareFunctions:SpecialNearPosition(50) then 
							bedwars.ClientHandler:Get("UseWerewolfHowlAbility"):CallServer({player = lplr})
						end
					until not WolfExploit.Enabled
				end)
			end
		end
	})
end)

runFunction(function()
	local SpookyExploit = {Enabled = false}
	SpookyExploit = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "SpookyExploit",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					table.insert(SpookyExploit.Connections, lplr.CharacterAdded:Connect(function()
						repeat task.wait() until isAlive(lplr, true)
						bedwars.ClientHandler:Get("CursedCoffinApplyVampirism"):SendToServer({player = lplr})
					end))
					bedwars.ClientHandler:Get("CursedCoffinApplyVampirism"):SendToServer({player = lplr}) 
				end)
			end
		end
	})
end)

runFunction(function()
	local HungerAll = {Enabled = false}
	local Hunger = {Enabled = false}
	local HungerTarget = {Value = ""}
	local HungerAllTeam = {Enabled = false}
	local function decayfunc(player, toggle)
		repeat task.wait() until tostring(player.Team) ~= "Neutral" and not player:GetAttribute("Spectator")
		if player:GetAttribute("Team") == lplr:GetAttribute("Team") and HungerAllTeam.Enabled and not toggle then 
			return 
		end
		repeat task.wait() until VoidwareFunctions.WhitelistLoaded and WhitelistFunctions.Loaded
		if not ({VoidwareFunctions:GetPlayerType(v)})[2] or not ({WhitelistFunctions:GetWhitelist(v)})[2] then 
			return 
		end
		table.insert(toggle and vapeConnections or HungerAll.Connections, player.CharacterAdded:Connect(function()
			repeat task.wait() until isAlive(player, true)
			if player:GetAttribute("Team") == lplr:GetAttribute("Team") and HungerAllTeam.Enabled and not toggle then 
				return 
			end
			bedwars.ClientHandler:Get("CursedCoffinApplyVampirism"):SendToServer({player = player})
		end))
		bedwars.ClientHandler:Get("CursedCoffinApplyVampirism"):SendToServer({player = player})
	end
	HungerAll = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		Name = "HungerAll",
		HoverText = "Gives away the vampire effect to everyone else.",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					for i,v in playersService:GetPlayers() do 
						if v ~= lplr then
						  task.spawn(decayfunc, v)
						end
					end
					table.insert(HungerAll.Connections, playersService.PlayerAdded:Connect(decayfunc))
				end)
			end
		end
	})
	HungerAllTeam = HungerAll.CreateToggle({
		Name = "Team Check",
		HoverText = "Ignores teamates.",
		Default = true,
		Function = function() end
	})
	
	Hunger = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
		Name = "Hunger",
		NoSave = true,
		HoverText = "Gives a player the hunger effect.",
		Function = function(callback)
			if callback then 
				task.spawn(function()
					Hunger.ToggleButton(false)
					if HungerAll.Enabled then 
						return 
					end
					local plr = GetPlayerByName(HungerTarget.Value)
					if plr then 
						HungerTarget.SetValue("")
						decayfunc(plr, true)
						InfoNotification("Hunger", plr.DisplayName.." has been infected.")
					else
						errorNotification("Hunger", "Player not found.")
					end
				end)
			end
		end
	})
	HungerTarget = Hunger.CreateTextBox({
		Name = "Target",
		TempText = "name (not sensetive)",
		Function = function() end
	})

	task.spawn(function()
		repeat task.wait() until shared.VapeFullyLoaded
		HungerTarget.SetValue("")
	end)
end)
