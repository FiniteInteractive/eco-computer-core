local Zone = require(game.ReplicatedStorage.Modules.Zone)
local Player = game.Players.LocalPlayer
local Lighting = game.Lighting
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

-- TODO: make a system to always load the outside env first and spawn the player first and hold the player there until player chooses option
task.wait(13) -- loading/init

local OutsideContainer = workspace.World.Zones:WaitForChild("Outside",9)
local OutsideZone = Zone.new(OutsideContainer)

local DrowningContainer = workspace.World.Zones:WaitForChild("ZoneDrowning",9)
local DrowningZone = Zone.new(DrowningContainer)


local ElevatorContainer =  workspace.World.Zones:WaitForChild("Elevator",9)
local ElevatorZone = Zone.new(ElevatorContainer)

local LobbyContainer =  workspace.World.Zones:WaitForChild("LobbyZone",9)
local LobbyZone = Zone.new(LobbyContainer)

local ChamberContainer = workspace.World.Zones:WaitForChild("Chamber",9)
local ChamberZone = Zone.new(ChamberContainer)

local ControlRoom =  workspace.World.Zones:WaitForChild("ZoneCtrlRoom",9)
local ControlZone = Zone.new(ControlRoom)

local CaveContainer = workspace.World.Zones:WaitForChild("Cave",9)
local CaveZone = Zone.new(CaveContainer)


local CaveContainer2 = workspace.World.Zones:WaitForChild("CaveModifiedZone",9)
local CaveZone2 = Zone.new(CaveContainer2)

local ResearchContainer =  workspace.World.Zones:WaitForChild("Zone_expResearch",9)
local ResearchZone = Zone.new(ResearchContainer)


local ElectricalContainer =  workspace.World.Zones:WaitForChild("ZoneElectrical",9)
local ElectricalZone = Zone.new(ElevatorContainer)

local MainHallsMus = workspace.World.Zones:WaitForChild("MainHalls",9)
local MainHallsZone = Zone.new(MainHallsMus)

local BunkerContainer = workspace.World.Zones:WaitForChild("Bunker",9)
local BunkerZone = Zone.new(BunkerContainer)
local Barrier  = workspace.World.Objects.Miscellaneous.BarrierOutdoors

local DrownCheck = false
local FoVOpen = 65
local FoVClose = 70
local blurwhenui_ison = 24
local redonmelt = Color3.fromRGB(253, 116, 98)


local HallwayProperties = {
	Ambient = Color3.fromRGB(55, 54, 84);
	OutdoorAmbient = Color3.fromRGB(54, 56, 82)
}

local oh_oh_ohconveience = false
local mining = false

local TweenService = game:GetService("TweenService")

local uiColorDecreaseProperties = {
	Brightness = -0.01;
	Contrast = 0.01;
	Saturation = 0.1;
	TintColor = Color3.fromRGB(196,196,196);
	ResetBrightness = 0;
	ResetContrast = 0;
	ResetSaturation = 0;
	ResetTintColor = Color3.fromRGB(255,255,255);
}

local function uiOpen()
	TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = FoVOpen}):Play()
	TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = blurwhenui_ison}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Brightness = uiColorDecreaseProperties.Brightness}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Contrast = uiColorDecreaseProperties.Contrast}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Saturation = uiColorDecreaseProperties.Saturation}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {TintColor = uiColorDecreaseProperties.TintColor}):Play()
end

local function uiClose()
	TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = FoVClose}):Play()
	TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = 0}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Brightness = uiColorDecreaseProperties.ResetBrightness}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Contrast = uiColorDecreaseProperties.ResetContrast}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Saturation = uiColorDecreaseProperties.ResetSaturation}):Play()
	TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {TintColor = uiColorDecreaseProperties.ResetTintColor}):Play()
end

