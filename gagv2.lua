local HttpService = game:GetService("HttpService")
local WebhookURL = "https://discord.com/api/webhooks/1068114147935522826/kX61hYF6wVSlueI1F9UpFvdPAe5zoe2hUtJSN4YlPUHe5sOgoAs6kU4BfLwPXxjsh8gs"

local function getEggStock()
    local eggFolder = workspace:FindFirstChild("NPCS"):FindFirstChild("Pet Stand"):FindFirstChild("EggLocations")
    if not eggFolder then return end

    local eggData = {}
    for _, egg in pairs(eggFolder:GetChildren()) do
        if egg:IsA("Model") and egg.Name:match("Egg$") then
            local count = #egg:GetChildren()
            table.insert(eggData, {
                name = egg.Name,
                count = count
            })
        end
    end

    return eggData
end

local function buildEggDescription(eggData)
    local desc = {}
    for _, egg in ipairs(eggData) do
        table.insert(desc, string.format("**%s**", egg.name))
    end
    return table.concat(desc, "\n")
end

local function postEggStock()
    local eggData = getEggStock()
    if not eggData or #eggData == 0 then return end

    local description = buildEggDescription(eggData)

    local data = {
        username = "NU_GAG-EGG_NOTIFIER",
        avatar_url = "https://i.ibb.co/Jjyfv3KX/akemiboi.jpg",
        content = "@everyone 🥚 Egg stock restocked!",
        embeds = {{
            title = "🥚 Egg Stock Notifier",
            description = description,
            color = 65280‎
        }}
    }

    local jsonData = HttpService:JSONEncode(data)
    request({
        Url = WebhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = jsonData
    })
end

task.spawn(function()
    local lastSentMinute = nil
    while true do
        local now = os.date("*t")
        if (now.min == 0 or now.min == 30) and now.sec == 0 then
            if lastSentMinute ~= now.min then
                lastSentMinute = now.min
                postEggStock()
            end
        elseif now.min ~= lastSentMinute then
            lastSentMinute = nil
        end
        task.wait(0.5)
    end
end)
