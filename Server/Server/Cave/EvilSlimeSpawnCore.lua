task.wait(15)
local spawnPart1 = workspace.World.Objects.Facility.Cave.SpawnNPCInsideHere
local spawnPart2 = workspace.World.Objects.Facility.Cave.SpawnNPCInsideHere2

local mob = game.ServerStorage.Misc["Evil Slime"]

local random = Random.new()

function getRandomLocationInsidePart(part)
	-- Returns the part's CFrame plus or minus half of the part's size
	return part.CFrame * CFrame.new(
		part.Size * Vector3.new(random:NextNumber(-.5,.5), random:NextNumber(-.5,.5), random:NextNumber(-.5,.5))
	)
end

function spawnNPC()
	-- Get a random cframe, and use just the position as the spawn point
	local randomLocation = getRandomLocationInsidePart(spawnPart1).p
	local randomLocation2 = getRandomLocationInsidePart(spawnPart2).p

	-- Get a random rotation so that the npc isn't always facing the same direction
	local randomRotation = CFrame.Angles(0,math.pi*random:NextNumber(0,2),0)

	local npc = mob:Clone()
	local npc2 = mob:Clone()

	local hipHeight = npc.Humanoid.HipHeight
	local hipHeight2 = npc2.Humanoid.HipHeight

	-- Position the NPC at the random location but a little higher because they are standing.
	npc.HumanoidRootPart.CFrame = CFrame.new(randomLocation + Vector3.new(0,1+hipHeight,0)) * randomRotation
	npc2.HumanoidRootPart.CFrame = CFrame.new(randomLocation2 + Vector3.new(0,1+hipHeight,0)) * randomRotation

	npc.Parent = workspace.World.Mobs
	npc2.Parent = workspace.World.Mobs

	return npc
end

local count = 0
while true do
	if count >= 25 then
		task.wait(math.random(450,650))
		count = 0
	elseif count <= 24 then
		spawnNPC()
		count = count +math.random(1,2)
	end
	task.wait(0.45)
end

