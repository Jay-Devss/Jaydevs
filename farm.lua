local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local LivingNPCs = {} -- Format: [npc.Name] = {npc = Instance, cframe = CFrame}
local currentTarget = nil
local tween = nil
local punching = false
local frozen = false

-- Freeze or unfreeze user movement
local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
        frozen = state
    end
end

-- Update and return list of alive NPCs
local function GetAllLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
    if not serverFolder then return {} end

    local activeNames = {}
    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") then
            local name = npc.Name
            activeNames[name] = true
            if not LivingNPCs[name] then
                LivingNPCs[name] = {
                    name = name,
                    npc = npc,
                    cframe = npc.CFrame
                }
            else
                LivingNPCs[name].npc = npc
                LivingNPCs[name].cframe = npc.CFrame
            end
        end
    end

    -- Remove dead NPCs (not found anymore)
    for name in pairs(LivingNPCs) do
        if not activeNames[name] then
            LivingNPCs[name] = nil
        end
    end

    return LivingNPCs
end

-- Tween or teleport to CFrame
local function MoveToCFrame(cframe)
    if getgenv().useTween then
        if tween then tween:Cancel() end
        local distance = (humanoidRootPart.Position - cframe.Position).Magnitude
        local duration = math.clamp(distance / getgenv().tweenSpeed, 0.05, 1)
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = cframe})
        tween:Play()
    else
        humanoidRootPart.CFrame = cframe
    end
end

-- Call PunchAttack event
local function FirePunch(npcName)
    if not punching then
        punching = true
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = "PunchAttack",
                Enemy = npcName
            },
            "\4"
        })
        punching = false
    end
end

-- AriseDestroy after NPC disappears
local function FireAriseDestroy(npcName)
    if not getgenv().autoAriseDestroy then return end
    task.wait(0.1)
    for _ = 1, 3 do
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture",
                Enemy = npcName
            },
            "\4"
        })
        task.wait(0.05)
    end
end

-- Handle reset
local function ResetCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end

player.CharacterAdded:Connect(ResetCharacter)

-- Background loop to always update LivingNPCs
task.spawn(function()
    while getgenv().isActive do
        GetAllLivingNPCs()
        task.wait(0) -- Fastest possible update
    end
end)

-- Main farming loop
task.spawn(function()
    while getgenv().isActive do
        -- Check if target still exists
        if currentTarget then
            if not LivingNPCs[currentTarget.name] or not currentTarget.npc:IsDescendantOf(workspace) then
                FireAriseDestroy(currentTarget.name)
                currentTarget = nil
                FreezePlayer(false)
            end
        end

        -- Pick next target if none
        if not currentTarget then
            for name, data in pairs(LivingNPCs) do
                currentTarget = data
                MoveToCFrame(data.cframe)
                break
            end
        else
            FreezePlayer(true)
            FirePunch(currentTarget.name)
        end

        task.wait(0.05)
    end
    FreezePlayer(false)
end)