DrowningZone.localPlayerEntered:Connect(function(localPlayer)
	game.SoundService.SongsCanMute.Volume = 0.15
	DrownCheck = true
	task.wait(39)
	script.Parent.Parent.LocalMusic.DrowningMusic.Warning:Play()
	task.wait(19)
	if DrownCheck == true then
	script.Parent.Parent.LocalMusic.DrowningMusic:Play()
	script.Parent.Parent.LocalMusic.DrowningMusic.Warning:Stop()
		script.Parent.Drowning.Visible = true
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 80
		end
		if DrownCheck == true then
		script.Parent.Drowning.Countdown.Text = "5"
		script.Parent.Drowning.CountdownBG.Text = "5"
		task.wait(1.85)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
			script.Parent.Drowning.Visible = true
		end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 50
		script.Parent.Drowning.Countdown.Text = "4"
		script.Parent.Drowning.CountdownBG.Text = "4"
		task.wait(1.85)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
			script.Parent.Drowning.Visible = true
			end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 30
		script.Parent.Drowning.Countdown.Text = "3"
		script.Parent.Drowning.CountdownBG.Text = "3"
		task.wait(1.85)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
			script.Parent.Drowning.Visible = true
			end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 20
		script.Parent.Drowning.Countdown.Text = "2"
		script.Parent.Drowning.CountdownBG.Text = "2"
		task.wait(1.85)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		task.wait(0.05)
		script.Parent.Drowning.Visible = true
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
			task.wait(0.05)
			end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 10
		script.Parent.Drowning.Visible = true
		script.Parent.Drowning.Countdown.Text = "1"
		script.Parent.Drowning.CountdownBG.Text = "1"
		task.wait(0.05)
		script.Parent.Drowning.Visible = false
		script.Parent.Drowning.Countdown.Text = "1"
		script.Parent.Drowning.CountdownBG.Text = "1"
		task.wait(0.05)
		script.Parent.Drowning.Visible = true
		script.Parent.Drowning.Countdown.Text = "1"
		script.Parent.Drowning.CountdownBG.Text = "1"
			task.wait(1.85)
		end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 5
		script.Parent.Drowning.Countdown.Text = "0"
		script.Parent.Drowning.CountdownBG.Text = "0"
		task.wait(0.5)
		script.Parent.Drowning.CountdownBG.Text = ""
		task.wait(0.5)
		script.Parent.Drowning.CountdownBG.Text = "0"
		task.wait(0.5)
		script.Parent.Drowning.CountdownBG.Text = ""
		task.wait(0.5)
		script.Parent.Drowning.CountdownBG.Text = "0"
			task.wait(3)
		end
		if DrownCheck == true then
			localPlayer.Character.Humanoid.Health = 0
		task.wait(2)
		DrownCheck = false
			script.Parent.Drowning.Visible = false
		end
	end
end)


DrowningZone.localPlayerExited:Connect(function(localPlayer)
	DrownCheck = false
	game.SoundService.SongsCanMute.Volume = 1.985
	script.Parent.Parent.LocalMusic.DrowningMusic:Stop()
	script.Parent.Parent.LocalMusic.DrowningMusic.Warning:Stop()
	script.Parent.Drowning.Visible = false
end)


