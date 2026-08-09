
local function selfDestruct()
    pcall(function()
        game.Players.LocalPlayer:Kick("检测到抓包工具")
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

if not isfunctionhooked then
    selfDestruct()
    return
end

local testFunc = function()
    return "a"
end
hookfunction(testFunc, function()
    return "b"
end)
if not isfunctionhooked(testFunc) then
    selfDestruct()
    return
end
restorefunction(testFunc)

if isfunctionhooked(game.HttpGet) then
    selfDestruct()
    return
end

if isfunctionhooked(game.HttpPost) then
    selfDestruct()
    return
end

if isfunctionhooked(tostring) then
    selfDestruct()
    return
end

if isfunctionhooked(setclipboard) then
    selfDestruct()
    return
end

local req = request or http_request or (syn and syn.request)
if req and isfunctionhooked(req) then
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
            if isfunctionhooked(game.HttpGet) then
                selfDestruct()
            end
            if isfunctionhooked(game.HttpPost) then
                selfDestruct()
            end
            if isfunctionhooked(tostring) then
                selfDestruct()
            end
            if isfunctionhooked(setclipboard) then
                selfDestruct()
            end
            local r = request or http_request
            if r and isfunctionhooked(r) then
                selfDestruct()
            end
            if isfolder("HttpGetFolder") or isfolder("WebhookFolder") or isfolder("RequestFolder") then
                selfDestruct()
            end
        end)
    end
end)

for _, name in pairs({"rconsoleprint", "rconsolewarn", "rconsoleinfo", "rconsoleerr", "rconsoletitle", "clonefunction"}) do
    pcall(function()
        getgenv()[name] = nil
    end)
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/czcasdfwdk/dyk-jzq-czc/main/dykjzqjzq2-czc.lua"))()
