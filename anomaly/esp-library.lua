--> Services/Libraries: 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tippityfiddler/lua_programs/refs/heads/main/anomaly/ui-lib.lua"))()
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/tippityfiddler/lua_programs/refs/heads/main/anomaly/esp-library.lua"))()
local ServerTeleports = loadstring(game:HttpGet("https://raw.githubusercontent.com/tippityfiddler/lua_programs/refs/heads/main/anomaly/serverteleport-library.lua"))() 

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")

local RS = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")

local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Analytics = game:GetService("RbxAnalyticsService")
local TextChatService = game:GetService("TextChatService")

local ScriptContext = game:GetService("ScriptContext")
local LogService = game:GetService("LogService")
local ContentProvider = game:GetService("ContentProvider")

local GuiService = game:GetService("GuiService")
local workspace = game:GetService("Workspace")

--> Client:
local localPlayer = Players.LocalPlayer 
local backpack = localPlayer.Backpack
local camera = workspace.CurrentCamera 

local mouse = localPlayer:GetMouse()
local ocean = workspace.Env.Ocean 

--> Folders:
local binFolder = localPlayer.bin 
local enemiesFolder = workspace.Enemies 
local chestFolder = workspace:FindFirstChild("Chest", true).Parent 

--> Bin Values:
local firstMagic = binFolder.Magic.Value
local fightingStyle = binFolder.FightingStyle.Value 

--> Modules:
local clientFuncModules = require(RS.Modules.Client.ClientFunctions)
local oldMovementModule = require(RS.Modules.Client.ClientFunctions.Core.Movement)

--> Remotes:
local chargeRE = RS.Remotes.Events.Charge 
local antiRemote = RS.Remotes.Events.Anti
local acRemote = RS.Remotes.Events:FindFirstChild("SwapCheck") or RS.Remotes.Events:FindFirstChild("AC")

--> UI Essentials:
local window = Library:CreateWindow("Anomaly")
local mainTab = Library:CreateTab(window, "General")
local farmsTab = Library:CreateTab(window, "Farms")
local espTab = Library:CreateTab(window, "ESP")

--> Cached Commons: 
local getgenv = getgenv 
local getfenv = getfenv 
local hookmetamethod = hookmetamethod 
local hookfunction = hookfunction 
local getnamecallmethod = getnamecallmethod 
local getcallingscript = getcallingscript 
local tostring = tostring 
local getconnections = getconnections 
local checkcaller = checkcaller 
local getrenv = getrenv 
local getrawmetatable = getrawmetatable 
local getUpvalues = debug.getupvalues
local V3 = Vector3.new
local V2 = Vector2.new 
local CF = CFrame.new
local toggles = {}
local idled = localPlayer.Idled
local cachedMagicTool = backpack:FindFirstChild(firstMagic)
local cachedFightingTool = backpack:FindFirstChild(fightingStyle)
local heightPos = V3(0, 7, 0)
local timers =  {
	bossFarmTimer = 0, 
	magicFarmTimer = 0, 
	strengthFarmTimer = 0,
	breakBossFarmTimer = 0,
	breakMagicFarmTimer = 0, 
	breakStrengthFarmTimer = 0, 
}
--> Constant:
local HUGE = math.huge
local HUGE_FORCE = V3(HUGE, HUGE, HUGE)
local V3_0 = V3(0, 0, 0)

--> Bypasses:
--ScriptContext:SetTimeout(0.25)
local commonDTCServices = {
	"UGCValidationService",
	"WebSocketService",
	"OpenCloudService",
	"VirtualUser",
	"VirtualInputManager"
}

for i,v in pairs(getgc(true)) do
	if typeof(v) == "table" then
		local mt = getrawmetatable(v)
		if mt then 
			setreadonly(mt, false)
			if rawget(mt, "__mode") then
				setmetatable(v, nil)
			end 
		end
	end
end

for i,v in pairs(debug.getregistry()) do
	if typeof(v) == "table" then
		local mt = getrawmetatable(v)
		if mt then 
			setreadonly(mt, false)
			if rawget(mt, "__mode") then
				setmetatable(v, nil)
			end 
		end
	end
end

