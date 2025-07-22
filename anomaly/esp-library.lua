local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Workspace = game:GetService("Workspace")

local ESP = {}

local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local boxEspCache, textEspCache, arrowsCache = {}, {}, {}

--> Cached Commons: 
local V3, V2, C3 = Vector3.new, Vector2.new, Color3.fromRGB
local pos = V3(0, 3, 0)

--> Helper Functions:
local function createDrawing(class, props)
    local drawing = Drawing.new(class)
    for i, v in pairs(props) do
        drawing[i] = v
    end
    return drawing
end

local function wtvp(cam, pos)
    return cam:WorldToViewportPoint(pos)
end

local function round(num)
    return math.floor(num)
end

-- Assume all your existing code above stays the same

-- Update AddBoxESP to accept either player or NPC model
function ESP:AddBoxESP(model)
    if boxEspCache[model] then return end

    boxEspCache[model] = {
        outline = createDrawing("Square", {
            Visible = false,
            Color = C3(0, 0, 0),
            Filled = false,
            Thickness = 3,
            Transparency = 1
        }),

        box = createDrawing("Square", {
            Visible = false,
            Color = C3(255, 255, 255),
            Filled = false,
            Thickness = 2,
            Transparency = 1
        })
    }
end

function ESP:RemoveBoxESP(model)
    if not boxEspCache[model] then return end

    boxEspCache[model].outline:Remove()
    boxEspCache[model].box:Remove()
    boxEspCache[model] = nil
end

local function updateBox(model, cached)
    local isFFA = #Teams:GetChildren() == 0

    if not model then
        cached.outline.Visible = false
        cached.box.Visible = false
        return
    end

    local head = model:FindFirstChild("Head")
    local humanoid = model:FindFirstChild("Humanoid")

    if head and humanoid and humanoid.Health > 0 then
        local cf = model:GetBoundingBox()
        local top = wtvp(camera, cf.Position + pos)
        local bottom = wtvp(camera, cf.Position - pos)
        local height = top.Y - bottom.Y
        local width = height / 1.2

        local headPos, onScreen = camera:WorldToViewportPoint(head.Position)

        if onScreen then
            local pos2d = V2(headPos.X - width / 2, headPos.Y - height / 1.2)

            cached.outline.Size = V2(width, height)
            cached.outline.Position = pos2d
            cached.outline.Visible = isFFA or (model.Parent and model.Parent:IsA("Player")) and localPlayer.Team ~= model.Parent.Team or true

            cached.box.Size = cached.outline.Size
            cached.box.Position = pos2d
            cached.box.Visible = cached.outline.Visible

            if ESP.BoxColor then
                cached.box.Color = ESP.BoxColor
            end

            return
        end
    end

    cached.outline.Visible = false
    cached.box.Visible = false
end

function ESP:EnableBoxESP()
    -- Add box esp to players
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self:AddBoxESP(player.Character)
        end
    end

    -- Example: Add box esp to NPCs in a folder called "NPCs"
    local NPCFolder = workspace:FindFirstChild("NPCs")
    if NPCFolder then
        for _, npc in ipairs(NPCFolder:GetChildren()) do
            if npc:IsA("Model") then
                self:AddBoxESP(npc)
            end
        end
    end

    ESP._playerAdded = Players.PlayerAdded:Connect(function(player)
        self:AddBoxESP(player.Character)
    end)

    -- Listen for NPCs added dynamically (optional)
    if NPCFolder then
        ESP._npcAdded = NPCFolder.ChildAdded:Connect(function(npc)
            if npc:IsA("Model") then
                self:AddBoxESP(npc)
            end
        end)
    end

    ESP._playerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:RemoveBoxESP(player.Character)
    end)

    if NPCFolder then
        ESP._npcRemoving = NPCFolder.ChildRemoved:Connect(function(npc)
            self:RemoveBoxESP(npc)
        end)
    end

    ESP._update = RunService.RenderStepped:Connect(function()
        for model, cached in pairs(boxEspCache) do
            updateBox(model, cached)
        end
    end)
end

function ESP:DisableBoxESP()
    if ESP._playerAdded then ESP._playerAdded:Disconnect() end
    if ESP._npcAdded then ESP._npcAdded:Disconnect() end
    if ESP._playerRemoving then ESP._playerRemoving:Disconnect() end
    if ESP._npcRemoving then ESP._npcRemoving:Disconnect() end
    if ESP._update then ESP._update:Disconnect() end

    for model, _ in pairs(boxEspCache) do
        self:RemoveBoxESP(model)
    end
