task.wait(0.75)
workspace.GameData.EcoCC.CaveRegenInProg.Value = true
task.wait(15)
local Iron = game.ServerStorage.Misc.Cave.Ores.Iron
local Rock = game.ServerStorage.Misc.Cave.Ores.Rock
local Phantom = game.ServerStorage.Misc.Cave.Ores.Phantom
local Ruby = game.ServerStorage.Misc.Cave.Ores.Ruby
local spawnPart1 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen1
local spawnPart2 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen2
local spawnPart3 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen3
local spawnPart4 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen4
local spawnPart5 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen5
local spawnPart6 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen6
local spawnPart7 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen7
local spawnPart8 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen8
local spawnPart9 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen9
local spawnPart10 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen10
local spawnPart11 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen11
local spawnPart12 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen12
local spawnPart13 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen13
local spawnPart14 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen14
local spawnPart15 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen15
local spawnPart16 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen16
local spawnPart17 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen17
local spawnPart18 = workspace.World.Objects.Facility.Cave.OreLoc.YoCaveGen18

local Rarities = {
	Rock = 0.05;
	Iron = 0.02, -- 60% chance
	TnTium = 0.15,
	Ruby = 0.89, -- 30% chance
	Phantom = 0.979, -- 9% chance
}

local function PickRarity()
	local Index = math.random()
	local HighestRarity = "Iron"

	for RarityName, Value in pairs(Rarities) do
		if Index >= Value and Value >= Rarities[HighestRarity] then
			HighestRarity = RarityName
		end
	end

	return HighestRarity
