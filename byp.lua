local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

local dataRemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")

local function buyDungeonTicket()
    local args = {
        {
            {
                Type = "Gems",
                Event = "DungeonAction",
                Action = "BuyTicket"
            },
            "\n"
        }
    }
    dataRemoteEvent:FireServer(unpack(args))
end

local function bypassDungeon()
    buyDungeonTicket()

    local createDungeonArgs = {
        {
            {
                Event = "DungeonAction",
                Action = "Create"
            },
            "\n"
        }
    }

    local dungeonID = dataRemoteEvent:FireServer(unpack(createDungeonArgs))

    task.wait(0.1)

    local startDungeonArgs = {
        {
            {
                Dungeon = dungeonID,
                Event = "DungeonAction",
                Action = "Start"
            },
            "\n"
        }
    }

    dataRemoteEvent:FireServer(unpack(startDungeonArgs))
end

local function isAllowedTime()
    local currentMinute = os.date("*t").min
    return (currentMinute >= 15 and currentMinute <= 29) or (currentMinute >= 45 and currentMinute <= 59)
end

local function checkAndRunBypass()
    local gameService = game:GetService("MarketplaceService")
    local gameInfo = gameService:GetProductInfo(game.PlaceId)
    local gameName = gameInfo.Name

    print("Game Name: " .. gameName)
    print("Game ID: " .. game.GameId)

    if string.find(gameName, "Dungeon") then
        jay:Notify({
            Title = "Dungeon Running",
            Content = "You currently doing an dungeon raid, please finish the current dungeon first before bypassing the dungeon!",
            Duration = 5
        })
        return false
    end

    if getgenv().spamDungeon or isAllowedTime() then
        bypassDungeon()
        return true
    else
        jay:Notify({
            Title = "Normal Dungeon Mode",
            Content = "Bypassing is not allowed at this time. Use the normal dungeon way.",
            Duration = 5
        })
        return false
    end
end

local function autoCheckLoop()
    while getgenv().autoBypass do
        if checkAndRunBypass() then
            while isAllowedTime() do
                task.wait(60)
            end
        else
            task.wait(60)
        end
    end
end

task.spawn(autoCheckLoop)
