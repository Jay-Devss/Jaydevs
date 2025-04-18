getgenv().isActive = true
getgenv().useTween = true
getgenv().tweenSpeed = 500 -- studs per second
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy" -- or "Capture"

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local npcQueue = {}
local currentTarget = nil
local tween = nil

local function EnableAutoClick()
    local autoClick = player:GetAttribute("AutoClick")
    if autoClick == nil or autoClick == false then
        player:SetAttribute("AutoClick", true)
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

local function IsValidSize(npc)
    local humanoidRootPart = npc:FindFirstChild("HumanoidRootPart")
    return humanoidRootPart and humanoidRootPart.Size == Vector3.new(4, 4, 2)
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
        if IsValidSize(enemy) and IsNPCLiving(enemy) then
            table.insert(npcs, enemy)
        end
    end
    return npcs
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
        task.wait(0.3)
    end
end

local function ResetCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

player.CharacterAdded:Connect(ResetCharacter)

task.spawn(function()
    EnableAutoClick()
    local lastTarget = nil
    while getgenv().isActive do
        if lastTarget and not IsNPCLiving(lastTarget) then
            FireAriseDestroy(lastTarget)
            lastTarget = nil
        end
        if not currentTarget then
            npcQueue = GetAllLivingNPCs()
            for _, npc in ipairs(npcQueue) do
                if IsNPCLiving(npc) then
                    currentTarget = npc
                    MoveToNPC(currentTarget)
                    lastTarget = npc
                    break
                end
            end
        elseif not IsNPCLiving(currentTarget) then
            lastTarget = currentTarget
            currentTarget = nil
        end
        task.wait(0.1)
    end
end)

EnableAutoClick()
