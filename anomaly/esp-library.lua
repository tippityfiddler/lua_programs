
local ESP = {}

--> Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Camera = workspace.CurrentCamera

--> Cached Commons
local localPlayer = Players.LocalPlayer
local vector2New, vector3New = Vector2.new, Vector3.new
local wtvp = Camera.WorldToViewportPoint
local fromRGB = Color3.fromRGB
local newColor = Color3.new

--> Caches
ESP.Caches = {
    Square = {},
    Text = {},
    HealthBar = {},
    Lines = {}, 
}

--> Helper Functions
local function createDrawing(typeName, properties)
    local drawing = Drawing.new(typeName)
    for prop, val in next, properties do
        drawing[prop] = val
    end
    return drawing
end

local function hideAll(drawings)
    for _,drawing in next, drawings do
        if drawing and drawing.Visible ~= nil then
            drawing.Visible = false
        end
    end
end

--> ESP Type Definitions
ESP.Types = {}

ESP.Types["Square"] = {
    create = function(player)
        if not ESP.Caches.Square[player] then
            ESP.Caches.Square[player] = {
                Outline = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(0, 0, 0),
                    Thickness = 2,
                    Filled = false,
                    Transparency = 1
                }),
                Box = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(255, 255, 255),
                    Thickness = 1,
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

        local height = top.Y - bottom.Y
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
            for _,d in next, drawings do d:Remove() end
            ESP.Caches.Square[player] = nil
        end
    end
}

ESP.Types["Line"] = {
    create = function(player)
        if not ESP.Caches.Line[player] then
            ESP.Caches.Line[player] = {
                lineOutline = createDrawing("Line", {
                    Visible = false,
                    Color = fromRGB(0, 0, 0),
                    Thickness = 3,
                    Transparency = 1,
                }),
                line = createDrawing("Line", {
                    Visible = false,
                    Color = fromRGB(255, 255, 255),
                    Thickness = 1,
                    Transparency = 1,
                }),
            }
        end
    end,

    update = function(player)
        local cachedDrawings = ESP.Caches.Line[player]
        if not cachedDrawings then return end

        local lineOutline = cachedDrawings.lineOutline
        local line = cachedDrawings.line

        local character = player.Character
        if not character then
            line.Visible = false
            lineOutline.Visible = false
            return
        end

        local head = character:FindFirstChild("Head")
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not head or not root or not humanoid or humanoid.Health <= 0 then
            line.Visible = false
            lineOutline.Visible = false
            return
        end

        local centerCFrame, _ = character:GetBoundingBox()
        local topOfObject = wtvp(Camera, centerCFrame.Position + vector3New(0, 6 / 2, 0))
        local bottomOfObject = wtvp(Camera, centerCFrame.Position - vector3New(0, 6 / 2, 0))

        local heightOfObject = topOfObject.Y - bottomOfObject.Y
        local widthOfObject = heightOfObject / 1.2

        local root2dPos, onScreenRoot = wtvp(Camera, root.Position)
        local headPos, onScreenHead = wtvp(Camera, head.Position)

        local boxOutlineSize = vector2New(widthOfObject, heightOfObject)
        local boxOutlinePosition = vector2New(headPos.X - boxOutlineSize.X / 2, headPos.Y - boxOutlineSize.Y / 1.2)

        local isFFA = #Teams:GetChildren() == 0
        local shouldShow = (isFFA or localPlayer.Team ~= player.Team) and onScreenRoot and onScreenHead

        if shouldShow then
            line.From = vector2New(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)

            if ESP.Caches.Square[player] then
                local bottomMiddle = vector2New(
                    boxOutlinePosition.X + boxOutlineSize.X / 2,
                    boxOutlinePosition.Y + 0.75
                )
                line.To = bottomMiddle
            else
                line.To = vector2New(root2dPos.X, root2dPos.Y)
            end

            lineOutline.From = line.From
            lineOutline.To = line.To

            line.Visible = true
            lineOutline.Visible = true

            -- Use a customizable color if you want, else white by default
            if ESP.LineColor then
                line.Color = ESP.LineColor
            end
        else
            line.Visible = false
            lineOutline.Visible = false
        end
    end,

    remove = function(player)
        local drawings = ESP.Caches.Line[player]
        if drawings then
            drawings.line:Remove()
            drawings.lineOutline:Remove()
            ESP.Caches.Line[player] = nil
        end
    end
}

--> Main update loop
local activeTypes = {}
RunService.RenderStepped:Connect(function()
    for name,enabled in next, activeTypes do
        if enabled then
            for _,player in next, Players:GetPlayers() do
                if player ~= localPlayer then
                    ESP.Types[name].update(player)
                end
            end
        end
    end
end)

--> Public Library Functions
function ESP:Enable(typeName)
    activeTypes[typeName] = true
    for _,player in next, Players:GetPlayers() do
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
    for _,player in next, Players:GetPlayers() do
        self.Types[typeName].remove(player)
    end
end

return ESP
