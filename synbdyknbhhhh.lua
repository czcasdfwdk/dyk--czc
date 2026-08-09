local function selfDestruct()
    pcall(function()
        local player = game.Players.LocalPlayer
        if player then
            local gui = player:FindFirstChild("PlayerGui")
            if gui then
                gui:Destroy()
            end
            player:Kick("检测到抓包工具")
        end
    end)
    pcall(function()
        local player = game.Players.LocalPlayer
        if player then
            player:Destroy()
        end
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

if not hasHookAPI() then
    selfDestruct()
    return
end

local testFunc = function() return "a" end
pcall(function()
    hookfunction(testFunc, function() return "b" end)
end)

if not isHooked(testFunc) then
    selfDestruct()
    return
end

pcall(restorefunction, testFunc)

local coreFuncs = {game.HttpGet, game.HttpPost, tostring, setclipboard}
for _, f in ipairs(coreFuncs) do
    if isHooked(f) then
        selfDestruct()
        return
    end
end

local req = request or http_request or (syn and syn.request)
if req and isHooked(req) then
    selfDestruct()
    return
end

spawn(function()
    local startTime = os.clock()
    while task.wait(0.3) do
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
