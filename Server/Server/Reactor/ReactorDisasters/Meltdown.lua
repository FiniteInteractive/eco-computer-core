--[[
Meltdown
by gloopyreverb
07/30/2021
]]

-- Libraries

self = workspace.GameData.EcoCC
audiosfx = workspace.GameData.EcoCC.SFX
facility = workspace.World.Objects.Facility
importantfacilityarea = facility.ImportantFacilityAreas
core = importantfacilityarea.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary
local replicatedstorage = game.ReplicatedStorage
notification = require(game.ReplicatedStorage.Modules.NotificationStyle)
funkyname = self.ReactorStats.UsernameForCutscene.Value
TweenService = game:GetService("TweenService")
boom_module = require(game.ServerStorage.Modules.Reactor.BoomModule)
local Jets = workspace.World.Objects.Facility.Jets.jetButtons
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")


--[[
Players can trigger this event if the following criteria is met:
-  primary reactor core temperature is over 3260ºC
]]

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

function jets(ifon)
	if ifon == "Available" then
		for i = 1,6 do
			Jets["Jet"..i.."Button"].Button.Button.ProximityPrompt.Enabled = true
		end
	elseif ifon == "StopAvailable" then
		for i = 1,6 do
			Jets["Jet"..i.."Button"].Button.Button.ProximityPrompt.Enabled = false
		end
	end
end

function RedLights()
	local CoreL = core
	for i = 1,10 do
		TweenService:Create(CoreL["Startup"..i], TweenInfo.new(0.5), {Color = Color3.fromRGB(252, 65, 72)}):Play()
	end
end


function meltdownending()
	if workspace.GameData.EcoCC.ReactorStats.ShutD.Value == false then
		fade(workspace.GameData.EcoCC.GeneralMusic.EndingMusic.BothOverloadAndMeltdown,"In")
		game.ReplicatedStorage.Components.Maps.Destroyed_PrimaryReactorArea:Clone().Parent = workspace
		game.ReplicatedStorage.Components.Maps.Destroyed_MainHallway:Clone().Parent = workspace
		task.wait(45)
		workspace.Destroyed_MainHallway:Destroy()
		workspace.Destroyed_PrimaryReactorArea:Destroy()
		fade(workspace.GameData.EcoCC.GeneralMusic.EndingMusic.BothOverloadAndMeltdown,"Out")
		task.wait(2)
		notify("System","The game is regenerating...",7)
		for _,Player in pairs(game.Players:GetPlayers()) do
			Player.Character:PivotTo(workspace.World.Objects.LookAtMeImNeverComingDown.CFrame)
		end
		task.wait(7)
		ReplicatedStorage.RemotesEvents.GuiEvents.AddAchievement:FireAllClients("Exploded")
		notify("System","The game has regenerated.",7)
		self.PowerEventChamber:Fire("on")
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
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Static.Enabled = true
		wait(0.6)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Static.Enabled = false
	elseif area == "Lobby_Top" then

	elseif area == "Lobby_MainHallWallToCafe" then
		game.ServerStorage.Misc.Wall:Clone().Parent = workspace.World.Objects.Facility.Debris
	elseif area == "ControlRoom_Roof" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
		task.wait(5.5)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
	elseif area == "AllDown" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.EmergencyMode.Disabled = true
		importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.SoundPart.AlarmSound:Stop()
	end
end

function switches()
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchA.Main.Script.Disabled = false
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchB.Main.WaitAMoment.Disabled = false
end

function ready()
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchB.Main.WaitAMoment.Disabled = true
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchB.Second.BrickColor = BrickColor.new("Really red")
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchB.Main.Script.Disabled = false
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Interactables.Switches.KSwitchB.Main.ClickDetector.MaxActivationDistance = 15
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
function explosionNOW()
	if game.ServerScriptService.Server.Reactor.ReactorEvents.ShutdownSystem.Disabled == true or game.ServerScriptService.Server.Reactor.ReactorEvents.ReactorDisasters.ShutdownFailure.Disabled == true then
		boom_module.Boom()
		task.wait(boom_module.delay)
		replicatedstorage.Events.General.Regen:Fire() -- note that regeneration is a --14 second process-- 
		task.wait(2)
		if self:WaitForChild("ReactorStats",16).ShutD.Value == false then
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