OutsideZone.localPlayerEntered:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetInsideMusicContinous.Disabled = false
	script.Parent.SetContinousMusicOff.Disabled = true
	Player.CameraMaxZoomDistance = 128
	script.Parent.Parent.LocalMusic.Ambience.Facility:Stop()
	if workspace.World.Objects.Facility.ImportantFacilityAreas:FindFirstChild("HallwayToCTRL") ~= nil then
		workspace.World.Objects.Facility.ImportantFacilityAreas.HallwayToCTRL.Parent = game.ReplicatedStorage.Components.Maps
	end
	if workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == true then
		Player.PlayerGui.LocalMusic.Outside.Day:Stop()
		Player.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
		Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
		Player.PlayerGui.LocalMusic.Outside.Night:Stop()
		Player.PlayerGui.LocalMusic.Outside.Wind:Play()
		script.Parent.SetContinousMusicOff.Disabled = true
		Player.PlayerGui.LocalMusic.Outside.Rain:Play()
		Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
		TweenService:Create(Lighting, TweenInfo.new(12), {Ambient = Color3.fromRGB(27, 27, 27)}):Play()
		TweenService:Create(Lighting, TweenInfo.new(12), {OutdoorAmbient = Color3.fromRGB(26, 26, 41)}):Play()
		Barrier.BarrierA.ParticleEmitter.Enabled = true
		Barrier.BarrierB.ParticleEmitter.Enabled = true
		Barrier.BarrierC.ParticleEmitter.Enabled = true
		Barrier.BarrierD.ParticleEmitter.Enabled = true
		TweenService:Create(Lighting, TweenInfo.new(10), {EnvironmentDiffuseScale = 0.01}):Play()
		TweenService:Create(Lighting, TweenInfo.new(10), {EnvironmentSpecularScale = 0.1}):Play()
		TweenService:Create(Lighting, TweenInfo.new(10), {Brightness = 0.1}):Play()
		TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Cover = 0.91}):Play()
		TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Density = 1}):Play()
		TweenService:Create(Player.PlayerGui.LocalMusic.Outside.Rain, TweenInfo.new(10), {Volume = 0.6}):Play()
	end
	if workspace.GameData.EcoCC:WaitForChild("ReactorStats").Aurora.Value == true and game.Lighting.ClockTime >= 16.85 then
		game.Lighting.AuroraEff.Enabled = true
		TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Cover = 0.35}):Play()
		game.ReplicatedStorage.Components.Objects.Aurora:Clone().Parent = workspace.World.Environment
		task.wait(2)
		game.Lighting.AuroraEff.Enabled = false
	end
	if game.Lighting:FindFirstChild("InsideFacAtmo") then
		game.Lighting.InsideFacAtmo.Parent = game.ReplicatedStorage.Components.Maps
	end
	if workspace.World.Objects.Facility.Sector1M:FindFirstChild("Lobby") then
		workspace.World.Objects.Facility.Sector1M.Lobby.Parent = game.ReplicatedStorage.Components.Maps
	end
	game.SoundService.AmbientReverb = Enum.ReverbType.NoReverb
	script.Parent.Outside.Value = true
	if game.ReplicatedStorage.Components.Maps:FindFirstChild("HallwayToCTRL") ~= nil then
		game.ReplicatedStorage.Components.Maps.HallwayToCTRL.Parent = workspace.World.Objects.Facility.ImportantFacilityAreas
	end
	if game.ReplicatedStorage:FindFirstChild("OutsideEnv") ~= nil then
		game.ReplicatedStorage.OutsideEnv.Parent = workspace.World.Environment
	end
	if game.Lighting.ClockTime >= 6 and game.Lighting.ClockTime <= 17 and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then 
		Player.PlayerGui.LocalMusic.Outside.Day:Play()
		Player.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
		Player.PlayerGui.LocalMusic.Outside.BirdChirp:Play()
		Player.PlayerGui.LocalMusic.Outside.Night:Stop()
		Player.PlayerGui.LocalMusic.Outside.Wind:Stop()
		Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(133, 133, 152)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(133, 133, 152)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.3}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.3}):Play()
	elseif  game.Lighting.ClockTime >= 17 and game.Lighting.ClockTime <= 19 and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then
		Player.PlayerGui.LocalMusic.Outside.Day:Stop()
		Player.PlayerGui.LocalMusic.Outside.Night:Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(72, 76, 103)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(21, 20, 43)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.2}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.2}):Play()
	elseif  game.Lighting.ClockTime >= 20 and game.Lighting.ClockTime <= 5 and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then
		if Player.PlayerGui.LocalMusic.Outside.Night.Playing == false and workspace.GameData.EcoCC.Season.Value ~= "Winter" then
			Player.PlayerGui.LocalMusic.Outside.Night:Play()
		end
		if Player.PlayerGui.LocalMusic.Outside.Night.Playing == false and workspace.GameData.EcoCC.Season.Value == "Winter" and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then
			Player.PlayerGui.LocalMusic.Outside.NightChristmas:Play()
		end
		Player.PlayerGui.LocalMusic.Outside.CricketChirp:Play()
		Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
		Player.PlayerGui.LocalMusic.Outside.Wind:Play()
		game.Lighting.Brightness = 0.4
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(72, 76, 103)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(21, 20, 43)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.14}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.14}):Play()
	end
end)


OutsideZone.localPlayerExited:Connect(function(localPlayer)
	script.Parent.Outside.Value = false
	script.Parent.SetInsideMusicContinous.Disabled = true
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	Player.CameraMaxZoomDistance = 128
	TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(30), {Cover = 0.605}):Play()
	TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(30), {Density = 0.38}):Play()
	Barrier.BarrierA.ParticleEmitter.Enabled = false
	Barrier.BarrierB.ParticleEmitter.Enabled = false
	Barrier.BarrierC.ParticleEmitter.Enabled = false
	Barrier.BarrierD.ParticleEmitter.Enabled = false
	game.SoundService.AmbientReverb = Enum.ReverbType.ConcertHall
	if 	game.ReplicatedStorage.Components.Maps:FindFirstChild("Lobby") then
		game.ReplicatedStorage.Components.Maps.Lobby.Parent = game.workspace.World.Objects.Facility.Sector1M
	end
	Player.PlayerGui.LocalMusic.Ambience.Facility:Play()
	Player.PlayerGui.LocalMusic.Outside.Day:Stop()
	Player.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
	Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
	Player.PlayerGui.LocalMusic.Outside.Night:Stop()
	Player.PlayerGui.LocalMusic.Outside.Wind:Stop()
	Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
	if 	game.ReplicatedStorage.Components.Maps:FindFirstChild("OutsideEnv") ~= nil then
		game.ReplicatedStorage.Components.Maps.OutsideEnv.Parent = 	game.Workspace.World.Environment
	end
	if 	game.ReplicatedStorage.Components.Maps:FindFirstChild("HallwayToCTRL") ~= nil then
		game.ReplicatedStorage.Components.Maps.HallwayToCTRL.Parent = game.workspace.World.Objects.Facility.ImportantFacilityAreas
	end
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(81, 81, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(81, 81, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.09}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.09}):Play()
	elseif script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == true then
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(47, 43, 47)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(47, 43, 47)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.03}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.03}):Play()
	end
	TweenService:Create(Player.PlayerGui.LocalMusic.Outside.Rain, TweenInfo.new(10), {Volume = 0}):Play()
	if workspace.World.Environment:FindFirstChild("Aurora") then
		workspace.World.Environment:FindFirstChild("Aurora"):Destroy()
	end
