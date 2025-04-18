
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Character = player.Character or player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local LivingNPCs = {}
local currentTarget = nil
local npcQueue = {}

getgenv().AutoFarm = true
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy"

local platform = Instance.new("Part")
platform.Size = Vector3.new(5, 1, 5)
platform.Transparency = 1
platform.Anchored = false
platform.CanCollide = true
platform.Name = "_GlidePlatform"
platform.Parent = workspace

local alignPos = Instance.new("AlignPosition", platform)
alignPos.RigidityEnabled = true
alignPos.MaxForce = math.huge
alignPos.Responsiveness = 200

local alignOri = Instance.new("AlignOrientation", platform)
alignOri.RigidityEnabled = true
alignOri.MaxTorque = math.huge
alignOri.Responsiveness = 200

local att0 = Instance.new("Attachment", platform)
local att1 = Instance.new("Attachment", HumanoidRootPart)
alignPos.Attachment0 = att0
alignPos.Attachment1 = att1
alignOri.Attachment0 = att0
alignOri.Attachment1 = att1

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
        ReplicatedStorage.BridgeNet2.dataRemoteEvent:FireServer({
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
    local npcPos = npc.Position
    local direction = (HumanoidRootPart.Position - npcPos).Unit
    local offsetDistance = hitboxRadius + math.random(1,3)
    return npcPos + (direction * offsetDistance)
end

local function MoveToNPC(npc)
    local pos = GetNearbyPosition(npc)
    att0.WorldPosition = pos - Vector3.new(0, 3, 0)
    att0.WorldOrientation = Vector3.new(0, 0, 0)
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
