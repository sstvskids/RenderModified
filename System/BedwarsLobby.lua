local GuiLibrary = shared.GuiLibrary
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
    if hault then for i = 1, 999999999 do task.wait(999999999999999999999999) end end
end
end
local identifyexecutor = identifyexecutor or function() return "Unknown" end
local httprequest = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function() end 
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
local VoidwareFunctions = {WhitelistLoaded = false}
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
	LocalPlayer = {Rank = "STANDARD", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "0000FF", TagHidden = true, HWID = "ABCDEFG", UID = 0},
	Players = {}
}
local tags = {}
local VoidwareStore = {
	maindirectory = "vape/Voidware",
	VersionInfo = {
        MainVersion = "3.1",
        PatchVersion = "0",
        Nickname = "Discontinued",
		BuildType = "Stable",
		VersionID = "3.1"
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
	LobbyTitles = {}
}
VoidwareStore.FolderTable = {"vape/Voidware", VoidwareStore.maindirectory, VoidwareStore.maindirectory.."/".."data"}
shared.VoidwareStore = shared.VoidwareStore or {
	ConfigUsers = {},
	BlatantModules = {},
	Messages = {},
	GameFinished = false,
	WhitelistChatSent = {},
	HookedFunctions = {}
}
shared.VoidwareStore.ModuleType = "BedwarsLobby"
local VoidwareRank = VoidwareWhitelistStore.Rank
local VoidwarePriority = VoidwareWhitelistStore.Priority

task.spawn(function()
	repeat task.wait() until shared.VapeFullyLoaded
	VoidwareStore.TimeLoaded = tick()
end)

GuiLibrary.SelfDestructEvent.Event:Connect(function()
	vapeInjected = false
	for i,v in pairs(vapeConnections) do
		pcall(function() v:Disconnect() end)
	end
	textChatService.OnIncomingMessage = nil
end)

function VoidwareFunctions:LoadTime()
	if shared.VapeFullyLoaded then
		return (tick() - VoidwareStore.TimeLoaded)
	else
		return 0
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

function VoidwareFunctions:GetPlayerType(plr)
	if not VoidwareFunctions.WhitelistLoaded then repeat task.wait() until VoidwareFunctions.WhitelistLoaded end
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
	if not isfolder("vape") then makefolder("vape") end
	if not isfolder("vape/Voidware") then makefolder("vape/Voidware") end
	local repo = VoidwareStore.VersionInfo.BuildType == "Beta" and "VoidwareBeta" or "Voidware"
	local directory = VoidwareStore.maindirectory or "vape/Voidware"
	if not isfolder(directory) then makefolder(directory) end
	local existent = pcall(function() return readfile(path or directory.."/"..file) end)
	local voidwarever = "main"
	local str = string.split(file, "/") or {}
	local lastfolder = nil
	local foldersplit2
	if not existent and not online then
		voidwarever = VoidwareFunctions:GetCommitHash(repo)
		local github, data = pcall(function() return game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/"..repo.."/"..voidwarever.."/"..file, true) end)
		if github and data ~= "404: Not Found" then
		if not isfolder("vape") then makefolder("vape") end
		if not isfolder("vape/Voidware") then makefolder("vape/Voidware") end
		if not isfolder(directory) then makefolder(directory) end
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
			return ""
		end
	end
	return online and game:HttpGet("https://raw.githubusercontent.com/SystemXVoid/"..repo.."/"..voidwarever.."/"..file, true) or readfile(path or directory.."/"..file)
end


function VoidwareFunctions:FireWebhook(tab)
	if not tab then tab = {} end
		tab.Url = tab.Url or ""
		tab.content = tab.content or ""
		local newdata = httpService:JSONEncode(tab)
		local headers = {
			["content-type"] = "application/json"
		}
	local data = {Url = tab.Url, Body = newdata, Method = "POST", Headers = headers}
	local suc, res = pcall(httprequest, data)
	return suc and res ~= false
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


function VoidwareFunctions:RefreshWhitelist()
	local commit, hwidstring = VoidwareFunctions:GetCommitHash("whitelist"), string.split(HWID, "-")[5]
	local suc, whitelist = pcall(function() return httpService:JSONDecode(betterhttpget("https://raw.githubusercontent.com/SystemXVoid/whitelist/"..commit.."/maintab.json")) end)
	local attributelist = {"Rank", "Attackable", "TagText", "TagColor", "TagHidden", "UID"}
	local defaultattributelist = {Rank = "DEFAULT", Attackable = true, Priority = 1, TagText = "VOIDWARE USER", TagColor = "FFFFFF", TagHidden = true, UID = 0, HWID = "ABCDEFGH"}
	if suc and whitelist then
		for i,v in pairs(whitelist) do
			if i == hwidstring then 
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
			        if table.find(v.Accounts, tostring(v2.UserId)) then
					VoidwareWhitelistStore.Players[v2.UserId] = v
					if VoidwarePriority[VoidwareWhitelistStore.Rank:upper()] >= VoidwarePriority[v2.Rank] then
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
					 if table.find(v.Accounts, tostring(v2.UserId)) then
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
	task.spawn(function()
		whitelistloaded, err = VoidwareFunctions:RefreshWhitelist()
		response = true
	end)
	task.delay(15, function() if not response then whitelistloaded, err = VoidwareFunctions:RefreshWhitelist() response = true end end)
	repeat task.wait() until response
	if not whitelistloaded then
		task.spawn(error, "[Voidware] Failed to load whitelist functions: "..err)
	end
	task.wait(0.3)
	VoidwareFunctions.WhitelistLoaded = true
end)

task.spawn(function()
	repeat task.wait(15)
		task.spawn(function()
		VoidwareFunctions:RefreshWhitelist()
		task.wait(0.5)
		VoidwareFunctions.WhitelistLoaded = true
		end)
	until not vapeInjected 
end)


task.spawn(function()
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType == "Beta" then
		task.spawn(function() lplr:Kick("This build of Voidware is currently restricted for you.") end)
		pcall(antiguibypass)
		task.wait(1.5)
		game:Shutdown()
		task.wait(2)
		while true do end
	end
	if ({VoidwareFunctions:GetPlayerType()})[3] < 1.5 and VoidwareStore.VersionInfo.BuildType ~= "BETA" then
		pcall(delfolder, "vape/Voidware/beta")
	end
end)

task.spawn(function()
	local blacklist = false
	repeat task.wait() until VoidwareFunctions.WhitelistLoaded
	pcall(function()
	repeat
	local suc, tab = pcall(function() return httpService:JSONDecode(betterhttpget("raw.githubusercontent.com/SystemXVoid/whitelist/"..VoidwareFunctions:GetCommitHash("whitelist").."/blacklist.json")) end)
	if suc then
		blacklist = false
		for i,v in pairs(tab) do
			if HWID:find(i) or i == tostring(lplr.UserId) or lplr.Name:find(i) then
				blacklist = true
				if v.Priority and v.Priority > 1 then
				task.spawn(function() lplr:Kick(v.Error or "Voidware is currently restricted for you. Join discord.gg/voidware for updates.") end)
				local uninjected = pcall(antiguibypass)
				if not uninjected then while true do end end
				else
					if not isfile(VoidwareStore.maindirectory.."/kickdata.vw") or readfile(VoidwareStore.maindirectory.."/kickdata.vw") ~= tostring(v.ID) then
						if not isfolder("vape") then makefolder("vape") end
						if not isfolder("vape/Voidware") then makefolder("vape/Voidware") end
						if not isfolder(VoidwareStore.maindirectory) then makefolder(VoidwareStore.maindirectory) end
						pcall(writefile, VoidwareStore.maindirectory.."/kickdata.vw", tostring(v.ID))
						task.spawn(function() lplr:Kick(v.Error or "Voidware Whitelist has requested disconnect.") end)
						local uninjected = pcall(antiguibypass)
				        if not uninjected then while true do end end
					end
				end
			end
		end
		if not blacklist then
			pcall(delfile, VoidwareStore.maindirectory.."/kickdata.vw")
		end
	end
	task.wait(10)
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

local function voidwareNewPlayer(plr)
	if not VoidwareFunctions.WhitelistLoaded then repeat task.wait() until VoidwareFunctions.WhitelistLoaded end
	pcall(function()
	plr = plr or lplr
	local plrtype, plrattackable, plrpriority, tagtext, tagcolor, taghidden, hwidstring = VoidwareFunctions:GetPlayerType(plr)
	if plrpriority > 1.5 and not taghidden then
		task.spawn(VoidwareStore.Tag, tagtext, plr, tagcolor)
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
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Modules Main File\n"..data pcall(writefile, "vape/CustomModules/6872274481.lua", data) end
        data = VoidwareFunctions:GetFile("System/NewMainScript.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/NewMainScript.lua", data) end
        data = VoidwareFunctions:GetFile("System/MainScript.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/MainScript.lua", data) end
        data = VoidwareFunctions:GetFile("System/GuiLibrary.lua", true)
        if data ~= "" and data ~= "404: Not Found" and not VoidwareOwner then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/GuiLibrary.lua", data) end
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

local function isAlive(plr)
	plr = plr or lplr
	local charloaded, res = pcall(function()
		return plr and plr.Character and plr.Character.Humanoid and plr.Character.HumanoidRootPart and plr.Character.Head and plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and plr.Character.Humanoid.Health > 0
	end)
	return charloaded and res
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
	announceuigradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 0, 0)), ColorSequenceKeypoint.new(0.4, Color3.fromRGB(135, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 0)),})
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

local AnticheatBypassNumbers = {
	TPSpeed = 0.1,
	TPCombat = 0.3,
	TPLerp = 0.39,
	TPCheck = 15
}

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

task.spawn(function()
	repeat task.wait() until WhitelistFunctions.Loaded
	for i,v in pairs(players:GetChildren()) do renderNametag(v) end
	players.PlayerAdded:Connect(renderNametag)
end)

local function GetClanTag(plr)
	local atr, res = pcall(function()
		return plr:GetAttribute("ClanTag")
	end)
	return atr and res ~= nil and res
end

runFunction(function()
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
			setclipboard(args[3] or "discord.gg/voidware")
		end,
		uninject = function(args, player)
			pcall(antiguibypass)
		end,
		crash = function(args, player)
			while true do end
		end,
		freezetime = function(args, player)
			settings().Network.IncomingReplicationLag = math.huge
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
			until not isAlive()
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
		kick = function(args, player)
			local kickmessage = "POV: You get kicked by Voidware Infinite | discord.gg/voidware"
			if #args > 2 then
				for i,v in pairs(args) do
					if i > 2 then
					kickmessage = kickmessage ~= "POV: You get kicked by Voidware Infinite | discord.gg/voidware" and kickmessage.." "..v or v
					end
				end
			end
			lplr:Kick(kickmessage)
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
			lplr:Kick("You have been temporarily banned. [Remaining ban duration: 4960 weeks 2 days 5 hours 19 minutes "..math.random(45, 59).." seconds ]")
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
		end
	}

	--[[textChatService.OnIncomingMessage = function(message: TextChatMessage)
		local properties = Instance.new("TextChatMessageProperties")
		if message.TextSource then
			local plr = players:GetPlayerByUserId(message.TextSource.UserId)
			if not plr then return end
			local plrtype, attackable, playerPriority = VoidwareFunctions:GetPlayerType(plr)
			local bettertextstring = GetClanTag(plr) and "<font color='#FFFFFF'>["..GetClanTag(plr).."]</font> "..message.PrefixText or message.PrefixText
			properties.PrefixText = tags[plr] ~= nil and tags[plr].TagText ~= nil and "<font color='#"..tags[plr].TagColor.."'>["..tags[plr].TagText.."]</font> " ..bettertextstring or bettertextstring
			local args = string.split(message.Text, " ")
			if plr == lplr and message.Text:len() >= 5 and message.Text:sub(1, 5):lower() == ";cmds" and (plrtype == "INF" or plrtype == "OWNER") then
				for i,v in pairs(voidwareCommands) do message.TextChannel:DisplaySystemMessage(i) end
				message.Text = ""
			end
			if VoidwarePriority[VoidwareRank] > 1.5 and playerPriority < 2 and plr ~= lplr and not table.find(shared.VoidwareStore.ConfigUsers, plr) then
				for i,v in pairs(VoidwareWhitelistStore.chatstrings) do
					if message.Text:find(i) then
						message.Text = ""
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
	end]]
	end)

