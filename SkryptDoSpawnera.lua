local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local spawner = script.Parent  -- The spawner object

local cubeTemplate = ReplicatedStorage:WaitForChild("CollectibleCube")  -- The template for the cube with the script already attached
local spawnInterval = 5  -- Time in seconds between spawns
local numCubesToSpawn = 3  -- Number of cubes to spawn per interval
local spawnRadius = 10  -- Radius around the spawner to spawn cubes within
local maxCubesInWorld = 6  -- Maximum number of cubes allowed in the world

-- Function to count the number of "CollectibleCube" in the workspace
local function countCubesInWorld()
    local count = 0
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Name == "CollectibleCube" then
            count = count + 1
        end
    end
    return count
end

-- Function to spawn a cube
local function spawnCube()
    -- Check the current number of cubes in the world
    if countCubesInWorld() >= maxCubesInWorld then
        return  -- Stop spawning if the limit is reached
    end
    
    local cube = cubeTemplate:Clone()
    cube.Parent = workspace
    cube.Position = spawner.Position + Vector3.new(
        math.random() * 2 * spawnRadius - spawnRadius,
        0,  -- Start on the ground level
        math.random() * 2 * spawnRadius - spawnRadius
    )

    -- Enable the script in the cloned cube (if it's a LocalScript, it needs to be handled properly)
    local jumpingScript = cube:FindFirstChild("JumpingCubeScript")
    if jumpingScript then
        jumpingScript.Disabled = false
    end

    -- Clean up the cube after some time
    Debris:AddItem(cube, 300)  -- Adjust the lifetime if needed
end

-- Function to continuously check and spawn cubes
local function spawnCubesContinuously()
    while true do
        -- Spawn cubes in intervals, but only if the number of cubes is below the limit
        if countCubesInWorld() < maxCubesInWorld then
            for i = 1, numCubesToSpawn do
                spawnCube()
            end
        end
        wait(spawnInterval)  -- Wait for the spawn interval
    end
end

-- Start the spawning process
spawnCubesContinuously()
