
local ESP = {}

--> Services:
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Camera = workspace.CurrentCamera

--> Cached Commons:
local localPlayer = Players.LocalPlayer
local vector2New, vector3New = Vector2.new, Vector3.new
local wtvp = Camera.WorldToViewportPoint
local fromRGB = Color3.fromRGB
local newColor = Color3.new
local pos = vector3New(0,3,0)
local round = math.floor 

--> Caches:
ESP.Caches = {
    Square = {},
    Text = {},
    HealthBar = {},
    Line = {}, 
    Arrow = {},
    CustomText = {}, 

}

ESP.Connections = {
    PlayerAdded = nil, 
    PlayerRemoving = nil 
}
--> Helper Functions:
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

--> ESP Type Definitions:
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
        local top = wtvp(Camera, centerCFrame.Position + pos)
        local bottom = wtvp(Camera, centerCFrame.Position - pos)

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
        local topOfObject = wtvp(Camera, centerCFrame.Position + pos)
        local bottomOfObject = wtvp(Camera, centerCFrame.Position - pos)

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

ESP.Types["HealthBar"] = {
    create = function(player)
        if not ESP.Caches.HealthBar[player] then
            ESP.Caches.HealthBar[player] = {
                healthBarOutline = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(0, 0, 0),
                    Thickness = 3,
                    Filled = true,
                    Transparency = 1
                }),
                healthBar = createDrawing("Square", {
                    Visible = false,
                    Color = fromRGB(255, 0, 0),
                    Thickness = 1,
                    Filled = true,
                    Transparency = 1
                })
            }
        end
    end,

    update = function(player)
        local drawings = ESP.Caches.HealthBar[player]
        if not drawings then return end

        local character = player.Character
        local outline, bar = drawings.healthBarOutline, drawings.healthBar
        hideAll(drawings)

        if not character then return end

        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        if not head or not humanoid or humanoid.Health <= 0 then return end

        local centerCFrame, _ = character:GetBoundingBox()
        local top = wtvp(Camera, centerCFrame.Position + pos)
        local bottom = wtvp(Camera, centerCFrame.Position - pos)
        local height = top.Y - bottom.Y
        local width = height / 1.2

        local headPos, onScreen = wtvp(Camera, head.Position)
        if not onScreen then return end

        local healthRatio = humanoid.Health / humanoid.MaxHealth
        local healthBarHeight = height * healthRatio

        local boxPos = vector2New(headPos.X - width / 2, headPos.Y - height / 1.2)

        outline.Size = vector2New(2, height)
        outline.Position = vector2New(boxPos.X + 3, boxPos.Y)
        outline.Visible = (#Teams:GetChildren() == 0 or localPlayer.Team ~= player.Team) and onScreen

        bar.Size = vector2New(1, healthBarHeight)
        local offsetX = (outline.Size.X - bar.Size.X) / 2
        bar.Position = vector2New(outline.Position.X + offsetX, outline.Position.Y)
        bar.Color = Color3.new(1, 0, 0):Lerp(Color3.new(0, 1, 0), healthRatio)
        bar.Visible = outline.Visible
    end,

    remove = function(player)
        local drawings = ESP.Caches.HealthBar[player]
        if drawings then
            for _, d in pairs(drawings) do d:Remove() end
            ESP.Caches.HealthBar[player] = nil
        end
    end
}

