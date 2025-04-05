local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local npcQueue = {}
local currentTarget = nil
local tween = nil
local frozen = false
local nextUpdateTime = 0

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

local function GetAllLivingNPCs()
    local mainFolder = workspace:FindFirstChild("__Main")
    if not mainFolder then return {} end
    local enemiesFolder = mainFolder:FindFirstChild("__Enemies")
    if not enemiesFolder then return {} end
    local clientFolder = enemiesFolder:FindFirstChild("Client")
    if not clientFolder then return {} end

    local npcs = {}
    for _, enemy in pairs(clientFolder:GetChildren()) do
        if enemy:FindFirstChild("HumanoidRootPart") and IsNPCLiving(enemy) then
            local distance = (enemy.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            if distance <= getgenv().maxDetectionDistance then
                table.insert(npcs, {enemy = enemy, distance = distance})
            end
        end
    end

    table.sort(npcs, function(a, b) return a.distance < b.distance end)

    local sorted = {}
    for _, data in ipairs(npcs) do
        table.insert(sorted, data.enemy)
    end
    return sorted
end

local function MoveToNPC(npc)
    local targetPosition = npc.HumanoidRootPart.Position
    if getgenv().useTween then
        if tween then tween:Cancel() end
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Linear)
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
    task.wait(0.1)
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
        local now = tick()

        -- Update NPC queue every second
        if now >= nextUpdateTime then
            npcQueue = GetAllLivingNPCs()
            nextUpdateTime = now + 1
        end

        -- If no current target or target is dead, find a new NPC
        if not currentTarget or not IsNPCLiving(currentTarget) then
            if currentTarget then
                FireAriseDestroy(currentTarget)
                task.wait(0.1)
                FreezePlayer(false)
            end
            currentTarget = nil
            for _, npc in ipairs(npcQueue) do
                if IsNPCLiving(npc) then
                    currentTarget = npc
                    MoveToNPC(currentTarget)
                    break
                end
            end
        else
            -- Attack current target continuously without delay
            FreezePlayer(true)
            FirePunch(currentTarget)

            -- If NPC dies, remove it
            if not IsNPCLiving(currentTarget) then
                task.wait(0.1)
                currentTarget = nil
            end
        end

        task.wait() -- Runs as fast as possible
    end
    FreezePlayer(false)
end)
