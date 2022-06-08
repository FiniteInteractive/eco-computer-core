--[[
Server Handler
by gloopyreverb
02/19/21, modified to fit current version (06/07/22)
]]

local TweenService = game:GetService("TweenService")
local ColorSet = require(game.ReplicatedStorage.Modules.ColorSet)
local Zone = require(game:GetService("ReplicatedStorage").Modules.Zone)
local Players = game:GetService("Players")
local marketplace = game:GetService("MarketplaceService")
local ReplicatedStorage = game.ReplicatedStorage
local BadgeService = game:GetService("BadgeService")
local AlarmModule = require(game.ReplicatedStorage.Lib.AlarmSystem)
--local remoteFunctionSet = ReplicatedStorage.Events:WaitForChild("SetSpawn")
local ServerStorage = game.ServerStorage
local FourGame = workspace.GameData.EcoCC
local id = 39155604 -- gamepass
local id2 = 8461871 --gamepass... 2. same thing as id 1
local CollectionService = game:GetService("CollectionService")
local badgeService = game:GetService("BadgeService")
local badgeID = 2125872820

local Goal = {}
Goal.Size = Vector3.new(2048,2048,2048)
NukeTime = TweenInfo.new(40)
OverLoadNuke = TweenInfo.new(10)
local Lights = CollectionService:GetTagged("LightChamber")

local lightColours = {
	black = Color3.fromRGB(0,0,0);
}


local function lights_show(v)
		game:GetService("TweenService"):Create(v, TweenInfo.new(math.random(0.45,0.85),Enum.EasingStyle.Linear), {Color = lightColours.black}):Play()
		game:GetService("TweenService"):Create(v.PointLight, TweenInfo.new(math.random(0.45,0.85),Enum.EasingStyle.Linear), {Color = lightColours.black}):Play()
end


for i,v in pairs (Lights) do
	coroutine.resume(coroutine.create(function() --Coroutine to make sure it doesn't hold up the loop.
		lights_show(v)
	end))
end



local Shockwave = {}
Shockwave.Size = Vector3.new(516,516,516)
local ShockwaveTime = TweenInfo.new(6)
local ShieldBreak = TweenInfo.new(13)


game.Players.PlayerAdded:Connect(function(plr)
	while true do 
		task.wait(math.random(350,800))
		local eco = math.random(3,85)
		local xp = math.random(34,198)
		plr.leaderstats.Eco.Value += eco
		plr.Level.Experience_Current.Value += xp
		ReplicatedStorage.RemotesEvents.GameEvents.PaycheckReminder:FireClient(plr,eco,xp)
	end
end)

game.Players.PlayerAdded:Connect(function(plr)
	plr.CharacterAdded:Connect(function()
		if plr:WaitForChild("SpawnString",8).Value == "Cave1" then
			plr.Character:MoveTo(Vector3.new(workspace.World.Objects.Miscellaneous.Spawns.Cave1Spawn.Position))
		elseif plr:WaitForChild("SpawnString").Value == "Outside" then
			plr.Character:WaitForChild("Head").CFrame = workspace.World.Objects.Miscellaneous.Spawns.OutsideSpawn.CFrame
		elseif plr:WaitForChild("SpawnString").Value == "PrimaryReactorControlRoom" then
			plr.Character:WaitForChild("Head").CFrame = workspace.World.Objects.Miscellaneous.Spawns.PrimaryReactorControlSpawn.CFrame
		elseif plr:WaitForChild("SpawnString").Value == "SpaceTravel" then
			plr.Character:WaitForChild("Head").CFrame = workspace.World.Objects.Miscellaneous.Spawns.SpaceTravelSpawn.CFrame
		end
	end)
end)

game.Players.PlayerAdded:Connect(function(plr)
	local SpawnString = Instance.new("StringValue",plr)
	SpawnString.Name = "SpawnString"
	task.wait(3600)
	badgeService:AwardBadge(plr.UserId, badgeID)
end)



---- Bind the "createPart()" function to the remote function's "OnServerInvoke" callback
--remoteFunction.OnServerInvoke = spawner

