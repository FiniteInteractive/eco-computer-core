--[[
Overload Meltdown
Eco Computer Core Version 8
by gloopyreverb
]]

--[[
Players can trigger this event if the following criteria is met:
- less or more than 1 shutdown switch
- trip shutdown switch
- craft OverloHeat in Research Lab (ruby + hydrogen = OverloHeat)
- send OverloHeat to Reactor in Research Lab
- when all of the above is done, a player needs to trigger the shutdown
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


function BlackLights()
	local CoreL = core
	for i = 1,10 do
		TweenService:Create(CoreL["Startup"..i], TweenInfo.new(5), {Color = Color3.fromRGB(0, 0, 0)}):Play()
	end
end


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

function fade(music,inorout)
	if inorout == "In" then
		music:Play()
		TweenService:Create(music,TweenInfo.new(1),{Volume = 2.15}):Play()
	elseif inorout == "Out" then
		TweenService:Create(music,TweenInfo.new(1),{Volume = 0}):Play()
		wait(1)
		music:Stop()
	end
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
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Static.Enabled = true
		wait(0.6)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Static.Enabled = false
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

function meltdownending()
	notify("System","The game is regenerating...",7)
	for _,Player in pairs(game.Players:GetPlayers()) do
		Player.Character.Humanoid.Health = 0
	end
	task.wait(8)
	for _,Player in pairs(game.Players:GetPlayers()) do
		Player.Character:PivotTo(workspace.World.Objects.LookAtMeImNeverComingDown.CFrame)
	end
	task.wait(2)
	game.ReplicatedStorage.Events.General.Regen:Fire()
	task.wait(10)
	notify("System","The game has regenerated.",7)
	task.wait(3)
	self.PowerEventChamber:Fire("on")
end

function unexpected()
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Explosion]",7)
	audiosfx.ExplosionSoundEffects.BlewItOutFast:Play()
	audiosfx.Alarms.Overload.BellAlarm:Play()
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

self.ReactorStats.IsDisaster.Value = true
workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = true
replicatedstorage.Events.DisasterClient:FireAllClients(true)
notify("Shutdown","There was a catastrophic failure.",4)
task.wait(4)
notify("Attention","According to the Research Lab, the shutdown sequence has been tripped.",8)
task.wait(4)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2.5)
task.wait(0.1)
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(false)
task.wait(2.1)
ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent:FireAllClients("OverloadShutdownFail")
self.ReactorStats.CoreTemp.Value = self.ReactorStats.CoreTemp.Value*math.random(90,150)
notify("Attention","The reactor is experiencing major side-effects. We're working to identify the problem.",8)
task.wait(7)
notify("Problem Identified","The problem has been identified. Attempting to revert problem...",5)
TweenService:Create(core.lIGHT.Idle,TweenInfo.new(1),{PlaybackSpeed = 0}):Play()
task.wait(1)
core.lIGHT.Idle.Volume = 4
core.lIGHT.Idle.SoundId = "rbxassetid://1462066094"
core.lIGHT.Idle:Play()
core.lIGHT.Idle.RollOffMaxDistance = 2500
core.lIGHT.Idle.RollOffMinDistance = 120
core.lIGHT.Idle2.Disabled = true
TweenService:Create(core.lIGHT.Idle,TweenInfo.new(13),{PlaybackSpeed = 8}):Play()
task.wait(4)
unexpected()
self.PowerEventChamber:Fire("red")
fade(self.SFX.Alarms.AlarmBlur,"In")
task.wait(3)
self.PowerOut:Fire()
task.wait(1)
audiosfx.Alarms.MeltdownDramatic.Alarm1:Play()
core.lIGHT.Fire_Dust.Enabled = true
core.lIGHT.Active.Color = ColorSequence.new(Color3.fromRGB(215, 41, 46))
core.Core.Main.BrickColor = BrickColor.Black()
task.wait(1)
fade(self.GeneralMusic.PlanetEradication.OverloadMeltdownPartA,"In")
task.wait(3)
audiosfx.Alarms.Overload.RepeatingWRREEE:Play()
self.PowerRed:Fire()
notify("Error","Failed to revert problem!",5)
task.wait(2)
audiosfx.Alarms.IsoAlarm_CountFor140Only:Play()
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.overload_meltdown.Visible = true
notify("Warning","An overload meltdown has been issued",8)
audiosfx.Announcements.OverloadMeltdown:Play()
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.SurfaceGui.Enabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Countdown.Enabled = true
task.wait(4)
notify("Evacuation Options","Please use the Space Travel or Emergency Jets option at this time! The bunker is not safe!",7)
task.wait(2)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarms blaring]",9)
ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("Countdown",true)
replicatedstorage.Events.General.ContinousShake:FireAllClients()
for z = 330,0,-1 do
	ReplicatedStorage.RemotesEvents.GuiEvents.CountdownText:FireAllClients(z)
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Countdown.Frame.CountdownText.Text = "T-MINUS "..z.." SECONDS"
	if z == 280 then
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		replicatedstorage.Events.General.WoopShocking:FireAllClients()
		audiosfx.Alarms.MeltdownDramatic.Alarm1:Stop()
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
	if z == 290 then
		fade(self.SFX.Alarms.AlarmBlur,"Out")
	end
	if z == 210 then
		unanchor2(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.ThermalUnits.THERMAL_U_A)
		replicatedstorage.Events.General.WoopShocking:FireAllClients()
		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
	end
	if z == 165 then
		notify("Evacuation Options","Space Travel is an option if you are trying to evacuate!",7)
	end
	if z == 151 then
		audiosfx.ExplosionSoundEffects.majorExplosion:Play()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = workspace.World.Objects.Facility.Connector.SoundPart.Position
		unanchor2(workspace.World.Objects.Facility.Connector)
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
	if z == 127 then
		power("off")
		game.Lighting.Ambient = Color3.fromRGB(10,10,10)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(10,10,10)
		workspace.GameData.EcoCC.PowerOut:Fire()
	end
	if z == 100 then
		audiosfx.Alarms.Overload.Last100:Play()
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
	end
	if z == 72 then
		core.lIGHT.RS2.Volume = 4
		core.lIGHT.RS2:Play()
		core.lIGHT.RS2.RollOffMaxDistance = 2500
		core.lIGHT.RS2.RollOffMinDistance = 120
		TweenService:Create(core.lIGHT.Idle,TweenInfo.new(21),{PlaybackSpeed = 14}):Play()
		TweenService:Create(core.lIGHT.RS2,TweenInfo.new(21),{PlaybackSpeed = 14}):Play()
	end
	if z == 69 then
		TweenService:Create(core.lIGHT.RS2.PitchShiftSoundEffect,TweenInfo.new(21),{Octave = 2}):Play()
	end
	if z == 65 then
		self.GeneralMusic.PlanetEradication.OverloadMeltdownPartB:Play()
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
	if z == 62 then
		audiosfx.OverloadCounting:Play()
	end
	if z == 60 then
		audiosfx.Alarms.Overload.Last60SecondsOfUrLIfe:Play()
		TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Close.CFrame}):Play()
		audiosfx.Overload60:Play()
		workspace.LockdownItsLockingIndicator.Alarm:Play()
	end
	if z == 45 then
		workspace.LockdownItsLockingIndicator.Alarm:Stop()
		unanchor2(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.ThermalUnits.THERMAL_U_B)
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
	end
	if z == 30 then
		workspace.Graviity = 185
		audiosfx.Overloadlast60:Play()
	end
	if z == 20 then
		TweenService:Create(core.lIGHT.Idle,TweenInfo.new(20),{PlaybackSpeed = 20}):Play()
	end
	if z == 11 then
		BlackLights()
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Countdown.Frame.Visible = false
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Countdown.ded.Visible = true
		fade(self.GeneralMusic.PlanetEradication.OverloadMeltdownPartA,"Out")
		fade(self.GeneralMusic.PlanetEradication.Ending,"In")
	end
	if z == 3 then
		audiosfx.Alarms.Overload.Last100:Stop()
		audiosfx.Alarms.AmbienceAlarm:Stop()
		audiosfx.Overloadlast60:Stop()
		audiosfx.Overload60:Stop()
		audiosfx.Alarms.AmbienceAlarm2:Stop()
		audiosfx.Alarms.IsoAlarm_CountFor140Only:Stop()
		audiosfx.Alarms.Overload.BellAlarm:Stop()
		audiosfx.Alarms.Overload.facaalarm:Stop()
		audiosfx.Alarms.Overload.RepeatingWRREEE:Stop()
		audiosfx.Alarms.RepeatingWRREEE:Stop()
		audiosfx.Doom2atmospheric:Stop()
		audiosfx.Alarms.NearDestruction:Stop()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		audiosfx.Rumbling:Play()
		self.PowerEventChamber:Fire("off")
	end
	task.wait(1)
