local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local ReplicatedStorage = game:GetService("ReplicatedStorage") 
local MarketplaceService = game:GetService("MarketplaceService") 
local Players = game:GetService("Players") 
local VirtualInputManager = game:GetService("VirtualInputManager") 
local player = Players.LocalPlayer 
local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local LivingNPCs = {}
local selectedRunes = {}
local currentTarget = nil
local tween = nil
local lastDeadNPC = nil
local targetCFramePosition = nil
local autoBypass = false
local delay = 0.5
local tp_delay = 0.1
local fixedDungeonID = 7948501548
local skipDoubleDungeon = false 
local dungeonAction = "None"
local isActive = false
local useTween = false
local tweenSpeed = 100
local autoAriseDestroy = false
local ariseDestroyType = "Arise"
local addRunes = false


local Window = jay:CreateWindow({
    Title = "Jay Hub | " .. game:GetService("MarketplaceService"):GetProductInfo(87039211657390).Name,
    SubTitle = "By Jaydevs",
    TabWidth = 180,
    Size = UDim2.fromOffset(525, 300),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local ClickButton = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner_2 = Instance.new("UICorner")

ClickButton.Name = "ClickButton"
ClickButton.Parent = game.CoreGui
ClickButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ClickButton
MainFrame.AnchorPoint = Vector2.new(1, 0)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(1, -60, 0, 10)
MainFrame.Size = UDim2.new(0, 45, 0, 45)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = ImageLabel

ImageLabel.Parent = MainFrame
ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
ImageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0, 45, 0, 45)
ImageLabel.Image = "rbxassetid://132940723895184"

TextButton.Parent = MainFrame
TextButton.BackgroundColor3 = Color3.new(1, 1, 1)
TextButton.BackgroundTransparency = 1
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0, 0, 0, 0)
TextButton.Size = UDim2.new(0, 45, 0, 45)
TextButton.AutoButtonColor = false
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = ""
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 20

TextButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "LeftControl", false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "LeftControl", false, game)
end)

