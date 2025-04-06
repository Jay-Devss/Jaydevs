getgenv().Webhook = getgenv().Webhook or "https://ap-is-ivory.vercel.app/api/webhook"
getgenv().isActive = true

function AutoLeft()
    task.spawn(function()
        while getgenv().isActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContainer")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 10s" then
                    local vim = game:GetService("VirtualInputManager")

                    vim:SendKeyEvent(true, "BackSlash", false, game)
                    vim:SendKeyEvent(false, "BackSlash", false, game)
                    task.wait(0.5)

                    vim:SendKeyEvent(true, "Right", false, game)
                    vim:SendKeyEvent(false, "Right", false, game)
                    task.wait(0.1)

                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    task.wait(0.5)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)

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
                                local hour = tonumber(os.date("%I", time))
                                local minute = os.date("%M", time)
                                local amPm = os.date("%p", time)
                                local formattedTime = string.format("%d:%s %s", hour, minute, amPm)

                                local data = {
                                    embeds = {{
                                        title = "Dungeon Completed ✅",
                                        description = string.format(
                                            "Hey! Your dungeon run just finished.\n\n**Player Name:** %s\n**Time:** %s\n\n**Inventory:**\n- ✨ Common Dust: **%d**\n- 🔮 Rare Dust: **%d**\n- 🏆 Legendary Dust: **%d**",
                                            player.Name, formattedTime, commonAmount, rareAmount, legendaryAmount
                                        ),
                                        color = 65280 -- Green
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
                                    warn("HTTP requests are not supported by your exploit.")
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end

AutoLeft()
