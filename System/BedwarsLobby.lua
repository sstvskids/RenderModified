local GuiLibrary = shared.GuiLibrary
if isfile("vape/Voidware/oldvape/BedwarsLobby.lua") then
	local manualfileload = pcall(function() loadstring(readfile("vape/Voidware/oldvape/BedwarsLobby.lua"))() end)
	if not manualfileload then 
		loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872265039.lua"))()
	end
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/CustomModules/6872265039.lua"))()
end

local vapeInjected = true
local vapeConnections = {}
local vapeAssert = function(argument, title, text, duration, hault, moduledisable, module) 
	if not argument then
    local suc, res = pcall(function()
    local notification = GuiLibrary.CreateNotification(title or "Voidware", text or "Failed to call function.", duration or 20, "assets/WarningNotification.png")
    notification.IconLabel.ImageColor3 = Color3.new(220, 0, 0)
    notification.Frame.Frame.ImageColor3 = Color3.new(220, 0, 0)
    if moduledisable and (module and GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.Enabled) then GuiLibrary.ObjectsThatCanBeSaved[module.."OptionsButton"].Api.ToggleButton(false) end
    end)
    if hault then while true do end end
end
end
local identifyexecutor = identifyexecutor or function() return "Unknown" end
local httprequest = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	return {Body = tab.Method == "GET" and game:HttpGet(tab.Url, true) or "shit exploit", Headers = {["content-type"] = "application/json"}, StatusCode = 404}
end
local queueonteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local setclipboard = setclipboard or function(data) writefile("clipboard.txt", data) end
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local delfolder = delfolder or function() end
local antiguibypass = GuiLibrary.SelfDestruct
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local workspace = game:GetService("Workspace")
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
local targetinfo = shared.VapeTargetInfo
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local robloxfriends = {}
local bedwars = {}
local getfunctions
local origC0 = nil
local textChatService = game:GetService("TextChatService")
local collectionservice = game:GetService("CollectionService")
local VoidwareFunctions = {WhitelistLoaded = false, WhitelistRefreshEvent = Instance.new("BindableEvent")}
local VoidwareLibraries = {}
local tags = {}
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
		voidwarelitemoment = "Voidware Lite"
	},
	LocalPlayer = {Rank = "STANDARD", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "0000FF", TagHidden = true, HWID = "ABCDEFG", Accounts = {}, BlacklistedProducts = {}, UID = 0},
	Players = {}
}
local tags = {}
local VoidwareStore = {
	maindirectory = "vape/Voidware",
	VersionInfo = {
        MainVersion = "3.2",
        PatchVersion = "0",
        Nickname = "Universal Update",
		BuildType = "Stable",
		VersionID = "3.2"
    },
	FolderTable = {"vape/Voidware", "vape/Voidware/data"},
	SystemFiles = {"vape/NewMainScript.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua"},
	watermark = function(text) return ("[Voidware] "..text) end,
	Tweening = false,
	map = "Unknown",
	EnumFonts = {"SourceSans"},
	QueueTypes = {"bedwars_to4"},
	TimeLoaded = tick(),
	CurrentPing = 0,
	TargetObject = shared.VoidwareTargetObject,
	bedtable = {},
	HumanoidDied = Instance.new("BindableEvent"),
	Tag = function(name, player, color)
		name = name or "VOIDWARE USER"
		player = player or lplr
		color = color or "FF0000"
		tags[player] = {}
		tags[player].TagText = name
		tags[player].TagColor = color
	end,
	MobileInUse = (uis:GetPlatform() == Enum.Platform.Android or uis:GetPlatform() == Enum.Platform.IOS) and true or false,
	LastScytheTime = tick(),
	vapePrivateCommands = {},
	Enums = {},
	jumpTick = tick(),
	Api = {},
	AverageFPS = 60,
	entityIDs = shared.VoidwareStore and type(shared.VoidwareStore.entityIDs) == "table" and shared.VoidwareStore.entityIDs or {fakeIDs = {}},
	LobbyTitles = {},
	vapeupdateroutine = nil
}
VoidwareStore.FolderTable = {"vape/Voidware", VoidwareStore.maindirectory, VoidwareStore.maindirectory.."/".."data"}
local VoidwareGlobe = {ConfigUsers = {}, BlatantModules = {}, Messages = {}, GameFinished = false, WhitelistChatSent = {}, HookedFunctions = {}, UpdateTargetInfo = function() end, targetInfo = {}, entityIDs = {fakeIDs = {}}}
local VoidwareRank = VoidwareWhitelistStore.Rank
local VoidwarePriority = VoidwareWhitelistStore.Priority
local VoidwareQueueStore = {}
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
shared.VoidwareStore.ModuleType = "BedwarsLobby"

task.spawn(function()
	repeat task.wait() until shared.VapeFullyLoaded
	VoidwareStore.TimeLoaded = tick()
end)

for i,v in pairs(players:GetPlayers()) do 
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

