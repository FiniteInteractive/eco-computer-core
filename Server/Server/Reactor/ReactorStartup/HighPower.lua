--[[
High Power Startup
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
local Reactor2 = workspace.World.Objects.Facility.Reactor2.Core
local EcoGame = workspace.GameData.EcoCC
local ReplicatedStorage = game:GetService("ReplicatedStorage")


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
		
	elseif onout == false then

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
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight2.BrickColor = BrickColor.White()
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight3.BrickColor = BrickColor.White()
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.ReactorLight4.BrickColor = BrickColor.White()
	task.wait(0.8)
	audiosfx.LightsPower:Play()
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part1, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Enabled = true
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 10
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 20
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part2, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 40
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part3, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
	task.wait(0.3)
	audiosfx.LightsPower:Play()
	core.Core.Reactor1Primary.CoreL.light.PointLight.Range = 60
	TweenService:Create(core.Core.Reactor1Primary.CoreL.Part4, TweenInfo.new(0.5), {Color = Color3.fromRGB(99, 176, 127)}):Play()
end

function laserson()
	core.Core.Reactor1Primary.Lasers.Model1.laser1.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model1.noooooo.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model8.BOI.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model8.bye.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model2.BUM.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model2.laser.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model3.EEEEE.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model3.selloutalarm.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model4.aaaaa.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model4.noturn.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model5.Which.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model5.thatthing.ParticleEmitter.Enabled = true
	task.wait(0.3)
	core.Core.Reactor1Primary.Lasers.Model6.COCO.ParticleEmitter.Enabled = true
	core.Core.Reactor1Primary.Lasers.Model6.offplz.ParticleEmitter.Enabled = true
	task.wait(0.3)
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
	task.wait(1.5)
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
	TweenService:Create(Reactor2.PWRLaserR2.INDI2, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI3, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine1, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine2, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine5, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine6, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine7, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.LightLine8, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine1, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine2, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine5, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine6, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine7, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.LightLine8, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI3, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI12, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI11, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI4, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI12, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI11, TweenInfo.new(1), {Color = Color3.fromRGB(255, 255, 255)}):Play()
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
	TweenService:Create(Reactor2.PWRLaserR2.INDI9, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI8, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI7, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR2.INDI10, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI9, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI8, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI7, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI6, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI5, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	TweenService:Create(Reactor2.PWRLaserR1.INDI10, TweenInfo.new(1), {Color = Color3.fromRGB(33, 84, 185)}):Play()
	workspace.World.Objects.Miscellaneous.LaserBeamR2_1.ParticleEmitter.Enabled = true
	workspace.World.Objects.Miscellaneous.LaserBeamR2_2.ParticleEmitter.Enabled = true
	TweenService:Create(Reactor2.Core.Part, TweenInfo.new(1.5), {Transparency = 0}):Play()
	TweenService:Create(Reactor2.Core.Part2, TweenInfo.new(1.5), {Transparency = 0}):Play()
end

function coreform()
	TweenService:Create(Reactor2.Core.Main, TweenInfo.new(1.5), {Transparency = 0}):Play()
	Reactor2.Core.Main.RS2:Play()
end



-- Main
replicatedstorage.Events.DisasterClient:FireAllClients(true)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("Announcement: Primary Reactor Control Room has requested Reactor 1 to start.",5)
ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("The primary reactor is preparing to start.",6)
wait(1)
audiosfx.Announcements.StartupLineAutoHighAndLow:Play()
ReplicatedStorage.Events.General.SpeakerEffect:Fire(true)
notify("Primary Reactor Control","High Power Startup primed by "..funkyname.."! The reactor is about to start, please evacuate the core chamber immediately!",9)
task.wait(2)
ReplicatedStorage.Events.General.SpeakerEffect:Fire(false)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blares]",5)
audiosfx.AlarmStartup.AlarmAboutToStart:Play()
wait(3)
audiosfx.AlarmStartup.AlarmAboutToStart:Stop()
music.startmusic("HighPowerStartup")
wait(1.21)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn off]",3)
audiosfx.OutNoPow3:Play()
power("Off")
notify("Power Diverted","The power has been diverted to start the Primary Reactor. Over 250,000 megawatts of power will be divided and given to each Reactor.",6)
wait(2)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1)
-- // BEFORE REACTOR STARTUP //
task.wait(1.95)
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(true)
ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent:FireAllClients("High_StartupCutscene")
wait(0.5)
init()
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",3)
wait(0.85)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.25)
wait(2)
rods(true)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Rods power up]",3)
wait(2.1)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.25)
wait(2.5)
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),1.45)
wait(1.5)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",1.5)
audiosfx.LightsPower:Play()
core.Core.Reactor1Primary.SpinnerReactorForm1.Light.Material = Enum.Material.Neon
core.Core.Reactor1Primary.SpinnerReactorForm1.Light.Color = Color3.fromRGB(110, 153, 202)
wait(0.5)
audiosfx.LightsPower:Play()
core.Core.Reactor1Primary.SpinnerReactorForm2.Light.Material = Enum.Material.Neon
core.Core.Reactor1Primary.SpinnerReactorForm2.Light.Color = Color3.fromRGB(110, 153, 202)
task.wait(1.5)
startlights()
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2.35)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blares]",3)
TweenService:Create(core.Core.Reactor1Primary.Core.Shield, TweenInfo.new(0.5), {Transparency = 0}):Play()
audiosfx.AlarmStartup.AlarmAboutToStart:Play()
laserson()
task.wait(1)
TweenService:Create(core.Core.Reactor1Primary.Core.Shield2, TweenInfo.new(0.5), {Transparency = 0.5}):Play()
ready_corelighton()
audiosfx.LaserCharge:Play()
task.wait(3)
audiosfx.AlarmStartup.AlarmAboutToStart:Stop()
task.wait(1)
core.Core.Reactor1Primary.SpinnerReactor.Disabled = false
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Charging]",3)
wait(0.05)
core.Core.Reactor1Primary.SpinnerReactor2.Disabled = false
task.wait(4.12)
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Ignited]",4)
audiosfx.CoreNowOn_HighOrLow:Play()
TweenService:Create(game.Lighting.Blur, TweenInfo.new(2), {Size = explosionblur.explosion}):Play()
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(255, 255, 255),2.35)
corelights()
laserprime()
coreform()
task.wait(1.35)
audiosfx.ReactorChargeAfterStart:Play()
TweenService:Create(game.Lighting.Blur, TweenInfo.new(5), {Size = explosionblur.normal}):Play()
core.Core.Reactor1Primary.lIGHT.Active.Enabled = true
wait(0.15)
TweenService:Create(core.Core.Reactor1Primary.Core.Main, TweenInfo.new(0.5), {Transparency = 0}):Play()
task.wait(14)
TweenService:Create(Reactor2.Core.Part, TweenInfo.new(1.5), {Transparency = 0}):Play()
task.wait(0.5)
TweenService:Create(Reactor2.Core.Part2, TweenInfo.new(1.5), {Transparency = 0}):Play()
TweenService:Create(Reactor2.Core.Main, TweenInfo.new(1.5), {Transparency = 0}):Play()
audiosfx.LightsPower:Play()
ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Lights turn on]",3)
core.Core.Reactor1Primary.Core.Main.RepelScript.Disabled = false
core.Core.Reactor1Primary.Core.Shield.RepelScript.Disabled = false
core.Core.Reactor1Primary.Core.Shield2.RepelScript.Disabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.offline.Visible = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.online.Visible = true
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Off.Visible = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Frame.Visible = true
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.Visible = true
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Ready.Visible = false
power("On")
task.wait(15.25)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = true
-- // CUTSCENE OVER //
workspace.GameData.EcoCC.ReactorStats.CoreTemp.OfflineBeLike.Disabled = true
ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),2)
ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic:FireAllClients(false)
ReplicatedStorage.RemotesEvents.GuiEvents.AddAchievement:FireAllClients("Startup")
workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Screens.CStat2.Log:Fire("Reactor 1 active")
notify("Reactors Started","The reactors have sucessfully started in the high way!",6)
wait(2)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
wait(0.5)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.CountingUp.Disabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = true
wait(0.5)
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.ScreenStartupModeChooser.SurfaceGui.Idle_Or_ImportantInstruction.dvd_container.CornerHit.Disabled = false
--ReplicatedStorage.RemotesEvents.GuiEvents.AddTipChatEvent:FireAllClients(hints[math.random(1, #hints)])
task.wait(35)
music.endmusic("HighPowerStartup")
workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = false
replicatedstorage.Events.DisasterClient:FireAllClients(false)
workspace.GameData.EcoCC.ReactorStats.IsStartup.Value = false
script.Disabled = true

