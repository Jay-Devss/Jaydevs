local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

if getgenv().jaydevs_autototem then 
    jay:Notify({ Title = "⚠️ Script Already Running", Content = "Auto Summon Whale Event script is already running!", Duration = 4 })
    return 
end
getgenv().jaydevs_autototem = true

local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local backpack = lp:FindFirstChild("Backpack") or lp:WaitForChild("Backpack")
local zones = game:GetService("Workspace"):WaitForChild("zones")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lastWhalePoolTick = 0
local lastAuroraNotification = 0 

jay:Notify({ Title = "🐋 Auto Summon Whale Event", Content = "By Jay Devs - Monitoring Whale Pool status...", Duration = 5 })

local function notify(content, duration)
    jay:Notify({ Title = "🔍 Status", Content = content, Duration = duration or 3 })
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
    return fishing and fishing:IsA("Model") and fishing:FindFirstChild("Whales Pool") ~= nil
end

local function buyTotem(Totem, amount)
    local event = ReplicatedStorage:FindFirstChild("events") and ReplicatedStorage.events:FindFirstChild("purchase")
    if event then
        event:FireServer(Totem, "Item", nil, amount or totemAmount)
    end
end

local function equipActivateUnequip(Totem)
    local totem = backpack:FindFirstChild(Totem)

    if not totem then
        buyTotem(Totem, totemAmount)
        task.wait(2)
        totem = backpack:FindFirstChild(Totem)
    end

    if totem then
        ReplicatedStorage.packages.Net["RE/Backpack/Equip"]:FireServer(totem)
        task.wait(0.5)
        totem.Parent = char
        task.wait(0.2)
        totem:Activate()
        task.wait(1)
        totem.Parent = backpack
    end
end

local function autoPopTotemWhileFishing(Totem)
    local rod_name = ReplicatedStorage.playerstats[lp.Name].Stats.rod.Value
    local char = lp.Character
    if char then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == rod_name then
                tool.Parent = lp.Backpack
                equipActivateUnequip(Totem)
                task.wait(0.5)
                tool.Parent = char
                task.wait(1)
                tool.Parent = char
                tool.Parent = lp.Backpack
                task.wait(1)
                tool.Parent = char
                return
            end
        end
    end
    equipActivateUnequip(Totem)
end

local function jaydevsautowhale()
    while getgenv().jaywhale do
        local currentCycle = getServerInfo("3_cycle")
        local currentWeather = getServerInfo("2_weather")

        if currentWeather == "Aurora Borealis" then
            notify("❌ Aurora Borealis is active! Waiting for it to end before popping totems.", 10)
            repeat
                task.wait(5)
                currentWeather = getServerInfo("2_weather")
            until currentWeather ~= "Aurora Borealis"
            notify("✅ Aurora Borealis has ended! Resuming auto summon.", 5)
        end

        if not isWhalePoolPresent() then
            notify("⚠️ Whale Pool Missing! Auto summoning whale event... ⏳", 5)
            while not isWhalePoolPresent() and getgenv().jaywhale do
                autoPopTotemWhileFishing("Windset Totem")
                if isWhalePoolPresent() then break end
                task.wait(1)

                autoPopTotemWhileFishing("Tempest Totem")
                if isWhalePoolPresent() then break end
                task.wait(1)
            end
            lastWhalePoolTick = tick()
            notify("✅ Whale Pool Found! Stopping auto summon. 🎉", 5)
        end

        if tick() - lastWhalePoolTick > 900 then
            lastWhalePoolTick = tick()
            notify("✅ Whale Pool is still active. 🐋", 5)
        end

        if currentWeather == "Rain" then
            if auto_pop_aurora then
                if currentCycle == "Day" then
                    notify("🌧️ Rain detected during Day! Using Sundial Totem to switch to Night.", 5)
                    equipActivateUnequip("Sundial Totem")

                    repeat
                        task.wait(1)
                        currentCycle = getServerInfo("3_cycle")
                    until currentCycle == "Night"

                    notify("🌌 Making Aurora Borealis! Popping Aurora Totem.", 5)
                    equipActivateUnequip("Aurora Totem")
                elseif currentCycle == "Night" then
                    notify("🌧️ Rain detected during Night! Popping Aurora Totem directly.", 5)
                    equipActivateUnequip("Aurora Totem")
                end
            else
                notify("🌧️ Rain detected! Using Windset Totem to clear weather.", 5)
                equipActivateUnequip("Windset Totem")
            end
        elseif auto_pop_aurora and currentWeather ~= "Aurora Borealis" then
            if currentCycle ~= "Night" then
                notify("🌙 Not Night! Using Sundial Totem to switch to Night.", 5)
                equipActivateUnequip("Sundial Totem")
                repeat
                    task.wait(1)
                    currentCycle = getServerInfo("3_cycle")
                until currentCycle == "Night"
            end
            notify("🌌 Popping Aurora Totem to trigger Aurora Borealis!", 5)
            equipActivateUnequip("Aurora Totem")
        end

        task.wait(10)
    end
end

task.spawn(jaydevsautowhale)

if getgenv().jaywhale then
    notify("✅ Auto Summon Whale Event ENABLED!", 5)
else
    notify("❌ Auto Summon Whale Event DISABLED!", 5)
end
