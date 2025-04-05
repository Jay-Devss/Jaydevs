local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local tween = nil
local currentTarget = nil
local isFrozen = false

local TweenService = game:GetService("TweenService")
local raycastParams = Instance.new("RaycastParams")
raycastParams.FilterDescendantsInstances = {character}
raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

local originalWalkSpeed = humanoid.WalkSpeed
local originalJumpPower = humanoid.JumpPower

local function FreezePlayer()
	if not isFrozen then
		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
		isFrozen = true
	end
end

local function UnfreezePlayer()
	if isFrozen then
		humanoid.WalkSpeed = originalWalkSpeed
		humanoid.JumpPower = originalJumpPower
		isFrozen = false
	end
end

local function IsNPCLiving(npc)
	if not npc then return false end
	local healthBar = npc:FindFirstChild("HealthBar")
	if not healthBar then return false end
	local main = healthBar:FindFirstChild("Main")
	local bar = main and main:FindFirstChild("Bar")
	local amount = bar and bar:FindFirstChild("Amount")
	return amount and amount:IsA("TextLabel") and amount.Text ~= "0 HP"
end

local function GetAllLivingNPCs()
	local enemiesFolder = workspace:FindFirstChild("__Main")
		:FindFirstChild("__Enemies")
		:FindFirstChild("Client")
	if not enemiesFolder then return {} end

	local npcs = {}
	for _, enemy in ipairs(enemiesFolder:GetChildren()) do
		if enemy:FindFirstChild("HumanoidRootPart") and IsNPCLiving(enemy) then
			local distance = (enemy.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
			if distance <= getgenv().maxDetectionDistance then
				table.insert(npcs, {enemy = enemy, distance = distance})
			end
		end
	end

	table.sort(npcs, function(a, b) return a.distance < b.distance end)

	local sorted = {}
	for _, data in ipairs(npcs) do
		table.insert(sorted, data.enemy)
	end
	return sorted
end

local function GetNearbyPosition(npc)
	local hitboxRadius = 5
	local humanoid = npc:FindFirstChildOfClass("Humanoid")
	if humanoid then
		hitboxRadius = humanoid.HipHeight + 3
	end
	local npcPos = npc.HumanoidRootPart.Position
	local direction = (humanoidRootPart.Position - npcPos).Unit
	local offsetDistance = hitboxRadius + math.random(1, 2)
	return npcPos + (direction * offsetDistance)
end

local function IsPathBlocked(targetPos)
	local rayResult = workspace:Raycast(humanoidRootPart.Position, (targetPos - humanoidRootPart.Position), raycastParams)
	return rayResult ~= nil
end

local function MoveToNPC(npc)
	local targetPosition = GetNearbyPosition(npc)

	if IsPathBlocked(targetPosition) then
		humanoidRootPart.CFrame = CFrame.new(targetPosition)
	else
		if getgenv().useTween then
			if tween then tween:Cancel() end
			local tweenInfo = TweenInfo.new((humanoidRootPart.Position - targetPosition).Magnitude / getgenv().tweenSpeed, Enum.EasingStyle.Linear)
			tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
			tween:Play()
		else
			humanoidRootPart.CFrame = CFrame.new(targetPosition)
		end
	end
end

local function TriggerAriseDestroy(npc)
	if not getgenv().autoAriseDestroy then return end

	local eventType = getgenv().ariseDestroyType == "Destroy" and "EnemyDestroy" or "EnemyCapture"
	for i = 1, 3 do
		local args = {
			[1] = {
				[1] = {
					["Event"] = eventType,
					["Enemy"] = npc.Name
				},
				[2] = "\4"
			}
		}
		game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
		task.wait(0.1)
	end
end

local function ResetCharacter()
	character = player.Character or player.CharacterAdded:Wait()
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	originalWalkSpeed = humanoid.WalkSpeed
	originalJumpPower = humanoid.JumpPower
end

player.CharacterAdded:Connect(ResetCharacter)

-- MAIN LOOP
task.spawn(function()
	while true do
		if getgenv().isActive then
			if not currentTarget or not IsNPCLiving(currentTarget) then
				if currentTarget then
					UnfreezePlayer()
					TriggerAriseDestroy(currentTarget)
				end

				local sortedNPCs = GetAllLivingNPCs()
				currentTarget = sortedNPCs[1]
				if currentTarget then
					MoveToNPC(currentTarget)
				end
			end

			if currentTarget and IsNPCLiving(currentTarget) then
				FreezePlayer()
				game:GetService("ReplicatedStorage").BridgeNet2.dataRemoteEvent:FireServer({
					{
						Event = "PunchAttack",
						Enemy = currentTarget.Name
					},
					"\4"
				})
			else
				UnfreezePlayer()
				currentTarget = nil
			end
		else
			UnfreezePlayer()
		end
		task.wait()
	end
end)
