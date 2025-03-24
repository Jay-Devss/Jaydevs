local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()
local webhookUrl = "https://discord.com/api/webhooks/1068114147935522826/kX61hYF6wVSlueI1F9UpFvdPAe5zoe2hUtJSN4YlPUHe5sOgoAs6kU4BfLwPXxjsh8gs"
local player = game:GetService("Players").LocalPlayer
local playerGui = player:FindFirstChild("PlayerGui")

if _G.JayLoggerRunning then
    jay:Notify({
        Title = "Jay Logger | Fisch",
        Content = "Catch webhook is already running!",
        Duration = 2
    })
    return
end
_G.JayLoggerRunning = true

jay:Notify({
    Title = "Webhook Sender",
    Content = "Script is running...",
    Duration = 5
})

local function antiAFK()
    local virtualUser = game:GetService("VirtualUser")
    player.Idled:Connect(function()
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end)
end

antiAFK()

while task.wait(0.5) do
    if playerGui then
        local countdownGui = playerGui:FindFirstChild("CountDown")
        if countdownGui then
            local frame = countdownGui:FindFirstChild("Frame")
            if frame then
                local rewardPopup = frame:FindFirstChild("RewardPopup")
                local nextRewardText = frame:FindFirstChild("Next Reward")
                if rewardPopup and nextRewardText then
                    local rewardChance = rewardPopup:FindFirstChild("RewardChance")
                    local rewardName = rewardPopup:FindFirstChild("RewardName")
                    if rewardChance and rewardName then
                        local rewardChanceText = rewardChance.Text
                        local rewardNameText = rewardName.Text
                        local nextRewardCountdown = nextRewardText.Text
                        if nextRewardCountdown == "NEXT RANDOM REWARD IN 5 MINUTES" then
                            local embedTitle = "YOU GOT NEW REWARDS"
                            local embedColor = 16777215
                            
                            if rewardNameText == "ZIRU G" then
                                embedTitle = "YOU GOT BIGGEST REWARDS!"
                                embedColor = 65280
                            elseif rewardNameText == "TIGER" then
                                embedTitle = "YOU GOT NEW MOUNT!"
                                embedColor = 255
                            end

                            jay:Notify({
                                Title = embedTitle,
                                Content = rewardNameText .. " (" .. rewardChanceText .. ")",
                                Duration = 5
                            })

                            local data = {
                                ["username"] = "Jay AFK Rewards Notifier",
                                ["avatar_url"] = "https://i.ibb.co/BVCvL6TQ/67df8a539c155399b4214600.png",
                                ["content"] = "**" .. embedTitle .. "**",
                                ["embeds"] = {{
                                    ["title"] = embedTitle,
                                    ["fields"] = {
                                        {["name"] = "Reward Name", ["value"] = rewardNameText, ["inline"] = true},
                                        {["name"] = "Chance", ["value"] = rewardChanceText, ["inline"] = true},
                                        {["name"] = "Next Reward", ["value"] = nextRewardCountdown, ["inline"] = false}
                                    },
                                    ["color"] = embedColor
                                }}
                            }
                            local request = (syn and syn.request) or (http and http.request) or request
                            if request then
                                request({
                                    Url = webhookUrl,
                                    Method = "POST",
                                    Headers = {["Content-Type"] = "application/json"},
                                    Body = game:GetService("HttpService"):JSONEncode(data)
                                })
                            end
                        end
                    end
                end
            end
        end
    end
end
