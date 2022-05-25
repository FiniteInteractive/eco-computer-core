--[[
Low Power Startup
Eco Computer Core, Backend Script
by gloopyreverb
]]

-- Libraries
self = workspace.GameData.EcoCC
local audiosfx = self.SFX
local facility = workspace.World.Objects.Facility
local importantfacilityarea = facility.ImportantFacilityAreas
local replicatedstorage = game.ReplicatedStorage
local hints = require(replicatedstorage.Lib.Tips)
local music = require(replicatedstorage.Lib.Music)
local TweenService = game:GetService("TweenService")
local notification = require(game.ReplicatedStorage.Modules.NotificationStyle)
local core = importantfacilityarea.PrimaryReactorArea.PrimaryChamber
local startupmodule = require(game.ServerStorage.Modules.Reactor.Startup)
local ctrlroom = importantfacilityarea.PrimaryReactorArea.ControlRoom
local funkyname = self.ReactorStats.UsernameForCutscene.Value
local Players = game:GetService("Players")
local ReplicatedStorage = game.ReplicatedStorage
local EcoGame = workspace.GameData.EcoCC
local Reactor2 = workspace.World.Objects.Facility.Reactor2.Core


-- Functions


local explosionblur = {
	explosion = 28.5;
	normal = 2.5
}

function notify(Title,Text,Icon,TimeWait)
	for _,v in pairs(game.Players:GetPlayers()) do
		notification:Notify(v,"Classic",Title,Text,"Exclamation",TimeWait,"Classic")
	end
end


