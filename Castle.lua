local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local LivingNPCs = {}
local currentTarget = nil
local tween = nil
local lastDeadNPC = nil
local targetCFramePosition = nil
local kill = true

local function FreezePlayer(state)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.AutoRotate = not state
        character.Humanoid.WalkSpeed = state and 0 or 16
    end
end

local function EnableAutoClicker()
    if not player:GetAttribute("AutoClick") then
        player:SetAttribute("AutoClick", true)
    elseif player:GetAttribute("AutoClick") == false then
        player:SetAttribute("AutoClick", true)
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

local function GetNearbyPosition(npc)
    local hitboxRadius = 3
    local npcPos = npc.CFrame.Position
    local direction = (humanoidRootPart.Position - npcPos).Unit
    local offsetDistance = hitboxRadius + math.random(1, 3)
    return npcPos + (direction * offsetDistance)
end

local function MoveToCFrame(npc)
    local targetPosition = GetNearbyPosition(npc)
    targetCFramePosition = targetPosition
    local targetCFrame = CFrame.new(targetPosition)

    local distance = (humanoidRootPart.Position - targetPosition).Magnitude
    if distance <= 15 then
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

local function FireAriseDestroy(npcName)
    if not getgenv().autoAriseDestroy then return end
        for _ = 1, 3 do
            game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
                { Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture", Enemy = npcName },
                "\4"
            })
            task.wait(0.3)
    end)
end

local function IsNPCDead(npc)
    local success, hp = pcall(function() return npc:GetAttribute("HP") end)
    return success and hp == 0
end

local function autoLeave()
    local vim = game:GetService("VirtualInputManager")
    local function pressKey(key)
        vim:SendKeyEvent(true, key, false, game)
        vim:SendKeyEvent(false, key, false, game)
    end
    pressKey("BackSlash")
    task.wait(0.5)
    pressKey("Right")
    task.wait(0.5)
    for _ = 1, 3 do
        pressKey("Return")
        task.wait(0.2)
    end
end

local function getCurrentCastleFloor()
    local gui = player:FindFirstChild("PlayerGui")
    local hud = gui and gui:FindFirstChild("Hud")
    local upContainer = hud and hud:FindFirstChild("UpContanier")
    local room = upContainer and upContainer:FindFirstChild("Room")
    if room and room:IsA("TextLabel") then
        if not string.find(room.Text, "Floor") then
            getgenv().isActive = false
            return nil
        end
        return room.Text
    end
    return nil
end

local function KillAllNPCs()
    LivingNPCs = {}
    GetAllLivingNPCs()
    EnableAutoClicker()
    task.spawn(function()
        while kill and getgenv().isActive do
            if not currentTarget or not currentTarget:IsDescendantOf(workspace) or IsNPCDead(currentTarget) then
                if currentTarget and IsNPCDead(currentTarget) then
                    FireAriseDestroy(currentTarget.Name)
                    lastDeadNPC = currentTarget
                end
                currentTarget = nil

                for name, npc in pairs(LivingNPCs) do
                    if npc and not IsNPCDead(npc) then
                        currentTarget = npc
                        MoveToCFrame(npc)
                        break
                    end
                end
            elseif currentTarget and not IsNPCDead(currentTarget) then
                local distance = (humanoidRootPart.Position - currentTarget.Position).Magnitude
                if distance > 7 then
                    MoveToCFrame(currentTarget)
                end
            end
            task.wait()
        end
    end)
end

local function killAllNPCsAndLeave()
    LivingNPCs = {}
    GetAllLivingNPCs()
    EnableAutoClicker()
    task.spawn(function()
        while getgenv().isActive do
            if not currentTarget or not currentTarget:IsDescendantOf(workspace) or IsNPCDead(currentTarget) then
                if currentTarget and IsNPCDead(currentTarget) then
                    FireAriseDestroy(currentTarget.Name)
                    lastDeadNPC = currentTarget
                end
                currentTarget = nil

                for name, npc in pairs(LivingNPCs) do
                    if npc and not IsNPCDead(npc) then
                        currentTarget = npc
                        MoveToCFrame(npc)
                        break
                    end
                end
            elseif currentTarget and not IsNPCDead(currentTarget) then
                local distance = (humanoidRootPart.Position - currentTarget.Position).Magnitude
                if distance > 7 then
                    MoveToCFrame(currentTarget)
                end
            end

            local allDead = true
            for _, npc in pairs(LivingNPCs) do
                if npc and not IsNPCDead(npc) then
                    allDead = false
                    break
                end
            end
            if allDead then
                autoLeave()
                break
            end
            task.wait()
        end
    end)
end

local function killBossOnly()
    local server = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
    if not server then return end

    local foundBoss = false
    local startTime = tick()

    repeat
        for _, npc in ipairs(server:GetChildren()) do
            if npc:IsA("BasePart") and npc:GetAttribute("IsBoss") == true and not IsNPCDead(npc) then
                foundBoss = true
                EnableAutoClicker()
                currentTarget = npc
                while not IsNPCDead(npc) do
                    MoveToCFrame(npc)
                    if (humanoidRootPart.Position - npc.Position).Magnitude > 7 then
                        MoveToCFrame(npc)
                    end
                    task.wait()
                end
                FireAriseDestroy(npc.Name)
                task.wait(1)
                autoLeave()
                break
            end
        end
        task.wait(0.5)
    until foundBoss or tick() - startTime > 10

    if not foundBoss then
        autoLeave()
    end
end

local function handleLeaveLogic()
    local currentFloorText = getCurrentCastleFloor()
    local targetFloor = "Floor: " .. tostring(getgenv().FloorLevel) .. "/100"
    if currentFloorText and currentFloorText == targetFloor then
        if getgenv().LeaveMode == "KillBossOnly" then
            killBossOnly()
        elseif getgenv().LeaveMode == "KillAll" then
            killAllNPCsAndLeave()
        elseif getgenv().LeaveMode == "LeaveDirectly" then
            autoLeave()
        end
        kill = false
        return true
    end
    return false
end

player.CharacterAdded:Connect(function(char)
    character = char
    humanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

task.spawn(function()
    while getgenv().isActive do
        if not handleLeaveLogic() then
            kill = true
            KillAllNPCs()
        else
            kill = false
        end
        task.wait(0.5)
    end
end)
