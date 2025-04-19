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
local targetCFramePosition = nil

getgenv().AutoFarm = true
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy"

local function IsNPCDead(npc)
    local success, hp = pcall(function() return npc:GetAttribute("HP") end)
    if success and hp == 0 then return true end
    return npc:GetAttribute("Dead") == true
end

local function GetSortedLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server"):FindFirstChild("8")
    if not serverFolder then return {} end

    local npcList = {}
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") and npc:GetAttribute("Scale") == 2 and not IsNPCDead(npc) then
            table.insert(npcList, npc)
        end
    end

    table.sort(npcList, function(a, b)
        return (a.Position - humanoidRootPart.Position).Magnitude < (b.Position - humanoidRootPart.Position).Magnitude
    end)

    return npcList
end

local function EnableAutoClick()
    if not player:GetAttribute("AutoClick") then
        player:SetAttribute("AutoClick", true)
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

local function GetNearbyPosition(npc)
    local offset = Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
    return npc.Position + offset
end

local function MovePlatformTo(npc)
    local pos = GetNearbyPosition(npc)
    platform.CFrame = CFrame.new(pos + Vector3.new(0, -3.5, 0))
    targetCFramePosition = pos
end

task.spawn(function()
    while getgenv().AutoFarm do
        task.wait(0.1)
        if #LivingNPCs == 0 and not currentTarget then
            LivingNPCs = GetSortedLivingNPCs()
        end
    end
end)

task.spawn(function()
    EnableAutoClick()
    while getgenv().AutoFarm do
        if currentTarget and IsNPCDead(currentTarget) then
            FireAriseDestroy(currentTarget)
            currentTarget = nil
        end

        if not currentTarget and #LivingNPCs > 0 then
            currentTarget = table.remove(LivingNPCs, 1)
            if currentTarget then
                MovePlatformTo(currentTarget)
            end
        end

        task.wait()
    end
end)

task.spawn(function()
    while getgenv().AutoFarm do
        pcall(function()
            if currentTarget and targetCFramePosition then
                local distance = (humanoidRootPart.Position - targetCFramePosition).Magnitude
                if distance > 5 then
                    MovePlatformTo(currentTarget)
                end
            end
        end)
        task.wait(0.1)
    end
end)

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
