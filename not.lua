getgenv().Webhook = getgenv().Webhook or "https://ap-is-ivory.vercel.app/api/webhook"
getgenv().isWebhookActive = true

local function escape(text)
    return text:gsub("([%-%[%]%(%)%.%+%*%?%^%$])", "\\%1")
end

function NotifyWebhook()
    task.spawn(function()
        local sent = false
        local startTime = os.time()

        while getgenv().isWebhookActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 12s" and not sent then
                    sent = true

                    local leaderstats = player:FindFirstChild("leaderstats")
                    local inventory = leaderstats and leaderstats:FindFirstChild("Inventory")
                    local items = inventory and inventory:FindFirstChild("Items")
                    local enchCommon = items and items:FindFirstChild("EnchCommon")
                    local enchRare = items and items:FindFirstChild("EnchRare")
                    local enchLegendary = items and items:FindFirstChild("EnchLegendary")

                    local commonStart = enchCommon and enchCommon:GetAttribute("Amount") or 0
                    local rareStart = enchRare and enchRare:GetAttribute("Amount") or 0
                    local legendaryStart = enchLegendary and enchLegendary:GetAttribute("Amount") or 0

                    local commonEnd = enchCommon and enchCommon:GetAttribute("Amount") or 0
                    local rareEnd = enchRare and enchRare:GetAttribute("Amount") or 0
                    local legendaryEnd = enchLegendary and enchLegendary:GetAttribute("Amount") or 0

                    local gainCommon = commonEnd - commonStart
                    local gainRare = rareEnd - rareStart
                    local gainLegendary = legendaryEnd - legendaryStart

                    local endTime = os.time()
                    local duration = endTime - startTime
                    local minutes = math.floor(duration / 60)
                    local seconds = duration % 60
                    local formattedDuration = string.format("%d minute(s) %d second(s)", minutes, seconds)

                    local timeNow = os.date("%I:%M:%S %p", endTime)
                    local summaryText = ""

                    if gainCommon > 0 then
                        summaryText = string.format("You gained *%d* common dust in this run.\n", gainCommon)
                    end
                    if gainRare > 0 then
                        summaryText = string.format("You gained *%d* rare dust in this run.\n", gainRare)
                    end
                    if gainLegendary > 0 then
                        summaryText = string.format("You gained *%d* legendary dust in this run.\n", gainLegendary)
                    end
                    
                    local titleMsg = "You completed a Dungeon ✅"

                    local description = string.format(
                        "*%s*\n\n*Player:* %s\n*Time Completed:* %s\n*Duration:* %s\n\n*Dust Gained This Run:*\n- ✨ Common Dust: +%d\n- 🔮 Rare Dust: +%d\n- 🏆 Legendary Dust: +%d\n\n*Summary:*\n%s",
                        escape(titleMsg), escape(player.Name), escape(timeNow), escape(formattedDuration),
                        gainCommon, gainRare, gainLegendary, escape(summaryText)
                    )

                    local data = {
                        text = description,
                        parse_mode = "MarkdownV2"
                    }

                    local jsonData = game:GetService("HttpService"):JSONEncode(data)
                    local requestFunction = (http_request or request or syn.request or fluxus.request)
                    if requestFunction then
                        requestFunction({
                            Url = getgenv().Webhook,
                            Method = "POST",
                            Headers = {["Content-Type"] = "application/json"},
                            Body = jsonData
                        })
                    else
                        warn("HTTP requests not supported.")
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end

NotifyWebhook()
