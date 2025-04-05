
--// SERVICES
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

--// STATE
local currentTarget = nil
local tween = nil

--// HELPERS
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
    local clientFolder = workspace:FindFirstChild("__Main")?
        :FindFirstChild("__Enemies")?
        :FindFirstChild("Client")
    if not clientFolder then return {} end

    local npcs = {}
    for _, npc in pairs(clientFolder:GetChildren()) do
        if npc:FindFirstChild("HumanoidRootPart") and IsNPCLiving(npc) then
            local dist = (npc.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            if dist <= getgenv().maxDetectionDistance then
                table.insert(npcs, {npc = npc, dist = dist})
            end
        end
    end

    table.sort(npcs, function(a, b) return a.dist < b.dist end)

    local sorted = {}
    for _, entry in ipairs(npcs) do
        table.insert(sorted, entry.npc)
    end
    return sorted
end

local function GetNearbyPosition(npc)
    local hitboxRadius = 5
    local npcHumanoid = npc:FindFirstChildOfClass("Humanoid")
    if npcHumanoid then
        hitboxRadius = npcHumanoid.HipHeight + 3
    end
    local npcPos = npc.HumanoidRootPart.Position
    local dir = (humanoidRootPart.Position - npcPos).Unit
    local offset = hitboxRadius + math.random(1, 3)
    return npcPos + (dir * offset)
end

local function MoveToNPC(npc)
    local targetPos = GetNearbyPosition(npc)
    if getgenv().useTween then
        if tween then tween:Cancel() end
        local duration = (humanoidRootPart.Position - targetPos).Magnitude / getgenv().tweenSpeed
        tween = TweenService:Create(humanoidRootPart, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
        tween:Play()
    else
        humanoidRootPart.CFrame = CFrame.new(targetPos)
    end
end

local function FreezePlayer(state)
    if humanoid then
        humanoid.WalkSpeed = state and 0 or 16
        humanoid.JumpPower = state and 0 or 50
    end
end

local function FirePunch(npc)
    ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer({
        {
            Event = "PunchAttack",
            Enemy = npc.Name
        },
        "\4"
    })
end

local function FireAriseDestroy(npc)
    local eventName = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture"
    for _ = 1, 3 do
        ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer({
            {
                Event = eventName,
                Enemy = npc.Name
            },
            "\4"
        })
        task.wait(0.15)
    end
end

--// CHARACTER RESET
player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
end)

--// MAIN LOOP
task.spawn(function()
    while getgenv().isActive do
        if not currentTarget or not IsNPCLiving(currentTarget) then
            if currentTarget and getgenv().autoAriseDestroy then
                FireAriseDestroy(currentTarget)
            end

            local npcs = GetAllLivingNPCs()
            currentTarget = npcs[1]
            if currentTarget then
                MoveToNPC(currentTarget)
            end
        else
            FreezePlayer(true)
            FirePunch(currentTarget)
        end
        task.wait()
    end
    FreezePlayer(false)
end)