local Tabs = {
    Info = Window:AddTab({ Title = "Info", Icon = "notebook" }),
    Main = Window:AddTab({ Title = "Main", Icon = "align-justify" }),
    Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "heart" }),
    Rune = Window:AddTab({Title = "Rune", Icon = "sparkles" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Window:SelectTab(1)

local spawnMap = {
    ["Solo City"] = "SoloWorld",
    ["Grass City"] = "NarutoWorld",
    ["Brum City"] = "OPWorld",
    ["Faceheal City"] = "BleachWorld",
    ["Lucky City"] = "BCWorld",
    ["Nipon City"] = "ChainsawWorld",
    ["Jojo City"] = "JojoWorld",
    ["Dragon City"] = "DBWorld",
    ["Punch City"] = "OPMWorld",
    ["Dandadan City"] = "DanWorld"
}

local runeMap = {
    ["Health Rune"] = "DgHealthRune",
    ["Cash Rune"] = "DgCashRune",
    ["Gems Rune"] = "DgGemsRune",
    ["Time Rune"] = "DgTimeRune",
    ["More Room Rune"] = "DgMoreRoomRune",
    ["Room Rune"] = "DgRoomRune",
    ["Rank Down Rune"] = "DgRankDownRune",
    ["Rank Up Rune"] = "DgRankUpRune",
    ["Ultimate Rank Up Rune"] = "DgURankUpRune",
    ["Alien City Rune"] = "DgDanRune",
    ["Brum City Rune"] = "DgOPRune",
    ["Dragon City Rune"] = "DgDbRune",
    ["Faceheal City Rune"] = "DgBleachRune",
    ["Grass City Rune"] = "DgNarutoRune",
    ["Leveling City Rune"] = "DgSoloRune",
    ["Lucky City Rune"] = "DgBCRune",
    ["Mori City Rune"] = "DgJojoRune",
    ["Nipon City Rune"] = "DgChainsawRune",
    ["Xz City Rune"] = "DgOPMRune"
}

local displayNames = {
    "None",
    "Health Rune",
    "Cash Rune",
    "Gems Rune",
    "Time Rune",
    "More Room Rune",
    "Room Rune",
    "Rank Down Rune",
    "Rank Up Rune",
    "Ultimate Rank Up Rune",
    "Alien City Rune",
    "Brum City Rune",
    "Dragon City Rune",
    "Faceheal City Rune",
    "Grass City Rune",
    "Leveling City Rune",
    "Lucky City Rune",
    "Mori City Rune",
    "Nipon City Rune",
    "Xz City Rune",
}

-- Notifications and Error Handling
local function notify(title, content, duration)
    jay:Notify({ Title = title, Content = content, Duration = duration or 4 })
end

-- Dungeon Events
local function fireDungeonEvent(argsTable)
    dataRemoteEvent:FireServer(unpack(argsTable))
end

local function leaveDungeon()
    fireDungeonEvent({
        {
            {
                Dungeon = fixedDungeonID,
                Event = "DungeonAction",
                Action = "Leave"
            },
            "\011"
        }
    })
end

local function buyDungeonTicket()
    fireDungeonEvent({
        {
            {
                Type = "Gems",
                Event = "DungeonAction",
                Action = "BuyTicket"
            },
            "\011"
        }
    })
end

local function createDungeon()
    fireDungeonEvent({
        {
            {
                Event = "DungeonAction",
                Action = "Create"
            },
            "\011"
        }
    })
end

local function startDungeon()
    fireDungeonEvent({
        {
            {
                Dungeon = fixedDungeonID,
                Event = "DungeonAction",
                Action = "Start"
            },
            "\011"
        }
    })
end

-- Rune Validation
local function isCityRune(displayName)
    return string.find(displayName:lower(), "city")
end

local function validateSelectedRunes()
    local inventory = player:FindFirstChild("leaderstats"):FindFirstChild("Inventory"):FindFirstChild("Items")
    if not inventory then
        notify("Error", "Inventory not found.", 5)
        leaveDungeon()
        return false, nil
    end

    local usedCityRune = false
    local validRunes = {}

    for slot = 1, 7 do
        local displayName = selectedRunes[slot]
        if not displayName or displayName == "None" then
            continue
        end

        local runeID = runeMap[displayName]
        if not runeID then continue end

        local hasRune = inventory:FindFirstChild(runeID)
        if not hasRune then
            notify("Invalid Rune", "You don't own: " .. displayName .. " (Slot " .. slot .. ")", 5)
            leaveDungeon()
            return false, nil
        end

        if isCityRune(displayName) then
            if usedCityRune then
                notify("Invalid Rune Selection", "You can only use one City rune. Please remove one.", 5)
                leaveDungeon()
                return false, nil
            end
            usedCityRune = true
        end

        validRunes[slot] = runeID
    end

    return true, validRunes
end

-- Dungeon State Check
local function isInDungeonGame()
    local success, result = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId).Name end)
    return success and string.find(result, "Dungeon") ~= nil
end

-- Run Dungeon Bypass Logic
function runDungeonBypass()
    local success, err = pcall(function()
        if isInDungeonGame() then
            notify("Dungeon Running", "You are already in a dungeon!", 5)
            return
        end

        buyDungeonTicket()
        task.wait(delay)
        createDungeon()
        task.wait(delay)

        if addRunes then
            local isValid, validRunes = validateSelectedRunes()
            if not isValid then return end

            for slot, runeID in pairs(validRunes) do
                fireDungeonEvent({
                    {
                        {
                            Dungeon = fixedDungeonID,
                            Action = "AddItems",
                            Slot = slot,
                            Event = "DungeonAction",
                            Item = runeID
                        },
                        "\011"
                    }
                })
                task.wait(0.2)
            end
        end
        task.wait(delay)
        startDungeon()
        notify("Dungeon Started", "Joining on dungeon...", 5)
    end)

    if not success then
        notify("Error", "Something went wrong: " .. tostring(err), 6)
    end