end
ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("Countdown",false)
task.wait(3)
audiosfx.OverloadExp:Play()
audiosfx.OverloadExp2:Play()
audiosfx.OverloadExp3:Play()
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(252, 39, 48),1.65)
game.Lighting.OverloadEffect.Enabled = true
game.ServerStorage.Misc.OverloadExplode:Clone().Parent = workspace
ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.Nuke:Fire("OverloadedNuke")
replicatedstorage.Events.General.WeExploded:FireAllClients()
replicatedstorage.Events.Nuclear.FlingPlayersShockwave:Fire()
task.wait(2)
replicatedstorage.Events.Nuclear.FlingPlayersShockwave:Fire()
task.wait(15)
for _,Player in pairs(game.Players:GetPlayers()) do
	if Player.Character then
	local fire = Instance.new("Fire",Player.Character.HumanoidRootPart)
	fire.Size = 20
		fire.Enabled = true
	end
end
task.wait(90)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.overload_meltdown.Visible = false
fade(self.GeneralMusic.PlanetEradication.Ending,"Out")
self.PowerEventChamber:Fire("on")
game.Lighting.OverloadEffect.Enabled = false
game.Workspace.OverloadExplode:Destroy()
workspace.Graviity = 196.1
-- add an ending
TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(0.95, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Open.CFrame}):Play()
task.wait(1)
-- this is the ending!!! during this make sure to regenerate the
-- whole thing and stuff
--	make a seperate model so people can explore the entire destruction
-- scene. people who
-- choose to explore the ruins will be invisible to other players
-- as they explore through em'. 
game.ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.OverloadMeltdownEnding:FireAllClients()
task.wait(61)
meltdownending()
ReplicatedStorage.RemotesEvents.GuiEvents.AddAchievement:FireAllClients("Exploded")
--almost-near-instant regeneration ACTUALLY!!!!
-- players who were in the control room have a toggle that will be turned so 
-- they will lose some FourCoins (up to 150-200) until they reach 0 and Ores (for iron and ruby, up to 1-3 lost, for phantom 3-5). they will also lose exp by 500 - This is as soon as the Meltdown starts to prevent avoiding (most of the time)
task.wait(10)
replicatedstorage.Events.DisasterClient:FireAllClients(false)
workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = false
script.Disabled = true