local HttpService = game:GetService("HttpService")
local WebhookURL = "https://discord.com/api/webhooks/1370271793188966470/CDA4X38eZF0LbmpSZ46FMm58PRufKgiEDIBAMxeZWb8FSgnT9A_1vgaBtYOXa56Rqck5"

local function getEggStock()
    local eggFolder = workspace:FindFirstChild("NPCS"):FindFirstChild("Pet Stand"):FindFirstChild("EggLocations")
    if not eggFolder then return end

    local eggData = {}
    for _, egg in pairs(eggFolder:GetChildren()) do
        if egg:IsA("Model") and egg.Name:match("Egg$") then
            local count = #egg:GetChildren()
            table.insert(eggData, {
                name = egg.Name
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
        content = "🥚 Egg stock restocked!",
        embeds = {{
            title = "🥚 Egg Stock Notifier",
            description = description,
            color = 16753920
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
    local lastHour, lastMinute
    while true do
        local now = os.date("*t")
        local min = now.min
        if (min == 0 or min == 30) and (lastMinute ~= min or lastHour ~= now.hour) then
            lastMinute = min
            lastHour = now.hour
            postEggStock()
        end
        task.wait(0.5)
    end
end)