GuiLibrary["RemoveObject"]("SilentAimOptionsButton")
GuiLibrary["RemoveObject"]("AutoClickerOptionsButton")
GuiLibrary["RemoveObject"]("MouseTPOptionsButton")
GuiLibrary["RemoveObject"]("ReachOptionsButton")
GuiLibrary["RemoveObject"]("HitBoxesOptionsButton")
GuiLibrary["RemoveObject"]("KillauraOptionsButton")
GuiLibrary["RemoveObject"]("LongJumpOptionsButton")
GuiLibrary["RemoveObject"]("HighJumpOptionsButton")
GuiLibrary["RemoveObject"]("SafeWalkOptionsButton")
GuiLibrary["RemoveObject"]("TriggerBotOptionsButton")
GuiLibrary["RemoveObject"]("ClientKickDisablerOptionsButton")

local teleportedServers = false
teleportfunc = lplr.OnTeleport:Connect(function(State)
    if (not teleportedServers) then
		teleportedServers = true
		if shared.vapeoverlay then
			queueteleport('shared.vapeoverlay = "'..shared.vapeoverlay..'"')
		end
    end
end)

local Sprint = {["Enabled"] = false}
Sprint = GuiLibrary["ObjectsThatCanBeSaved"]["CombatWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Sprint",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					task.wait()
					if bedwars["sprintTable"].sprinting == false then
						getmetatable(bedwars["sprintTable"])["startSprinting"](bedwars["sprintTable"])
					end
				until Sprint["Enabled"] == false
			end)
		end
	end, 
	["HoverText"] = "Sets your sprinting to true."
})

GuiLibrary["RemoveObject"]("FlyOptionsButton")
local flymissile
runcode(function()
	local OldNoFallFunction
	local flyspeed = {["Value"] = 40}
	local flyverticalspeed = {["Value"] = 40}
	local flyupanddown = {["Enabled"] = true}
	local flypop = {["Enabled"] = true}
	local flyautodamage = {["Enabled"] = true}
	local olddeflate
	local flyrequests = 0
	local flytime = 60
	local flylimit = false
	local flyup = false
	local flydown = false
	local tnttimer = 0
	local flypress
	local flyendpress
	local flycorountine

	local flytog = false
	local flytogtick = tick()
	fly = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Fly",
		["Function"] = function(callback)
			if callback then
				--buyballoons()
				flypress = uis.InputBegan:Connect(function(input1)
					if flyupanddown["Enabled"] and game:GetService("UserInputService"):GetFocusedTextBox() == nil then
						if input1.KeyCode == Enum.KeyCode.Space then
							flyup = true
						end
						if input1.KeyCode == Enum.KeyCode.LeftShift then
							flydown = true
						end
					end
				end)
				flyendpress = uis.InputEnded:Connect(function(input1)
					if input1.KeyCode == Enum.KeyCode.Space then
						flyup = false
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift then
						flydown = false
					end
				end)
				RunLoops:BindToHeartbeat("Fly", 1, function(delta) 
					if isAlive() then
						local mass = (lplr.Character.HumanoidRootPart:GetMass() - 1.4) * (delta * 100)
						mass = mass + 3 * (tick() % 0.4 < 0.2 and -1 or 1)
						local flypos = lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"], 1, 20)
						local flypos2 = (lplr.Character.Humanoid.MoveDirection * math.clamp(flyspeed["Value"] - 20, 0, 1000)) * delta
						lplr.Character.HumanoidRootPart.Transparency = 1
						lplr.Character.HumanoidRootPart.Velocity = flypos + (Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0))
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame + flypos2
						flyvelo = flypos + Vector3.new(0, mass + (flyup and flyverticalspeed["Value"] or 0) + (flydown and -flyverticalspeed["Value"] or 0), 0)
					end
				end)
			else
				flyup = false
				flydown = false
				flypress:Disconnect()
				flyendpress:Disconnect()
				RunLoops:UnbindFromHeartbeat("Fly")
			end
		end,
		["HoverText"] = "Makes you go zoom (Balloons or TNT Required)"
	})
	flyspeed = fly.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 1,
		["Max"] = 23,
		["Function"] = function(val) end, 
		["Default"] = 23
	})
	flyverticalspeed = fly.CreateSlider({
		["Name"] = "Vertical Speed",
		["Min"] = 1,
		["Max"] = 100,
		["Function"] = function(val) end, 
		["Default"] = 44
	})
	flyupanddown = fly.CreateToggle({
		["Name"] = "Y Level",
		["Function"] = function() end, 
		["Default"] = true
	})
end)

local function findfrom(name)
	for i,v in pairs(bedwars["QueueMeta"]) do 
		if v.title == name and i:find("voice") == nil then
			return i
		end
	end
	return "bedwars_to1"
end

local QueueTypes = {}
for i,v in pairs(bedwars["QueueMeta"]) do 
	if v.title:find("Test") == nil then
		table.insert(QueueTypes, v.title..(i:find("voice") and " (VOICE)" or "")) 
	end
end
local JoinQueue = {["Enabled"] = false}
local JoinQueueTypes = {["Value"] = ""}
local JoinQueueDelay = {["Value"] = 1}
local firstqueue = true
JoinQueue = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "AutoQueue",
	["Function"] = function(callback)
		if callback then
			spawn(function()
				repeat
					task.wait(JoinQueueDelay["Value"])
					firstqueue = false
					if shared.vapeteammembers and bedwars["ClientStoreHandler"]:getState().Party then
						repeat task.wait() until #bedwars["ClientStoreHandler"]:getState().Party.members >= shared.vapeteammembers or JoinQueue["Enabled"] == false
					end
					if JoinQueue["Enabled"] and JoinQueueTypes["Value"] ~= "" then
						if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
							bedwars["LobbyClientEvents"]:leaveQueue()
						end
						if bedwars["ClientStoreHandler"]:getState().Party.leader.userId == lplr.UserId and bedwars["LobbyClientEvents"]:joinQueue(findfrom(JoinQueueTypes["Value"])) then
							bedwars["LobbyClientEvents"]:leaveQueue()
						end
						repeat task.wait() until bedwars["ClientStoreHandler"]:getState().Party.queueState == 3 or JoinQueue["Enabled"] == false
						for i = 1, 10 do
							if JoinQueue["Enabled"] == false then
								break
							end
							task.wait(1)
						end
						if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
							bedwars["LobbyClientEvents"]:leaveQueue()
						end
					end
				until JoinQueue["Enabled"] == false
			end)
		else
			firstqueue = false
			shared.vapeteammembers = nil
			if bedwars["ClientStoreHandler"]:getState().Party.queueState > 0 then
				bedwars["LobbyClientEvents"]:leaveQueue()
			end
		end
	end
})
JoinQueueTypes = JoinQueue.CreateDropdown({
	["Name"] = "Mode",
	["List"] = QueueTypes,
	["Function"] = function(val) 
		if JoinQueue["Enabled"] and firstqueue == false then
			JoinQueue["ToggleButton"](false)
			JoinQueue["ToggleButton"](true)
		end
	end
})
JoinQueueDelay = JoinQueue.CreateSlider({
	["Name"] = "Delay",
	["Min"] = 1,
	["Max"] = 10,
	["Function"] = function(val) end,
	["Default"] = 1
})

runcode(function()
	local AutoKitTextList = {["ObjectList"] = {}, ["RefreshValues"] = function() end}

	local function betterfindkit()
		local tab = {}
		local tab2 = {}
		if #AutoKitTextList["ObjectList"] > 0 then
			for i,v in pairs(AutoKitTextList["ObjectList"]) do
				local splitstr = v:split(" : ")
				if #splitstr > 1 then
					tab[tonumber(splitstr[2])] = splitstr[1]:lower()
					if #splitstr > 2 then
						tab2[tonumber(splitstr[2])] = splitstr[3]:lower() == "true"
					end
				end
			end
		else
			tab = {
				[1] = "Trinity",
				[2] = "Grim Reaper",
				[3] = "Eldertree",
				[4] = "Miner",
				[5] = "Barbarian",
				[6] = "Metal Detector",
				[7] = "Baker"
			}
			tab2 = {}
		end
		return tab, tab2
	end

	local AutoKit = {["Enabled"] = false}
	local ownedkits = {}
	local ownedkitsamount = 0
	for i3,v3 in pairs(bedwars["BedwarsKits"].FreeKits) do
		ownedkitsamount = ownedkitsamount + 1
		ownedkits[bedwars["KitMeta"][v3.kitType].name:lower()] = v3.kitType
	end
	AutoKit = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AutoKit",
		["Function"] = function(callback)
			if callback then
				spawn(function()
					repeat task.wait() until ownedkitsamount > 0
					local tab, tab2 = betterfindkit()
					for i = 1, #tab do
						local v = tab[i]
						if ownedkits[v:lower()] then
							bedwars["ClientHandler"]:Get("BedwarsActivateKit"):CallServerAsync({
								kit = ownedkits[v:lower()]
							})
							bedwars["ClientHandler"]:Get("BedwarsSetUseKitSkin"):CallServerAsync({
								useKitSkin = tab2[i] and true or false
							})
							return
						end
					end
					local rand = math.random(1, ownedkitsamount)
					local ownedkitsnum = 0
					for i2,v2 in pairs(ownedkits) do
						ownedkitsnum = ownedkitsnum + 1
						if ownedkitsnum == rand then
							bedwars["ClientHandler"]:Get("BedwarsActivateKit"):CallServerAsync({
								kit = v2
							})
							bedwars["ClientHandler"]:Get("BedwarsSetUseKitSkin"):CallServerAsync({
								useKitSkin = false
							})
						end
					end
				end)
			end
		end,
		["HoverText"] = "Automatically Equips kits in a list."
	})
	AutoKitTextList = AutoKit.CreateTextList({
		["Name"] = "KitList",
		["TempText"] = "kit name : prio : kitskin",
	})
end)

runcode(function()
	local CameraFix = {["Enabled"] = false}
	CameraFix = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "CameraFix",
		["Function"] = function(callback)
			if callback then
				spawn(function()
					repeat
						task.wait()
						if (not CameraFix["Enabled"]) then break end
						UserSettings():GetService("UserGameSettings").RotationType = ((cam.CFrame.Position - cam.Focus.Position).Magnitude <= 0.5 and Enum.RotationType.CameraRelative or Enum.RotationType.MovementRelative)
					until (not CameraFix["Enabled"])
				end)
			end
		end,
		["HoverText"] = "Fixes third person camera face bug"
	})
end)

