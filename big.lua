local player = game.Players.LocalPlayer
local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local LivingNPCs = {}
local currentTarget = nil
local npcQueue = {}
getgenv().AutoFarm = true
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy"

local function EnableAutoClick()
    local autoClick = player:GetAttribute("AutoClick")
    if autoClick == nil or autoClick == false then
        player:SetAttribute("AutoClick", true)
    end
end

local function GetAllLivingNPCs()
    LivingNPCs = {}
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server"):FindFirstChild("8")
    if not serverFolder then return {} end
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") and npc:GetAttribute("Scale") == 2 then
            LivingNPCs[npc.Name] = npc
        end
    end
    return LivingNPCs
end

local function IsNPCLiving(npc)
    return npc and npc:GetAttribute("HP") > 0 and npc:GetAttribute("Dead") == false
end

local function IsNPCDead(npc)
    local success, hp = pcall(function() return npc:GetAttribute("HP") end)
    if success and hp == 0 then
        return true
    end
    local deadAttr = npc and npc:GetAttribute("Dead")
    return deadAttr == true
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

local function GetNearbyPosition(npc)
    local hitboxRadius = 3
    local npcPos = npc.CFrame.Position
    local direction = (humanoidRootPart.Position - npcPos).Unit
    local offsetDistance = hitboxRadius + math.random(1,3)
    return npcPos + (direction * offsetDistance)
end

local function MoveToNPC(npc)
    local targetPosition = GetNearbyPosition(npc)
    targetCFramePosition = targetPosition
    local targetCFrame = CFrame.new(targetPosition)

    local distance = (humanoidRootPart.Position - targetPosition).Magnitude
    if distance <= 30 then
        player.Character:PivotTo(targetCFrame)
    else
        local step = (targetPosition - humanoidRootPart.Position).Unit * 15
        while (humanoidRootPart.Position - targetPosition).Magnitude > 15 do
            player.Character:PivotTo(CFrame.new(humanoidRootPart.Position + step))
            task.wait(0.05)
        end
        player.Character:PivotTo(targetCFrame)
    end
end

task.spawn(function()
    EnableAutoClick()
    local lastTarget = nil
    while getgenv().AutoFarm do
        if lastTarget and IsNPCDead(lastTarget) then
            FireAriseDestroy(lastTarget)
            lastTarget = nil
        end

        if not currentTarget then
            npcQueue = GetAllLivingNPCs()
            for _, npc in pairs(npcQueue) do
                if IsNPCLiving(npc) then
                    currentTarget = npc
                    MoveToNPC(currentTarget)
                    lastTarget = npc
                    break
                end
            end
        elseif IsNPCDead(currentTarget) then
            lastTarget = currentTarget
            currentTarget = nil
        end

        task.wait(0.1)
    end
end)