end

-- Get Dungeon Info Label
local function getDungeonInfoLabel()
    local playerGui = player:FindFirstChild("PlayerGui")
    local hud = playerGui and playerGui:FindFirstChild("Hud")
    local upContainer = hud and hud:FindFirstChild("UpContanier")
    local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")
    local text = dungeonInfo and dungeonInfo:FindFirstChild("TextLabel")
    return text
end

-- Dungeon Text Management
local function DungeonText()
    if skipDoubleDungeon then return "Dungeon Ends in 20s" else return "Dungeon Ends in 12s" end
end

-- Auto Dungeon Action
local function autoDungeonAction()
    task.spawn(function()
        while dungeonAction ~= "None" do
            pcall(function()
                local dungeonInfo = getDungeonInfoLabel()
                if dungeonInfo and dungeonInfo.Text == DungeonText() then
                    if dungeonAction == "Leave" then
                        VirtualInputManager:SendKeyEvent(true, "BackSlash", false, game)
                        VirtualInputManager:SendKeyEvent(false, "BackSlash", false, game)
                        task.wait(0.5)
                        VirtualInputManager:SendKeyEvent(true, "Right", false, game)
                        VirtualInputManager:SendKeyEvent(false, "Right", false, game)
                        task.wait(0.5)
                        for _ = 1, 3 do
                            VirtualInputManager:SendKeyEvent(true, "Return", false, game)
                            VirtualInputManager:SendKeyEvent(false, "Return", false, game)
                            task.wait(0.2)
                        end
                    elseif dungeonAction == "Rejoin" then
                        buyDungeonTicket()
                        task.wait(delay)
                        createDungeon()
                        task.wait(delay)

                        if addRunes then
                            local isValid, validRunes = validateSelectedRunes()
                            if not isValid then return end

                            for slot, runeID in pairs(validRunes) do
                                fireDungeonEvent({
                                    {
                                        {
                                            Dungeon = fixedDungeonID,
                                            Action = "AddItems",
                                            Slot = slot,
                                            Event = "DungeonAction",
                                            Item = runeID
                                        },
                                        "\011"
                                    }
                                })
                                task.wait(0.2)
                            end
                        end
                        task.wait(delay)
                        startDungeon()
                        task.wait(1)
                        dungeonAction = "None"
                        return
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end

-- Player Movement and Combat
local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
    end
end

local function GetAllLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
    if not serverFolder then return end
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") then
            local name = npc.Name
            if not LivingNPCs[name] then
                LivingNPCs[name] = npc
            end
        end
    end
end

local function GetNearbyPosition(npc)
    local hitboxRadius = 3
    local npcPos = npc.CFrame.Position
    local direction = (humanoidRootPart.Position - npcPos).Unit
    local offsetDistance = hitboxRadius + math.random(1, 3)
    return npcPos + (direction * offsetDistance)
end

local function MoveToCFrame(npc)
    local targetPosition = GetNearbyPosition(npc)
    targetCFramePosition = targetPosition
    local targetCFrame = CFrame.new(targetPosition)

    if useTween then
        if tween then tween:Cancel() end
        local distance = (humanoidRootPart.Position - targetPosition).Magnitude
        local duration = math.clamp(distance / tweenSpeed, 0.05, 1)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    else
        local distance = (humanoidRootPart.Position - targetPosition).Magnitude
        if distance <= 20 then
            player.Character:PivotTo(targetCFrame)
        else
            if tween then tween:Cancel() end
            local duration = math.clamp(distance / 1000, 0.05, 0.15)
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
            tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end
    end
end

local function FirePunch(npcName)
    fireDungeonEvent({
        {
            {
                Event = "PunchAttack",
                Enemy = npcName
            },
            "\005"
        }
    })
end

local function FireAriseDestroy(npcName)
    if not autoAriseDestroy then return end
    task.spawn(function()
        for _ = 1, 3 do
            fireDungeonEvent({
                {
                    {
                        Event = ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture",
                        Enemy = npcName
                    },
                    "\005"
                }
            })
            task.wait(0.3)
        end
    end)
end

local function IsNPCDead(npc)
    local success, hp = pcall(function()
        return npc:GetAttribute("HP")
    end)
    return success and hp == 0
end

-- Auto Rejoin and Combat Loops
player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

task.spawn(function()
    while true do
        if isActive then
            GetAllLivingNPCs()
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if isActive then
            if not currentTarget or not currentTarget:IsDescendantOf(workspace) or IsNPCDead(currentTarget) then
                if currentTarget and IsNPCDead(currentTarget) then
                    lastDeadNPC = currentTarget
                end
                currentTarget = nil
                for name, npc in pairs(LivingNPCs) do
                    if npc and not IsNPCDead(npc) then
                        currentTarget = npc
                        FirePunch(name)
                        if useTween then
                            MoveToCFrame(npc)
                        else
                            task.wait(tp_delay)
                            if currentTarget == npc then
                                MoveToCFrame(npc)
                            end
                        end
                        break
                    end
                end
            end
        end
        task.wait()
    end
end)

task.spawn(function()
    while true do
        if isActive then
            if currentTarget then
                FreezePlayer(true)
                FirePunch(currentTarget.Name)
            end
        else
            FreezePlayer(false)
        end
        task.wait()
    end
end)

task.spawn(function()
    while ariseDestroyType do
        if lastDeadNPC then
            FireAriseDestroy(lastDeadNPC.Name)
            task.wait(0.3)
        end
    end
end)


Tabs.Info:AddParagraph({
    Title = "Welcome to Jay Hub!",
    Content = "Thank you for using our script! We appreciate your support and hope it helps you have a smoother experience. If you have any questions, feel free to reach out!\nMore featuress to come!"
})

Tabs.Info:AddParagraph({
    Title = "Update Log",
    Content = "New:\n+ Add runes available (you can now choose your own runes in dungeon)\n+ New Tab info\n+ New Teleport button (teleport to Winter Island)\n\nRemove:\n- No more Join Jay Option\n- Removed Ultimate Rune feature\n\nFixed:\n+ Not teleporting to selected Island\n+ Not starting dungeon\n+ Not punching\n+ Not working Arise/Destroy option"
})

local Config = Tabs.Main:AddSection("Config")

Config:AddDropdown("AriseDestroyType", {
    Title = "Select Action",
    Values = { "Destroy", "Arise" },
    Default = "Destroy",
    Multi = false,
    Callback = function(value)
        ariseDestroyType = value
    end
})

Config:AddToggle("AutoAriseDestroyToggle", {
    Title = "Auto Arise/Destroy",
    Description = "Choose action below if Arise or Destroy",
    Default = false,
    Callback = function(state)
        autoAriseDestroy = state
    end
})

Tabs.Dungeon:AddToggle("AutoFarmToggle", {
    Title = "Dungeon Farm",
    Default = false,
    Callback = function(state)
        isActive = state
    end
})

Tabs.Dungeon:AddDropdown("MovementMethod", {
    Title = "Movement Method",
    Description = "Choose how to move to targets",
    Values = { "Slow (Tween)", "Fast (Teleport)" },
    Default = "Slow (Tween)",
    Multi = false,
    Callback = function(value)
        useTween = value == "Slow (Tween)"
    end
})

Tabs.Dungeon:AddSlider("TweenSpeedSlider", {
    Title = "Tween Speed",
    Description = "Used only with 'Slow (Tween)'",
    Default = 100,
    Min = 50,
    Max = 1000,
    Rounding = 0,
    Callback = function(value)
        tweenSpeed = value
    end
})

Tabs.Dungeon:AddSlider("TpDelaySlider", {
    Title = "Teleport Delay",
    Description = "Used only with 'Fast (Teleport)'",
    Default = 0.5,
    Min = 0,
    Max = 3,
    Rounding = 1,
    Callback = function(value)
        tp_delay = value
    end
})

Tabs.Dungeon:AddSlider("DelaySlider", {
    Title = "Delay (Seconds)",
    Default = delay,
    Min = 0.1,
    Max = 3,
    Rounding = 1,
    Increment = 0.1,
    Callback = function(val)
        delay = val
    end
})

local BypassSection = Tabs.Dungeon:AddSection("Bypass Section")

BypassSection:AddToggle("AutoBypassToggle", {
    Title = "Auto Dungeon Bypass",
    Default = autoBypass,
    Callback = function(val)
        autoBypass = val
        if val then runDungeonBypass() end
    end
})

BypassSection:AddToggle("SkipDoubleDungeon", {
    Title = "Skip Double Dungeon",
    Default = skipDoubleDungeon,
    Callback = function(val)
        skipDoubleDungeon = val
    end
})

BypassSection:AddDropdown("DungeonActionDropdown", {
    Title = "Action After Dungeon",
    Values = { "None", "Leave", "Rejoin" },
    Default = dungeonAction,
    Callback = function(val)
        dungeonAction = val
        if val ~= "None" then autoDungeonAction() end
    end
})

BypassSection:AddToggle("AddRunesToggle", {
    Title = "Add runes",
    Default = false,
    Callback = function(state)
        addRunes = state
    end
})

BypassSection:AddParagraph({
    Title = "How to Use Add Runes",
    Content = "Open the Rune tab and choose the rune you want to use. Each slot can hold a different rune, so make sure you pick the right one for each slot!"
})

local RuneSection = Tabs.Rune:AddSection("Rune Config")

for slot = 1, 7 do
    RuneSection:AddDropdown("Slot" .. slot .. "Dropdown", {
        Title = "Slot " .. slot,
        Values = displayNames,
        Multi = false,
        Default = displayNames[1],
        Callback = function(selection)
          selectedRunes[slot] = selection ~= "None" and selection or nil
        end
    })
end

local Dropdown = Tabs.Teleport:AddDropdown("Dropdown", {
    Title = "Select Island",
    Description = "Choose an island to teleport to.",
    Values = {
        "Solo City", 
        "Grass City", 
        "Brum City", 
        "Faceheal City", 
        "Lucky City", 
        "Nipon City", 
        "Jojo City",
        "Dragon City",
        "Punch City",
        "Dandadan City"
    },
    Multi = false,
    Default = 1
})

Tabs.Teleport:AddButton({
  Title = "Teleport",
  Description = "Teleport to the selected island.",
  Callback = function()
    local selectedIsland = Dropdown.Value
    local spawnLocation = spawnMap[selectedIsland]

    if spawnLocation then
        fireDungeonEvent({
            {
                {
                    Event = "ChangeSpawn",
                    Spawn = spawnLocation
                },
                "\011"
            }
        })
    end

    local player = game:GetService("Players").LocalPlayer
    if player.Character then
        player.Character:BreakJoints()
    end
end
})

local IslandSection = Tabs.Teleport:AddSection("Event Island Teleport")


IslandSection:AddButton({
    Title = "Teleport to Winter Island",
    Callback = function()
        fireDungeonEvent({
            {
                {
                    Event = "ChangeSpawn",
                    Spawn = "JojoWorld"
                },
                "\011"
            }
        })

        local player = game:GetService("Players").LocalPlayer
        if player.Character then
            player.Character:BreakJoints()
        end

        task.delay(5, function()
            local TweenService = game:GetService("TweenService")

            local targetCFrame = CFrame.new(
                4759.65625, 29.7264366, -2014.11768,
                0.999825656, -2.80905277e-09, -0.0186712835,
                3.26758465e-09, 1, 2.45276315e-08,
                0.0186712835, -2.45843665e-08, 0.999825656
            )

            repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local hrp = player.Character.HumanoidRootPart

            local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear)
            local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
            tween:Play()
        end)
    end
})


SaveManager:SetLibrary(jay)
InterfaceManager:SetLibrary(jay)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("JayHub")
SaveManager:SetFolder("JayHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
