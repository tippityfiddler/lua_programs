repeat task.wait() until game:IsLoaded()
getgenv().AnomalyLoaded = true 
if AnomalyLoaded then 
    getgenv().hooks = {
        disableMobDamage = nil,
        disableMobAI = nil, 
        damageMultiplier = nil 
    } 
end 
-- Services:
-- Self Note: Do Not Copy and Paste Health Bar ESP, Box ESP or Text ESP from MVSD portion of code 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")

local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Essential Variables:
local localPlayer = Players.LocalPlayer 
local camera = workspace.CurrentCamera 
local mouse = localPlayer.GetMouse(localPlayer)

-- Essential Feature/Function/Event Variable Initialization: 
local silentAim, wallbang, playerSpeed, 
boxPlayerAddedEv, boxPlayerRemovingEv, updateBoxEsp, updateTextEsp, 
textPlayerAddedEv, textPlayerRemovingEv, healthBarPlayerAddedEv, healthBarPlayerRemovingEv,
updateHealthBarEsp, showCursor, noFogEv, fullBrightEv, hitboxExpanderTorsoEv, mvsdKillAll

local textEspCache = {}
local boxEspCache = {}
local healthBarEspCache = {}
local boatEspCache = {}
local chestEspCache = {}

local supportedGames = {
    ["Weaponry"] = 3297964905,
    ["War Tycoon"] = 4639625707,
    ["MVSD"] = { ["Pro Server"] = 13771457545, ["Default Server"] = 12355337193 },
    ["Arcane Odyssey"] = { ["Bronze Sea"] = 12604352060, ["Nimbus Sea"] = 15449776494 }
}

local toxicMessages = {
    "Haha you're a loser, ", "Quit the game, ", "Keep crying, ", "You're so dog, ",
    "Never play this game again, ", "Nobody wants you here, ", "Mald, ", "Cope, ",
    "I dislike losers like you, ", "Rage, ", "Stop dying, ", "Why are you so bad, ",
    "You should do us all a favour and quit the game, ", "Please stop wasting our time dog, ",
    "Give up, ", "You're a nerd, ", "Keep raging little mutt, ", "Cope and Seethe, ",
    "Good dog, ", "You're worthless,", "Anomaly on top!"
}

-- Cached Functions/Events:
local loadstring = loadstring 
local connections = getconnections or get_signal_cons
local fenv = getfenv 
local gc = getgc 

local taskWait = task.wait
local tick = tick 
local callMethod = getnamecallmethod
local idled = localPlayer.Idled 

local senv = getsenv 
local coroutineCreate = coroutine.create 
local coroutineResume = coroutine.resume 
local renderStepped = RunService.RenderStepped 

local wtvp = camera.WorldToViewportPoint
local getUpvalues = debug.getupvalues 
local round = math.floor 
local random = math.random 

local callingScript = getcallingscript 
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
local queueTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local playerAdded = Players.PlayerAdded 

local playerRemoving = Players.PlayerRemoving
local taskCancel = task.cancel 
local tenv = gettenv 
local getRegistry = debug.getregistry 

local getNilInstances = getnilinstances 
local getInfo = debug.getinfo 
local inputBegan = UserInputService.InputBegan
local next = next 
local vector2New = Vector2.new 
local vector3New = Vector3.new

-- Essential Hooks and Functions:
local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(...)
    if callMethod() == "Kick" or callMethod():lower() == "kick" then return end
    return oldNamecall(...)
end)
hookfunction(localPlayer.Kick, function() return end)

local function universalHitboxExpander() 
    for i, v in next, Players:GetPlayers() do 
        if v ~= localPlayer and v.Team ~= localPlayer.Team and v.Character then 
            local character = v.Character 

            if character:FindFirstChild("HumanoidRootPart") then 
                local root = character.HumanoidRootPart 

                if root.Size ~= vector3New(15, 15, 15) then 
                    root.Size = vector3New(15, 15, 15) 
                    root.Transparency = 0.5
                    root.Color = Color3.fromRGB(255, 0, 0)
                end 
            end 
        end 

        if v.Team == localPlayer.Team and #Teams:GetChildren() > 0 and v.Character then 
            local character = v.Character 

            if character:FindFirstChild("HumanoidRootPart") then 
                local root = character.HumanoidRootPart 

                if root.Transparency ~= 1 then 
                    root.Transparency = 1 
                end 
            end  
        end 

        if v.Team == localPlayer.Team and #Teams:GetChildren() == 0 then 
            local character = v.Character 

            if character:FindFirstChild("HumanoidRootPart") then 
                local root = character.HumanoidRootPart 

                if root.Size ~= vector3New(15, 15, 15) then 
                    root.Size = vector3New(15, 15, 15) 
                    root.Transparency = 0.5
                    root.Color = Color3.fromRGB(255, 0, 0)
                end 
            end 
        end 
    end 
end 

local function unNoClip()
    if localPlayer.Character then 
        for i, v in pairs(localPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and not v.CanCollide then
                v.CanCollide = true
            end
        end
    end
end

local function noClip()
    if localPlayer.Character then 
        for i, v in pairs(localPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false 
            end
        end
    end
end

local function serverHop()
    local response = httpRequest({Url = "https://games.roblox.com/v1/games/".. game.PlaceId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100"})
    local parsed = HttpService:JSONDecode(response.Body)
    local serverList = {}

    for i, v in next, parsed.data do
        local serverJobId = v.id
        if serverJobId ~= game.JobId then
            table.insert(serverList, serverJobId)
        end
    end
    if #serverList == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR";
            Text = "Couldn't find different servers";
            Duration = 3;
        })
    else
        local randomServer = serverList[random(1, #serverList)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData() or 1)
    end
end

local function rejoinServer() 
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData() or 1)
end 

local function alwaysShowCursor() 
    UserInputService.MouseIconEnabled = true
end 
-- Anti AFK:
local function antiAFK()
    if connections then
        for _, v in pairs(connections(idled)) do
            if v.Disable then
                v:Disable()
            elseif v.Disconnect then
                v:Disconnect()
            end
        end
    else
        idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(vector2New(0, 0))
        end)
    end
end

antiAFK() 

-- Get Closest Player Function:
local function getNearestPlayerHead()
    local target
    local distance = math.huge

    for i, v in next, Players.GetPlayers(Players) do 
        if v ~= localPlayer then 
            if v.Character then
                local character = v.Character

                if not ReplicatedStorage.FindFirstChild(ReplicatedStorage, "HiddenCharacters") then  
                    if localPlayer.Team ~= v.Team and #Teams.GetChildren(Teams) > 0 then 
                        if character.FindFirstChild(character, "Head") and character.FindFirstChild(character, "Humanoid") and  not character.FindFirstChild(character, "ForceField") and not character.FindFirstChild(character, "SpawnShield") and not character.FindFirstChild(character, "BaseShieldForceField")  then 
                            local head = character.Head
                            local humanoid = character.Humanoid

                            if humanoid.Health > 0 then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                
                                if onScreen then 
                                    local distanceFromHead = (vector2New(mouse.X, mouse.Y) - vector2New(headPos.X, headPos.Y)).Magnitude
                
                                    if distanceFromHead < distance then 
                                        distance = distanceFromHead
                                        target = head
                                    end
                                end
                            end
                        end
                        
                    elseif #Teams.GetChildren(Teams) == 0 then 
                        if character.FindFirstChild(character, "Head") and character.FindFirstChild(character, "Humanoid") and  not character.FindFirstChild(character, "ForceField") and not character.FindFirstChild(character, "SpawnShield") and not character.FindFirstChild(character, "BaseShieldForceField")  then 
                            local head = character.Head
                            local humanoid = character.Humanoid

                            if humanoid.Health > 0 then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                
                                if onScreen then 
                                    local distanceFromHead = (vector2New(mouse.X, mouse.Y) - vector2New(headPos.X, headPos.Y)).Magnitude
                
                                    if distanceFromHead < distance then 
                                        distance = distanceFromHead
                                        target = head
                                    end
                                end
                            end
                        end
                    end

                -- MVSD Game Check:
                elseif ReplicatedStorage.FindFirstChild(ReplicatedStorage, "HiddenCharacters") then  
                    local hiddenCharacters = ReplicatedStorage.HiddenCharacters

                    if v ~= localPlayer and localPlayer.Team ~= v.Team and not hiddenCharacters.FindFirstChild(hiddenCharacters, v.Name) then 
                        if character.FindFirstChild(character, "Head") and character.FindFirstChild(character, "Humanoid") and not character.FindFirstChild(character, "ForceField") and not character.FindFirstChild(character, "SpawnShield") and not character.FindFirstChild(character, "BaseShieldForceField") then 
                            local head = character.Head
                            local humanoid = character.Humanoid
    
                            if humanoid.Health > 0 then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                
                                if not mvsdKillAll and silentAim then 
                                    if onScreen then 
                                        local distanceFromHead = (vector2New(mouse.X, mouse.Y) - vector2New(headPos.X, headPos.Y)).Magnitude
                    
                                        if distanceFromHead < distance then 
                                            distance = distanceFromHead
                                            target = head
                                        end
                                    end

                                elseif mvsdKillAll and not silentAim then 
                                    local distanceFromHead = localPlayer.DistanceFromCharacter(localPlayer, head.Position)
                
                                    if distanceFromHead < distance then 
                                        distance = distanceFromHead
                                        target = head
                                    end

                                elseif mvsdKillAll and silentAim then 
                                    local distanceFromHead = localPlayer.DistanceFromCharacter(localPlayer, head.Position)
                
                                    if distanceFromHead < distance then 
                                        distance = distanceFromHead
                                        target = head
                                    end
                                end 
                            end
                        end
                    end
                end 
            end
        
        end 
    end

    return target
end 

local function createDrawing(name, properties)
    local drawing = Drawing.new(name)
    for i, v in next, properties do 
        drawing[i] = v 
    end
    return drawing
end

local function addPlayerToDrawingCache(name, player) -- name refers to the drawing name
    if name == "Text" then 
        if not textEspCache[player] then 
            textEspCache[player] = {
                textEsp = createDrawing(name, { 
                    Color = Color3.fromRGB(255, 0, 0),
                    Text = "", 
                    Visible = false,
                    Center = true, 
                    Outline = true, 
                    Position = vector2New(0, 0),
                    Size = 14,
                    Font = 3
                })
            }
        end 

    elseif name == "Square" then 
        if not boxEspCache[player] then
            boxEspCache[player] = {
                boxEspOutline = createDrawing(name, {
                    Visible = false,
                    Color = Color3.fromRGB(0, 0, 0),
                    Filled = false,
                    Thickness = 2,
                    Transparency = 1
                }),

                boxEsp = createDrawing(name, {
                    Visible = false,
                    Color = Color3.fromRGB(255, 255, 255),
                    Filled = false,
                    Thickness = 1,
                    Transparency = 1
                })
            }
        end
    elseif name == "Health Bar" then 
        if not healthBarEspCache[player] then 
            healthBarEspCache[player] = {
                healthBarOutline = createDrawing("Line", {
                    Visible = false,
                    From = vector2New(0, 0),
                    To = vector2New(0, 0),
                    Color = Color3.fromRGB(0, 0, 0), 
                    Thickness = 6
                }),

                healthBar = createDrawing("Line", {
                    Visible = false,
                    From = vector2New(0, 0),
                    To = vector2New(0, 0),
                    Color = Color3.fromRGB(0, 255, 0), 
                    Thickness = 4
                })
            } 
        end
    elseif name == "Boat Text" then 
        boatEspCache[player] = {
            textEsp = createDrawing("Text", { 
                Color = Color3.fromRGB(255, 0, 0),
                Text = "", 
                Visible = false,
                Center = true, 
                Outline = true, 
                Position = vector2New(0, 0),
                Size = 14,
                Font = 3
            })
        }
    elseif name == "Chest Text" then 
        chestEspCache[player] = {
            textEsp = createDrawing("Text", { 
                Color = Color3.fromRGB(255, 255, 255),
                Text = "", 
                Visible = false,
                Center = true, 
                Outline = true, 
                Position = vector2New(0, 0),
                Size = 14,
                Font = 3
            })
        }
    end 
end 

local function removePlayerDrawingCache(name, player) 
    if name == "Text" then 
        if textEspCache[player] then
            textEspCache[player].textEsp:Remove()
            textEspCache[player] = nil
        end 
    elseif name == "Square" then 
        if boxEspCache[player] then 
            boxEspCache[player].boxEspOutline:Remove()
            boxEspCache[player].boxEsp:Remove()
            boxEspCache[player] = nil
        end 
    elseif name == "Health Bar" then 
        if healthBarEspCache[player] then 
            healthBarEspCache[player].healthBarOutline:Remove()
            healthBarEspCache[player].healthBar:Remove()
            healthBarEspCache[player] = nil
        end     
    elseif name == "Boat Text" then 
        if boatEspCache[player] then
            boatEspCache[player].textEsp:Remove()
            boatEspCache[player] = nil
        end 
    elseif name == "Chest Text" then 
        if chestEspCache[player] then
            chestEspCache[player].textEsp:Remove()
            chestEspCache[player] = nil
        end 
    end 
end 

-- UI Essential Universal Functions/Sections/Tabs/Button:
local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()
local Anomaly = Library:CreateWindow({ Name = "Anomaly", Themeable = { Info = "Discord Server: VzYTJ7Y" } })
local GeneralTab = Anomaly:CreateTab({ Name = "General" })
local LightingSection = GeneralTab:CreateSection({ Name = "Lighting" })
local NoShadows = LightingSection:AddToggle({ Name = "No Shadows", Flag = "No Shadows", Callback = function(v) Lighting.GlobalShadows = not Lighting.GlobalShadows end })
local NoFog = LightingSection:AddToggle({ Name = "No Fog", Flag = "No Fog",
    Callback = function(v)
        if v then 
            if Lighting:FindFirstChild("Atmosphere") then 
                Lighting.Atmosphere.Density = 0    
                noFogEv = Lighting.Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
                    Lighting.Atmosphere.Density = 0
                end)  
            end
        else
            if noFogEv then noFogEv:Disconnect(); noFogEv = nil end 
        end
    end
})
local FullBright = LightingSection:AddToggle({ Name = "Full Bright", Flag = "Full Bright",
    Callback = function(v)
        if v then 
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)

            fullBrightEv = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            end)
        else 
            if fullBrightEv then fullBrightEv:Disconnect(); fullBrightEv = nil end 
        end
    end
})
local PlayerSection = GeneralTab:CreateSection({ Name = "Local Player", Side = "Right" })
local GeneralSection = GeneralTab:CreateSection({ Name = "General" })
local EspSection = GeneralTab:CreateSection({ Name = "Extra Sensory Perception", Side = "Right" })

