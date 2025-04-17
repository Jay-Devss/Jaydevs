local function BossSender()
    local webhookUrl = "https://discord.com/api/webhooks/1362297111869263984/rhHupoX6kYbUqqtrpGK-XDTWXGgpnYkR2iNs1spKcp3SqbioKHUx8ILOALJUaW-YnnVE"
    local HttpService = game:GetService("HttpService")
    local player = game:GetService("Players").LocalPlayer
    local BossList = {}

    -- Boss images map
    local BossImages = {
        ["Igris"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/c/c4/Vermillion.png/revision/latest?cb=20250408103728",
        ["Pain"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/8/8b/Dor.png/revision/latest?cb=20250408112805",
        ["Mihalk"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/0/03/Mifalcon.png/revision/latest?cb=20250408112924",
        ["Ulquiorra"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/7/76/Murcielago.png/revision/latest?cb=20250408114942",
        ["Julius"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/1/1e/Timeking.png/revision/latest?cb=20250408115409",
        ["Denji"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/c/cc/Chainsaw.png/revision/latest?cb=20250408115528",
        ["Pucci"] = "https://static.wikia.nocookie.net/arise-crossoverrlbx/images/1/15/Gucci.png/revision/latest?cb=20250408115642",
        ["Esil"] = "https://i.ibb.co/Q3G2hrR4/ifoto-ai-1744878699366.png",
        ["Freeza"] = "https://i.ibb.co/fVFqK1sF/ifoto-ai-1744878857777.png"
    }

    local function getCurrentCastleFloor()
        local gui = player:FindFirstChild("PlayerGui")
        local hud = gui and gui:FindFirstChild("Hud")
        local upContainer = hud and hud:FindFirstChild("UpContanier")
        local room = upContainer and upContainer:FindFirstChild("Room")
        if room and room:IsA("TextLabel") then
            if not string.find(room.Text, "Floor") then
                warn("Not in Castle. Script disabled.")
                getgenv().isActive = false
                return nil
            end
            return room.Text
        end
        return nil
    end

    local function extractFloorNumber(floorText)
        local number = string.match(floorText or "", "(%d+)")
        return number and tonumber(number) or nil
    end

    local function sendBossToDiscord(floorText, bossName)
        local embed = {
            title = "CASTLE BOSS INFO",
            fields = {
                { name = "FLOOR", value = floorText, inline = true },
                { name = "BOSS", value = bossName, inline = true }
            },
            footer = {
                text = "Detected at: " .. os.date("%Y-%m-%d %H:%M:%S")
            },
            color = 0x00FF00
        }

        local imageUrl = BossImages[bossName]
        if imageUrl then
            embed.image = { url = imageUrl }
        end

        local data = {
            username = "NU_CASTLE-SENDER",
            avatar_url = "https://i.ibb.co/Jjyfv3KX/akemiboi.jpg",
            embeds = { embed }
        }

        request({
            Url = webhookUrl,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode(data)
        })
    end

    local function isBossAlreadySent(floorText, bossName)
        for _, entry in ipairs(BossList) do
            if entry.floor == floorText and entry.boss == bossName then
                return true
            end
        end
        return false
    end

    local function saveBossRecord(floorText, bossName)
        table.insert(BossList, { floor = floorText, boss = bossName })
    end

    local function cleanOldBossRecords(currentFloorNumber)
        local newList = {}
        for _, entry in ipairs(BossList) do
            local savedFloorNumber = extractFloorNumber(entry.floor)
            if savedFloorNumber and math.abs(savedFloorNumber - currentFloorNumber) <= 1 then
                table.insert(newList, entry)
            end
        end
        BossList = newList
    end

    local function detectBoss()
        local server = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
        if not server then return end

        local floorText = getCurrentCastleFloor()
        local floorNumber = extractFloorNumber(floorText)
        if not floorNumber then return end

        cleanOldBossRecords(floorNumber)

        if floorNumber % 5 ~= 0 then return end

        for _, npc in ipairs(server:GetChildren()) do
            if npc:IsA("BasePart") and npc:GetAttribute("IsBoss") == true then
                local bossName = npc:GetAttribute("Model") or "Unknown"
                if not isBossAlreadySent(floorText, bossName) then
                    sendBossToDiscord(floorText, bossName)
                    saveBossRecord(floorText, bossName)
                end
                break
            end
        end
    end

    getgenv().isActive = true
    while task.wait(1) do
        if getgenv().isActive then
            pcall(detectBoss)
        end
    end
end

-- Start the boss sender
BossSender()
