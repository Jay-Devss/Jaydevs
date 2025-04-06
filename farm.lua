local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local LivingNPCs = {}
local currentTarget = nil
local tween = nil
local punching = false

local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
    end
end

local function GetAllLivingNPCs()
    local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
    if not serverFolder then return {} end

    for _, npc in pairs(serverFolder:GetChildren()) do
        if npc:IsA("BasePart") then
            local name = npc.Name
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
end

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
        task.wait(0.1)
    end
end)

task.spawn(function()
    while getgenv().isActive do
        if not currentTarget or not currentTarget.npc or not currentTarget.npc:IsDescendantOf(workspace) or IsNPCDead(currentTarget.npc) then
            if currentTarget and IsNPCDead(currentTarget.npc) then
                FireAriseDestroy(currentTarget.name)
            end
            currentTarget = nil
            for name, data in pairs(LivingNPCs) do
                if data.npc and not IsNPCDead(data.npc) then
                    currentTarget = data
                    MoveToCFrame(data.cframe)
                    break
                end
            end
        elseif currentTarget and currentTarget.npc then
            FreezePlayer(true)
            FirePunch(currentTarget.name)
        end
        task.wait(0)
    end
    FreezePlayer(false)
end)

task.spawn(function()
    while getgenv().isActive do
        pcall(function()
            local playerGui = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
            local hud = playerGui and playerGui:FindFirstChild("Hud")
            local upContainer = hud and hud:FindFirstChild("UpContanier")
            local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")

            if dungeonInfo and dungeonInfo:IsA("TextLabel") then
                if dungeonInfo.Text == "Dungeon Ends in 10s" then
                    local vim = game:GetService("VirtualInputManager")

                    -- Toggle UI navigation (BackSlash)
                    vim:SendKeyEvent(true, "BackSlash", false, game)
                    vim:SendKeyEvent(false, "BackSlash", false, game)
                    task.wait(0.1)

                    -- Press right arrow key once
                    vim:SendKeyEvent(true, "Right", false, game)
                    vim:SendKeyEvent(false, "Right", false, game)
                    task.wait(0.1)

                    -- Press Enter (Return)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                    vim:SendKeyEvent(true, "Return", false, game)
                    vim:SendKeyEvent(false, "Return", false, game)
                end
            end
        end)
        task.wait(0.5)
    end
end)
