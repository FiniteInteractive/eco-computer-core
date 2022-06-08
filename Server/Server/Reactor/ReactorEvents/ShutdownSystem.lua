--[[
Shutdown System
Eco Computer Core Backend Script
by gloopyreverb
08/02/21
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

local CanFail = math.random(1,100)



-- Functions


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
		TweenService:Create(music,TweenInfo.new(1),{Volume = 0.8}):Play()
	elseif inorout == "Out" then
		TweenService:Create(music,TweenInfo.new(1),{Volume = 0}):Play()
		task.wait(1)
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
		task.wait(0.6)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
	elseif area == "Lobby_Top" then

	elseif area == "Lobby_MainHallWallToCafe" then
		game.ServerStorage.Wall:Clone().Parent = workspace.World.Objects.Facility.Debris
	elseif area == "ControlRoom_Roof" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
		task.wait(1.5)
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

--[[
FOUR COMPUTER CORE VERSION 6:
Restart for 6.0.2
]]

-- Libraries
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage
local FourGame = workspace.GameData.EcoCC

function shutdown()
	notify("Shutdown","Disconnecting Lights...",5)
	game:GetService("TweenService"):Create(core.CoreL.Part1,TweenInfo.new(5),{Color = Color3.fromRGB(0,0,0)}):Play()
	task.wait(1)
	game:GetService("TweenService"):Create(core.CoreL.Part2,TweenInfo.new(5),{Color = Color3.fromRGB(0,0,0)}):Play()
	game:GetService("TweenService"):Create(core.CoreL.Part3,TweenInfo.new(5),{Color = Color3.fromRGB(0,0,0)}):Play()
	game:GetService("TweenService"):Create(core.CoreL.Part4,TweenInfo.new(5),{Color = Color3.fromRGB(0,0,0)}):Play()
	task.wait(3)
	local CoreL = core
	for i = 1,10 do
		TweenService:Create(CoreL["Startup"..i], TweenInfo.new(0.5), {Color = Color3.fromRGB(0, 0, 0)}):Play()
	end
	task.wait(5)
	notify("Shutdown","Requesting Reactor #1 and #2 to power off...",5)
	core.Lasers.Model1.noooooo.ParticleEmitter.Enabled = false
	core.Lasers.Model1.laser1.ParticleEmitter.Enabled = false
	core.Lasers.Model2.BUM.ParticleEmitter.Enabled = false
	core.Lasers.Model2.laser.ParticleEmitter.Enabled = false
	core.Lasers.Model3.EEEEE.ParticleEmitter.Enabled = false
	core.Lasers.Model3.selloutalarm.ParticleEmitter.Enabled = false
	task.wait(3)
	core.lIGHT.NearMelt.Enabled = false
	task.wait(6)
	core.Lasers.Model4.aaaaa.ParticleEmitter.Enabled = false
	core.Lasers.Model4.noturn.ParticleEmitter.Enabled = false
	core.Lasers.Model5.Which.ParticleEmitter.Enabled = false
	core.Lasers.Model5.thatthing.ParticleEmitter.Enabled = false
	core.Lasers.Model6.COCO.ParticleEmitter.Enabled = false
	core.Lasers.Model6.offplz.ParticleEmitter.Enabled = false
	core.Lasers.Model7.kthx.ParticleEmitter.Enabled = false
	core.Lasers.Model7.noproblem.ParticleEmitter.Enabled = false
	core.Lasers.Model8.BOI.ParticleEmitter.Enabled = false
	core.Lasers.Model8.bye.ParticleEmitter.Enabled = false
	core.Core.Shield.Transparency = 1
	core.Core.Shield2.Transparency = 1
	task.wait(4)
	notify("Shutdown","All reactors are powering down...",5)
	task.wait(2)
	core.lIGHT.Fire_Dust.Enabled = false
	task.wait(3)
	workspace:SetAttribute("CoreIsOn",false)
	game:GetService("TweenService"):Create(core.Core.Main,TweenInfo.new(5),{Transparency = 1}):Play()
	core.Lasers.Model1.laser1.ParticleEmitter.Enabled = false
	core.Lasers.Model1.noooooo.ParticleEmitter.Enabled = false
	task.wait(5)
	core.Lasers.Model8.BOI.ParticleEmitter.Enabled = false
	core.Lasers.Model8.bye.ParticleEmitter.Enabled = false
	task.wait(2)
	core.lIGHT.Active.Enabled = false
	core.Lasers.Model2.BUM.ParticleEmitter.Enabled = false
	core.Lasers.Model2.laser.ParticleEmitter.Enabled = false
	task.wait(4)
	core.Lasers.Model3.EEEEE.ParticleEmitter.Enabled = false
	core.Lasers.Model3.selloutalarm.ParticleEmitter.Enabled = false
	task.wait(5)
	core.Lasers.Model4.aaaaa.ParticleEmitter.Enabled = false
	core.Lasers.Model4.noturn.ParticleEmitter.Enabled = false
	task.wait(6)
	core.Lasers.Model5.Which.ParticleEmitter.Enabled = false
	core.Lasers.Model5.thatthing.ParticleEmitter.Enabled = false
	task.wait(5)
	core.Lasers.Model6.COCO.ParticleEmitter.Enabled = false
	core.Lasers.Model6.offplz.ParticleEmitter.Enabled = false
	task.wait(6)
	core.Lasers.Model7.kthx.ParticleEmitter.Enabled = false
	core.Lasers.Model7.noproblem.ParticleEmitter.Enabled = false
	task.wait(3)
	notify("Shutdown","The Primary Reactor has shut down.",5)
	

end

function stop (m)
	for _,i in pairs (m:GetChildren()) do
		if i:IsA("Sound") then
			i:Stop()
		else
			stop(i)
		end
	end
end

if workspace.GameData.EcoCC.ReactorStats.ShutD.Value == false then
	workspace.GameData.EcoCC.ReactorStats.ShutD.Value = true
	game.ServerScriptService.Server.Reactor.ReactorEvents.Stop.Disabled = false
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Frame.Visible = false
	ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("Countdown",false)
	stop(workspace.GameData.EcoCC.SFX)
	stop(workspace.GameData.EcoCC.GeneralMusic)
	ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2.5)
	task.wait(1)
	game.ServerScriptService.Server.Reactor.ReactorDisasters.Meltdown.Disabled = true
	ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(true)
	fade(FourGame.GeneralMusic.EmergencyShutdown.ShutdownPending,"In")
	task.wait(1)
	ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent:FireAllClients("Shutdown")
	task.wait(5)
	--ReplicatedStorage.GUI.Notification:FireAllClients("Shutdown","L.E.R Shutdown Initiated by "..workspace.GameData.EcoCC.DaButtonPusher.Value.."!",5)
	notify("Shutdown","You shut the Reactor off, just in time, "..self.ReactorStats.UsernameForCutscene.Value.."!",6)
	task.wait(4)
	notify("Shutdown","Thank you to everyone who evacuated and/or collaborated in shutting off the reactor.",6)
	task.wait(7)
	ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2.5)
	task.wait(7)
	notify("Shutdown","It's strange how people just want to watch the world burn...",5)-- especially to other player
	task.wait(7)
	notify("Shutdown","but we will see how this pans out.",5)-- especially to other player
	task.wait(7)
	if workspace.GameData.EcoCC.KillSwitches.Value >= 7  and workspace.GameData.EcoCC.ReactorStats.OverloadMix.Value == false and CanFail <= 90 then -- kill switches on, coolant on
		audiosfx.Intercoms.bell:Play()
		task.wait(1.7)
		notify("Shutdown","Disconnecting Reactor from Facility Power",5)
		task.wait(0.5)
		power("Off")
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		task.wait(3)
		power("On")
		task.wait(6.7)
		notify("Shutdown","Attempting shutoff of Primary Reactor Systems",5)
		task.wait(5)
		fade(FourGame.GeneralMusic.EmergencyShutdown.ShutdownPending,"Out")
		task.wait(0.4)
		fade(FourGame.GeneralMusic.EmergencyShutdown.ShutdownSuccess,"In")
		notify("Shutdown","Rerouting emergency resources to Primary Reactor",5)
		task.wait(4)
		ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent:FireAllClients("ItsActuallyShuttingDown")
		shutdown()
		task.wait(1)
		FourGame.SFX.SucessEmergency:Play()
		notify("Shutdown","Waiting to shut off...",5)
		task.wait(7)
		notify("Shutdown","Since the shutdown sequence was performed sucessfully,",5)
		task.wait(7)
		notify("Shutdown","..there will no longer be a meltdown.",5)
		task.wait(5)
		notify("Shutdown","Thank you for saving the facility from an explosion.",5)
		task.wait(6.5)
		ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),4.5)
		notify("System","The game is regenerating...",7)
		game.ReplicatedStorage.Events.Regen:Fire()
		for _,Player in pairs(game.Players:GetPlayers()) do
			Player.Character:PivotTo(workspace.World.Objects.Miscellaneous.LookAtMeImNeverComingDown.CFrame)
		end
		task.wait(7)
		notify("System","The game has regenerated.",7)
		workspace.World.Objects.Miscellaneous.Nuke2Out.Size = Vector3.new(0,0,0)
		task.wait(2)
		ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(false)
		task.wait(6)
		script.Disabled = true
	elseif workspace.GameData.EcoCC.KillSwitches.Value <= 7 and workspace.GameData.EcoCC.ReactorStats.OverloadMix.Value == false and CanFail >= 91 then -- kill switches off, coolant off
		audiosfx.Intercoms.bell:Play()
		task.wait(1.7)
		notify("Shutdown","Disconnecting Reactor from Facility Power",5)
		task.wait(0.5)
		power("Off")
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		task.wait(1.5)
		power("Red")
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		task.wait(2)
		notify("Shutdown","There was a catastrophic failure.",5)
		task.wait(2)
		fade(FourGame.GeneralMusic.EmergencyShutdown.ShutdownPending,"Out")
		task.wait(2)
		game.ServerScriptService.Server.Reactor.ReactorDisasters.ShutdownFailure.Disabled = false
		script.Disabled = true
	elseif workspace.GameData.EcoCC.ReactorStats.OverloadMix.Value == true and workspace.GameData.EcoCC.KillSwitches.Value <= 7 then
		audiosfx.Intercoms.bell:Play()
		task.wait(1)
		notify("Shutdown","Disconnecting Reactor from facility power...",5)
		task.wait(7)
		game.ServerScriptService.Server.Reactor.ReactorDisasters.OverloadMeltdown.Disabled = false
		script.Disabled = true
	elseif workspace.GameData.EcoCC.ReactorStats.OverloadMix.Value == true and workspace.GameData.EcoCC.KillSwitches.Value >= 7 then
		audiosfx.Intercoms.bell:Play()
		task.wait(1)
		notify("Shutdown","Disconnecting Reactor from facility power...",5)
		task.wait(7)
		game.ServerScriptService.Server.Reactor.ReactorDisasters.OverloadMeltdown.Disabled = false
		script.Disabled = true
	else
		audiosfx.Intercoms.bell:Play()
		task.wait(1.7)
		notify("Shutdown","Disconnecting Reactor from Facility Power",5)
		task.wait(0.5)
		power("Off")
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		task.wait(1.5)
		power("Red")
		replicatedstorage.Events.General.WoopShocking:FireAllClients()

		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		task.wait(2)
		notify("Shutdown","There was a catastrophic failure.",5)
		task.wait(2)
		fade(FourGame.GeneralMusic.EmergencyShutdown.ShutdownPending,"Out")
		task.wait(2)
		game.ServerScriptService.Server.Reactor.ReactorDisasters.ShutdownFailure.Disabled = false
		script.Disabled = true
	end
end