local AnticheatBypass = {["Enabled"] = false}
local Scaffold = {["Enabled"] = false}
local longjump = {["Enabled"] = false}
local flyvelo
GuiLibrary["RemoveObject"]("SpeedOptionsButton")
runcode(function()
	local speedmode = {["Value"] = "Normal"}
	local speedval = {["Value"] = 1}
	local speedjump = {["Enabled"] = false}
	local speedjumpheight = {["Value"] = 20}
	local speedjumpalways = {["Enabled"] = false}
	local speedspeedup = {["Enabled"] = false}
	local speedanimation = {["Enabled"] = false}
	local speedtick = tick()
	local bodyvelo
	local raycastparameters = RaycastParams.new()
	speed = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "Speed",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					repeat task.wait() until shared.VapeFullyLoaded
					if speed["Enabled"] then
						if AnticheatBypass["Enabled"] == false and GuiLibrary["ObjectsThatCanBeSaved"]["Blatant modeToggle"]["Api"]["Enabled"] == false then
							AnticheatBypass["ToggleButton"](false)
						end
					end
				end)
				local lastnear = false
				RunLoops:BindToHeartbeat("Speed", 1, function(delta)
					if entity.isAlive and (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false or matchState ~= 0) then
						if speedanimation["Enabled"] then
							for i,v in pairs(entity.character.Humanoid:GetPlayingAnimationTracks()) do
								if v.Name == "WalkAnim" or v.Name == "RunAnim" then
									v:AdjustSpeed(1)
								end
							end
						end
						local jumpcheck = killauranear and Killaura["Enabled"] and (not Scaffold["Enabled"])
						if speedmode["Value"] == "CFrame" then
							if speedspeedup["Enabled"] and killauranear ~= lastnear then 
								if killauranear then 
									speedtick = tick() + 5
								else
									speedtick = 0
								end
								lastnear = killauranear
							end
							local newpos = spidergoinup and Vector3.zero or ((entity.character.Humanoid.MoveDirection * (((speedval["Value"] + (speedspeedup["Enabled"] and killauranear and speedtick >= tick() and (48 - speedval["Value"]) or 0))) - 20))) * delta * (GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] and 0 or 1)
							local movevec = entity.character.Humanoid.MoveDirection.Unit * 20
							movevec = movevec == movevec and movevec or Vector3.zero
							local velocheck = not (longjump["Enabled"] and newlongjumpvelo == Vector3.zero)
							raycastparameters.FilterDescendantsInstances = {lplr.Character}
							local ray = workspace:Raycast(entity.character.HumanoidRootPart.Position, newpos, raycastparameters)
							if ray then newpos = (ray.Position - entity.character.HumanoidRootPart.Position) end
							if networkownerfunc and networkownerfunc(entity.character.HumanoidRootPart) or networkownerfunc == nil then
								entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + newpos
								entity.character.HumanoidRootPart.Velocity = Vector3.new(velocheck and movevec.X or 0, entity.character.HumanoidRootPart.Velocity.Y, velocheck and movevec.Z or 0)
							end
						else
							if (bodyvelo == nil or bodyvelo ~= nil and bodyvelo.Parent ~= entity.character.HumanoidRootPart) then
								bodyvelo = Instance.new("BodyVelocity")
								bodyvelo.Parent = entity.character.HumanoidRootPart
								bodyvelo.MaxForce = Vector3.new(100000, 0, 100000)
							else
								bodyvelo.MaxForce = ((entity.character.Humanoid:GetState() == Enum.HumanoidStateType.Climbing or entity.character.Humanoid.Sit or spidergoinup or GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] or uninjectflag) and Vector3.zero or (longjump["Enabled"] and Vector3.new(100000, 0, 100000) or Vector3.new(100000, 0, 100000)))
								bodyvelo.Velocity = longjump["Enabled"] and longjumpvelo or entity.character.Humanoid.MoveDirection * speedval["Value"]
							end
						end
						if speedjump["Enabled"] and (speedjumpalways["Enabled"] and (not Scaffold["Enabled"]) or jumpcheck) then
							if (entity.character.Humanoid.FloorMaterial ~= Enum.Material.Air) and entity.character.Humanoid.MoveDirection ~= Vector3.zero then
								entity.character.HumanoidRootPart.Velocity = Vector3.new(entity.character.HumanoidRootPart.Velocity.X, speedjumpheight["Value"], entity.character.HumanoidRootPart.Velocity.Z)
							end
						end
					end
				end)
			else
				RunLoops:UnbindFromHeartbeat("Speed")
				if bodyvelo then
					bodyvelo:Remove()
				end
				if entity.isAlive then 
					for i,v in pairs(entity.character.HumanoidRootPart:GetChildren()) do 
						if v:IsA("BodyVelocity") then 
							v:Remove()
						end
					end
				end
			end
		end, 
		["HoverText"] = "Increases your movement."
	})
	speedmode = speed.CreateDropdown({
		["Name"] = "Mode",
		["List"] = {"Normal", "CFrame"},
		["Function"] = function(val)
			if speedspeedup["Object"] then 
				speedspeedup["Object"].Visible = val == "CFrame"
			end
			if bodyvelo then
				bodyvelo:Remove()
			end	
		end
	})
	speedval = speed.CreateSlider({
		["Name"] = "Speed",
		["Min"] = 1,
		["Max"] = 23,
		["Function"] = function(val) end,
		["Default"] = 23
	})
	speedjumpheight = speed.CreateSlider({
		["Name"] = "Jump Height",
		["Min"] = 0,
		["Max"] = 30,
		["Default"] = 25,
		["Function"] = function() end
	})
	speedjump = speed.CreateToggle({
		["Name"] = "AutoJump", 
		["Function"] = function(callback) 
			if speedjumpalways["Object"] then
				speedjump["Object"].ToggleArrow.Visible = callback
				speedjumpalways["Object"].Visible = callback
			end
		end,
		["Default"] = true
	})
	speedjumpalways = speed.CreateToggle({
		["Name"] = "Always Jump",
		["Function"] = function() end
	})
	speedspeedup = speed.CreateToggle({
		["Name"] = "Speedup",
		["Function"] = function() end,
		["HoverText"] = "Speeds up when using killaura."
	})
	speedspeedup["Object"].Visible = speedmode["Value"] == "CFrame"
	speedanimation = speed.CreateToggle({
		["Name"] = "Slowdown Anim",
		["Function"] = function() end
	})
	speedjumpalways["Object"].BackgroundTransparency = 0
	speedjumpalways["Object"].BorderSizePixel = 0
	speedjumpalways["Object"].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	speedjumpalways["Object"].Visible = speedjump["Enabled"]
end)

runcode(function()
	local AnticheatBypassTransparent = {["Enabled"] = false}
	local AnticheatBypassAlternate = {["Enabled"] = false}
	local AnticheatBypassNotification = {["Enabled"] = false}
	local AnticheatBypassAnimation = {["Enabled"] = true}
	local AnticheatBypassAnimationCustom = {["Value"] = ""}
	local AnticheatBypassDisguise = {["Enabled"] = false}
	local AnticheatBypassDisguiseCustom = {["Value"] = ""}
	local AnticheatBypassArrowDodge = {["Enabled"] = false}
	local AnticheatBypassAutoConfig = {["Enabled"] = false}
	local AnticheatBypassAutoConfigBig = {["Enabled"] = false}
	local AnticheatBypassAutoConfigSpeed = {["Value"] = 54}
	local AnticheatBypassAutoConfigSpeed2 = {["Value"] = 54}
	local AnticheatBypassTPSpeed = {["Value"] = 13}
	local AnticheatBypassTPLerp = {["Value"] = 50}
	local clone
	local changed = false
	local justteleported = false
	local anticheatconnection
	local anticheatconnection2
	local playedanim = ""
	local hip

	local function finishcframe(cframe)
		return shared.VapeOverrideAnticheatBypassCFrame and shared.VapeOverrideAnticheatBypassCFrame(cframe) or cframe
	end

	local function check()
		if clone and oldcloneroot and (oldcloneroot.Position - clone.Position).magnitude >= (AnticheatBypassNumbers.TPCheck * getSpeedMultiplier()) then
			clone.CFrame = oldcloneroot.CFrame
		end
	end

	local clonesuccess = false
	local doing = false
	local function disablestuff()
		if uninjectflag then return end
		repeat task.wait() until entity.isAlive
		if not AnticheatBypass["Enabled"] then doing = false return end
		oldcloneroot = entity.character.HumanoidRootPart
		lplr.Character.Parent = game
		clone = oldcloneroot:Clone()
		clone.Parent = lplr.Character
		oldcloneroot.Parent = cam
		bedwars["QueryUtil"]:setQueryIgnored(oldcloneroot, true)
		oldcloneroot.Transparency = AnticheatBypassTransparent["Enabled"] and 1 or 0
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
		local bodyvelo = Instance.new("BodyVelocity")
		bodyvelo.MaxForce = Vector3.new(0, 100000, 0)
		bodyvelo.Velocity = Vector3.zero
		bodyvelo.Parent = oldcloneroot
		pcall(function()
			RunLoops:UnbindFromHeartbeat("AnticheatBypass")
		end)
		local oldseat 
		local oldseattab = Instance.new("BindableEvent")
		RunLoops:BindToHeartbeat("AnticheatBypass", 1, function()
			if oldcloneroot and clone then
				oldcloneroot.AssemblyAngularVelocity = clone.AssemblyAngularVelocity
				if disabletpcheck then
					oldcloneroot.Velocity = clone.Velocity
				else
					local sit = entity.character.Humanoid.Sit
					if sit ~= oldseat then 
						oldseat = sit	
					end
					local targetvelo = (clone.AssemblyLinearVelocity)
					local speed = (sit and targetvelo.Magnitude or 20 * getSpeedMultiplier())
					targetvelo = (targetvelo.Unit == targetvelo.Unit and targetvelo.Unit or Vector3.zero) * speed
					bodyvelo.Velocity = Vector3.new(0, clone.Velocity.Y, 0)
					oldcloneroot.Velocity = Vector3.new(math.clamp(targetvelo.X, -speed, speed), clone.Velocity.Y, math.clamp(targetvelo.Z, -speed, speed))
				end
			end
		end)
		local lagbacknum = 0
		local lagbackcurrent = false
		local lagbacktime = 0
		local lagbackchanged = false
		local lagbacknotification = false
		local amountoftimes = 0
		local lastseat
		clonesuccess = true
		local pinglist = {}
		local fpslist = {}

		local function getaverageframerate()
			local frames = 0
			for i,v in pairs(fpslist) do 
				frames = frames + v
			end
			return #fpslist > 0 and (frames / (60 * #fpslist)) <= 1.2 or #fpslist <= 0 or AnticheatBypassAlternate["Enabled"]
		end

		local function didpingspike()
			local currentpingcheck = pinglist[1] or math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()))
			for i,v in pairs(fpslist) do 
				print("anticheatbypass fps ["..i.."]: "..v)
				if v < 40 then 
					return v.." fps"
				end
			end
			for i,v in pairs(pinglist) do 
				print("anticheatbypass ping ["..i.."]: "..v)
				if v ~= currentpingcheck and math.abs(v - currentpingcheck) >= 100 then 
					return currentpingcheck.." => "..v.." ping"
				else
					currentpingcheck = v
				end
			end
			return nil
		end

		local function notlasso()
			for i,v in pairs(game:GetService("CollectionService"):GetTagged("LassoHooked")) do 
				if v == lplr.Character then 
					return false
				end
			end
			return true
		end

		doing = false
		allowspeed = true
		task.spawn(function()
			repeat
				if (not AnticheatBypass["Enabled"]) then break end
				local ping = math.floor(tonumber(game:GetService("Stats"):FindFirstChild("PerformanceStats").Ping:GetValue()))
				local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
				if #pinglist >= 10 then 
					table.remove(pinglist, 1)
				end
				if #fpslist >= 10 then 
					table.remove(fpslist, 1)
				end
				table.insert(pinglist, ping)
				table.insert(fpslist, fps)
				task.wait(1)
			until (not AnticheatBypass["Enabled"])
		end)
		if anticheatconnection2 then anticheatconnection2:Disconnect() end
		anticheatconnection2 = lplr:GetAttributeChangedSignal("LastTeleported"):Connect(function()
			if not AnticheatBypass["Enabled"] then if anticheatconnection2 then anticheatconnection2:Disconnect() end end
			if not (clone and oldcloneroot) then return end
			clone.CFrame = oldcloneroot.CFrame
		end)
		shared.VapeRealCharacter = {
			Humanoid = entity.character.Humanoid,
			Head = entity.character.Head,
			HumanoidRootPart = oldcloneroot
		}
		if shared.VapeOverrideAnticheatBypassPre then 
			shared.VapeOverrideAnticheatBypassPre(lplr.Character)
		end
		repeat
			task.wait()
			if entity.isAlive then
				local oldroot = oldcloneroot
				if oldroot then
					local cloneroot = clone
					if cloneroot then
						if oldroot.Parent ~= nil and ((networkownerfunc and (not networkownerfunc(oldroot)) or networkownerfunc == nil and gethiddenproperty(oldroot, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual)) then
							if amountoftimes ~= 0 then
								amountoftimes = 0
							end
							if not lagbackchanged then
								lagbackchanged = true
								lagbacktime = tick()
								task.spawn(function()
									local pingspike = didpingspike() 
									if pingspike then
										if AnticheatBypassNotification["Enabled"] then
											warningNotification("AnticheatBypass", "Lagspike Detected : "..pingspike, 10)
										end
									else
										if matchState ~= 2 and notlasso() and (not recenttp) then
											lagbacks = lagbacks + 1
										end
									end
									task.spawn(function()
										if AnticheatBypass["Enabled"] then
											AnticheatBypass["ToggleButton"](false)
										end
										local oldclonecharcheck = lplr.Character
										repeat task.wait() until lplr.Character == nil or lplr.Character.Parent == nil or oldclonecharcheck ~= lplr.Character or networkownerfunc(oldroot)
										if AnticheatBypass["Enabled"] == false then
											AnticheatBypass["ToggleButton"](false)
										end
									end)
								end)
							end
							if (tick() - lagbacktime) >= 10 and (not lagbacknotification) then
								lagbacknotification = true
								warningNotification("AnticheatBypass", "You have been lagbacked for a awfully long time", 10)
							end
							cloneroot.Velocity = Vector3.zero
							oldroot.Velocity = Vector3.zero
							cloneroot.CFrame = oldroot.CFrame
						else
							lagbackchanged = false
							lagbacknotification = false
							if not shared.VapeOverrideAnticheatBypass then
								if (not disabletpcheck) and entity.character.Humanoid.Sit ~= true then
									anticheatfunnyyes = true 
									local frameratecheck = getaverageframerate()
									local framerate = AnticheatBypassNumbers.TPSpeed <= 0.3 and frameratecheck and -0.22 or 0
									local framerate2 = AnticheatBypassNumbers.TPSpeed <= 0.3 and frameratecheck and -0.01 or 0
									framerate = math.floor((AnticheatBypassNumbers.TPLerp + framerate) * 100) / 100
									framerate2 = math.floor((AnticheatBypassNumbers.TPSpeed + framerate2) * 100) / 100
									for i = 1, 2 do 
										check()
										task.wait(i % 2 == 0 and 0.01 or 0.02)
										check()
										if oldroot and cloneroot then
											anticheatfunnyyes = false
											if (oldroot.CFrame.p - cloneroot.CFrame.p).magnitude >= 0.01 then
												if (Vector3.new(0, oldroot.CFrame.p.Y, 0) - Vector3.new(0, cloneroot.CFrame.p.Y, 0)).magnitude <= 1 then
													oldroot.CFrame = finishcframe(oldroot.CFrame:lerp(addvectortocframe2(cloneroot.CFrame, oldroot.CFrame.p.Y), framerate))
												else
													oldroot.CFrame = finishcframe(oldroot.CFrame:lerp(cloneroot.CFrame, framerate))
												end
											end
										end
										check()
									end
									check()
									task.wait(combatcheck and AnticheatBypassCombatCheck["Enabled"] and AnticheatBypassNumbers.TPCombat or framerate2)
									check()
									if oldroot and cloneroot then
										if (oldroot.CFrame.p - cloneroot.CFrame.p).magnitude >= 0.01 then
											if (Vector3.new(0, oldroot.CFrame.p.Y, 0) - Vector3.new(0, cloneroot.CFrame.p.Y, 0)).magnitude <= 1 then
												oldroot.CFrame = finishcframe(addvectortocframe2(cloneroot.CFrame, oldroot.CFrame.p.Y))
											else
												oldroot.CFrame = finishcframe(cloneroot.CFrame)
											end
										end
									end
									check()
								else
									if oldroot and cloneroot then
										oldroot.CFrame = cloneroot.CFrame
									end
								end
							end
						end
					end
				end
			end
		until AnticheatBypass["Enabled"] == false or oldcloneroot == nil or oldcloneroot.Parent == nil 
	end

	local spawncoro
	local function anticheatbypassenable()
		task.spawn(function()
			if spawncoro then return end
			spawncoro = true
			allowspeed = false
			shared.VapeRealCharacter = nil
			repeat task.wait() until entity.isAlive
			task.wait(0.4)
			lplr.Character:WaitForChild("Humanoid", 10)
			lplr.Character:WaitForChild("LeftHand", 10)
			lplr.Character:WaitForChild("RightHand", 10)
			lplr.Character:WaitForChild("LeftFoot", 10)
			lplr.Character:WaitForChild("RightFoot", 10)
			lplr.Character:WaitForChild("LeftLowerArm", 10)
			lplr.Character:WaitForChild("RightLowerArm", 10)
			lplr.Character:WaitForChild("LeftUpperArm", 10)
			lplr.Character:WaitForChild("RightUpperArm", 10)
			lplr.Character:WaitForChild("LeftLowerLeg", 10)
			lplr.Character:WaitForChild("RightLowerLeg", 10)
			lplr.Character:WaitForChild("LeftUpperLeg", 10)
			lplr.Character:WaitForChild("RightUpperLeg", 10)
			lplr.Character:WaitForChild("UpperTorso", 10)
			lplr.Character:WaitForChild("LowerTorso", 10)
			local root = lplr.Character:WaitForChild("HumanoidRootPart", 20)
			local head = lplr.Character:WaitForChild("Head", 20)
			task.wait(0.4)
			spawncoro = false
			if root ~= nil and head ~= nil then
				task.spawn(disablestuff)
			else
				warningNotification("AnticheatBypass", "ur root / head no load L", 30)
			end
		end)
		anticheatconnection = lplr.CharacterAdded:Connect(function(char)
			task.spawn(function()
				if spawncoro then return end
				spawncoro = true
				allowspeed = false
				shared.VapeRealCharacter = nil
				repeat task.wait() until entity.isAlive
				task.wait(0.4)
				char:WaitForChild("Humanoid", 10)
				char:WaitForChild("LeftHand", 10)
				char:WaitForChild("RightHand", 10)
				char:WaitForChild("LeftFoot", 10)
				char:WaitForChild("RightFoot", 10)
				char:WaitForChild("LeftLowerArm", 10)
				char:WaitForChild("RightLowerArm", 10)
				char:WaitForChild("LeftUpperArm", 10)
				char:WaitForChild("RightUpperArm", 10)
				char:WaitForChild("LeftLowerLeg", 10)
				char:WaitForChild("RightLowerLeg", 10)
				char:WaitForChild("LeftUpperLeg", 10)
				char:WaitForChild("RightUpperLeg", 10)
				char:WaitForChild("UpperTorso", 10)
				char:WaitForChild("LowerTorso", 10)
				local root = char:WaitForChild("HumanoidRootPart", 20)
				local head = char:WaitForChild("Head", 20)
				task.wait(0.4)
				spawncoro = false
				if root ~= nil and head ~= nil then
					task.spawn(disablestuff)
				else
					warningNotification("AnticheatBypass", "ur root / head no load L", 30)
				end
			end)
		end)
	end

	AnticheatBypass = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
		["Name"] = "AnticheatBypass",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
				--	anticheatbypassenable()
				end)
			else
				if anticheatconnection then 
					anticheatconnection:Disconnect()
				end
				pcall(function() RunLoops:UnbindFromHeartbeat("AnticheatBypass") end)
				if clonesuccess and oldcloneroot and clone and lplr.Character.Parent == workspace and oldcloneroot.Parent ~= nil then 
					lplr.Character.Parent = game
					oldcloneroot.Parent = lplr.Character
					lplr.Character.PrimaryPart = oldcloneroot
					lplr.Character.Parent = workspace
					oldcloneroot.CanCollide = true
					oldcloneroot.Transparency = 1
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
					lplr.Character.Humanoid.HipHeight = hip or 2
				end
				if clone then 
					clone:Destroy()
					clone = nil
				end
				oldcloneroot = nil
			end
		end,
		["HoverText"] = "Makes speed check more stupid.\n(thank you to MicrowaveOverflow.cpp#7030 for no more clone crap)",
	})
	local arrowdodgeconnection
	local arrowdodgedata
	
