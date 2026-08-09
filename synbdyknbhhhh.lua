
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
    local ok, result = pcall(function()
        if isfunctionhooked then
            return isfunctionhooked(func)
        end
        return false
    end)
    return ok and result or false
end

if isHooked(game.HttpGet) or isHooked(game.HttpPost) then
    selfDestruct()
    return
end

local req = request or http_request or (syn and syn.request)
if req and isHooked(req) then
    selfDestruct()
    return
end

spawn(function()
    local startTime = os.clock()
    while task.wait(0.5) do
        if os.clock() - startTime > 30 then
            break
        end
        pcall(function()
            if isHooked(game.HttpGet) or isHooked(game.HttpPost) then
                selfDestruct()
            end
            local r = request or http_request
            if r and isHooked(r) then
                selfDestruct()
            end
        end)
    end
end)
