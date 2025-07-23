--// Optimized ESP System (Modular, Scalable, Efficient)
local ESP = {}

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Camera = workspace.CurrentCamera

--// Aliases
local localPlayer = Players.LocalPlayer
local vector2New, vector3New = Vector2.new, Vector3.new
local wtvp = Camera.WorldToViewportPoint
local fromRGB = Color3.fromRGB
local newColor = Color3.new

--// Caches
ESP.Caches = {
    Square = {},
    Text = {},
    HealthBar = {},
    -- Add more caches as needed
}

--// Utility
local function createDrawing(typeName, properties)
    local drawing = Drawing.new(typeName)
    for prop, val in pairs(properties) do
        drawing[prop] = val
    end
    return drawing
end

local function hideAll(drawings)
    for _, drawing in pairs(drawings) do
        if drawing and drawing.Visible ~= nil then
            drawing.Visible = false
        end
    end
end

--// ESP Type Definitions
ESP.Types = {}

ESP.Types["Square"] = {
    create = function(player)
        if not ESP.Caches.Square[player] then
            ESP.Caches.Square[player] = {
                Outline = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(0, 0, 0),
                    Thickness = 3,
                    Filled = false,
                    Transparency = 1
                }),
                Box = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(255, 255, 255),
                    Thickness = 2,
                    Filled = false,
                    Transparency = 1
                })
            }
        end
    end,

    update = function(player)
        local drawings = ESP.Caches.Square[player]
        if not drawings then return end

        local character = player.Character
        local box, outline = drawings.Box, drawings.Outline
        hideAll(drawings)

        if not character then return end

        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        if not head or not humanoid or humanoid.Health <= 0 then return end

        local headPos, onScreen = wtvp(Camera, head.Position)
        if not onScreen then return end

        local centerCFrame = character:GetBoundingBox()
        local halfHeight = 6 / 2 -- You can replace with dynamic value if needed
        local top = wtvp(Camera, centerCFrame.Position + vector3New(0, halfHeight, 0))
        local bottom = wtvp(Camera, centerCFrame.Position - vector3New(0, halfHeight, 0))

        local height = math.abs(top.Y - bottom.Y)
        local minHeight = 25  -- Minimum height in pixels
        if height < minHeight then
            height = minHeight
        end

        local width = height / 1.2 

        --> avg width is 113 at a good dist, avg height is 135 


        local size = vector2New(width, height)
        local position = vector2New(headPos.X - width / 2, headPos.Y - height / 1.2)

        local isFFA = #Teams:GetChildren() == 0
        local isEnemy = isFFA or localPlayer.Team ~= player.Team

        outline.Size = size
        outline.Position = position
        outline.Visible = isEnemy

        box.Size = size
        box.Position = position
        box.Visible = isEnemy
    end,

    remove = function(player)
        local drawings = ESP.Caches.Square[player]
        if drawings then
            for _, d in pairs(drawings) do d:Remove() end
            ESP.Caches.Square[player] = nil
        end
    end
}

--// Main update loop
local activeTypes = {}
RunService.RenderStepped:Connect(function()
    for name, enabled in pairs(activeTypes) do
        if enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= localPlayer then
                    ESP.Types[name].update(player)
                end
            end
        end
    end
end)

--// Public API
function ESP:Enable(typeName)
    activeTypes[typeName] = true
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self.Types[typeName].create(player)
        end
    end

    Players.PlayerAdded:Connect(function(player)
        self.Types[typeName].create(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        self.Types[typeName].remove(player)
    end)
end

function ESP:Disable(typeName)
    activeTypes[typeName] = false
    for _, player in ipairs(Players:GetPlayers()) do
        self.Types[typeName].remove(player)
    end
end

return ESP
