local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local TweenService = game:GetService("TweenService")
local LivingNPCs = {}
local currentTarget = nil
local tween = nil
local lastDeadNPC = nil
local targetCFramePosition = nil
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

	if getgenv().useTween then
		if tween then tween:Cancel() end
		local distance = (humanoidRootPart.Position - targetPosition).Magnitude
		local duration = math.clamp(distance / getgenv().tweenSpeed, 0.05, 1)
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
		tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
		tween:Play()
	else
		local hitboxPosition = GetNearbyPosition(npc)
		local duration = 0
		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear) 
		tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(hitboxPosition)})
		tween:Play() 
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
	task.spawn(function()
		for _ = 1, 3 do
			game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
				{ Event = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture", Enemy = npcName },
				"\4"
			})
			task.wait(0.3)
		end
	end)
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
		if not currentTarget or not currentTarget:IsDescendantOf(workspace) or IsNPCDead(currentTarget) then
			if currentTarget and IsNPCDead(currentTarget) then
				lastDeadNPC = currentTarget
			end
			currentTarget = nil
			for name, npc in pairs(LivingNPCs) do
				if npc and not IsNPCDead(npc) then
					currentTarget = npc
					FirePunch(name)
					MoveToCFrame(npc)
					break
				end
			end
		end
		task.wait()
	end
end)

task.spawn(function()
	while getgenv().isActive do
		if currentTarget then
			FreezePlayer(true)
			FirePunch(currentTarget.Name)
		end
		task.wait()
	end
	FreezePlayer(false)
end)

task.spawn(function()
	while getgenv().isActive do
		if lastDeadNPC then
			FireAriseDestroy(lastDeadNPC.Name)
			lastDeadNPC = nil
		end
		task.wait()
	end
end)

task.spawn(function()
	while getgenv().isAutoLeftActive do
		pcall(function()
			local playerGui = player:FindFirstChild("PlayerGui")
			local hud = playerGui and playerGui:FindFirstChild("Hud")
			local upContainer = hud and hud:FindFirstChild("UpContanier")
			local dungeonInfo = upContainer and upContainer:FindFirstChild("DungeonInfo")
			if dungeonInfo and dungeonInfo:IsA("TextLabel") and dungeonInfo.Text == "Dungeon Ends in 12s" then
				local vim = game:GetService("VirtualInputManager")
				vim:SendKeyEvent(true, "BackSlash", false, game)
				vim:SendKeyEvent(false, "BackSlash", false, game)
				task.wait(0.5)
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

local VirtualUser = game:GetService("VirtualUser")

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

task.spawn(function()
	while getgenv().isActive do
		if character and character:FindFirstChild("Humanoid") then
			if character.Humanoid.Sit then
				character.Humanoid.Sit = false
			end
		end
		task.wait(0.1)
	end
end)

task.spawn(function()
	while getgenv().isActive do
		if humanoidRootPart then
			humanoidRootPart.Anchored = false
			humanoidRootPart.Velocity = Vector3.zero
		end
		task.wait(0.5)
	end
end)

task.spawn(function()
	while getgenv().isActive do
		pcall(function()
			if currentTarget and targetCFramePosition then
				local distance = (humanoidRootPart.Position - targetCFramePosition).Magnitude
				if distance > 5 then
					MoveToCFrame(currentTarget)
				end
			end
		end)
		task.wait(1)
	end
end)