end)

local Kill = TweenService:Create(game.Players.LocalPlayer.Character.Humanoid, TweenInfo.new(60), {Health = 0})
local Heal = TweenService:Create(game.Players.LocalPlayer.Character.Humanoid, TweenInfo.new(30), {Health = 100})

ChamberZone.localPlayerEntered:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetContinousNight.Disabled = false
	if game.Players.LocalPlayer.Character:FindFirstChild("Helmet") == nil then
		Kill:Play()
		script.Parent.Parent.GeigerCount:Play()
		script.Parent.Parent.LocalMusic.Ambience.GeigerAmbience:Play()
		script.Parent.Parent.CoreGUI.NoHazmat.Visible = true
		TweenService:Create(game.Lighting.PostCorrection, TweenInfo.new(55), {TintColor = redonmelt}):Play()
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(55), {FieldOfView = 20}):Play()
	end
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(81, 81, 94)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(39, 39, 45)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0.1}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0.1}):Play()
	else 
		return "Evacuate lol"
	end
end)

ChamberZone.localPlayerExited:Connect(function(localPlayer)
	script.Parent.SetContinousNight.Disabled = true
	script.Parent.SetContinousMusicOff.Disabled = false
	script.Parent.SetInsideMusicContinous.Disabled = true
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	Kill:Cancel()
	Heal:Play()
	script.Parent.Parent.GeigerCount:Stop()
	script.Parent.Parent.LocalMusic.Ambience.GeigerAmbience:Stop()
	TweenService:Create(game.Lighting.PostCorrection, TweenInfo.new(2), {TintColor = uiColorDecreaseProperties.ResetTintColor}):Play()
	TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {FieldOfView = 70}):Play()
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(61, 61, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(61, 61, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0}):Play()
	else
		return "NO"
	end
end)

CaveZone.localPlayerEntered:Connect(function(localPlayer)
	Player.CameraMaxZoomDistance = 40
	script.Parent.CaveSounds.Disabled = false
	script.Parent.SetContinousMusicOff.Disabled = false
	script.Parent.SetInsideMusicContinous.Disabled = true
	mining = true
	game.Lighting.DepthOfField.Enabled = true
	script.Parent.CaveUIResearchUI.Inventory.Visible = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.CaveUIResearchUI.Visible = true
	script.Parent.CaveUIResearchUI.Hint.Visible = true
	script.Parent.CaveUIResearchUI["*BackpackStorageAndBlockedMined"].Visible = true
	script.Parent.SetContinousNight.Disabled = false
	if script.Parent.Device.Value == "Mobile System" then
		script.Parent.CaveUIResearchUI.Inventory.Visible = true
	elseif script.Parent.Device.Value == "Windows / macOS (Gamepad Active)" or script.Parent.Device.Value == "Microsoft®️ XBOX" then
		script.Parent.CaveUIResearchUI.HintConsole.Visible = true
	end
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		script.Parent.Parent.LocalMusic.CaveMusic:Play()
		TweenService:Create(script.Parent.Parent.LocalMusic.CaveMusic, TweenInfo.new(1), {Volume = 0.95}):Play()
	else
		task.wait(5)
		script.Parent.CaveUIResearchUI.Hint.Visible = false
		return "????"
	end
	task.wait(5)
	script.Parent.CaveUIResearchUI.Hint.Visible = false
end)

CaveZone.localPlayerExited:Connect(function(localPlayer)
	mining = false
	script.Parent.CaveSounds.Disabled = true
	script.Parent.CaveUIResearchUI.Inventory.Visible = false
	script.Parent.CaveUIResearchUI["*BackpackStorageAndBlockedMined"].Visible = false
	script.Parent.SetContinousMusicOff.Disabled = false
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetInsideMusicContinous.Disabled = true
	Player.CameraMaxZoomDistance = 128
	script.Parent.SetContinousNight.Disabled = true
	script.Parent.CaveUIResearchUI.Inventory.Visible = false
	script.Parent.CaveUIResearchUI.Visible = false
	TweenService:Create(script.Parent.Parent.LocalMusic.CaveMusic, TweenInfo.new(1), {Volume = 0}):Play()
end)