--workspace.GameData.EcoCC.ReactorStats.CoreTemp.Changed:Connect(function(val)
--	if val >= 2800 and val <= 9000 and game.ServerScriptService.Events.Reactor.Shutdown.Coolant.Disabled == true and game.ServerScriptService.Events.Reactor.Shutdown.Restart.Disabled == true and game.ServerScriptService.Events.Reactor.Disasters.Overload.Disabled == true then
--		game.ServerScriptService.Events.Reactor.Disasters.Meltdown.Disabled = false
--	elseif val <= -2000 and game.ServerScriptService.Events.Reactor.Shutdown.Coolant.Disabled == true and game.ServerScriptService.Events.Reactor.Shutdown.Restart.Disabled == true then
--		game.ServerScriptService.Events.Reactor.Disasters.Freezedown.Disabled = false
--		game.ServerScriptService.Events.Reactor.Disasters.PreFreeze.Disabled = true
--	elseif val <= -300 and game.ServerScriptService.Events.Reactor.Shutdown.Coolant.Disabled == true and game.ServerScriptService.Events.Reactor.Shutdown.Restart.Disabled == true then
--		game.ServerScriptService.Events.Reactor.Disasters.PreFreeze.Disabled = false
--	end		
--end)

ReplicatedStorage.Events.GiveSteak.OnServerEvent:Connect(function(plr)
	ReplicatedStorage.Tools.Steak:Clone().Parent = plr.Backpack
end)

workspace.GameData.EcoCC.ReactorStats.CoreTemp.Changed:Connect(function(val)
	if val >= 3250 and val <= 13000 then
		if  game.ServerScriptService.Server.Reactor.ReactorEvents.ShutdownSystem.Disabled == true or game.ServerScriptService.Server.Reactor.ReactorDisasters.OverloadMeltdown.Disabled == true or game.ServerScriptService.Server.Reactor.ReactorDisasters.ShutdownFailure.Disabled == true  then
			game.ServerScriptService.Server.Reactor.ReactorDisasters.Meltdown.Disabled = false 

		elseif val >= 2000 and val <= 3250 then
			AlarmModule.on("red")	


		elseif val <= 1998 and val <= 1999 then
			AlarmModule.off("red")	

		end
	end
end)



ReplicatedStorage.RemotesEvents.GameEvents.SetSpawnEvent.OnServerEvent:Connect(function(plr,location)
	plr.SpawnString.Value = location
	if location == "Cave1" then
		plr.RespawnLocation = workspace.World.Objects.Miscellaneous.Spawns.Cave1Spawn
	elseif location == "Outside" then
		plr.RespawnLocation = workspace.World.Objects.Miscellaneous.Spawns.OutsideSpawn
	elseif location == "PrimaryReactorControlRoom" then
		plr.RespawnLocation = workspace.World.Objects.Miscellaneous.Spawns.PrimaryReactorControlSpawn		
	elseif location == "SpaceTravel" then
		plr.RespawnLocation = workspace.World.Objects.Miscellaneous.Spawns.SpaceTravelSpawn		
	end
end)


local RemoteEvent = ReplicatedStorage.RemotesEvents:WaitForChild("BadgeRewards")
local BadgeID = 2124633863 --Set this to your own badgeID! melt
local BadgeID2 = 2124894716 -- overload

RemoteEvent.OnServerEvent:Connect(function(player,bdg)
	if bdg == "melt" then
		BadgeService:AwardBadge(player.UserId, BadgeID)
	elseif bdg == "overload" then
		BadgeService:AwardBadge(player.UserId, BadgeID2)
	end
end)




--workspace.GameData.EcoCC.ShutdownSwitches.Changed:Connect(function(val)
--	if val == 1 then
--		ReplicatedStorage.GUI.Notification:FireAllClients("levers","levers Enabled! 1 down, 3 remaining!",10)
--		workspace.GameData.EcoCC.SFX.ShutdownSwitch:Play()
--	elseif val == 2 then
--		ReplicatedStorage.GUI.Notification:FireAllClients("levers","SS levers Enabled! 2 down, 2 remaining!",10)
--		workspace.GameData.EcoCC.SFX.ShutdownSwitch:Play()
--	elseif val == 3 then
--		ReplicatedStorage.GUI.Notification:FireAllClients("levers","SS levers Enabled! 3 down, 1 remaining!",10)
--		workspace.GameData.EcoCC.SFX.ShutdownSwitch:Play()
--	elseif val == 4 and game.ServerScriptService.Events.Reactor.Disasters.Meltdown.Disabled == false then
--		ReplicatedStorage.GUI.Notification:FireAllClients("levers","All levers enabled! Follow the instructions on how to shutdown the reactor.",10)
--		workspace.GameData.EcoCC.SFX.ShutdownSwitch:Play()
--	elseif val == 4 and game.ServerScriptService.Events.Reactor.Disasters.Freezedown.Disabled == false then
--		ReplicatedStorage.GUI.Notification:FireAllClients("levers","All levers enabled! Follow the instructions on how to restart the reactor.",10)
--		workspace.GameData.EcoCC.SFX.ShutdownSwitch:Play()
--	end
--end)