end

function ESP:AddTextESP(player)
    if textEspCache[player] then return end

    textEspCache[player] = {
        text = createDrawing("Text", {
            Color = C3(255, 255, 255),
            Text = "",
            Visible = false,
            Center = true,
            Outline = true,
            Position = V2(0, 0),
            Size = 16,
            Font = 1
        })
    }
end

function ESP:RemoveTextESP(player)
    if not textEspCache[player] then return end
    textEspCache[player].text:Remove()
    textEspCache[player] = nil
end

local function updateText(player, cached)
    local isFFA = #Teams:GetChildren() == 0
    local char = player.Character
    local text = cached.text

    if not char then text.Visible = false return end

    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")

    if head and root and humanoid and humanoid.Health > 0 then
        local headPos, onScreen = wtvp(camera, head.Position)
        if onScreen then
            local dist = round(localPlayer:DistanceFromCharacter(head.Position))
            local health = round(humanoid.Health)
            local maxHealth = round(humanoid.MaxHealth)

            text.Text = string.format("[%s][%d] \n [%d/%d]", player.Name, dist, health, maxHealth)
            text.Position = V2(headPos.X, headPos.Y)
            text.Visible = isFFA or localPlayer.Team ~= player.Team

            if ESP.TextColor then
                text.Color = ESP.TextColor
            end
            return
        end
    end

    text.Visible = false
end

function ESP:EnableTextESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self:AddTextESP(player)
        end
    end

    self._textPlayerAdded = Players.PlayerAdded:Connect(function(player)
        self:AddTextESP(player)
    end)

    self._textPlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:RemoveTextESP(player)
    end)

    self._textUpdate = RunService.RenderStepped:Connect(function()
        for player, cached in pairs(textEspCache) do
            updateText(player, cached)
        end
    end)
end

function ESP:AddArrowESP(player)
    if arrowsCache[player] then return end

    arrowsCache[player] = {
        arrow = createDrawing("Triangle", {
            Thickness = 1,
            Color = C3(255, 255, 255),
            Filled = true,
            Visible = false,
            Transparency = 1
        })
    }
end

function ESP:RemoveArrowESP(player)
    if not arrowsCache[player] then return end
    arrowsCache[player].arrow:Remove()
    arrowsCache[player] = nil
end

local function updateArrow(player, cached)
    local isFFA = #Teams:GetChildren() == 0
    local char = player.Character
    local arrow = cached.arrow

    if not char then arrow.Visible = false return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then arrow.Visible = false return end

    local rootPos, onScreen = camera:WorldToViewportPoint(root.Position)

    if not onScreen then
        local centerScreen = camera.ViewportSize / 2
        local rel = -camera.CFrame:PointToObjectSpace(root.Position)
        local dir = V2(rel.X, rel.Z).Unit

        local base = dir * 150
        local tip = dir * 170
        local perp = V2(-dir.Y, dir.X)

        local left = base - perp * 10
        local right = base + perp * 10

        if ESP.ArrowColor then
            arrow.Color = ESP.ArrowColor
        end

        arrow.PointA = centerScreen - left
        arrow.PointB = centerScreen - right
        arrow.PointC = centerScreen - tip
        arrow.Visible = isFFA or localPlayer.Team ~= player.Team
    else
        arrow.Visible = false
    end
end

function ESP:EnableArrowESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self:AddArrowESP(player)
        end
    end

    self._arrowPlayerAdded = Players.PlayerAdded:Connect(function(player)
        self:AddArrowESP(player)
    end)

    self._arrowPlayerRemoving = Players.PlayerRemoving:Connect(function(player)
        self:RemoveArrowESP(player)
    end)

    self._arrowUpdate = RunService.RenderStepped:Connect(function()
        for player, cached in pairs(arrowsCache) do
            updateArrow(player, cached)
        end
    end)
end

function ESP:DisableArrowESP()
    if self._arrowUpdate then self._arrowUpdate:Disconnect() end
    if self._arrowPlayerAdded then self._arrowPlayerAdded:Disconnect() end
    if self._arrowPlayerRemoving then self._arrowPlayerRemoving:Disconnect() end

    for player in pairs(arrowsCache) do
        self:RemoveArrowESP(player)
    end
end

return ESP
