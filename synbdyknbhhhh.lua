
local function hideAllGUI()
    pcall(function()
        local player = game.Players.LocalPlayer
        if player then
            local gui = player:FindFirstChild("PlayerGui")
            if gui then
                gui.Enabled = false
                gui.Parent = nil
            end
            local coreGui = game:GetService("CoreGui")
            if coreGui then
                coreGui.Enabled = false
            end
            local screenGui = Instance.new("ScreenGui")
            screenGui.Name = "Blocker"
            screenGui.ResetOnSpawn = false
            screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            frame.BackgroundTransparency = 0
            frame.ZIndex = 9999
            frame.Parent = screenGui
            screenGui.Parent = player:WaitForChild("PlayerGui")
        end
    end)
end

local function selfDestruct()
    hideAllGUI()
    task.wait(0.15)
    pcall(function()
        local player = game.Players.LocalPlayer
        if player then
            player:Kick("检测到抓包工具，脚本已终止")
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