ESP.Caches.Arrow = {}
ESP.Types["Arrow"] = {
    create = function(player)
        if ESP.Caches.Arrow[player] then return end

        ESP.Caches.Arrow[player] = {
            arrowOutline = createDrawing("Triangle", {
                Filled = false,
                Color = Color3.fromRGB(0, 0, 0),
                Visible = false,
                Transparency = 1,
                Thickness = 2,
            }),
            arrow = createDrawing("Triangle", {
                Filled = true,
                Color = Color3.fromRGB(255, 0, 0),
                Visible = false,
                Transparency = 1,
                Thickness = 1,
            }),
        }
    end,

    update = function(player)
        local espData = ESP.Caches.Arrow[player]
        if not espData then return end

        local arrowOutline = espData.arrowOutline
        local arrow = espData.arrow
        local character = player.Character

        if not character or not localPlayer.Character or not localPlayer.Character.PrimaryPart then
            arrowOutline.Visible = false
            arrow.Visible = false
            return
        end

        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then
            arrowOutline.Visible = false
            arrow.Visible = false
            return
        end

        local _, onScreen = wtvp(Camera, root.Position)
        if onScreen then
            arrowOutline.Visible = false
            arrow.Visible = false
            return
        end

        local centerScreen = Camera.ViewportSize / 2
        local targetPos = vector3New(root.Position.X, 0, root.Position.Z)
        local localPos = vector3New(localPlayer.Character.PrimaryPart.Position.X, 0, localPlayer.Character.PrimaryPart.Position.Z)

        local displacement = targetPos - localPos
        local displacement2D = vector2New(displacement.X, displacement.Z)

        local CameraYaw = math.atan2(Camera.CFrame.LookVector.X, Camera.CFrame.LookVector.Z)
        local cosYaw, sinYaw = math.cos(CameraYaw), math.sin(CameraYaw)

        local rotatedX = (displacement2D.X * -cosYaw) - (displacement2D.Y * -sinYaw)
        local rotatedY = (displacement2D.X * -sinYaw) + (displacement2D.Y * -cosYaw)

        local dir = vector2New(rotatedX, rotatedY)
        if dir.Magnitude == 0 then
            arrowOutline.Visible = false
            arrow.Visible = false
            return
        end
        local unitDir = dir.Unit

        local base = unitDir * 100
        local tip = unitDir * 120

        local perp = vector2New(-unitDir.Y, unitDir.X)
        local leftEdge = base - perp * 10
        local rightEdge = base + perp * 10

        arrowOutline.PointA = centerScreen + leftEdge
        arrowOutline.PointB = centerScreen + rightEdge
        arrowOutline.PointC = centerScreen + tip

        arrow.PointA = arrowOutline.PointA
        arrow.PointB = arrowOutline.PointB
        arrow.PointC = arrowOutline.PointC

        arrowOutline.Visible = true
        arrow.Visible = true
    end,

    remove = function(player)
        local espData = ESP.Caches.Arrow[player]
        if espData then
            espData.arrow:Remove()
            espData.arrowOutline:Remove()
            ESP.Caches.Arrow[player] = nil
        end
    end,
}

ESP.Types["CustomText"] = { 
    create = function(part)
        if ESP.Caches.CustomText[part] then return end

        ESP.Caches.CustomText[part] = {
            text = createDrawing("Text", {
                Color = fromRGB(255, 255, 255),
                Text = "", 
                Visible = false,
                Center = true, 
                Outline = true, 
                Position = vector2New(0, 0),
                Size = 16,
                Font = 1
            }),
        }
    end,

    update = function(part, text)
        if not part then return end 
        local espData = ESP.Caches.CustomText[part]
        if not espData then return end

        local text = espData.text
        local distance = round(localPlayer:DistanceFromCharacter(part.Position))
        local partPos, onScreen = wtvp(Camera, part.Position)

        if not onScreen then
            text.Visible = false
            return
        end

        text.Visible = true
        text.Position = vector2New(partPos.X, partPos.Y) 
        text.Text = string.format("[%s] | [%d]", text, distance)
    end,

    remove = function(part)
        local espData = ESP.Caches.CustomText[part]
        if espData then
            espData.text:Remove()
            ESP.Caches.CustomText[part] = nil
        end
    end,
}

--> Main update loop
local activeTypes = {}
RunService.RenderStepped:Connect(function()
    for name,enabled in next, activeTypes do
        if enabled then
            if name == "Custom Text" then 
                if not ESP.Types[name].folder then  
                    
                else 
                    for i,v in next, ESP.Types[name].folder:GetChildren() do 
                        ESP.Types[name].update(v, v.Name)
                    end 
                end 
            else 
                for _,player in next, Players:GetPlayers() do
                    if player ~= localPlayer then
                        ESP.Types[name].update(player)
                    end 
                end
            end 
        end 
    end
end)

--> Public Library Functions
function ESP:Enable(typeName)
    if typeName == "CustomText" then 
        activeTypes[typeName] = true 
        if not self.Types[typeName].folder then return end 
        for i,v in next, self.Types[typeName].folder:GetChildren() do
            self.Types[typeName].create(v)

              
        end

        self.Types[typeName].folder.ChildAdded:Connect(function(player)
            self.Types[typeName].create(player)
        end)
        
        self.Types[typeName].folder.ChildRemoved:Connect(function(child)
            self.Types[typeName].remove(child)
        end)
    else
        activeTypes[typeName] = true
        for _,player in next, Players:GetPlayers() do
            if player ~= localPlayer then
                self.Types[typeName].create(player)
            end
        end

        ESP.Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
            self.Types[typeName].create(player)
        end)

        ESP.Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
            self.Types[typeName].remove(player)
        end)
    end 
end

function ESP:Disable(typeName)
    activeTypes[typeName] = false
    for _,player in next, Players:GetPlayers() do
        self.Types[typeName].remove(player)
    end

    if ESP.Connections.PlayerAdded then ESP.Connections.PlayerAdded:Disconnect(); ESP.Connections.PlayerAdded = nil end 
    if ESP.Connections.PlayerRemoving then ESP.Connections.PlayerRemoving:Disconnect(); ESP.Connections.PlayerRemoving = nil end 

end 

return ESP
