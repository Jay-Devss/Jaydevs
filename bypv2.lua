local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

getgenv().UltimateDungeon = getgenv().UltimateDungeon or false
local targetUser = "Jayalwayspaldooo7"
local fixedDungeonID = 7948501548
local delay = 0.5

local function fireDungeonEvent(argsTable)
    dataRemoteEvent:FireServer(unpack(argsTable))
end

local function notify(title, content, duration)
    jay:Notify({
        Title = title,
        Content = content,
        Duration = duration or 5
    })
end

local function isInDungeonGame()
    local gameName = nil
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    if success then
        gameName = result
        return string.find(gameName, "Dungeon") ~= nil
    end
    return false
end

local function buyDungeonTicket()
    fireDungeonEvent({
        {
            {
                ["Type"] = "Gems",
                ["Event"] = "DungeonAction",
                ["Action"] = "BuyTicket"
            },
            "\n"
        }
    })
end

local function createDungeon()
    fireDungeonEvent({
        {
            {
                ["Event"] = "DungeonAction",
                ["Action"] = "Create"
            },
            "\n"
        }
    })
end

local function addUltimateRune()
    fireDungeonEvent({
        {
            {
                ["Dungeon"] = fixedDungeonID,
                ["Action"] = "AddItems",
                ["Slot"] = 1,
                ["Event"] = "DungeonAction",
                ["Item"] = "DgURankUpRune"
            },
            "\n"
        }
    })
end

local function startDungeon()
    fireDungeonEvent({
        {
            {
                ["Dungeon"] = fixedDungeonID,
                ["Event"] = "DungeonAction",
                ["Action"] = "Start"
            },
            "\n"
        }
    })
end

local function tryJoinCastle()
    local minute = os.date("*t").min
    local gameName = nil
    if minute >= 45 and minute <= 59 then
        local success, result = pcall(function()
            return MarketplaceService:GetProductInfo(game.PlaceId).Name
        end)
        if success then
            gameName = result
            if string.find(gameName, "Dungeon") then
                notify("Dungeon Running", "You are currently doing a Dungeon raid. Please finish it before bypassing!", 5)
                return
            end
        end
        fireDungeonEvent({
            {
                {
                    ["Event"] = "JoinCastle"
                },
                "\n"
            }
        })
        notify("Castle Join", "You have joined the castle event!", 5)
        return true
    else
        notify("Castle Join Skipped", "Not within Castle join time window (XX:45 - XX:59).", 5)
        return false
    end
end

local function runDungeonBypass()
    local success, err = pcall(function()
        if isInDungeonGame() then
            notify("Dungeon Running", "You are currently in a Dungeon game. Please finish the current dungeon first before bypassing.", 5)
            return
        end
        if getgenv().autoCastle and tryJoinCastle() then
            return
        end
        if getgenv().autoJoinJay and player.Name ~= targetUser then
            local found = false
            for _, p in pairs(Players:GetPlayers()) do
                if p.Name == targetUser then
                    found = true
                    break
                end
            end
            if found then
                while true do
                    local stillExists = Players:FindFirstChild(targetUser)
                    if not stillExists then
                        break
                    end
                    buyDungeonTicket()
                    task.wait(delay)
                    fireDungeonEvent({
                        {
                            {
                                ["Dungeon"] = fixedDungeonID,
                                ["Event"] = "DungeonAction",
                                ["Action"] = "Join"
                            },
                            "\n"
                        }
                    })
                    task.wait(1.5)
                end
                return
            end
        end
        buyDungeonTicket()
        task.wait(delay)
        createDungeon()
        task.wait(delay)
        if getgenv().UltimateDungeon then
            addUltimateRune()
            task.wait(delay)
        end
        startDungeon()
        notify("Dungeon Started", "Dungeon started with ID: " .. fixedDungeonID .. (getgenv().UltimateDungeon and " + Rune!" or "!"), 5)
    end)
    if not success then
        notify("Error", "Something went wrong: " .. tostring(err), 6)
    end
end

local function autoLeave()
    task.spawn(function()
        while getgenv().isAutoLeftActive do
            pcall(function()
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")
                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 12s" then
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendKeyEvent(true, "BackSlash", false, game)
                    vim:SendKeyEvent(false, "BackSlash", false, game)
                    task.wait(0.5)
                    vim:SendKeyEvent(true, "Right", false, game)
                    vim:SendKeyEvent(false, "Right", false, game)
                    task.wait(0.5)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    task.wait(0.2)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    task.wait(0.2)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                end
            end)
            task.wait(0.5)
        end
    end)
end

local function autoRejoin()
    local rejoinCooldown = false
    task.spawn(function()
        while getgenv().isAutoRejoinActive do
            pcall(function()
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")
                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 20s" and not rejoinCooldown then
                    rejoinCooldown = true
                    if getgenv().autoJoinJay and player.Name ~= targetUser then
                        local found = false
                        for _, p in pairs(Players:GetPlayers()) do
                            if p.Name == targetUser then
                                found = true
                                break
                            end
                        end
                        if found then
                            while true do
                                local stillExists = Players:FindFirstChild(targetUser)
                                if not stillExists then
                                    break
                                end
                                buyDungeonTicket()
                                task.wait(delay)
                                fireDungeonEvent({
                                    {
                                        {
                                            ["Dungeon"] = fixedDungeonID,
                                            ["Event"] = "DungeonAction",
                                            ["Action"] = "Join"
                                        },
                                        "\n"
                                    }
                                })
                                task.wait()
                            end
                            return
                        end
                    end
                    buyDungeonTicket()
                    task.wait(delay)
                    createDungeon()
                    task.wait(delay)
                    if getgenv().UltimateDungeon then
                        addUltimateRune()
                        task.wait(delay)
                    end
                    startDungeon()
                    task.wait(1)
                    rejoinCooldown = false
                end
            end)
            task.wait(0.5)
        end
    end)
end

runDungeonBypass()
autoLeave()
autoRejoin()
