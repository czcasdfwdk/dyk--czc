

local function selfDestruct(reason)
    pcall(function()
        for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetChildren()) do
            if v:IsA("ScreenGui") then
                v.Enabled = false
            end
        end
    end)
    task.wait(0.5)
    pcall(function()
        game.Players.LocalPlayer:Kick("检测到抓包工具")
    end)
    pcall(game.Shutdown, game)
end

local function checkHooks()
    if not isfunctionhooked then
        return false
    end
    local funcs = {
        game and game.HttpGet,
        game and game.HttpPost,
        tostring,
        setclipboard,
        request,
        http_request,
    }
    for _, f in ipairs(funcs) do
        if f and type(f) == "function" and isfunctionhooked(f) then
            return true
        end
    end
    if isfolder and type(isfolder) == "function" then
        for _, folder in ipairs({"HttpGetFolder", "WebhookFolder", "RequestFolder"}) do
            if isfolder(folder) then
                return true
            end
        end
    end
    return false
end


for _, name in pairs({"rconsoleprint", "rconsolewarn", "rconsoleinfo", "rconsoleerr", "rconsoletitle", "clonefunction"}) do
    pcall(function()
        if getgenv() and getgenv()[name] ~= nil then
            getgenv()[name] = nil
        end
    end)
end


if isfunctionhooked and type(isfunctionhooked) == "function" then
    if checkHooks() then
        selfDestruct()
    else
        local startTime = os.clock()
        spawn(function()
            while os.clock() - startTime < 60 do
                task.wait(2)
                if checkHooks() then
                    selfDestruct()
                    break
                end
            end
        end)
    end
end


pcall(function()
    local url = "https://raw.githubusercontent.com/czcasdfwdk/dyk-jzq-czc/main/dykjzqjzq2-czc.lua"
    local content = game:HttpGet(url, true)
    if content and #content > 100 then
        
        local fn = loadstring(content)
        if fn then
            xpcall(fn, function(err)
                
                print("外部脚本执行出错，尝试修复...")
            end)
        end
    end
end)
