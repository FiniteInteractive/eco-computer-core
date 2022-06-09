--[[
Shutdown Failure
Eco Computer Core V8, Backend Script
by gloopyreverb
09/05/2021
]]

--[[
Players can trigger this event if the following criteria is met:
- shutdown has failed and no criteria creating an overload meltdown is met
]]

-- Libraries

self = workspace.GameData.EcoCC
audiosfx = workspace.GameData.EcoCC.SFX
facility = workspace.World.Objects.Facility
importantfacilityarea = facility.ImportantFacilityAreas
core = importantfacilityarea.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary
replicatedstorage = game.ReplicatedStorage
notification = require(game.ReplicatedStorage.Modules.NotificationStyle)
funkyname = self.ReactorStats.UsernameForCutscene.Value
TweenService = game:GetService("TweenService")
boom_module = require(game.ServerStorage.Modules.Reactor.BoomModule)
local ReplicatedStorage = game:GetService("ReplicatedStorage")


-- Functions



local announcement_timepos = {
	expired = 78;
	starting = 0;	
	startingend = 32;
}

function notify(Title,Text,Icon,TimeWait)
	for _,v in pairs(game.Players:GetPlayers()) do
		notification:Notify(v,"Classic",Title,Text,"Exclamation",TimeWait,"Classic")
	end
end

function teleport()
	for _,v in pairs(game.Players:GetPlayers()) do
		v.Character:MoveTo(Vector3.new(workspace.TeleportToHere.Position))
	end
end
function shockwave()
	ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.Nuke:Fire("Shockwave")
	audiosfx.ExplosionSoundEffects.Shockwave:Play()
end

function unanchor2(m)
	for _, i in pairs(m:GetChildren()) do
		if i:IsA("BasePart") then
			i.Anchored = false
		else
			unanchor2(i)
		end
	end
end

function meltdownending()
	if workspace.GameData.EcoCC.ReactorStats.ShutD.Value == false then
		fade(workspace.GameData.EcoCC.GeneralMusic.EndingMusic.BothOverloadAndMeltdown,"In")
		game.ReplicatedStorage.Components.Maps.Destroyed_MainHallway:Clone().Parent = workspace
		game.ReplicatedStorage.Components.Maps.Destroyed_PrimaryReactorArea:Clone().Parent = workspace
		task.wait(45)
		workspace.Destroyed_PrimaryReactorArea:Destroy()
		workspace.Destroyed_MainHallway:Destroy()
		fade(workspace.GameData.EcoCC.GeneralMusic.EndingMusic.BothOverloadAndMeltdown,"Out")
		task.wait(2)
		notify("System","The game is regenerating...",7)
		for _,Player in pairs(game.Players:GetPlayers()) do
			Player.Character:PivotTo(workspace.World.Objects.LookAtMeImNeverComingDown.CFrame)
		end
		task.wait(7)
		notify("System","The game has regenerated.",7)
		self.PowerEventChamber:Fire("on")
	end
end


function explosionNOW()
	if game.ServerScriptService.Server.Reactor.ReactorEvents.ShutdownSystem.Disabled == true or game.ServerScriptService.Server.Reactor.ReactorEvents.ReactorDisasters.ShutdownFailure.Disabled == true then
		boom_module.Boom()
		task.wait(boom_module.delay + 24)

		replicatedstorage.Events.General.Regen:Fire() -- note that regeneration is a --14 second process-- 
		task.wait(2)
		if self.ReactorStats.ShutD.Value == false then
			replicatedstorage.Events.EndingEvent:FireAllClients("Meltdown") 
			meltdownending()
		end
		task.wait(1)
		-- this is the ending!!! during this make sure to regenerate the
		-- whole thing and stuff
		--	make a seperate model so people can explore the entire destruction
		-- scene. people who
		-- choose to explore the ruins will be invisible to other players
		-- as they explore through em'. --almost-near-instant regeneration ACTUALLY!!!!
		-- players who were in the control room have a toggle that will be turned so 
		-- they will lose some FourCoins (up to 150-200) until they reach 0 and Ores (for iron and ruby, up to 1-3 lost, for phantom 3-5). they will also lose exp by 500 - This is as soon as the Meltdown starts to prevent avoiding (most of the time)
		task.wait(20)
		replicatedstorage.Events.DisasterClient:FireAllClients(false)
		workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = false
		script.Disabled = true
	end
