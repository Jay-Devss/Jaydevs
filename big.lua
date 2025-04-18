local player = game.Players.LocalPlayer
repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local character = player.Character
local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

local platform = Instance.new("Part")
platform.Size = Vector3.new(6, 1, 6)
platform.Anchored = false
platform.CanCollide = true
platform.Transparency = 0.5
platform.Name = "GlidePlatform"
platform.Material = Enum.Material.ForceField
platform.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
platform.Parent = workspace

local weld = Instance.new("WeldConstraint")
weld.Part0 = platform
weld.Part1 = humanoidRootPart
weld.Parent = platform

local LivingNPCs = {}
local currentTarget = nil
local npcQueue = {}
getgenv().AutoFarm = true
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy"
local LivingNPCs = {}

local function RefreshLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server"):FindFirstChild("8")
    if not serverFolder then return end

    -- Remove dead NPCs
    for name, npc in pairs(LivingNPCs) do
        if not npc or not npc:IsDescendantOf(workspace) or IsNPCDead(npc) then
            LivingNPCs[name] = nil
        end
    end

    -- Add new living NPCs
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") and npc:GetAttribute("Scale") == 2 and not LivingNPCs[npc.Name] then
            if not IsNPCDead(npc) then
                LivingNPCs[npc.Name] = npc
            end
        end
    end
end

local function EnableAutoClick()
    if not player:GetAttribute("AutoClick") then
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
    if success and hp == 0 then return true end
    return npc:GetAttribute("Dead") == true
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
    local offset = Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
    return npc.Position + offset
end

local function MovePlatformTo(npc)
    local targetPos = GetNearbyPosition(npc)
    platform.CFrame = CFrame.new(targetPos + Vector3.new(0, -3.5, 0))
end

task.spawn(function()
    EnableAutoClick()
    local lastTarget = nil
    while getgenv().AutoFarm do
        RefreshLivingNPCs()

        if lastTarget and IsNPCDead(lastTarget) then
            FireAriseDestroy(lastTarget)
            lastTarget = nil
        end

        if not currentTarget then
            for name, npc in pairs(LivingNPCs) do
                if IsNPCLiving(npc) then
                    currentTarget = npc
                    MovePlatformTo(currentTarget)
                    lastTarget = npc
                    break
                end
            end
        elseif IsNPCDead(currentTarget) then
            LivingNPCs[currentTarget.Name] = nil
            lastTarget = currentTarget
            currentTarget = nil
        end

        task.wait(0.2)
    end
end)
