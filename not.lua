getgenv().Webhook = getgenv().Webhook or "https://ap-is-ivory.vercel.app/api/webhook"
getgenv().isWebhookActive = true

function NotifyWebhook()
    task.spawn(function()
        local sent = false
        while getgenv().isWebhookActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 11s" and not sent then
                    sent = true

                    local leaderstats = player:FindFirstChild("leaderstats")
                    local inventory = leaderstats and leaderstats:FindFirstChild("Inventory")
                    local items = inventory and inventory:FindFirstChild("Items")
                    local enchCommon = items and items:FindFirstChild("EnchCommon")
                    local enchRare = items and items:FindFirstChild("EnchRare")
                    local enchLegendary = items and items:FindFirstChild("EnchLegendary")

                    local commonAmount = enchCommon and enchCommon:GetAttribute("Amount") or 0
                    local rareAmount = enchRare and enchRare:GetAttribute("Amount") or 0
                    local legendaryAmount = enchLegendary and enchLegendary:GetAttribute("Amount") or 0

                    local time = os.time() + (8 * 3600) - (4 * 3600)
                    local hour = tonumber(os.date("%I", time))
                    local minute = os.date("%M", time)
                    local amPm = os.date("%p", time)
                    local formattedTime = string.format("%d:%s %s", hour, minute, amPm)
                    print("Delayed PH Time:", formattedTime)
                            
                    -- Webhook content
                    local data = {
                        embeds = {{
                            title = "Dungeon Completed ✅",
                            description = string.format(
                                "Your dungeon just wrapped up!\n\n**Player Name:** %s\n**Time:** %s\n\n**Dust Inventory:**\n- ✨ Common Dust: **%d**\n- 🔮 Rare Dust: **%d**\n- 🏆 Legendary Dust: **%d**",
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
                        warn("HTTP requests not supported.")
                    end
                elseif dungeonInfo and dungeonInfo.Text ~= "Dungeon Ends in 15s" then
                    sent = false -- reset if text changed
                end
            end)
            task.wait(0.5)
        end
    end)
end

NotifyWebhook()
