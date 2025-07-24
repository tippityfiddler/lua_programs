local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local ServerTeleport = {}

local localPlayer = Players.LocalPlayer
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

function ServerTeleport.ServerHop()
    local response = httpRequest({
        Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100",
        Method = "GET"
    })
    local parsed = HttpService:JSONDecode(response.Body)
    local serverList = {}

    for _, serverData in ipairs(parsed.data) do
        local serverJobId = serverData.id
        if serverJobId ~= game.JobId then
            table.insert(serverList, serverJobId)
        end
    end

    if #serverList == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR";
            Text = "Couldn't find different servers";
            Duration = 3,
        })
    else
        local randomServer = serverList[math.random(1, #serverList)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData() or 1)
    end
end

function ServerTeleport.RejoinServer()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData() or 1)
end

function ServerTeleport.TeleportToPlaceId(placeId)
    local response = httpRequest({
        Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/0?sortOrder=2&excludeFullGames=true&limit=100",
        Method = "GET"
    })
    local parsed = HttpService:JSONDecode(response.Body)
    local serverList = {}

    for _, serverData in ipairs(parsed.data) do
        local serverJobId = serverData.id
        if serverJobId ~= game.JobId then
            table.insert(serverList, serverJobId)
        end
    end

    if #serverList == 0 then
        StarterGui:SetCore("SendNotification", {
            Title = "ERROR";
            Text = "Couldn't find different servers";
            Duration = 3,
        })
    else
        local randomServer = serverList[math.random(1, #serverList)]
        TeleportService:TeleportToPlaceInstance(placeId, randomServer, localPlayer, nil, TeleportService:GetLocalPlayerTeleportData() or 1)
    end
end

return ServerTeleport