function rods(onout)
	if onout == true then
		audiosfx.LaserOn:Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod1, TweenInfo.new(0.5), {Color = Color3.fromRGB(130, 203, 255)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod2, TweenInfo.new(0.5), {Color = Color3.fromRGB(130, 203, 255)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod3, TweenInfo.new(0.5), {Color = Color3.fromRGB(130, 203, 255)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod4, TweenInfo.new(0.5), {Color = Color3.fromRGB(130, 203, 255)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.RodMain, TweenInfo.new(0.5), {Color = Color3.fromRGB(130, 203, 255)}):Play()
	elseif onout == false then
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod1, TweenInfo.new(0.5), {Color = Color3.fromRGB(27, 42, 53)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod2, TweenInfo.new(0.5), {Color = Color3.fromRGB(27, 42, 53)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod3, TweenInfo.new(0.5), {Color = Color3.fromRGB(27, 42, 53)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.Rod4, TweenInfo.new(0.5), {Color = Color3.fromRGB(27, 42, 53)}):Play()
		TweenService:Create(core.Core.Reactor1Primary.rods.RodMain, TweenInfo.new(0.5), {Color = Color3.fromRGB(27, 42, 53)}):Play()
	end
end


function power(outon)
	if outon == "On" then
		game.Lighting.Ambient = Color3.fromRGB(61, 61, 71)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(61, 61, 71)
		self.PowerIn:Fire()
	elseif outon == "Off" then
		self.PowerOut:Fire()
		game.Lighting.Ambient = Color3.fromRGB(24, 24, 24)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(24,24,24)
	elseif outon == "Red" then
		self.PowerRed:Fire()
		game.Lighting.Ambient = Color3.fromRGB(16,16,16)
		game.Lighting.OutdoorAmbient = Color3.fromRGB(16,16,16)
	end
end



-- the reactor lights 99, 176, 127

-- // Core Startup Functions // --

function init()
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight1.BrickColor = BrickColor.White()
	wait(2)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight2.BrickColor = BrickColor.White()
	wait(2)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight3.BrickColor = BrickColor.White()
	wait(1)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight4.BrickColor = BrickColor.White()
end

function lighton()
	audiosfx.LightsPower:Play()
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part1, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Enabled = true
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 10
	wait(1)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 20
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part2, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	wait(1)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 40
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part3, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	wait(1)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 60
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part4, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
end


function createshield()

end


function laserson()
	core.Core.Reactor1Primary.Lasers.Model1.laser1.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model1.noooooo.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model8.BOI.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model8.bye.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model2.BUM.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model2.laser.ParticleEmitter.Enabled = true
	wait(1.01)
	core.Core.Reactor1Primary.Lasers.Model3.EEEEE.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model3.selloutalarm.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model4.aaaaa.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model4.noturn.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model5.Which.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model5.thatthing.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model6.COCO.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model6.offplz.ParticleEmitter.Enabled = true
	wait(1)
	core.Core.Reactor1Primary.Lasers.Model7.kthx.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model7.noproblem.ParticleEmitter.Enabled = true
end


function ready_corelighton()
	local CoreL = core.Core.Reactor1Primary.CoreL
	for i = 1,4 do
		TweenService:Create(CoreL["Part"..i], TweenInfo.new(0.5), {Color = Color3.fromRGB(255, 173, 8)}):Play()
	end
	core.Core.Reactor1Primary.SpinnerReactorForm1.Light.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.SpinnerReactorForm2.Light.ParticleEmitter.Enabled = true
	task.wait(2)
	for i = 1,4 do
		TweenService:Create(CoreL["Part"..i], TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	end
end

function startlights()
	local CoreL = core.Core.Reactor1Primary
	for i = 1,10 do
		TweenService:Create(CoreL["Startup"..i], TweenInfo.new(0.5), {Color = Color3.fromRGB(52, 142, 64)}):Play()
	end
end


function corelights()
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Secondary Reactor lights turn on]",3)
	Reactor2.PWRLaserR1.INDI1.Color = Color3.fromRGB(33, 84, 185)
	Reactor2.PWRLaserR1.INDI2.Color = Color3.fromRGB(33, 84, 185)
	Reactor2.PWRLaserR1.INDI3.Color = Color3.fromRGB(33, 84, 185)
	TweenService:Create(Reactor2.PWRLaserR2.INDI1, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	EcoGame.SFX.LightsPower:Play()
	task.wait(1)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI2, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(1)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI3, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(1.9)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine1, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine2, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine5, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine6, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine7, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine8, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(1)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine1, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine2, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine5, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine6, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine7, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine8, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(1)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI12, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI11, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI12, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI11, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	task.wait(0.5)
end

function laserprime()
	TweenService:Create(Reactor2.PWRLaserR1.fuse1, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.fuse2, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.fuse3, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.fuse4, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.fuse5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.fuse6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse1, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse2, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse3, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse4, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.fuse6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	EcoGame.SFX.LaserOn:Play()
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lasers turn on]",3)
	task.wait(2)
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",3)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI9, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(1)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI8, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI7, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI10, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(1.95)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI9, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI8, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI7, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(0.5)
	EcoGame.SFX.LightsPower:Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI10, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	task.wait(1.2)
	notify("Reactor 2 Startup","Activating External Lasers...",2)
	task.wait(1)
	notify("Reactor 2 Startup","1",2)
	task.wait(2)
	notify("Reactor 2 Startup","2",2)
	task.wait(2)
	notify("Reactor 2 Startup","External Laser 1 & 2 ready.",5)
	task.wait(3)
	EcoGame.SFX.LaserCharge.TimePosition = 11.6
	EcoGame.SFX.LaserCharge:Play()
	workspace.World.Objects.Miscellaneous.LaserBeamR2_1.ParticleEmitter.Enabled = true
	task.wait(1.2)
	EcoGame.SFX.LaserCharge.TimePosition = 11.6
	EcoGame.SFX.LaserCharge:Play()
	workspace.World.Objects.Miscellaneous.LaserBeamR2_2.ParticleEmitter.Enabled = true
	task.wait(2.5)
	TweenService:Create(Reactor2.Core.Part, TweenInfo.new(1.5), {Transparency = 0}):Play()
	task.wait(0.5)
	TweenService:Create(Reactor2.Core.Part2, TweenInfo.new(1.5), {Transparency = 0}):Play()
end

function coreform()
	notify("Reactor 2 Startup","Charging...",5)
	task.wait(1.75)
	EcoGame.SFX.LaserCharge_Secondary:Play()
	task.wait(14.72)
	ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(255, 247, 243),2)
	task.wait(0.4)
	TweenService:Create(Reactor2.Core.Main, TweenInfo.new(1.5), {Transparency = 0}):Play()
	Reactor2.Core.Main.RS2:Play()
end

-- Main
replicatedstorage.Events.DisasterClient:FireAllClients(true)
workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = true
replicatedstorage.Events.DisasterClient:FireAllClients(true)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("Announcement: Primary Reactor Control Room has requested Reactor 1 to start.",5)
ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("The primary reactor is preparing to start.",6)
wait(1)
audiosfx.Announcements.StartupLineAutoHighAndLow:Play()
ReplicatedStorage.Events.General.SpeakerEffect:Fire(true)
notify("Primary Reactor Control","Startup primed by "..funkyname.."! The reactor is about to start, please evacuate the core chamber!",9)
wait(4)
ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
music.startmusic("NormalStartup")
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blares]",5)
audiosfx.AlarmStartup.AlarmAboutToStart:Play()
wait(6)
audiosfx.AlarmStartup.AlarmAboutToStart:Stop()
wait(2.21)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn off]",3)
audiosfx.OutNoPow3:Play()
power("Off")
notify("Power Diverted","The power has been diverted to start the Primary Reactor.",6)
wait(8)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2)
-- // BEFORE REACTOR STARTUP //
wait(1.5)
ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("electricalsystemstartuponly",8)
wait(4)
workspace.GameData.EcoCC.PowerEventChamber:Fire("on")
task.wait(3.95)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2)
-- Cutscene stop
wait(8.95)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),6)
wait(6.05)
-- Cutscene
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(true)
ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent:FireAllClients("StartupCutscene")
wait(1)
init()
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",3)
wait(0.85)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.25)
wait(3.2)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.25)
wait(1.5)
lighton()
wait(4.5)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.45)
wait(2.5)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",1.5)
audiosfx.LightsPower:Play()
core.Core.Reactor1Primary.SpinnerReactorForm1.Light.Material = Enum.Material.Neon
core.Core.Reactor1Primary.SpinnerReactorForm1.Light.Color = Color3.fromRGB(110, 153, 202)
wait(0.5)
audiosfx.LightsPower:Play()
core.Core.Reactor1Primary.SpinnerReactorForm2.Light.Material = Enum.Material.Neon
core.Core.Reactor1Primary.SpinnerReactorForm2.Light.Color = Color3.fromRGB(110, 153, 202)
wait(2)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2.35)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blares]",3)
startlights()
TweenService:Create(core.Core.Reactor1Primary.Core.Shield, TweenInfo.new(0.5), {Transparency = 0}):Play()
audiosfx.AlarmStartup.AlarmAboutToStart:Play()
wait(4)
ready_corelighton()
wait(3)
audiosfx.AlarmStartup.AlarmAboutToStart:Stop()
wait(5)
laserson()
wait(1)
TweenService:Create(core.Core.Reactor1Primary.Core.Shield2, TweenInfo.new(0.5), {Transparency = 0.5}):Play()
wait(4)
core.Core.Reactor1Primary.SpinnerReactor.Disabled = false
audiosfx.LaserCharge:Play()
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Charging]",3)
wait(0.05)
core.Core.Reactor1Primary.SpinnerReactor2.Disabled = false
wait(8)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Ignited]",4)
audiosfx.CoreNowOn_HighOrLow:Play()
TweenService:Create(game.Lighting.Blur, TweenInfo.new(2), {Size = explosionblur.explosion}):Play()
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(255, 255, 255),2.35)
wait(1.35)
audiosfx.ReactorChargeAfterStart:Play()
TweenService:Create(game.Lighting.Blur, TweenInfo.new(5), {Size = explosionblur.normal}):Play()
core.Core.Reactor1Primary.lIGHT.Active.Enabled = true
wait(0.15)
TweenService:Create(core.Core.Reactor1Primary.Core.Main, TweenInfo.new(0.5), {Transparency = 0}):Play()
wait(12)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),3)
task.wait(2.98)
-- start reactor 2
corelights()
task.wait(0.5)
laserprime()
task.wait(1)
coreform()
task.wait(6)
core.Core.Reactor1Primary.Core.Main.RepelScript.Disabled = false
core.Core.Reactor1Primary.Core.Shield.RepelScript.Disabled = false
core.Core.Reactor1Primary.Core.Shield2.RepelScript.Disabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.offline.Visible = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.online.Visible = true
audiosfx.LightsPower:Play()
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",3)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Off.Visible = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Frame.Visible = true
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.Visible = true
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Ready.Visible = false
power("On")
task.wait(5)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = true
-- // CUTSCENE OVER //
workspace.GameData.EcoCC.ReactorStats.CoreTemp.OfflineBeLike.Disabled = true
task.wait(5)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2)
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(false)
ReplicatedStorage.RemotesEvents.GuiEvents.AddAchievement:FireAllClients("Startup")
workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Screens.CStat2.Log:Fire("Reactor 1 active")
notify("Reactors Started","The Primary and Secondary Reactor have sucessfully started!",6)
wait(2)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
wait(0.5)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = true
wait(0.5)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
--ReplicatedStorage.RemotesEvents.GuiEvents.AddTipChatEvent:FireAllClients(hints[math.random(1, #hints)])
wait(25)
workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.CountingUp.Disabled = false
replicatedstorage.Events.DisasterClient:FireAllClients(false)
music.endmusic("NormalStartup")
workspace.GameData.EcoCC.ReactorStats.IsStartup.Value = false
script.Disabled = true

