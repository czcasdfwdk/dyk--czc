
local function detectEnvironment()
    local env = getgenv()
    if env then
        local spyVars = {"HttpSpy", "__HttpSpy", "http_spy", "HTTP_SPY", "__spy", "__hook", "__debug"}
        for _, name in ipairs(spyVars) do
            if env[name] then
                return true
            end
        end
    end
    return false
end

if detectEnvironment() then
    selfDestruct()
    return
end