local RejoinServer = GeneralSection:AddButton({ Name = "Rejoin Server", Callback = function() rejoinServer() end })
local ServerHop = GeneralSection:AddButton({ Name = "Server Hop", Callback = function() serverHop() end })
local InfiniteYield = GeneralSection:AddButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end })

if game.PlaceId == supportedGames["Weaponry"] then 
    -- Weaponry Game Essentials:
    local weaponryFramework = senv(localPlayer.PlayerScripts.WeaponryFramework)
    local weaponHandler = ReplicatedStorage.Remotes.WeaponHandler

    local weaponHandlerFireServer = weaponHandler.FireServer
    local inventoryManager = weaponryFramework.InventoryManager 

    local clientHitHandler = require(ReplicatedStorage.ClientModules.ClientHitHandler)
    local handleHit = clientHitHandler.HandleHit

    local hitboxFolder = workspace.Hitboxes
    -- Weaponry Features Variables Initialization: 
    local rainbowGun, walkspeedEv, infAmmoEv, noSpreadEv, 
    noRecoilEv, primary, secondary, hitboxExpanderHeadEv, rainbowGunChildAddedEv, 
    rainbowGunCharacterAddedEv, autoFireModeEv, autoFireMode
    
    local function getWeaponProperties() 
        if not inventoryManager then repeat taskWait() until inventoryManager end 
        for i, v in next, getUpvalues(inventoryManager) do 
            if type(v) ~= "table" then continue end 
            for i, v in next, v do 
                if type(v) ~= "table" then continue end 
                if i == 1 then 
                    primary = v 
                end 
                if i == 2 then 
                    secondary = v 
                end 
            end 
        end 

        return primary, secondary
    end 

    local cachedParts = {}
    local function cacheRainbowParts(tool)
        cachedParts = {}
        for _, v in ipairs(tool:GetDescendants()) do
            if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("UnionOperation") then
                table.insert(cachedParts, v)

                local surfaceAppearance = v:FindFirstChild("SurfaceAppearance")
                if surfaceAppearance then
                    surfaceAppearance:Destroy()
                end
            end
        end
    end
    local GunModsSection = GeneralTab:CreateSection({ Name = "Gun Modifications", Side = "Right" })
    local SilentAim = GeneralSection:AddToggle({ Name = "Silent Aim", Flag = "Silent Aim", Callback = function(v) silentAim = v end })
    local Wallbang = GeneralSection:AddToggle({ Name = "Wallbang [SNIPERS ONLY]", Flag = "Wallbang [SNIPERS ONLY]", Callback = function(v) wallbang = v end })
    local RainbowGun = GeneralSection:AddToggle({ Name = "Rainbow Gun", Flag = "Rainbow Gun", 
        Callback = function(v) 
            rainbowGun = v
            if v then 
                if localPlayer.Character then 
                    local character = localPlayer.Character
                    local tool = character:FindFirstChildWhichIsA("Tool") 

                    if tool then 
                        cacheRainbowParts(tool)
                    end 
            
                    rainbowGunChildAddedEv = character.ChildAdded:Connect(function(child) 
                        if child:IsA("Tool") and rainbowGun then 
                            cacheRainbowParts(child)
                        end 
                    end)
                end 
                
                rainbowGunCharacterAddedEv = localPlayer.CharacterAdded:Connect(function(character)
                    rainbowGunChildAddedEv = character.ChildAdded:Connect(function(child) 
                        if child:IsA("Tool") and rainbowGun then 
                            cacheRainbowParts(child)
                        end 
                    end)
                end)
            else 
                if rainbowGunCharacterAddedEv then rainbowGunCharacterAddedEv:Disconnect(); rainbowGunCharacterAddedEv = nil end
                if rainbowGunChildAddedEv then rainbowGunChildAddedEv:Disconnect(); rainbowGunChildAddedEv = nil end
                repeat taskWait() cachedParts = {} until #cachedParts == 0
                
            end 
        end 
    })
    local RejoinServer = GeneralSection:AddButton({ Name = "Rejoin Server", Callback = function() rejoinServer() end })
    local ServerHop = GeneralSection:AddButton({ Name = "Server Hop", Callback = function() serverHop() end })
    local InfiniteYield = GeneralSection:AddButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end })
    local AlwaysShowCursor = GeneralSection:AddToggle({ Name = "Always Show Cursor", Flag = "Always Show Cursor", 
        Callback = function(v)
            if v then 
                showCursor = renderStepped:Connect(function()
                    UserInputService.MouseIconEnabled = v 
                end)
            else 
                if showCursor then showCursor:Disconnect(); showCursor = nil end 
            end 
        end
    })

    local HitboxExpanderTorso = GeneralSection:AddToggle({ Name = "Hitbox Expander [TORSO]", Flag = "Hitbox Expander [TORSO]", 
        Callback = function(v) 
            if v then 
                hitboxExpanderTorsoEv = renderStepped:Connect(function() 
                    for i, v in next, Players:GetPlayers() do
                        if v ~= localPlayer then
                            for i, hitbox in next, hitboxFolder:GetChildren() do
                                if tonumber(hitbox.Name) == v.UserId then  -- Checking if the User Id of the player matches the User Id of their hitbox essentially
                                    hitbox.Name = tostring(v)
                                end

                                if v.Name == hitbox.Name then
                                    if #Teams:GetChildren() > 0 and localPlayer.Team ~= v.Team then
                                        if hitbox:FindFirstChild("HitboxBody") then
                                            hitbox.HitboxBody.Transparency = 0.5
                                            hitbox.HitboxBody.Size = vector3New(25, 25, 25)
                                        end
                                    end

                                    if #Teams:GetChildren() == 0 then
                                        if hitbox:FindFirstChild("HitboxBody") then
                                            hitbox.HitboxBody.Transparency = 0.5
                                            hitbox.HitboxBody.Size = vector3New(25, 25, 25)
                                        end
                                    end

                                    if localPlayer.Team == v.Team and #Teams:GetChildren() > 0 then
                                        if hitbox:FindFirstChild("HitboxBody") then
                                            hitbox.HitboxBody.Transparency = 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            else 
                if hitboxExpanderTorsoEv then hitboxExpanderTorsoEv:Disconnect(); hitboxExpanderTorsoEv = nil end 
                for i, hitbox in next, hitboxFolder:GetChildren() do
                    if hitbox:FindFirstChild("HitboxBody") then
                        repeat taskWait()
                            hitbox.HitboxBody.Transparency = 1
                            hitbox.HitboxBody.Size = vector3New(4.1, 2, 1.1)
                        until hitbox.HitboxBody.Transparency == 1 and hitbox.HitboxBody.Size == vector3New(4.1, 2, 1.1)
                    end
                end
            end 
        end 
    })
    local HitboxExpanderHead = GeneralSection:AddToggle({ Name = "Hitbox Expander [HEAD]", Flag = "Hitbox Expander [HEAD]", 
        Callback = function(v) 
            if v then 
                hitboxExpanderHeadEv = renderStepped:Connect(function() 
                    for i, v in next, Players:GetPlayers() do
                        if v ~= localPlayer then
                            for i, hitbox in next, hitboxFolder:GetChildren() do
                                if tonumber(hitbox.Name) == v.UserId then  -- Checking if the User Id of the player matches the User Id of their hitbox essentially
                                    hitbox.Name = tostring(v)
                                end

                                if v.Name == hitbox.Name then
                                    if #Teams:GetChildren() > 0 and localPlayer.Team ~= v.Team then
                                        if hitbox:FindFirstChild("HitboxHead") then
                                            hitbox.HitboxHead.Transparency = 0.5
                                            hitbox.HitboxHead.Size = vector3New(25, 25, 25)
                                        end
                                    end

                                    if #Teams:GetChildren() == 0 then
                                        if hitbox:FindFirstChild("HitboxHead") then
                                            hitbox.HitboxHead.Transparency = 0.5
                                            hitbox.HitboxHead.Size = vector3New(25, 25, 25)
                                        end
                                    end

                                    if localPlayer.Team == v.Team and #Teams:GetChildren() > 0 then
                                        if hitbox:FindFirstChild("HitboxHead") then
                                            hitbox.HitboxHead.Transparency = 1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            else 
                if hitboxExpanderHeadEv then hitboxExpanderHeadEv:Disconnect(); hitboxExpanderHeadEv = nil end 
                for i, hitbox in next, hitboxFolder:GetChildren() do
                    if hitbox:FindFirstChild("HitboxHead") then
                        repeat taskWait()
                            hitbox.HitboxHead.Transparency = 1
                            hitbox.HitboxHead.Size = vector3New(4.1, 2, 1.1)
                        until hitbox.HitboxHead.Transparency == 1 and hitbox.HitboxHead.Size == vector3New(4.1, 2, 1.1)
                    end
                end
            end 
        end 
    })
    local AutomatciFireMode = GunModsSection:AddButton({ Name = "Automatic Fire Mode",
        Callback = function()
            if not autoFireMode then 
                autoFireMode = true 
                autoFireModeEv = renderStepped:Connect(function()
                    local primary, secondary = getWeaponProperties()
                    if primary then 
                        primary.WeaponStats.FireMode = {Name = "Auto", Round = 1}
                    end
                    if secondary then 
                        secondary.WeaponStats.FireMode = {Name = "Auto", Round = 1}
                    end
                end)
            end 
        end
    })
    local InfAmmo = GunModsSection:AddToggle({ Name = "Inf Ammo",  Flag = "Inf Ammo", 
        Callback = function(v) 
            if v then 
                infAmmoEv = renderStepped:Connect(function()
                    local primary, secondary = getWeaponProperties()
                    if primary and primary.CurrentAmmo and primary.WeaponStats.MaxAmmo and primary.CurrentAmmo < primary.WeaponStats.MaxAmmo then 
                        primary.Reloading = true
                        weaponHandler:FireServer(3, primary)
                        primary.CurrentAmmo = primary.WeaponStats.MaxAmmo
                        primary.Reloading = false
                    end
                    if secondary and secondary.CurrentAmmo and secondary.WeaponStats.MaxAmmo and secondary.CurrentAmmo < secondary.WeaponStats.MaxAmmo then 
                        secondary.Reloading = true
                        weaponHandler:FireServer(3, secondary)
                        secondary.CurrentAmmo = secondary.WeaponStats.MaxAmmo
                        secondary.Reloading = false
                    end
                end)
            else 
                if infAmmoEv then infAmmoEv:Disconnect(); infAmmoEv = nil end
            end 
        end 
    })
    local NoSpread = GunModsSection:AddToggle({ Name = "No Spread", Flag = "No Spread", 
        Callback = function(v) 
            if v then 
                noSpreadEv = renderStepped:Connect(function()
                    local primary, secondary = getWeaponProperties()
                    if primary then 
                        primary.WeaponStats.Spread = {
                            [1] = vector2New(0, 0),
                            [2] = vector2New(0, 0),
                            [3] = vector2New(0, 0),
                            [4] = vector2New(0, 0),
                            [5] = vector2New(0, 0),
                            [6] = vector2New(0, 0),
                            [7] = vector2New(0, 0),
                            [8] = vector2New(0, 0),
                            [9] = vector2New(0, 0)
                        }
                    end 
                    if secondary then 
                        secondary.WeaponStats.Spread = {
                            [1] = vector2New(0, 0),
                            [2] = vector2New(0, 0),
                            [3] = vector2New(0, 0),
                            [4] = vector2New(0, 0),
                            [5] = vector2New(0, 0),
                            [6] = vector2New(0, 0),
                            [7] = vector2New(0, 0),
                            [8] = vector2New(0, 0),
                            [9] = vector2New(0, 0)
                        }
                    end 
                end)
            else 
                if noSpreadEv then noSpreadEv:Disconnect(); noSpreadEv = nil end 
            end 
        end 
    })
    local NoRecoil = GunModsSection:AddToggle({ Name = "No Recoil", Flag = "No Recoil", 
        Callback = function(v) 
            if v then 
                noRecoilEv = renderStepped:Connect(function()
                    local primary, secondary = getWeaponProperties()
                    if primary then 
                        primary.WeaponStats.RecoilData = { ["y"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 }, ["x"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 }, ["z"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 } } 
                    end 
                    if secondary then 
                        secondary.WeaponStats.RecoilData = { ["y"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 }, ["x"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 }, ["z"] = { ["Damper"] = 0, ["Speed"] = 0, ["MaxAngle"] = 0, ["ADSreduction"] = 0, ["MinAngle"] = 0 } } 
                    end 
                end)
                                            
            else 
                if noRecoilEv then noRecoilEv:Disconnect(); noRecoilEv = nil end 
            end 
        end 
    })
    local PlayerSpeed = PlayerSection:AddSlider({ Name = "Player Walkspeed", Flag = "Player Walkspeed", Value = 16, Min = 16, Max = 250, Callback = function(v) playerSpeed = v end })
    local SetSpeed = PlayerSection:AddToggle({ Name = "Set Walkspeed", Flag = "Set Walkspeed",
        Callback = function(v)
            if v then 
                walkspeedEv = renderStepped:Connect(function()
                    if playerSpeed then 
                        if localPlayer.Character then 
                            local character = localPlayer.Character
                            
                            if character:FindFirstChild("Humanoid") then 
                                local humanoid = character.Humanoid

                                humanoid.WalkSpeed = playerSpeed
                            end
                        end
                    end
                end)

            else 
                if walkspeedEv then walkspeedEv:Disconnect(); walkspeedEv = nil end 
                repeat taskWait() 
                    if localPlayer.Character then 
                        local character = localPlayer.Character
                        
                        if character:FindFirstChild("Humanoid") then 
                            local humanoid = character.Humanoid

                            humanoid.WalkSpeed = 16
                        end
                    end
                until localPlayer.Character.Humanoid.WalkSpeed == 16
    
            end 
        end
    })
    local BoxESP = EspSection:CreateToggle({ Name = "Box ESP", CurrentValue = false, Flag = "Box ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Square", v)
                    end 
                end 

                boxPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Square", player) end)
                boxPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Square", player) end)

                updateBoxEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, boxEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local displayed = false

                        local boxOutline = cachedDrawings.boxEspOutline
                        local box = cachedDrawings.boxEsp

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")

                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)
                    
                                if onScreen and humanoid.Health > 0 then 
                                    box.Size = newSize
                                    box.Position = vector2New(headPos.X - newSize.X / 2, headPos.Y - newSize.Y / 1.2)

                                    boxOutline.Size = box.Size 
                                    boxOutline.Position = box.Position
                                    
                                    boxOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    box.Visible = boxOutline.Visible

                                else 
                                    boxOutline.Visible = false 
                                    box.Visible = false
                                end 

                            else 
                                boxOutline.Visible = false 
                                box.Visible = false
                            end 

                        else 
                            boxOutline.Visible = false 
                            box.Visible = false
                        end 
                    end 
                end)
            else 
                if boxPlayerAddedEv then boxPlayerAddedEv:Disconnect(); boxPlayerAddedEv = nil end 
                if boxPlayerRemovingEv then boxPlayerRemovingEv:Disconnect(); boxPlayerRemovingEv = nil end 
                if updateBoxEsp then updateBoxEsp:Disconnect(); updateBoxEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Square", v)
                end 
            end 
        end 
    })
    local TextESP = EspSection:CreateToggle({ Name = "Text ESP", CurrentValue = false, Flag = "Text ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Text", v)
                    end 
                end 

                textPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Text", player) end)
                textPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Text", player) end)

                updateTextEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, textEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        local isFFA = #Teams:GetChildren() == 0

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
                            local root = character:FindFirstChild("HumanoidRootPart")

                            if head and humanoid and root then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local rootPos, onScreen = wtvp(camera, root.Position)

                                if onScreen and humanoid.Health > 0 then 
                                    local distanceFromHeadPos = round(localPlayer:DistanceFromCharacter(head.Position))
                                    local health = round(humanoid.Health)
                                    local maxHealth = round(humanoid.MaxHealth)

                                    textEsp.Text = "[" .. player.Name .. "]" .. "[" .. distanceFromHeadPos .. "] \n [" .. health .. "/" .. maxHealth .. "]"
                                    textEsp.Color = Color3.fromRGB(255, 255, 255)
                                    textEsp.Position = vector2New(headPos.X, headPos.Y)
                                    textEsp.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen

                                else 
                                    textEsp.Visible = false 
                                end 

                            else 
                                textEsp.Visible = false 
                            end 

                        else 
                            textEsp.Visible = false 
                        end 
                    end 
                end)

            else 
                if textPlayerAddedEv then textPlayerAddedEv:Disconnect(); textPlayerAddedEv = nil end 
                if textPlayerRemovingEv then textPlayerRemovingEv:Disconnect(); textPlayerRemovingEv = nil end 
                if updateTextEsp then updateTextEsp:Disconnect(); updateTextEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Text", v)
                end 
            end 
        end 
    })
    local HealthBarESP = EspSection:CreateToggle({ Name = "Health Bar ESP", CurrentValue = false, Flag = "Health Bar ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Health Bar", v)
                    end 
                end 

                healthBarPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Health Bar", player) end)
                healthBarPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Health Bar", player) end)

                updateHealthBarEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, healthBarEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local healthBarOutline = cachedDrawings.healthBarOutline
                        local healthBar = cachedDrawings.healthBar

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
 
                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)           
                                local healthBarWidth = 10
                                local healthBarHeight = newSize.Y * (humanoid.Health / humanoid.MaxHealth)

                                local healthBarX = (headPos.X - newSize.X / 2) + newSize.X - 10
                                local healthBarY = (headPos.Y - newSize.Y / 1.2)
                                local healthBarFraction = humanoid.Health / humanoid.MaxHealth

                                if onScreen and humanoid.Health > 0 then 
                                    healthBarOutline.From = vector2New(healthBarX, healthBarY)
                                    healthBarOutline.To = vector2New(healthBarX, healthBarY + newSize.Y)
                                    healthBarOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    healthBarOutline.ZIndex = 1 

                                    healthBar.From = vector2New(healthBarX, healthBarY)
                                    healthBar.To = vector2New(healthBarX, healthBarY + healthBarHeight)
                                    healthBar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), healthBarFraction)
                                    healthBar.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen and healthBarOutline.Visible
                                    healthBar.ZIndex = 2 

                                else 
                                    healthBar.Visible = false
                                    healthBarOutline.Visible = false 
                                end 

                            else 
                                healthBar.Visible = false
                                healthBarOutline.Visible = false 
                            end 

                        else 
                            healthBar.Visible = false
                            healthBarOutline.Visible = false 
                        end                    
                    end 
                end)

            else 
                if healthBarPlayerAddedEv then healthBarPlayerAddedEv:Disconnect(); healthBarPlayerAddedEv = nil end 
                if healthBarPlayerRemovingEv then healthBarPlayerRemovingEv:Disconnect(); healthBarPlayerRemovingEv = nil end 
                if updateHealthBarEsp then updateHealthBarEsp:Disconnect(); updateHealthBarEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Health Bar", v)
                end 
            end 
        end 
    })

    local function updateRainbowGun()
        for _, v in ipairs(cachedParts) do
            local rainbowCalculation = tick() % 5 / 5
            v.Color = Color3.fromHSV(rainbowCalculation, 1, 1)
            v.Transparency = 0.5
            v.Material = Enum.Material.ForceField
        end
    end
    coroutineResume(coroutineCreate(function()
        while taskWait(0.1) do 
            if rainbowGun then 
                updateRainbowGun()
            end
        end
    end))
    -- Wallbang Hook:
    local oldHandleHit; oldHandleHit = hookfunction(handleHit, function(...)
        local args = { ... }

        if getNearestPlayerHead() and wallbang then 
            local closestPlayerHead = getNearestPlayerHead() 
            args[3] = {
                ["HitPos"] = closestPlayerHead.Position, 
                ["HitObj"] = closestPlayerHead, 
                ["HitNorm"] = closestPlayerHead.Position,
                ["HitChar"] = closestPlayerHead.Parent,
                ["HitPlr"] = Players[closestPlayerHead.Parent.Name],
                ["isChar"] = true,
                ["isHitbox"] = true, 
                ["Distance"] = localPlayer:DistanceFromCharacter(closestPlayerHead.Position)
            }   
        end 

        return oldHandleHit(unpack(args))
    end)
    -- Silent Aim Hook:
    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(...)
        local args = { ... }
        if callMethod() == "Raycast" and tostring(callingScript()) == "WeaponryFramework" and getNearestPlayerHead() and silentAim then 
            local closestPlayerHead = getNearestPlayerHead()
            args[2] = camera.CFrame.Position
            args[3] = (closestPlayerHead.Position - args[2]).Unit * 1000
        end
        
        return oldNamecall(unpack(args))
    end)