table.insert(vapeConnections, players.PlayerAdded:Connect(function(plr)
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
	for i,v in pairs(vapeConnections) do
		pcall(function() v:Disconnect() end)
	end
	textChatService.OnIncomingMessage = nil
	pcall(function() getgenv().VoidwareFunctions = nil end)
end)

table.insert(vapeConnections, lplr.OnTeleport:Connect(function()
	if not shared.VoidwareQueueStore or type(shared.VoidwareQueueStore) ~= "table" then 
		shared.VoidwareQueueStore = VoidwareQueueStore
	end
	local oldqueuestore = shared.VoidwareQueueStore
	queueonteleport('shared.VoidwareQueueStore = '..oldqueuestore)
end))

function VoidwareFunctions:GetLocalEntityID(player)
	for i,v in pairs(VoidwareStore.entityIDs) do 
		if v == player.UserId then 
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

function VoidwareFunctions:GetLocalTag(player)
	local plr = VoidwareFunctions:GetLocalEntityID(player or lplr)
	if plr and tags[plr] then
		return tags[plr]
	end
	return {Text = "", Color = "FFFFFF"}
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

function VoidwareFunctions:LoadTime()
	if shared.VapeFullyLoaded then
		return (tick() - VoidwareStore.TimeLoaded)
	else
		return 0
	end
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


local function betterhttpget(url)
	local supportedexploit, body = syn and syn.request or http_requst or request or fluxus and fluxus.request, ""
	if supportedexploit then
		local data = httprequest({Url = url, Method = "GET"})
		if data.Body then
			body = data.Body
		else
			body = game:HttpGet(url, true)
		end
	else
		body = game:HttpGet(url, true)
	end
	return body
end


local isfile = isfile or function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
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


function VoidwareFunctions:GetPlayerType(plr)
	plr = plr or lplr
	local tab = VoidwareWhitelistStore.Players[plr.UserId]
	if tab == nil then
		return "DEFAULT", true, 0, "SPECIAL USER", "FFFFFF", true, 0, false, "ABCDEFGH"
	else
		tab.Priority = VoidwarePriority[tab.Rank:upper()]
		return tab.Rank, tab.Attackable, tab.Priority, tab.TagText, tab.TagColor, tab.TagHidden, tab.UID, tab.HWID
	end
end

function VoidwareFunctions:SpecialInGame()
	local specialtable = {}
	for i,v in pairs(players:GetPlayers()) do
		if v ~= lplr and ({VoidwareFunctions:GetPlayerType(v)})[3] > 1.5 then
			table.insert(specialtable, v)
		end
	end
	return #specialtable > 0 and specialtable
end

function VoidwareFunctions:GetClientUsers()
	local users = {}
	for i,v in pairs(players:GetPlayers()) do
		if v ~= lplr and table.find(shared.VoidwareStore.ConfigUsers, v) then
			table.insert(users, plr)
		end
	end
	return users
end

function VoidwareFunctions:GetCommitHash(repo)
	repo = repo or "Voidware"
	local commit = "main"
	for i,v in pairs(game:HttpGet("https://github.com/SystemXVoid/"..repo):split("\n")) do 
	if v:find("commit") and v:find("fragment") then 
	local str = v:split("/")[5]
	commit = str:sub(0, str:find('"') - 1)
	break
	end
	end
	return commit
end

function VoidwareFunctions:GetFile(file, online, path)
	local repo = VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware"
	local directory = VoidwareFunctions:GetMainDirectory()
	if not isfolder(directory) then makefolder(directory) end
	local existent = pcall(function() return readfile(path or directory.."/"..file) end)
	local voidwarever = "main"
	local str = string.split(file, "/") or {}
	local lastfolder = nil
	local foldersplit2
	if not existent and not online then
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
	for i,v in pairs({"base64"}) do 
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


local function isEnabled(toggle)
	if not toggle then return false end
	toggle = GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"] and GuiLibrary.ObjectsThatCanBeSaved[toggle.."OptionsButton"].Api
	return toggle and toggle.Enabled or false
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
			for i2, v2 in pairs(players:GetPlayers()) do
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
		table.insert(vapeConnections, players.PlayerAdded:Connect(function(v2)
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
		table.insert(vapeConnections, players.PlayerRemoving:Connect(function(v2)
			if VoidwareWhitelistStore.Players[v2.UserId] ~= nil then
				VoidwareWhitelistStore.Players[v2.UserId] = nil
			end
		end))
	end
	return suc, whitelist
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
		task.spawn(error, "[Voidware] Failed to load whitelist functions: "..err)
	end
	task.wait(0.3)
	VoidwareFunctions.WhitelistLoaded = true
end)

task.spawn(function()
	local alreadychecked = false
	repeat task.wait(alreadychecked and 5 or 10)
		alreadychecked = true
		task.spawn(function()
		VoidwareFunctions:RefreshWhitelist()
		local suc, res = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/SystemXVoid/whitelist/"..VoidwareFunctions:GetCommitHash("whitelist").."/modulestrings.json")) end)
		if suc and res then
			VoidwareWhitelistStore.chatstrings = res
		end
		if VoidwareFunctions.WhitelistLoaded then
			VoidwareFunctions.WhitelistRefreshEvent:Fire()
		end
		task.wait(0.5)
		VoidwareFunctions.WhitelistLoaded = true
		end)
	until not vapeInjected 
end)



task.spawn(function()
	repeat
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType == "Beta" then
		antikickbypass("This build of Voidware is currently restricted", true)
	end
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType ~= "Beta" then
		pcall(delfolder, VoidwareFunctions:GetMainDirectory().."/beta")
	end
until not vapeInjected
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
					task.spawn(GuiLibrary.SelfDestruct)
					antikickbypass(v.Error, true)
				else
					if not isfile(directory.."/kickdata.vw") or readfile(directory.."/kickdata.vw") ~= tostring(v.ID) then
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

if GetCurrentProfile() == "Ghost" then
	VoidwareWhitelistStore.Hash = "voidwarelitemoment"
end

function VoidwareFunctions:RenderCustomNameTag(plr, text, color)
	if not plr then return nil end
	local nametag = plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("Nametag") and plr.Character.Head.Nametag:FindFirstChild("DisplayNameContainer")
	if nametag and nametag:IsA("Frame") then
		pcall(function()
			nametag.DisplayName.Text = "<font color='#"..color.."'>["..text.."]</font> "..nametag.DisplayName.Text
			table.insert(vapeConnections, nametag.DisplayName:GetPropertyChangedSignal("Text"):Connect(function()
				pcall(function() nametag.DisplayName.Text = "<font color='#"..color.."'>["..text.."]</font> "..plr.DisplayName end)
			end))
	end)
end
	table.insert(vapeConnections, plr.CharacterAdded:Connect(function()
		repeat
		nametag = plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("Nametag") and plr.Character.Head.Nametag:FindFirstChild("DisplayNameContainer")
		 if nametag and nametag:IsA("Frame") then 
			break 
		end
		task.wait()
		until not vapeInjected
		pcall(function()
			nametag.DisplayName.Text = "<font color='#"..color.."'>["..text.."]</font> "..nametag.DisplayName.Text
			table.insert(vapeConnections, nametag.DisplayName:GetPropertyChangedSignal("Text"):Connect(function()
				pcall(function() nametag.DisplayName.Text = "<font color='#"..color.."'>["..text.."]</font> "..plr.DisplayName end)
			end))
		end)
	end))
	return nametag
end

local function voidwareNewPlayer(plr)
	if not VoidwareFunctions.WhitelistLoaded then repeat task.wait() until VoidwareFunctions.WhitelistLoaded end
	pcall(function()
	plr = plr or lplr
	local plrtype, plrattackable, plrpriority, tagtext, tagcolor, taghidden, hwidstring = VoidwareFunctions:GetPlayerType(plr)
	if plrpriority > 1.5 and not taghidden then
		VoidwareFunctions:CreateLocalTag(plr, tagtext, tagcolor)
		task.spawn(function() VoidwareFunctions:RenderCustomNameTag(plr, tagtext, tagcolor) end)
	end
	if plr ~= lplr and ({VoidwareFunctions:GetPlayerType()})[3] < 2 and playerPriority > 1.5 then
		local whisperallowed = game:GetService("RobloxReplicatedStorage").ExperienceChat.WhisperChat:InvokeServer(plr.UserId)
		if whisperallowed then
			if not plr:GetAttribute("LobbyConnected") then repeat task.wait() until plr:GetAttribute("LobbyConnected") end
			task.wait(5)
			whisperallowed:SendAsync(VoidwareWhitelistStore.Hash)
		end
	end
end)
end

task.spawn(function()
	local oldwhitelists = {}
	for i,v in pairs(players:GetPlayers()) do
		task.spawn(voidwareNewPlayer, v)
		oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
	end
	
	table.insert(vapeConnections, players.PlayerAdded:Connect(function(v)
		oldwhitelists[v] = VoidwarePriority[({VoidwareFunctions:GetPlayerType(v)})[3]]
		task.spawn(voidwareNewPlayer, v)
	end))
	
	table.insert(vapeConnections, VoidwareFunctions.WhitelistRefreshEvent.Event:Connect(function()
	for i,v in pairs(players:GetPlayers()) do
		if ({VoidwareFunctions:GetPlayerType(v)}) ~= oldwhitelists[v] then
		task.spawn(voidwareNewPlayer, v)
		end
	end
	end))
end)

for i,v in pairs(players:GetPlayers()) do
	task.spawn(voidwareNewPlayer, v)
end

table.insert(vapeConnections, players.PlayerAdded:Connect(function(v)
	task.spawn(voidwareNewPlayer, v)
end))

table.insert(vapeConnections, players.PlayerRemoving:Connect(function(v)
	if table.find(shared.VoidwareStore.ConfigUsers, v) then
		table.remove(shared.VoidwareStore.ConfigUsers, v)
	end
end))

VoidwareStore.vapeupdateroutine = coroutine.create(function()
	repeat
	if not vapeInjected then break end
	local success, response = pcall(function()
	local vaperepoinfo = betterhttpget("https://github.com/7GrandDadPGN/VapeV4ForRoblox")
	for i,v in pairs(vaperepoinfo:split("\n")) do 
	    if v:find("commit") and v:find("fragment") then 
	    local str = v:split("/")[5]
	    return str:sub(0, v:split("/")[5]:find('"') - 1)
	    end
	end
end)
if (isfile("vape/commithash.txt") and readfile("vape/commithash.txt") ~= response or not isfile("vape/commithash.txt") or not isfile("vape/Voidware/oldvape/BedwarsLobby.lua")) then
		if VoidwareFunctions:GetPlayerType() == "OWNER" and success then 
			if response ~= "main" then 
				if not isfolder("vape") then makefolder("vape") end
				pcall(writefile, "vape/commithash.txt", response)
			end
			local newvape = betterhttpget("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..response.."/CustomModules/6872265039.lua")
			if newvape ~= "404: Not Found" then 
			VoidwareFunctions:GetMainDirectory()
			if not isfolder("vape/Voidware/oldvape") then makefolder("vape/Voidware/oldvape") end
			pcall(writefile, "vape/Voidware/oldvape/BedwarsLobby.lua", newvape)
			end
		end
	end
	task.wait(5)
 until not vapeInjected
end)

pcall(coroutine.resume, VoidwareStore.vapeupdateroutine)

task.spawn(function()
    if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not vapeInjected or shared.VoidwareStore.ModuleType ~= "Universal.lua" then return end
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
	repeat
	pcall(function()
	if VoidwareFunctions:GetPlayerType() == "OWNER" then
		if not isfolder("Voidware") then makefolder("Voidware") end
		if not isfolder("Voidware/src") then makefolder("Voidware/src") end
		local filedata = readfile("vape/CustomModules/6872274481.lua")
		if filedata:find("VoidwareStore") then
		writefile("Voidware/src/Bedwars.lua", filedata)
		end
		filedata = readfile("vape/Universal.lua")
		if filedata:find("VoidwareStore") then
			writefile("Voidware/src/Universal.lua", filedata)
		end
	end
end)
	task.wait(5)
	until not vapeInjected
end)

task.spawn(function()
    pcall(function()
    if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not VoidwareFunctions.WhitelistLoaded then repeat task.wait() until VoidwareFunctions.WhitelistLoaded end
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
    if not vapeInjected then return end
    local versiondata = VoidwareStore.VersionInfo
    repeat
    local VoidwareOwner = VoidwareFunctions:GetPlayerType() == "OWNER"
    if not isfolder("vape") then makefolder("vape") end
    if not isfolder("vape/Voidware") then pcall(makefolder, "vape/Voidware") end
	if not isfolder(VoidwareStore.maindirectory) then makefolder(VoidwareStore.maindirectory) end
    versiondata = VoidwareFunctions:GetFile("System/Version.vw", true)
    if versiondata ~= "404: Not Found" and versiondata ~= "" then versiondata = httpService:JSONDecode(versiondata) else versiondata = {} end
    local currentcommit = VoidwareFunctions:GetCommitHash(VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware")
    if not isfile(VoidwareStore.maindirectory.."/".."commithash.vw") or readfile(VoidwareStore.maindirectory.."/".."commithash.vw") ~= currentcommit then
        pcall(delfolder, VoidwareStore.maindirectory.."/".."data")
        pcall(delfolder, VoidwareStore.maindirectory.."/".."Libraries")
        local data = VoidwareFunctions:GetFile("System/Bedwars.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Vape Main File\n"..data pcall(writefile, "vape/CustomModules/6872274481.lua", data) end
        data = VoidwareFunctions:GetFile("System/NewMainScript.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/NewMainScript.lua", data) end
        data = VoidwareFunctions:GetFile("System/MainScript.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/MainScript.lua", data) end
        data = VoidwareFunctions:GetFile("System/GuiLibrary.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/GuiLibrary.lua", data) end
        pcall(writefile, VoidwareStore.maindirectory.."/".."commithash.vw", currentcommit)
    end 
    task.wait(VoidwareStore.MobileInUse and 10 or 5)
    until not vapeInjected
end)
end)

local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end
local bettergetfocus = function()
	if KRNL_LOADED then
		-- krnl is so garbage, you literally cannot detect focused textbox with UIS
		if game:GetService("TextChatService").ChatVersion == "TextChatService" then
			return (game:GetService("CoreGui").ExperienceChat.appLayout.chatInputBar.Background.Container.TextContainer.TextBoxContainer.TextBox:IsFocused())
		elseif game:GetService("TextChatService").ChatVersion == "LegacyChatService" then
			return ((game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:IsFocused() or searchbar:IsFocused()) and true or nil) 
		end
	end
	return game:GetService("UserInputService"):GetFocusedTextBox()
end
local entity = shared.vapeentity
local WhitelistFunctions = shared.vapewhitelist
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local getasset = getsynasset or getcustomasset
local storedshahashes = {}
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end

local function addvectortocframe2(cframe, newylevel)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getSpeedMultiplier(reduce)
	local speed = 1
	if lplr.Character then 
		local speedboost = lplr.Character:GetAttribute("SpeedBoost")
		if speedboost and speedboost > 1 then 
			speed = speed + (speedboost - 1)
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 0.6
		end
		if lplr.Character:GetAttribute("SpeedPieBuff") then 
			speed = speed + (queueType == "SURVIVAL" and 0.15 or 0.3)
		end
	end
	return reduce and speed ~= 1 and speed * (0.9 - (0.15 * math.floor(speed))) or speed
end

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

local function runcode(func)
	func()
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return CFrame.new(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local function getcustomassetfunc(path)
	if not betterisfile(path) then
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
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	return getasset(path) 
end

local function isAlive(plr, healthblacklist)
	plr = plr or lplr
	local alive = false 
	if plr.Character and plr.Character.PrimaryPart and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Head") then 
		alive = true
	end
	if plr:GetAttribute("PlayerConnected") then 
		alive = false
	end
	if not healthblacklist and plr.Character.Humanoid.Health <= 0 then 
		alive = false
	end
	return alive
end

local function GetMagnitudeOf2Objects(part1, part2, bypass)
	local partcounter = 0
	if bypass then
		local suc, res = pcall(function() return part1 end)
		if suc then 
		partcounter = partcounter + 1 
		end
		suc, res = pcall(function() return part2 end)
		if suc then 
		partcounter = partcounter + 1
	end
	else
		local suc, res = pcall(function() return part1.Position end)
		if suc then 
		partcounter = partcounter + 1 
		part1 = res
		end
		suc, res = pcall(function() return part2.Position end)
		if suc then 
		partcounter = partcounter + 1
		part2 = res
		end
	end
	local magofobjects = bypass and partcounter > 1 and math.floor(((part1) - (part2)).Magnitude) or not bypass and partcounter > 1 and math.floor(((part1) - (part2)).Magnitude) or 0
	return magofobjects
end

local function GetEnumItems(EnumType)
	local items = {}
	for i,v in pairs(Enum[EnumType]:GetEnumItems()) do
		table.insert(items, v.Name)
	end
	return items
end

local function transformtitle(plr)
	plr = plr or lplr
	if VoidwareStore.LobbyTitles[plr] then
		if VoidwareStore.LobbyTitles[plr].Connections then
			for i,v in pairs(VoidwareStore.LobbyTitles[plr].Connections) do
				pcall(function() v:Disconnect() end)
			end
			VoidwareStore.LobbyTitles[plr] = nil
		end
	end
	VoidwareStore.LobbyTitles[plr] = VoidwareStore.LobbyTitles[plr] or {}
	VoidwareStore.LobbyTitles[plr].Connections = VoidwareStore.LobbyTitles[plr].Connections or {}
	local disconnectfunctions = function() end
	if not isAlive(plr) then repeat task.wait() until isAlive(plr) end
	local lobbytitle = plr.Character.Head:FindFirstChild("LobbyTitle")
	if lobbytitle then
		lobbytitle:Destroy()
	end
	local newtitlegui = Instance.new("BillboardGui")
	newtitlegui.Name = "LobbyTitle"
	newtitlegui.Size = UDim2.new(4, 0, 0.5, 0)
	newtitlegui.StudsOffsetWorldSpace = Vector3.new(0, 2.5, 0)
	newtitlegui.MaxDistance = 20
	newtitlegui.Parent = plr.Character.Head
	newtitlegui.DistanceUpperLimit = -1
	newtitlegui.StudsOffset = Vector3.new(0, 0, 0)
	newtitlegui.AlwaysOnTop = true
	local newtitlelabel = Instance.new("TextLabel")
	newtitlelabel.Name = "1"
	newtitlelabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	newtitlelabel.Text = "Voidware Sense"
	newtitlelabel.TextScaled = true
	newtitlelabel.Position = UDim2.new(0, 0, 0, 0)
	newtitlelabel.Size = UDim2.new(1, 0, 1, 0)
	newtitlelabel.BackgroundTransparency = 1
	newtitlelabel.TextSize = 8
	newtitlelabel.BorderSizePixel = 0
	newtitlelabel.Font = Enum.Font.LuckiestGuy
	newtitlelabel.Archivable = true
	newtitlelabel.Parent = newtitlegui
	table.insert(VoidwareStore.LobbyTitles[plr].Connections, plr.Character.Head.ChildAdded:Connect(function(v)
		if v ~= newtitlegui and v.Name == "LobbyTitle" then
			v:Destroy()
		end
	end))
	table.insert(VoidwareStore.LobbyTitles[plr].Connections, plr.CharacterAdded:Connect(function()
		for i,v in pairs(VoidwareStore.LobbyTitles[plr].Connections) do
			pcall(function() v:Disconnect() end)
		end
		VoidwareStore.LobbyTitles[plr] = nil
	end))
	disconnectfunctions = function()
		for i,v in pairs(VoidwareStore.LobbyTitles[plr].Connections) do
			pcall(function() v:Disconnect() end)
		end
		VoidwareStore.LobbyTitles[plr] = nil
		pcall(function() newtitlegui:Destroy() end)
	end
	return newtitlegui, disconnectfunctions
end

local function FindTarget(dist, healthmethod, teamonly, enemyonly)
	local sort, playertab = healthmethod and math.huge or dist or math.huge, {}
	local sortmethods = {Nearest = function(ent) return GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, ent.Character.PrimaryPart) < sort end, Health = function(ent) return ent.Character.Humanoid.Health < sort end}
	for i,v in pairs(players:GetPlayers()) do
		if v ~= lplr and lplr.Character and lplr.Character.PrimaryPart and isAlive(v) and (teamcheck and v.Team and lplr.Team and v.Team ~= lplr.Team or not teamcheck or not v.Team or not lplr.Team) and (enemyonly and v.Team and lplr.Team and v.Team ~= lplr.Team or not enemyonly or not v.Team or not lplr.Team) then
			local currentmethod = healthmethod and "Health" or "Nearest"
			if sortmethods[currentmethod] and sortmethods[currentmethod](v) then
				sort = healthmethod and v.Character.Humanoid.Health or GetMagnitudeOf2Objects(lplr.Character.PrimaryPart, v.Character.PrimaryPart)
				playertab.Player = v
				playertab.Humanoid = v.Character.Humanoid
				playertab.RootPart = v.Character.PrimaryPart
			end
		end
	end
	return playertab
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

function VoidwareFunctions:RefreshLocalFiles()
	local success, updateIndex = pcall(function() return httpService:JSONDecode(VoidwareFunctions:GetFile("System/fileindex.vw")) end)
	if not success or type(updateIndex) ~= "table" then 
		updateIndex = {
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

local function runFunction(func) func() end

runcode(function()
    local flaggedremotes = {"SelfReport"}
    getfunctions = function()
        local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local OldClientGet = getmetatable(Client).Get
		local OldClientWaitFor = getmetatable(Client).WaitFor
        bedwars = {
			BedwarsKits = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ClientHandler = Client,
            ClientStoreHandler = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
			EmoteMeta = require(repstorage.TS.locker.emote["emote-meta"]).EmoteMeta,
			QueryUtil = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
			KitMeta = require(repstorage.TS.games.bedwars.kit["bedwars-kit-meta"]).BedwarsKitMeta,
			LobbyClientEvents = KnitClient.Controllers.QueueController,
            sprintTable = KnitClient.Controllers.SprintController,
			WeldTable = require(repstorage.TS.util["weld-util"]).WeldUtil,
			QueueMeta = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			getEntityTable = require(repstorage.TS.entity["entity-util"]).EntityUtil,
        }
		if not shared.vapebypassed then
			local realremote = repstorage:WaitForChild("GameAnalyticsError")
			realremote.Parent = nil
			local fakeremote = Instance.new("RemoteEvent")
			fakeremote.Name = "GameAnalyticsError"
			fakeremote.Parent = repstorage
			game:GetService("ScriptContext").Error:Connect(function(p1, p2, p3)
				if not p3 then
					return;
				end;
				local u2 = nil;
				local v4, v5 = pcall(function()
					u2 = p3:GetFullName();
				end);
				if not v4 then
					return;
				end;
				if p3.Parent == nil then
					return;
				end
				realremote:FireServer(p1, p2, u2);
			end)
			shared.vapebypassed = true
		end
	end
end)
getfunctions()

GuiLibrary["SelfDestructEvent"].Event:Connect(function()
	if chatconnection then
		chatconnection:Disconnect()
	end
	if teleportfunc then
		teleportfunc:Disconnect()
	end
	if oldchannelfunc and oldchanneltab then
		oldchanneltab.GetChannel = oldchannelfunc
	end
	for i2,v2 in pairs(oldchanneltabs) do
		i2.AddMessageToChannel = v2
	end
end)

local function getNametagString(plr)
	local nametag = ""
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE PRIVATE" then
		nametag = '<font color="rgb(127, 0, 255)">[VAPE PRIVATE] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE OWNER" then
		nametag = '<font color="rgb(255, 80, 80)">[VAPE OWNER] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)] then
		local data = WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)]
		local newnametag = ""
		if data.Tags then
			for i2,v2 in pairs(data.Tags) do
				newnametag = newnametag..'<font color="rgb('..math.floor(v2.TagColor.r)..', '..math.floor(v2.TagColor.g)..', '..math.floor(v2.TagColor.b)..')">['..v2.TagText..']</font> '
			end
		end
		nametag = newnametag..(newnametag.NameColor and '<font color="rgb('..math.floor(newnametag.NameColor.r)..', '..math.floor(newnametag.NameColor.g)..', '..math.floor(newnametag.NameColor.b)..')">' or '')..(plr.DisplayName or plr.Name)..(newnametag.NameColor and '</font>' or '')
	end
	return nametag
end

local function friendCheck(plr, recolor)
	if GuiLibrary["ObjectsThatCanBeSaved"]["Use FriendsToggle"]["Api"]["Enabled"] then
		local friend = (table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name) and GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectListEnabled"][table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name)] and true or nil)
		if recolor then
			return (friend and GuiLibrary["ObjectsThatCanBeSaved"]["Recolor visualsToggle"]["Api"]["Enabled"] and true or nil)
		else
			return friend
		end
	end
	return nil
end

local function renderNametag(plr)
	if WhitelistFunctions:CheckPlayerType(plr) ~= "DEFAULT" or WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)] then
		local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
		if playerlist then
			pcall(function()
				local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
				local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
				if targetedplr then 
					targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
				end
			end)
		end
		local nametag = getNametagString(plr)
		plr.CharacterAdded:Connect(function(char)
			if char ~= oldchar then
				pcall(function() 
					bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
				end)
			end
		end)
		if plr.Character and plr.Character ~= oldchar then
			task.spawn(function()
				pcall(function() 
					bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
				end)
			end)
		end
	end
end

local function GetClanTag(plr)
	local atr, res = pcall(function()
		return plr:GetAttribute("ClanTag")
	end)
	return atr and res ~= nil and res
end

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
						pcall(GuiLibrary.RemoveObject, "LightingThemeOptionsButton")
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
			if isAlive(lplr, true) then
				lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
				lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
			end
		end,
		removemodule = function(args, player)
			for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do
				if args[3] and v.Type == "OptionsButton" and tostring(args[3]):find(i) then
					GuiLibrary.RemoveObject(i)
				end
			end
		end,
		sendclipboard = function(args, player)
			setclipboard(args[3] or "https://voidwareclient.xyz")
		end,
		uninject = function(args, player)
			local uninject = false
			repeat uninject = pcall(antiguibypass) task.wait() until uninject
		end,
		crash = function(args, player)
			repeat until false
		end,
		freezetime = function(args, player)
			settings().Network.IncomingReplicationLag = math.huge
		end,
		unfreezetime = function(args, player)
			settings().Network.IncomingReplicationLag = 0
		end,
		void = function(args, player)
			local blocks = {}
			repeat task.wait()
			pcall(function()
			lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, -200, 0)
			for i,v in pairs(collectionService:GetTagged("block")) do
				if v.CanCollide then
					pcall(function()
					v.CanCollide = false
					table.insert(blocks, v)
					end)
				end
			end
			end)
			until not isAlive(lplr, true)
			for i,v in pairs(blocks) do
				pcall(function() v.CanCollide = true end)
			end
		end,
		disable = function(args, player)
			repeat 
			  pcall(function()
				if shared.GuiLibrary then
				  repeat task.wait() until shared.VapeFullyLoaded
				  shared.GuiLibrary.SelfDestruct()
				end
			  end)
			task.wait()
			 until not true
		end,
		deletemap = function(args, player)
			for i,v in pairs(game:GetDescendants()) do 
				if v:IsA("Part") or v:IsA("BasePart") or v:IsA("Model") then
				if v == lplr.Character then continue end
				pcall(function() v:Destroy() end)
				end
			end
			game.DescendantAdded:Connect(function(v)
				if v:IsA("Part") or v:IsA("BasePart") or v:IsA("Model") then
				pcall(function() v:Destroy() end)
				end
			end)
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
		lobby = function(args, player)
			bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer()
		end,
		sendmessage = function(args, player)
			local message = nil
			if #args > 2 then
				for i,v in pairs(args) do
					if i > 2 then
						message = message and message.." "..v or v
					end
				end
			end
			if message ~= nil then
				textChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(message)
			end
		end,
		shutdown = function(args, player)
			game:Shutdown()
		end,
		ban = function(args, player)
			antikickbypass("You have been temporarily banned. [Remaining ban duration: 4960 weeks 2 days 5 hours 19 minutes "..math.random(45, 59).." seconds ]")
			
		end,
		byfron = function(args, player)
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
		end,
		soundloop = function(args, player)
				for i,v in pairs(bedwars.SoundList) do
				local sound = Instance.new("Sound")
				sound.SoundId = v
				sound.Looped = true
				sound:Play()
			 end
		end,
		rickroll = function(args, player)
			transformimages()
		end,
		troll = function(args, player)
			transformimages("http://www.roblox.com/asset/?id=14392608036", "You've been trolled, you've been trolled, you've probably been told.")
		end
	}

	textChatService.OnIncomingMessage = function(message)
		local properties = Instance.new("TextChatMessageProperties")
		if message.TextSource then
			local plr = players:GetPlayerByUserId(message.TextSource.UserId)
			if not plr then return end
			local plrtype, attackable, playerPriority = VoidwareFunctions:GetPlayerType(plr)
			local tagdata = VoidwareFunctions:GetLocalTag(plr)
			local bettertextstring = GetClanTag(plr) and "<font color='#FFFFFF'>["..GetClanTag(plr).."]</font> "..message.PrefixText or message.PrefixText
			properties.PrefixText = tagdata.Text ~= "" and "<font color='#"..tagdata.Color.."'>["..tagdata.Text.."]</font> " ..bettertextstring or bettertextstring
			local args = string.split(message.Text, " ")
			if plr == lplr and message.Text:len() >= 5 and message.Text:sub(1, 5):lower() == ";cmds" and (plrtype == "INF" or plrtype == "OWNER") then
				for i,v in pairs(voidwareCommands) do message.TextChannel:DisplaySystemMessage(i) end
				message.Text = ""
			end
			if VoidwarePriority[VoidwareRank] > 1.5 and playerPriority < 2 and plr ~= lplr and not table.find(shared.VoidwareStore.ConfigUsers, plr) then
				for i,v in pairs(VoidwareWhitelistStore.chatstrings) do
					if message.Text:find(i) then
						message.Text = ""
						task.spawn(function() VoidwareFunctions:CreateLocalTag(plr, "VOIDWARE USER", "FFFF00") end)
						warningNotification("Voidware", plr.DisplayName.." is using "..v.."!", 60)
						table.insert(shared.VoidwareStore.ConfigUsers, plr)
					end
				end
			end
			if VoidwarePriority[VoidwareRank] < playerPriority  then
			for i,v in pairs(voidwareCommands) do
				if message.Text:len() >= (i:len() + 1) and message.Text:sub(1, i:len() + 1):lower() == ";"..i:lower() and (VoidwareWhitelistStore.Rank:find(args[2]:upper()) or VoidwareWhitelistStore.Rank:find(args[2]:lower()) or args[2] == lplr.DisplayName or args[2] == lplr.Name or args[2] == tostring(lplr.UserId)) then
					task.spawn(v, args, plr)
					local thirdarg = args[3] or ""
					message.Text = ""
					break
				end
			end
		end
		end
		return properties
	end
end)

