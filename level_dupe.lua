local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

if getgenv().genexpjaydevs then
    jay:Notify({
        Title = "✨ Jay Level Dupe",
        Content = "✅ Level Dupe already executed! Hold 🐊 Alligator to gain EXP.",
        Duration = 2
    })
    return
end

getgenv().genexpjaydevs = true

function TPAgaric()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    if not rootPart then return end

    local originalCFrame = rootPart.CFrame

    local targetCFrame = CFrame.new(2591.52539, 132.808685, -729.38562, 
        0.00213085138, 1.22422023e-07, -0.999997735, 
        1.4245557e-09, 1, 1.22425334e-07, 
        0.999997735, -1.68542269e-09, 0.00213085138)

    rootPart.CFrame = targetCFrame

    local npcsFolder = workspace:WaitForChild("world", 10):WaitForChild("npcs", 10)
    if not npcsFolder then return end

    local agaric = npcsFolder:FindFirstChild("Agaric")
    if agaric then
        agaric.ModelStreamingMode = Enum.ModelStreamingMode.Persistent
    end

    rootPart.CFrame = originalCFrame
end

jay:Notify({
    Title = "🚀 Jay Level Dupe",
    Content = "⚡ Script is now running! Hold 🐊 Alligator to gain EXP.",
    Duration = 3
})

TPAgaric()

task.spawn(function()
    while getgenv().jayleveldupe do
        local success, err = pcall(function()
            local world = workspace:WaitForChild("world")
            local npcs = world:WaitForChild("npcs")
            local agaric = npcs:WaitForChild("Agaric"):WaitForChild("Agaric")
            local complete = agaric:WaitForChild("complete")

            for i = 1, 10000000 do
                complete:InvokeServer()
            end
        end)

        if not success then
            warn("❌ Error invoking server: " .. tostring(err))
        end
    end
end)