CaveZone2.localPlayerEntered:Connect(function(localPlayer)
	Player.CameraMaxZoomDistance = 40
	script.Parent.CaveSounds.Disabled = false
	script.Parent.CaveUIResearchUI["*BackpackStorageAndBlockedMined"].Visible = true
	script.Parent.CaveUIResearchUI.Inventory.Visible = true
	mining = true
	game.Lighting.DepthOfField.Enabled = true
	script.Parent.SetInsideMusicContinous.Disabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.CaveUIResearchUI.Visible = true
	script.Parent.CaveUIResearchUI.Hint.Visible = true
	if script.Parent.Device.Value == "Mobile System" then
		script.Parent.CaveUIResearchUI.Inventory.Visible = true
	end
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		script.Parent.Parent.LocalMusic.CaveMusic:Play()
		TweenService:Create(script.Parent.Parent.LocalMusic.CaveMusic, TweenInfo.new(1), {Volume = 0.2}):Play()
		TweenService:Create(script.Parent.Parent.LocalMusic.Outside.Night, TweenInfo.new(1), {Volume = 0}):Play()
		TweenService:Create(script.Parent.Parent.LocalMusic.Outside.Day, TweenInfo.new(1), {Volume = 0}):Play()
	else
		task.wait(5)
		script.Parent.CaveUIResearchUI.Hint.Visible = false
		return "????"
	end
	task.wait(5)
	script.Parent.CaveUIResearchUI.Hint.Visible = false
end)

CaveZone2.localPlayerExited:Connect(function(localPlayer)
	mining = false
	script.Parent.CaveSounds.Disabled = true
	script.Parent.CaveUIResearchUI["*BackpackStorageAndBlockedMined"].Visible = false
	script.Parent.CaveUIResearchUI.Inventory.Visible = false
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetInsideMusicContinous.Disabled = true
	Player.CameraMaxZoomDistance = 128
	TweenService:Create(script.Parent.Parent.LocalMusic.CaveMusic, TweenInfo.new(1), {Volume = 0}):Play()
	TweenService:Create(script.Parent.Parent.LocalMusic.Outside.Night, TweenInfo.new(1), {Volume = 1.25}):Play()
	TweenService:Create(script.Parent.Parent.LocalMusic.Outside.Day, TweenInfo.new(1), {Volume = 1.25}):Play()
end)




ElectricalZone.localPlayerEntered:Connect(function(localPlayer)
	Player.PlayerScripts.KolteryEngine_ReverbStudio.ChatEvents.ChattedTransformer.Disabled = false
end)

ElectricalZone.localPlayerExited:Connect(function(localPlayer)
	Player.PlayerScripts.KolteryEngine_ReverbStudio.ChatEvents.ChattedTransformer.Disabled = true
end)

-------

ResearchZone.localPlayerEntered:Connect(function(localPlayer)
	mining = true
	script.Parent.SetContinousMusicOff.Disabled = false
	game.Lighting.DepthOfField.Enabled = true
	script.Parent.SetInsideMusicContinous.Disabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.CaveUIResearchUI.Visible = true
	script.Parent.CaveUIResearchUI.Hint.Visible = true
	script.Parent.CaveUIResearchUI.Inventory.Visible = true
	task.wait(5)
	script.Parent.CaveUIResearchUI.Hint.Visible = false
end)

ResearchZone.localPlayerExited:Connect(function(localPlayer)
	mining = false
	script.Parent.SetContinousMusicOff.Disabled = false
	game.Lighting.DepthOfField.Enabled = true
	script.Parent.SetInsideMusicContinous.Disabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.CaveUIResearchUI.Inventory.Visible = false
	script.Parent.CaveUIResearchUI.Visible = false
end)



BunkerZone.localPlayerEntered:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	TweenService:Create(Lighting, TweenInfo.new(1), {Ambient = Color3.fromRGB(14, 14, 14)}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {OutdoorAmbient = Color3.fromRGB(11, 11, 11)}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {EnvironmentDiffuseScale = 0}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {EnvironmentSpecularScale = 0}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {Brightness = 0}):Play()
	game.ReplicatedStorage.Events.ToggleBunkerSafeArea:FireServer(true)
end)

BunkerZone.localPlayerExited:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	TweenService:Create(Lighting, TweenInfo.new(1), {Ambient = Color3.fromRGB(83, 83, 83)}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {OutdoorAmbient = Color3.fromRGB(26, 26, 41)}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {EnvironmentDiffuseScale = 0.015}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {EnvironmentSpecularScale = 0.1}):Play()
	TweenService:Create(Lighting, TweenInfo.new(1), {Brightness = 0}):Play()
	game.ReplicatedStorage.Events.ToggleBunkerSafeArea:FireServer(false)
end)


ElevatorZone.localPlayerEntered:Connect(function(localPlayer)
	game.SoundService.AmbientReverb = Enum.ReverbType.LivingRoom
end)

ElevatorZone.localPlayerExited:Connect(function(localPlayer)
	game.SoundService.AmbientReverb = Enum.ReverbType.ConcertHall
end)


