local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local npcTable = {}
local currentTarget = nil
local tween = nil
local frozen = false

local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
        frozen = state
    end
end

local function IsNPCLiving(npc)
    if not npc then return false end
    local healthBar = npc:FindFirstChild("HealthBar")
    if not healthBar then return false end
    local main = healthBar:FindFirstChild("Main")
    local bar = main and main:FindFirstChild("Bar")
    local amount = bar and bar:FindFirstChild("Amount")
    return amount and amount:IsA("TextLabel") and amount.Text ~= "0 HP"
end

local function UpdateNPCStatus()
    for name, npcData in pairs(npcTable) do
        if npcData.Instance and npcData.Alive then
            if not IsNPCLiving(npcData.Instance) then
                npcTable[name] = nil
            end
        end
    end
end

local function AddNewNPCs()
    local mainFolder = workspace:FindFirstChild("__Main")
    if not mainFolder then return end
    local enemiesFolder = mainFolder:FindFirstChild("__Enemies")
    if not enemiesFolder then return end
    local clientFolder = enemiesFolder:FindFirstChild("Client")
    if not clientFolder then return end

    for _, enemy in pairs(clientFolder:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and not npcTable[enemy.Name] then
            local distance = (enemy.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            if distance <= getgenv().maxDetectionDistance then
                npcTable[enemy.Name] = {
                    Instance = enemy,
                    CFrame = enemy.HumanoidRootPart.CFrame,
                    Alive = IsNPCLiving(enemy)
                }
            end
        end
    end
end

task.spawn(function()
    while getgenv().isActive do
        AddNewNPCs()
        task.wait(0.1)
    end
end)

local function GetNearbyPosition(npc)
    local hitboxRadius = 3
    local humanoid = npc:FindFirstChildOfClass("Humanoid")
    if humanoid then
        hitboxRadius = humanoid.HipHeight + 3
    end
    local npcPos = npc.HumanoidRootPart.Position
    local direction = (humanoidRootPart.Position - npcPos).unit
    local offsetDistance = hitboxRadius + math.random(1, 3)
    return npcPos + (direction * offsetDistance)
end

local function MoveToNPC(npc)
    local targetPosition = GetNearbyPosition(npc)
    if getgenv().useTween then
        if tween then tween:Cancel() end
        local tweenInfo = TweenInfo.new((humanoidRootPart.Position - targetPosition).Magnitude / getgenv().tweenSpeed, Enum.EasingStyle.Linear)
        tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
        tween:Play()
    else
        humanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

local function FirePunch(npc)
    if npc and IsNPCLiving(npc) then
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = "PunchAttack",
                Enemy = npc.Name
            },
            "\4"
        })
    end
end

local function FireAriseDestroy(npc)
    if not getgenv().autoAriseDestroy then return end
    task.wait(0.05)
    for _ = 1, 3 do
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture",
                Enemy = npc.Name
            },
            "\4"
        })
        task.wait(0.05)
    end
end

local function ResetCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

player.CharacterAdded:Connect(ResetCharacter)

task.spawn(function()
    while getgenv().isActive do
        UpdateNPCStatus()

        if not currentTarget or not IsNPCLiving(currentTarget) then
            if currentTarget then
                FireAriseDestroy(currentTarget)
                task.wait(0.1)
                FreezePlayer(false)
            end
            currentTarget = nil

            for _, npcData in pairs(npcTable) do
                if npcData.Alive and npcData.Instance then
                    currentTarget = npcData.Instance
                    MoveToNPC(currentTarget)
                    break
                end
            end
        else
            FreezePlayer(true)
            FirePunch(currentTarget)
        end
        task.wait(0)
    end
    FreezePlayer(false)
end)
