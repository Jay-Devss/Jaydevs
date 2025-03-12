local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

if getgenv().genexpjaydevs then
    jay:Notify({
        Title = "Jay Level Dupe",
        Content = "Level Dupe already executed. Hold Alligator to gain EXP",
        Duration = 2
    })
    return
end
getgenv().genexpjaydevs = true

jay:Notify({
    Title = "Jay Level Dupe",
    Content = "Script is now running! Hold Alligator to gain EXP",
    Duration = 3
})

local lp = game.Players.LocalPlayer
local leaderstats = lp:FindFirstChild("leaderstats")

task.spawn(function()
    while getgenv().jayleveldupe do
        local currentLevel = leaderstats and leaderstats:FindFirstChild("Level") and leaderstats.Level.Value or "N/A"

        if currentLevel ~= "N/A" and currentLevel >= desiredLevel then
            jay:Notify({
                Title = "Jay Level Dupe",
                Content = "Reached desired level: " .. tostring(desiredLevel),
                Duration = 3
            })
            getgenv().jayleveldupe = false
            break
        end

        local success, err = pcall(function()
            workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Agaric"):WaitForChild("Agaric"):WaitForChild("complete"):InvokeServer()
        end)

        if not success then
            warn("Error invoking server: " .. tostring(err))
        end
    end
end)
