local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local ServerTeleport = {}
local localPlayer = Players.LocalPlayer

local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

-- Utility function to safely get server list
local function getServerList(placeId)
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
    
    local success, response = pcall(function()
        return httpRequest({
            Url = url,
            Method = "GET"
        })
    end)
    
    if not success or not response or not response.Body then
        return {}
    end

    local parsed
    local ok, err = pcall(function()
        parsed = HttpService:JSONDecode(response.Body)
    end)
    if not ok or not parsed or type(parsed.data) ~= "table" then
        return {}
    end

    local serverList = {}
    for _, serverData in ipairs(parsed.data) do
        local serverJobId = serverData.id
        local playersInServer = serverData.playing or 0
        local maxPlayers = serverData.maxPlayers or 0

        -- Skip full servers and current server
        if serverJobId ~= game.JobId and playersInServer < maxPlayers then
            table.insert(serverList, serverJobId)
        end
    end
    return serverList
end

function ServerTeleport.ServerHop()
    local servers = getServerList(game.PlaceId)
    if #servers == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR",
            Text = "Couldn't find different servers",
            Duration = 3,
        })
        return
    end

    local randomServer = servers[math.random(1, #servers)]
    TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, localPlayer)
end

function ServerTeleport.RejoinServer()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer)
end

function ServerTeleport.TeleportToPlaceId(placeId)
    local servers = getServerList(placeId)
    if #servers == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR",
            Text = "Couldn't find different servers",
            Duration = 3,
        })
        return
    end

    local randomServer = servers[math.random(1, #servers)]
    TeleportService:TeleportToPlaceInstance(placeId, randomServer, localPlayer)
end

return ServerTeleport
