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
local currentTarget = nil
local tween = nil
local lastDeadNPC = nil
local targetCFramePosition = nil
local autoBypass = false 
local autoCastle = false 
local autoJoinJay = false 
local ultimateDungeon = false 
local delay = 0.5
local tp_delay = 0.1
local targetUser = "Jayalwayspaldooo7" 
local fixedDungeonID = 7948501548
local skipDoubleDungeon = false 
local dungeonAction = "None"
local isActive = false
local useTween = false
local tweenSpeed = 100
local autoAriseDestroy = false
local ariseDestroyType = "Arise"

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
    Main = Window:AddTab({ Title = "Main", Icon = "align-justify" }),
    Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "heart" }),
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

local function fireDungeonEvent(argsTable) dataRemoteEvent:FireServer(unpack(argsTable)) end

local function notify(title, content, duration) jay:Notify({ Title = title, Content = content, Duration = duration or 4 }) end

local function isInDungeonGame() local success, result = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId).Name end) return success and string.find(result, "Dungeon") ~= nil end

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

local function addUltimateRune() fireDungeonEvent({ { { ["Dungeon"] = fixedDungeonID, ["Action"] = "AddItems", ["Slot"] = 1, ["Event"] = "DungeonAction", ["Item"] = "DgURankUpRune" }, "\n" } }) end

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
local function tryJoinCastle() local minute = os.date("*t").min if minute >= 45 and minute <= 59 and not isInDungeonGame() then fireDungeonEvent({ { { ["Event"] = "JoinCastle" }, "\n" } }) notify("Castle Join", "You have joined the castle event!", 5) return true else notify("Castle Join Skipped", "Not within Castle join time window (XX:45 - XX:59).", 5) return false end end

function runDungeonBypass() local success, err = pcall(function() if isInDungeonGame() then notify("Dungeon Running", "You are already in a dungeon!", 5) return end if autoCastle and tryJoinCastle() then return end if autoJoinJay and player.Name ~= targetUser then for _, p in pairs(Players:GetPlayers()) do if p.Name == targetUser then while Players:FindFirstChild(targetUser) do buyDungeonTicket() task.wait(delay) fireDungeonEvent({ { { ["Dungeon"] = fixedDungeonID, ["Event"] = "DungeonAction", ["Action"] = "Join" }, "\n" } }) task.wait(1.5) end return end end end buyDungeonTicket() task.wait(delay) createDungeon() task.wait(delay) if ultimateDungeon then addUltimateRune() task.wait(delay) end startDungeon() notify("Dungeon Started", "Dungeon started with ID: " .. fixedDungeonID .. (ultimateDungeon and " + Rune!" or "!"), 5) end) if not success then notify("Error", "Something went wrong: " .. tostring(err), 6) end end

local function getDungeonInfoLabel() 
  local playerGui = player:FindFirstChild("PlayerGui") 
  local hud = playerGui and playerGui:FindFirstChild("Hud") 
  local upContainer = hud and hud:FindFirstChild("UpContanier") 
  local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo") 
  local text = dungeonInfo and dungeonInfo:FindFirstChild("TextLabel")
  return text 
end

local function DungeonText() if skipDoubleDungeon then return "Dungeon Ends in 20s" else return "Dungeon Ends in 12s" end end

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
                        if autoJoinJay and player.Name ~= targetUser then
                            local targetFound = Players:FindFirstChild(targetUser)
                            if targetFound then
                                while Players:FindFirstChild(targetUser) do
                                    task.wait(1)
                                end
                            end
                        end
                        buyDungeonTicket()
                        task.wait(delay)
                        createDungeon()
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
            game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
                { Event = ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture", Enemy = npcName },
                "\4"
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
    while true do
        if lastDeadNPC then
            FireAriseDestroy(lastDeadNPC.Name)
            lastDeadNPC = nil
        end
        task.wait()
    end
end)

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

task.spawn(function()
    while true do
        if isActive and character and character:FindFirstChild("Humanoid") then
            if character.Humanoid.Sit then
                character.Humanoid.Sit = false
            end
        end
        task.wait(0.1)
    end
end)

task.spawn(function()
    while true do
        if isActive and humanoidRootPart then
            humanoidRootPart.Anchored = false
            humanoidRootPart.Velocity = Vector3.zero
        end
        task.wait(0.5)
    end
end)

task.spawn(function()
    while true do
        if isActive and currentTarget and targetCFramePosition then
            local distance = (humanoidRootPart.Position - targetCFramePosition).Magnitude
            if distance > 5 then
                MoveToCFrame(currentTarget)
            end
        end
        task.wait(1)
    end
end)


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

BypassSection:AddToggle("AutoCastle", {
    Title = "Auto Castle Join",
    Default = autoCastle,
    Callback = function(val)
        autoCastle = val
    end
})

BypassSection:AddToggle("AutoJoinJay", {
    Title = "Auto Join Jay",
    Default = player.Name ~= targetUser and autoJoinJay or false,
    Callback = function(val)
        if player.Name == targetUser then
            autoJoinJay = false
        else
            autoJoinJay = val
        end
    end
})

BypassSection:AddToggle("UltimateRune", {
    Title = "Add Ultimate Rune",
    Default = ultimateDungeon,
    Callback = function(val)
        ultimateDungeon = val
    end
})

BypassSection:AddSlider("DelaySlider", {
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

local IslandSection = Tabs.Teleport:AddSection("Island Teleport")


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

        task.delay(3, function()
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
