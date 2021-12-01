--[[
Meltdown
FCC V7, Script
by gloopyreverb
]]


-- TODO 
--Regeneration; debris and bunker handling

-- Libraries
local Event = game.ReplicatedStorage.NotificationCards.RemoteEvent;


self = workspace.FourCC
audiosfx = workspace.FourCC.SFX
facility = workspace.Facility
importantfacilityarea = facility.ImportantFacilityAreas
core = importantfacilityarea.PrimaryReactorArea.PrimaryChamber.Core.Reactor1Primary
replicatedstorage = game.ReplicatedStorage
funkyname = self.ReactorStats.UsernameForCutscene.Value
TweenService = game:GetService("TweenService")


-- Functions


local announcement_timepos = {
	expired = 76;
	starting = 0;	
	startingend = 30;
}

function notify(bodytitle,icon,title,text,dur,sound,color)
	Event:FireAllClients(bodytitle, {
		Name = icon;
		Title = title;
		Body = text;
		Sound = sound;
		Lifetime = dur;
		Color = color
	});

end

function shockwave()
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
		wait(0.6)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
	elseif area == "Lobby_Top" then
		
	elseif area == "Lobby_MainHallWallToCafe" then
		game.ServerStorage.Wall:Clone().Parent = workspace
	elseif area == "ControlRoom_Roof" then
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = true
		wait(1.5)
		importantfacilityarea.PrimaryReactorArea.ControlRoom.Roof_control.debris.Enabled = false
	end
end

audiosfx.Announcements.CodeYellow.Played:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(true)
end)

audiosfx.Announcements.CodeYellow.Stopped:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.CodeYellow.Ended:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.MeltdownLines.Played:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(true)
end)

audiosfx.Announcements.MeltdownLines.Stopped:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(false)
end)

audiosfx.Announcements.MeltdownLines.Ended:Connect(function()
	replicatedstorage.Events.SpeakerEffect:Fire(false)
end)