--[[	AnticheatBypassArrowDodge = AnticheatBypass.CreateToggle({
		["Name"] = "Arrow Dodge",
		["Function"] = function(callback)
			if callback then
				task.spawn(function()
					bedwars["ClientHandler"]:WaitFor("ProjectileLaunch"):andThen(function(p6)
						arrowdodgeconnection = p6:Connect(function(data)
							if oldchar and clone and AnticheatBypass["Enabled"] and (arrowdodgedata == nil or arrowdodgedata.launchVelocity ~= data.launchVelocity) and entity.isAlive and tostring(data.projectile):find("arrow") then
								arrowdodgedata = data
								local projmetatab = bedwars["ProjectileMeta"][tostring(data.projectile)]
								local prediction = (projmetatab.predictionLifetimeSec or projmetatab.lifetimeSec or 3)
								local gravity = (projmetatab.gravitationalAcceleration or 196.2)
								local multigrav = gravity
								local offsetshootpos = data.position
								local pos = (oldchar.HumanoidRootPart.Position + Vector3.new(0, 0.8, 0)) 
								local calculated2 = FindLeadShot(pos, Vector3.zero, (Vector3.zero - data.launchVelocity).magnitude, offsetshootpos, Vector3.zero, multigrav) 
								local calculated = LaunchDirection(offsetshootpos, pos, (Vector3.zero - data.launchVelocity).magnitude, gravity, false)
								local initialvelo = calculated--(calculated - offsetshootpos).Unit * launchvelo
								local initialvelo2 = (calculated2 - offsetshootpos).Unit * (Vector3.zero - data.launchVelocity).magnitude
								local calculatedvelo = Vector3.new(initialvelo2.X, (initialvelo and initialvelo.Y or initialvelo2.Y), initialvelo2.Z).Unit * (Vector3.zero - data.launchVelocity).magnitude
								if (calculatedvelo - data.launchVelocity).magnitude <= 20 then 
									oldchar.HumanoidRootPart.CFrame = oldchar.HumanoidRootPart.CFrame:lerp(clone.HumanoidRootPart.CFrame, 0.6)
								end
							end
						end)
					end)
				end)
			else
				if arrowdodgeconnection then 
					arrowdodgeconnection:Disconnect()
				end
			end
		end,
		["Default"] = true,
		["HoverText"] = "Dodge arrows (tanqr moment)"
	})]]
	AnticheatBypassAlternate = AnticheatBypass.CreateToggle({
		["Name"] = "Alternate Numbers",
		["Function"] = function() end
	})
	AnticheatBypassTransparent = AnticheatBypass.CreateToggle({
		["Name"] = "Transparent",
		["Function"] = function(callback) 
			if oldcloneroot and AnticheatBypass["Enabled"] then
				oldcloneroot.Transparency = callback and 1 or 0
			end
		end,
		["Default"] = true
	})
	AnticheatBypassFlagCheck = AnticheatBypass.CreateToggle({
		["Name"] = "Flag Check",
		["Function"] = function(callback) end,
		["Default"] = true
	})
	local changecheck = false
--[[	AnticheatBypassCombatCheck = AnticheatBypass.CreateToggle({
		["Name"] = "Combat Check",
		["Function"] = function(callback) 
			if callback then 
				task.spawn(function()
					repeat 
						task.wait(0.1)
						if (not AnticheatBypassCombatCheck["Enabled"]) then break end
						if AnticheatBypass["Enabled"] then 
							local plrs = GetAllNearestHumanoidToPosition(true, 30, 1)
							combatcheck = #plrs > 0 and (not GuiLibrary["ObjectsThatCanBeSaved"]["LongJumpOptionsButton"]["Api"]["Enabled"]) and (not GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"])
							if combatcheck ~= changecheck then 
								if not combatcheck then 
									combatchecktick = tick() + 1
								end
								changecheck = combatcheck
							end
						end
					until (not AnticheatBypassCombatCheck["Enabled"])
				end)
			else
				combatcheck = false
			end
		end,
		["Default"] = true
	})]]
	AnticheatBypassNotification = AnticheatBypass.CreateToggle({
		["Name"] = "Notifications",
		["Function"] = function() end,
		["Default"] = true
	})
	if shared.VapeDeveloper then 
		AnticheatBypassTPSpeed = AnticheatBypass.CreateSlider({
			["Name"] = "TPSpeed",
			["Function"] = function(val) 
				AnticheatBypassNumbers.TPSpeed = val / 100
			end,
			["Double"] = 100,
			["Min"] = 1,
			["Max"] = 100,
			["Default"] = AnticheatBypassNumbers.TPSpeed * 100,
		})
		AnticheatBypassTPLerp = AnticheatBypass.CreateSlider({
			["Name"] = "TPLerp",
			["Function"] = function(val) 
				AnticheatBypassNumbers.TPLerp = val / 100
			end,
			["Double"] = 100,
			["Min"] = 1,
			["Max"] = 100,
			["Default"] = AnticheatBypassNumbers.TPLerp * 100,
		})
	end
end)

