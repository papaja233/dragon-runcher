print("Jumping script started")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local cube = script.Parent
cube.Anchored = false  -- Ensure the cube can move and collide
local originalSize = cube.Size

-- Create BodyGyro object to control the cube's orientation
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.Name = "BodyGyro"
bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000) -- Strong torque to resist rotation
bodyGyro.P = 100000 -- Very strong to resist any rotational forces
bodyGyro.CFrame = CFrame.new(cube.Position) -- Lock the cube's orientation to be upright
bodyGyro.Parent = cube

-- Function to generate a controlled random movement offset
local function getRandomMovementOffset()
	local xOffset = math.random(-5, 5) -- Modest horizontal movement
	local zOffset = math.random(-5, 5)
	return Vector3.new(xOffset, 0, zOffset)
end

-- Create tweens for a jelly-like jump with faster transitions
local function createTweens()
	local movementOffset = getRandomMovementOffset()
	local newPosition = cube.Position + movementOffset

	-- Create the upward tween (moving up and forward)
	local upGoal = {
		Position = newPosition + Vector3.new(0, 5, 0), -- Vertical jump height
		Size = Vector3.new(originalSize.X * 0.9, originalSize.Y * 1.1, originalSize.Z * 0.9) -- More noticeable stretch
	}

	-- Create the downward tween (moving down and forward)
	local downGoal = {
		Position = newPosition + Vector3.new(0, -1, 0), -- Slightly lower than original position for bounce
		Size = Vector3.new(originalSize.X * 1.1, originalSize.Y * 0.9, originalSize.Z * 1.1) -- More noticeable squash
	}

	-- Reset to original size but keep the new position
	local resetGoal = {
		Position = newPosition,
		Size = originalSize
	}

	-- Adjusted tween timing for faster transitions
	local tweenInfo = TweenInfo.new(
		0.4, -- Faster duration for the up tween
		Enum.EasingStyle.Sine, -- Smoother easing
		Enum.EasingDirection.Out
	)

	-- Create the tweens
	local upTween = TweenService:Create(cube, tweenInfo, upGoal)
	local downTween = TweenService:Create(cube, tweenInfo, downGoal)
	local resetTween = TweenService:Create(cube, TweenInfo.new(0.2), resetGoal) -- Faster reset duration

	return upTween, downTween, resetTween
end

-- Function to perform the jump
local function jump()
	local upTween, downTween, resetTween = createTweens()

	-- Play the tweens in sequence
	upTween:Play()
	upTween.Completed:Wait() -- Wait for the tween to complete before starting the next one
	downTween:Play()
	downTween.Completed:Wait()
	resetTween:Play()

	-- Reset any angular velocity to prevent rotation
	cube.RotVelocity = Vector3.new(0, 0, 0)
end

-- Function to get a random interval between 1 and 5 seconds
local function getRandomInterval()
	return math.random(1, 5)
end

-- Loop the jump with random intervals
while true do
	jump()
	wait(getRandomInterval())  -- Wait for a random interval between jumps
end