elseif game.PlaceId == supportedGames["War Tycoon"] then 
    -- War Tycoon Feature Variables/Functions/Events Initialization:
    local noFallDmg, gunMods, hasGunBeenShot, gunModsChildAddedEv,
    characterAddedGunModsEv
    local usedGuns = {} 

    local function applyGunMods(tool, character)
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
        local settings = tool:FindFirstChild("Settings", true)
        if settings then
            local gunSettings = require(settings)
            
            -- Set gun properties
            gunSettings.Mode = "Auto"
            gunSettings.FireModes = {Semi = false, Auto = true, Burst = false}
            gunSettings.Ammo = math.huge
            gunSettings.FireRate = 1e14  
            gunSettings.BSpeed = 1e6     
            gunSettings.DamageMultiplier = math.huge

            -- No Recoil
            gunSettings.MinRecoilPower = 0
            gunSettings.VRecoil = {0, 0}
            gunSettings.HRecoil = {0, 0}
            gunSettings.MaxRecoilPower = 0
            gunSettings.AimRecoilReduction = math.huge
            gunSettings.RecoilPowerStepAmount = 0
            gunSettings.RecoilPunch = 0

            -- No Spread
            gunSettings.MinSpread = 0
            gunSettings.MaxSpread = 0
        end

        tool.Parent = localPlayer.Backpack 
        localPlayer.Backpack[tool.Name].Parent = character
    end

    local GunModsSection = GeneralTab:CreateSection({ Name = "Gun Modifications", Side = "Right" })
    local SilentAim = GeneralSection:AddToggle({ Name = "Silent Aim", Flag = "Silent Aim [War Tycoon]", Callback = function(v) silentAim = v end })
    local Wallbang = GeneralSection:AddToggle({ Name = "Wallbang [SILENT AIM]", Flag = "Wallbang [War Tycoon]", Callback = function(v) wallbang = v end })
    local NoFallDMG = GeneralSection:AddToggle({ Name = "No Fall DMG", Flag = "No Fall DMG [War Tycoon]", Callback = function(v) noFallDmg = v end })
    local HitboxExpanderTorso = GeneralSection:AddToggle({ Name = "Hitbox Expander [TORSO]", Flag = "Hitbox Expander [TORSO WAR TYCOON]",
        Callback = function(v)
            if v then 
                hitboxExpanderTorsoEv = renderStepped:Connect(function()
                    universalHitboxExpander()
                end)

            else 
                if hitboxExpanderTorsoEv then hitboxExpanderTorsoEv:Disconnect(); hitboxExpanderTorsoEv = nil end 
                for i, v in next, Players:GetPlayers() do 
                    if v.Character then 
                        local character = v.Character
                        if character:FindFirstChild("HumanoidRootPart") then 
                            local root = character.HumanoidRootPart 
                            repeat taskWait() root.Transparency = 1; root.Size = vector3New(2, 2, 1)  until root.Transparency == 1
                        end 
                    end 
                end 
            end 
        end
    })

    local GunMods = GunModsSection:AddToggle({ Name = "Gun Mods", Flag = "Gun Mods [War Tycoon]", 
        Callback = function(v) 
            gunMods = v 
            if v then 
                if localPlayer.Character then 
                    StarterGui:SetCore("SendNotification", {
                        Title = "Gun Mods",
                        Text = "Shoot your gun!",
                        Duration = 3
                    })
                    local character = localPlayer.Character 
                
                    if character:FindFirstChildWhichIsA("Tool") then 
                        local tool = character:FindFirstChildWhichIsA("Tool")
                        local toolName = tool.Name 
                        
                        if tool:FindFirstChild("Settings", true) and require(tool:FindFirstChild("Settings", true)).Ammo ~= math.huge then 
                            if not table.find(usedGuns, toolName) and not hasGunBeenShot then 
                                repeat taskWait() until hasGunBeenShot
                                table.insert(usedGuns, toolName)
                                applyGunMods(tool, character)
                            end
                        end
                    end 
                
                    gunModsChildAddedEv = character.ChildAdded:Connect(function(child)
                        if child:IsA("Tool") then
                            local tool = child
                            local toolName = tool.Name
                            if not table.find(usedGuns, child.Name) and not hasGunBeenShot then 
                                if tool:FindFirstChild("Settings", true) and require(tool:FindFirstChild("Settings", true)).Ammo ~= math.huge then 
                                    repeat taskWait() until hasGunBeenShot
                                    table.insert(usedGuns, toolName)
                                    applyGunMods(tool, character)
                                end
                            end 
                
                            if not table.find(usedGuns, child.Name) and hasGunBeenShot then 
                                hasGunBeenShot = false 
                                repeat taskWait() until hasGunBeenShot

                                table.insert(usedGuns, toolName)
                                applyGunMods(tool, character)
                            end 
                        end
                    end)
                end 
                
                characterAddedGunModsEv = localPlayer.CharacterAdded:Connect(function(character)
                    hasGunBeenShot = false 
                    usedGuns = {}
                
                    gunModsChildAddedEv = character.ChildAdded:Connect(function(child)
                        if child:IsA("Tool") then
                            local tool = child
                            local toolName = tool.Name
                            if not table.find(usedGuns, child.Name) and not hasGunBeenShot then 
                                if tool:FindFirstChild("Settings", true) and require(tool:FindFirstChild("Settings", true)).Ammo ~= math.huge then 
                                    repeat taskWait() until hasGunBeenShot
                                    table.insert(usedGuns, toolName)
                                    applyGunMods(tool, character)
                                end
                            end 
                
                            if not table.find(usedGuns, child.Name) and hasGunBeenShot then 
                                hasGunBeenShot = false 
                                repeat taskWait() until hasGunBeenShot
                                table.insert(usedGuns, toolName)
                                applyGunMods(tool, character)
                            end 
                        end
                    end)
                end)    
            else 
                if gunModsChildAddedEv then gunModsChildAddedEv:Disconnect(); gunModsChildAddedEv = nil end 
                if characterAddedGunModsEv then characterAddedGunModsEv:Disconnect(); characterAddedGunModsEv = nil end     
            end 
        end 
    })
    local BoxESP = EspSection:CreateToggle({ Name = "Box ESP", CurrentValue = false, Flag = "Box ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Square", v)
                    end 
                end 

                boxPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Square", player) end)
                boxPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Square", player) end)

                updateBoxEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, boxEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local displayed = false

                        local boxOutline = cachedDrawings.boxEspOutline
                        local box = cachedDrawings.boxEsp

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")

                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)
                    
                                if onScreen and humanoid.Health > 0 then 
                                    box.Size = newSize
                                    box.Position = vector2New(headPos.X - newSize.X / 2, headPos.Y - newSize.Y / 1.2)

                                    boxOutline.Size = box.Size 
                                    boxOutline.Position = box.Position
                                    
                                    boxOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    box.Visible = boxOutline.Visible

                                else 
                                    boxOutline.Visible = false 
                                    box.Visible = false
                                end 

                            else 
                                boxOutline.Visible = false 
                                box.Visible = false
                            end 

                        else 
                            boxOutline.Visible = false 
                            box.Visible = false
                        end 
                    end 
                end)
            else 
                if boxPlayerAddedEv then boxPlayerAddedEv:Disconnect(); boxPlayerAddedEv = nil end 
                if boxPlayerRemovingEv then boxPlayerRemovingEv:Disconnect(); boxPlayerRemovingEv = nil end 
                if updateBoxEsp then updateBoxEsp:Disconnect(); updateBoxEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Square", v)
                end 
            end 
        end 
    })
    local TextESP = EspSection:CreateToggle({ Name = "Text ESP", CurrentValue = false, Flag = "Text ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Text", v)
                    end 
                end 

                textPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Text", player) end)
                textPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Text", player) end)

                updateTextEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, textEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        local isFFA = #Teams:GetChildren() == 0

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
                            local root = character:FindFirstChild("HumanoidRootPart")

                            if head and humanoid and root then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local rootPos, onScreen = wtvp(camera, root.Position)

                                if onScreen and humanoid.Health > 0 then 
                                    local distanceFromHeadPos = round(localPlayer:DistanceFromCharacter(head.Position))
                                    local health = round(humanoid.Health)
                                    local maxHealth = round(humanoid.MaxHealth)

                                    textEsp.Text = "[" .. player.Name .. "]" .. "[" .. distanceFromHeadPos .. "] \n [" .. health .. "/" .. maxHealth .. "]"
                                    textEsp.Color = Color3.fromRGB(255, 255, 255)
                                    textEsp.Position = vector2New(headPos.X, headPos.Y)
                                    textEsp.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen

                                else 
                                    textEsp.Visible = false 
                                end 

                            else 
                                textEsp.Visible = false 
                            end 

                        else 
                            textEsp.Visible = false 
                        end 
                    end 
                end)

            else 
                if textPlayerAddedEv then textPlayerAddedEv:Disconnect(); textPlayerAddedEv = nil end 
                if textPlayerRemovingEv then textPlayerRemovingEv:Disconnect(); textPlayerRemovingEv = nil end 
                if updateTextEsp then updateTextEsp:Disconnect(); updateTextEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Text", v)
                end 
            end 
        end 
    })
    local HealthBarESP = EspSection:CreateToggle({ Name = "Health Bar ESP", CurrentValue = false, Flag = "Health Bar ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Health Bar", v)
                    end 
                end 

                healthBarPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Health Bar", player) end)
                healthBarPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Health Bar", player) end)

                updateHealthBarEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, healthBarEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local healthBarOutline = cachedDrawings.healthBarOutline
                        local healthBar = cachedDrawings.healthBar

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
 
                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)           
                                local healthBarWidth = 10
                                local healthBarHeight = newSize.Y * (humanoid.Health / humanoid.MaxHealth)

                                local healthBarX = (headPos.X - newSize.X / 2) + newSize.X - 10
                                local healthBarY = (headPos.Y - newSize.Y / 1.2)
                                local healthBarFraction = humanoid.Health / humanoid.MaxHealth

                                if onScreen and humanoid.Health > 0 then 
                                    healthBarOutline.From = vector2New(healthBarX, healthBarY)
                                    healthBarOutline.To = vector2New(healthBarX, healthBarY + newSize.Y)
                                    healthBarOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    healthBarOutline.ZIndex = 1 

                                    healthBar.From = vector2New(healthBarX, healthBarY)
                                    healthBar.To = vector2New(healthBarX, healthBarY + healthBarHeight)
                                    healthBar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), healthBarFraction)
                                    healthBar.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen and healthBarOutline.Visible
                                    healthBar.ZIndex = 2 

                                else 
                                    healthBar.Visible = false
                                    healthBarOutline.Visible = false 
                                end 

                            else 
                                healthBar.Visible = false
                                healthBarOutline.Visible = false 
                            end 

                        else 
                            healthBar.Visible = false
                            healthBarOutline.Visible = false 
                        end                    
                    end 
                end)

            else 
                if healthBarPlayerAddedEv then healthBarPlayerAddedEv:Disconnect(); healthBarPlayerAddedEv = nil end 
                if healthBarPlayerRemovingEv then healthBarPlayerRemovingEv:Disconnect(); healthBarPlayerRemovingEv = nil end 
                if updateHealthBarEsp then updateHealthBarEsp:Disconnect(); updateHealthBarEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Health Bar", v)
                end 
            end 
        end 
    })
    -- Essential Hooks for Gun Mods/No Fall DMG/Silent Aim/Wallbang
    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if noFallDmg then 
            if self.Name == "FDMG" then return end
        end 
        return oldNamecall(self, ...)
    end)

    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        if gunMods then 
            if self.Name == "FireGun" then hasGunBeenShot = true end
        end 
        return oldNamecall(self, ...)
    end)

    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(...)
        local args = { ... }
        if silentAim then
            if callMethod() == "Raycast" and getNearestPlayerHead() then 
                local closestPlayerHead = getNearestPlayerHead()
                args[2] = camera.CFrame.Position
                args[3] = (closestPlayerHead.Position - args[2]).Unit * 1000000
            end
        end 
        return oldNamecall(unpack(args))
    end)

    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = { ... }
        if wallbang then
            if callMethod() == "FireServer" and getNearestPlayerHead() and self.Name == "BulletHit" then 
                local closestPlayerHead = getNearestPlayerHead()

                args[2] = closestPlayerHead
                args[3] = closestPlayerHead.Position
            end
        end 
        return oldNamecall(self, unpack(args))
    end)