workspace.GameData.EcoCC.PowerEventChamber:Fire("off")

ReplicatedStorage.Events.General.ToggleBunkerSafeArea.OnServerEvent:Connect(function(player,toggle)
	if toggle == true then
		player.Bunker.Value = true
	elseif toggle == false then
		player.Bunker.Value = false
	end
end)

local cloneConnector = workspace.World.Objects.Facility.Connector:Clone()
local ImportantFacilityAreaClone = workspace.World.Objects.Facility.ImportantFacilityAreas:Clone()
local ReactorStats = workspace.GameData.EcoCC.ReactorStats:Clone()
local Reactor2Stats = workspace.GameData.EcoCC.Reactor2Stats:Clone()

cloneConnector.Parent = game.ServerStorage.Misc.RegenModules
ImportantFacilityAreaClone.Parent = game.ServerStorage.Misc.RegenModules
ReactorStats.Parent = game.ServerStorage.Misc.RegenModules
Reactor2Stats.Parent = game.ServerStorage.Misc.RegenModules

task.wait(0.5)
ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.Nuke.Event:Connect(function(typeofblast)
	if typeofblast == "Shockwave" then
		local twee = TweenService:Create(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.Shockwave,ShockwaveTime,Shockwave)
		twee:Play()
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.Shockwave.Transparency = 0.5
		wait(10)
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.Shockwave.Transparency = 1
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.Shockwave.Size = Vector3.new(0,0,0)
	elseif typeofblast == "ShieldBroken" then
		local twee = TweenService:Create(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.BrokenShield,ShockwaveTime,Shockwave)
		twee:Play()
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.BrokenShield.Transparency = 0.5
		wait(10)
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.BrokenShield.Transparency = 1
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield.BrokenShield.Size = Vector3.new(0,0,0)
	elseif typeofblast == "Nuke" then
		local twee = TweenService:Create(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield["Nuke_-2"],NukeTime,Goal)
		local twee2 = TweenService:Create(workspace.World.Objects.Miscellaneous.Nuke2Out,NukeTime,Goal)
		twee:Play()
		twee2:Play()
		wait(31)
		workspace.World.Objects.Miscellaneous.Nuke2Out.Size = Vector3.new(0,0,0)
	elseif typeofblast == "OverloadedNuke" then
		local twee = TweenService:Create(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield["Nuke_-2"],OverLoadNuke,Goal)
		twee:Play()
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield["Nuke_-2"].Transparency = -4
		wait(20)
		workspace.World.Objects.Miscellaneous.Nuke2Out.Size = Vector3.new(0,0,0)
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield["Nuke_-2"].Transparency = 0
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary.Core.Shield["Nuke_-2"].Size = Vector3.new(0,0,0)
	end
end)



ReplicatedStorage.Events.Nuclear.FlingPlayersShockwave.Event:Connect(function()
	for i, player in ipairs(game.Players:GetPlayers()) do
		if player.Character then
			player.Character.Humanoid.Sit = true
			local bv = Instance.new("BodyVelocity")
			bv.P = 4000
			bv.MaxForce = Vector3.new(7500,1250,5504)
			bv.Velocity =  Vector3.new(7000,2500,4500)

			bv.Parent = player.Character.HumanoidRootPart
			wait(0.8)
			player.Character.HumanoidRootPart.BodyVelocity:Destroy()
		end
	end
end)