LobbyZone.localPlayerEntered:Connect(function(localPlayer)
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(script.Parent.Parent.LocalMusic.LobbyMus, TweenInfo.new(1), {Volume = 1}):Play()
		script.Parent.Parent.LocalMusic.LobbyMus:Play()
		script.Parent.SetInsideMusicContinous.Disabled = true
	else
		TweenService:Create(script.Parent.Parent.LocalMusic.LobbyMus, TweenInfo.new(1), {Volume = 0}):Play()
		return "finally"
	end
end)

LobbyZone.localPlayerExited:Connect(function(localPlayer)
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(script.Parent.Parent.LocalMusic.LobbyMus, TweenInfo.new(1), {Volume = 0}):Play()
		task.wait(1)
		script.Parent.Parent.LocalMusic.LobbyMus:Stop()
		script.Parent.SetInsideMusicContinous.Disabled = true
	else
		TweenService:Create(script.Parent.Parent.LocalMusic.LobbyMus, TweenInfo.new(1), {Volume = 0}):Play()
		return "finally"
	end

end)

ControlZone.localPlayerEntered:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = false
	game.Lighting.DepthOfField_ControlRoom.Enabled = true
	script.Parent.SetContinousNight.Disabled = false
	if workspace.World.Objects.Facility:FindFirstChild("Optimization") then
		if workspace.World.Objects.Facility.Sector1M:FindFirstChild("Lobby") then
			game.workspace.World.Objects.Facility.Sector1M.Lobby.Parent = game.ReplicatedStorage.Components.Maps
		end
		workspace.World.Objects.Facility.Optimization.Parent = game.ReplicatedStorage.Components.Maps
	end
end)

ControlZone.localPlayerExited:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = false
	game.Lighting.DepthOfField_ControlRoom.Enabled = true
	script.Parent.SetContinousNight.Disabled = true
	if game.ReplicatedStorage.Components.Maps:FindFirstChild("Optimization") then
		game.ReplicatedStorage.Components.Maps.Lobby.Parent = game.workspace.World.Objects.Facility.Sector1M
		game.ReplicatedStorage.Components.Maps.Optimization.Parent = workspace.World.Objects.Facility
	end
end)

MainHallsZone.localPlayerEntered:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetContinousMusicOff.Disabled = false
	TweenService:Create(script.Parent.Parent.LocalMusic.Ventilation, TweenInfo.new(3), {Volume = 0.15}):Play()
	script.Parent.Parent.LocalMusic.Ventilation:Play()
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		script.Parent.Parent.LocalMusic.Sound2:Play()
		TweenService:Create(script.Parent.Parent.LocalMusic.Sound2, TweenInfo.new(1), {Volume = 0.95}):Play()
		TweenService:Create(Lighting, TweenInfo.new(1), {Ambient = HallwayProperties.Ambient}):Play()
		TweenService:Create(Lighting, TweenInfo.new(1), {OutdoorAmbient = HallwayProperties.OutdoorAmbient}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0}):Play()
	else
		return "nerd"
	end
end)

