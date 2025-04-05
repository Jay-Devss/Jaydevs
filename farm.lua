local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local npcQueue = {}
local currentTarget = nil
local tween = nil
local punching = false
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
    local serverFolder = enemiesFolder:FindFirstChild("Server")
    if not serverFolder then return {} end

    local npcs = {}
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("Part") and npc:GetAttribute("CFrame") and IsNPCLiving(npc) then
            local npcCFrame = npc:GetAttribute("CFrame")
            local distance = (CFrame.new(npcCFrame).Position - humanoidRootPart.Position).Magnitude
            if distance <= getgenv().maxDetectionDistance then
                table.insert(npcs, {enemy = npc, distance = distance})
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

local function GetNearbyPosition(npc)
    local hitboxRadius = 3
    local npcHumanoid = npc:FindFirstChildOfClass("Humanoid")
    if npcHumanoid then
        hitboxRadius = npcHumanoid.HipHeight + 3
    end
    local npcCFrame = npc:GetAttribute("CFrame")
    local npcPos = CFrame.new(npcCFrame).Position
    local dir = (humanoidRootPart.Position - npcPos).Unit
    local offset = hitboxRadius + math.random(1, 3)
    return npcPos + (dir * offset)
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
    task.wait(0.1)
    for _ = 1, 3 do
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture",
                Enemy = npc.Name
            },
            "\4"
        })
        task.wait(0)
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

        if now >= nextUpdateTime then
            npcQueue = GetAllLivingNPCs()
            nextUpdateTime = now + 0.5
        end

        if not currentTarget or not IsNPCLiving(currentTarget) then
            if currentTarget then
                FireAriseDestroy(currentTarget)
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
            FreezePlayer(true)
            FirePunch(currentTarget)
            if not IsNPCLiving(currentTarget) then
                FreezePlayer(false)
                currentTarget = nil
            end
        end
        task.wait(0.1)
    end
end)