end


function fade(music,inorout)
	if inorout == "In" then
		music:Play()
		TweenService:Create(music,TweenInfo.new(1),{Volume = 0.8}):Play()
	elseif inorout == "Out" then
		TweenService:Create(music,TweenInfo.new(1),{Volume = 0}):Play()
		wait(1)
		music:Stop()
	end
end

function bunkerclose()
	-- add bunker closing code for union and disable reset for anyone in bunker. if in hallway  outside bunker damage 20 since huge blast.
end

function power(outon)
	if outon == "On" then
		game.Lighting.Ambient = Color3.fromRGB(61, 61, 71)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(61, 61, 71)
		self.PowerIn:Fire()
	elseif outon == "Off" then
		self.PowerOut:Fire()
		audiosfx.OutNoPow3:Play()
		game.Lighting.Ambient = Color3.fromRGB(23, 23, 26)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(16,16,16)
	elseif outon == "Red" then
		self.PowerRed:Fire()
		game.Lighting.Ambient = Color3.fromRGB(16,16,16)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(16,16,16)
	end
end

function debris(area)
	if area == "screen_static" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = false
		wait(0.6)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
	elseif area == "Lobby_Top" then

	elseif area == "Lobby_MainHallWallToCafe" then
		game.ServerStorage.Wall:Clone().Parent = workspace.World.Objects.Facility.Debris
	elseif area == "ControlRoom_Roof" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
		wait(1.5)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
	elseif area == "AllDown" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.EmergencyMode.Disabled = true
		importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.SoundPart.AlarmSound:Stop()
	end
end


audiosfx.Announcements.CodeYellow.Played:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(true)
end)

audiosfx.Announcements.CodeYellow.Stopped:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.CodeYellow.Ended:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.MeltdownLines.Played:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(true)
end)

audiosfx.Announcements.MeltdownLines.Stopped:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.MeltdownLines.Ended:Connect(function()
	ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
end)

