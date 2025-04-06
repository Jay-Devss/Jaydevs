local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local LivingNPCs = {}
local currentTarget = nil
local tween = nil

getgenv().isAutoLeftActive = true
getgenv().isActive = true
getgenv().useTween = true
getgenv().tweenSpeed = 100
getgenv().autoAriseDestroy = true
getgenv().ariseDestroyType = "Destroy"

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

local function GetNearbyPosition(npc)
	local hitboxRadius = 3
	local npcPos = npc.CFrame.Position
	local direction = (humanoidRootPart.Position - npcPos).Unit
	local offsetDistance = hitboxRadius + math.random(1, 3)
	return npcPos + (direction * offsetDistance)
end

local function MoveToCFrame(npc)
	local targetPosition = GetNearbyPosition(npc)
	local targetCFrame = CFrame.new(targetPosition)
	if getgenv().useTween then
		if tween then tween:Cancel() end
		local tweenInfo = TweenInfo.new(0, Enum.EasingStyle.Linear)
		tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
		tween:Play()
	else
		humanoidRootPart.CFrame = targetCFrame
	end
end

local function FirePunch(npcName)
	game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
		{ Event = "PunchAttack", Enemy = npcName },
		"\4"
	})
end

function FireAriseDestroy(npcName)
	if not getgenv().autoAriseDestroy then return end
	for _ = 1, 3 do
		game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
			{ Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture", Enemy = npcName },
			"\4"
		})
		task.wait(0.2)
	end
end

local function IsNPCDead(npc)
	local success, hp = pcall(function() return npc:GetAttribute("HP") end)
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
		task.wait()
	end
	FreezePlayer(false)
end)

function AutoLeft()
	task.spawn(function()
		while getgenv().isAutoLeftActive do
			pcall(function()
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
