local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local inventoryGui = player:WaitForChild("PlayerGui"):WaitForChild("InventoryGui")
local cubeContainer = inventoryGui:WaitForChild("CubeContainer")
local cubeCounter = cubeContainer:WaitForChild("CubeCounter")

-- Initialize cube count
local collectedCubes = 0
cubeContainer.Visible = false

-- Function to update the cube counter display
local function updateCubeCounter()
	cubeCounter.Text = "x" .. collectedCubes
	if collectedCubes > 0 then
		cubeContainer.Visible = true
	else
		cubeContainer.Visible = false
	end
end

-- Function to collect a cube
local function collectCube(cube)
	collectedCubes = collectedCubes + 1
	updateCubeCounter()
	cube:Destroy()
end

-- Function to spawn a clone of the cube
local function spawnCube()
	if collectedCubes > 0 then
		collectedCubes = collectedCubes - 1
		updateCubeCounter()

		-- Clone the cube and script
		local collectibleCube = ReplicatedStorage:WaitForChild("CollectibleCube")
		local newCube = collectibleCube:Clone()

		local localScript = ReplicatedStorage:WaitForChild("JumpingCubeScript")
		local clonedScript = localScript:Clone()

		-- Calculate the spawn position in front of the player
		local character = player.Character
		if character then
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
			local lookVector = humanoidRootPart.CFrame.LookVector
			local spawnPosition = humanoidRootPart.Position + (lookVector * 5)

			-- Set cube position and properties
			newCube.Position = spawnPosition
			newCube.Anchored = false  -- Ensure it's not anchored
			newCube.CanCollide = true -- Ensure it can collide with the environment

			-- Parent the script to the new cube and disable it initially
			clonedScript.Parent = newCube
			clonedScript.Disabled = true

			-- Parent the cube to the workspace
			newCube.Parent = workspace

			-- Enable the script after everything is set up
			clonedScript.Disabled = false
			print("LocalScript enabled for:", newCube.Name)
		end
	end
end

-- Detect clicks on cubes
mouse.Button1Down:Connect(function()
	local target = mouse.Target
	if target and target:IsA("Part") and target.Name == "CollectibleCube" then
		collectCube(target)
	end
end)

-- Detect right-click anywhere to spawn a cube
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		spawnCube()
	end
end)
