local player = game:GetService("Players").LocalPlayer
local leaderstats = player:FindFirstChild("leaderstats")

if leaderstats then
    local inventory = leaderstats:FindFirstChild("Inventory")
    if inventory then
        local items = inventory:FindFirstChild("Items")
        if items then
            local enchCommon = items:FindFirstChild("EnchCommon")
            local enchRare = items:FindFirstChild("EnchRare")
            local enchLegendary = items:FindFirstChild("EnchLegendary")

            local commonAmount = enchCommon and enchCommon:GetAttribute("Amount") or 0
            local rareAmount = enchRare and enchRare:GetAttribute("Amount") or 0
            local legendaryAmount = enchLegendary and enchLegendary:GetAttribute("Amount") or 0

            local time = os.time() + (8 * 3600)
            local hour = tonumber(os.date("%I", time)) -- Get 12-hour format hour
            local minute = os.date("%M", time) -- Get minutes
            local amPm = os.date("%p", time) -- AM or PM
            local formattedTime = string.format("%d:%s %s", hour, minute, amPm)

            local webhookUrl = "https://ap-is-ivory.vercel.app/api/webhook"
            local data = {
                embeds = {{
                    title = "📦 Inventory Update",
                    description = string.format(
                        "🕒 *As of %s *\n\nYou have:\n- ✨ %d Common Dust\n- 🔮 %d Rare Dust\n- 🏆 %d Legendary Dust",
                        formattedTime, commonAmount, rareAmount, legendaryAmount
                    ),
                    color = 16776960 -- Yellow color
                }}
            }

            local jsonData = game:GetService("HttpService"):JSONEncode(data)

            local requestFunction = (http_request or request or syn.request or fluxus.request)
            if requestFunction then
                requestFunction({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = jsonData
                })
            else
                warn("Your exploit does not support HTTP requests!")
            end
        end
    end
end