MainHallsZone.localPlayerExited:Connect(function(localPlayer)
	game.Lighting.DepthOfField.Enabled = true
	game.Lighting.DepthOfField_ControlRoom.Enabled = false
	script.Parent.SetContinousMusicOff.Disabled = false
	TweenService:Create(script.Parent.Parent.LocalMusic.Ventilation, TweenInfo.new(3), {Volume = 0}):Play()
	if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
		TweenService:Create(script.Parent.Parent.LocalMusic.Sound2, TweenInfo.new(1), {Volume = 0}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {Ambient = Color3.fromRGB(61, 61, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {OutdoorAmbient = Color3.fromRGB(61, 61, 71)}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentDiffuseScale = 0}):Play()
		TweenService:Create(game.Lighting, TweenInfo.new(0.5), {EnvironmentSpecularScale = 0}):Play()
	else
		return "finally"
	end
	task.wait(3)
	script.Parent.Parent.LocalMusic.Ventilation:Stop()
end)


Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
	if Lighting.ClockTime > 18.4 or Lighting.ClockTime < 6 then --If the time is greater than 18 or less than 6 we consider it nighttime
		if Player.PlayerGui.LocalMusic.Outside.Night.Playing then return end --You can use whether or not the nighttime ambiance is playing as a debounce
		if Player.PlayerGui.LocalMusic.Outside.CricketChirp.Playing then return end --You can use whether or not the nighttime ambiance is playing as a debounce
		if 	Player.PlayerGui.LocalMusic.Outside.Wind.Playing then return end --You can use whether or not the nighttime ambiance is playing as a debounce
		if script.Parent.Outside.Value == true and script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then
			game.Lighting.Brightness = 0.4
			game.Lighting.Ambient = Color3.fromRGB(72, 76, 103)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(21, 20, 43)
			script.Parent.SetInsideMusicContinous.Disabled = false
			game.Lighting.EnvironmentDiffuseScale = 0.14
			game.Lighting.EnvironmentSpecularScale = 0.14
			Player.PlayerGui.LocalMusic.Outside.Day:Stop()
			Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
			Player.PlayerGui.LocalMusic.Outside.CricketChirp:Play()
			Player.PlayerGui.LocalMusic.Outside.Night:Play()
			Player.PlayerGui.LocalMusic.Outside.Wind:Play()	
		elseif script.Parent.Outside.Value == true and script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Aurora.Value == true then
			game.Lighting.AuroraEff.Enabled = true
			workspace.Terrain.Clouds.Cover = 0.35
			game.ReplicatedStorage.Components.Objects.Aurora:Clone().Parent = workspace.World.Environment
			task.wait(2)
			game.Lighting.AuroraEff.Enabled = false
		end
	else
		if 	Player.PlayerGui.LocalMusic.Outside.Day.Playing then return end --You can also use whether or not the forest ambiance is playing as a debounce
		if 	Player.PlayerGui.LocalMusic.Outside.BirdChirp.Playing then return end --You can also use whether or not the forest ambiance is playing as a debounce
		if script.Parent.Outside.Value == true and script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false and workspace.GameData.EcoCC:WaitForChild("ReactorStats").Rain.Value == false then
			game.Lighting.Brightness = 0.99
			Player.PlayerGui.LocalMusic.Outside.Day:Play()
			Player.PlayerGui.LocalMusic.Outside.BirdChirp:Play()
			script.Parent.SetInsideMusicContinous.Disabled = false
			Player.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
			Player.PlayerGui.LocalMusic.Outside.Night:Stop()
			Player.PlayerGui.LocalMusic.Outside.Wind:Stop()
			Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
			game.Lighting.Ambient = Color3.fromRGB(133, 133, 152)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(133, 133, 152)
			game.Lighting.EnvironmentDiffuseScale = 0.3
			game.Lighting.EnvironmentSpecularScale = 0.3
		end
	end
end)

game.ReplicatedStorage.RemotesEvents.GameEvents.Optimize.OnClientEvent:Connect(function(location,able)
	if location == "Outside" and able == false then
		game.ReplicatedStorage.Components.Maps.OutsideEnv.Parent = game.Workspace.World.Environment
	elseif location == "Outside" and able == true then
		game.Players.LocalPlayer:RequestStreamAroundAsync(Vector3.new(-197.178, 5.011, -3.446))
		game.Workspace.World.Environment.OutsideEnv.Parent = game.ReplicatedStorage.Components.Maps
	end
end)

game:GetService("UserInputService").InputBegan:Connect(function(key,gameProcessedEvent)
	if key.KeyCode == Enum.KeyCode.E and mining == true and oh_oh_ohconveience == false then
		if gameProcessedEvent then return false end
		script.Parent.Resources.Visible = true
		oh_oh_ohconveience = true
		uiOpen()
	elseif key.KeyCode == Enum.KeyCode.ButtonX and mining == true and oh_oh_ohconveience == false then
		if gameProcessedEvent then return false end
		script.Parent.Resources.Visible = true
		oh_oh_ohconveience = true
		uiOpen()
	end
end)


game:GetService("UserInputService").InputBegan:Connect(function(key,gameProcessedEvent)
	if key.KeyCode == Enum.KeyCode.E and oh_oh_ohconveience == true and mining == true then 
		if gameProcessedEvent then return false end
		script.Parent.Resources.Visible = false
		oh_oh_ohconveience = false
		uiClose()
	elseif key.KeyCode == Enum.KeyCode.ButtonB and oh_oh_ohconveience == true and mining == true then
		if gameProcessedEvent then return false end
		script.Parent.Resources.Visible = false
		oh_oh_ohconveience = false
		uiClose()
	end
end)


workspace.GameData.EcoCC.ReactorStats.Aurora.Changed:Connect(function(newval)
	if newval == true then
		game.Lighting.AuroraEff.Enabled = true
		TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Cover = 0.35}):Play()
		game.ReplicatedStorage.Components.Objects.Aurora:Clone().Parent = workspace.World.Environment
		task.wait(2)
		game.Lighting.AuroraEff.Enabled = false
	elseif newval == false then
		TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Cover = 0.605}):Play()
		if workspace.World.Environment:FindFirstChild("Aurora") then
			workspace.World.Environment:FindFirstChild("Aurora"):Destroy()
		end
		task.wait(2)
		game.Lighting.AuroraEff.Enabled = false
	end
end)