task.spawn(function()
	local removedobjects = {"PlayerTP", "HealthNotifications", "AutoRejoin", "SetEmote"}
	for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
		if v.Type == "OptionsButton" then 
			local namesplit = string.split(i, "OptionsButton")[1]
			if table.find(removedobjects, namesplit) then 
				task.spawn(GuiLibrary.RemoveObject, i)
			end
		end
	end
end)

pcall(function() getgenv().VoidwareFunctions = VoidwareFunctions end)

local function VoidwareDataDecode(datatab)
	local newdata = datatab.latestdata or {}
	local oldfile = datatab.filedata
	local latestfile = datatab.filesource
	task.spawn(function()
		local releasedversion = newdata.ReleasedBuilds and table.find(newdata.ReleasedBuilds, VoidwareStore.VersionInfo.VersionID)
		if releasedversion and not newdata.Disabled and VoidwareStore.VersionInfo.BuildType == "Beta" and VoidwareFunctions:GetPlayerType() ~= "OWNER" then
			local data = VoidwareFunctions:GetFile("System/Bedwars.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Vape Main File\n"..data pcall(writefile, "vape/CustomModules/6872274481.lua", data) end
			data = VoidwareFunctions:GetFile("System/NewMainScript.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/NewMainScript.lua", data) end
			data = VoidwareFunctions:GetFile("System/MainScript.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/MainScript.lua", data) end
			data = VoidwareFunctions:GetFile("System/GuiLibrary.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Vape Signed File\n"..data pcall(writefile, "vape/GuiLibrary.lua", data) end
			pcall(delfolder, "vape/Voidware/beta")
			if VoidwareFunctions:LoadTime() < 10 then
			local uninject = pcall(antiguibypass)
			if uninject then
			table.insert(shared.VoidwareStore.Messages, "This beta build of Voidware has been released publicly. Your custom modules have been updated.")
			pcall(function() loadstring(readfile("vape/NewMainScript.lua"))() end)
			end
			end
		end
		if newdata.Disabled and ({VoidwareFunctions:GetPlayerType()})[3] < 2 then
			local uninjected = pcall(antiguibypass)
			if not uninjected then
				pcall(function() bedwars.ClientHandler:Get("TeleportToLobby"):SendToServer() end)
				task.wait(2)
				while true do end
			end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware",
				Text = "Voidware is currently disabled. check voidwareclient.xyz for updates.",
				Duration = 30,
			})
			setclipboard("https://voidwareclient.xyz")
		end
		if oldfile ~= latestfile then
			pcall(writefile, VoidwareStore.maindirectory.."/".."maintab.vw", latestfile)
			if not newdata.Disabled and newdata.Announcement and not VoidwareStore.MobileInUse then
				VoidwareFunctions:Announcement({
				 Text = newdata.AnnouncementText,
				 Duration = newdata.AnnouncementDuration
			    })
			end
		end
    end)