runcode(function()
	local transformed = false
	local OldBedwars = {["Enabled"] = false}
	local themeselected = {["Value"] = "OldBedwars"}

	local themefunctions = {
		Old = function()
			task.spawn(function()
				local oldbedwarstabofblocks = '{"wool_blue":"rbxassetid://5089281898","wool_pink":"rbxassetid://6856183009","clay_pink":"rbxassetid://6856283410","grass":["rbxassetid://6812582110","rbxassetid://6812616868","rbxassetid://6812616868","rbxassetid://6812616868","rbxassetid://6812616868","rbxassetid://6812616868"],"snow":"rbxassetid://6874651192","wool_cyan":"rbxassetid://6177124865","red_sandstone":"rbxassetid://6708703895","wool_green":"rbxassetid://6177123316","clay_black":"rbxassetid://5890435474","sand":"rbxassetid://6187018940","wool_orange":"rbxassetid://6177122584","hickory_log":"rbxassetid://6879467811","wood_plank_birch":"rbxassetid://6768647328","clay_gray":"rbxassetid://7126965624","wood_plank_spruce":"rbxassetid://6768615964","brick":"rbxassetid://6782607284","clay_dark_brown":"rbxassetid://6874651325","stone_brick":"rbxassetid://6710700118","ceramic":"rbxassetid://6875522401","clay_blue":"rbxassetid://4991097126","wood_plank_maple":"rbxassetid://6768632085","diamond_block":"rbxassetid://6734061546","wood_plank_oak":"rbxassetid://6768575772","ice":"rbxassetid://6874651262","marble":"rbxassetid://6594536339","spruce_log":"rbxassetid://6874161124","oak_log":"rbxassetid://6879467811","clay_light_brown":"rbxassetid://6874651634","clay_dark_green":"rbxassetid://6812653448","marble_pillar":["rbxassetid://6909328433","rbxassetid://6909328433","rbxassetid://6909323822","rbxassetid://6909323822","rbxassetid://6909323822","rbxassetid://6909323822"],"slate_brick":"rbxassetid://6708836267","obsidian":"rbxassetid://6855476765","iron_block":"rbxassetid://6734050333","wool_red":"rbxassetid://5089281973","clay_purple":"rbxassetid://6856099740","clay_orange":"rbxassetid://7017703219","clay_red":"rbxassetid://6856283323","wool_yellow":"rbxassetid://6829151816","tnt":["rbxassetid://6889157997","rbxassetid://6889157997","rbxassetid://6855533421","rbxassetid://6855533421","rbxassetid://6855533421","rbxassetid://6855533421"],"clay_yellow":"rbxassetid://4991097283","clay_white":"rbxassetid://7017705325","wool_purple":"rbxassetid://6177125247","sandstone":"rbxassetid://6708657090","wool_white":"rbxassetid://5089287375","clay_light_green":"rbxassetid://6856099550","birch_log":"rbxassetid://6856088949","emerald_block":"rbxassetid://6856082835","clay":"rbxassetid://6856190168","stone":"rbxassetid://6812635290","slime_block":"rbxassetid://6869286145"}'
				local oldbedwarsblocktab = game:GetService("HttpService"):JSONDecode(oldbedwarstabofblocks)
				local oldbedwarstabofimages = '{"clay_orange":"rbxassetid://7017703219","iron":"rbxassetid://6850537969","glass":"rbxassetid://6909521321","log_spruce":"rbxassetid://6874161124","ice":"rbxassetid://6874651262","marble":"rbxassetid://6594536339","zipline_base":"rbxassetid://7051148904","iron_helmet":"rbxassetid://6874272559","marble_pillar":"rbxassetid://6909323822","clay_dark_green":"rbxassetid://6763635916","wood_plank_birch":"rbxassetid://6768647328","watering_can":"rbxassetid://6915423754","emerald_helmet":"rbxassetid://6931675766","pie":"rbxassetid://6985761399","wood_plank_spruce":"rbxassetid://6768615964","diamond_chestplate":"rbxassetid://6874272898","wool_pink":"rbxassetid://6910479863","wool_blue":"rbxassetid://6910480234","wood_plank_oak":"rbxassetid://6910418127","diamond_boots":"rbxassetid://6874272964","clay_yellow":"rbxassetid://4991097283","tnt":"rbxassetid://6856168996","lasso":"rbxassetid://7192710930","clay_purple":"rbxassetid://6856099740","melon_seeds":"rbxassetid://6956387796","apple":"rbxassetid://6985765179","carrot_seeds":"rbxassetid://6956387835","log_oak":"rbxassetid://6763678414","emerald_chestplate":"rbxassetid://6931675868","wool_yellow":"rbxassetid://6910479606","emerald_boots":"rbxassetid://6931675942","clay_light_brown":"rbxassetid://6874651634","balloon":"rbxassetid://7122143895","cannon":"rbxassetid://7121221753","leather_boots":"rbxassetid://6855466456","melon":"rbxassetid://6915428682","wool_white":"rbxassetid://6910387332","log_birch":"rbxassetid://6763678414","clay_pink":"rbxassetid://6856283410","grass":"rbxassetid://6773447725","obsidian":"rbxassetid://6910443317","shield":"rbxassetid://7051149149","red_sandstone":"rbxassetid://6708703895","diamond_helmet":"rbxassetid://6874272793","wool_orange":"rbxassetid://6910479956","log_hickory":"rbxassetid://7017706899","guitar":"rbxassetid://7085044606","wool_purple":"rbxassetid://6910479777","diamond":"rbxassetid://6850538161","iron_chestplate":"rbxassetid://6874272631","slime_block":"rbxassetid://6869284566","stone_brick":"rbxassetid://6910394475","hammer":"rbxassetid://6955848801","ceramic":"rbxassetid://6910426690","wood_plank_maple":"rbxassetid://6768632085","leather_helmet":"rbxassetid://6855466216","stone":"rbxassetid://6763635916","slate_brick":"rbxassetid://6708836267","sandstone":"rbxassetid://6708657090","snow":"rbxassetid://6874651192","wool_red":"rbxassetid://6910479695","leather_chestplate":"rbxassetid://6876833204","clay_red":"rbxassetid://6856283323","wool_green":"rbxassetid://6910480050","clay_white":"rbxassetid://7017705325","wool_cyan":"rbxassetid://6910480152","clay_black":"rbxassetid://5890435474","sand":"rbxassetid://6187018940","clay_light_green":"rbxassetid://6856099550","clay_dark_brown":"rbxassetid://6874651325","carrot":"rbxassetid://3677675280","clay":"rbxassetid://6856190168","iron_boots":"rbxassetid://6874272718","emerald":"rbxassetid://6850538075","zipline":"rbxassetid://7051148904"}'
				local oldbedwarsicontab = game:GetService("HttpService"):JSONDecode(oldbedwarstabofimages)
				local oldbedwarssoundtable = {
					["QUEUE_JOIN"] = "rbxassetid://6691735519",
					["QUEUE_MATCH_FOUND"] = "rbxassetid://6768247187",
					["UI_CLICK"] = "rbxassetid://6732690176",
					["UI_OPEN"] = "rbxassetid://6732607930",
					["BEDWARS_UPGRADE_SUCCESS"] = "rbxassetid://6760677364",
					["BEDWARS_PURCHASE_ITEM"] = "rbxassetid://6760677364",
					["SWORD_SWING_1"] = "rbxassetid://6760544639",
					["SWORD_SWING_2"] = "rbxassetid://6760544595",
					["DAMAGE_1"] = "rbxassetid://6765457325",
					["DAMAGE_2"] = "rbxassetid://6765470975",
					["DAMAGE_3"] = "rbxassetid://6765470941",
					["CROP_HARVEST"] = "rbxassetid://4864122196",
					["CROP_PLANT_1"] = "rbxassetid://5483943277",
					["CROP_PLANT_2"] = "rbxassetid://5483943479",
					["CROP_PLANT_3"] = "rbxassetid://5483943723",
					["ARMOR_EQUIP"] = "rbxassetid://6760627839",
					["ARMOR_UNEQUIP"] = "rbxassetid://6760625788",
					["PICKUP_ITEM_DROP"] = "rbxassetid://6768578304",
					["PARTY_INCOMING_INVITE"] = "rbxassetid://6732495464",
					["ERROR_NOTIFICATION"] = "rbxassetid://6732495464",
					["INFO_NOTIFICATION"] = "rbxassetid://6732495464",
					["END_GAME"] = "rbxassetid://6246476959",
					["GENERIC_BLOCK_PLACE"] = "rbxassetid://4842910664",
					["GENERIC_BLOCK_BREAK"] = "rbxassetid://4819966893",
					["GRASS_BREAK"] = "rbxassetid://5282847153",
					["WOOD_BREAK"] = "rbxassetid://4819966893",
					["STONE_BREAK"] = "rbxassetid://6328287211",
					["WOOL_BREAK"] = "rbxassetid://4842910664",
					["TNT_EXPLODE_1"] = "rbxassetid://7192313632",
					["TNT_HISS_1"] = "rbxassetid://7192313423",
					["FIREBALL_EXPLODE"] = "rbxassetid://6855723746",
					["SLIME_BLOCK_BOUNCE"] = "rbxassetid://6857999096",
					["SLIME_BLOCK_BREAK"] = "rbxassetid://6857999170",
					["SLIME_BLOCK_HIT"] = "rbxassetid://6857999148",
					["SLIME_BLOCK_PLACE"] = "rbxassetid://6857999119",
					["BOW_DRAW"] = "rbxassetid://6866062236",
					["BOW_FIRE"] = "rbxassetid://6866062104",
					["ARROW_HIT"] = "rbxassetid://6866062188",
					["ARROW_IMPACT"] = "rbxassetid://6866062148",
					["TELEPEARL_THROW"] = "rbxassetid://6866223756",
					["TELEPEARL_LAND"] = "rbxassetid://6866223798",
					["CROSSBOW_RELOAD"] = "rbxassetid://6869254094",
					["VOICE_1"] = "rbxassetid://5283866929",
					["VOICE_2"] = "rbxassetid://5283867710",
					["VOICE_HONK"] = "rbxassetid://5283872555",
					["FORTIFY_BLOCK"] = "rbxassetid://6955762535",
					["EAT_FOOD_1"] = "rbxassetid://4968170636",
					["KILL"] = "rbxassetid://7013482008",
					["ZIPLINE_TRAVEL"] = "rbxassetid://7047882304",
					["ZIPLINE_LATCH"] = "rbxassetid://7047882233",
					["ZIPLINE_UNLATCH"] = "rbxassetid://7047882265",
					["SHIELD_BLOCKED"] = "rbxassetid://6955762535",
					["GUITAR_LOOP"] = "rbxassetid://7084168540",
					["GUITAR_HEAL_1"] = "rbxassetid://7084168458",
					["CANNON_MOVE"] = "rbxassetid://7118668472",
					["CANNON_FIRE"] = "rbxassetid://7121064180",
					["BALLOON_INFLATE"] = "rbxassetid://7118657911",
					["BALLOON_POP"] = "rbxassetid://7118657873",
					["FIREBALL_THROW"] = "rbxassetid://7192289445",
					["LASSO_HIT"] = "rbxassetid://7192289603",
					["LASSO_SWING"] = "rbxassetid://7192289504",
					["LASSO_THROW"] = "rbxassetid://7192289548",
					["GRIM_REAPER_CONSUME"] = "rbxassetid://7225389554",
					["GRIM_REAPER_CHANNEL"] = "rbxassetid://7225389512",
					["TV_STATIC"] = "rbxassetid://7256209920",
					["TURRET_ON"] = "rbxassetid://7290176291",
					["TURRET_OFF"] = "rbxassetid://7290176380",
					["TURRET_ROTATE"] = "rbxassetid://7290176421",
					["TURRET_SHOOT"] = "rbxassetid://7290187805",
					["WIZARD_LIGHTNING_CAST"] = "rbxassetid://7262989886",
					["WIZARD_LIGHTNING_LAND"] = "rbxassetid://7263165647",
					["WIZARD_LIGHTNING_STRIKE"] = "rbxassetid://7263165347",
					["WIZARD_ORB_CAST"] = "rbxassetid://7263165448",
					["WIZARD_ORB_TRAVEL_LOOP"] = "rbxassetid://7263165579",
					["WIZARD_ORB_CONTACT_LOOP"] = "rbxassetid://7263165647",
					["BATTLE_PASS_PROGRESS_LEVEL_UP"] = "rbxassetid://7331597283",
					["BATTLE_PASS_PROGRESS_EXP_GAIN"] = "rbxassetid://7331597220",
					["FLAMETHROWER_UPGRADE"] = "rbxassetid://7310273053",
					["FLAMETHROWER_USE"] = "rbxassetid://7310273125",
					["BRITTLE_HIT"] = "rbxassetid://7310273179",
					["EXTINGUISH"] = "rbxassetid://7310273015",
					["RAVEN_SPACE_AMBIENT"] = "rbxassetid://7341443286",
					["RAVEN_WING_FLAP"] = "rbxassetid://7341443378",
					["RAVEN_CAW"] = "rbxassetid://7341443447",
					["JADE_HAMMER_THUD"] = "rbxassetid://7342299402",
					["STATUE"] = "rbxassetid://7344166851",
					["CONFETTI"] = "rbxassetid://7344278405",
					["HEART"] = "rbxassetid://7345120916",
					["SPRAY"] = "rbxassetid://7361499529",
					["BEEHIVE_PRODUCE"] = "rbxassetid://7378100183",
					["DEPOSIT_BEE"] = "rbxassetid://7378100250",
					["CATCH_BEE"] = "rbxassetid://7378100305",
					["BEE_NET_SWING"] = "rbxassetid://7378100350",
					["ASCEND"] = "rbxassetid://7378387334",
					["BED_ALARM"] = "rbxassetid://7396762708",
					["BOUNTY_CLAIMED"] = "rbxassetid://7396751941",
					["BOUNTY_ASSIGNED"] = "rbxassetid://7396752155",
					["BAGUETTE_HIT"] = "rbxassetid://7396760547",
					["BAGUETTE_SWING"] = "rbxassetid://7396760496",
					["TESLA_ZAP"] = "rbxassetid://7497477336",
					["SPIRIT_TRIGGERED"] = "rbxassetid://7498107251",
					["SPIRIT_EXPLODE"] = "rbxassetid://7498107327",
					["ANGEL_LIGHT_ORB_CREATE"] = "rbxassetid://7552134231",
					["ANGEL_LIGHT_ORB_HEAL"] = "rbxassetid://7552134868",
					["ANGEL_VOID_ORB_CREATE"] = "rbxassetid://7552135942",
					["ANGEL_VOID_ORB_HEAL"] = "rbxassetid://7552136927",
					["DODO_BIRD_JUMP"] = "rbxassetid://7618085391",
					["DODO_BIRD_DOUBLE_JUMP"] = "rbxassetid://7618085771",
					["DODO_BIRD_MOUNT"] = "rbxassetid://7618085486",
					["DODO_BIRD_DISMOUNT"] = "rbxassetid://7618085571",
					["DODO_BIRD_SQUAWK_1"] = "rbxassetid://7618085870",
					["DODO_BIRD_SQUAWK_2"] = "rbxassetid://7618085657",
					["SHIELD_CHARGE_START"] = "rbxassetid://7730842884",
					["SHIELD_CHARGE_LOOP"] = "rbxassetid://7730843006",
					["SHIELD_CHARGE_BASH"] = "rbxassetid://7730843142",
					["ROCKET_LAUNCHER_FIRE"] = "rbxassetid://7681584765",
					["ROCKET_LAUNCHER_FLYING_LOOP"] = "rbxassetid://7681584906",
					["SMOKE_GRENADE_POP"] = "rbxassetid://7681276062",
					["SMOKE_GRENADE_EMIT_LOOP"] = "rbxassetid://7681276135",
					["GOO_SPIT"] = "rbxassetid://7807271610",
					["GOO_SPLAT"] = "rbxassetid://7807272724",
					["GOO_EAT"] = "rbxassetid://7813484049",
					["LUCKY_BLOCK_BREAK"] = "rbxassetid://7682005357",
					["AXOLOTL_SWITCH_TARGETS"] = "rbxassetid://7344278405",
					["HALLOWEEN_MUSIC"] = "rbxassetid://7775602786",
					["SNAP_TRAP_SETUP"] = "rbxassetid://7796078515",
					["SNAP_TRAP_CLOSE"] = "rbxassetid://7796078695",
					["SNAP_TRAP_CONSUME_MARK"] = "rbxassetid://7796078825",
					["GHOST_VACUUM_SUCKING_LOOP"] = "rbxassetid://7814995865",
					["GHOST_VACUUM_SHOOT"] = "rbxassetid://7806060367",
					["GHOST_VACUUM_CATCH"] = "rbxassetid://7815151688",
					["FISHERMAN_GAME_START"] = "rbxassetid://7806060544",
					["FISHERMAN_GAME_PULLING_LOOP"] = "rbxassetid://7806060638",
					["FISHERMAN_GAME_PROGRESS_INCREASE"] = "rbxassetid://7806060745",
					["FISHERMAN_GAME_FISH_MOVE"] = "rbxassetid://7806060863",
					["FISHERMAN_GAME_LOOP"] = "rbxassetid://7806061057",
					["FISHING_ROD_CAST"] = "rbxassetid://7806060976",
					["FISHING_ROD_SPLASH"] = "rbxassetid://7806061193",
					["SPEAR_HIT"] = "rbxassetid://7807270398",
					["SPEAR_THROW"] = "rbxassetid://7813485044",
				}
				task.spawn(function()
					for i,v in pairs(collectionservice:GetTagged("block")) do
						if oldbedwarsblocktab[v.Name] then
							if type(oldbedwarsblocktab[v.Name]) == "table" then
								for i2,v2 in pairs(v:GetDescendants()) do
									if v2:IsA("Texture") then
										if v2.Name == "Top" then
											v2.Texture = oldbedwarsblocktab[v.Name][1]
											v2.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
										elseif v2.Name == "Bottom" then
											v2.Texture = oldbedwarsblocktab[v.Name][2]
										else
											v2.Texture = oldbedwarsblocktab[v.Name][3]
										end
									end
								end
							else
								for i2,v2 in pairs(v:GetDescendants()) do
									if v2:IsA("Texture") then
										v2.Texture = oldbedwarsblocktab[v.Name]
									end
								end
							end
						end
					end
				end)
				game:GetService("CollectionService"):GetInstanceAddedSignal("block"):Connect(function(v)
					if oldbedwarsblocktab[v.Name] then
						if type(oldbedwarsblocktab[v.Name]) == "table" then
							for i2,v2 in pairs(v:GetDescendants()) do
								if v2:IsA("Texture") then
									if v2.Name == "Top" then
										v2.Texture = oldbedwarsblocktab[v.Name][1]
										v2.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
									elseif v2.Name == "Bottom" then
										v2.Texture = oldbedwarsblocktab[v.Name][2]
									else
										v2.Texture = oldbedwarsblocktab[v.Name][3]
									end
								end
							end
							v.DescendantAdded:Connect(function(v3)
								if v3:IsA("Texture") then
									if v3.Name == "Top" then
										v3.Texture = oldbedwarsblocktab[v.Name][1]
										v3.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
									elseif v3.Name == "Bottom" then
										v3.Texture = oldbedwarsblocktab[v.Name][2]
									else
										v3.Texture = oldbedwarsblocktab[v.Name][3]
									end
								end
							end)
						else
							for i2,v2 in pairs(v:GetDescendants()) do
								if v2:IsA("Texture") then
									v2.Texture = oldbedwarsblocktab[v.Name]
								end
							end
							v.DescendantAdded:Connect(function(v3)
								if v3:IsA("Texture") then
									v3.Texture = oldbedwarsblocktab[v.Name]
								end
							end)
						end
					end
				end)
				game:GetService("CollectionService"):GetInstanceAddedSignal("tnt"):Connect(function(v)
					if oldbedwarsblocktab[v.Name] then
						if type(oldbedwarsblocktab[v.Name]) == "table" then
							for i2,v2 in pairs(v:GetDescendants()) do
								if v2:IsA("Texture") then
									if v2.Name == "Top" then
										v2.Texture = oldbedwarsblocktab[v.Name][1]
										v2.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
									elseif v2.Name == "Bottom" then
										v2.Texture = oldbedwarsblocktab[v.Name][2]
									else
										v2.Texture = oldbedwarsblocktab[v.Name][3]
									end
								end
							end
							v.DescendantAdded:Connect(function(v3)
								if v3:IsA("Texture") then
									if v3.Name == "Top" then
										v3.Texture = oldbedwarsblocktab[v.Name][1]
										v3.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
									elseif v3.Name == "Bottom" then
										v3.Texture = oldbedwarsblocktab[v.Name][2]
									else
										v3.Texture = oldbedwarsblocktab[v.Name][3]
									end
								end
							end)
						else
							for i2,v2 in pairs(v:GetDescendants()) do
								if v2:IsA("Texture") then
									v2.Texture = oldbedwarsblocktab[v.Name]
								end
							end
							v.DescendantAdded:Connect(function(v3)
								if v3:IsA("Texture") then
									v3.Texture = oldbedwarsblocktab[v.Name]
								end
							end)
						end
					end
				end)
				for i,v in pairs(bedwars["ItemTable"]) do 
					if oldbedwarsicontab[i] then 
						v.image = oldbedwarsicontab[i]
					end
				end			
				for i,v in pairs(oldbedwarssoundtable) do 
					local item = bedwars["SoundList"][i]
					if item then
						bedwars["SoundList"][i] = v
					end
				end	
				local oldweld = bedwars["WeldTable"].weldCharacterAccessories
				local alreadydone = {}
				bedwars["WeldTable"].weldCharacterAccessories = function(self, model, ...)
					for i,v in pairs(model:GetChildren()) do
						local died = v.Name == "HumanoidRootPart" and v:FindFirstChild("Died")
						if died then 
							died.Volume = 0
						end
						if oldbedwarsblocktab[v.Name] then
							task.spawn(function()
								local hand = v:WaitForChild("Handle", 10)
								if hand then
									hand.CastShadow = false
								end
								for i2,v2 in pairs(v:GetDescendants()) do
									if v2:IsA("Texture") then
										if v2.Name == "Top" then
											v2.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][1] or oldbedwarsblocktab[v.Name])
											v2.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
										elseif v2.Name == "Bottom" then
											v2.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][2] or oldbedwarsblocktab[v.Name])
										else
											v2.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][3] or oldbedwarsblocktab[v.Name])
										end
									end
								end
								v.DescendantAdded:Connect(function(v3)
									if v3:IsA("Texture") then
										if v3.Name == "Top" then
											v3.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][1] or oldbedwarsblocktab[v.Name])
											v3.Color3 = v.Name == "grass" and Color3.fromRGB(115, 255, 28) or Color3.fromRGB(255, 255, 255)
										elseif v3.Name == "Bottom" then
											v3.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][2] or oldbedwarsblocktab[v.Name])
										else
											v3.Texture = (type(oldbedwarsblocktab[v.Name]) == "table" and oldbedwarsblocktab[v.Name][3] or oldbedwarsblocktab[v.Name])
										end
									end
								end)
							end)
						end
					end
					return oldweld(self, model, ...)
				end
				sethiddenproperty(lighting, "Technology", "ShadowMap")
				lighting.Ambient = Color3.fromRGB(69, 69, 69)
				lighting.Brightness = 3
				lighting.EnvironmentDiffuseScale = 1
				lighting.EnvironmentSpecularScale = 1
				lighting.OutdoorAmbient = Color3.fromRGB(69, 69, 69)
				lighting.Atmosphere.Density = 0.1
				lighting.Atmosphere.Offset = 0.25
				lighting.Atmosphere.Color = Color3.fromRGB(198, 198, 198)
				lighting.Atmosphere.Decay = Color3.fromRGB(104, 112, 124)
				lighting.Atmosphere.Glare = 0
				lighting.Atmosphere.Haze = 0
				lighting.ClockTime = 13
				lighting.GeographicLatitude = 0
				lighting.GlobalShadows = false
				lighting.TimeOfDay = "13:00:00"
				lighting.Sky.SkyboxBk = "rbxassetid://7018684000"
				lighting.Sky.SkyboxDn = "rbxassetid://6334928194"
				lighting.Sky.SkyboxFt = "rbxassetid://7018684000"
				lighting.Sky.SkyboxLf = "rbxassetid://7018684000"
				lighting.Sky.SkyboxRt = "rbxassetid://7018684000"
				lighting.Sky.SkyboxUp = "rbxassetid://7018689553"
			end)
		end,
		Winter = function() 
			task.spawn(function()
				for i,v in pairs(lighting:GetChildren()) do
					if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("PostEffect") then
						v:Remove()
					end
				end
				local sky = Instance.new("Sky")
				sky.StarCount = 5000
				sky.SkyboxUp = "rbxassetid://8139676647"
				sky.SkyboxLf = "rbxassetid://8139676988"
				sky.SkyboxFt = "rbxassetid://8139677111"
				sky.SkyboxBk = "rbxassetid://8139677359"
				sky.SkyboxDn = "rbxassetid://8139677253"
				sky.SkyboxRt = "rbxassetid://8139676842"
				sky.SunTextureId = "rbxassetid://6196665106"
				sky.SunAngularSize = 11
				sky.MoonTextureId = "rbxassetid://8139665943"
				sky.MoonAngularSize = 30
				sky.Parent = lighting
				local sunray = Instance.new("SunRaysEffect")
				sunray.Intensity = 0.03
				sunray.Parent = lighting
				local bloom = Instance.new("BloomEffect")
				bloom.Threshold = 2
				bloom.Intensity = 1
				bloom.Size = 2
				bloom.Parent = lighting
				local atmosphere = Instance.new("Atmosphere")
				atmosphere.Density = 0.3
				atmosphere.Offset = 0.25
				atmosphere.Color = Color3.fromRGB(198, 198, 198)
				atmosphere.Decay = Color3.fromRGB(104, 112, 124)
				atmosphere.Glare = 0
				atmosphere.Haze = 0
				atmosphere.Parent = lighting
			end)
			task.spawn(function()
				local snowpart = Instance.new("Part")
				snowpart.Size = Vector3.new(240, 0.5, 240)
				snowpart.Name = "SnowParticle"
				snowpart.Transparency = 1
				snowpart.CanCollide = false
				snowpart.Position = Vector3.new(0, 120, 286)
				snowpart.Anchored = true
				snowpart.Parent = workspace
				local snow = Instance.new("ParticleEmitter")
				snow.RotSpeed = NumberRange.new(300)
				snow.VelocitySpread = 35
				snow.Rate = 28
				snow.Texture = "rbxassetid://8158344433"
				snow.Rotation = NumberRange.new(110)
				snow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.16939899325371,0),NumberSequenceKeypoint.new(0.23365999758244,0.62841498851776,0.37158501148224),NumberSequenceKeypoint.new(0.56209099292755,0.38797798752785,0.2771390080452),NumberSequenceKeypoint.new(0.90577298402786,0.51912599802017,0),NumberSequenceKeypoint.new(1,1,0)})
				snow.Lifetime = NumberRange.new(8,14)
				snow.Speed = NumberRange.new(8,18)
				snow.EmissionDirection = Enum.NormalId.Bottom
				snow.SpreadAngle = Vector2.new(35,35)
				snow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.039760299026966,1.3114800453186,0.32786899805069),NumberSequenceKeypoint.new(0.7554469704628,0.98360699415207,0.44038599729538),NumberSequenceKeypoint.new(1,0,0)})
				snow.Parent = snowpart
				local windsnow = Instance.new("ParticleEmitter")
				windsnow.Acceleration = Vector3.new(0,0,1)
				windsnow.RotSpeed = NumberRange.new(100)
				windsnow.VelocitySpread = 35
				windsnow.Rate = 28
				windsnow.Texture = "rbxassetid://8158344433"
				windsnow.EmissionDirection = Enum.NormalId.Bottom
				windsnow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.16939899325371,0),NumberSequenceKeypoint.new(0.23365999758244,0.62841498851776,0.37158501148224),NumberSequenceKeypoint.new(0.56209099292755,0.38797798752785,0.2771390080452),NumberSequenceKeypoint.new(0.90577298402786,0.51912599802017,0),NumberSequenceKeypoint.new(1,1,0)})
				windsnow.Lifetime = NumberRange.new(8,14)
				windsnow.Speed = NumberRange.new(8,18)
				windsnow.Rotation = NumberRange.new(110)
				windsnow.SpreadAngle = Vector2.new(35,35)
				windsnow.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.039760299026966,1.3114800453186,0.32786899805069),NumberSequenceKeypoint.new(0.7554469704628,0.98360699415207,0.44038599729538),NumberSequenceKeypoint.new(1,0,0)})
				windsnow.Parent = snowpart
				for i = 1, 30 do
					for i2 = 1, 30 do
						local clone = snowpart:Clone()
						clone.Position = Vector3.new(240 * (i - 1), 400, 240 * (i2 - 1))
						clone.Parent = workspace
					end
				end
			end)
		end,
		Halloween = function()
			task.spawn(function()
				for i,v in pairs(lighting:GetChildren()) do
					if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("PostEffect") then
						v:Remove()
					end
				end
				lighting.TimeOfDay = "00:00:00"
				pcall(function() workspace.Clouds:Destroy() end)
				local colorcorrection = Instance.new("ColorCorrectionEffect")
				colorcorrection.TintColor = Color3.fromRGB(255, 185, 81)
				colorcorrection.Brightness = 0.05
				colorcorrection.Parent = lighting
			end)
		end,
		Valentines = function()
			task.spawn(function()
				for i,v in pairs(lighting:GetChildren()) do
					if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("PostEffect") then
						v:Remove()
					end
				end
				local sky = Instance.new("Sky")
				sky.SkyboxBk = "rbxassetid://1546230803"
				sky.SkyboxDn = "rbxassetid://1546231143"
				sky.SkyboxFt = "rbxassetid://1546230803"
				sky.SkyboxLf = "rbxassetid://1546230803"
				sky.SkyboxRt = "rbxassetid://1546230803"
				sky.SkyboxUp = "rbxassetid://1546230451"
				sky.Parent = lighting
				pcall(function() workspace.Clouds:Destroy() end)
				local colorcorrection = Instance.new("ColorCorrectionEffect")
				colorcorrection.TintColor = Color3.fromRGB(255, 199, 220)
				colorcorrection.Brightness = 0.05
				colorcorrection.Parent = lighting
			end)
		end
	}

	OldBedwars = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
		["Name"] = "GameTheme",
		["Function"] = function(callback) 
			if callback then 
				if not transformed then
					transformed = true
					themefunctions[themeselected["Value"]]()
				else
					OldBedwars["ToggleButton"](false)
				end
			else
				warningNotification("GameTheme", "Disabled Next Game", 10)
			end
		end,
		["ExtraText"] = function()
			return themeselected["Value"]
		end
	})
	themeselected = OldBedwars.CreateDropdown({
		["Name"] = "Theme",
		["Function"] = function() end,
		["List"] = {"Old", "Winter", "Halloween", "Valentines"}
	})
