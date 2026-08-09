

local function selfDestruct()
    pcall(function()
        game.Players.LocalPlayer:Kick("检测到抓包工具")
    end)
    pcall(game.Shutdown, game)
    while true do
        task.wait()
    end
end

local function hasHookAPI()
    local ok, result = pcall(function()
        return type(isfunctionhooked) == "function"
    end)
    return ok and result or false
end

local function isHooked(func)
    if not hasHookAPI() then
        return false
    end
    local ok, result = pcall(function()
        return isfunctionhooked(func)
    end)
    return ok and result or false
end