elseif game.PlaceId == supportedGames["MVSD"]["Default Server"] or game.PlaceId == supportedGames["MVSD"]["Pro Server"] then 
    -- MVSD Game Essentials:
    local hiddenCharacters = ReplicatedStorage.HiddenCharacters
    local killAllEv, noGunshotCdEv, instaKnifeThrowEv

    local function disableAntiCheat()
        local antiCheatScript

        for i, v in next, getNilInstances() do
            if game.IsA(v, "LocalScript") and v.Name == "BAC_" then
                antiCheatScript = v
                break
            end
        end

        for i, v in next, getRegistry() do
            if type(v) == "thread" and tenv(v).script == antiCheatScript then
                taskCancel(v)
            end
        end
    end
    
    disableAntiCheat() 

    local SilentAim = GeneralSection:AddToggle({ Name = "Silent Aim", Flag = "Silent Aim [MVSD]", Callback = function(v) silentAim = v end })
    local KillAll = GeneralSection:AddToggle({ Name = "Kill All", Flag = "Kill All [MVSD]", 
        Callback = function(v) 
            mvsdKillAll = v 
           if v then
                killAllEv = renderStepped:Connect(function()
                    if localPlayer.Character then
                        local character = localPlayer.Character
                        if character:FindFirstChild("HumanoidRootPart") and getNearestPlayerHead() then
                            local root = character.HumanoidRootPart
                            local part = getNearestPlayerHead():FindFirstChild("Part")
                            if part then
                                local shootRemote = ReplicatedStorage.Remotes.Shoot
                                local args = { [1] = root.Position, [2] = vector3New(-210.20181274414062, 172.1002197265625, -92.3746337890625), [3] = part, [4] = part.Position }
                                shootRemote:FireServer(unpack(args)) 
                            end
                        end

                        if character:FindFirstChildWhichIsA("Tool") then 
                            local tool = character:FindFirstChildWhichIsA("Tool") 
                            if not tool:GetAttribute("Cooldown") and tool then 
                                tool.Parent = backpack
                            end 
                        end
                        for i, v in next, localPlayer.Backpack:GetChildren() do 
                            if v:IsA("Tool") and v:GetAttribute("Cooldown") then 
                                if localPlayer.Character then
                                    v.Parent = localPlayer.Character 
                                end
                            end 
                        end 
                    end
                end)
            else 
                if killAllEv then killAllEv:Disconnect(); killAllEv = nil end 
            end
        end 
    })
    local NoGunshotCD = GeneralSection:AddToggle({ Name = "No Gunshot CD", Flag = "No Gunshot CD",
        Callback = function(v)
            if v then 
                noGunshotCdEv = renderStepped:Connect(function()
                    local backpack = localPlayer.Backpack
                    for i, v in next, backpack:GetChildren() do 
                        if v:GetAttribute("Cooldown") and v:GetAttribute("Cooldown") ~= 0 then 
                            v:SetAttribute("Cooldown", 0)
                        end    
                    end 
    
                    if localPlayer.Character then 
                        local character = localPlayer.Character 
                
                        if character:FindFirstChildWhichIsA("Tool") then 
                            local tool = character:FindFirstChildWhichIsA("Tool") 
                            
                            if tool:GetAttribute("Cooldown") and tool:GetAttribute("Cooldown") ~= 0 then 
                                tool:SetAttribute("Cooldown", 0)
                                local toolName = tool.Name
                                tool.Parent = backpack
                                backpack[toolName].Parent = character
                            end         
                        end 
                    end
                end)
    
            else 
                if noGunshotCdEv then noGunshotCdEv:Disconnect(); noGunshotCdEv = nil end 
            end 
        end
    })
    local InstantKnifeThrow = GeneralSection:AddToggle({ Name = "Insta Knife Throw", Flag = "Insta Knife Throw",
        Callback = function(v)
            if v then 
                instaKnifeThrowEv = renderStepped:Connect(function()
                    local backpack = localPlayer.Backpack
                    for i, v in next, backpack:GetChildren() do 
                        if v:GetAttribute("ThrowSpeed") and v:GetAttribute("ThrowSpeed") ~= 1000000000000000 then 
                            v:SetAttribute("ThrowSpeed", 1000000000000000)
                        end    
                    end 
                
                    if localPlayer.Character then 
                        local character = localPlayer.Character 
                
                        if character:FindFirstChildWhichIsA("Tool") then 
                            local tool = character:FindFirstChildWhichIsA("Tool") 
                            
                            if tool:GetAttribute("ThrowSpeed") and tool:GetAttribute("ThrowSpeed") ~= 1000000000000000 then 
                                tool:SetAttribute("ThrowSpeed", 1000000000000000)
                                local toolName = tool.Name
                                tool.Parent = backpack
                                backpack[toolName].Parent = character
                            end         
                        end 
                    end
                end)
        
            else 
                if instaKnifeThrowEv then instaKnifeThrowEv:Disconnect(); instaKnifeThrowEv = nil end 
            end 
        end
    })
    local HitboxExpanderTorso = GeneralSection:AddToggle({ Name = "Hitbox Expander [TORSO]", Flag = "Hitbox Expander [TORSO]", 
        Callback = function(v) 
           if v then
                hitboxExpanderTorsoEv = renderStepped:Connect(function()
                    universalHitboxExpander()
                end)
            else 
                if hitboxExpanderTorsoEv then hitboxExpanderTorsoEv:Disconnect(); hitboxExpanderTorsoEv = nil end 
            end
        end 
    })

    local BoxESP = EspSection:CreateToggle({ Name = "Box ESP", CurrentValue = false, Flag = "Box ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Square", v)
                    end 
                end 

                boxPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Square", player) end)
                boxPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Square", player) end)

                updateBoxEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, boxEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local displayed = false

                        local boxOutline = cachedDrawings.boxEspOutline
                        local box = cachedDrawings.boxEsp

                        if player.Character and not hiddenCharacters.FindFirstChild(hiddenCharacters, player.Name) then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")

                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)
                    
                                if onScreen and humanoid.Health > 0 then 
                                    box.Size = newSize
                                    box.Position = vector2New(headPos.X - newSize.X / 2, headPos.Y - newSize.Y / 1.2)

                                    boxOutline.Size = box.Size 
                                    boxOutline.Position = box.Position
                                    
                                    boxOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    box.Visible = boxOutline.Visible

                                else 
                                    boxOutline.Visible = false 
                                    box.Visible = false
                                end 

                            else 
                                boxOutline.Visible = false 
                                box.Visible = false
                            end 

                        else 
                            boxOutline.Visible = false 
                            box.Visible = false
                        end 
                    end 
                end)
            else 
                if boxPlayerAddedEv then boxPlayerAddedEv:Disconnect(); boxPlayerAddedEv = nil end 
                if boxPlayerRemovingEv then boxPlayerRemovingEv:Disconnect(); boxPlayerRemovingEv = nil end 
                if updateBoxEsp then updateBoxEsp:Disconnect(); updateBoxEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Square", v)
                end 
            end 
        end 
    })
    local TextESP = EspSection:CreateToggle({ Name = "Text ESP", CurrentValue = false, Flag = "Text ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Text", v)
                    end 
                end 

                textPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Text", player) end)
                textPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Text", player) end)

                updateTextEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, textEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        local isFFA = #Teams:GetChildren() == 0

                        if player.Character and not hiddenCharacters.FindFirstChild(hiddenCharacters, player.Name) then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
                            local root = character:FindFirstChild("HumanoidRootPart")

                            if head and humanoid and root then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local rootPos, onScreen = wtvp(camera, root.Position)

                                if onScreen and humanoid.Health > 0 then 
                                    local distanceFromHeadPos = round(localPlayer:DistanceFromCharacter(head.Position))
                                    local health = round(humanoid.Health)
                                    local maxHealth = round(humanoid.MaxHealth)

                                    textEsp.Text = "[" .. player.Name .. "]" .. "[" .. distanceFromHeadPos .. "] \n [" .. health .. "/" .. maxHealth .. "]"
                                    textEsp.Color = Color3.fromRGB(255, 255, 255)
                                    textEsp.Position = vector2New(headPos.X, headPos.Y)
                                    textEsp.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen

                                else 
                                    textEsp.Visible = false 
                                end 

                            else 
                                textEsp.Visible = false 
                            end 

                        else 
                            textEsp.Visible = false 
                        end 
                    end 
                end)

            else 
                if textPlayerAddedEv then textPlayerAddedEv:Disconnect(); textPlayerAddedEv = nil end 
                if textPlayerRemovingEv then textPlayerRemovingEv:Disconnect(); textPlayerRemovingEv = nil end 
                if updateTextEsp then updateTextEsp:Disconnect(); updateTextEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Text", v)
                end 
            end 
        end 
    })
    local HealthBarESP = EspSection:CreateToggle({ Name = "Health Bar ESP", CurrentValue = false, Flag = "Health Bar ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Health Bar", v)
                    end 
                end 

                healthBarPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Health Bar", player) end)
                healthBarPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Health Bar", player) end)

                updateHealthBarEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, healthBarEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local healthBarOutline = cachedDrawings.healthBarOutline
                        local healthBar = cachedDrawings.healthBar

                        if player.Character and not hiddenCharacters.FindFirstChild(hiddenCharacters, player.Name) then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")

                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)           
                                local healthBarWidth = 10
                                local healthBarHeight = newSize.Y * (humanoid.Health / humanoid.MaxHealth)

                                local healthBarX = (headPos.X - newSize.X / 2) + newSize.X - 10
                                local healthBarY = (headPos.Y - newSize.Y / 1.2)
                                local healthBarFraction = humanoid.Health / humanoid.MaxHealth

                                if onScreen and humanoid.Health > 0 then 
                                    healthBarOutline.From = vector2New(healthBarX, healthBarY)
                                    healthBarOutline.To = vector2New(healthBarX, healthBarY + newSize.Y)
                                    healthBarOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    healthBarOutline.ZIndex = 1 

                                    healthBar.From = vector2New(healthBarX, healthBarY)
                                    healthBar.To = vector2New(healthBarX, healthBarY + healthBarHeight)
                                    healthBar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), healthBarFraction)
                                    healthBar.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen and healthBarOutline.Visible
                                    healthBar.ZIndex = 2 

                                else 
                                    healthBar.Visible = false
                                    healthBarOutline.Visible = false 
                                end 

                            else 
                                healthBar.Visible = false
                                healthBarOutline.Visible = false 
                            end 

                        else 
                            healthBar.Visible = false
                            healthBarOutline.Visible = false 
                        end                    
                    end 
                end)

            else 
                if healthBarPlayerAddedEv then healthBarPlayerAddedEv:Disconnect(); healthBarPlayerAddedEv = nil end 
                if healthBarPlayerRemovingEv then healthBarPlayerRemovingEv:Disconnect(); healthBarPlayerRemovingEv = nil end 
                if updateHealthBarEsp then updateHealthBarEsp:Disconnect(); updateHealthBarEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Health Bar", v)
                end 
            end 
        end 
    })

    -- Essential Hooks Silent Aim MVSD:
    local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local args = { ... }
        if silentAim then 

            if callMethod() == "Raycast" and getNearestPlayerHead() and tostring(callingScript()) == "GunController" or tostring(callingScript()) == "KnifeController" then 
                local closestPlayerHead = getNearestPlayerHead() 
                args[2] = camera.CFrame.Position
                args[3] = (closestPlayerHead.Position - args[2]).Unit * 10000
            end 
        end 
        return oldNamecall(unpack(args))
    end))