local oldNC; oldNC = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
	local method = getnamecallmethod()
	local args = {...}
	
	if method == "Fire" and type(args[1]) == "table" then 
		for i,v in next, args[1] do 
			if type(i) == "userdata" then 
				hookmetamethod(game, "__namecall", oldNC)

				return 
			end 
		end 
	end 

	if self.Name == "ContentProvider" and (method == "PreloadAsync" or method == "GetAssetFetchStatus" or method == "Preload" or method == "GetAssetFetchStatusChangedSignal") then 
		return
	end 	
	
	if not checkcaller() and self == game then
		if (method == "FindService" or method == "FindFirstChild") and table.find(commonDTCServices, args[1]) then
			return
		end
	end

	if self.Name == "AC" or self.Name == "SwapCheck" or self.Name == "Anti" then 
		return 
	end 

	if method == "Kick" or method:lower() == "kick" then 
		return 
	end 

	return oldNC(self, ...)
end))

local oldFetch; oldFetch = hookfunction(ContentProvider.GetAssetFetchStatusChangedSignal, function(self, asset)
	if self == ContentProvider then
		local fake = Instance.new("BindableEvent")

		return fake.Event
	end

	return oldFetch(self, asset)
end)


local oldFFC; oldFFC = hookfunction(game.FindFirstChild, function(self, name)
	if not checkcaller() then
		if self == game and table.find(commonDTCServices, name) then
			return 
		end
	end

	return oldFFC(self, name)
end)

local oldFS; oldFS = hookfunction(game.FindService, function(self, name)
	if not checkcaller() then
		if self == game and table.find(commonDTCServices, name) then
			return 
		end
	end

	return oldFS(self, name)
end)

local old; old = hookfunction(getrenv().spawn or spawn, function(...)
	if getcallingscript() == nil then 
		return 
	end 
	return old(...)
end)

local old; old = hookfunction(getrenv().task.spawn or task.spawn, function(...)
	if not checkcaller() and (tostring(getcallingscript()) == "        " or getcallingscript() == nil) then 
		return 
	end 

	return old(...)
end)

local old; old = hookfunction(getrenv().require or require, function(...)
	if not checkcaller() and (tostring(getcallingscript()) == "        " or getcallingscript() == nil) then 
		return 
	end 
	return old(...)
end)

hookfunction(antiRemote.FireServer, function() return end)
hookfunction(localPlayer.Kick, function() return end)
hookfunction(acRemote.FireServer, function() return end)
hookfunction(ContentProvider.PreloadAsync, function() return end)
hookfunction(ContentProvider.GetAssetFetchStatus, function() return end)
hookfunction(GuiService.InspectPlayerFromHumanoidDescription, function() return end)
hookfunction(GuiService.CloseInspectMenu, function() return end)

for i,v in next, debug.getregistry() do 
	if type(v) == "thread" and gettenv(v).script and gettenv(v).script.Name == "        " then 
		task.cancel(v)
	end 
end 

--> Comment these out when debugging:
for i,v in pairs(getconnections(ScriptContext.Error)) do
    v:Disable()
end
for i,v in pairs(getconnections(LogService.MessageOut)) do
    v:Disable()
end
for i,v in next, getconnections(game.ServiceAdded) do 
	v:Disable()
end

--> Anti AFK:
if getconnections then 
	for i,v in next, getconnections(idled) do
		if v.Disable then
			v:Disable()
		elseif v.Disconnect then
			v:Disconnect()
		end
	end

	idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(V2(0, 0))
	end)
else
	idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(V2(0, 0))
	end)
end

--> Get Functions:
local function getMagicEvent(character)  
	if backpack:FindFirstChild(firstMagic) then 
		local tool = backpack[firstMagic] 
		if tool:FindFirstChild("LocalScript") and tool.LocalScript:FindFirstChild(firstMagic) then 
			return tool.LocalScript[firstMagic] 
		end 
	end 

	if character:FindFirstChild(firstMagic) then 
		local tool = character[firstMagic] 
		if tool:FindFirstChild("LocalScript") and tool.LocalScript:FindFirstChild(firstMagic) then 
			return tool.LocalScript[firstMagic]  
		end 
	end 
end 

