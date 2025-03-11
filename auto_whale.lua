local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

if getgenv().jaydevs_autototem then 
    jay:Notify({
        Title = "⚠️ Script Already Running",
        Content = "Auto Summon Whale Event script is already running!",
        Duration = 4
    })
    return 
end
getgenv().jaydevs_autototem = true

local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local backpack = lp:FindFirstChild("Backpack") or lp:WaitForChild("Backpack")
local zones = game:GetService("Workspace"):WaitForChild("zones")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lastWhalePoolTick = 0 

jay:Notify({
    Title = "🐋 Auto Summon Whale Event",
    Content = "By Jay Devs - Monitoring Whale Pool status...",
    Duration = 5
})

local function notify(content, duration)
    jay:Notify({
        Title = "🔍 Status",
        Content = content,
        Duration = duration or 3
    })
end

local function getServerInfo(Name)
    local playerGui = lp:FindFirstChild("PlayerGui")
    if playerGui then
        local hud = playerGui:FindFirstChild("hud")
        if hud then
            local safezone = hud:FindFirstChild("safezone")
            if safezone then
                local worldstatuses = safezone:FindFirstChild("worldstatuses")
                if worldstatuses then
                    local season = worldstatuses:FindFirstChild(Name)
                    if season then
                        local label = season:FindFirstChild("label")
                        if label and label:IsA("TextLabel") then
                            return label.Text
                        end
                    end
                end
            end
        end
    end
    return "Unknown"
end

local function isWhalePoolPresent()
    local fishing = zones:FindFirstChild("fishing")
    if fishing and fishing:IsA("Model") then
        return fishing:FindFirstChild("Whales Pool") ~= nil
    end
    return false
end

local function buyTotem(Totem)
    local event = ReplicatedStorage:FindFirstChild("events") and ReplicatedStorage.events:FindFirstChild("purchase")
    if event then
        event:FireServer(Totem, "Item", nil, 1)
    else
        warn("Purchase event not found!")
    end
end

local function equipActivateUnequip(Totem)
    local totem = backpack:FindFirstChild(Totem)

    if not totem and auto_buy_totem then
        notify("🛒 Buying missing totem: " .. Totem, 4)
        buyTotem(Totem)
        task.wait(2)
        totem = backpack:FindFirstChild(Totem)
    end

    if totem then
        game:GetService("ReplicatedStorage"):WaitForChild("packages"):WaitForChild("Net")
            :WaitForChild("RE/Backpack/Equip"):FireServer(totem)

        task.wait(0.5)

        if totem.Parent == backpack then
            totem.Parent = char
        end

        if totem.Parent == char then
            totem:Activate()
            task.wait(1)
            totem.Parent = backpack
        end
    end
end

while true do
    if getServerInfo("2_weather") == "Rain" then
        notify("🌧️ Rain detected! Using Windset Totem to clear weather.", 5)
        equipActivateUnequip("Windset Totem")
    end

    if not isWhalePoolPresent() then
        notify("⚠️ Whale Pool Missing! Auto summoning whale event... ⏳", 5)

        while not isWhalePoolPresent() do
            equipActivateUnequip("Windset Totem")
            if isWhalePoolPresent() then break end

            task.wait(1)

            equipActivateUnequip("Tempest Totem")
            if isWhalePoolPresent() then break end

            task.wait(1)
        end

        lastWhalePoolTick = tick()
        notify("✅ Whale Pool Found! Stopping auto summon. 🎉", 5)
    else
        if tick() - lastWhalePoolTick > 900 then
            lastWhalePoolTick = tick()
            notify("✅ Whale Pool is still active. 🐋", 5)
        end
    end

    task.wait(10)
end
