local GuiLibrary = shared.GuiLibrary
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
local entityLibrary = shared.vapeentity
local vapeInjected = true
local VoidwareFunctions = {WhitelistLoaded = false, WhitelistRefreshEvent = Instance.new("BindableEvent"), WhitelistSucceeded = false, WhitelistLoadTime = tick()}
local VoidwareLibraries = {}
local RunLoops = {HeartTable = {}}
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
        MainVersion = "3.2.1",
        PatchVersion = "0",
        Nickname = "Universal Update V2",
		BuildType = "Stable",
		VersionID = "3.2"
    },
	FolderTable = {"vape/Voidware", "vape/Voidware/data"},
	SystemFiles = {"vape/NewMainScript.lua", "vape/MainScript.lua", "vape/GuiLibrary.lua", "vape/Universal.lua"},
	teleportinprogress = false,
	watermark = function(text) return ("[Voidware] "..text) end,
	Tweening = false,
	TimeLoaded = tick(),
	CurrentPing = 0,
	entityIDs = shared.VoidwareStore and type(shared.VoidwareStore.entityIDs) == "table" and shared.VoidwareStore.entityIDs or {fakeIDs = {}},
	HumanoidDied = Instance.new("BindableEvent"),
	MobileInUse = (inputService:GetPlatform() == Enum.Platform.Android or inputService:GetPlatform() == Enum.Platform.IOS) and true or false,
	ChatCommands = {},
	Api = {},
	AverageFPS = 60,
	FrameRate = 60,
	AliveTick = tick(),
	MatchStartEvent = Instance.new("BindableEvent"),
	MatchEndEvent = Instance.new("BindableEvent"),
	oldchatTabs = {
		oldchanneltab = nil,
		oldchannelfunc = nil,
		oldchanneltabs = {}
	}
}
local brookhavenStore = {
    gamecontrolRemote = {}
}
local VoidwareRank = VoidwareWhitelistStore.Rank
local VoidwarePriority = VoidwareWhitelistStore.Priority
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

shared.VoidwareStore.ModuleType = "Brookhaven"

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
	queueonteleport('shared.VoidwareQueueStore = '..newqueuestore)
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
	shared.VoidwareQueued = nil
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
	 local req, res = pcall(function() return game:HttpGet("https://github.com/SystemXVoid/"..repo) end)
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
			data = file:find(".lua") and "-- Voidware Custom Modules Signed File\n"..data or data
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
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
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
for i,v in pairs(playersService:GetPlayers()) do
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
    if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	if not vapeInjected then return end
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
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
		filedata = readfile("vape/CustomModules/6872265039.lua")
		if filedata:find("VoidwareStore") then
			writefile("Voidware/src/BedwarsLobby.lua", filedata)
		end
	end
end)
	task.wait(5)
	until not vapeInjected
end)

