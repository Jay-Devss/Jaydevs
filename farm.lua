local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local LivingNPCs = {}
local currentTarget = nil
local tween = nil
local punching = false
getgenv().isAutoLeftActive = true

local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
    end
end

local function GetAllLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
    if not serverFolder then return end

    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") then
            local name = npc.Name
            if not LivingNPCs[name] then
                LivingNPCs[name] = npc
            end
        end
    end
end

local function MoveToCFrame(npc)
    local cframe = npc.CFrame
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

function FireAriseDestroy(npcName)
    if not getgenv().autoAriseDestroy then return end
    for _ = 1, 3 do
        game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
            {
                Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture",
                Enemy = npcName
            },
            "\4"
        })
        task.wait()
    end
end

local function IsNPCDead(npc)
    local success, hp = pcall(function()
        return npc:GetAttribute("HP")
    end)
    return success and hp == 0
end

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

task.spawn(function()
    while getgenv().isActive do
        GetAllLivingNPCs()
        task.wait(0.5)
    end
end)

task.spawn(function()
    while getgenv().isActive do
        if not currentTarget or not currentTarget:IsDescendantOf(workspace) or IsNPCDead(currentTarget) then
            if currentTarget and IsNPCDead(currentTarget) then
                FireAriseDestroy(currentTarget.Name)
            end
            currentTarget = nil
            for name, npc in pairs(LivingNPCs) do
                if npc and not IsNPCDead(npc) then
                    currentTarget = npc
                    MoveToCFrame(npc)
                    break
                end
            end
        elseif currentTarget then
            FreezePlayer(true)
            FirePunch(currentTarget.Name)
        end
        task.wait(0)
    end
    FreezePlayer(false)
end)

function AutoLeft()
    task.spawn(function()
        while getgenv().isAutoLeftActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local playerGui = player:FindFirstChild("PlayerGui")
                local hud = playerGui and playerGui:FindFirstChild("Hud")
                local upContainer = hud and hud:FindFirstChild("UpContanier")
                local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

                if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 10s" then
                    local vim = game:GetService("VirtualInputManager")

                    vim:SendKeyEvent(true, "BackSlash", false, game)
                    vim:SendKeyEvent(false, "BackSlash", false, game)
                    task.wait(0.1)
                    vim:SendKeyEvent(true, "Right", false, game)
                    vim:SendKeyEvent(false, "Right", false, game)
                    task.wait(0.5)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    task.wait(0.2)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    task.wait(0.2)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                end
            end)
            task.wait(0.5)
        end
    end)
end

AutoLeft()