end

task.spawn(function()
	pcall(function()
	if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not VoidwareFunctions.WhitelistLoaded then repeat task.wait() until VoidwareFunctions.WhitelistLoaded end
	if not vapeInjected then return end
	task.wait(4.5)
	repeat
    local source = VoidwareFunctions:GetFile("maintab.vw", true)
	VoidwareDataDecode({
		latestdata = httpService:JSONDecode(source),
		filesource = source,
		filedata = VoidwareFunctions:GetFile("maintab.vw")
	})
	task.wait(5)
	until not vapeInjected
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

	runFunction(function()
		local NoNameTag = {Enabled = false}
		NoNameTag = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
			Name = "NoNameTag",
			NoSave = true,
			Function = function(callback)
				if callback then
					task.spawn(function()
						if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
						pcall(function() lplr.Character.Head.Nametag:Destroy() end)
						table.insert(NoNameTag.Connections, lplr.Character.Head.ChildAdded:Connect(function(v)
							if v.Name == "Nametag" then
								v:Destroy()
							end
						end))
						table.insert(NoNameTag.Connections, lplr.CharacterAdded:Connect(function()
							if not isAlive(lplr, true) then repeat task.wait() until isAlive(lplr, true) end
							NoNameTag.ToggleButton(false)
							NoNameTag.ToggleButton(false)
						end))
					end)
				end
			end
		})
	end)


	runFunction(function()
		local TitleCustomizer = {Enabled = false}
		local TitleColorToggle = {Enabled = false}
		local TextFontToggle = {Enabled = false}
		local TitleStroke = {Enabled = false}
		local TitleText = {Value = "VoidwareSense"}
		local TitleColor = {Hue = 0, Sat = 0, Value = 0}
		local TitleFont = {Value = "LuckiestGuy"}
		local titlemainframe, removefunction
		local function setlobbytitle()
			titlemainframe, removefunction = transformtitle(lplr)
			titlemainframe = titlemainframe:FindFirstChildWhichIsA("TextLabel")
				if not titlemainframe then return end
				titlemainframe.Text = TitleText.Value ~= "" and TitleText.Value or "Voidware Sense"
				titlemainframe.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
				if TitleColorToggle.Enabled then
					titlemainframe.TextColor3 = Color3.fromHSV(TitleColor.Hue, TitleColor.Sat, TitleColor.Value)
				end
				if TextFontToggle.Enabled then
					titlemainframe.Font = Enum.Font[TitleFont.Value]
				end
				titlemainframe.TextStrokeTransparency = TitleStroke.Enabled and 0 or 1
				table.insert(TitleCustomizer.Connections, lplr.CharacterAdded:Connect(function()
					if not isAlive() then repeat task.wait() until isAlive() end
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)	
			end))
		end
		TitleCustomizer = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
			Name = "TitleCustomizer",
			HoverText = "customizes your lobby titles client side.\n(creates a custom lobby title if you didn't have one)",
			Function = function(callback)
				if callback then
					task.spawn(function()
						if not isAlive() then repeat task.wait() until isAlive() end
						if not TitleCustomizer.Enabled then return end
						pcall(setlobbytitle)
					end)
					else
					  pcall(function() removefunction() end)
					  titlemainframe, removefunction = nil, nil
				end
			end
		})
		TitleColorToggle = TitleCustomizer.CreateToggle({
			Name = "Custom Color",
			Function = function(callback)
				pcall(function() TitleColor.Object.Visible = callback end) 
				if TitleCustomizer.Enabled then
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)
				end
			end
		})
		TitleColor = TitleCustomizer.CreateColorSlider({
			Name = "Text Color",
			Function = function()
				if TitleCustomizer.Enabled then
					pcall(setlobbytitle)
				end
			 end
		})
		TitleText = TitleCustomizer.CreateTextBox({
			Name = "Text",
			TempText = "Title Text",
			Function = function() 
				if TitleCustomizer.Enabled then
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)
				end
			end
		})
		TextFontToggle = TitleCustomizer.CreateToggle({
			Name = "Custom Font",
			Function = function(callback) 
				pcall(function() TitleFont.Object.Visible = callback end) 
				if TitleCustomizer.Enabled then
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)
				end
			end
		})
		TitleFont = TitleCustomizer.CreateDropdown({
			Name = "Font",
			List = GetEnumItems("Font"),
			Function = function()
				if TitleCustomizer.Enabled then
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)
				end
			 end
		})
		TitleStroke = TitleCustomizer.CreateToggle({
			Name = "Stroke",
			Function = function()
				if TitleCustomizer.Enabled then
					TitleCustomizer.ToggleButton(false)
					TitleCustomizer.ToggleButton(false)
				end
			end
		})
		TitleColor.Object.Visible = false
		TitleFont.Object.Visible = false
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
			local inventoryicons = ({pcall(function() return lplr.PlayerGui.hotbar["1"]["3"] end)})[2]
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
				indicatorobject.Text = DamageIndicatorTextToggle.Enabled and #DamageIndicatorText.ObjectList > 0 and DamageIndicatorText.ObjectList[math.random(1, #DamageIndicatorText.ObjectList)] or indicatorobject.Text
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
