local ESP = {}
local round = math.floor 

ESP.__index = ESP 

function ESP:hasESP(player, cache) 
    local key = player.Name .. "_" .. self.drawingName
    return cache[key] ~= nil
end 

function ESP:new(drawingName, typeOfEsp, properties)
    local obj = setmetatable({
        drawing = Drawing.new(drawingName),
        typeOfESP = typeOfEsp,
        properties = properties or {},
        currentPlayer = nil, 
        drawingName = drawingName
    }, ESP) 

    for key, value in pairs(obj.properties) do 
        obj.drawing[key] = value
    end 

    return obj 
end 

function ESP:add(player, cache)
    if self:hasESP(player) then return end 
    local key = player.Name .. "_" .. self.drawingName 
    self.currentPlayer = player 
    cache[key] = self 
end 

function ESP:remove(player, cache)
    local key = player.Name .. "_" .. self.drawingName
    if cache[key] then 
        self.drawing:Remove() 
        self.name = nil 
        self.player = nil 
        self.properties = nil 
        setmetatable(self, nil) 
        cache[key] = nil 
    end 
end 

function ESP:updateESP(localPlayer, player, camera, isFFA)
    if self:hasESP(player)  then
        local character = player.Character 

        if character then 
            if self.typeOfEsp == "Player Text ESP" then 
                local head = character:FindFirstChild("Head") 
                local humanoid = character:FindFirstChild("Humanoid")
                local root = character:FindFirstChild("HumanoidRootPart")

                if head and humanoid and root then 
                    local headPos, onScreen = wtvp(camera, head.Position)

                    if onScreen and humanoid.Health > 0 then 
                        local distanceFromHeadPos = round(localPlayer:DistanceFromCharacter(head.Position))
                        local health = round(humanoid.Health)
                        local maxHealth = round(humanoid.MaxHealth)

                        self.properties.Text = "[" .. player.Name .. "]" .. "[" .. distanceFromHeadPos .. "] \n [" .. health .. "/" .. maxHealth .. "]"
                        self.properties.Position = Vector2.new(headPos.X, headPos.Y)  -- Use Vector2.new
                        self.properties.Visible = (isFFA or localPlayer.Team ~= player.Team) and onScreen

                    else 
                        self.properties.Visible = false 
                    end 
                else 
                    self.properties.Visible = false 
                end 

            elseif self.typeOfEsp == "Player Box ESP" then 
                
            end 

        else 
            self.properties.Visible = false 
        end 
    end 
end 

return ESP 