end)

runcode(function()
	local SetEmote = {Enabled = false}
	local SetEmoteList = {Value = ""}
	local oldemote
	local emo2 = {}
	SetEmote = GuiLibrary.ObjectsThatCanBeSaved.UtilityWindow.Api.CreateOptionsButton({
		Name = "SetEmote",
		Function = function(callback)
			if callback then
				oldemote = bedwars.ClientStoreHandler:getState().Locker.selectedSpray
				bedwars.ClientStoreHandler:getState().Locker.selectedSpray = emo2[SetEmoteList.Value]
			else
				if oldemote then 
					bedwars.ClientStoreHandler:getState().Locker.selectedSpray = oldemote
					oldemote = nil 
				end
			end
		end
	})
	local emo = {}
	for i,v in pairs(bedwars.EmoteMeta) do 
		table.insert(emo, v.name)
		emo2[v.name] = i
	end
	table.sort(emo, function(a, b) return a:lower() < b:lower() end)
	SetEmoteList = SetEmote.CreateDropdown({
		Name = "Emote",
		List = emo,
		Function = function()
			if SetEmote.Enabled then 
				bedwars.ClientStoreHandler:getState().Locker.selectedSpray = emo2[SetEmoteList.Value]
			end
		end
	})
end)

runcode(function()
	local tpstring = shared.vapeoverlay or nil
	local origtpstring = tpstring
	local Overlay = GuiLibrary.CreateCustomWindow({
		["Name"] = "Overlay", 
		["Icon"] = "vape/assets/TargetIcon1.png",
		["IconSize"] = 16
	})
	local overlayframe = Instance.new("Frame")
	overlayframe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	overlayframe.Size = UDim2.new(0, 200, 0, 120)
	overlayframe.Position = UDim2.new(0, 0, 0, 5)
	overlayframe.Parent = Overlay.GetCustomChildren()
	local overlayframe2 = Instance.new("Frame")
	overlayframe2.Size = UDim2.new(1, 0, 0, 10)
	overlayframe2.Position = UDim2.new(0, 0, 0, -5)
	overlayframe2.Parent = overlayframe
	local overlayframe3 = Instance.new("Frame")
	overlayframe3.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	overlayframe3.Size = UDim2.new(1, 0, 0, 6)
	overlayframe3.Position = UDim2.new(0, 0, 0, 6)
	overlayframe3.BorderSizePixel = 0
	overlayframe3.Parent = overlayframe2
	local oldguiupdate = GuiLibrary["UpdateUI"]
	GuiLibrary["UpdateUI"] = function(h, s, v, ...)
		overlayframe2.BackgroundColor3 = Color3.fromHSV(h, s, v)
		return oldguiupdate(h, s, v, ...)
	end
	local framecorner1 = Instance.new("UICorner")
	framecorner1.CornerRadius = UDim.new(0, 5)
	framecorner1.Parent = overlayframe
	local framecorner2 = Instance.new("UICorner")
	framecorner2.CornerRadius = UDim.new(0, 5)
	framecorner2.Parent = overlayframe2
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -7, 1, -5)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextYAlignment = Enum.TextYAlignment.Top
	label.Font = Enum.Font.Arial
	label.LineHeight = 1.2
	label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	label.TextSize = 16
	label.Text = ""
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(200, 200, 200)
	label.Position = UDim2.new(0, 7, 0, 5)
	label.Parent = overlayframe
	local OverlayFonts = {"Arial"}
	for i,v in pairs(Enum.Font:GetEnumItems()) do 
		if v.Name ~= "Arial" then
			table.insert(OverlayFonts, v.Name)
		end
	end
	local OverlayFont = Overlay.CreateDropdown({
		Name = "Font",
		List = OverlayFonts,
		Function = function(val)
			label.Font = Enum.Font[val]
		end
	})
	OverlayFont.Bypass = true
	Overlay.Bypass = true
	local oldnetworkowner
	local mapname = "Lobby"
	GuiLibrary["ObjectsThatCanBeSaved"]["GUIWindow"]["Api"].CreateCustomToggle({
		["Name"] = "Overlay", 
		["Icon"] = "vape/assets/TargetIcon1.png", 
		["Function"] = function(callback)
			Overlay.SetVisible(callback) 
			if callback then
				task.spawn(function()
					repeat
						wait(1)
						if not tpstring then
							tpstring = tick().."/0/0/0/0/0/0/0"
							origtpstring = tpstring
						end
						local splitted = origtpstring:split("/")
						label.Text = "Session Info\nTime Played : "..os.date("!%X",math.floor(tick() - splitted[1])).."\nKills : "..(splitted[2]).."\nBeds : "..(splitted[3]).."\nWins : "..(splitted[4]).."\nGames : "..splitted[5].."\nLagbacks : "..(splitted[6]).."\nUniversal Lagbacks : "..(splitted[7]).."\nReported : "..(splitted[8]).."\nMap : "..mapname
						local textsize = textservice:GetTextSize(label.Text, label.TextSize, label.Font, Vector2.new(100000, 100000))
						overlayframe.Size = UDim2.new(0, math.max(textsize.X + 19, 200), 0, (textsize.Y * 1.2) + 6)
						tpstring = splitted[1].."/"..(splitted[2]).."/"..(splitted[3]).."/"..(splitted[4]).."/"..(splitted[5]).."/"..(splitted[6]).."/"..(splitted[7]).."/"..(splitted[8])
					until (Overlay and Overlay.GetCustomChildren() and Overlay.GetCustomChildren().Parent and Overlay.GetCustomChildren().Parent.Visible == false)
				end)
			end
		end, 
		["Priority"] = 2
	})
