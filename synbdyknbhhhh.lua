local function selfDestruct()
    pcall(function()
        game.Players.LocalPlayer:Kick("检测到抓包工具")
    end)
    pcall(game.Shutdown, game)
    while true do
        task.wait()
    end
end

local function safeIsHooked(func)
    local ok, result = pcall(function()
        if isfunctionhooked then
            return isfunctionhooked(func)
        end
        return false
    end)
    return ok and result or false
end

if safeIsHooked(game.HttpGet) or safeIsHooked(game.HttpPost) then
    selfDestruct()
    return
end

local req = request or http_request or (syn and syn.request)
if req and safeIsHooked(req) then
    selfDestruct()
    return
end

local startTime = os.clock()
spawn(function()
    while task.wait(0.5) do
        if os.clock() - startTime > 30 then
            break
        end
        pcall(function()
            if safeIsHooked(game.HttpGet) or safeIsHooked(game.HttpPost) then
                selfDestruct()
            end
            local r = request or http_request
            if r and safeIsHooked(r) then
                selfDestruct()
            end
        end)
    end
end)