game.ServerScriptService.Server.Reactor.ReactorEvents.Stop.Disabled = false
notify("Shutdown","The Shutdown System failed to override dangerous reactor conditions and shutoff because...",7)
task.wait(6)
notify("Shutdown","The shutdown sequence was not followed correctly,",5)
task.wait(4)
notify("Shutdown", "and the Kill Switches are "..workspace.GameData.EcoCC.KillSwitches.Value..", instead of the minimum of 7.",7)
task.wait(8)
fade(self.GeneralMusic.EmergencyShutdown.ShutdownPending,"Out")
notify("Evacuate","Therefore, you need to evacuate at this time. The countdown will resume.",5)
task.wait(5)
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(false)
task.wait(1)
game.ServerScriptService.Server.Reactor.ReactorEvents.ShutdownSystem.Disabled = true
ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("Countdown",true)
audiosfx.Alarms.RepeatingWRREEE:Play()
audiosfx.Alarms.AmbienceAlarm2:Play()
fade(self.GeneralMusic.EmergencyShutdown.Failed.ShutdownFailed1,"In")
for z = 225,0,-1 do
	ReplicatedStorage.RemotesEvents.GuiEvents.CountdownText:FireAllClients(z)
	if z == 220 then
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
		debris("screen_static")
	end
	if z == 205 then
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		replicatedstorage.Events.General.WoopShocking:FireAllClients()
		
		unanchor2(core.Lasers.Model1)
		unanchor2(core.Lasers.Model2)
		unanchor2(core.Lasers.Model3)
		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = core.Lasers.Model1.Part.Position
		e.BlastRadius = 20
		e.BlastPressure = 40
		e.ExplosionType = Enum.ExplosionType.NoCraters
	end
	if z == 200 then
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
		wait(0.3)
		audiosfx.PowerOn:Play()
		power("Red")
	end
	if z == 180 then
		debris("glitchscreen")
	end
	if z == 140 then
		audiosfx.Alarms.IsoAlarm_CountFor140Only:Play()
	end
	if z == 131 then
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
		wait(0.3)
		audiosfx.PowerOn:Play()
		power("On")
	end
	if z == 130 then
		debris("glitchscreen")
		audiosfx.Alarms.KlaxonAlarm_CountdownStarted_or_Last130Sec:Play()
	end
	if z == 120 then
		notify("Two Minutes","You have 2 minutes left until the facility detonates!",8)
		audiosfx.Alarms.NuclearSiren:Play()
		audiosfx.Alarms.AlarmTwoMin:Play()
		audiosfx.Rumbling:Play()
	end
	if z == 71 then
		ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Explosion]",7)
		audiosfx.ExplosionSoundEffects.BlewItOutFast:Play()
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		replicatedstorage.Events.General.WoopShocking:FireAllClients()
		
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		unanchor2(core.SpinnerReactorForm1)
		unanchor2(core.SpinnerReactorForm2)
		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = core.SpinnerReactorForm1.Light.Position
		e.BlastRadius = 15
		e.BlastPressure = 15
		e.ExplosionType = Enum.ExplosionType.NoCraters
		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = core.SpinnerReactorForm2.Light.Position
		e.BlastRadius = 15
		e.BlastPressure = 15
		e.ExplosionType = Enum.ExplosionType.NoCraters
		wait(1)
		unanchor2(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.StairsGonExplode)
	end
	if z == 90 then
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.leak.Enabled = true
		workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.Leak:Play()
	end
	if z == 70 then
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		fade(self.GeneralMusic.EmergencyShutdown.Failed.ShutdownFailed1,"Out")
		fade(self.GeneralMusic.EmergencyShutdown.Failed.ShutdownFailed2,"In")
	end
	if z == 54 then
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
	end
	if z == 41 then
		ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Explosion]",7)
		audiosfx.Alarms.NearDestruction:Play()
		unanchor2(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Vent2Explode)
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		wait(0.2)
		audiosfx.ExplosionSoundEffects.ElectronicExplosion:Play()
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
		wait(0.01)
		game.ServerStorage.Misc.FireRoofSpawn:Clone().Parent = workspace.World.Objects.Facility.Debris
		audiosfx.ExplosionSoundEffects.majorExplosion:Play()
		audiosfx.Rumbling:Play()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
	end
	if z == 40 then
		TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Close.CFrame}):Play()
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

	end
	if z == 34 then
		unanchor2(core.Lasers.Model4)
		unanchor2(core.Lasers.Model5)
		unanchor2(core.Lasers.Model6)
		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = core.Lasers.Model4.Part.Position
		e.BlastRadius = 20
		e.BlastPressure = 40
		e.ExplosionType = Enum.ExplosionType.NoCraters
	end
	if z == 30 then
		ReplicatedStorage.RemotesEvents.GameEvents.Bunker:Fire("Close")
		ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blaring]",7)
		audiosfx.Alarms.AlarmWootWootDuhh:Play()
		notify("Bunker","The bunker is now closing!",8)
	end
	if z == 25 then
		audiosfx.Alarms.NuclearSiren:Play()
	end
	if z == 18 then
		audiosfx.Alarms.AmbienceAlarm:Stop()
		audiosfx.Alarms.AmbienceAlarm2:Stop()
		audiosfx.Alarms.IsoAlarm_CountFor140Only:Stop()
		audiosfx.Alarms.RepeatingWRREEE:Stop()
		audiosfx.Doom2atmospheric:Stop()
		audiosfx.Alarms.NearDestruction:Stop()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		audiosfx.Rumbling:Play()
	end
	if z == 12 then
		debris("bridge_collapse")
	end
	if z == 5 then
		fade(self.GeneralMusic.EmergencyShutdown.Failed.ShutdownFailed1,"Out")
		debris("AllDown")
	end
	if z == 3 then
		audiosfx.ExplosionSoundEffects.Rumble:Play()
	end
	task.wait(1)
end
TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(0.95, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Open.CFrame}):Play()
fade(self.GeneralMusic.EmergencyShutdown.Failed.ShutdownFailed1,"Out")
explosionNOW()