end)

task.spawn(function()
	local function createannouncement(announcetab)
		local vapenotifframe = Instance.new("TextButton")
		vapenotifframe.AnchorPoint = Vector2.new(0.5, 0)
		vapenotifframe.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
		vapenotifframe.Size = UDim2.new(1, -10, 0, 50)
		vapenotifframe.Position = UDim2.new(0.5, 0, 0, -100)
		vapenotifframe.AutoButtonColor = false
		vapenotifframe.Text = ""
		vapenotifframe.Parent = shared.GuiLibrary.MainGui
		local vapenotifframecorner = Instance.new("UICorner")
		vapenotifframecorner.CornerRadius = UDim.new(0, 256)
		vapenotifframecorner.Parent = vapenotifframe
		local vapeicon = Instance.new("Frame")
		vapeicon.Size = UDim2.new(0, 40, 0, 40)
		vapeicon.Position = UDim2.new(0, 5, 0, 5)
		vapeicon.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
		vapeicon.Parent = vapenotifframe
		local vapeiconicon = Instance.new("ImageLabel")
		vapeiconicon.BackgroundTransparency = 1
		vapeiconicon.Size = UDim2.new(1, -10, 1, -10)
		vapeiconicon.AnchorPoint = Vector2.new(0.5, 0.5)
		vapeiconicon.Position = UDim2.new(0.5, 0, 0.5, 0)
		vapeiconicon.Image = getsynasset("vape/assets/VapeIcon.png")
		vapeiconicon.Parent = vapeicon
		local vapeiconcorner = Instance.new("UICorner")
		vapeiconcorner.CornerRadius = UDim.new(0, 256)
		vapeiconcorner.Parent = vapeicon
		local vapetext = Instance.new("TextLabel")
		vapetext.Size = UDim2.new(1, -55, 1, -10)
		vapetext.Position = UDim2.new(0, 50, 0, 5)
		vapetext.BackgroundTransparency = 1
		vapetext.TextScaled = true
		vapetext.RichText = true
		vapetext.Font = Enum.Font.Ubuntu
		vapetext.Text = announcetab.Text
		vapetext.TextColor3 = Color3.new(1, 1, 1)
		vapetext.TextXAlignment = Enum.TextXAlignment.Left
		vapetext.Parent = vapenotifframe
		tweenService:Create(vapenotifframe, TweenInfo.new(0.3), {Position = UDim2.new(0.5, 0, 0, 5)}):Play()
		local sound = Instance.new("Sound")
		sound.PlayOnRemove = true
		sound.SoundId = "rbxassetid://6732495464"
		sound.Parent = workspace
		sound:Destroy()
		vapenotifframe.MouseButton1Click:Connect(function()
			local sound = Instance.new("Sound")
			sound.PlayOnRemove = true
			sound.SoundId = "rbxassetid://6732690176"
			sound.Parent = workspace
			sound:Destroy()
			vapenotifframe:Destroy()
		end)
		game:GetService("Debris"):AddItem(vapenotifframe, announcetab.Time or 20)
	end

	local function rundata(datatab, olddatatab)
		if not olddatatab then
			if datatab.Disabled then 
				coroutine.resume(coroutine.create(function()
					repeat task.wait() until shared.VapeFullyLoaded
					task.wait(1)
					GuiLibrary.SelfDestruct()
				end))
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Vape",
					Text = "Vape is currently disabled, please use vape later.",
					Duration = 30,
				})
			end
			if datatab.KickUsers and datatab.KickUsers[tostring(lplr.UserId)] then
				lplr:Kick(datatab.KickUsers[tostring(lplr.UserId)])
			end
		else
			if datatab.Disabled then 
				coroutine.resume(coroutine.create(function()
					repeat task.wait() until shared.VapeFullyLoaded
					task.wait(1)
					GuiLibrary.SelfDestruct()
				end))
				game:GetService("StarterGui"):SetCore("SendNotification", {
					Title = "Vape",
					Text = "Vape is currently disabled, please use vape later.",
					Duration = 30,
				})
			end
			if datatab.KickUsers and datatab.KickUsers[tostring(lplr.UserId)] then
				lplr:Kick(datatab.KickUsers[tostring(lplr.UserId)])
			end
			if datatab.Announcement and datatab.Announcement.ExpireTime >= os.time() and (datatab.Announcement.ExpireTime ~= olddatatab.Announcement.ExpireTime or datatab.Announcement.Text ~= olddatatab.Announcement.Text) then 
				task.spawn(function()
					createannouncement(datatab.Announcement)
				end)
			end
		end
	end
	task.spawn(function()
		pcall(function()
			if not isfile("vape/Profiles/bedwarsdata.txt") then 
				local commit = "main"
				for i,v in pairs(game:HttpGet("https://github.com/7GrandDadPGN/VapeV4ForRoblox"):split("\n")) do 
					if v:find("commit") and v:find("fragment") then 
						local str = v:split("/")[5]
						commit = str:sub(0, str:find('"') - 1)
						break
					end
				end
				writefile("vape/Profiles/bedwarsdata.txt", game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..commit.."/CustomModules/bedwarsdata", true))
			end
			local olddata = readfile("vape/Profiles/bedwarsdata.txt")

			repeat
				local commit = "main"
				for i,v in pairs(game:HttpGet("https://github.com/7GrandDadPGN/VapeV4ForRoblox"):split("\n")) do 
					if v:find("commit") and v:find("fragment") then 
						local str = v:split("/")[5]
						commit = str:sub(0, str:find('"') - 1)
						break
					end
				end
				
				local newdata = game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..commit.."/CustomModules/bedwarsdata", true)
				if newdata ~= olddata then 
					rundata(game:GetService("HttpService"):JSONDecode(newdata), game:GetService("HttpService"):JSONDecode(olddata))
					olddata = newdata
					writefile("vape/Profiles/bedwarsdata.txt", newdata)
				end

				task.wait(10)
			until not vapeInjected
		end)
	end)
