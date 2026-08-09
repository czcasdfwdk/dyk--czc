
local function selfDestruct()
    pcall(function()
        local player = game.Players.LocalPlayer
        if player then
            player:Kick("检测到抓包工具")
        end
    end)
    pcall(game.Shutdown, game)
    while true do
        task.wait()
    end
end

local function isHooked(func)
    if isfunctionhooked then
        return isfunctionhooked(func)
    end
    return false
end

if isHooked(game.HttpGet) then
    selfDestruct()
    return
end

if isHooked(game.HttpPost) then
    selfDestruct()
    return
end

local requestFunc = request or http_request
if requestFunc and isHooked(requestFunc) then
    selfDestruct()
    return
end

spawn(function()
    while task.wait(0.5) do
        if isHooked(game.HttpGet) then
            selfDestruct()
        end
        if isHooked(game.HttpPost) then
            selfDestruct()
        end
        local req = request or http_request
        if req and isHooked(req) then
            selfDestruct()
        end
    end
end)