-- Main
-- intercom option off	
replicatedstorage.Events.Intercom:Fire(false)
core.lIGHT.NearMelt.Enabled = true
core.lIGHT.Fire_Dust.Enabled = true
replicatedstorage.Events.DisasterClient:FireAllClients(true)
replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("Attention! The reactor needs to be cooled down!",7)
wait(10)
power("Off")
audiosfx.OutNoPow3:Play()
wait(0.5)
power("On")
audiosfx.PowerOn:Play()
wait(0.5)
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.majorExplosion:Play()
wait(1)
power("Off")
audiosfx.OutNoPow3:Play()
wait(5)
audiosfx.Alarms.WarningAboutTo:Play()
wait(2)
audiosfx.Announcements.CodeYellow:Play()
power("On")
facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.EvacSigns.EmergencyMode.Disabled = false
notify("Notify","Info","Code Yellow","Attention! A Code Yellow 1-c has been issued.",7)
wait(33)
fade(self.GeneralMusic.Meltdown.Meltdown_Detected,"In")
audiosfx.Alarms.WarningAboutTo:Play()
wait(0.5)
audiosfx.Alarms.WarningAboutTo:Stop()
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.BlewItOut:Play()
audiosfx.OutNoPow3:Play()
power("Off")
wait(9)
audiosfx.PreMeltAlarm:Play()
notify("Notify","Info","Code Yellow","Attempting to vent Reactor using cooling modules...",7)
wait(19.2)
audiosfx.ExplosionSoundEffects.majorExplosion:Play()
audiosfx.Rumbling:Play()
audiosfx.ExplosionSoundEffects.SparkExp:Play()
replicatedstorage.Events.ContinousShake:FireAllClients()
replicatedstorage.Events.WoopShocking:FireAllClients()
wait(0.5)
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
audiosfx.PowerOn:Play()
power("On")
wait(0.5)
audiosfx.OutNoPow3:Play()
power("Off")
wait(0.5)
audiosfx.PowerOn:Play()
power("On")
wait(0.3)
audiosfx.PowerOn:Play()
power("On")
wait(0.5)
audiosfx.OutNoPow3:Play()
power("Off")
wait(0.5)
audiosfx.PowerOn:Play()
power("On")
wait(0.3)
audiosfx.PowerOn:Play()
power("On")
wait(0.5)
audiosfx.OutNoPow3:Play()
power("Off")
wait(0.5)
audiosfx.PowerOn:Play()
power("On")
wait(4)
core.lIGHT.Alarm:Play()
replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("Reactor venting cool failure!",7)
wait(4)
core.lIGHT.Alarm:Stop()
wait(8)
fade(self.GeneralMusic.Meltdown.Meltdown_Detected,"Out")
audiosfx.Announcements.PleasePrep:Play()
wait(2)
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Status.Enabled = false
importantfacilityarea.PrimaryReactorArea.ControlRoom.Screens.CStat2.Meltdown.Enabled = true
wait(3)
core.lIGHT.Active.Color = ColorSequence.new(Color3.fromRGB(216, 141, 56))
fade(self.GeneralMusic.Meltdown.MeltdownPartA,"In")
wait(6)
audiosfx.PreMeltAlarm:Play()
wait(4)
audiosfx.Doom2atmospheric:Play()
audiosfx.Alarms.AlarmCodeRedWarning:Play()
wait(1)
notify("Notify","Info","Code Red","Attention! A Code Red has been issued by facility management higher-ups. Please use Reactor Shutoff methods or evacuate immediately.",8)
replicatedstorage.GUIEvents.Captions:FireAllClients("Attention, all personell. This is now a Code Red. All personell that is not working on the reactor needs to evacuate immediately. The reactor is now in a dangerous condition. We will open the Emergency Jets shortly. Again, this is a Code Red.",9)
wait(3.5)
audiosfx.OutNoPow3:Play()
power("Off")
audiosfx.Alarms.UrgentWarning:Play()
wait(5)
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.BlewItOut:Play()
wait(2)
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
debris("Transit")
wait(2.3)
debris("ControlRoom_Roof")
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.MajorCollapse:Play()
audiosfx.OutNoPow3:Play()
power("Red")
wait(1.49)
audiosfx.Announcements.MeltdownLines:Play()
replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("Attention! An ED-1x protocol has been activated. This facility is estimated to detonate in 7 minutes! Please evacuate immediately!",6)
wait(0.3)
audiosfx.Alarms.AmbienceAlarm2:Play()
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.BlewItOut:Play()
notify("Notify","Info","Detonation","The facility is estimated to detonate in 7 minutes!",5,Color3.fromRGB(104, 14, 50))
wait(5)
debris("MainHallWallToCafe")
wait(0.1)
debris("screen_static")
wait(0.4)
debris("screen_static")
wait(15)
audiosfx.Alarms.NuclearSiren:Play()
wait(20)
notify("Notify","Info","Detonation","Please evacuate immediately!",5,Color3.fromRGB(104, 14, 50))
wait(30)
replicatedstorage.Events.WoopShocking:FireAllClients()
audiosfx.ExplosionSoundEffects.BlewItOut:Play()
game.ServerStorage.RegenModules.debris_roof_ctrl:Clone().Parent = workspace
wait(25)
shockwave()
wait(7)
audiosfx.Alarms.KlaxonAlarm_CountdownStarted_or_Last130Sec:Play()
notify("Notify","Info","Detonation","The estimated detonation time will be displayed. You have 6 more minutes to get to the bunker or Emergency Jets",15,Color3.fromRGB(104, 14, 50))
wait(10)
replicatedstorage.GUIEvents.UIControllerOthers:FireAllClients("Countdown",true)
for z = 408,0,-1 do
	replicatedstorage.GUIEvents.CountdownText:FireAllClients(z)
	if z == 390 then
		fade(self.GeneralMusic.Meltdown.MeltdownPartB ,"In")
	end
	if z == 385 then
		debris("screen_static")
	end
	if z == 380 then
		power("Off")
		replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("Attention! The turbines have now malfunctioned!!",6)
	end
	if z == 370 then
		-- after this point, intercom options are now on for players
		replicatedstorage.Events.Intercom:Fire(true)
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
	if z == 340 then
		shockwave()
	end
	if z == 320 then
		--pipes are leaking; pipe leak at storage, main hallway and such
		debris("pipe_breakmainhall")
		debris("pipe_breakcargo")
	end
	if z == 280 then
		audiosfx.Alarms.NuclearSiren:Play()
		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
		workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Glassisbreak.Anchored = false
		wait(0.01)
		local e = Instance.new("Explosion")
		e.Parent = game.Workspace
		e.Position = workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Glassisbreak.Position
		e.BlastRadius = 15
		e.BlastPressure = 15
		e.ExplosionType = Enum.ExplosionType.NoCraters
	end
	if z == 271 then
		replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("30,000 megawatts of power has been transferred to the evacuation bunker.",6)
	end
	if z == 270 then
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
	if z == 267 then
		replicatedstorage.GUIEvents.AddFacilityStatus:FireAllClients("Attention! Reactor window destroyed. Locking off further chamber access.",6)
	end
	if z == 252 then
		debris("cargofire")
	end
	if z == 243 then
		notify("Notify","Info","Fire","Attention! Fire at Cargo Bay! Extingush fire on sight!",6)
		workspace.FourCC.ReactorStats.FireAlarmEx.Value = true
	end
	if z == 240 then
		notify("Notify","Info","Shutdown","Reactor Shutoff will expire in 25 seconds. Please initate the sequence immediately!",9)
	end
	if z == 230 then
		audiosfx.OutNoPow3:Play()
		power("Off")
	end
	if z == 220 then
		replicatedstorage.Events.WoopShocking:FireAllClients()
		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.RegenModules.debris_roof_ctrl:Clone().Parent = workspace
		debris("screen_static")
	end
	if z == 215 then
		audiosfx.Announcements.MeltdownLines.TimePosition = announcement_timepos.expired
		audiosfx.Announcements.MeltdownLines:Play()
		notify("Notify","Info","Shutdown Expired","The shutdown protocol has expired! All personell, you have 3 minutes to get to the bunker or Emergency Jets.",10)
	end
	if z == 205 then
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		replicatedstorage.Events.WoopShocking:FireAllClients()		
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
		fade(self.GeneralMusic.Meltdown.MeltdownPartC,"In")
	end
	if z == 130 then
		debris("glitchscreen")
		audiosfx.Alarms.KlaxonAlarm_CountdownStarted_or_Last130Sec:Play()
	end
	if z == 120 then
		audiosfx.Alarms.NuclearSiren:Play()
		audiosfx.Rumbling:Play()
	end
	if z == 109 then
		audiosfx.ExplosionSoundEffects.BlewItOutFast:Play()
		audiosfx.ExplosionSoundEffects.Explosion:Play()
		replicatedstorage.Events.WoopShocking:FireAllClients()		
		replicatedstorage.Events.WoopShocking:FireAllClients()
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
		unanchor2(workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.StairsGonExplode)
		-- epic explosion debris, explosion on reactor window 3 and 4; various things in facility 
		--and outside start exploding, and the supports to the reactor destroy part of the control 
		--room along with the glass at the bottom of the reactor.
	end
	if z == 90 then
		workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.leak.Enabled = true
		workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.VentLeak.Leak:Play()
	end
	if z == 88 then
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
		wait(0.3)
		audiosfx.PowerOn:Play()
		power("Red")
	end
	if z == 86 then
		audiosfx.Alarms.NearDestruction:Play()
		unanchor2(workspace.Facility.ImportantFacilityAreas.PrimaryReactorArea.ControlRoom.Vent2Explode)
		replicatedstorage.Events.WoopShocking:FireAllClients()
		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.RegenModules.debris_roof_ctrl:Clone().Parent = workspace
		wait(0.5)
		replicatedstorage.Events.WoopShocking:FireAllClients()
		audiosfx.ExplosionSoundEffects.BlewItOut:Play()
		game.ServerStorage.RegenModules.debris_roof_ctrl:Clone().Parent = workspace
		wait(0.5)
		game.ServerStorage.FireRoofSpawn:Clone().Parent = workspace
		audiosfx.ExplosionSoundEffects.majorExplosion:Play()
		audiosfx.Rumbling:Play()
		audiosfx.ExplosionSoundEffects.SparkExp:Play()
		audiosfx.ExplosionSoundEffects.ExplosionIdk:Play()
	end
	if z == 40 then
		audiosfx.PowerOn:Play()
		power("On")
		wait(0.2)
		audiosfx.OutNoPow3:Play()
		power("Off")
		replicatedstorage.Events.WoopShocking:FireAllClients()
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
		audiosfx.Alarms.AlarmWootWootDuhh:Play()
		notify("Notify","Info","Bunker","The bunker is now closing! If you haven't, launch all the remaining Emergency Jets if necessary!",10)
	end
	if z == 25 then
		audiosfx.Alarms.NuclearSiren:Play()
	end
	if z == 24 then
		fade(self.GeneralMusic.Meltdown.Meltdown_Ending, "In")
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
		-- everything, everything shuts off
		debris("AllDown")
	end
	if z == 3 then
		audiosfx.ExplosionSoundEffects.Rumble:Play()
	end
	task.wait(1)
end
replicatedstorage.Events.TheCoreExplode:FireAllClients(true)
replicatedstorage.Events.WeExploded:FireAllClients()
self.GeneralMusic.Meltdown.Meltdown_Ending.Ended:Connect:function()
	replicatedstorage.GUIEvents.FadeScreen:FireAllClients(Color3.fromRGB(0,0,0),3.25)
	wait(2)
	replicatedstorage.Events.EndingEvent:FireAllClients("Meltdown") 
	-- this is the ending!!! during this make sure to regenerate the
	-- whole thing and stuff
	--	make a seperate model so people can explore the entire destruction
	-- scene. people who
	-- choose to explore the ruins will be invisible to other players
	-- as they explore through em'. 
	wait(20)
	replicatedstorage.Events.Regen:Fire() -- note that regeneration is a 14 second process
	-- players who were in the control room have a toggle that will be turned so 
	-- they will lose some FourCoins (up to 150-200) until they reach 0 and Ores (for iron and ruby, up to 1-3 lost, for phantom 3-5). they will also be de-leveled
end)
script.Disabled = true