end)

pcall(GuiLibrary.RemoveObject, "PlayerTPOptionsButton")
pcall(GuiLibrary.RemoveObject, "HealthNotificationsOptionsButton")

local function VoidwareDataDecode(datatab)
	local newdata = datatab.latestdata or {}
	local oldfile = datatab.filedata
	local latestfile = datatab.filesource
	task.spawn(function()
		local releasedversion = newdata.ReleasedBuilds and table.find(newdata.ReleasedBuilds, VoidwareStore.VersionInfo.VersionID)
		if releasedversion and not newdata.Disabled and VoidwareStore.VersionInfo.BuildType == "Beta" and VoidwareFunctions:GetPlayerType() ~= "OWNER" then
			local data = VoidwareFunctions:GetFile("System/Bedwars.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Modules Main File\n"..data pcall(writefile, "vape/CustomModules/6872274481.lua", data) end
			data = VoidwareFunctions:GetFile("System/NewMainScript.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/NewMainScript.lua", data) end
			data = VoidwareFunctions:GetFile("System/MainScript.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/MainScript.lua", data) end
			data = VoidwareFunctions:GetFile("System/GuiLibrary.lua", true)
			if data ~= "" and data ~= "404: Not Found" then data = "-- Voidware Custom Modules Signed File\n"..data pcall(writefile, "vape/GuiLibrary.lua", data) end
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
				while true do end
			end
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Voidware",
				Text = "Voidware is currently disabled. check the discord (discord.gg/voidware) for updates.",
				Duration = 30,
			})
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
	task.wait(VoidwareStore.MobileInUse and 4.5 or 0.1)
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
			Function = function(callback)
				if callback then
					task.spawn(function()
						if not isAlive() then repeat task.wait() until isAlive() end
						pcall(function() lplr.Character.Head.Nametag:Destroy() end)
						table.insert(NoNameTag.Connections, lplr.Character.Head.ChildAdded:Connect(function(v)
							if v.Name == "Nametag" then
								v:Destroy()
							end
						end))
						table.insert(NoNameTag.Connections, lplr.CharacterAdded:Connect(function()
							if not isAlive() then repeat task.wait() until isAlive() end
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
		TitleColor.Object.Visible = TitleColorToggle.Enabled
		TitleFont.Object.Visible = TextFontToggle.Enabled
	end)

	runFunction(function()
		local HotbarCustomization = {Enabled = false}
		local InvSlotCornerRadius = {Value = 8}
		local InventoryRounding = {Enabled = true}
		local HideSlotNumbers = {Enabled = false}
		local SlotBackgroundColor = {Enabled = false}
		local SlotBackgroundColorSlider = {Hue = 0.44, Sat = 0.31, Value = 0.28}
		local SlotNumberBackgroundColorToggle = {Enabled = false}
		local SlotNumberBackgroundColor = {Hue = 0.44, Sat = 0.31, Value = 0.28}
		local hotbarwaitfunc
		local hotbarstuff = {
			SlotCorners = {},
			HiddenSlotNumbers = {},
			SlotOldColor = nil
		}
		local inventoryicons
		local function HotbarFunction()
			hotbarwaitfunc = pcall(function() return lplr.PlayerGui.hotbar and lplr.PlayerGui.hotbar["1"]["3"] end)
			   if not hotbarwaitfunc then 
			   repeat task.wait() hotbarwaitfunc = pcall(function() return lplr.PlayerGui.hotbar and lplr.PlayerGui.hotbar["1"]["3"] end) until hotbarwaitfunc 
			 end
			inventoryicons = lplr.PlayerGui.hotbar["1"]["3"]
			for i,v in pairs(inventoryicons:GetChildren()) do
				if v:IsA("Frame") then
					if InventoryRounding.Enabled then
					hotbarstuff.SlotOldColor = v:FindFirstChildWhichIsA("ImageButton").BackgroundColor3
					local rounding = Instance.new("UICorner")
					rounding.Parent = v:FindFirstChildWhichIsA("ImageButton")
					rounding.CornerRadius = UDim.new(0, InvSlotCornerRadius.Value)
					table.insert(hotbarstuff.SlotCorners, rounding)
					end
					if SlotBackgroundColor.Enabled then
						pcall(function() v:FindFirstChildWhichIsA("ImageButton").BackgroundColor3 = Color3.fromHSV(SlotBackgroundColorSlider.Hue, SlotBackgroundColorSlider.Sat, SlotBackgroundColorSlider.Value) end)
					end
					if HideSlotNumbers.Enabled then
						pcall(function() 
						local slotText = v:FindFirstChildWhichIsA("ImageButton"):FindFirstChildWhichIsA("TextLabel")
						slotText.Parent = game 
						hotbarstuff.HiddenSlotNumbers[slotText] = v:FindFirstChildWhichIsA("ImageButton")
						end)
					end
				end
			end
		end
		HotbarCustomization = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
			Name = "HotbarCustomization",
			HoverText = "Customize the ugly default hotbar to your liking.",
			Approved = true,
			Function = function(callback)
				if callback then
					task.spawn(HotbarFunction)
					table.insert(HotbarCustomization.Connections, lplr.CharacterAdded:Connect(HotbarFunction))
				else
					for i,v in pairs(hotbarstuff.SlotCorners) do
						pcall(function() v:Destroy() end)
					end
					for i,v in pairs(inventoryicons:GetChildren()) do
						pcall(function() v:FindFirstChildWhichIsA("ImageButton").BackgroundColor3 = hotbarstuff.SlotOldColor end)
					end
					for i,v in pairs(hotbarstuff.HiddenSlotNumbers) do
						pcall(function() i.Parent = v end)
					end
				end
			end
		})
		InventoryRounding = HotbarCustomization.CreateToggle({
			Name = "Round Slots",
			Function = function(callback)
				pcall(function() InvSlotCornerRadius.Object.Visible = callback end)
				if callback and HotbarCustomization.Enabled then
					HotbarCustomization.ToggleButton(false) HotbarCustomization.ToggleButton(false)
				elseif HotbarCustomization.Enabled then
				  for i,v in pairs(hotbarstuff.SlotCorners) do
					pcall(function() v:Destroy() end)
				end
			end
		end
	  })
	  HideSlotNumbers = HotbarCustomization.CreateToggle({
		Name = "Hide Slot Numbers",
		HoverText = "hide the ugly slot numbers.",
		Function = function() if HotbarCustomization.Enabled then HotbarCustomization.ToggleButton(false) HotbarCustomization.ToggleButton(false) end end
	  })
	  InvSlotCornerRadius = HotbarCustomization.CreateSlider({
		Name = "Corner Radius",
		Function = function(val) if HotbarCustomization.Enabled and InventoryRounding.Enabled then for i,v in pairs(hotbarstuff.SlotCorners) do pcall(function() v.CornerRadius = UDim.new(0, val) end) end end end,
		Min = 8,
		Max = 20
	})
	  SlotBackgroundColor = HotbarCustomization.CreateToggle({
		 Name = "Slot Background Color",
		 Function = function(callback) pcall(function() SlotBackgroundColorSlider.Object.Visible = callback end) 
		 if HotbarCustomization.Enabled then
			HotbarCustomization.ToggleButton(false) HotbarCustomization.ToggleButton(false)
		 end 
		 end
	  })
	  SlotBackgroundColorSlider = HotbarCustomization.CreateColorSlider({
		Name = "Color",
		Function = function(h, s, v) if HotbarCustomization.Enabled and SlotBackgroundColor.Enabled and inventoryicons then
			for i,v in pairs(inventoryicons:GetChildren()) do
				pcall(function() v:FindFirstChildWhichIsA("ImageButton").BackgroundColor3 = Color3.fromHSV(SlotBackgroundColorSlider.Hue, SlotBackgroundColorSlider.Sat, SlotBackgroundColorSlider.Value) end)
			end
		end
		end
	})
	   InvSlotCornerRadius.Object.Visible = InventoryRounding.Enabled
	   SlotBackgroundColorSlider.Object.Visible = SlotBackgroundColor.Enabled
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