local function getCombatEvent(character)  
	if backpack:FindFirstChild(fightingStyle) then 
		local tool = backpack[fightingStyle] 
		if tool:FindFirstChild("LocalScript") and tool.LocalScript:FindFirstChild(fightingStyle) then 
			return tool.LocalScript[fightingStyle] 
		end 
	end 

	if character:FindFirstChild(fightingStyle) then 
		local tool = character[fightingStyle] 
		if tool:FindFirstChild("LocalScript") and tool.LocalScript:FindFirstChild(fightingStyle) then 
			return tool.LocalScript[fightingStyle]  
		end 
	end 
end 

local function getFirstMagicQRemoteKey(magicRE)
	local proxy, proxyMT, GUID
	if magicRE then 
		for i,v in next, getconnections(magicRE.OnClientEvent) do 
			if typeof(getfenv(v.Function).script) == "Instance" and getfenv(v.Function).script:FindFirstChild(magicRE.Name) then 
				for i,v in next, getUpvalues(v.Function) do 
					if tostring(v) ~= "LocalScript" then
						if type(v) == "userdata" then proxy = v; proxyMT = getrawmetatable(v) end
						if i == 2 then GUID = v; break end
					end 
				end 
			end 
			if proxyMT and type(proxyMT.__index) == "function" then 
				return getUpvalues(proxyMT.__index)[3]
            end
		end 
	end 
end

local function getCombatRemoteKey(combatRE)
	local fightProxy, fightProxyMT, fightGUID
	if combatRE then 
		for i,v in next, getconnections(combatRE.OnClientEvent) do 
			for i,v in next, getUpvalues(v.Function) do 
				if type(v) == "userdata" then fightProxy = v; fightProxyMT = getrawmetatable(v) end 
				if i == 2 then fightGUID = v break end 
			end 
		end 
		if fightProxyMT and type(fightProxyMT.__index) == "function" then 
			return getUpvalues(fightProxyMT.__index)[3]
		end
	end 
end 

local function getMagicStats()
	local powerSlider = binFolder.PowerSlider.Value
	local magicPower = binFolder.MagicPower.Value
	local magicTier = clientFuncModules.MagicTier(magicPower, 1)
	local spellCost = (magicTier * 20) * powerSlider
	local magicEnergy = binFolder.MagicEnergy.Value
	return spellCost, magicEnergy
end

local function updateCachedTools()
    local newMagicTool = backpack:FindFirstChild(firstMagic) or (localPlayer.Character and localPlayer.Character:FindFirstChild(firstMagic))
    local newFightingTool = backpack:FindFirstChild(fightingStyle) or (localPlayer.Character and localPlayer.Character:FindFirstChild(fightingStyle))
    
    if newMagicTool ~= cachedMagicTool then
        cachedMagicTool = newMagicTool
    end

    if newFightingTool ~= cachedFightingTool then
        cachedFightingTool = newFightingTool
    end
end

--> Events for Cached Commons:
backpack.ChildAdded:Connect(function(child)
    if child.Name == firstMagic then
        updateCachedTools()
    elseif child.Name == fightingStyle then
		updateCachedTools()
    end
end)

backpack.ChildRemoved:Connect(function(child)
    if child.Name == firstMagic then
        updateCachedTools()
    elseif child.Name == fightingStyle then
		updateCachedTools()
    end
end)

localPlayer.CharacterAdded:Connect(function(char)
	repeat task.wait() until localPlayer:FindFirstChild("Backpack")
	backpack = localPlayer.Backpack

	backpack.ChildAdded:Connect(function(child)
		if child.Name == firstMagic then
			updateCachedTools()
		elseif child.Name == fightingStyle then
			updateCachedTools()
		end
	end)

	backpack.ChildRemoved:Connect(function(child)
		if child.Name == firstMagic then
			updateCachedTools()
		elseif child.Name == fightingStyle then
			updateCachedTools()
		end
	end)
	updateCachedTools()
end)

--> Lighting Section:
local NoShadows = mainTab:CreateToggle("No Shadows", function(v) 
    Lighting.GlobalShadows = not Lighting.GlobalShadows 
end)

local NoFog = mainTab:CreateToggle("No Fog", function(v) 
    if v then 
        if Lighting:FindFirstChild("Atmosphere") then 
            Lighting.Atmosphere.Density = 0    
			toggles.noFog = Lighting.Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
				pcall(function()
					Lighting.Atmosphere.Density = 0
				end)
			end)  
        end
    else
        if toggles.noFog then toggles.noFog:Disconnect(); toggles.noFog = nil end 
    end
