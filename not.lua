getgenv().Webhook = getgenv().Webhook or "https://ap-is-ivory.vercel.app/api/webhook"
getgenv().isWebhookActive = true

function NotifyWebhook()
    task.spawn(function()
        local sent = false
        local startTime = os.time()
        local startCommon, startRare, startLegendary = 0, 0, 0
        local isDoubleDungeon = false

        -- Get starting dust
        local function getStartingDust()
            local player = game:GetService("Players").LocalPlayer
            local leaderstats = player:FindFirstChild("leaderstats")
            local inventory = leaderstats and leaderstats:FindFirstChild("Inventory")
            local items = inventory and inventory:FindFirstChild("Items")
            startCommon = (items and items:FindFirstChild("EnchCommon") and items.EnchCommon:GetAttribute("Amount")) or 0
            startRare = (items and items:FindFirstChild("EnchRare") and items.EnchRare:GetAttribute("Amount")) or 0
            startLegendary = (items and items:FindFirstChild("EnchLegendary") and items.EnchLegendary:GetAttribute("Amount")) or 0
        end

        getStartingDust()

        while getgenv().isWebhookActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

                if dungeonInfo and dungeonInfo:IsA("TextLabel") then
                    local text = dungeonInfo.Text

                    if text == "Double Dungeon Appear" then
                        isDoubleDungeon = true
                    end

                    if text == "Dungeon Ends in 12s" and not sent then
                        sent = true
                        local endTime = os.time()
                        local duration = os.difftime(endTime, startTime)

                        local leaderstats = player:FindFirstChild("leaderstats")
                        local inventory = leaderstats and leaderstats:FindFirstChild("Inventory")
                        local items = inventory and inventory:FindFirstChild("Items")
                        local endCommon = (items and items:FindFirstChild("EnchCommon") and items.EnchCommon:GetAttribute("Amount")) or 0
                        local endRare = (items and items:FindFirstChild("EnchRare") and items.EnchRare:GetAttribute("Amount")) or 0
                        local endLegendary = (items and items:FindFirstChild("EnchLegendary") and items.EnchLegendary:GetAttribute("Amount")) or 0

                        local gainCommon = endCommon - startCommon
                        local gainRare = endRare - startRare
                        local gainLegendary = endLegendary - startLegendary

                        local totalGained = gainCommon + gainRare + gainLegendary
                        local formattedDuration = string.format("%d minute(s) %d second(s)", math.floor(duration / 60), duration % 60)
                        local timeNow = os.date("%I:%M:%S %p", endTime)
                        local titleMsg = isDoubleDungeon and "You completed a Double Dungeon" or "You completed a Dungeon"

                        -- Build dynamic summary
                        local summaryLines = {}
                        if gainCommon > 0 then
                            table.insert(summaryLines, string.format("You now have %d Common Dust.", endCommon))
                        end
                        if gainRare > 0 then
                            table.insert(summaryLines, string.format("You now have %d Rare Dust.", endRare))
                        end
                        if gainLegendary > 0 then
                            table.insert(summaryLines, string.format("You now have %d Legendary Dust.", endLegendary))
                        end

                        local summaryText = (#summaryLines > 0)
                            and (string.format("You gained %d dust in this run.\n%s", totalGained, table.concat(summaryLines, "\n")))
                            or "You didn’t gain any dust this run."

                        -- Webhook embed
                        local data = {
                            embeds = {{
                                title = titleMsg .. " ✅",
                                description = string.format(
                                    "Player: %s\nTime Completed: %s\nDuration: %s\n\nDust Gained This Run:\n- ✨ Common Dust: +%d\n- 🔮 Rare Dust: +%d\n- 🏆 Legendary Dust: +%d\n\nSummary:\n%s",
                                    player.Name, timeNow, formattedDuration, gainCommon, gainRare, gainLegendary, summaryText
                                ),
                                color = 65280
                            }}
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
                end
            end)
            task.wait(0.5)
        end
    end)
end

NotifyWebhook()