if workspace.GameData.EcoCC.Season.Value == "Winter" then
	game.Lighting.PostCorrection.TintColor = Color3.fromRGB(218, 240, 255)
	game.ServerStorage.Misc.Winter.Parent = workspace
	game.ReplicatedStorage.Skies.Winter.Parent = game.Lighting
	script.Parent.WeatherCore.Disabled = true
	game.ReplicatedStorage.Skies.WinterAtmo.Parent = game.Lighting
	workspace.Terrain:SetMaterialColor(Enum.Material.Asphalt, Color3.fromRGB(247,244,255))
	workspace.Terrain:SetMaterialColor(Enum.Material.Basalt, Color3.fromRGB(254, 167, 8))
	workspace.Terrain:SetMaterialColor(Enum.Material.Cobblestone, Color3.fromRGB(152, 204, 255))
	workspace.Terrain:SetMaterialColor(Enum.Material.Concrete, Color3.fromRGB(216, 220, 229))
	workspace.Terrain:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(238, 249, 255))
	workspace.Terrain:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(254, 255, 243))
	workspace.Terrain:SetMaterialColor(Enum.Material.LeafyGrass, Color3.fromRGB(226, 240, 255))
	workspace.Terrain:SetMaterialColor(Enum.Material.Mud, Color3.fromRGB(207, 213, 219))
	workspace.Terrain:SetMaterialColor(Enum.Material.Pavement, Color3.fromRGB(207, 236, 255))
	workspace.Terrain:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(189, 211, 228))
	workspace.Terrain:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(138, 159, 223))
	workspace.Terrain:SetMaterialColor(Enum.Material.Sandstone, Color3.fromRGB(255, 249, 244))
	workspace.Terrain:SetMaterialColor(Enum.Material.Slate, Color3.fromRGB(63, 127, 107))
	workspace.Terrain.WaterColor = Color3.fromRGB(23, 187, 255)

elseif workspace.GameData.EcoCC.Season.Value == "AprilFools" then

elseif workspace.GameData.EcoCC.Season.Value == "Summer" or "Spring" or "Initial" then
	game.ReplicatedStorage.Skies.SpringFallEtc:Clone().Parent = game.Lighting
	game.ReplicatedStorage.Skies.SpringSummerFallAtmo:Clone().Parent = game.Lighting
	workspace.Terrain:SetMaterialColor(Enum.Material.Asphalt, Color3.fromRGB(115, 123, 107))
	workspace.Terrain:SetMaterialColor(Enum.Material.Basalt, Color3.fromRGB(30, 30, 37))
	workspace.Terrain:SetMaterialColor(Enum.Material.Cobblestone, Color3.fromRGB(156, 145, 106))
	workspace.Terrain:SetMaterialColor(Enum.Material.Concrete, Color3.fromRGB(127, 102, 63))
	workspace.Terrain:SetMaterialColor(Enum.Material.Grass, Color3.fromRGB(86, 121, 82))
	workspace.Terrain:SetMaterialColor(Enum.Material.Ground, Color3.fromRGB(102, 92, 59))
	workspace.Terrain:SetMaterialColor(Enum.Material.LeafyGrass, Color3.fromRGB(120, 132, 83))
	workspace.Terrain:SetMaterialColor(Enum.Material.Mud, Color3.fromRGB(58, 46, 36))
	workspace.Terrain:SetMaterialColor(Enum.Material.Pavement, Color3.fromRGB(148, 148, 140))
	workspace.Terrain:SetMaterialColor(Enum.Material.Rock, Color3.fromRGB(102, 108, 111))
	workspace.Terrain:SetMaterialColor(Enum.Material.Sand, Color3.fromRGB(222, 195, 148))
	workspace.Terrain:SetMaterialColor(Enum.Material.Sandstone, Color3.fromRGB(137, 90, 71))
	workspace.Terrain:SetMaterialColor(Enum.Material.Slate, Color3.fromRGB(63, 127, 107))
	workspace.Terrain.WaterColor = Color3.fromRGB(148, 146, 172)
elseif workspace.GameData.EcoCC.Season.Value == "Fall" then


end

workspace.World.Objects.TeleportingElevators.MainBody.ElevatorCtrl.Up.ClickDetector.MouseClick:Connect(function(player)
	ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireClient(player,Color3.fromRGB(0,0,0),6.25)
	wait(5)
	ReplicatedStorage.RemotesEvents.GameEvents.Optimize:FireClient(player,"Outside",false)
	if player:FindFirstChild("inCar") == nil then
		player.Character:MoveTo(Vector3.new(718.763, 4524.991, 4669.26))
	elseif player:FindFirstChild("inCar") then
		player.Character.Humanoid.Jump = true
		player.Character:MoveTo(Vector3.new(718.763, 4524.991, 4669.26))
	end
	player.PlayerGui.CoreGUI.Outside.Value = true
end)