end
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
	local randomLocation3 = getRandomLocationInsidePart(spawnPart3).p
	local randomLocation4 = getRandomLocationInsidePart(spawnPart4).p
	local randomLocation5 = getRandomLocationInsidePart(spawnPart5).p
	local randomLocation6 = getRandomLocationInsidePart(spawnPart6).p
	local randomLocation7 = getRandomLocationInsidePart(spawnPart7).p
	local randomLocation8 = getRandomLocationInsidePart(spawnPart8).p
	local randomLocation9 = getRandomLocationInsidePart(spawnPart9).p
	local randomLocation10 = getRandomLocationInsidePart(spawnPart10).p
	local randomLocation11 = getRandomLocationInsidePart(spawnPart11).p
	local randomLocation12 = getRandomLocationInsidePart(spawnPart12).p
	local randomLocation13 = getRandomLocationInsidePart(spawnPart13).p
	local randomLocation14 = getRandomLocationInsidePart(spawnPart14).p
	local randomLocation15 = getRandomLocationInsidePart(spawnPart15).p
	local randomLocation16 = getRandomLocationInsidePart(spawnPart16).p
	local randomLocation17 = getRandomLocationInsidePart(spawnPart17).p
	local randomLocation18 = getRandomLocationInsidePart(spawnPart18).p


	-- Get a random rotation so that the npc isn't always facing the same direction
	local randomRotation = CFrame.Angles(0,math.pi*random:NextNumber(0,2),0)

	local rarechance = PickRarity()
	local rarechance2 = PickRarity()
	local rarechance3 = PickRarity()
	local rarechance4 = PickRarity()
	local rarechance5 = PickRarity()
	local rarechance6 = PickRarity()
	local rarechance7 = PickRarity()
	local rarechance8 = PickRarity()
	local rarechance9 = PickRarity()
	local rarechance10 = PickRarity()
	local rarechance11 = PickRarity()
	local rarechance12 = PickRarity()
	local rarechance13 = PickRarity()
	local rarechance14 = PickRarity()
	local rarechance15 = PickRarity()
	local rarechance16 = PickRarity()
	local rarechance17 = PickRarity()
	local rarechance18 = PickRarity()

	local rarity = game.ServerStorage.Misc.Cave.Ores[rarechance]
	local rarity2 = game.ServerStorage.Misc.Cave.Ores[rarechance2]
	local rarity3 = game.ServerStorage.Misc.Cave.Ores[rarechance3]
	local rarity4 = game.ServerStorage.Misc.Cave.Ores[rarechance4]
	local rarity5 = game.ServerStorage.Misc.Cave.Ores[rarechance5]
	local rarity6 = game.ServerStorage.Misc.Cave.Ores[rarechance6]
	local rarity7 = game.ServerStorage.Misc.Cave.Ores[rarechance7]
	local rarity8 = game.ServerStorage.Misc.Cave.Ores[rarechance8]
	local rarity9 = game.ServerStorage.Misc.Cave.Ores[rarechance9]
	local rarity10 = game.ServerStorage.Misc.Cave.Ores[rarechance10]
	local rarity11 = game.ServerStorage.Misc.Cave.Ores[rarechance11]
	local rarity12 = game.ServerStorage.Misc.Cave.Ores[rarechance12]
	local rarity13 = game.ServerStorage.Misc.Cave.Ores[rarechance13]
	local rarity14 = game.ServerStorage.Misc.Cave.Ores[rarechance14]
	local rarity15 = game.ServerStorage.Misc.Cave.Ores[rarechance15]
	local rarity16 = game.ServerStorage.Misc.Cave.Ores[rarechance16]
	local rarity17 = game.ServerStorage.Misc.Cave.Ores[rarechance17]
	local rarity18 = game.ServerStorage.Misc.Cave.Ores[rarechance18]


	-- Position the NPC at the random location but a little higher because they are standing.
	rarity.CFrame = CFrame.new(randomLocation + Vector3.new(0,1+0.05,0)) * randomRotation
	rarity2.CFrame = CFrame.new(randomLocation2 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity3.CFrame = CFrame.new(randomLocation3 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity4.CFrame = CFrame.new(randomLocation4 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity5.CFrame = CFrame.new(randomLocation5 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity6.CFrame = CFrame.new(randomLocation6 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity7.CFrame = CFrame.new(randomLocation7 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity8.CFrame = CFrame.new(randomLocation8 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity9.CFrame = CFrame.new(randomLocation9 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity10.CFrame = CFrame.new(randomLocation10 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity11.CFrame = CFrame.new(randomLocation11 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity12.CFrame = CFrame.new(randomLocation12 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity13.CFrame = CFrame.new(randomLocation13 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity14.CFrame = CFrame.new(randomLocation14 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity15.CFrame = CFrame.new(randomLocation15 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity16.CFrame = CFrame.new(randomLocation16 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity17.CFrame = CFrame.new(randomLocation17 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity18.CFrame = CFrame.new(randomLocation18 + Vector3.new(0,math.random(1,6)+math.random(0.04,1.21),0)) * randomRotation
	rarity:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity2:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity3:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity4:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity5:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity6:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity7:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity8:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity9:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity10:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity11:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity12:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity13:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity14:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity15:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity16:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity17:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	rarity18:Clone().Parent = game.ServerStorage.OresToPutInWorkspace
	return rarity
end




-- Spawn an NPC every 5 seconds, but also remove the old one.
local count = 0
while true do
	if count >= 350 then
		local Children = game.ServerStorage.OresToPutInWorkspace:GetChildren()
	
		for i = 1, #Children do
			Children[i].Parent = workspace.World.Objects.Facility.Cave.OreLoc.Ores
			task.wait(0.05)
		end
		workspace.GameData.EcoCC.CaveRegenInProg.Value = false
		wait(100)
		task.wait(math.random(1300,3000))
		task.wait(60.1)
		workspace.World.Objects.Facility.Cave.OreLoc:Destroy()
		game.ReplicatedStorage.Components.Maps.Cave.OreLoc:Clone().Parent = workspace.World.Objects.Facility.Cave
		task.wait(10)
		count = 0
	elseif count <= 349 then
		spawnNPC()
		workspace.GameData.EcoCC.CaveRegenInProg.Value = true
		count = count +2
	end
	task.wait(math.random(0.25,0.95))
end