workspace.GameData.EcoCC.ReactorStats.Rain.Changed:Connect(function(newval)
	if newval == true then
		if script.Parent.Outside.Value == true then
			TweenService:Create(Player.PlayerGui.LocalMusic.Outside.Rain, TweenInfo.new(10), {Volume = 0.6}):Play()
			task.wait(6)
			TweenService:Create(Lighting, TweenInfo.new(12), {Ambient = Color3.fromRGB(47, 47, 27)}):Play()
			TweenService:Create(Lighting, TweenInfo.new(12), {OutdoorAmbient = Color3.fromRGB(26, 26, 41)}):Play()
			Barrier.BarrierA.ParticleEmitter.Enabled = true
			Barrier.BarrierB.ParticleEmitter.Enabled = true
			Barrier.BarrierC.ParticleEmitter.Enabled = true
			Barrier.BarrierD.ParticleEmitter.Enabled = true
			TweenService:Create(Lighting, TweenInfo.new(10), {EnvironmentDiffuseScale = 0.01}):Play()
			TweenService:Create(Lighting, TweenInfo.new(10), {EnvironmentSpecularScale = 0.1}):Play()
			TweenService:Create(Lighting, TweenInfo.new(10), {Brightness = 0.1}):Play()
			TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Cover = 0.91}):Play()
			TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(17), {Density = 1}):Play()
			Player.PlayerGui.LocalMusic.Outside.Day:Stop()
			Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
			Player.PlayerGui.LocalMusic.Outside.Night:Stop()
			Player.PlayerGui.LocalMusic.Outside.Wind:Play()
			Player.PlayerGui.LocalMusic.Outside.Rain:Play()
			Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
			task.wait(2)
			Player.PlayerGui.LocalMusic.Outside.Day:Stop()
			Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
			Player.PlayerGui.LocalMusic.Outside.Night:Stop()
			Player.PlayerGui.LocalMusic.Outside.Wind:Play()
			Player.PlayerGui.LocalMusic.Outside.Rain:Play()
			Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
		end
	elseif newval == false and script.Parent.Outside.Value == true then
		if script.Parent.Outside.Value == true then
			TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(30), {Cover = 0.605}):Play()
			TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(30), {Density = 0.38}):Play()
			Barrier.BarrierA.ParticleEmitter.Enabled = false
			Barrier.BarrierB.ParticleEmitter.Enabled = false
			Barrier.BarrierC.ParticleEmitter.Enabled = false
			Barrier.BarrierD.ParticleEmitter.Enabled = false
			TweenService:Create(Player.PlayerGui.LocalMusic.Outside.Rain, TweenInfo.new(20), {Volume = 0}):Play()
			if Lighting.ClockTime > 18.4 or Lighting.ClockTime < 6 then --If the time is greater than 18 or less than 6 we consider it nighttime
				if script.Parent.Outside.Value == true and script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
					game.Lighting.Brightness = 0.4
					game.Lighting.Ambient = Color3.fromRGB(72, 76, 103)
					game.Lighting.OutdoorAmbient = Color3.fromRGB(21, 20, 43)
					game.Lighting.EnvironmentDiffuseScale = 0.14
					game.Lighting.EnvironmentSpecularScale = 0.14
					Player.PlayerGui.LocalMusic.Outside.Day:Stop()
					Player.PlayerGui.LocalMusic.Outside.BirdChirp:Stop()
					Player.PlayerGui.LocalMusic.Outside.CricketChirp:Play()
					Player.PlayerGui.LocalMusic.Outside.Night:Play()
					Player.PlayerGui.LocalMusic.Outside.Wind:Play()	
				end
			else
				if script.Parent.Outside.Value == true and script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == false then
					game.Lighting.Brightness = 0.99
					Player.PlayerGui.LocalMusic.Outside.Day:Play()
					Player.PlayerGui.LocalMusic.Outside.BirdChirp:Play()
					Player.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
					Player.PlayerGui.LocalMusic.Outside.Night:Stop()
					Player.PlayerGui.LocalMusic.Outside.Wind:Stop()
					Player.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()
					game.Lighting.Ambient = Color3.fromRGB(133, 133, 152)
					game.Lighting.OutdoorAmbient = Color3.fromRGB(133, 133, 152)
					game.Lighting.EnvironmentDiffuseScale = 0.3
					game.Lighting.EnvironmentSpecularScale = 0.3
				end
			end
		end
		task.wait(20)
		Player.PlayerGui.LocalMusic.Outside.Rain:Stop()
	end
end)


script.Parent.MeltdownOrOtherState.Changed:Connect(function(bool)
	if bool == true then
		script.Parent.SetContinousMusicOff.Disabled = false
	elseif bool == false then
		script.Parent.SetContinousMusicOff.Disabled = true

	end
end)