end)


local NoDoF = mainTab:CreateButton("No Depth of Field", function() 
    if Lighting:FindFirstChildWhichIsA("DepthOfFieldEffect") then 
        Lighting:FindFirstChildWhichIsA("DepthOfFieldEffect"):Destroy()
    end 

    for i,v in next, Lighting:GetDescendants() do 
        if v:IsA("DepthOfFieldEffect") then 
            v:Destroy()
        end 
    end 
end)

--> Main Tab:
local GetAllAnimationPacks = mainTab:CreateButton("Get All Animation Packs", function() 
    for i,v in next, binFolder:GetChildren() do 
        if v.Name:find("Has") and v.Name:find("Pack") then 
            v.Value = true 
        end 
    end 
end)

local IY = mainTab:CreateButton("IY", function() 
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

local WalkSpeedSlider = mainTab:CreateSlider("WalkSpeed", 0, 500, 16, function(value)
    toggles.walkSpeed = value 
end)

local SetWalkSpeed = mainTab:CreateToggle("Set WalkSpeed", function(v) 
	toggles.setWalkSpeed = v
end)

local NoDashCD = mainTab:CreateToggle("No Dash CD", function(v) 
	toggles.noDashCD = v
end)

local NoDashDecay = mainTab:CreateToggle("No Dash Decay", function(v) 
	toggles.noDashDecay = v
end)

local InfStamina = mainTab:CreateToggle("Infinite Stamina", function(v) 
    toggles.infStamina = v 
end)

local WalkOnWater = mainTab:CreateToggle("Walk On Water", function(v) 
    toggles.walkOnWater = v 
	if v then
		local jesusPart = Instance.new("Part", workspace) 
		local jesusPartSize = V3(2, 1, 2) 

		jesusPart.Size = jesusPartSize 
		jesusPart.Name = "Yeshua Is Goated"
		jesusPart.Transparency = 1 
	else 
		if workspace:FindFirstChild("Yeshua Is Goated") then
			workspace["Yeshua Is Goated"]:Destroy()
		end
	end
end)

--> Teleports: 
local RejoinServer = mainTab:CreateButton("Rejoin Server", function() 
	ServerTeleports.RejoinServer() 
end)

local RejoinServer = mainTab:CreateButton("Server Hop", function() 
	ServerTeleports.ServerHop() 
end)

local TeleportsDropdown = mainTab:CreateDropdown("Teleports", {"First Sea", "Second Sea", "Third Sea"}, function(v)
    toggles.sea = v
end)

local TeleportToSea = mainTab:CreateButton("Teleport To Sea", function() 
	if toggles.sea == "First Sea" then 
		ServerTeleports.TeleportToPlaceId(3099893649)
	elseif toggles.sea == "Second Sea" then 
		ServerTeleports.TeleportToPlaceId(4180357500)
	elseif toggles.sea == "Third Sea" then 
		ServerTeleports.TeleportToPlaceId(4592306011)
	end 
end)

--> Farms Tab:
local MagicFarm = farmsTab:CreateToggle("Magic Farm", function(v) 
    toggles.magicFarm = v 
end)

local StrengthFarm = farmsTab:CreateToggle("Strength Farm", function(v) 
    toggles.strengthFarm = v 
end)

local BossDropdown = farmsTab:CreateDropdown("Bosses", {"Kraken", "Verdies", "Marua", "Harrison", "Theos", "Captain Sage"}, function(v)
    toggles.boss = v
end)

local BossFarm = farmsTab:CreateToggle("Boss Farm", function(v) 
    toggles.bossFarm = v 
    if not v then
        local character = localPlayer.Character
        if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local keyBodyVel = rootPart:FindFirstChild("KEYS")
                if keyBodyVel then
                    keyBodyVel:Destroy()
                end
            end
        end
    end
end)

--> ESP Tab: 
local BoxESP = espTab:CreateToggle("Box ESP", function(v) 
	if v then 
		ESP:Enable("Square")
	else 
		ESP:Disable("Square")
	end 
end)

local HealthBarESP = espTab:CreateToggle("Health Bar ESP", function(v) 
	if v then 
		ESP:Enable("HealthBar")
	else 
		ESP:Disable("HealthBar")
	end 
end)

local OffscreenArrowsESP = espTab:CreateToggle("Offscreen Arrows ESP", function(v) 
	if v then 
		ESP:Enable("Arrow")
	else 
		ESP:Disable("Arrow")
	end 
end)

local LineESP = espTab:CreateToggle("Line ESP", function(v) 
	if v then 
		ESP:Enable("Line")
	else 
		ESP:Disable("Line")
	end 
end)

local ChestESP = espTab:CreateToggle("Chest ESP", function(v) 
	toggles.chestESP = v
	if v then 
		for i,v in next, chestFolder:GetChildren() do 
			local bottom = v:FindFirstChild("Bottom") 
			if not bottom then continue end 
			ESP.Types["CustomText"].create(bottom)
		end 

		toggles.chestPartAdded = chestFolder.ChildAdded:Connect(function(child)
			ESP.Types["CustomText"].create(child.Bottom)

		end)

		toggles.chestPartRemoved = chestFolder.ChildRemoved:Connect(function(child)
			ESP.Types["CustomText"].remove(child.Bottom) 
		end)
	else 
		if toggles.chestPartAdded then toggles.chestPartAdded:Disconnect(); toggles.chestPartAdded = nil end
		if toggles.chestPartRemoved then toggles.chestPartRemoved:Disconnect(); toggles.chestPartRemoved = nil end 
	end 
end)

--> Chest ESP Section:
local function chestESP() 
	for i,v in next, chestFolder:GetChildren() do 
		local bottom = v:FindFirstChild("Bottom") 
		local opened = v:FindFirstChild("Opened")
		local chestType = v:FindFirstChild("Type")
		if not bottom or not opened or not chestType then return end 
		local chestTxt = chestType.Value .. " Chest"

		ESP.Types["CustomText"].update(bottom, chestTxt)
	end 
end 

local function bossFarm(dt, target) 
	local character = localPlayer.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	if not toggles.bossFarm then
		local keyBodyVel = rootPart:FindFirstChild("KEYS")
		if keyBodyVel then
			keyBodyVel:Destroy()
		end
		return
	end

	if cachedMagicTool and cachedMagicTool.Parent ~= character then
		cachedMagicTool.Parent = character
	end

	local bodyVelocity = rootPart:FindFirstChild("KEYS")
	if not bodyVelocity then
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = "KEYS"
		bodyVelocity.MaxForce = V3(HUGE, HUGE, HUGE)
		bodyVelocity.Parent = rootPart
	end

	local spellCost, magicEnergy = getMagicStats()
	local magicRE = getMagicEvent(character)
	local bossInstance = enemiesFolder:FindFirstChild(toggles.boss)

	if bossInstance and bossInstance:FindFirstChild("HumanoidRootPart") and bossInstance:FindFirstChild("Humanoid") then
		if bossInstance.Humanoid.Health <= 0 then 
			bossInstance:Destroy()
			return
		end

		local bossRP = bossInstance.HumanoidRootPart
		local abovePos = bossRP.Position + heightPos
		rootPart.CFrame = CFrame.lookAt(abovePos, bossRP.Position)
	else
		rootPart.CFrame = CF(2000, 2000, 2000)
		return
	end

	if spellCost >= magicEnergy then 
		chargeRE:FireServer("Charge")
	else  
		chargeRE:FireServer("ChargeEnd")
		if magicRE then 
			timers.bossFarmTimer += dt
			if timers.bossFarmTimer >= 0.25 then
				local remoteKey = getFirstMagicQRemoteKey(magicRE)
				
				if remoteKey then 
					magicRE:FireServer(remoteKey, target) 
					magicRE:FireServer(remoteKey + 1, rootPart.CFrame)
					timers.breakBossFarmTimer = 0
				else
					timers.breakBossFarmTimer += dt 
					
					if timers.breakBossFarmTimer >= 5 then 
						humanoid.Health = 0
						timers.breakBossFarmTimer = 0 
					end 
				end 
				timers.bossFarmTimer = 0
			else 
				timers.breakBossFarmTimer += dt
			end
		end 
	end 
end 

local function magicFarm(dt, target)
	local character = localPlayer.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then return end

	if not cachedMagicTool or (cachedMagicTool.Parent ~= backpack and cachedMagicTool.Parent ~= character) then
		cachedMagicTool = backpack:FindFirstChild(firstMagic) or character:FindFirstChild(firstMagic)
	end
	if cachedMagicTool and cachedMagicTool.Parent ~= character then
		cachedMagicTool.Parent = character
	end

	local magicRE = getMagicEvent(character)
	local spellCost, magicEnergy = getMagicStats()
	local cPos = CF(rootPart.Position, mouse.Hit.p)

	if spellCost >= magicEnergy then 
		chargeRE:FireServer("Charge")
	else  
		chargeRE:FireServer("ChargeEnd")
		if magicRE then 
			timers.magicFarmTimer += dt
			if timers.magicFarmTimer >= 0.25 then
				local remoteKey = getFirstMagicQRemoteKey(magicRE)
				if remoteKey then 
					magicRE:FireServer(remoteKey, target) 
					magicRE:FireServer(remoteKey + 1, rootPart.CFrame)
				else 
					timers.breakMagicFarmTimer += dt 
					
					if timers.breakMagicFarmTimer >= 7 then 
						humanoid.Health = 0
						timers.breakMagicFarmTimer = 0 
					end 
				end 
				timers.magicFarmTimer = 0

			else 
				timers.breakMagicFarmTimer += dt 
			end
		end 
	end 
end 

local function strengthFarm(dt)
	local character = localPlayer.Character
	if not character then return end 
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end 
	local humanoid = character:FindFirstChild("Humanoid") 
	if not humanoid then return end 

	if not cachedFightingTool or (cachedFightingTool.Parent ~= backpack and cachedFightingTool.Parent ~= character) then
		cachedFightingTool = backpack:FindFirstChild(fightingStyle) or character:FindFirstChild(fightingStyle)
	end

	if cachedFightingTool and cachedFightingTool.Parent ~= character then
		cachedFightingTool.Parent = character
	end

	local fightingRE = getCombatEvent(character)
	if fightingRE then 
		timers.strengthFarmTimer += dt
		if timers.strengthFarmTimer >= 0.25 then
			local remoteKey = getCombatRemoteKey(fightingRE)
			if remoteKey then 
				fightingRE:FireServer(remoteKey + 1, rootPart.Position)
				timers.strengthFarmTimer = 0
			else 
				timers.breakStrengthFarmTimer += dt 

				if timers.breakStrengthFarmTimer >= 9 then 
					humanoid.Health = 0
					timers.breakMagicFarmbreakStrengthFarmTimerTimer = 0 
				end 
			end 
			timers.strengthFarmTimer = 0
		end
	end 
end 

local function walkOnWater()
	local character = localPlayer.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end
	local j = workspace:FindFirstChild("Yeshua Is Goated")
	if not j then return end 
	j.Position = V3(rootPart.Position.X, ocean.Position.Y, rootPart.Position.Z)
	j.Rotation = V3_0
end 

RunService.Heartbeat:Connect(function(dt)
	if not (toggles.bossFarm or toggles.magicFarm or toggles.strengthFarm or toggles.walkOnWater or toggles.chestESP) then return end
	local target = mouse.Target 

	if toggles.bossFarm then bossFarm(dt, target) end 
	if toggles.magicFarm then magicFarm(dt, target) end
	if toggles.strengthFarm then strengthFarm(dt) end 
	if toggles.walkOnWater then walkOnWater() end 	
	if toggles.chestESP then chestESP() end
end)

local oldNI; oldNI = hookmetamethod(game, "__newindex", function(object, property, value)
	if toggles.infStamina and tostring(object) == "Stamina" and property == "Value" then 
		return oldNI(object, property, HUGE)
	end 

    if toggles.setWalkSpeed and tostring(object) == "Humanoid" and property == "WalkSpeed" then 
		return oldNI(object, property, toggles.walkSpeed)
	end 

	return oldNI(object, property, value)
end)

local old; old = hookfunction(oldMovementModule.Dodge, function(...)
	if toggles.noDashCD then 
		oldMovementModule.CanDodge = true 
	end 

	if toggles.noDashDecay then 
		oldMovementModule.DodgeDecayMultiplier = 1 
	end 
	return old(...) 
end)
