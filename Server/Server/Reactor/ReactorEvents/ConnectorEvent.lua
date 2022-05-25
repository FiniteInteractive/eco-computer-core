--[[
Connector Event
Eco Computer Core Backend Script
by gloopyreverb
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
RunService = game:GetService("RunService")
boom_module = require(game.ServerStorage.Modules.Reactor.BoomModule)
local ReplicatedStorage = game:GetService("ReplicatedStorage")


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

local function tweenModel(model, tweenInfo, offsetCFrame)
	local modelPivot = model:GetPivot()
	local steppedConnection

	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = modelPivot

	steppedConnection = RunService.Stepped:Connect(function ()
		model:PivotTo(CFrameValue.Value)
	end)

	local tween = TweenService:Create(CFrameValue, tweenInfo, {Value = modelPivot * offsetCFrame})
	tween.Completed:Connect(function ()
		steppedConnection:Disconnect()
		CFrameValue:Destroy()
		tween:Destroy() -- Avoid memory leak from tween
	end)
	tween:Play()
end

fade(workspace.GameData.EcoCC.SFX.Alarms.Overload.facaalarm,"In")
notify("Attention","Coolant-Instant Sample was sent and verified!",8)
task.wait(5)
notify("Attention","We're connecting the 'CoModule' to the Reactor to inject Coolant-Instant!",8)
task.wait(10)
fade(workspace.GameData.EcoCC.SFX.Alarms.Overload.facaalarm,"Out")
task.wait(5)
fade(facility.Connector.SoundPart.Sound,"In")
tweenModel(facility.Connector,TweenInfo.new(15, Enum.EasingStyle.Quad), CFrame.new(-228.5,0,0))
task.wait(14.5)
fade(facility.Connector.SoundPart.Sound,"Out")
task.wait(5.5)
for z = 1,7 do
	workspace.GameData.EcoCC.ReactorStats.CoreTemp.Value = workspace.GameData.EcoCC.ReactorStats.CoreTemp.Value - 50
	task.wait(4)
end
task.wait(10.5)
fade(facility.Connector.SoundPart.Sound,"In")
tweenModel(facility.Connector,TweenInfo.new(15, Enum.EasingStyle.Quad), CFrame.new(228.5,0,0))
task.wait(14.5)
fade(facility.Connector.SoundPart.Sound,"Out")
script.Disabled = true