workspace.World.Objects.TeleportingElevators.MainBody2.ElevatorCtrl.Up.ClickDetector.MouseClick:Connect(function(player)
	ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireClient(player,Color3.fromRGB(0,0,0),6.25)
	wait(5)
	--player.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(position) end     
	player.Character:MoveTo(Vector3.new(-198.042, 5.011, -12.881))
	ReplicatedStorage.RemotesEvents.GameEvents.Optimize:FireClient(player,"Outside",true)
	player.PlayerGui.CoreGUI.Outside.Value = false
end)

game.ReplicatedStorage.RemotesEvents.GameEvents.MiningCrafting.GiveToolPickaxe.OnServerEvent:Connect(function(plr,tool)
	if tool == "Phantom" then
		if plr.Inventory.Phantom.Value >= 15  and plr.Backpack:FindFirstChild("Phantom Pick") == nil then
			ReplicatedStorage.Components.Maps.Cave.Tools["Phantom Pick"]:Clone().Parent = plr.Backpack
		end
	end
	if tool == "Ruby" then
		if plr.Inventory.Ruby.Value >= 10 and plr.Backpack:FindFirstChild("Ruby Pick") == nil then
			ReplicatedStorage.Components.Maps.Cave.Tools["Ruby Pick"]:Clone().Parent = plr.Backpack
		end
	end
	if tool == "Iron" then
		if plr.Inventory.Iron.Value >= 5 and plr.Backpack:FindFirstChild("Iron Pick") == nil then
			ReplicatedStorage.Components.Maps.Cave.Tools["Iron Pick"]:Clone().Parent = plr.Backpack
		end
	end
end)

workspace.World.Objects.Miscellaneous.UnlockedPhantomServer.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Phantom.Value >= 15 and plr.Backpack:FindFirstChild("Phantom Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Phantom Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Phantom Pick"]:Clone().Parent = plr.StarterGear
	end
end)

workspace.World.Objects.Miscellaneous.UnlockedIron2Server.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Iron.Value >= 5 and plr.Backpack:FindFirstChild("Iron Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Iron Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Iron Pick"]:Clone().Parent = plr.StarterGear
	end
end)

workspace.World.Objects.Miscellaneous.UnlockedRuby2Server.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Ruby.Value >= 10 and plr.Backpack:FindFirstChild("Ruby Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Ruby Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Ruby Pick"]:Clone().Parent = plr.StarterGear
	end
end)


workspace.World.Objects.Miscellaneous.UnlockedPhantom2Server.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Phantom.Value >= 15 and plr.Backpack:FindFirstChild("Phantom Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Phantom Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Phantom Pick"]:Clone().Parent = plr.StarterGear
	end
end)

workspace.World.Objects.Miscellaneous.UnlockedIron2Server.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Iron.Value >= 5 and plr.Backpack:FindFirstChild("Iron Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Iron Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Iron Pick"]:Clone().Parent = plr.StarterGear
	end
end)

workspace.World.Objects.Miscellaneous.UnlockedRubyServer.ProximityPrompt.Triggered:Connect(function(plr)
	if plr.Inventory.Ruby.Value >= 10 and plr.Backpack:FindFirstChild("Ruby Pick") == nil then
		ReplicatedStorage.Components.Maps.Cave.Tools["Ruby Pick"]:Clone().Parent = plr.Backpack
		ReplicatedStorage.Components.Maps.Cave.Tools["Ruby Pick"]:Clone().Parent = plr.StarterGear
	end
end)

while true do
	task.wait(200)
	workspace.World.Objects.Facility.Cave.Collecting_GarbageCollection:ClearAllChildren()
end

workspace.World.Objects.Miscellaneous["old.Workspace"]["Module-mix"].Grouper.Ore1.Color = ColorSet.orecolors_forui.Ruby
workspace.World.Objects.Miscellaneous["old.Workspace"]["Module-mix"].Grouper.Ore2.Color = ColorSet.orecolors_forui.Phantom
workspace.World.Objects.Miscellaneous["old.Workspace"]["Module-mix"].Grouper.Ore3.Color = ColorSet.orecolors_forui.Iron

game:GetService('Players').PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local toolCount = 0
		character.ChildAdded:Connect(function(instance)
			if instance:IsA('Tool') then
				toolCount = toolCount + 1
			end
		end)
		while wait(1) and character:IsDescendantOf(workspace) do
			if toolCount >= 250 then
				player:Kick('You have more than 250 tools. This can cause lag to your computer. - Reverb Studio Koltery Engine')
			end
			toolCount = 0
		end
	end)
end)