elseif game.PlaceId == supportedGames["Arcane Odyssey"]["Bronze Sea"] or game.PlaceId == supportedGames["Arcane Odyssey"]["Nimbus Sea"] then
    -- Arcane Odyssey Game Essentials Folders/Events/Functions/Variables: 
    local boatsFolder = game.Workspace.Boats
    local enemiesFolder = game.Workspace.Enemies
    local npcFolder = game.Workspace.NPCs
    local mapFolder = workspace.Map

    local remotesFolder = ReplicatedStorage.RS.Remotes
    local useSpellRemote = remotesFolder.Magic.UseSpell
    local endMagicRemote = remotesFolder.Magic.EndMagic
    local endGPRemote = remotesFolder.Combat.EndGP
    local eatFoodRemote = remotesFolder.Misc.ToolAction

    local staminaRemote = remotesFolder.Combat.StaminaCost
    local dealWeaponDamageRemote = remotesFolder.Combat.DealWeaponDamage
    local dealStrengthDamageRemote = remotesFolder.Combat.DealStrengthDamage
    local useMeleeRemote = remotesFolder.Combat.UseMelee

    local updateLastSeenRemote = remotesFolder.Misc.UpdateLastSeen
    local saveSettingsRemote = remotesFolder.UI.SaveSettings
    local openChestRemote = remotesFolder.Misc.OpenChest
    local fishingRemote = remotesFolder.Misc.ToolAction

    local fishStateRemote = remotesFolder.Misc.FishState
    local fishClockRemote = remotesFolder.Misc.FishClock
    local basic = require(ReplicatedStorage.RS.Modules.Basic)
    local updateHunger = remotesFolder.UI.UpdateHunger

    getgenv().hooks = {
        disableMobDamage = nil,
        disableMobAI = nil, 
        damageMultiplier = nil 
    }

    getgenv().uiEssentials = {
        ChestEsp = nil, 
        IslandTeleports = nil, 
        TeleportToIsland = nil, 
        TeleportToBoat = nil, 
        PlayerTeleports = nil, 
        RefreshPlayersDropdown = nil 
    }

    getgenv().gameEssentialVariables = {
        eyesDecalTexture = nil, 
        mouthDecalTexture = nil, 
        irisDecalTexture = nil, 
        eyesColor = nil, 
        irisColor = nil, 
        mouthColor = nil, 
        headlessHeadEv = nil, 
        boatSpeed = nil,
        killAuraPlayersEv = nil, 
        forceLoadEnemiesEv = nil, 
        antiWhirlpoolEv = nil, 
        forceLoadBossesEv = nil, 
        chestAddedEv = nil, 
        chestEspEv = nil, 
        boatEspEv = nil, 
        chestRemovedEv = nil, 
        seeHiddenChatEv = nil, 
        boatEspRange = nil, 
        playerEspRange = nil, 
        sharkAddedEv = nil, 
        sharkRemovedEv = nil, 
        sharkEspEv = nil, 
        disableMobDamage = nil, 
        disableMobAI = nil, 
        damageMultiplier = nil, 
        noMagicAttackCdEv = nil, 
        autoEat = nil, 
        staminaCharacterAddedEv = nil, 
        weaponChoice = nil, 
        bossFarmChoice = nil, 
        jesusPart = nil, 
        walkOnWaterEv = nil, 
        bypassDialogueRep = nil, 
        loadIslandFunc = nil,
        forceLoadIslandsEv = nil, 
        forceLoadIslands = nil, 
        loadEnemyFunc = nil, 
        updateHungerEv = nil, 
        autoEatEv = nil, 
        killAuraMobsEv = nil, 
        boatAddedEv = nil, 
        boatRemovedEv = nil, 
        updateBoatEsp = nil, 
        chestEspRange = nil,
        islandsList = {}, 
        playerList = {}, 
    }
    local function teleportToSea(seaPlaceId) 
        local response = httpRequest({Url = "https://games.roblox.com/v1/games/".. seaPlaceId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100"})
        local parsed = HttpService:JSONDecode(response.Body)
        local serverList = {}

        for i, v in next, parsed.data do
            local serverJobId = v.id
            if serverJobId ~= game.JobId then
                table.insert(serverList, serverJobId)
            end
        end
        if #serverList == 0 then
            StarterGui:SetCore("SendNotification", {
                Title = "ERROR";
                Text = "Couldn't find different servers";
                Duration = 3;
            })     
        else
            local randomServer = serverList[math.random(1, #serverList)]

            TeleportService:TeleportToPlaceInstance(seaPlaceId, randomServer, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData())
        end
    end 

    local function getNearestChest() 
        local distance = math.huge
        local target
        for i, v in next, mapFolder:GetDescendants() do 
            if string.match(v.Name, "Chest") and v:FindFirstChild("Base") and v:FindFirstChild("Lid") and not v:FindFirstChild("Open") then 
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then 
                    local rootPart = localPlayer.Character.HumanoidRootPart
                    local chestBase = v.Base
                    local chestLid = v.Lid
                    local distanceFromChest = (rootPart.Position - chestBase.Position).Magnitude

                    chestBase.CanCollide = false
                    chestLid.CanCollide = false
                    if distanceFromChest < distance then
                        target = chestBase
                        distance = distanceFromChest
                    end
                end
            end
        end

        return target
    end 
    local function getLoadIslandFunc() 
        for i, v in next, connections(remotesFolder.Misc.OnTeleport.OnClientEvent) do 
            if tostring(fenv(v.Function).script) == "Unloading" then

                for i, v in next, getUpvalues(v.Function) do 
                    if type(v) == "function" then -- If the type of upvalue is a function then get the upvalues of that function
                        for i, v in next, getUpvalues(v) do 
                            if type(v) == "function" then 
        
                                if getInfo(v).name == "LoadIsland" then -- If the function name is Load Island
                                    loadIslandFunc = v
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end

        return loadIslandFunc
    end 
    local function getLoadEnemiesFunc() 
        for i, v in next, gc() do
            if type(v) == "function"  then
                if getInfo(v).name == "LoadEnemy" then
                    loadEnemyFunc = v
                    break
                end
            end
        end
        return loadEnemyFunc
    end 
    local function blockBossAntiLoadFunc()           
        for i, v in pairs(getgc()) do
            if type(v) == "function"  then
                if fenv(v).script.Name == "QuestsHandler" then 
                    if getInfo(v).name == "EnemySideQuestCheck" then 
                        hookfunction(v, function()
                            return
                        end)
                    end
                end
            end
        end
    end
    local function updateJobValue(jobInstance)
        local validJobs = {
            "Alchemist",
            "Armorer",
            "Shipwright",
            "Fishmonger",
            "Food Merchant",
            "Builder",
            "Auctioneer",
            "Blacksmith",
            "Tailor",
            "Receptionist"
        }
        
        for _, job in ipairs(validJobs) do
            if string.match(jobInstance.Value, job) then
                jobInstance.Value = job == "Receptionist" and "" or job
                break
            end
        end
    end
    local function setRenownPositive()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Data") then
            local data = localPlayer.Character.Data
            data.RenownType.Value = "Positive"
        end
    end
    local FarmsTab = Anomaly:CreateTab({ Name = "Farms" })
    local FarmSection = FarmsTab:CreateSection({ Name = "Farm" })
    local PlayerSection = GeneralTab:CreateSection({ Name = "Local Player", Side = "Right" })
    local BoatModificationsSection = GeneralTab:CreateSection({ Name = "Boat Modifications", Side = "Right" })
    local TeleportSection = GeneralTab:CreateSection({ Name = "Teleports", Side = "Right" })
    local ClearUnderWaterEffect = LightingSection:AddToggle({ Name = "Clear Underwater Effect", Flag = "Clear Underwater Effect",
        Callback = function(v)
            if Lighting:FindFirstChild("ColorCorrection") then 
                Lighting.ColorCorrection.Enabled = not Lighting.ColorCorrection.Enabled
            end 
        end
    })
    uiEssentials.PlayerSpeed = PlayerSection:AddSlider({ Name = "Player Walkspeed", Flag = "Player Walkspeed", Value = 16, Min = 16, Max = 250, Callback = function(v) playerSpeed = v end })
    uiEssentials.SetSpeed = PlayerSection:AddToggle({ Name = "Set Walkspeed", Flag = "Set Walkspeed",
        Callback = function(v)
            if v then 
                walkspeedEv = renderStepped:Connect(function()
                    if playerSpeed then 
                        if localPlayer.Character then 
                            local character = localPlayer.Character
                            
                            if character:FindFirstChild("Humanoid") then 
                                local humanoid = character.Humanoid

                                humanoid.WalkSpeed = playerSpeed
                            end
                        end
                    end
                end)
            else 
                if walkspeedEv then walkspeedEv:Disconnect(); walkspeedEv = nil end 
                repeat taskWait() 
                    if localPlayer.Character then 
                        local character = localPlayer.Character
                        if character:FindFirstChild("Humanoid") then 
                            local humanoid = character.Humanoid
                            humanoid.WalkSpeed = 16
                        end
                    end
                until localPlayer.Character.Humanoid.WalkSpeed == 16
            end 
        end
    })
    local DisableMobDamage = GeneralSection:AddToggle({ Name = "Disable Mob Damage", Flag = "Disable Mob Damage", Callback = function(v) disableMobDamage = v end })
    local DisableMobAI = GeneralSection:AddToggle({ Name = "Disable Mob AI", Flag = "Disable Mob AI", Callback = function(v) disableMobAI = v end })
    local DamageMultiplier = GeneralSection:AddToggle({ Name = "Damage Multiplier", Flag = "Damage Multiplier", Callback = function(v) damageMultiplier = v end })

    local AnimationPacks = GeneralSection:AddDropdown({
        Name = "Choose Animation Pack", 
        Flag = "Animation Packs", 
        Value = "None", 
        List = {"None", "Cute", "Boss", "Coward"},

        Callback = function(v) 
            if localPlayer.Character then
                local character = localPlayer.Character
                
                if character:FindFirstChild("Humanoid") and v ~= "None" then 
                    local humanoid = character.Humanoid

                    humanoid.Health = 0
                    basic.GetAnimationPack = function()
                        return v
                    end
                end
            end
        end
    })
    local DiscoverAllIslands = GeneralSection:AddButton({ Name = "Discover All Islands",
        Callback = function()
            for i, v in next, mapFolder:GetChildren() do 
                if v:IsA("Folder") then 
                    updateLastSeenRemote:FireServer(tostring(v), "")
                end
            end
        end
    })
    local NoWeather = GeneralSection:AddButton({ Name = "No Weather",
        Callback = function()
            if mapFolder:FindFirstChild("Weather") then
                mapFolder.Weather:Destroy()
            end
        end
    })
    local ForceLoadIslands = GeneralSection:AddButton({ Name = "Force Load Islands [LAGGY]",
        Callback = function()
            if not forceLoadIslands then 
                forceLoadIslands = true 
                local loadIslandFunc = getLoadIslandFunc()

                forceLoadIslandsEv = renderStepped:Connect(function()
                    if loadIslandFunc then 
                        for i, v in next, mapFolder:GetChildren() do 
                            if v:FindFirstChild("Center") and v.Center:FindFirstChild("UnloadAt") then
                                v.Center.UnloadAt.Value = 1000000000000
                            end
                            loadIslandFunc(v, true)
                        end
                    end
                end)
            end 
        end
    })
    local BypassDialogueRep = GeneralSection:AddButton({ Name = "Bypass Dialogue Reputation",
        Callback = function()
            if not bypassDialogueRep then 
                bypassDialogueRep = true
                for _, npc in next, npcFolder:GetDescendants() do
                    if npc.Name == "Job" then
                        updateJobValue(npc)
                    end
                end
        
                setRenownPositive()
                localPlayer.CharacterAdded:Connect(function(character)
                    repeat taskWait() until character:FindFirstChild("Data") and character.Data:FindFirstChild("RenownType")
                    setRenownPositive()
                end)
        
                npcFolder.DescendantAdded:Connect(function(descendant)
                    if descendant.Name == "Job" then
                        updateJobValue(descendant)
                    end
                end)
            end
        end
    })
    local HeadlessHeadClient = GeneralSection:AddToggle({ Name = "Headless Head [CLIENT]", Flag = "Headless Head [CLIENT]",
        Callback = function(v)
            if v then 
                if localPlayer.Character then 
                    local character = localPlayer.Character 

                    if character:FindFirstChild("Head") then
                        local head = character.Head
                        head.Transparency = 1

                        for i, v in next, head:GetChildren() do 
                            if v.Name == "Eyes" then
                                eyesDecalTexture = v.Texture
                                eyesColor = v.Color3
                                v:Destroy()

                            elseif v.Name == "Iris" then 
                                irisDecalTexture = v.Texture 
                                irisColor = v.Color3
                                v:Destroy()

                            elseif v.Name == "Mouth" then
                                mouthDecalTexture = v.Texture
                                mouthColor = v.Color3
                                v:Destroy()
                            end
                        end
                    end
                end
                
                gameEssentialVariables.headlessHeadEv = localPlayer.CharacterAdded:Connect(function(character)
                    repeat taskWait() until character:FindFirstChild("Head")
                    local head = character.Head
                    head.Transparency = 1

                    for i, v in next, head:GetChildren() do 
                        if v:IsA("Decal") then
                            v:Destroy()
                        end
                    end
                end)

            else 
                if gameEssentialVariables.headlessHeadEv then gameEssentialVariables.headlessHeadEv:Disconnect(); gameEssentialVariables.headlessHeadEv = nil end 
                localPlayer.Character.Head.Transparency = 0
                local eyes = Instance.new("Decal", localPlayer.Character.Head)
                local mouth = Instance.new("Decal", localPlayer.Character.Head)
                local iris = Instance.new("Decal", localPlayer.Character.Head)

                eyes.Name = "Eyes"
                eyes.Texture = eyesDecalTexture
                eyes.ZIndex = 1
                eyes.Color3 = eyesColor
                eyes.Face = Enum.NormalId.Front

                mouth.Name = "Mouth" 
                mouth.Texture = mouthDecalTexture
                mouth.ZIndex = 1
                mouth.Color3 = mouthColor
                mouth.Face = Enum.NormalId.Front

                iris.Name = "Iris"
                iris.Texture = irisDecalTexture 
                iris.ZIndex = 2
                iris.Color3 = irisColor
                iris.Face = Enum.NormalId.Front
            end
        end
    })
    local SeeHiddenChat = GeneralSection:AddToggle({ Name = "See Hidden Chat", Flag = "See Hidden Chat",
        Callback = function(v)
            local chatFrame = localPlayer.PlayerGui.Chat.Frame
            local customChat = localPlayer.PlayerGui.CustomChat
            customChat.Frame.Visible = not customChat.Frame.Visible
            if v then 
                gameEssentialVariables.seeHiddenChatEv = customChat.Frame:GetPropertyChangedSignal("Visible"):Connect(function()
                    customChat.Frame.Visible = false
                end)
            else 
                if gameEssentialVariables.seeHiddenChatEv then gameEssentialVariables.seeHiddenChatEv:Disconnect(); gameEssentialVariables.seeHiddenChatEv = nil end 
            end
            customChat.Frame.Visible = not customChat.Frame.Visible
            chatFrame.ChatChannelParentFrame.Visible = not chatFrame.ChatChannelParentFrame.Visible
            chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
        end
    })
    local ForceLoadEnemies = GeneralSection:AddToggle({ Name = "Force Load Enemies", Flag = "Force Load Enemies",
        Callback = function(v)
            if v then 
                local loadEnemyFunc = getLoadEnemiesFunc()
                gameEssentialVariables.forceLoadEnemiesEv = renderStepped:Connect(function()
                    for i, v in next, ReplicatedStorage.RS.UnloadEnemies:GetChildren() do 
                        pcall(function()
                            if loadEnemyFunc then 
                                loadEnemyFunc(v, true)
                            end
                        end)
                    end
                end)
            else 
                if gameEssentialVariables.forceLoadEnemiesEv then gameEssentialVariables.forceLoadEnemiesEv:Disconnect(); gameEssentialVariables.forceLoadEnemiesEv = nil end 
            end
        end
    })
    local WalkOnWater = GeneralSection:AddToggle({ Name = "Walk On Water", Flag = "Walk On Water", 
        Callback = function(v)
            if v then 
                gameEssentialVariables.walkOnWaterEv = RunService.Heartbeat:Connect(function()
                    if localPlayer.Character and localPlayer.character:FindFirstChild("LeftFoot") then 
                        local ocean = camera.Sea.Sea.Ocean1
                        local leftFoot = localPlayer.Character.LeftFoot
                        
                        if not workspace.Map:FindFirstChild("Jesus") then 
                            gameEssentialVariables.jesusPart = Instance.new("Part", workspace.Map)
                        end
                        gameEssentialVariables.jesusPart.Name = "Jesus"
                        gameEssentialVariables.jesusPart.Size = vector3New(2048, 0, 2048)
                        gameEssentialVariables.jesusPart.Anchored = true 
                        gameEssentialVariables.jesusPart.Transparency = 0.999999
                        gameEssentialVariables.jesusPart.Position = vector3New(leftFoot.Position.X, ocean.Position.Y, leftFoot.Position.Z)
                    end
                end)
            else 
                if gameEssentialVariables.walkOnWaterEv then gameEssentialVariables.walkOnWaterEv:Disconnect(); gameEssentialVariables.walkOnWaterEv = nil end 
                workspace.Map.Jesus:Destroy()
            end 
        end
    })
    local InfStamina = GeneralSection:AddToggle({ Name = "Infinite Stamina", Flag = "Infinite Stamina",
        Callback = function(v)
            if v then 
                staminaRemote:FireServer(-5000, "Dodge")
                gameEssentialVariables.staminaCharacterAddedEv = localPlayer.CharacterAdded:Connect(function()
                    repeat taskWait() until localPlayer.PlayerGui:FindFirstChild("MainGui")
                    staminaRemote:FireServer(-5000, "Dodge")
                end)
            else 
                if gameEssentialVariables.staminaCharacterAddedEv then gameEssentialVariables.staminaCharacterAddedEv:Disconnect(); gameEssentialVariables.staminaCharacterAddedEv = nil end 
            end  
        end
    })
    local AntiWhirlpool = GeneralSection:AddToggle({ Name = "Anti Whirlpool", Flag = "Anti Whirlpool",
        Callback = function(v)
            if v then 
                gameEssentialVariables.antiWhirlpoolEv = RunService.RenderStepped:Connect(function()
                    if localPlayer.Character and localPlayer.Character:FindFirstChild("Whirlpool") then 
                        localPlayer.Character.Whirlpool:Destroy()
                    end
                end)
                
            else 
                if gameEssentialVariables.antiWhirlpoolEv then gameEssentialVariables.antiWhirlpoolEv:Disconnect(); gameEssentialVariables.antiWhirlpoolEv = nil end 
            end
        end
    })
    local AutoEat = GeneralSection:AddToggle({ Name = "Auto Eat", Flag = "Auto Eat",
        Callback = function(v)
            if v then 
                local hungerFunc = connections(updateHunger.OnClientEvent)[1].Function
                local currentHunger = getupvalue(hungerFunc, 1)
                gameEssentialVariables.updateHungerEv = updateHunger.OnClientEvent:Connect(function(hungerValue) 
                    currentHunger = hungerValue
                end)
                gameEssentialVariables.autoEatEv = renderStepped:Connect(function()
                    if currentHunger <= 45 then 
                        local foodItem = localPlayer.PlayerGui.Backpack:FindFirstChild("HungerIcon", true)
                        if not foodItem then return end
                        eatFoodRemote:FireServer(foodItem.Parent.Parent.Tool.Value)
                    end 
                end)
            else 
                if gameEssentialVariables.autoEatEv then gameEssentialVariables.autoEatEv:Disconnect(); gameEssentialVariables.autoEatEv = nil end 
            end
        end
    })
    local ForceLoadBosses = GeneralSection:AddToggle({ Name = "Force Load Bosses", Flag = "Force Load Bosses",
        Callback = function(v)
            if v then 
                blockBossAntiLoadFunc()
                gameEssentialVariables.forceLoadBossesEv = renderStepped:Connect(function()
                    for i, v in next, ReplicatedStorage.RS.Story.Enemies:GetChildren() do 
                        if v:FindFirstChild("AppearAt") and not workspace.Enemies:FindFirstChild(v.Name) then 
                            v.AppearAt.Value = 0
                            v.Parent = enemiesFolder
                        end
                    end
                
                    for i, v in next, ReplicatedStorage.RS.Quest.Enemies:GetChildren() do 
                        if v:FindFirstChild("AppearAtQuest") and not workspace.Enemies:FindFirstChild("Cernyx") then 
                            v.AppearAtQuest.Value = 0
                            v.Parent = enemiesFolder
                        end
                    end
                end)
            else 
                if gameEssentialVariables.forceLoadBossesEv then gameEssentialVariables.forceLoadBossesEv:Disconnect(); gameEssentialVariables.forceLoadBossesEv = nil end 
            end
        end
    })
    local NoMagicAttackCooldown = GeneralSection:AddToggle({  Name = "No Magic Attack Cooldown", Flag = "No Magic Attack Cooldown",
        Callback = function(v)
            if v then     
                gameEssentialVariables.noMagicAttackCdEv = inputBegan:Connect(function(input, gpe)
                    if gpe then return end

                    if localPlayer.Character then
                        local character = localPlayer.Character
                        local data = character.Data
                        local firstMagic = data.Magic1
                        local secondMagic = data.Magic2

                        if (input.KeyCode == Enum.KeyCode.Q) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 1, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.Q) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 1, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.E) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 2, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.E) and string.match(string.sub(secondMagic.Value, 3), "Magic") and character:FindFirstChild(string.sub(secondMagic.Value, 3)) then 
                            useSpellRemote:FireServer(2, 2, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.R) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 3, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.R) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 3, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.F) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 4, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.F) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 4, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.V) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 5, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.V) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 5, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.C) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 6, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.C) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 6, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.X) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 7, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.X) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 7, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                        
                        if (input.KeyCode == Enum.KeyCode.Z) and (string.match(string.sub(firstMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(firstMagic.Value, 3))) then 
                            useSpellRemote:FireServer(1, 8, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(firstMagic.Value, 3))
                            endGPRemote:FireServer()
                        end

                        if (input.KeyCode == Enum.KeyCode.Z) and (string.match(string.sub(secondMagic.Value, 3), "Magic")) and (character:FindFirstChild(string.sub(secondMagic.Value, 3))) then 
                            useSpellRemote:FireServer(2, 8, vector3New(0, 0, 0))
                            endMagicRemote:FireServer(character, string.sub(secondMagic.Value, 3))
                            endGPRemote:FireServer()
                        end
                    end
                end)
                    
            else 
                if gameEssentialVariables.noMagicAttackCdEv then gameEssentialVariables.noMagicAttackCdEv:Disconnect(); gameEssentialVariables.noMagicAttackCdEv = nil end 
            end
        end
    })
    local KillAuraMobs = GeneralSection:AddToggle({
        Name = "Kill Aura [MOBS]",
        Flag = "Kill Aura [MOBS]",
        Callback = function(v)
            if v then 
                gameEssentialVariables.killAuraMobsEv = renderStepped:Connect(function()
                    for i, v in next, enemiesFolder:GetChildren() do
                        if localPlayer.Character and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then 
                            local enemyRootPart = v.HumanoidRootPart
                            local character = localPlayer.Character
                            
                            if localPlayer:DistanceFromCharacter(enemyRootPart.Position) <= 150 then
                                dealWeaponDamageRemote:FireServer(0, character, v, character:FindFirstChildWhichIsA("Tool"), "Slash")
                            
                                if localPlayer.Character:FindFirstChild("Boxing") or localPlayer.Character:FindFirstChild("Canon Fist") or localPlayer.Character:FindFirstChild("Iron Leg") or localPlayer.Character:FindFirstChild("Sailor Fist") or localPlayer.Character:FindFirstChild("Thermo Fist") or localPlayer.Character:FindFirstChild("Basic Combat") then 
                                    useMeleeRemote:FireServer(character:FindFirstChildWhichIsA("Tool"), nil, vector3New(0, 0, 0))
                                    dealStrengthDamageRemote:FireServer(0, character, v, character:FindFirstChildWhichIsA("Tool"), "Attack")
                                end
                            end
                        end
                    end
                end)

            else 
                if gameEssentialVariables.killAuraMobsEv then gameEssentialVariables.killAuraMobsEv:Disconnect(); gameEssentialVariables.killAuraMobsEv = nil end 
            end
        end
    })
    local KillAuraPlayers = GeneralSection:AddToggle({
        Name = "Kill Aura [PLAYERS]",
        Flag = "Kill Aura [PLAYERS]",
        Callback = function(v)
            if v then
                gameEssentialVariables.killAuraPlayersEv = renderStepped:Connect(function()
                    for i, v in next, workspace:GetChildren() do
                        if localPlayer.Character and v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then 
                            local enemyRootPart = v.HumanoidRootPart
                            local character = localPlayer.Character
                            
                            if localPlayer:DistanceFromCharacter(enemyRootPart.Position) <= 150 then
                                dealWeaponDamageRemote:FireServer(0, character, v, character:FindFirstChildWhichIsA("Tool"), "Slash")
                                if localPlayer.Character:FindFirstChild("Boxing") or localPlayer.Character:FindFirstChild("Canon Fist") or localPlayer.Character:FindFirstChild("Iron Leg") or localPlayer.Character:FindFirstChild("Sailor Fist") or localPlayer.Character:FindFirstChild("Thermo Fist") or localPlayer.Character:FindFirstChild("Basic Combat") then 
                                    useMeleeRemote:FireServer(character:FindFirstChildWhichIsA("Tool"), nil, vector3New(0, 0, 0))
                                    dealStrengthDamageRemote:FireServer(0, character, v, character:FindFirstChildWhichIsA("Tool"), "Attack")
                                end
                            end
                        end
                    end  
                end)

            else 
                if gameEssentialVariables.killAuraPlayersEv then gameEssentialVariables.killAuraPlayersEv:Disconnect(); gameEssentialVariables.killAuraPlayersEv = nil end 
            end
        end
    })

    local PlayerESPRange = EspSection:AddSlider({ Name = "Player ESP Range", Flag = "Player ESP Range Slider", Value = 1000, Min = 1000, Max = 25000, Callback = function(v) playerEspRange = v end })
    local BoxESP = EspSection:CreateToggle({ Name = "Box ESP", CurrentValue = false, Flag = "Box ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Square", v)
                    end 
                end 

                gameEssentialVariables.boxPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Square", player) end)
                gameEssentialVariables.boxPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Square", player) end)

                updateBoxEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, boxEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local displayed = false

                        local boxOutline = cachedDrawings.boxEspOutline
                        local box = cachedDrawings.boxEsp

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")

                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)
                    
                                if onScreen and humanoid.Health > 0 and localPlayer:DistanceFromCharacter(head.Position) < playerEspRange then 
                                    box.Size = newSize
                                    box.Position = vector2New(headPos.X - newSize.X / 2, headPos.Y - newSize.Y / 1.2)

                                    boxOutline.Size = box.Size 
                                    boxOutline.Position = box.Position
                                    
                                    boxOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    box.Visible = boxOutline.Visible

                                else 
                                    boxOutline.Visible = false 
                                    box.Visible = false
                                end 

                            else 
                                boxOutline.Visible = false 
                                box.Visible = false
                            end 

                        else 
                            boxOutline.Visible = false 
                            box.Visible = false
                        end 
                    end 
                end)
            else 
                if boxPlayerAddedEv then boxPlayerAddedEv:Disconnect(); boxPlayerAddedEv = nil end 
                if boxPlayerRemovingEv then boxPlayerRemovingEv:Disconnect(); boxPlayerRemovingEv = nil end 
                if updateBoxEsp then updateBoxEsp:Disconnect(); updateBoxEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Square", v)
                end 
            end 
        end 
    })
    local TextESP = EspSection:CreateToggle({ Name = "Text ESP", CurrentValue = false, Flag = "Text ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Text", v)
                    end 
                end 

                textPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Text", player) end)
                textPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Text", player) end)

                updateTextEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, textEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        local isFFA = #Teams:GetChildren() == 0

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
                            local root = character:FindFirstChild("HumanoidRootPart")

                            if head and humanoid and root then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local rootPos, onScreen = wtvp(camera, root.Position)

                                if onScreen and humanoid.Health > 0 and localPlayer:DistanceFromCharacter(head.Position) < playerEspRange then 
                                    local distanceFromHeadPos = round(localPlayer:DistanceFromCharacter(head.Position))
                                    local health = round(humanoid.Health)
                                    local maxHealth = round(humanoid.MaxHealth)

                                    textEsp.Text = "[" .. player.Name .. "]" .. "[" .. distanceFromHeadPos .. "] \n [" .. health .. "/" .. maxHealth .. "]"
                                    textEsp.Color = Color3.fromRGB(255, 255, 255)
                                    textEsp.Position = vector2New(headPos.X, headPos.Y)
                                    textEsp.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen

                                else 
                                    textEsp.Visible = false 
                                end 

                            else 
                                textEsp.Visible = false 
                            end 

                        else 
                            textEsp.Visible = false 
                        end 
                    end 
                end)

            else 
                if textPlayerAddedEv then textPlayerAddedEv:Disconnect(); textPlayerAddedEv = nil end 
                if textPlayerRemovingEv then textPlayerRemovingEv:Disconnect(); textPlayerRemovingEv = nil end 
                if updateTextEsp then updateTextEsp:Disconnect(); updateTextEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Text", v)
                end 
            end 
        end 
    })
    local HealthBarESP = EspSection:CreateToggle({ Name = "Health Bar ESP", CurrentValue = false, Flag = "Health Bar ESP [Weaponry]", 
        Callback = function(v)
            if v then 
                for i, v in next, Players:GetPlayers() do 
                    if v ~= localPlayer then 
                        addPlayerToDrawingCache("Health Bar", v)
                    end 
                end 

                healthBarPlayerAddedEv = playerAdded:Connect(function(player) addPlayerToDrawingCache("Health Bar", player) end)
                healthBarPlayerRemovingEv = playerRemoving:Connect(function(player) removePlayerDrawingCache("Health Bar", player) end)

                updateHealthBarEsp = renderStepped:Connect(function()
                    for player, cachedDrawings in next, healthBarEspCache do 
                        local isFFA = #Teams:GetChildren() == 0
                        local healthBarOutline = cachedDrawings.healthBarOutline
                        local healthBar = cachedDrawings.healthBar

                        if player.Character then 
                            local character = player.Character 
                            local head = character:FindFirstChild("Head") 
                            local humanoid = character:FindFirstChild("Humanoid")
 
                            if head and humanoid then 
                                local headPos, onScreen = wtvp(camera, head.Position)
                                local origin, size = character:GetBoundingBox()
                                local height = (camera.CFrame - camera.CFrame.Position) * vector3New(0, math.clamp(size.Y, 1, 10) / 2, 0)

                                local bottom = wtvp(camera, origin.Position - height)
                                local top = wtvp(camera, origin.Position + height)
                                local newHeight = -math.abs(top.Y - bottom.Y)

                                local newSize = vector2New(newHeight / 1.5, newHeight)           
                                local healthBarWidth = 10
                                local healthBarHeight = newSize.Y * (humanoid.Health / humanoid.MaxHealth)

                                local healthBarX = (headPos.X - newSize.X / 2) + newSize.X - 10
                                local healthBarY = (headPos.Y - newSize.Y / 1.2)
                                local healthBarFraction = humanoid.Health / humanoid.MaxHealth

                                if onScreen and humanoid.Health > 0 and localPlayer:DistanceFromCharacter(head.Position) < playerEspRange then 
                                    healthBarOutline.From = vector2New(healthBarX, healthBarY)
                                    healthBarOutline.To = vector2New(healthBarX, healthBarY + newSize.Y)
                                    healthBarOutline.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen
                                    healthBarOutline.ZIndex = 1 

                                    healthBar.From = vector2New(healthBarX, healthBarY)
                                    healthBar.To = vector2New(healthBarX, healthBarY + healthBarHeight)
                                    healthBar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), healthBarFraction)
                                    healthBar.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen and healthBarOutline.Visible
                                    healthBar.ZIndex = 2 

                                else 
                                    healthBar.Visible = false
                                    healthBarOutline.Visible = false 
                                end 

                            else 
                                healthBar.Visible = false
                                healthBarOutline.Visible = false 
                            end 

                        else 
                            healthBar.Visible = false
                            healthBarOutline.Visible = false 
                        end                    
                    end 
                end)

            else 
                if healthBarPlayerAddedEv then healthBarPlayerAddedEv:Disconnect(); healthBarPlayerAddedEv = nil end 
                if healthBarPlayerRemovingEv then healthBarPlayerRemovingEv:Disconnect(); healthBarPlayerRemovingEv = nil end 
                if updateHealthBarEsp then updateHealthBarEsp:Disconnect(); updateHealthBarEsp = nil end 

                for i, v in next, Players:GetPlayers() do 
                    removePlayerDrawingCache("Health Bar", v)
                end 
            end 
        end 
    })
    local BoatEspRange = EspSection:AddSlider({ Name = "Boat ESP Range", Flag = "Boat ESP Range Slider", Value = 1000, Min = 1000, Max = 25000, Callback = function(v) boatEspRange = v end })
    local BoatEsp = EspSection:CreateToggle({ Name = "Boat ESP", CurrentValue = false, Flag = "Boat ESP", 
        Callback = function(v)
            if v then 
                for i, v in next, boatsFolder:GetChildren() do 
                    if v.Name ~= localPlayer.Name .. "Boat" then
                        addPlayerToDrawingCache("Boat Text", v) -- Not Player But Name of Function Innit
                    end
                end

                gameEssentialVariables.boatAddedEv = boatsFolder.ChildAdded:Connect(function(child) if child.Name ~= localPlayer.Name .. "Boat" then addPlayerToDrawingCache("Boat Text", child) --[[Not Player But Name of Function Innit]] end end)
                gameEssentialVariables.boatRemovedEv = boatsFolder.ChildRemoved:Connect(function(child) removePlayerDrawingCache("Boat Text", child) --[[Not Player But Name of Function Innit]]  end)
                updateBoatEsp = renderStepped:Connect(function()
                    for boat, cachedDrawings in next, boatEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        
                        if boat:FindFirstChild("Center") then 
                            local centerOfBoat = boat.Center

                            if centerOfBoat:FindFirstChild("BoatOverhead") and centerOfBoat.BoatOverhead:FindFirstChild("Amount") then 
                                local boatOverhead = centerOfBoat.BoatOverhead
                                local boatHP = boatOverhead.Amount

                                local boatTitle = boatOverhead.Title
                                local boatPos, onScreen = wtvp(camera, centerOfBoat.Position)

                                local distanceFromBoatPos = round(localPlayer:DistanceFromCharacter(centerOfBoat.Position))

                                if boatTitle.Text ~= "" then 
                                    textEsp.Text = "[" .. boat.Name .. "]" .. "[" .. distanceFromBoatPos .. "] \n [" .. boatHP.Text .. "] \n [Title: " .. boatTitle.Text .. "]"
                                else 
                                    textEsp.Text = "[" .. boat.Name .. "]" .. "[" .. distanceFromBoatPos .. "] \n [" .. boatHP.Text .. "] \n [Title: " .. "none" .. "]"
                                end

                                if onScreen and distanceFromBoatPos < boatEspRange then 
                                    textEsp.Visible = true
                                    textEsp.Position = vector2New(boatPos.X, boatPos.Y)
                                else 
                                    textEsp.Visible = false
                                end
                            else 
                                textEsp.Visible = false
                            end
                        end
                    end 
                end)

            else 
                if gameEssentialVariables.boatAddedEv then gameEssentialVariables.boatAddedEv:Disconnect(); gameEssentialVariables.boatAddedEv = nil end 
                if gameEssentialVariables.boatRemovedEv then gameEssentialVariables.boatRemovedEv:Disconnect(); gameEssentialVariables.boatRemovedEv = nil end 
                if updateBoatEsp then updateBoatEsp:Disconnect(); updateBoatEsp = nil end 

                for i, v in next, boatsFolder:GetChildren() do 
                    removePlayerDrawingCache("Boat Text", v)
                end 
            end 
        end 
    })
    local ChestEspRange = EspSection:AddSlider({ Name = "Chest ESP Range", Flag = "Chest ESP Range Slider", Value = 1000, Min = 1000, Max = 25000, Callback = function(v) chestEspRange = v end })
    uiEssentials.ChestEsp = EspSection:CreateToggle({ Name = "Chest ESP", CurrentValue = false, Flag = "Chest ESP", 
        Callback = function(v)
            if v then 
                for i, islands in next, mapFolder:GetChildren() do 
                    if islands:FindFirstChild("Chests") then 
                        local chestFolder = islands.Chests 

                        for i, chest in next, chestFolder:GetChildren() do 
                            if not chest:FindFirstChild("Open") then 
                                addPlayerToDrawingCache("Chest Text", chest)
                            end 

                            chestChildAddedEv = chest.ChildAdded:Connect(function(child) 
                                if child.Name == "Open" then
                                    removePlayerDrawingCache("Chest Text", chest) 
                                end 
                            end)
                            chestParentChangeEv = chest.AncestryChanged:Connect(function(child, parent)
                                if parent and parent.Parent and parent.Parent.Parent and parent.Parent.Parent.Name == "RS" then
                                    removePlayerDrawingCache("Chest Text", chest)
                                end
                            end)
                        end 

                        chestAddedEv = chestFolder.ChildAdded:Connect(function(chestChild) 
                            if chestChild.Name:find("Chest") or chestChild.Name:find("Storage") then 
                                addPlayerToDrawingCache("Chest Text", chestChild) 
                                chestParentChangeEv = chestChild.AncestryChanged:Connect(function(child, parent)
                                    if parent and parent.Parent and parent.Parent.Parent and parent.Parent.Parent.Name == "RS" then
                                        removePlayerDrawingCache("Chest Text", chestChild)
                                    end
                                end)
                                
                                chestChildAddedEv = chestChild.ChildAdded:Connect(function(child)
                                    if child.Name == "Open" then removePlayerDrawingCache("Chest Text", chestChild) end 
                                end)
                            end 
                        end)

                        chestRemovedEv = chestFolder.ChildRemoved:Connect(function(child) 
                            if child.Name:find("Chest") or child.Name:find("Storage") then 
                                removePlayerDrawingCache("Chest Text", child) 
                            end 
                        end)
                    end 

                    chestFolderAddedEv = islands.ChildAdded:Connect(function(child) 
                        if child.Name == "Chests" then
                            local chestFolder = child  

                            for i, chest in next, chestFolder:GetChildren() do 
                                if not chest:FindFirstChild("Open") then 
                                    addPlayerToDrawingCache("Chest Text", chest)
                                end 
                                chestParentChangeEv = chest.AncestryChanged:Connect(function(child, parent)
                                    if parent and parent.Parent and parent.Parent.Parent and parent.Parent.Parent.Name == "RS" then
                                        removePlayerDrawingCache("Chest Text", chest)
                                    end
                                end)
                                chestChildAddedEv = chest.ChildAdded:Connect(function(child) 
                                    if child.Name == "Open" then
                                        removePlayerDrawingCache("Chest Text", chest) 
                                    end 
                                end)
                            end 

                            chestAddedEv = chestFolder.ChildAdded:Connect(function(chestChild) 
                                if chestChild.Name:find("Chest") or chestChild.Name:find("Storage") then 
                                    addPlayerToDrawingCache("Chest Text", chestChild) 
                                    chestParentChangeEv = chestChild.AncestryChanged:Connect(function(child, parent)
                                        if parent and parent.Parent and parent.Parent.Parent and parent.Parent.Parent.Name == "RS" then
                                            removePlayerDrawingCache("Chest Text", chestChild)
                                        end
                                    end)

                                    chestChildAddedEv = chestChild.ChildAdded:Connect(function(child)
                                        if child.Name == "Open" then removePlayerDrawingCache("Chest Text", chestChild) end 
                                    end)
                                end 
                            end)

                            chestRemovedEv = chestFolder.ChildRemoved:Connect(function(child) 
                                if child.Name:find("Chest") or child.Name:find("Storage") then 
                                    removePlayerDrawingCache("Chest Text", child) 
                                end 
                            end)
                        end
                    end)
                end 

                updateChestEsp = renderStepped:Connect(function()
                    for chest, cachedDrawings in next, chestEspCache do 
                        local textEsp = cachedDrawings.textEsp
                        if chest then 
                            if chest:FindFirstChild("Base") then 
                                local base = chest.Base
                                local basePos, onScreen = wtvp(camera, base.Position)
                                local distanceFromBasePos = round(localPlayer:DistanceFromCharacter(base.Position))

                                if onScreen and distanceFromBasePos < chestEspRange then 
                                    if chest.Name == "Silver Chest" then 
                                        textEsp.Color = Color3.fromRGB(192, 192, 192)
                                    elseif chest.Name == "Golden Chest" then 
                                        textEsp.Color = Color3.fromRGB(248, 212, 92)
                                    end     

                                    textEsp.Text = "[" .. chest.Name .. "]" .. "[" .. distanceFromBasePos .. "]"
                                    textEsp.Visible = true 
                                    textEsp.Position = vector2New(basePos.X, basePos.Y)
                                else 
                                    textEsp.Visible = false
                                end 
                            else 
                                textEsp.Visible = false 
                            end
                        else 
                            textEsp.Visible = false 
                        end 
                    end 
                end)

            else 
                if updateChestEsp then updateChestEsp:Disconnect(); updateChestEsp = nil end 
                if chestAddedEv then chestAddedEv:Disconnect(); chestAddedEv = nil end 
                if chestRemovedEv then chestRemovedEv:Disconnect(); chestRemovedEv = nil end 
                if chestFolderAddedEv then chestFolderAddedEv:Disconnect(); chestFolderAddedEv = nil end 
                if chestParentChangeEv then chestParentChangeEv:Disconnect(); chestParentChangeEv = nil end 
                
                for i, v in next, mapFolder:GetDescendants() do 
                    if v.Name:find("Chest") or v.Name:find("Storage") then 
                        removePlayerDrawingCache("Chest Text", v)
                    end 
                end 
            end 
        end 
    })

    for i, v in next, mapFolder:GetChildren() do 
        if v:FindFirstChild("Center") then 
            table.insert(gameEssentialVariables.islandsList, v.Name)
        end
    end

    uiEssentials.IslandTeleports = TeleportSection:AddDropdown({ Name = "List Of Islands", Flag = "List Of Islands", Value = gameEssentialVariables.islandsList[1],  List = gameEssentialVariables.islandsList, Callback = function(v) getgenv().islandChoice = v end })
    uiEssentials.TeleportToIsland = TeleportSection:AddButton({ Name = "Teleport To Island",
        Callback = function()
            local loadIslandFunc = getLoadIslandFunc()
            if loadIslandFunc and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and islandChoice then
                local rootPart = localPlayer.Character.HumanoidRootPart
                local island = mapFolder[islandChoice]

                if island:FindFirstChild("Center") then 
                    local islandCenter = island.Center
                    loadIslandFunc(island, true)
                    if island.Name == "Harvest Island" then 
                        rootPart.CFrame = CFrame.new(7337, 598, 423) * CFrame.new(0, 200, 0)
                    elseif island.Name == "Ravenna" then 
                        rootPart.CFrame = CFrame.new(16610, 1027, 1711) * CFrame.new(0, 200, 0)
                    elseif island.Name ~= "Ravenna" or island.Name ~= "Harvest Island" then 
                        rootPart.CFrame = islandCenter.CFrame * CFrame.new(0, 200, 0)
                    end
                end
            end
        end
    })
    uiEssentials.TeleportToBoat = TeleportSection:AddButton({ Name = "Teleport To Boat",
        Callback = function()
            if boatsFolder:FindFirstChild(localPlayer.Name .. "Boat") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then 
                local boat = boatsFolder[localPlayer.Name .. "Boat"]
                local rootPart = localPlayer.Character.HumanoidRootPart
                if boat:FindFirstChild("Center") then 
                    rootPart.CFrame = boat.Center.CFrame * CFrame.new(0, 100, 0)
                end
            end
        end
    })
    for i, v in next, Players:GetPlayers() do 
        if v ~= localPlayer then
            table.insert(gameEssentialVariables.playerList, v.Name)
        end
    end

    uiEssentials.PlayerTeleports = TeleportSection:AddDropdown({ Name = "List Of Players", Flag = "List Of Players", Value = gameEssentialVariables.playerList[1], List = gameEssentialVariables.playerList, UpdateList = function(newList) end, Callback = function(v) getgenv().playerChoice = v end })
    uiEssentials.TeleportToPlayer = TeleportSection:AddButton({
        Name = "Teleport To Player",
        Callback = function()
            if workspace:FindFirstChild(getgenv().playerChoice) and workspace[playerChoice]:FindFirstChild("HumanoidRootPart") and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then 
                local rootPart = localPlayer.Character.HumanoidRootPart
                local playerRootPart = workspace[playerChoice].HumanoidRootPart
                rootPart.CFrame = playerRootPart.CFrame
            end
        end
    })

    uiEssentials.RefreshPlayersDropdown = TeleportSection:AddButton({ Name = "Refresh Players Dropdown",
        Callback = function()
            gameEssentialVariables.playerList = {}
            for i, v in next, Players:GetPlayers() do 
                if v ~= localPlayer then
                    table.insert(gameEssentialVariables.playerList, v.Name)
                end
            end
            uiEssentials.PlayerTeleports.UpdateList(gameEssentialVariables.playerList)
        end
    })
    uiEssentials.TeleportToNimbusSea = TeleportSection:AddButton({ Name = "Teleport to Nimbus Sea", Callback = function() teleportToSea(supportedGames["Arcane Odyssey"]["Nimbus Sea"]) end })
    uiEssentials.TeleportToBronzeSea = TeleportSection:AddButton({ Name = "Teleport to Bronze Sea", Callback = function() teleportToSea(supportedGames["Arcane Odyssey"]["Bronze Sea"]) end })
    uiEssentials.ChestFarm = FarmSection:AddToggle({ Name = "Chest Farm [RISKY]", Flag = "Chest Farm [RISKY]",
        Callback = function(v)
            getgenv().chestFarm = v 
            if not v then 
                if gameEssentialVariables.chestFarmEv then gameEssentialVariables.chestFarmEv:Disconnect(); gameEssentialVariables.chestFarmEv = nil end 
                if localPlayer.Character then 
                    local character = localPlayer.Character
                    if character:FindFirstChild("HumanoidRootPart") then 
                        character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0)
                        if character.HumanoidRootPart:FindFirstChild("BodyVelocity") then 
                            repeat taskWait() character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0); character.HumanoidRootPart.BodyVelocity:Destroy() until not character.HumanoidRootPart:FindFirstChild("BodyVelocity")
                        end
                    end
                end
                unNoClip()
                unNoClip()
            end
        end
    })

    coroutineResume(coroutineCreate(function()
        while taskWait() do 
            if chestFarm then 
                local nearestChest = getNearestChest()
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = localPlayer.Character.HumanoidRootPart

                    if not rootPart:FindFirstChild("BodyVelocity") then
                        local bodyVel = Instance.new("BodyVelocity", rootPart)
                        bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        bodyVel.Velocity = Vector3.new(0, 0, 0)
                    end
                end 
                gameEssentialVariables.chestEv = RunService.RenderStepped:Connect(function()
                    if chestFarm and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and nearestChest and nearestChest.Parent and not nearestChest.Parent:FindFirstChild("Open") then
                        local rootPart = localPlayer.Character.HumanoidRootPart

                        if not rootPart:FindFirstChild("BodyVelocity") then
                            local bodyVel = Instance.new("BodyVelocity", rootPart)
                                
                            bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            bodyVel.Velocity = Vector3.new(0, 0, 0)
                        end
                        rootPart.CFrame = nearestChest.CFrame * CFrame.new(0, -12, 0)
                    end
                    noClip()
                end)
                if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and nearestChest and nearestChest.Parent then 
                    local character = localPlayer.Character
                    task.wait(10)
                    openChestRemote:FireServer(nearestChest.Parent)
                end
            end
        end
    end))
    --gameEssentialVariables.
    -- Essential Hooks Disable Mob Damage/AI, Damage Multiplier 
    local disableMobAIHook; disableMobAIHook = hookmetamethod(game, "__namecall", function(self, ...)
        local args = { ... }
        if disableMobAI then 
            if self.Name == "TargetBehavior" or self.Name == "SetTarget" then 
                return
            end
        end
    
        return disableMobAIHook(self, unpack(args))
    end)

    local damageMultiplierHook; damageMultiplierHook = hookmetamethod(game, "__namecall", function(self, ...)
        if damageMultiplier then
            if self.Name:find("Deal") and self.Name:find("Damage") then
                if localPlayer.Character and ... == localPlayer.Character or select(2, ...) == localPlayer.Character then
                    for _ = 1, 3 do
                        self.FireServer(self, ...)
                    end
                    return 
                end
            end
        end
        return damageMultiplierHook(self, ...)
    end)

    local disableMobDamageHook; disableMobDamageHook = hookmetamethod(game, "__namecall", function(self, ...)
        local args = { ... }
        
        if disableMobDamage then
            local methodName = tostring(self)
            local damageMethods = {
                DealAttackDamage = {2, 3},
                DealWeaponDamage = {3},
                DealBossDamage = {2},
                DealStrengthDamage = {3}
            }
            if damageMethods[methodName] then
                for _, argIndex in ipairs(damageMethods[methodName]) do
                    if args[argIndex] == localPlayer.Character and args[1] ~= localPlayer.Character then
                        args[argIndex] = nil
                    end
                end
            end
            if methodName == "TouchDamage" or methodName == "TakeSideDamage" then
                return
            end
        end

        return disableMobDamageHook(self, unpack(args))
    end)

end 

queueTeleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/asxhes/robloxScripts/main/anomaly.lua"))()]])
