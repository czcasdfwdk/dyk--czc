
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

for _, folder in ipairs({"HttpGetFolder", "WebhookFolder", "RequestFolder"}) do
    local ok, result = pcall(function()
        return isfolder(folder)
    end)
    if ok and result then
        selfDestruct()
        return
    end
end