VoidwareStore.vapeupdateroutine = coroutine.create(function()
	repeat
	if not vapeInjected then break end
	local success, response = pcall(function()
	local vaperepoinfo = game:HttpGet("https://github.com/7GrandDadPGN/VapeV4ForRoblox", true)
	for i,v in pairs(vaperepoinfo:split("\n")) do 
	    if v:find("commit") and v:find("fragment") then 
	    local str = v:split("/")[5]
	    return str:sub(0, v:split("/")[5]:find('"') - 1)
	    end
	end
end)
if (isfile("vape/commithash.txt") and readfile("vape/commithash.txt") ~= response or not isfile("vape/commithash.txt") or not isfile("vape/Voidware/oldvape/Bedwars.lua")) then
		if VoidwareFunctions:GetPlayerType() == "OWNER" and success then 
			if response ~= "main" then 
				if not isfolder("vape") then makefolder("vape") end
				pcall(writefile, "vape/commithash.txt", response)
			end
			local newvape = betterhttpget("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..response.."/CustomModules/6872274481.lua")
			if newvape ~= "404: Not Found" then 
			VoidwareFunctions:GetMainDirectory()
			if not isfolder("vape/Voidware/oldvape") then makefolder("vape/Voidware/oldvape") end
			pcall(writefile, "vape/Voidware/oldvape/Bedwars.lua", newvape)
			end
		end
	end
	task.wait(5)
 until not vapeInjected
end)

pcall(coroutine.resume, VoidwareStore.vapeupdateroutine)

task.spawn(function()
    if not shared.VapeFullyLoaded and VoidwareStore.MobileInUse then repeat task.wait() until shared.VapeFullyLoaded or not vapeInjected end
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
    if not vapeInjected then return end
    local versiondata = VoidwareStore.VersionInfo
    repeat
    local VoidwareOwner = VoidwareFunctions:GetPlayerType() == "OWNER"
	if VoidwareOwner then return end
    local directory = VoidwareFunctions:GetMainDirectory()
    versiondata = VoidwareFunctions:GetFile("System/Version.vw", true)
    if versiondata ~= "404: Not Found" and versiondata ~= "" then versiondata = httpService:JSONDecode(versiondata) else versiondata = {} end
    local currentcommit = VoidwareFunctions:GetCommitHash(VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware")
    if not isfile(directory.."/".."commithash.vw") or readfile(VoidwareStore.maindirectory.."/".."commithash.vw") ~= currentcommit or not isfile(VoidwareStore.maindirectory.."/".."commithash.vw") then
        pcall(delfolder, directory.."/".."data")
        pcall(delfolder, directory.."/".."Libraries")
		if isfolder("vape") then
			for i,v in pairs(VoidwareStore.SystemFiles) do
				local body = VoidwareFunctions:GetFile("System/"..(string.gsub(v, "vape/", "")), true)
				if body ~= "" and body ~= "404: Not Found" and body ~= "400: Bad Request" then
					body = "-- Voidware Custom Modules Signed File\n"..body
					pcall(writefile, v, body)
				end
			end
			if isfolder("vape/CustomModules") then
			local supportedfiles = {"vape/CustomModules/6872274481.lua", "vape/CustomModules/6872265039.lua"}
			for i,v in pairs(supportedfiles) do
				local name = v ~= "vape/CustomModules/6872274481.lua" and "BedwarsLobby.lua" or "Bedwars.lua"
				local body = VoidwareFunctions:GetFile("System/"..name, true)
				if body ~= "" and body ~= "404: Not Found" and body ~= "400: Bad Request" then
					body = name ~= "Bedwars.lua" and "-- Voidware Custom Modules Signed File\n"..body or "-- Voidware Custom Modules Main File\n"..body
					pcall(writefile, v, body)
				end
			end
			end
		end
        pcall(writefile, directory.."/".."commithash.vw", currentcommit)
		if VoidwareStore.VersionInfo.BuildType == "Beta" and versiondata.VersionID and versiondata.VersionID ~= VoidwareStore.VersionInfo.VersionID and not VoidwareOwner then
			task.spawn(InfoNotification, "Voidware", "Your Beta build of Voidware has been updated. Changes will apply on relaunch.", 7)
			table.insert(shared.VoidwareStore.Messages, "Voidware Beta has successfully been upgraded from "..VoidwareStore.VersionInfo.VersionID.." to "..versiondata.VersionID)
		end
		if not VoidwareOwner and VoidwareStore.VersionInfo.BuildType ~= "Beta" and versiondata.VersionType ~= VoidwareStore.VersionInfo.MainVersion then
			if VoidwareFunctions:LoadTime() <= 10 then
				local uninject = pcall(antiguibypass)
				if uninject and isfile("vape/NewMainScript.lua") then
					loadstring(readfile("vape/NewMainScript.lua"))()
				end
			else
			   task.spawn(InfoNotification, "Voidware", "Voidware has been updated from "..VoidwareStore.VersionInfo.MainVersion.." to "..versiondata.VersionType..". changes will apply on relaunch.", 7)
			end
			table.insert(shared.VoidwareStore.Messages, "Voidware has successfully been upgraded from "..VoidwareStore.VersionInfo.VersionID.." to "..versiondata.VersionID)
		end
    end 
    task.wait(VoidwareStore.MobileInUse and 10 or 5)
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
        if not isfile(v) or not readfile(v):find("-- Voidware Custom Modules Signed File") then
        local namesplit = string.gsub(v, "vape/", "")
        local data = VoidwareFunctions:GetFile("System/"..namesplit, true)
        if data and data ~= "404: Not Found" and data ~= "" then
        data = "-- Voidware Custom Modules Signed File\n"..data
        pcall(writefile, v, data)
        end
    end
    end
    task.wait(VoidwareStore.MobileInUse and 10 or 5)
    until not vapeInjected
end)
end)

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

task.spawn(function()
	local removedobjects = {"Reach", "SilentAim", "TriggerBot", "HitBoxes", "Killaura", "HealthNotifications", "ChatBubble"}
	for i,v in pairs(GuiLibrary.ObjectsThatCanBeSaved) do 
		if v.Type == "OptionsButton" then 
			local namesplit = string.split(i, "OptionsButton")[1]
			if table.find(removedobjects, namesplit) then 
				task.spawn(GuiLibrary.RemoveObject, i)
			end
		end
	end
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

local function getbrookhavenstore() 
    local success, realstore = pcall(function() return replicatedStorageService.JK.TR end)
    if not success or not realstore then 
        local fakefolder = Instance.new("Folder")
        return fakefolder
    end
    return realstore
end

task.spawn(function()
    repeat task.wait()
        brookhavenStore.gamecontrolRemote = getbrookhavenstore() 
    until not vapeInjected
end)

runFunction(function()
    local AutoVehicleColor = {Enabled = false}
    local VehicleColor = {Hue = 0, Sat = 0, Value = 0}
    AutoVehicleColor = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
        Name = "AutoVehicleColor",
        HoverText = "Automatically changes the color on\nyour vehicles (some vehicles require gamepass).",
        Function = function(callback)
            if callback then
                task.spawn(function()
                repeat task.wait()
                pcall(function()
                    brookhavenStore.gamecontrolRemote["1Player1sCa1r"]:FireServer("NoMotorColor", Color3.fromHSV(VehicleColor.Hue, VehicleColor.Sat, VehicleColor.Value))
                end)
                until not AutoVehicleColor.Enabled
            end)
            end
        end
    })
    VehicleColor = AutoVehicleColor.CreateColorSlider({
        Name = "Color",
        Function = function() end
    })
end)