function flicker()
	task.wait(0.25)
	power("On")
	task.wait(0.25)
	power("Off")
	task.wait(0.25)
	power("On")
	task.wait(0.25)
	power("Off")
	task.wait(0.25)
	power("On")
	task.wait(0.25)
	power("On")
	task.wait(0.25)
	power("Off")
end

-- Main
-- intercom option off	
if self.ReactorStats.ShutD.Value == false then
	CollectionService:RemoveTag(workspace.World.NPCs.WanderAreas.ParkWanderArea, "pathfindable")
	CollectionService:RemoveTag(workspace.World.NPCs.WanderAreas.FacilityEntranceWanderArea, "pathfindable")
	CollectionService:RemoveTag(workspace.World.NPCs.WanderAreas.ParkingLotWanderArea, "pathfindable")
	workspace.GameData.EcoCC.ReactorStats.FlickerStats:Fire("Meltdown")
	workspace.GameData.EcoCC.ReactorStats.NewPlayerState.Value = true
	self.ReactorStats.IsDisaster.Value = true
	task.wait(3)
	self.ReactorStats.IsShutdownAvailable.Value = true
	workspace.GameData.EcoCC.ReactorStats.CoreTemp.CrazeTemp.Disabled = false
	self.SFX.Intercoms.bell:Play()
	task.wait(1.8)
	self.SFX.Intercoms.Overheating:Play()
	replicatedstorage.Events.General.Intercom:Fire(false)
	core.lIGHT.NearMelt.Enabled = true
	switches()
	core.lIGHT.Fire_Dust.Enabled = true
	replicatedstorage.Events.DisasterClient:FireAllClients(true)
	ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("Attention! The reactor needs to be cooled down!",7)
	wait(10)
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Title.Visible = true
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.CANNOTUse.Visible = false
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Instruct.Visible = true
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Frame.Visible = true
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.KeyClick.ProximityPrompt.Enabled = true
	local ma = math.random(1,3)
	if ma == 1 then
		replicatedstorage.Components.Tools.Key:Clone().Parent = workspace.World.Keys
	end
	power("Off")
	audiosfx.OutNoPow3:Play()
	wait(0.5)
	power("On")
	audiosfx.PowerOn:Play()
	wait(0.5)
	jets("Available")
	replicatedstorage.Events.General.ContinousShake:FireAllClients()
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.majorExplosion:Play()
	workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Screens.CStat2.Log:Fire("Reactor 1 malfunction")
	core.lIGHT.Active.Color = ColorSequence.new(Color3.fromRGB(216, 141, 56))
	wait(1)
	power("Off")
	fade(self.SFX.Alarms.AlarmBlur,"In")
	audiosfx.OutNoPow3:Play()
	task.wait(14)
	facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.EvacSigns.UnsafeLoop.Disabled = false
	audiosfx.Alarms.WarningAboutTo:Play()
	wait(2)
	power("On")
	self.SFX.Intercoms.bell:Play()
	task.wait(1.8)
	audiosfx.Announcements.CodeYellow:Play()
	task.wait(4)
	fade(self.SFX.Alarms.AlarmBlur,"Out")
	notify("Code Yellow","Warning! A code yellow has been issued! If you're not working on the reactor, please evacuate the area.",6)
	task.wait(33)
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("Music plays",6)
	fade(self.GeneralMusic.Meltdown.Meltdown_Detected,"In")
	audiosfx.Alarms.WarningAboutTo:Play()
	wait(0.5)
	fade(self.SFX.OccasionalMeltdownAmbience,"In")
	audiosfx.Alarms.WarningAboutTo:Stop()
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.BlewItOut:Play()
	audiosfx.OutNoPow3:Play()
	power("Off")
	wait(9)
	audiosfx.PreMeltAlarm:Play()
	wait(19.2)
	audiosfx.ExplosionSoundEffects.majorExplosion:Play()
	audiosfx.Rumbling:Play()
	notify("Shield Broken","Primary Reactor Shield BROKEN!",6)
	ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("MeltdownHappening")
	ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.Nuke:Fire("ShieldBroken")
	audiosfx.ExplosionSoundEffects.ShieldFail.Explo1:Play()
	audiosfx.ExplosionSoundEffects.ShieldFail.Explo2:Play()
	TweenService:Create(game.Lighting.client, TweenInfo.new(0.01), {Brightness = 0.85}):Play()
	audiosfx.ExplosionSoundEffects.SparkExp:Play()
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	RedLights()
	importantfacilityarea.PrimaryReactorArea.GlassBreak.BreakingHandler.Disabled = false
	wait(0.5)
	TweenService:Create(game.Lighting.client, TweenInfo.new(2), {Brightness = 0}):Play()
	audiosfx.Alarms.RepeatingWRREEE:Play()
	wait(1)
	audiosfx.PowerOn:Play()
	power("On")
	wait(0.5)
	audiosfx.OutNoPow3:Play()
	power("Off")
	wait(0.5)
	audiosfx.PowerOn:Play()
	power("On")
	wait(1)
	audiosfx.Announcements.PleasePrep:Play()
	audiosfx.PowerOn:Play()
	power("On")
	wait(0.5)
	audiosfx.OutNoPow3:Play()
	wait(7)
	core.lIGHT.Alarm:Play()
	wait(6)
	fade(self.GeneralMusic.Meltdown.Meltdown_Detected,"Out")
	self.GeneralMusic.Meltdown.StingerToPartA:Play()
	flicker()
	flicker()
	flicker()
	flicker()
	core.lIGHT.Alarm:Stop()
	task.wait(0.5)
	fade(self.SFX.OccasionalMeltdownAmbience,"Out")
	ready()
	self.SFX.Intercoms.bell:Play()
	task.wait(5.5)
	workspace.World.Objects.Miscellaneous["old.Workspace"].OreExperimentBillboard.OvrLoadSuggestion.Enabled = true
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
	self.SFX.Alarms.MeltdownDramatic.Alarm1:Play()
	power("Off")
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Enabled = false
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
	task.wait(5)
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("Danger, Reactor Meltdown. Evacuate at once.",5)
	self.SFX.Announcements.DReactorMeltdown:Play()
	task.wait(2)
	power("On")
	task.wait(3.45)
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("'INCOMING PHOTON BEAM' by EGGPRIEST plays",6)
	fade(self.GeneralMusic.Meltdown.MeltdownPartA,"In")
	wait(6)
	audiosfx.PreMeltAlarm:Play()
	wait(4)
	audiosfx.Doom2atmospheric:Play()
	importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.UnsafeLoop.Disabled = true
	audiosfx.Alarms.AlarmCodeRedWarning:Play()
	wait(1)
	importantfacilityarea.PrimaryReactorArea.ControlRoom.EvacSigns.EmergencyMode.Disabled = false
	notify("Code Red","Attention! A code red has been issued by management. Please shut off the reactor or evacuate immediately!",6)
	task.wait(1.5)
	self.SFX.Intercoms.bell:Play()
	task.wait(1.8)
	audiosfx.Intercoms.ThreatLevelCodeRed:Play()
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("Attention, all personell. This is now a Code Red. All personell that is not working on the reactor needs to evacuate immediately. The reactor is now in a dangerous condition. We will open the Emergency Jets shortly. Again, this is a Code Red.",9)
	task.wait(3.5)
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.online.Visible = false
	audiosfx.OutNoPow3:Play()
	power("Off")
	audiosfx.Alarms.UrgentWarning:Play()
	task.wait(5)
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.EntranceScreen.SurfaceGui.meltdown.Visible = true
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.BlewItOut:Play()
	task.wait(2)
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
	debris("Transit")
	wait(2.3)
	debris("ControlRoom_Roof")
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.MajorCollapse:Play()
	audiosfx.OutNoPow3:Play()
	power("Red")
	wait(1.49)
	audiosfx.Announcements.MeltdownLines:Play()
	ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("Attention! An ED-1x protocol has been activated. This facility is estimated to detonate in 7 minutes! Please evacuate immediately!",6)
	wait(0.3)
	audiosfx.Alarms.AmbienceAlarm2:Play()
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	fade(self.SFX.Alarms.MeltdownDramatic.Alarm1,"Out")
	audiosfx.ExplosionSoundEffects.BlewItOut:Play()
	notify("Detonation","The facility is estimated to detonate in 7 minutes.",6)
	wait(5)
	debris("MainHallWallToCafe")
	wait(0.1)
	debris("screen_static")
	wait(0.4)
	debris("screen_static")
	importantfacilityarea.PrimaryReactorArea.ControlRoom.BorderOfCellsScreen.BillboardGui.Enabled = true
	ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("Evacuate to Evacuation Bunker, or Outside if you don't have a choice!",10)
	wait(15)
	audiosfx.Alarms.NuclearSiren:Play()
	wait(5)
	audiosfx.Announcements.MeltdownLines:Stop()
	wait(40)
	audiosfx.Alarms.MeltdownDramatic.Alarm2:Play()
	replicatedstorage.Events.General.WoopShocking:FireAllClients()
	audiosfx.ExplosionSoundEffects.BlewItOut:Play()
	game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
	wait(25)
	importantfacilityarea.PrimaryReactorArea.ControlRoom.Bunker.BillboardGui.Enabled = true
	shockwave()
	task.wait(10)
	local ma = math.random(1,2)
	if ma == 2 then
		if workspace.World.Keys:FindFirstChild("Key") == nil then
			replicatedstorage.Components.Tools.Key:Clone().Parent = workspace.World.Keys
		end
	end
	task.wait(5)
	notify("Detonation","An estimated detonation countdown timer will now start. Evacuate now!",6)
	audiosfx.Alarms.KlaxonAlarm_CountdownStarted_or_Last130Sec:Play()
	audiosfx.Alarms.MeltdownDramatic.Alarm4:Play()
	task.wait(4.95)
	fade(audiosfx.Alarms.MeltdownDramatic.Alarm4,"Out")
	task.wait(4.8)
	ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarms blaring]",9)
	ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController:FireAllClients("Countdown",true)
	for z = 408,0,-1 do
		if game.ServerScriptService.Server.Reactor.ReactorEvents.ShutdownSystem.Disabled == false or game.ServerScriptService.Server.Reactor.ReactorDisasters.ShutdownFailure.Disabled == false then
			task.wait(0.5)
			script.Disabled = true
			break
		end
		ReplicatedStorage.RemotesEvents.GuiEvents.CountdownText:FireAllClients(z)
		if z == 385 then
			fade(self.SFX.OccasionalMeltdownAmbience,"In")
			debris("screen_static")
		end
		if z == 380 then
			power("Off")
			fade(self.SFX.OccasionalMeltdownAmbience,"Out")
		end
		if z == 370 then
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Explosion]",3)
			-- after this point, intercom options are now on for players
			replicatedstorage.Events.General.Intercom:Fire(true)
			debris("cave")
			audiosfx.ExplosionSoundEffects.Explosion:Play()
			audiosfx.PowerOn:Play()
			power("On")
			wait(0.2)
			audiosfx.OutNoPow3:Play()
			power("Off")
			wait(0.3)
			audiosfx.PowerOn:Play()
			power("On")
		end
		if z == 365 then
			if workspace.World.Keys:FindFirstChild("Key") == nil then
				replicatedstorage.Components.Tools.Key:Clone().Parent = workspace.World.Keys
			end
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarms blaring]",15)
		end
		if z == 340 then
			shockwave()
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Shockwave]",5)
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("'Half Life Alyx: Credits' plays",12)
			self.GeneralMusic.Meltdown.MeltdownPartB:Play()
		end
		if z == 320 then
			importantfacilityarea.PrimaryReactorArea.PrimaryChamber.ThatsChamberDebris.debris.Enabled = true
			audiosfx.Alarms.AmbienceAlarm2:Play()
			workspace.World.Objects.Miscellaneous["old.Workspace"].OreExperimentBillboard.OvrLoadSuggestion.Enabled = false
			debris("pipe_breakmainhall")
			debris("pipe_breakcargo")
		end
		if z == 300 then
			importantfacilityarea.PrimaryReactorArea.PrimaryChamber.ThatsChamberDebris.debris.Enabled = false
		end
		if z == 280 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Major explosion]",7)
			replicatedstorage.Events.General.WoopShocking:FireAllClients()
			audiosfx.Alarms.NuclearSiren:Play()
			audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
			workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Glassisbreak.Anchored = false
			wait(0.01)
			local e = Instance.new("Explosion")
			e.Parent = game.Workspace
			e.Position = workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Glassisbreak.Position
			e.BlastRadius = 20
			e.BlastPressure = 150
			e.ExplosionType = Enum.ExplosionType.NoCraters
		end
		if z == 271 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Sparking]",7)
			ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus:FireAllClients("30,000 megawatts of power has been transferred to the evacuation bunker.",6)
		end
		if z == 259 then 
			shockwave()
		end
		if z == 270 then
			audiosfx.Alarms.MeltdownDramatic.Alarm2:Play()
			shockwave()
			audiosfx.ExplosionSoundEffects.SparkExp:Play()
			power("On")
		end
		if z == 269 then
			audiosfx.PowerOn:Play()
			power("On")
			wait(0.2)
			audiosfx.OutNoPow3:Play()
			power("Off")
			wait(0.3)
			audiosfx.PowerOn:Play()
			power("On")
		end
		if z == 268 then
			debris("reactorwindow1/2")
		end
		if z == 252 then
			audiosfx.ExplosionSoundEffects.BlewItOut:Play()
			ReplicatedStorage.RemotesEvents.GameEvents.FireSpreadEvent:Fire("CargoBay")
		end
		if z == 243 then
			notify("Fire","Fire has been detected at Cargo Bay! Extingush on sight!",8)
			workspace.GameData.EcoCC.ReactorStats.FireAlarmEx.Value = true
		end
		if z == 240 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.BorderOfCellsScreen.BillboardGui.Enabled = false
			notify("Shutdown","The shutdown sequence will expire in 25 seconds! You are requested to shut off the reactor immediately!",8)
		end
		if z == 230 then
			audiosfx.Alarms.MeltdownDramatic.Alarm2:Stop()
			fade(self.SFX.OccasionalMeltdownAmbience,"In")
			audiosfx.OutNoPow3:Play()
			power("Off")
		end
		if z == 220 then
			replicatedstorage.Events.General.WoopShocking:FireAllClients()
			audiosfx.ExplosionSoundEffects.BlewItOut:Play()
			game.ServerStorage.Misc.RegenModules.debris_roof_ctrl:Clone().Parent = workspace.World.Objects.Facility.Debris
			debris("screen_static")
		end
		if z == 215 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
			self.ReactorStats.IsShutdownAvailable.Value = false
			self.ReactorStats.ShutdownProbability.Value = 0
			facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Title.Visible = false
			facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.CANNOTUse.Visible = false
			facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Instruct.Visible = false
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Unusable.Visible = true
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Shutdown.ShutdownScreen.SurfaceGui.Frame.Visible = false
			audiosfx.Announcements.MeltdownLines.TimePosition = announcement_timepos.expired
			audiosfx.Announcements.MeltdownLines:Play()
			notify("Shutdown Expired","The shutdown sequence has expired. All personell, please evacuate to the Emergency Bunker or Outside. You have 3 minutes!",8)
		end
		if z == 210 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
		end
		if z == 205 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
			audiosfx.ExplosionSoundEffects.Explosion:Play()
			replicatedstorage.Events.General.WoopShocking:FireAllClients()

			unanchor2(core.Lasers.Model1)
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
		if z == 195 then
			audiosfx.ExplosionSoundEffects.Explosion:Play()
			unanchor2(core.Lasers.Model3)
		end
		if z == 180 then
			debris("glitchscreen")
		end
		if z == 140 then
			audiosfx.Alarms.IsoAlarm_CountFor140Only:Play()
		end
		if z == 132 then
			fade(self.GeneralMusic.Meltdown.MeltdownPartB,"Out")
		end
		if z == 131 then
			fade(self.SFX.OccasionalMeltdownAmbience,"In")
			audiosfx.PowerOn:Play()
			power("On")
			wait(0.2)
			audiosfx.OutNoPow3:Play()
			power("Off")
			fade(self.GeneralMusic.Meltdown.MeltdownPartC,"In")
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("'Trauma' plays",6)
		end
		if z == 130 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Bunker.BillboardGui.Enabled = false
			debris("glitchscreen")
			audiosfx.Alarms.KlaxonAlarm_CountdownStarted_or_Last130Sec:Play()
		end
		if z == 120 then
			audiosfx.Alarms.AmbienceAlarm2:Stop()
			fade(self.SFX.OccasionalMeltdownAmbience,"Out")
			notify("Two Minutes","You have 2 minutes left until the facility detonates!",8)
			audiosfx.Alarms.NuclearSiren:Play()
			audiosfx.Alarms.AlarmTwoMin:Play()
			audiosfx.Rumbling:Play()
		end
		if z == 109 then
			self.PowerEventChamber:Fire("red")
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Explosion]",7)
			audiosfx.ExplosionSoundEffects.BlewItOutFast:Play()
			audiosfx.ExplosionSoundEffects.Explosion:Play()
			replicatedstorage.Events.General.WoopShocking:FireAllClients()
			replicatedstorage.Events.General.WoopShocking:FireAllClients()
			unanchor2(core.SpinnerReactorForm1)
			unanchor2(core.SpinnerReactorForm2)
			unanchor2(core.Lasers.Model2)
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
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
			workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.leak.Enabled = true
			workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.Leak:Play()
		end
		if z == 89 then
			audiosfx.ExplosionSoundEffects.Rumble:Play()
		end
		if z == 88 then
			audiosfx.OutNoPow3:Play()
			power("Off")
			task.wait(0.5)
			audiosfx.PowerOn:Play()
			power("Red")
		end
		if z == 87 then
			fade(self.SFX.OccasionalMeltdownAmbience,"Out")
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
		if z == 61 then
			audiosfx.ExplosionSoundEffects.BlewItOut:Play()
			replicatedstorage.Events.General.WoopShocking:FireAllClients()
		end
		if z == 40 then
			TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Close.CFrame}):Play()
			workspace.LockdownItsLockingIndicator.Alarm:Play()
			unanchor2(workspace.World.Objects.Facility.ImportantFacilityAreas.PrimaryReactorArea.PrimaryChamber.ThermalUnits.THERMAL_U_B)
			replicatedstorage.Events.General.WoopShocking:FireAllClients()

			audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		end
		if z == 36 then
			fade(self.SFX.OccasionalMeltdownAmbience,"In")
			audiosfx.Rumbling:Play()
		end
		if z == 34 then
			audiosfx.ExplosionSoundEffects.majorExplosion:Play()
			audiosfx.ExplosionSoundEffects.SparkExp:Play()
			audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
			replicatedstorage.Events.General.WoopShocking:FireAllClients()

			local e = Instance.new("Explosion")
			e.Parent = game.Workspace
			e.Position = workspace.World.Objects.Facility.Connector.SoundPart.Position
			unanchor2(workspace.World.Objects.Facility.Connector)
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
			audiosfx.Alarms.MeltdownDramatic.Alarm3:Play()
			workspace.LockdownItsLockingIndicator.Alarm:Stop()
			fade(self.SFX.OccasionalMeltdownAmbience,"Out")
			ReplicatedStorage.RemotesEvents.GameEvents.Bunker:Fire("Close")
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("[Alarm blaring]",7)
			audiosfx.Alarms.AlarmWootWootDuhh:Play()
			notify("Bunker","The bunker is now closing!",8)
		end
		if z == 25 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.NearMeltdownAlarm:Play()
			audiosfx.Alarms.NuclearSiren:Play()
			ReplicatedStorage.RemotesEvents.GuiEvents.Captions:FireAllClients("'The Final Countdown Remix' plays",6)
			fade(self.GeneralMusic.Meltdown.Meltdown_Ending, "In")
		end
		if z == 20 then
			fade(audiosfx.Alarms.MeltdownDramatic.Alarm3, "Out")
		end
		if z == 18 then
			audiosfx.Alarms.AmbienceAlarm:Stop()
			audiosfx.Alarms.MeltdownDramatic.Alarm1:Stop()
			audiosfx.Alarms.MeltdownDramatic.Alarm2:Stop()
			audiosfx.Alarms.AmbienceAlarm2:Stop()
			audiosfx.Alarms.IsoAlarm_CountFor140Only:Stop()
			audiosfx.Alarms.RepeatingWRREEE:Stop()
			audiosfx.Alarms.NearDestruction:Stop()
			audiosfx.ExplosionSoundEffects.SparkExp:Play()
			audiosfx.Rumbling:Play()
		end
		if z == 5 then
			debris("AllDown")
			jets("StopAvailable")
			self.PowerEventChamber:Fire("off")
		end
		if z == 3 then
			importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
			importantfacilityarea.PrimaryReactorArea.PrimaryChamber.ThatsChamberDebris.debris.Enabled = true
			audiosfx.ExplosionSoundEffects.Rumble:Play()
		end
		task.wait(1)
	end
	audiosfx.Doom2atmospheric:Stop()
	explosionNOW()
	workspace.World.Objects.Miscellaneous.Nuke2Out.Size = Vector3.new(0,0,0)
	TweenService:Create(workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Main, TweenInfo.new(20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = workspace.World.Objects.Miscellaneous.LockdownDoorCtrl.Open.CFrame}):Play()

	-- What exploded and needs to regenerate?
--[[ 
Roof debris
bridge collapse
The entire core
Control room (includes controls; evacuation sign)
bunker
Jets
--]]
end
