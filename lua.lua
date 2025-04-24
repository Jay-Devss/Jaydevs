local jay = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua", true))()

local function notify(title, content, duration)
	jay:Notify({ Title = title, Content = content, Duration = duration or 4 })
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local zonesFolder = workspace:WaitForChild("TeleportZones")
local zoneNames = {"TeleportZone", "TeleportZone1", "TeleportZone2", "TeleportZone3"}

local reachedThreshold = 3
local activeConnection = nil
local claimedZone = false

local function stopMovement()
	if activeConnection then
		activeConnection:Disconnect()
		activeConnection = nil
	end
	humanoid:Move(Vector3.zero)
end

local function createLobby()
	local args = {
		[1] = {
			["maxPlayers"] = 1,
			["gameMode"] = "Normal"
		}
	}

	game:GetService("ReplicatedStorage")
		:WaitForChild("Shared")
		:WaitForChild("RemotePromise")
		:WaitForChild("Remotes")
		:WaitForChild("C_CreateParty")
		:FireServer(unpack(args))
end


local function hasReachedTarget(targetCFrame)
	local currentPos = rootPart.Position
	local targetPos = targetCFrame.Position
	local distance = (targetPos - currentPos).Magnitude
	return distance <= reachedThreshold
end

local function moveTo(targetCFrame, stateLabel, zoneName)
	stopMovement()

	activeConnection = RunService.RenderStepped:Connect(function()
		if humanoid.Health <= 0 or not rootPart then
			stopMovement()
			return
		end

		if hasReachedTarget(targetCFrame) then
			stopMovement()
			notify("Arrived", "You reached " .. zoneName)
			createLobby()
			claimedZone = true
			return
		end

		if stateLabel.Text ~= "Waiting for players..." and not hasReachedTarget(targetCFrame) then
			stopMovement()
			notify("TeleportZone Taken", zoneName .. " is no longer available.")
			return
		end

		local moveDirection = (targetCFrame.Position - rootPart.Position).Unit
		humanoid:Move(moveDirection, false)
	end)
end


task.spawn(function()
	while not claimedZone do
		for _, zoneName in ipairs(zoneNames) do
			local zone = zonesFolder:FindFirstChild(zoneName)
			if zone then
				local gui = zone:FindFirstChild("BillboardGui")
				local stateLabel = gui and gui:FindFirstChild("StateLabel")
				local zoneContainer = zone:FindFirstChild("ZoneContainer")

				if stateLabel and zoneContainer and stateLabel:IsA("TextLabel") and zoneContainer:IsA("BasePart") and stateLabel.Text == "Waiting for players..." then
					local targetCFrame = zoneContainer.CFrame
					notify("TeleportZone Found", "Walking to " .. zoneName)
					moveTo(targetCFrame, stateLabel, zoneName)

					repeat
						task.wait(0.2)
					until not activeConnection or claimedZone

					break
				end
			end
		end

		task.wait(1)
	end
end)
