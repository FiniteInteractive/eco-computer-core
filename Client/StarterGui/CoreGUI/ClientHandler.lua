--[[
Eco Computer Core Version 8
Script: Client Handler
Purpose: Handles most client infrastructure
Code by: Cosmos (@gloopyreverb)

Reverb Studio 2022-2023
]]

-- LIBRARIES
--local sound = require(script.Parent.Parent.RGUI)
local Players = game:GetService("Players")
local ts = game:GetService("TeleportService") --Gather the game service=
local CoreGUI = script.Parent
local ChatService = game:GetService("Chat")
local camera = workspace.CurrentCamera
local CoreGUIModule = require(script.Parent.CoreGUIModule)
local Colors = require(script.Parent.UIColors)
local CleanupPerformance = require(game.ReplicatedStorage.Modules.PercleanModule)
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local main = script
local starterGui = game:GetService('StarterGui')
local SocialService = game:GetService("SocialService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game.ReplicatedStorage
local CameraShaker = require(ReplicatedStorage.Modules.CameraShaker)
local camera = workspace.CurrentCamera
local Combinations = require(ReplicatedStorage.Lib.ForgeCombine)
local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
local player = Players.LocalPlayer
local PurchaseEvent = game.ReplicatedStorage.RemotesEvents.Shop.PurchaseEvent
local navigate = workspace.World.Objects.Facility:WaitForChild("Navigate")
local SoundService = game.SoundService
local LevelImages = require(script.Parent.LevelImages)
local LevelQuotes = require(script.Parent.LevelQuotes)
local menu = true
local blurwhenui_ison = 24
local FoVOpen = 65
local FoVClose = 70
local vent = true
local level_notload = false
local blur = game.Lighting.uiBlur
serveraudiosfx = workspace.GameData.EcoCC.SFX
local tweenNerd = require(script.Parent.CoreGUIModule)
local TweenService = game:GetService("TweenService")
local TypeOfJob = script.Parent.TypeOfJob


task.wait(7.86) -- server backend has changed


-- slots --
local tools = {
	Clipboard = ReplicatedStorage.Components.Tools.Shop_Tools['Clipboard'];
	["Reactor Tablet"] = ReplicatedStorage.Components.Tools.Shop_Tools['Reactor Tablet'];
	Hyperbike = ReplicatedStorage.Components.Tools.Shop_Tools['Hyperbike'];
	SpellOfHeat = ReplicatedStorage.Components.Tools.Shop_Tools['SpellOfHeat'];
}
local slot1 = script.Parent.CombineMenu.InteractionMenu.From.Craft1.Slot1
local slot2 = script.Parent.CombineMenu.InteractionMenu.From.Craft1.Slot2
local result = script.Parent.CombineMenu.InteractionMenu.To.Frame.Slot3

local redonmelt = Color3.fromRGB(253, 116, 98)

local ErrSound = script.Parent.Parent.Error
local HoverSound = script.Parent.Parent.Hover
local ClickSound = script.Parent.Parent.Click

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

local id = 39155604
local id2 = 8461871 -- gamepass
local selectedgear = script.Parent.SelectedGear -- fixed.



local gamestate = workspace:GetAttribute("GameState")

if player:FindFirstChild("Level") == nil then
	--player:WaitForChild("Level",7)
	--player.Level:WaitForChild("Experience_Current",7)
	--player.Level:WaitForChild("Experience_Max",7)
	local successed, returnedData = xpcall(function()
		player:WaitForChild("Level",7)
		player.Level:WaitForChild("Experience_Current",7)
		player.Level:WaitForChild("Experience_Max",7)
		level_notload = false
		print("Level Data loaded.")
	end, function() -- 1
		script.Parent.SmthWrong.Prompt.InteractionMenu.ErrorMsg.Text = "We could not load one or more of your data. Gameplay will continue without your data saving. Please report this issue to us."
		script.Parent.SmthWrong.Visible = true
		level_notload = true
		warn("Something went wrong for Experience_Current and Experience_Max and 'Level'")
	end)
end


local frames_show_off = {
	["1"] = "rbxassetid://9205554490";
	["2"] = "rbxassetid://9205552832";
	["3"] = "rbxassetid://9205552265";
	["4"] = "rbxassetid://9205553852";
	["5"] = "rbxassetid://9205554980";
	["6"] = "rbxassetid://9205553368";
	["7"] = "rbxassetid://9205554111";
}

--local function fadethruimages(parent,id)
--	for i = 1,25 do
--		task.wait(.01)
--		parent.ImageTransparency = (1-(0.05*i))
--	end
--	script.Parent.About.InteractionMenu.Video.Image = id
--end
local un = false

local function loadmaps()
	workspace.World.Zones:Destroy()
	game.ReplicatedStorage.Components.Objects:WaitForChild("Zones").Parent = workspace.World
	game.ReplicatedStorage.Components.Maps.MapFacilityDecoration.Parent = workspace.World.Objects.Miscellaneous
	game.ReplicatedStorage.Components.Maps.OutsideEnv.Parent = workspace.World.Environment
	game.ReplicatedStorage.Components.Maps.Lobby.Parent = workspace.World.Objects.Facility.Sector1M
end

--local function playvideo()
--	un = false
--	task.spawn(function()
--		repeat
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["1"])
--			task.wait(2)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["2"])
--			task.wait(1.95)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["3"])
--			task.wait(2)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["4"])
--			task.wait(1.95)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["5"])
--			task.wait(1.95)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["6"])
--			task.wait(1.95)
--			fadethruimages(script.Parent.About.InteractionMenu.Video,frames_show_off["7"])
--			task.wait(3.5)
--		until un == true
--	end)
--end

--local function stopvideo()
--	un = true
--	script.Parent.About.InteractionMenu.Video.Image = "rbxassetid://9205554490"
--end

local buttoncolors = { -- button colors for stuff
	disabled = Color3.fromRGB(149, 149, 149);
	enabled = Color3.fromRGB(57, 100, 255);
}
local gamestatecolors =
	{
		qa = Color3.fromRGB(252, 80, 47);
		internal = Color3.fromRGB(255, 167, 25)
	}

local bombdecoderplaces = {
	qatest = 8075262451;
	internal =  000;
	stable = 8055069420;
}

local explosionblur = {
	explosion = 18.5;
	bunkerblurexp = 10.72;
	normal = 2.5
}

local function fixcam() -- fixes camera. duh
	game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	game.Workspace.CurrentCamera.CameraType = "Custom"
end


local function uiOpen()
	if script.Parent.IsAnimationsReduced.Value == false then
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = FoVOpen}):Play()
		TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = blurwhenui_ison}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Brightness = uiColorDecreaseProperties.Brightness}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Contrast = uiColorDecreaseProperties.Contrast}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Saturation = uiColorDecreaseProperties.Saturation}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {TintColor = uiColorDecreaseProperties.TintColor}):Play()
	elseif script.Parent.IsAnimationsReduced.Value == true then
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0), {FieldOfView = FoVOpen}):Play()
		TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0), {Size = blurwhenui_ison}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Brightness = uiColorDecreaseProperties.Brightness}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Contrast = uiColorDecreaseProperties.Contrast}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Saturation = uiColorDecreaseProperties.Saturation}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {TintColor = uiColorDecreaseProperties.TintColor}):Play()
	end
end

local function uiClose()
	if script.Parent.IsAnimationsReduced.Value == false then
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.5), {FieldOfView = FoVClose}):Play()
		TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = 0}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Brightness = uiColorDecreaseProperties.ResetBrightness}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Contrast = uiColorDecreaseProperties.ResetContrast}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {Saturation = uiColorDecreaseProperties.ResetSaturation}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0.5), {TintColor = uiColorDecreaseProperties.ResetTintColor}):Play()
	elseif script.Parent.IsAnimationsReduced.Value == true then
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0), {FieldOfView = FoVClose}):Play()
		TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0), {Size = 0}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Brightness = uiColorDecreaseProperties.ResetBrightness}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Contrast = uiColorDecreaseProperties.ResetContrast}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {Saturation = uiColorDecreaseProperties.ResetSaturation}):Play()
		TweenService:Create(game.Lighting.uiColor_Decrease, TweenInfo.new(0), {TintColor = uiColorDecreaseProperties.ResetTintColor}):Play()
	end
end

local function tweeny(frame, transparency)
	if script.Parent.IsAnimationsReduced.Value == false then
		TweenService:Create(frame, TweenInfo.new(0.5), {Transparency = transparency}):Play()
		for _, v in pairs(frame:GetDescendants()) do
			if v:IsA("GuiObject") then
				if v:IsA("TextLabel") then
					TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = transparency}):Play()
				elseif v:IsA("Frame") then
					TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = transparency}):Play()
				elseif v:IsA("ImageLabel") then
					TweenService:Create(v, TweenInfo.new(0.5), {ImageTransparency = transparency}):Play()
				elseif v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(0.5), {TextTransparency = transparency}):Play()
					TweenService:Create(v, TweenInfo.new(0.5), {BackgroundTransparency = transparency}):Play()
				end	
			end
		end
	else
		TweenService:Create(frame, TweenInfo.new(0), {Transparency = transparency}):Play()
		for _, v in pairs(frame:GetDescendants()) do
			if v:IsA("GuiObject") then
				if v:IsA("TextLabel") then
					TweenService:Create(v, TweenInfo.new(0), {TextTransparency = transparency}):Play()
				elseif v:IsA("Frame") then
					TweenService:Create(v, TweenInfo.new(0), {BackgroundTransparency = transparency}):Play()
				elseif v:IsA("ImageLabel") then
					TweenService:Create(v, TweenInfo.new(0), {ImageTransparency = transparency}):Play()
				elseif v:IsA("TextButton") then
					TweenService:Create(v, TweenInfo.new(0), {TextTransparency = transparency}):Play()
					TweenService:Create(v, TweenInfo.new(0), {BackgroundTransparency = transparency}):Play()
				end	
			end
		end
	end
end




loadmaps()

script.Parent.CommandProhibited.Prompt.InteractionMenu.Choices.Okay.MouseButton1Click:Connect(function()
	script.Parent.CommandProhibited.Visible = false
end)

script.Parent.SmthWrong.Prompt.InteractionMenu.Choices.Okay.MouseButton1Click:Connect(function()
	script.Parent.SmthWrong.Visible = false
	script.Parent.SmthWrong.Prompt.InteractionMenu.ErrorMsg.Text = "Please report this issue to us."
end)
script.Parent.CommandWarning.Prompt.InteractionMenu.Choices.Run.MouseButton1Click:Connect(function()
	script.Parent.CommandWarning.Visible = false
end)

function updateonjoin() -- Updates when player joins the game.
	print("Updating ReEngine Framework Client")
	script.Parent.Settings:TweenPosition(UDim2.new(0.147, 0, 0.136, 0))
	script.Parent.About:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	script.Parent.Credits:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	script.Parent.Donate:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	script.Parent.Feedback:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	tweeny(script.Parent.Settings,1)
	tweeny(script.Parent.Feedback,1)
	tweeny(script.Parent.About,1)
	tweeny(script.Parent.Credits,1)
	tweeny(script.Parent.Donate,1)
	player:WaitForChild("Inventory",3)
	if player.FeedbackString.Value then
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Visible = true
		script.Parent.Replies.InteractionMenu.Disclaimer.Visible = true
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Body.Text = player.FeedbackString.Value
		script.Parent.Feedback.NewMsgs.Visible = true
		script.Parent.Replies.InteractionMenu.NoMsgs.Visible = true
	elseif player.FeedbackString.Value == nil or player.FeedbackString.Value == 0 then
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Visible = false
		script.Parent.Replies.InteractionMenu.Disclaimer.Visible = false
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Body.Text = "No message body."
		script.Parent.Feedback.NewMsgs.Visible = false
		script.Parent.Replies.InteractionMenu.NoMsgs.Visible = true
	end
	if (MarketplaceService:UserOwnsGamePassAsync(player.UserId, id2)) or (MarketplaceService:UserOwnsGamePassAsync(player.UserId, id)) then
		script.Parent.Settings.MainContext.Others.InsRespawnOff.Visible = true
		script.Parent.Settings.MainContext.Others.InsRespawnOn.Visible = true
		script.Parent.Settings.MainContext.Others.TitlesRVRBGAMEPRO.Visible = true
	end
	script.Parent.Resources["*OreList"].Frame.Carbon.Text = player.Inventory.Carbon.Value.." Carbon"
	if player.Inventory.Carbon.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Carbon.Visible = false
	end
	script.Parent.Resources["*OreList"].Frame.Coolant.Text = player.Inventory.Coolant.Value.." Coolant"
	if player.Inventory.Coolant.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Coolant.Visible = false
	end
	script.Parent.Resources["*OreList"].Frame.H2O.Text = player.Inventory.H2O.Value.." H2O"
	if player.Inventory.H2O.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.H2O.Visible = false
	end
	script.Parent.Resources["*OreList"].Frame.Iron.Text = player.Inventory.Iron.Value.." Iron"
	if player.Inventory.Iron.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Iron.Visible = false
	end
	script.Parent.Resources["*OreList"].Frame.Oxygen.Text = player.Inventory.Oxygen.Value.." Oxygen"
	if player.Inventory.Oxygen.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Oxygen.Visible = false
	elseif player.Inventory.Oxygen.Value >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Oxygen.Visible = true
	end
	script.Parent.Resources["*OreList"].Frame.Ruby.Text = player.Inventory.Ruby.Value.." Ruby"
	if player.Inventory.Ruby.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Ruby.Visible = false
	elseif player.Inventory.Ruby.Value >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Ruby.Visible = true
	end
	script.Parent.Resources["*OreList"].Frame.Phantom.Text = player.Inventory.Phantom.Value.." Phantom"
	if player.Inventory.Phantom.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Phantom.Visible = false
	elseif player.Inventory.Phantom.Value >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Phantom.Visible = true
	end
	script.Parent.Resources["*OreList"].Frame.Hydrogen.Text = player.Inventory.Hydrogen.Value.." Hydrogen"
	if player.Inventory.Hydrogen.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Hydrogen.Visible = false
	end
	script.Parent.Resources["*OreList"].Frame.Rock.Text = player.Inventory.Rock.Value.." Rock"
	if player.Inventory.Rock.Value == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Rock.Visible = false
	end

	if player.Level.Value >= 1 and player.Level.Value <= 4 then
		script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level1to4.Image
		script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[2]
	elseif player.Level.Value >= 4 and player.Level.Value <= 8 then
		script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level4to8.Image
		script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[3]
	elseif player.Level.Value >= 9 then
		script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level9orMore.Image
		script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[4]
	elseif player.Level.Value == 0 then
		script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[1]
	end

	local new = player.Inventory.Iron.Value
	script.Parent.Resources["*OreList"].Frame.Iron.Text = new.." Iron"
	if new >= 5 then
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron",4).BillboardGui.TextLabel.Text = "Unlocked Iron Pick! Get this!"
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron2",4).BillboardGui.TextLabel.Text = "Unlocked Iron Pick! Get this!"
		script.Parent.Resources.PickMenu.ironpick.Text = "Unlocked Iron Pick!"
	elseif new <= 4 then
		script.Parent.Resources.PickMenu.ironpick.Text = 5-new.." Iron in order to get Iron Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron",4).BillboardGui.TextLabel.Text = "Must have "..5-new.." more Iron Ores to get Iron Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron2",4).BillboardGui.TextLabel.Text = "Must have "..5-new.." more Iron Ores to get Iron Pick."
	end

	local new2 = player.Inventory.Ruby.Value
	script.Parent.Resources["*OreList"].Frame.Ruby.Text = new2.." Ruby"
	if new2 >= 10 then
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby",2).BillboardGui.TextLabel.Text = "Unlocked Ruby Pick! Get this!"
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby2",2).BillboardGui.TextLabel.Text = "Unlocked Ruby Pick! Get this!"
		script.Parent.Resources.PickMenu.rubypick.Text = "Unlocked Ruby Pick!"
	elseif new2 <= 9 then
		script.Parent.Resources.PickMenu.rubypick.Text = 10-new2.." Ruby in order to get Ruby Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby",2).BillboardGui.TextLabel.Text = "Must have "..10-new2.." more Ruby Ores to get Ruby Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby2",2).BillboardGui.TextLabel.Text = "Must have "..10-new2.." more Ruby Ores to get Ruby Pick."
	end

	local new3 = player.Inventory.Phantom.Value
	script.Parent.Resources["*OreList"].Frame.Phantom.Text = new3.." Phantom"
	if new3 >= 15 then
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom",2).BillboardGui.TextLabel.Text = "Unlocked Phantom Pick! Get this!"
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom2",2).BillboardGui.TextLabel.Text = "Unlocked Phantom Pick! Get this!"
		script.Parent.Resources.PickMenu.phantompick.Text = "Unlocked Phantom Pick!"
	elseif new3 <= 14 then
		script.Parent.Resources.PickMenu.phantompick.Text = 15-new3.." Phantom in order to get Phantom Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom",2).BillboardGui.TextLabel.Text = "Must have "..15-new3.." more Phantom Ores to get Phantom Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom2",2).BillboardGui.TextLabel.Text = "Must have "..15-new3.." more Phantom Ores to get Phantom Pick."
	end
	task.wait(2)
	if script.Parent.Device.Value == "Mobile System" then
		script.Parent.CaveUIResearchUI.Hint.Frame.TextLabel.Text = "Tap the button below to open your Crafting Menu."
	end
	script.Parent.Menu.FourCoins.TextLabel.Text = player:WaitForChild("leaderstats"):WaitForChild("Eco").Value.." Eco"
	if level_notload == false then
		if player.Level.Value >= 1 and player.Level.Value <= 2 then
			if workspace.AreaBlockOff:WaitForChild("BlockOff_CTRLR_Lvl4",3)  then
				workspace.AreaBlockOff.BlockOff_CTRLR_Lvl4:Destroy()
			end
		elseif player.Level.Value >= 2 then
			if workspace.AreaBlockOff:WaitForChild("BlockOff_CTRLR_Lvl2",3)  then
				workspace.AreaBlockOff.BlockOff_CTRLR_Lvl2:Destroy()
				workspace.AreaBlockOff.BlockOff_CTRLR_Lvl4:Destroy()
			end
		elseif player.Level.Value >= 1 and player.Level.Value <= 4 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level1to4.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[2]
		elseif player.Level.Value >= 4 and player.Level.Value <= 8 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level4to8.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[3]
		elseif player.Level.Value >= 9 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level9orMore.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[4]
		elseif player.Level.Value == 0 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[1]
		end
		script.Parent.YourLevel.MainContext.LevelContex.Frame.Level_ExpToMax.Text = player.Level.Experience_Current.Value.." exp / "..player.Level.Experience_Max.Value.." exp"
		script.Parent.Level.Text = "Level "..player.Level.Value
		script.Parent.YourLevel.MainContext.LevelContex.Level.Text = "Level "..player.Level.Value
	end
end
if gamestate == 1 then
	script.Parent.statelabel1.Visible = false
	script.Parent.statelabel2.Visible = false
	script.Parent.statelabel3.Visible = false
	print("Reverb ReEngine Framework has started! Game state is 1. Stable")
elseif gamestate == 2 then
	script.Parent.statelabel1.Visible = true
	script.Parent.statelabel2.Visible = true
	script.Parent.statelabel3.Visible = true
	script.Parent.statelabel2.Text = "Q/A Testers"
	print("Reverb ReEngine Framework has started! Game state is 2. Q/A Testers")
elseif gamestate == 3 then
	script.Parent.statelabel2.Text = "Internal"
	script.Parent.statelabel1.Visible = true
	script.Parent.statelabel2.Visible = true
	script.Parent.statelabel3.Visible = true
	print("Reverb ReEngine Framework has started! Game state is 3. Internal")
end

function explosionEnd() -- plays every explosion sound effect in the folder
	for _,inst in pairs(serveraudiosfx.ExplosionSoundEffects:GetDescendants())  do
		if inst:IsA("Sound") then
			inst:Play()
		end
	end
end

function navigation(enable_or_disable,location) -- shows navigation ui
	if enable_or_disable == true then
		if location == "Reactor" then
			navigate.NavigateGetInFacility.Navigate.Enabled = true
			navigate.NavigateReactor.Navigate.Enabled = true
		end
		if location == "Lobby" then
			navigate.NavigateGetInFacility.Navigate.Enabled = true
			--navigate.NavigateMonsters.Navigate.Enabled = true
		end
		if location == "Mining" then
			--navigate.NavigateGetInFacility.Navigate.Enabled = true
			navigate.NavigateCave.Navigate.Enabled = true
		end
		if location == "Bomb" then
			navigate.NavigateGetInFacility.Navigate.Enabled = true
			navigate.NavigateBomb.Navigate.Enabled = true
		end
	end

	if enable_or_disable == false then
		navigate.NavigateCave.Navigate.Enabled = false
		navigate.NavigateBomb.Navigate.Enabled = false
		navigate.NavigateReactor.Navigate.Enabled = false
		navigate.NavigateGetInFacility.Navigate.Enabled = false
		script.Parent.ExitNavigation.Visible = false
	end
end


function teleport(location)
	if location == "Bomb" then
		ReplicatedStorage.Events.TeleportSpawn:FireServer("Bomb")
	elseif location == "Reactor" then
		ReplicatedStorage.Events.TeleportSpawn:FireServer("Reactor")
	elseif location == "Lobby" then
		ReplicatedStorage.Events.TeleportSpawn:FireServer("Lobby")
	elseif location == "Mining" then
		ReplicatedStorage.Events.TeleportSpawn:FireServer("Mining")
	elseif location == "Trains" then
		ReplicatedStorage.Events.TeleportSpawn:FireServer("Trains")
	end
end

local oresimages = {
	ruby = "rbxassetid://8058887408";
	phantom = "rbxassetid://8058887645";
	iron = "rbxassetid://8058883774";
}

--
--area change, ambience
--remote events and module scripts plus ambient changes things

script.Parent.Resources.InteractionMenu.SubmenuChooser.OresMaterials.MouseButton1Click:Connect(function()
	script.Parent.Resources["*OreList"].Visible = true
	script.Parent.Resources["PickMenu"].Visible = false
	script.Parent.Resources.contexttitle.Text = "Ores/Materials"
end)


script.Parent.Resources.InteractionMenu.SubmenuChooser.Picks.MouseButton1Click:Connect(function()
	script.Parent.Resources["*OreList"].Visible = false
	script.Parent.Resources["PickMenu"].Visible = true
	script.Parent.Resources.contexttitle.Text = "Pickaxes"
end)

ReplicatedStorage.RemotesEvents.GuiEvents.FadeScreen.OnClientEvent:Connect(function(color,timer)
	CoreGUI.Fade.Visible = true
	CoreGUI.Fade.BackgroundColor3 = color
	TweenService:Create(CoreGUI.Fade ,TweenInfo.new(0.5),{BackgroundTransparency = 0}):Play()
	wait(timer)
	TweenService:Create(CoreGUI.Fade ,TweenInfo.new(0.55),{BackgroundTransparency = 1}):Play()
	wait(1)
	CoreGUI.Fade.Visible = false	
end)

ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController.OnClientEvent:Connect(function(whatshows,duration)
	if whatshows == "electricalsystemstartuponly" then
		script.Parent.ElectricalSystemStartupOnly.Visible = true
		wait(duration)
		script.Parent.ElectricalSystemStartupOnly.Visible = false
	end
end)

ReplicatedStorage.RemotesEvents.GameEvents.LevelSystem.OnClientEvent:Connect(function(levelgui,level)
	if levelgui == true then
		script.Parent.CaveUIResearchUI.LevelGui.Visible = true
		if level ~= 2 or 1 then
			script.Parent.CaveUIResearchUI.LevelGui.Frame.TextLabel.Text = "Level Up! You are now Level "..tostring(level).."."
		elseif level == 1 then
			script.Parent.CaveUIResearchUI.LevelGui.Frame.TextLabel.Text = "Level Up! You are now Level "..tostring(level)..". You've unlocked the Primary Reactor Airlock!"
		elseif level == 2 then
			script.Parent.CaveUIResearchUI.LevelGui.Frame.TextLabel.Text = "Level Up! You are now Level "..tostring(level)..". You've unlocked Space Travel!"
		end
		script.Parent.Parent.Hooray:Play()
		task.spawn(function()
			wait(5)
			script.Parent.CaveUIResearchUI.LevelGui.Visible = false
		end)
	end
end)
ReplicatedStorage.Events.General.ContinousShake.OnClientEvent:Connect(function()
	if script.Parent.IsShakeOn.Value == true then
		local function ShakeCamera(shakeCf)
			-- shakeCf: CFrame value that represents the offset to apply for shake effect.
			-- Apply the effect:
			camera.CFrame = camera.CFrame * shakeCf
		end

		-- Create CameraShaker instance:
		local renderPriority = Enum.RenderPriority.Camera.Value + 1
		local camShake = CameraShaker.new(renderPriority, ShakeCamera)

		camShake:Start()

		local ContinousShakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		script.Parent.IsShakeOn.Changed:Connect(function(bool)
			if bool == false then
				ContinousShakeInstance:Stop()
			end
		end)
		task.wait(600)
		ContinousShakeInstance:StartFadeOut(10) -- Argument is the fadeout time
	end
end)

script.Parent.IsShakeOn.Changed:Connect(function(bool)
	if bool == true then
		player.PlayerScripts.Shaking.LocalScript.Disabled = false
		player.PlayerScripts.Shaking.LocalScript2.Disabled = false
		player.PlayerScripts.Shaking.LocalScript3.Disabled = false
	elseif bool == false then
		player.PlayerScripts.Shaking.LocalScript.Disabled = true
		player.PlayerScripts.Shaking.LocalScript2.Disabled = true
		player.PlayerScripts.Shaking.LocalScript3.Disabled = true
	end
end)

script.Parent.Settings.MainContext.Appearance.Dark.MouseButton1Click:Connect(function()
	script.Parent.Settings.BackgroundColor3 = Colors.dark.settings.windowborder
	for _, v in pairs(script.Parent.Settings.ActionBar:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextLabel") then
				v.TextColor3 = Colors.dark.settings.textcolor
			elseif v:IsA("Frame") then
				v.BackgroundColor3 = Colors.dark.settings.interactionmenus
			end
		end
	end
	for _, v in pairs(script.Parent.Settings.InteractionMenu:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextButton") then
				v.BackgroundColor3 = Colors.dark.settings.buttons
				v.TextColor3 = Colors.dark.settings.textcolor
			elseif v:IsA("TextLabel") then
				v.TextColor3 = Colors.dark.settings.textcolor
			end
		end
	end
	for _, v in pairs(script.Parent.Settings.MainContext:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextLabel") then
				v.TextColor3 = Colors.dark.settings.textcolor
			elseif v:IsA("Frame") then
				v.BackgroundColor3 = Colors.dark.settings.interactionmenus
			end
		end
	end
	script.Parent.Menu.BackgroundColor3 = Colors.dark.menu.windowborder
	script.Parent.Menu.Frame.BackgroundColor3 = Colors.dark.menu.windowborder
	script.Parent.Menu.Version.BackgroundColor3 = Colors.dark.menu.windowborder
	script.Parent.Menu.Version.TextLabel.TextColor = Colors.dark.menu.textcolor
	script.Parent.Menu.Frame.TextLabel = Colors.dark.menu.windowborder
	for _, v in pairs(script.Parent.Menu:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextButton") then
				v.BackgroundColor3 = Colors.dark.menu.buttons
				v.TextColor3 = Colors.dark.menu.textcolor
			elseif v:IsA("TextLabel") then
				v.TextColor3 = Colors.dark.menu.textcolor
			end
		end
	end
	script.Parent.Settings.ActionBar.BackgroundColor3 = Colors.dark.settings.interactionmenus
	script.Parent.Settings.InteractionMenu.BackgroundColor3 = Colors.dark.settings.interactionmenus
	script.Parent.Settings.MainContext.BackgroundColor3 = Colors.dark.settings.interactionmenus
	script.Parent.Settings.MainContext.Appearance.Dark.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Appearance.Light.BackgroundColor3 = buttoncolors.disabled
	script.Parent.Settings.MainContext.Appearance.Light.Active = false
	script.Parent.Settings.MainContext.Appearance.Light.Active = true
end)

script.Parent.Settings.MainContext.Appearance.Light.MouseButton1Click:Connect(function()
	script.Parent.Settings.BackgroundColor3 = Colors.light.settings.windowborder
	for _, v in pairs(script.Parent.Settings.ActionBar:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextLabel") then
				v.TextColor3 = Colors.light.settings.textcolor
			end
		end
	end
	for _, v in pairs(script.Parent.Settings.InteractionMenu:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextButton") then
				v.BackgroundColor3 = Colors.light.settings.buttons
				v.TextColor3 = Colors.light.settings.textcolor
			elseif v:IsA("TextLabel") then
				v.TextColor3 = Colors.light.settings.textcolor
			end
		end
	end
	for _, v in pairs(script.Parent.Settings.MainContext:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextLabel") then
				v.TextColor3 = Colors.light.settings.textcolor
			elseif v:IsA("Frame") then
				v.BackgroundColor3 = Colors.light.settings.interactionmenus
			end
		end
	end
	script.Parent.Menu.BackgroundColor3 = Colors.light.menu.windowborder
	script.Parent.Menu.Frame.BackgroundColor3 = Colors.light.menu.windowborder
	script.Parent.Menu.Version.BackgroundColor3 = Colors.light.menu.windowborder
	script.Parent.Menu.Version.TextLabel.TextColor = Colors.light.menu.textcolor
	script.Parent.Menu.Frame.TextLabel = Colors.light.menu.windowborder
	for _, v in pairs(script.Parent.Menu:GetDescendants()) do
		if v:IsA("GuiObject") then
			if v:IsA("TextButton") then
				v.BackgroundColor3 = Colors.light.menu.buttons
				v.TextColor3 = Colors.light.menu.textcolor
			elseif v:IsA("TextLabel") then
				v.TextColor3 = Colors.light.menu.textcolor
			end
		end
	end
	script.Parent.Settings.ActionBar.BackgroundColor3 = Colors.light.settings.interactionmenus
	script.Parent.Settings.InteractionMenu.BackgroundColor3 = Colors.light.settings.interactionmenus
	script.Parent.Settings.MainContext.BackgroundColor3 = Colors.light.settings.interactionmenus
	script.Parent.Settings.MainContext.Appearance.Dark.BackgroundColor3 = buttoncolors.disabled
	script.Parent.Settings.MainContext.Appearance.Light.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Appearance.Light.Active = false
	script.Parent.Settings.MainContext.Appearance.Light.Active = true
end)


script.Parent.Settings.MainContext.Appearance.MenuFull.MouseButton1Click:Connect(function()
	script.Parent.MenuButton.Visible = true
	script.Parent.MiniMenu.Visible = false
	script.Parent.QuestsButton.Position = UDim2.new(0.121, 0, 0.947, 0)
	script.Parent.Settings.MainContext.Appearance.MenuMini.BackgroundColor3 = buttoncolors.disabled
	script.Parent.Settings.MainContext.Appearance.MenuFull.BackgroundColor3 = buttoncolors.enabled
end)


script.Parent.Settings.MainContext.Appearance.MenuMini.MouseButton1Click:Connect(function()
	script.Parent.MenuButton.Visible = false
	script.Parent.MiniMenu.Visible = true
	script.Parent.QuestsButton.Position = UDim2.new(0.05, 0, 0.947, 0)
	script.Parent.Settings.MainContext.Appearance.MenuFull.BackgroundColor3 = buttoncolors.disabled
	script.Parent.Settings.MainContext.Appearance.MenuMini.BackgroundColor3 = buttoncolors.enabled
end)



script.Parent.Settings.MainContext.Accessibility.ShakeOn.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Accessibility.ShakeOn.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Accessibility.ShakeItOff.BackgroundColor3 = buttoncolors.disabled
	script.Parent.IsShakeOn.Value = true
end)


script.Parent.Settings.MainContext.Accessibility.ShakeItOff.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Accessibility.ShakeItOff.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Accessibility.ShakeOn.BackgroundColor3 = buttoncolors.disabled
	script.Parent.IsShakeOn.Value = false
end)

ReplicatedStorage.Events.General.WoopShocking.OnClientEvent:Connect(function()
	if script.Parent.IsShakeOn.Value == true then
		local function ShakeCamera(shakeCf)
			-- shakeCf: CFrame value that represents the offset to apply for shake effect.
			-- Apply the effect:
			camera.CFrame = camera.CFrame * shakeCf
		end

		-- Create CameraShaker instance:
		local renderPriority = Enum.RenderPriority.Camera.Value + 0.85
		local camShake = CameraShaker.new(renderPriority, ShakeCamera)

		camShake:Start()

		local shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Explosion)
		script.Parent.IsShakeOn.Changed:Connect(function(bool)
			if bool == false then
				shakeInstance:Stop()
			end
		end)
		wait(2)
		shakeInstance:StartFadeOut(3) -- Argument is the fadeout time
	end
end)


ReplicatedStorage.Events.General.WeExploded.OnClientEvent:Connect(function()
	if script.Parent.IsShakeOn.Value == true then
		local function ShakeCamera(shakeCf)
			-- shakeCf: CFrame value that represents the offset to apply for shake effect.
			-- Apply the effect:
			camera.CFrame = camera.CFrame * shakeCf
		end

		-- Create CameraShaker instance:
		local renderPriority = Enum.RenderPriority.Camera.Value + 1.05
		local camShake = CameraShaker.new(renderPriority, ShakeCamera)

		camShake:Start()

		local shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Explosion)
		script.Parent.IsShakeOn.Changed:Connect(function(bool)
			if bool == false then
				shakeInstance:Stop()
			end
		end)
		wait(8)
		shakeInstance:StartFadeOut(10) -- Argument is the fadeout time
	end
end)


ReplicatedStorage.RemotesEvents.GuiEvents.CutsceneEvent.OnClientEvent:Connect(function(type)
	if type == "StartupCutscene" then
		player.PlayerScripts.Cutscenes.Startup.Disabled = false
		script.Parent.Skip.Visible = true
	elseif type == "Shutdown" then
		player.PlayerScripts.Cutscenes.Shutdown.Disabled = false
		task.wait(10)
		script.Parent.Skip.Visible = true
	elseif type == "ItsActuallyShuttingDown" then
		player.PlayerScripts.Cutscenes.ShuttingOff.Disabled = false
	elseif type == "High_StartupCutscene" then
		player.PlayerScripts.Cutscenes.Startup_High.Disabled = false
		script.Parent.Skip.Visible = true
	end
end)

script.Parent.Skip.MouseButton1Click:Connect(function()
	fixcam()
	script.Parent.Parent.Click:Play()
	player.PlayerScripts.Cutscenes.Startup.Disabled = true
	player.PlayerScripts.Cutscenes.Shutdown.Disabled = true
	player.PlayerScripts.Cutscenes.ShuttingOff.Disabled = true
	player.PlayerScripts.Cutscenes.Startup_High.Disabled = true
	script.Parent.Skip.Visible = false
	script.Parent.Cine.Visible = false
	starterGui:SetCore("TopbarEnabled", true)
	starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
end)

script.Parent.MiniMenu.MouseButton1Click:Connect(function()
	if menu == true then
		script.Parent.Menu.Visible = true
		script.Parent.Parent.Click:Play()
		if UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled
			and not UIS.GamepadEnabled and not GuiService:IsTenFootInterface() then
			script.Parent.Menu:TweenPosition(UDim2.new(0.007, 0, 0.399, 0))
		else
			script.Parent.Menu:TweenPosition(UDim2.new(0.007, 0, 0.399, 0))
		end
		task.wait(0.05)
		menu = false
	elseif menu == false then
		script.Parent.Parent.Click:Play()
		if UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled
			and not UIS.GamepadEnabled and not GuiService:IsTenFootInterface() then
			script.Parent.Menu:TweenPosition(UDim2.new(-0.25, 0, 0.399, 0))
		else
			script.Parent.Menu:TweenPosition(UDim2.new(-0.25, 0, 0.399, 0))
		end
		task.wait(0.05)
		menu = true
		task.wait(1.14)
		script.Parent.Menu.Visible = false
	end
end)

script.Parent.MenuButton.MouseButton1Click:Connect(function()
	if menu == true then
		script.Parent.Menu.Visible = true
		script.Parent.Parent.Click:Play()
		if UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled
			and not UIS.GamepadEnabled and not GuiService:IsTenFootInterface() then
			script.Parent.Menu:TweenPosition(UDim2.new(0.007, 0, 0.399, 0))
		else
			script.Parent.Menu:TweenPosition(UDim2.new(0.007, 0, 0.399, 0))
		end
		task.wait(0.05)
		menu = false
	elseif menu == false then
		script.Parent.Parent.Click:Play()
		if UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled
			and not UIS.GamepadEnabled and not GuiService:IsTenFootInterface() then
			script.Parent.Menu:TweenPosition(UDim2.new(-0.25, 0, 0.399, 0))
		else
			script.Parent.Menu:TweenPosition(UDim2.new(-0.25, 0, 0.399, 0))
		end
		task.wait(0.05)
		menu = true
		task.wait(1.14)
		script.Parent.Menu.Visible = false
	end
end)

--script.Parent.MenuButton.MouseButton1Down:Connect(function()
--	TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = blurwhenui_ison}):Play()
--	script.Parent.LongPressMenu:TweenPosition(tweenNerd.OpenPos.PositionMenu)
--	tweeny(script.Parent.LongPressMenu,0.5)
--	script.Parent.Parent.LongPress:Play()
--end)

script.Parent.MenuButton.MouseEnter:Connect(function()
	script.Parent.Parent.Hover:Play()
end)

--script.Parent.LongPressMenu.Menu.Exit.MouseButton1Click:Connect(function()
--	script.Parent.LongPressMenu:TweenPosition(tweenNerd.ClosePos.PositionMenu)
--	tweeny(script.Parent.LongPressMenu,1)
--	TweenService:Create(game.Lighting.uiBlur, TweenInfo.new(0.5), {Size = 0}):Play()
--end)

ReplicatedStorage.RemotesEvents.GuiEvents.AddFacilityStatus.OnClientEvent:Connect(function(text,sec)
	script.Parent.FacilityStatus.txt.TextLabel.Text = text
	script.Parent.FacilityStatus:TweenPosition(UDim2.new(0.102, 0, 0.056, 0))
	script.Parent.Countdown:TweenPosition(UDim2.new(0.338, 0, 0.173, 0))
	for z = sec,0,-1 do
		script.Parent.FacilityStatus.Frame.close.Text = "Closes in "..z.." seconds."
		if z == 1 then
			script.Parent.FacilityStatus.Frame.close.Text = "Closes in 1 second."
		end
		if z == 0 then
			script.Parent.FacilityStatus.Frame.close.Text = "Closes in 0 seconds."
			script.Parent.FacilityStatus:TweenPosition(UDim2.new(0.102, 0,-0.23, 0))
			script.Parent.Countdown:TweenPosition(UDim2.new(0.338, 0,0.03, 0))
		end
		wait(1)
	end
end)


ReplicatedStorage.RemotesEvents.GuiEvents.Cinematic.OnClientEvent:Connect(function(visible)
	if visible == true then
		script.Parent.Cine.Visible = true
	elseif visible == false then
		script.Parent.Cine.Visible = false
	end
end)


ReplicatedStorage.RemotesEvents.GuiEvents.GotOreEvent.OnClientEvent:Connect(function(ore)
	if ore == "Ruby" then
		script.Parent.Parent.Hooray:Play()
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Ruby, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 8}):Play()
		task.wait(5)
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Ruby, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 0}):Play()
	elseif ore == "Phantom" then
		script.Parent.Parent.Hooray:Play()
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Phantom, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 8}):Play()
		task.wait(5)
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Phantom, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 0}):Play()
	elseif ore == "Iron" then
		script.Parent.Parent.Hooray:Play()
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Iron, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 8}):Play()
		task.wait(5)
		game:GetService("TweenService"):Create(script.Parent.Resources["*OreList"].Frame.Iron, TweenInfo.new(0.5,Enum.EasingStyle.Linear), {BorderSizePixel = 0}):Play()
	end
end)



script.Parent.Resources.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.Resources.Visible = false
	uiClose()
end)

script.Parent.CaveUIResearchUI.Inventory.Frame.TextButton.MouseButton1Click:Connect(function()
	uiOpen()
	script.Parent.Resources.Visible = true
end)


script.Parent.HeyHey.InteractionMenu.MiningOutCreate.MouseButton1Click:Connect(function()
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = false
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = true
	script.Parent.HeyHey.InteractionMenu.ChooseOp.Text = "Mine Cave #1"
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = true
	TypeOfJob.Value = "Cave"
end)

script.Parent.HeyHey.InteractionMenu.FacilLobby.MouseButton1Click:Connect(function()
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = true
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = false
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = true
	script.Parent.HeyHey.InteractionMenu.ChooseOp.Text = "Lobby"
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = true
	TypeOfJob.Value = "Lobby"

end)

script.Parent.HeyHey.InteractionMenu.ControlTheReactor.MouseButton1Click:Connect(function()
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = true
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = false
	script.Parent.HeyHey.InteractionMenu.ChooseOp.Text = "Control the Reactor"
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = true
	TypeOfJob.Value = "Reactor"
end)

script.Parent.HeyHey.InteractionMenu.ExploreOutdoor.MouseButton1Click:Connect(function()
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = true
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = false
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = true
	script.Parent.HeyHey.InteractionMenu.ChooseOp.Text = "Hangout / Explore the Outdoors"
	TypeOfJob.Value = "Outdoors"

end)


script.Parent.HeyHey.InteractionMenu.Trains.MouseButton1Click:Connect(function()
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = true
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = false
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = true
	script.Parent.HeyHey.InteractionMenu.ChooseOp.Text = "Trains"
	TypeOfJob.Value = "Trains"
end)


script.Parent.HeyHey.InteractionMenu.Frame.Choose.MouseButton1Click:Connect(function()
	camera.CameraType = Enum.CameraType.Custom
	starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)
	game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	player.PlayerScripts.ChoosersPoosers.MineCreateOwnCave.Disabled = true
	player.PlayerScripts.ChoosersPoosers.KillMonsters.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.ControlReactors.Disabled = true
	player.PlayerScripts.ChoosersPoosers.Trains.Disabled = true
	script.Parent.ClientHandler.LocalScript:Destroy()
	workspace.World.Objects.Facility.TemporaryShow:ClearAllChildren()
	script.Parent.HeyHey.Visible = false
	if TypeOfJob.Value == "Cave" then
		teleport("Mining")
		script.Parent.AchievementUIs.Mining.Visible = true
	elseif TypeOfJob.Value == "Bombs" then
		teleport("Bomb")
		script.Parent.AchievementUIs.CrackOutBombs.Visible = true
	elseif TypeOfJob.Value == "Outdoors" then
		script.Parent.AchievementUIs.Explore.Visible = true
	elseif TypeOfJob.Value == "Lobby" then
		teleport("Lobby")
	elseif TypeOfJob.Value == "Trains" then
		teleport("Trains")
		script.Parent.AchievementUIs.Welcome.Visible = true
	elseif TypeOfJob.Value == "Reactor" then
		teleport("Reactor")
		script.Parent.AchievementUIs.CTRLReactor.Visible = true		
	end
end)


-- then quick spawning

script.Parent.QuickSpawn.InteractionMenu.MiningOutCreate.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.InteractionMenu.ChooseOp.Text = "Mine Cave #1"
	TypeOfJob.Value = "Cave1"
end)

script.Parent.QuickSpawn.InteractionMenu.ExploreOutdoor.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.InteractionMenu.ChooseOp.Text = "Outdoors"
	TypeOfJob.Value = "Outside"
end)

script.Parent.QuickSpawn.InteractionMenu.ControlTheReactor.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.InteractionMenu.ChooseOp.Text = "Control the Primary Reactor"
	TypeOfJob.Value = "PrimaryReactorControlRoom"
end)

script.Parent.QuickSpawn.InteractionMenu.KillSumMonster.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.InteractionMenu.ChooseOp.Text = "Space Travel"
	TypeOfJob.Value = "SpaceTravel"
end)



script.Parent.QuickSpawn.InteractionMenu.Frame.Choose.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.Visible = false
	if TypeOfJob.Value == "Cave1" then
		ReplicatedStorage.RemotesEvents.GameEvents.SetSpawnEvent:FireServer(TypeOfJob.Value)
	elseif TypeOfJob.Value == "Outside" then
		ReplicatedStorage.RemotesEvents.GameEvents.SetSpawnEvent:FireServer(TypeOfJob.Value)
	elseif TypeOfJob.Value == "PrimaryReactorControlRoom" then
		ReplicatedStorage.RemotesEvents.GameEvents.SetSpawnEvent:FireServer(TypeOfJob.Value)
		script.Parent.AchievementUIs.Welcome.Visible = true
	elseif TypeOfJob.Value == "SpaceTravel" then
		ReplicatedStorage.RemotesEvents.GameEvents.SetSpawnEvent:FireServer(TypeOfJob.Value)
	end
end)

-- about
script.Parent.Menu.About.MouseButton1Click:Connect(function()
	script.Parent.About.Visible = true
	uiOpen()
	tweeny(script.Parent.About,0)
	script.Parent.About:TweenPosition(UDim2.new(0.175, 0,0.219, 0),"Out","Quad",0.28)
end)

script.Parent.About.InteractionMenu.Exit.MouseButton1Click:Connect(function()
	tweeny(script.Parent.About,1)
	uiClose()
	script.Parent.About:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	wait(0.3)
	script.Parent.About.Visible = false
end)

--feedback
script.Parent.Menu.Feedback.MouseButton1Click:Connect(function()
	script.Parent.Feedback.Visible = true
	tweeny(script.Parent.Feedback,0)
	uiOpen()
	script.Parent.Feedback:TweenPosition(UDim2.new(0.175, 0,0.219, 0),"Out","Quad",0.28)
end)

script.Parent.Feedback.InteractionMenu.SendExitChoices.Exit.MouseButton1Click:Connect(function()
	tweeny(script.Parent.Feedback,1)
	uiClose()
	script.Parent.Feedback:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	wait(0.3)
	script.Parent.Feedback.Visible = false
end)

--donate
script.Parent.Menu.Donate.MouseButton1Click:Connect(function()
	script.Parent.Donate.Visible = true
	uiOpen()
	tweeny(script.Parent.Donate,0)
	script.Parent.Donate:TweenPosition(UDim2.new(0.175, 0,0.219, 0),"Out","Quad",0.28)
end)

script.Parent.Donate.InteractionMenu.Exit.MouseButton1Click:Connect(function()
	tweeny(script.Parent.Donate,1)
	uiClose()
	script.Parent.Donate:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	wait(0.3)
	script.Parent.Donate.Visible = false
end)


-- credits

script.Parent.Menu.QuickSpawn.MouseButton1Click:Connect(function()
	script.Parent.QuickSpawn.Visible = true
end)

script.Parent.Menu.Credits.MouseButton1Click:Connect(function()
	script.Parent.Credits.Visible = true
	uiOpen()
	tweeny(script.Parent.Credits,0)
	script.Parent.Credits:TweenPosition(UDim2.new(0.175, 0,0.219, 0),"Out","Quad",0.28)
end)

script.Parent.Credits.InteractionMenu.Exit.MouseButton1Click:Connect(function()
	tweeny(script.Parent.Credits,1)
	uiClose()
	script.Parent.Credits:TweenPosition(UDim2.new(0.175, 0,0.230, 0),"Out","Quad",0.28)
	wait(0.3)
	script.Parent.Credits.Visible = false
end)


script.Parent.AchievementUIs.CrackOutBombs.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.CrackOutBombs.Visible = false
	uiClose()
end)

script.Parent.AchievementUIs.Mining.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.Mining.Visible = false
	uiClose()
end)

script.Parent.AchievementUIs.Explore.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.Explore.Visible = false
	uiClose()
end)


script.Parent.AchievementUIs.Mining.InteractionMenu.ExitFrame.Navigate.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.Mining.Visible = false
	navigation(true,"Mining")
	script.Parent.ExitNavigation.Visible = true
end)

script.Parent.AchievementUIs.CrackOutBombs.InteractionMenu.ExitFrame.Navigate.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.CrackOutBombs.Visible = false
	navigation(true,"Bomb")
	script.Parent.ExitNavigation.Visible = true
end)

script.Parent.AchievementUIs.CTRLReactor.InteractionMenu.ExitFrame.Navigate.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.CTRLReactor.Visible = false
	navigation(true,"Reactor")
	script.Parent.ExitNavigation.Visible = true
end)


script.Parent.AchievementUIs.CTRLReactor.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.CTRLReactor.Visible = false
end)

script.Parent.AchievementUIs.Welcome.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.Welcome.Visible = false
end)


ReplicatedStorage.RemotesEvents.GuiEvents.Captions.OnClientEvent:Connect(function(txt,duration)
	script.Parent.Captions.Text = txt
	wait(duration)
	script.Parent.Captions.Text = ""
end)

script.Parent.Settings.ActionBar.TextButton.MouseButton1Click:Connect(function()
	if script.Parent.Parent:FindFirstChild("Intro") then
		script.Parent.Parent.Intro.Intro.Visible = true
	end
	tweeny(script.Parent.Settings,1)
	uiClose()
	script.Parent.Settings:TweenPosition(UDim2.new(0.147, 0, 0.136, 0),"Out","Quad",0.28)
	wait(0.3)
	script.Parent.Settings.Visible = false
	script.Parent.Settings.MainContext.Visible = false
end)

script.Parent.Parent.SurfaceGui.ElectricalSystemStartupOnly.TextButton.MouseButton1Click:Connect(function()
	-- check to see if place id matches the place ; whether the branch would be internal, q/a testers or stable 
	local id = bombdecoderplaces.stable --The ID of where you would like to teleport
	ts:Teleport(id, player) --Teleport the player
	script.Parent.BombDecoderTeleport.Visible = true
end)


script.Parent.ExitNavigation.MouseButton1Click:Connect(function()
	navigation(false)
end)

ReplicatedStorage.Events.DisasterClient.OnClientEvent:Connect(function(isonorno)
	if isonorno == true then
		script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value = true
		script.Parent.MixIngredients.SubstanceOre.OvrLodTip.Visible = true
		script.Parent.CombineMenu.OvrLodTip.Visible = true

		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.Day:Play()
		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.BirdChirp:Play()
		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.CricketChirp:Stop()
		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.Night:Stop()
		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.Wind:Stop()
		Players.LocalPlayer.PlayerGui.LocalMusic.Outside.NightChristmas:Stop()


	elseif isonorno == false then
		script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value = false
		script.Parent.MixIngredients.SubstanceOre.OvrLodTip.Visible = false
		script.Parent.CombineMenu.OvrLodTip.Visible = false
	end
end)

ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController.OnClientEvent:Connect(function(uitype,en_dis)
	if uitype == "Countdown" and en_dis == true then
		script.Parent.Countdown.Visible = true
		wait(0.23)
		script.Parent.Countdown.Visible = false
		wait(0.1)
		script.Parent.Countdown.Visible = true
		wait(0.2)
		script.Parent.Countdown.Visible = false
		wait(1)
		script.Parent.Countdown.Visible = true
	elseif uitype == "Countdown" and en_dis == false then
		script.Parent.Countdown.Visible = true
		wait(0.01)
		script.Parent.Countdown.Visible = false
		wait(0.1)
		script.Parent.Countdown.Visible = true
		wait(0.01)
		script.Parent.Countdown.Visible = false
	elseif uitype == "MeltdownHappening" and en_dis == nil then
		TweenService:Create(game.Lighting.PostCorrection, TweenInfo.new(3), {TintColor = redonmelt}):Play()
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {FieldOfView = 64}):Play()
		task.wait(3.95)
		TweenService:Create(game.Lighting.PostCorrection, TweenInfo.new(2), {TintColor = uiColorDecreaseProperties.ResetTintColor}):Play()
		TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(1.5), {FieldOfView = 70}):Play()
	end
end)

ReplicatedStorage.RemotesEvents.GuiEvents.CountdownText.OnClientEvent:Connect(function(text)
	script.Parent.Countdown.Frame.TextLabel.Text = "T-"..text
end)


game.Workspace.GameData:WaitForChild("EcoCC",3).ReactorStats.CoreTemp.Changed:Connect(function(val)
	if val >= 3260 then
		ReplicatedStorage.RemotesEvents.BadgeRewards:FireServer("melt")
	elseif val >= 9000000 then
		ReplicatedStorage.RemotesEvents.BadgeRewards:FireServer("overload")
	end
end)

ReplicatedStorage.Events.Nuclear.TheCoreExplode.OnClientEvent:Connect(function(explosion)
	if explosion == true and player.Bunker.Value == false then
		TweenService:Create(game.Lighting.Blur, TweenInfo.new(3), {Size = explosionblur.explosion}):Play()
		TweenService:Create(game.Lighting.client, TweenInfo.new(3), {Brightness = 0.85}):Play()
		explosionEnd()
		task.wait(1.35)
		TweenService:Create(game.Lighting.Blur, TweenInfo.new(10), {Size = explosionblur.normal}):Play()
		task.wait(5)
		TweenService:Create(game.Lighting.client, TweenInfo.new(3), {Brightness = 0}):Play()
	elseif  explosion == true and player.Bunker.Value == true then
		script.Parent.Parent.LocalMusic.blast:Play()
		TweenService:Create(game.Lighting.Blur, TweenInfo.new(3), {Size = explosionblur.bunkerblurexp}):Play()
		task.wait(1.35)
		TweenService:Create(game.Lighting.Blur, TweenInfo.new(10), {Size = explosionblur.normal}):Play()
	end
end)

player:WaitForChild("leaderstats"):WaitForChild("Eco",7).Changed:Connect(function(current)
	script.Parent.Menu.FourCoins.TextLabel.Text = current.." Eco"
end)
if level_notload == false then
	player.Level.Changed:Connect(function(current)
		if current >= 1 then
			if workspace.AreaBlockOff:WaitForChild("BlockOff_CTRLR_Lvl4",5) then
				workspace.AreaBlockOff.BlockOff_CTRLR_Lvl4:Destroy()
				if workspace.AreaBlockOff:WaitForChild("BlockOff_CTRLR_Lvl2",5) then
					workspace.AreaBlockOff.BlockOff_CTRLR_Lvl2:Destroy()
				end
			end		
		elseif current >= 2 then
			if workspace.AreaBlockOff:WaitForChild("BlockOff_CTRLR_Lvl2",5) then
				workspace.AreaBlockOff.BlockOff_CTRLR_Lvl2:Destroy()
			end	
		end

		if player.Level.Value >= 1 and player.Level.Value <= 4 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level1to4.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[2]
		elseif player.Level.Value >= 4 and player.Level.Value <= 8 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level4to8.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[3]
		elseif player.Level.Value >= 9 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level9orMore.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[4]
		elseif player.Level.Value == 0 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[1]
		end

		script.Parent.Level.Text = "Level "..current
	end)
	player.Level:WaitForChild("Experience_Current",9).Changed:Connect(function(current)	
		if player.Level.Value >= 1 and player.Level.Value <= 4 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[2]
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level1to4.Image
		elseif player.Level.Value >= 4 and player.Level.Value <= 8 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[3]
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level4to8.Image
		elseif player.Level.Value >= 9 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level9orMore.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[4]
		else
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level0.Image
			script.Parent.YourLevel.MainContext.LevelContex.LevelQuote.Text = LevelQuotes[1]
		end
		script.Parent.YourLevel.MainContext.LevelContex.Level.Text = "Level "..player.Level.Value
		script.Parent.YourLevel.MainContext.LevelContex.Frame.Level_ExpToMax.Text = player.Level.Experience_Current.Value.." exp / "..player.Level.Experience_Max.Value.." exp"
	end)
	player.Level.Experience_Max.Changed:Connect(function(current)
		if player.Level.Value >= 1 and player.Level.Value <= 4 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level1to4.Image
		elseif player.Level.Value >= 4 and player.Level.Value <= 8 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level4to8.Image
		elseif player.Level.Value >= 9 then
			script.Parent.YourLevel.MainContext.LevelContex.LevelCartoonImage.Image = LevelImages.Level9orMore.Image
		end
		script.Parent.YourLevel.MainContext.LevelContex.Frame.Level_ExpToMax.Text = player.Level.Experience_Current.Value.." exp / "..player.Level.Experience_Max.Value.." exp"
	end)
end

script.Parent.Donate.InteractionMenu.DonateButtons["10Robux"].MouseButton1Click:Connect(function()

	game:GetService("MarketplaceService"):PromptProductPurchase(player,1256027063)

end)
script.Parent.Donate.InteractionMenu.DonateButtons["100Robux"].MouseButton1Click:Connect(function()
	game:GetService("MarketplaceService"):PromptProductPurchase(player,1256027086)

end)


-- Settings Functionality
script.Parent.Menu.Settings.MouseButton1Click:Connect(function()
	script.Parent.Settings.Visible = true
	script.Parent.Settings.MainContext.Visible = true
	uiOpen()
	script.Parent.Settings:TweenPosition(UDim2.new(0.147, 0, 0.13, 0),"Out","Quad",0.28)
	tweeny(script.Parent.Settings,0)
end)

script.Parent.Menu.Shop.MouseButton1Click:Connect(function()
	script.Parent.ShopUI.Visible = true
	uiOpen()
	script.Parent.LocalMusic.PreloadingAndShopTheme:Play()
end)

local Settings = script.Parent.Settings

Settings.InteractionMenu.Accessibility.MouseButton1Click:Connect(function()
	Settings.MainContext.Accessibility.Visible = true
	Settings.MainContext.Audio.Visible = false
	Settings.MainContext.Performance.Visible = false
	Settings.MainContext.Others.Visible = false
	Settings.MainContext.Appearance.Visible = false
	Settings.ActionBar.TextLabel.Text = "Accessibility"
end)

Settings.InteractionMenu.Audio.MouseButton1Click:Connect(function()
	Settings.MainContext.Accessibility.Visible = false
	Settings.MainContext.Audio.Visible = true
	Settings.MainContext.Performance.Visible = false
	Settings.MainContext.Others.Visible = false
	Settings.MainContext.Appearance.Visible = false
	Settings.ActionBar.TextLabel.Text = "Audio"
end)

Settings.InteractionMenu.Performance.MouseButton1Click:Connect(function()
	Settings.MainContext.Accessibility.Visible = false
	Settings.MainContext.Audio.Visible = false
	Settings.MainContext.Performance.Visible = true
	Settings.MainContext.Others.Visible = false
	Settings.MainContext.Appearance.Visible = false
	Settings.ActionBar.TextLabel.Text = "Performance"
end)

Settings.InteractionMenu.Others.MouseButton1Click:Connect(function()
	Settings.MainContext.Accessibility.Visible = false
	Settings.MainContext.Audio.Visible = false
	Settings.MainContext.Performance.Visible = false
	Settings.MainContext.Others.Visible = true
	Settings.MainContext.Appearance.Visible = false
	Settings.ActionBar.TextLabel.Text = "Others"
end)


Settings.InteractionMenu.Appearance.MouseButton1Click:Connect(function()
	Settings.MainContext.Accessibility.Visible = false
	Settings.MainContext.Audio.Visible = false
	Settings.MainContext.Performance.Visible = false
	Settings.MainContext.Others.Visible = true
	Settings.MainContext.Appearance.Visible = true
	Settings.ActionBar.TextLabel.Text = "Appearance"
end)

Settings.MainContext.Accessibility.ReducedOff.MouseButton1Click:Connect(function()
	script.Parent.IsAnimationsReduced.Value = false
	Settings.MainContext.Accessibility.ReducedOff.BackgroundColor3 = buttoncolors.enabled
	Settings.MainContext.Accessibility.ReducedOn.BackgroundColor3 = buttoncolors.disabled
end)

Settings.MainContext.Accessibility.ReducedOn.MouseButton1Click:Connect(function()
	script.Parent.IsAnimationsReduced.Value = true
	Settings.MainContext.Accessibility.ReducedOff.BackgroundColor3 = buttoncolors.disabled
	Settings.MainContext.Accessibility.ReducedOn.BackgroundColor3 = buttoncolors.enabled
end)



Settings.MainContext.Accessibility.CaptionsOff.MouseButton1Click:Connect(function()
	script.Parent.Captions.Visible = false
	Settings.MainContext.Accessibility.CaptionsOff.BackgroundColor3 = buttoncolors.enabled
	Settings.MainContext.Accessibility.CaptionsOn.BackgroundColor3 = buttoncolors.disabled
end)

Settings.MainContext.Accessibility.CaptionsOn.MouseButton1Click:Connect(function()
	script.Parent.Captions.Visible = true
	Settings.MainContext.Accessibility.CaptionsOff.BackgroundColor3 = buttoncolors.disabled
	Settings.MainContext.Accessibility.CaptionsOn.BackgroundColor3 = buttoncolors.enabled
end)

Settings.MainContext.Performance.SHDWS_On.MouseButton1Click:Connect(function()
	game.Lighting.GlobalShadows = true
	CleanupPerformance.EnableLowQuality("castshadow")
	Settings.MainContext.Performance.SHDWS_On.BackgroundColor3 = buttoncolors.enabled
	Settings.MainContext.Performance.SHDWS_Off.BackgroundColor3 = buttoncolors.disabled
end)

Settings.MainContext.Performance.SHDWS_Off.MouseButton1Click:Connect(function()
	game.Lighting.GlobalShadows = false
	CleanupPerformance.DisableLowQuality("castshadow")
	Settings.MainContext.Performance.SHDWS_On.BackgroundColor3 = buttoncolors.disabled
	Settings.MainContext.Performance.SHDWS_Off.BackgroundColor3 = buttoncolors.enabled
end)



Settings.MainContext.Performance.AICars_On.MouseButton1Click:Connect(function()
	script.Parent.AISystemCore.Disabled = false
	Settings.MainContext.Performance.AICars_On.BackgroundColor3 = buttoncolors.enabled
	Settings.MainContext.Performance.AICars_Off.BackgroundColor3 = buttoncolors.disabled
end)

Settings.MainContext.Performance.AICars_Off.MouseButton1Click:Connect(function()
	script.Parent.AISystemCore.Disabled = true
	Settings.MainContext.Performance.AICars_On.BackgroundColor3 = buttoncolors.disabled
	Settings.MainContext.Performance.AICars_On.BackgroundColor3 = buttoncolors.enabled
end)

Settings.MainContext.Others.InsRespawnOff.MouseButton1Click:Connect(function()
	ReplicatedStorage.Events.FourVIPEvent:FireServer("respawn","5sec")
	Settings.MainContext.Others.InsRespawnOff.BackgroundColor3 = buttoncolors.enabled
	Settings.MainContext.Others.InsRespawnOn.BackgroundColor3 = buttoncolors.disabled
end)

Settings.MainContext.Others.InsRespawnOn.MouseButton1Click:Connect(function()
	ReplicatedStorage.Events.FourVIPEvent:FireServer("respawn","instant")
	Settings.MainContext.Others.InsRespawnOff.BackgroundColor3 = buttoncolors.disabled
	Settings.MainContext.Others.InsRespawnOn.BackgroundColor3 = buttoncolors.enabled
end)



script.Parent.Menu.Tutorial.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Visible = true
end)


local combinations = {

	['RubyPhantom'] = 'SpellSwiftness',
	['IronRuby'] = 'SpellKangaroo',
	['RubyRock'] = 'Awkward',
	['PhantomCarbon'] = 'Bottle of Magic',
	['RubyCoolant'] = 'LiqInstant',
	['HydrogenRuby'] = 'OverloHeat',


}


local buttons = {}

for _, button in pairs(script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame:GetChildren()) do
	if button:IsA('ImageButton') then
		button.MouseButton1Click:Connect(function()
			local crystal = script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame:FindFirstChild(button.Name)
			if crystal then
				if slot1:GetAttribute("Free") == true then
					slot1.Image = crystal.Image
					slot1:SetAttribute("Crystal",crystal.Name)
					slot1:SetAttribute("Free",false)
				elseif slot2:GetAttribute("Free") == true then
					slot2.Image = crystal.Image
					slot2:SetAttribute("Crystal",crystal.Name)
					slot2:SetAttribute("Free",false)
				end
			end
		end)
	end
end

script.Parent.CombineMenu.InteractionMenu.ExitFrame.Clear.MouseButton1Click:Connect(function()
	slot1.Image = 'rbxassetid://0'
	slot2.Image = 'rbxassetid://0'
	result.Image = 'rbxassetid://0'
	slot1:SetAttribute("Free",true)
	slot2:SetAttribute("Free",true)
	slot1:SetAttribute("Crystal","")
	slot2:SetAttribute("Crystal","")
end)

script.Parent.CombineMenu.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.CombineMenu.Visible = false
	uiClose()
end)


script.Parent.CombineMenu.InteractionMenu.ExitFrame.Forge.MouseButton1Click:Connect(function()
	local combo = slot1:GetAttribute("Crystal")..slot2:GetAttribute("Crystal")
	if combinations[combo] then
		result.Image = script.Parent.CombineMenu.IngredientMenu.InteractionMenu:FindFirstChild(combinations[combo]).Image
		game.ReplicatedStorage.RemotesEvents.GameEvents.MiningCrafting.ForgeEvent:FireServer(combinations[combo]) -- Hackers, the server-side script is protected. It checks if you actually have the vaild resources.
	else
		result.Image = 'rbxassetid://8420109354'
	end
end)


ReplicatedStorage.RemotesEvents.GuiEvents.AddAchievement.OnClientEvent:Connect(function(type)
	if type == "Startup" then
		script.Parent.AchievementUIs.YouStarted.Visible = true
	elseif type == "Shutdown" then
		script.Parent.AchievementUIs.ReactorShutdown.Visible = true
	elseif type == "Exploded" then
		script.Parent.AchievementUIs.JustExploded.Visible = true
		script.Parent.AchievementUIs.JustExploded.InteractionMenu.ExitFrame.Exit.Visible = false
		task.wait(10)
		script.Parent.AchievementUIs.JustExploded.InteractionMenu.ExitFrame.Exit.Visible = true
	end
end)

script.Parent.AchievementUIs.JustExploded.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.JustExploded.Visible = false
end)

-- TODO: Redo entire Tutorial System; make it interactive
task.wait(1)
player:WaitForChild("Inventory",3)
player.Inventory:WaitForChild("Carbon",9).Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Carbon.Text = new.." Carbon"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Carbon.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Carbon.Visible = true
	end
end)
player.Inventory:WaitForChild("Coolant",4).Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Coolant.Text = new.." Coolant"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Coolant.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Coolant.Visible = true
	end
end)
player.Inventory:WaitForChild("H2O",3).Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.H2O.Text = new.." H2O"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.H2O.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.H2O.Visible = true
	end
end)
player.Inventory:WaitForChild("Iron").Changed:Connect(function(new)
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron").BillboardGui.TextLabel.Text = "Unlocked Iron Pick!"
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron2").BillboardGui.TextLabel.Text = "Unlocked Iron Pick!"
	script.Parent.Resources["*OreList"].Frame.Iron.Text = new.." Iron"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Iron.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Iron.Visible = true
	end
	if new >= 3 then
		script.Parent.Resources.PickMenu.ironpick.Text = "Unlocked Iron Pick!"
	elseif new <= 3 then
		script.Parent.Resources.PickMenu.ironpick.Text = 3-new.." Iron in order to get Iron Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron").BillboardGui.TextLabel.Text = "Must have "..10-new.." more Iron Ores to get this."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedIron2").BillboardGui.TextLabel.Text = "Must have "..10-new.." more Iron Ores to get this."
	end
end)
player.Inventory:WaitForChild("Oxygen").Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Oxygen.Text = new.." Oxygen"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Oxygen.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Oxygen.Visible = true
	end
end)
player.Inventory:WaitForChild("Ruby").Changed:Connect(function(new)
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby",2).BillboardGui.TextLabel.Text = "Unlocked Ruby Pick!"
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby2",4).BillboardGui.TextLabel.Text = "Unlocked Ruby Pick!"
	script.Parent.Resources["*OreList"].Frame.Ruby.Text = new.." Ruby"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Ruby.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Ruby.Visible = true
	end
	if new >= 10 then
		script.Parent.Resources.PickMenu.rubypick.Text = "Unlocked Ruby Pick!"
	elseif new <= 10 then
		script.Parent.Resources.PickMenu.rubypick.Text = 10-new.." Ruby in order to get Ruby Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby",2).BillboardGui.TextLabel.Text = "Must have "..10-new.." more Ruby Ores to get this."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedRuby2",4).BillboardGui.TextLabel.Text = "Must have "..5-new.." more Ruby Ores to get Ruby Pick."
	end
end)
player.Inventory:WaitForChild("Phantom",3).Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Phantom.Text = new.." Phantom"
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom",4).BillboardGui.TextLabel.Text = "Unlocked Phantom Pick!"
	workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom2",4).BillboardGui.TextLabel.Text = "Must have "..5-new.." more Phantom Ores to get Phantom Pick."
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Phantom.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Phantom.Visible = true
	end
	if new >= 15 then
		script.Parent.Resources.PickMenu.phantompick.Text = "Unlocked Phantom Pick!"
	elseif new <= 14 then
		script.Parent.Resources.PickMenu.phantompick.Text = 15-new.." Phantom in order to get Phantom Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom",4).BillboardGui.TextLabel.Text = "Must have "..15-new.." more Phantom Ores to get Phantom Pick."
		workspace.World.Objects.Miscellaneous:WaitForChild("UnlockedPhantom2",4).BillboardGui.TextLabel.Text = "Must have "..15-new.." more Phantom Ores to get Phantom Pick."
	end
end)
player.Inventory:WaitForChild("Hydrogen").Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Hydrogen.Text = new.." Hydrogen"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Hydrogen.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Hydrogen.Visible = true
	end
end)
player.Inventory:WaitForChild("Rock").Changed:Connect(function(new)
	script.Parent.Resources["*OreList"].Frame.Rock.Text = new.." Rock"
	if new == 0 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Rock.Visible = false
	elseif new >= 1 then
		script.Parent.CombineMenu.ResourcesMenu.InteractionMenu.Frame.Rock.Visible = true
	end
end)

script.Parent.WhatCanMakeElements.SubstanceOre.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.WhatCanMakeElements.Visible = false
	uiClose()
end)
script.Parent.MixIngredients.SubstanceOre.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.MixIngredients.Visible = false
	uiClose()
end)
script.Parent.AchievementUIs.YouStarted.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.YouStarted.Visible = false
	uiClose()
end)

game.ReplicatedStorage.RemotesEvents.GuiEvents.SpellUI.OnClientEvent:Connect(function(expiry)
	if expiry == false then
		script.Parent.CaveUIResearchUI.SpellExpire.Visible = true
		for z = 200,0,-1 do
			script.Parent.CaveUIResearchUI.SpellExpire.Frame.TextLabel.Text = "Spell expires in "..z.." seconds."
			task.wait(1)
		end
	elseif expiry == true then
		script.Parent.CaveUIResearchUI.SpellMoreThanOne.Visible = true
		task.wait(4)
		script.Parent.CaveUIResearchUI.SpellMoreThanOne.Visible = false
	end
end)
script.Parent.AchievementUIs.ReactorShutdown.InteractionMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.AchievementUIs.ReactorShutdown.Visible = false
end)
script.Parent.CaveUIResearchUI.CraftingSheetMobile.Frame.TextButton.MouseButton1Click:Connect(function()
	script.Parent.CraftyGrade.Visible = true
end)
workspace.World.Objects.Facility:WaitForChild("LabAreas",4):WaitForChild("ProximityPrompt_ResearchLabMolecule",5).ProximityPrompt.Triggered:Connect(function()
	script.Parent.WhatCanMakeElements.Visible = true
	uiOpen()
end)
workspace.World.Objects.Facility:WaitForChild("LabAreas",4):WaitForChild("ProximityPrompt_ResearchLabMix",5).ProximityPrompt.Triggered:Connect(function()
	script.Parent.MixIngredients.Visible = true
	uiOpen()
end)
workspace.World.Objects.Facility:WaitForChild("LabAreas",4):WaitForChild("ProximityPrompt_ResearchLabCombine",5).ProximityPrompt.Triggered:Connect(function()
	script.Parent.CombineMenu.Visible = true
	uiOpen()
end)

script.Parent.SecretMarketUI.MainContext.Gear.GearContainer.SpellOfHeat.MouseButton1Click:Connect(function()
	script.Parent.SecretMarketUI.MainContext.Gear.GearContainer.SpellOfHeat.BorderSizePixel = 10
	selectedgear.Value = "SpellOfHeat"
end)

--script.Parent.ShopUI.MainContext.Gear.GearContainer.Clipboard.MouseButton1Click:Connect(function()
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.ReactorTablet.BorderSizePixel = 0
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Hyperbike.BorderSizePixel = 0
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Clipboard.BorderSizePixel = 10
--	selectedgear.Value = "Clipboard"
--end)
--script.Parent.ShopUI.MainContext.Gear.GearContainer.Hyperbike.MouseButton1Click:Connect(function()
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.ReactorTablet.BorderSizePixel = 0
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Hyperbike.BorderSizePixel = 10
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Clipboard.BorderSizePixel = 0	
--	selectedgear.Value = "Hyperbike"
--end)
--script.Parent.ShopUI.MainContext.Gear.GearContainer.ReactorTablet.MouseButton1Click:Connect(function()
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.ReactorTablet.BorderSizePixel = 10
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Hyperbike.BorderSizePixel = 0
--	script.Parent.ShopUI.MainContext.Gear.GearContainer.Clipboard.BorderSizePixel = 0
--	selectedgear.Value = "Reactor Tablet"
--end)

script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.ChoiceFrame.Confirm.MouseButton1Click:Connect(function()
	script.Parent.ShopUI.AreYouSure.Processsing.Visible = true
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
	task.wait(math.random(0.5,2))
	PurchaseEvent:FireServer(tools[selectedgear.Value])
	task.wait(0.02)
	selectedgear.Value = "None"
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
end)
script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.ChoiceFrame.Exit.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.ShopUI.AreYouSure.Visible = false
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
	script.Parent.ShopUI.AreYouSure.ThankYou.Visible = false
	script.Parent.ShopUI.AreYouSure.Owned.Visible = false
	script.Parent.ShopUI.AreYouSure.MoreEcoPls.Visible = false
end)
script.Parent.ShopUI.AreYouSure.ThankYou.InteractionMenu.ChoiceFrame.Ok.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.ShopUI.AreYouSure.Visible = false
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
	script.Parent.ShopUI.AreYouSure.ThankYou.Visible = false
	script.Parent.ShopUI.AreYouSure.Owned.Visible = false
	script.Parent.ShopUI.AreYouSure.MoreEcoPls.Visible = false

end)
workspace.World.Objects.Miscellaneous.VentInteractive.MainPro.ProximityPrompt.Triggered:Connect(function(plr)
	if vent == true then
		vent = false
		plr.Character.HumanoidRootPart.CFrame = (workspace.World.Objects.Facility.TeleportLocations.Teleport_ventlocoin.CFrame)
	elseif vent == false then
		vent = true
		plr.Character.HumanoidRootPart.CFrame = (workspace.World.Objects.Facility.TeleportLocations.Teleport_ventlocout.CFrame)
	end
end)

script.Parent.ShopUI.AreYouSure.Owned.InteractionMenu.ChoiceFrame.Okay.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.ShopUI.AreYouSure.Visible = false
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
	script.Parent.ShopUI.AreYouSure.ThankYou.Visible = false
	script.Parent.ShopUI.AreYouSure.Owned.Visible = false
	script.Parent.ShopUI.AreYouSure.MoreEcoPls.Visible = false
end)
script.Parent.ShopUI.AreYouSure.MoreEcoPls.InteractionMenu.ChoiceFrame.Okay.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.ShopUI.AreYouSure.Visible = false
	script.Parent.ShopUI.AreYouSure.Confirmation.Visible = false
	script.Parent.ShopUI.AreYouSure.ThankYou.Visible = false
	script.Parent.ShopUI.AreYouSure.Owned.Visible = false
	script.Parent.ShopUI.AreYouSure.MoreEcoPls.Visible = false

end)




script.Parent.Settings.MainContext.Performance.LGHT_OFF.MouseButton1Click:Connect(function()
	game.Lighting.Blur.Enabled = false
	game.Lighting.SunRays.Enabled = false
	script.Parent.Settings.MainContext.Performance.LGHT_ON.BackgroundColor3 = buttoncolors.disabled
	script.Parent.Settings.MainContext.Performance.LGHT_OFF.BackgroundColor3 = buttoncolors.enabled
end)

script.Parent.Settings.MainContext.Performance.LGHT_ON.MouseButton1Click:Connect(function()
	game.Lighting.Blur.Enabled = true
	game.Lighting.SunRays.Enabled = true
	script.Parent.Settings.MainContext.Performance.LGHT_ON.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Performance.LGHT_OFF.BackgroundColor3 = buttoncolors.disabled

end)

script.Parent.Settings.MainContext.Audio.MusicOff.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Audio.MusicOff.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Audio.MusicOn.BackgroundColor3 = buttoncolors.disabled
	game.SoundService.SongsCanMute.Volume = 0
end)

script.Parent.Settings.MainContext.Audio.MusicOn.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Audio.MusicOn.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Audio.MusicOff.BackgroundColor3 = buttoncolors.disabled
	game.SoundService.SongsCanMute.Volume = 1.985
end)


script.Parent.Settings.MainContext.Audio.sfxLimitOff.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Audio.sfxLimitOff.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Audio.sfxLimitOn.BackgroundColor3 = buttoncolors.disabled
end)

script.Parent.Settings.MainContext.Audio.sfxLimitOn.MouseButton1Click:Connect(function()
	script.Parent.Settings.MainContext.Audio.sfxLimitOn.BackgroundColor3 = buttoncolors.enabled
	script.Parent.Settings.MainContext.Audio.sfxLimitOff.BackgroundColor3 = buttoncolors.disabled
end)

local set = true

script.Parent.Settings.MainContext.Accessibility.SetCaptionBG.MouseButton1Click:Connect(function()
	if set == true then
		script.Parent.Settings.MainContext.Accessibility.SetCaptionBG.Text = "/"
		script.Parent.Captions.BackgroundTransparency = 1
		set = false
	elseif set == false then
		script.Parent.Settings.MainContext.Accessibility.SetCaptionBG.Text = "Y"
		script.Parent.Captions.BackgroundTransparency = 0.5
		set = true
	end
end)



selectedgear.Changed:Connect(function(newtooloption)
	if newtooloption == "Clipboard" then
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Price.Text = "This item is "..tools.Clipboard.Price.Value.." Eco"
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Desc.Text = "Take notes without any writing supplies."
		--script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.Title.Text = "Are you sure you want to buy "..newtooloption.."?"
	elseif newtooloption == "Reactor Tablet" then
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Desc.Text = "On the go Reactor Temperatures."
		--script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.Title.Text = "Are you sure you want to buy "..newtooloption.."?"
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Price.Text = "This item is "..tools["Reactor Tablet"].Price.Value.." Eco"
	elseif newtooloption == "SpellOfHeat" then
		--script.Parent.SecretMarketUI.MainContext.Gear.ItemDescription.Desc.Text = 'Easily heat up the reactor quickly without the "Direct Heat" nonsense.'
		--script.Parent.SecretMarketUI.AreYouSure.Confirmation.InteractionMenu.Title.Text = "Are you sure you want to buy "..newtooloption.."?"
		--script.Parent.SecretMarketUI.MainContext.Gear.ItemDescription.Price.Text = "This item is "..tools["SpellOfHeat"].Price.Value.." Eco"
	elseif newtooloption == "Hyperbike" then
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Desc.Text = "Faster than the cars we have!"
		--script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.Title.Text = "Are you sure you want to buy "..newtooloption.."?"
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Price.Text = "This item is "..tools.Hyperbike.Price.Value.." Eco"
	elseif newtooloption == "None" then
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Desc.Text = "Select an item."
		--script.Parent.ShopUI.AreYouSure.Confirmation.InteractionMenu.Title.Text = "Are you sure you want to buy "..newtooloption.."?"
		--script.Parent.ShopUI.MainContext.Gear.ItemDescription.Price.Text = "Select an item to see the price."
		--script.Parent.ShopUI.MainContext.Gear.GearContainer.ReactorTablet.BorderSizePixel = 0
		--script.Parent.ShopUI.MainContext.Gear.GearContainer.Hyperbike.BorderSizePixel = 0
		--script.Parent.ShopUI.MainContext.Gear.GearContainer.Clipboard.BorderSizePixel = 0
	end
end)

ReplicatedStorage.RemotesEvents.GuiEvents.OtherUiController.OnClientEvent:Connect(function(which,thank)
	if which == "Shop" and thank == "ThankYou" then

		script.Parent.Parent.Success:Play()
		script.Parent.ShopUI.AreYouSure.Processsing.Visible = false
		script.Parent.ShopUI.AreYouSure.ThankYou.Visible = true
	elseif which == "Shop" and thank == "Owned" then
		script.Parent.ShopUI.AreYouSure.Owned.Visible = true
		script.Parent.ShopUI.AreYouSure.Processsing.Visible = false
	elseif which == "SecretMarket" and thank == "Owned" then
		script.Parent.SecretMarketUI.AreYouSure.Processsing.Visible = false
		script.Parent.SecretMarketUI.AreYouSure.Owned.Visible = true
	elseif which == "SecretMarket" and thank == "ThankYou" then
		script.Parent.SecretMarketUI.AreYouSure.Processsing.Visible = false
		script.Parent.SecretMarketUI.AreYouSure.ThankYou.Visible = true
		script.Parent.Parent.Success:Play()
	elseif which == "Sell" and thank == "ThankYou" then
		script.Parent.Parent.Success:Play()
		script.Parent.SellOres.AreYouSure.Processsing.Visible = false
		script.Parent.SellOres.AreYouSure.ThankYou.Visible = true
	elseif which == "Shop" and thank == "Error" then
		script.Parent.ShopUI.AreYouSure.Processsing.Visible = false
		script.Parent.ShopUI.AreYouSure.UnableToDo.Visible = true
		script.Parent.Parent.Error:Play()
	elseif which == "Sell" and thank == "Error" then
		script.Parent.SellOres.AreYouSure.Processsing.Visible = false
		script.Parent.SellOres.AreYouSure.UnableToDo.Visible = true
		script.Parent.Parent.Error:Play()
	elseif which == "Shop" and thank == "MoreEcoNeeded" then
		script.Parent.ShopUI.AreYouSure.Processsing.Visible = false
		script.Parent.Parent.Error:Play()
		script.Parent.ShopUI.AreYouSure.MoreEcoPls.Visible = true
		if which == "Cave" and "Iron" then
			script.Parent.CaveUIResearchUI.MustHaveIron.Visible = true
			task.wait(10)
			script.Parent.CaveUIResearchUI.MustHaveIron.Visible = false
		end
	end
end)

ReplicatedStorage.RemotesEvents.GameEvents.PaycheckReminder.OnClientEvent:Connect(function(eco,xp)
	script.Parent.Parent.Hooray:Play()
	script.Parent.Paycheck.Visible = true
	script.Parent.Paycheck.Paycheck.Frame.RewardEco.Text = eco.." Eco"
	script.Parent.Paycheck.Paycheck.Frame.RewardXp.Text = xp.." Eco"
	task.wait(5)
	script.Parent.Paycheck.Visible = false
end)

ReplicatedStorage.Events.Cave.IsHover.OnClientEvent:Connect(function(howshow,oreinstance)
	if howshow == "HoverOver" then
		oreinstance.SelectedOre.Visible = true
	elseif howshow == "StopHoverOver" then
		oreinstance.SelectedOre.Visible = false
	end
end)

script.Parent.ShopUI.ActionBar.Exit.MouseButton1Click:Connect(function()
	script.Parent.ShopUI.Visible = false
	uiClose()
end)


ReplicatedStorage.RemotesEvents.GuiEvents.DedicatedCutsceneText.OnClientEvent:Connect(function(txt,duration)
	tweeny(script.Parent.DCT,0.45)
	task.wait(0.45)
	script.Parent.DCT.Visible = true
	script.Parent.DCT.Text = txt
	task.wait(duration)
	tweeny(script.Parent.DCT,0.45)
	task.wait(0.45)
	script.Parent.DCT.Visible = false
end)

ReplicatedStorage.Events.EndingEvent.OnClientEvent:Connect(function(endingtype)
	if endingtype == "Meltdown" then
		if workspace.GameData.EcoCC.ReactorStats.ShutD.Value == false then
			player.PlayerScripts.Cutscenes.Ending.Disabled = false
		end
	elseif endingtype == "Overload" then
		return "ok"
	end
end)

workspace.World.Objects.Characters.birt.Head.Dialog.DialogChoiceSelected:Connect(function(player,choice)
	if choice.Name == "Shop" then
		script.Parent.SecretMarketUI.Visible = true
	end
end)

script.Parent.YourLevel.MainContext.LevelContex.LevelUpTips.MouseButton1Click:Connect(function()
	script.Parent.Parent.Click:Play()
	script.Parent.YourLevel.MainContext.LevelContex.Visible = false
	script.Parent.YourLevel.MainContext.Tips.Visible = true
end)

script.Parent.YourLevel.MainContext.Tips.BackLevelUpTips.MouseButton1Click:Connect(function()
	script.Parent.Parent.Click:Play()
	script.Parent.YourLevel.MainContext.LevelContex.Visible = true
	script.Parent.YourLevel.MainContext.Tips.Visible = false
end)

script.Parent.YourLevel.ActionBar.TextButton.MouseButton1Click:Connect(function()
	script.Parent.Parent.Click:Play()
	script.Parent.YourLevel.Visible = false
end)

script.Parent.Level.MouseButton1Click:Connect(function()
	script.Parent.Parent.Click:Play()
	script.Parent.YourLevel.Visible = true
end)

ReplicatedStorage.Events.CustomHDAdminHandler.OnClientEvent:Connect(function(ui,cmd)
	if ui == "CommandProhibit" and cmd then
		script.Parent.CommandProhibited.Visible = true
		script.Parent.CommandProhibited.Prompt.InteractionMenu.WhatNeedsToBeCombined.Text = cmd.." is prohibited due to interference with public server gameplay."
	elseif ui == "CommandWarn" and cmd then
		script.Parent.CommandWarning.Visible = true
		script.Parent.CommandWarning.Prompt.InteractionMenu.WhatNeedsToBeCombined.Text = "Using "..cmd.." will heavily affect your gameplay in this server."
	end
end)

script.Parent.FeatureUpdate.Prompt.Exit.MouseButton1Click:Connect(function()
	script.Parent.FeatureUpdate.Visible = false
	uiClose()
	if script.Parent.Parent:FindFirstChild("Intro") then
		if script.Parent.Parent.Intro:FindFirstChild("Main") then
			if script.Parent.Parent.Intro.Main.Disabled == false then
				script.Parent.Parent.Intro.Intro.Visible = true
			end
		end
	end
end)

script.Parent.Settings.MainContext.Others.FeatureLogToggle.MouseButton1Click:Connect(function()
	script.Parent.FeatureUpdate.Visible = true
end)

ReplicatedStorage.RemotesEvents.GameEvents.Nuclear.OverloadMeltdownEnding.OnClientEvent:Connect(function()
	script.Parent.OvrldEnding.Visible = true
	script.Parent.OvrldEnding.Text = ""
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound1:Play()
	task.wait(3)
	script.Parent.Parent.LocalMusic.OverloadEnding.BGMusic:Play()
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound2:Play()
	task.wait(1)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound3:Play()
	task.wait(0.5)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound4:Play()
	task.wait(2)
	script.Parent.OvrldEnding.Text = "everything 8,000 miles away from Edmon[>€3i, Canada was eradicated."
	task.wait(6)
	script.Parent.OvrldEnding.Text = "it's because..."
	task.wait(5)
	script.Parent.OvrldEnding.Text = "...of the shutdown trip."
	task.wait(5)
	script.Parent.OvrldEnding.Text = "nothing was able to be salvaged"
	task.wait(5)
	script.Parent.OvrldEnding.Text = "there was no way anyone survived, besides using those jets"
	task.wait(5)
	script.Parent.OvrldEnding.Text = "why did you wish for this?"
	task.wait(7)
	script.Parent.OvrldEnding.Text = "think about it"
	task.wait(8)
	script.Parent.Parent.LocalMusic.OverloadEnding.EndingGlitch:Play()
	script.Parent.OvrldEnding.Text = "thI m?!it"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "t123!@(*#&~@>#€⁄“it"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "t112#*@!&#(@!P#,EP(WQd.sa"
	task.wait(0.2)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound2:Stop()
	script.Parent.OvrldEnding.Text = "?d,/"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "thI m?!it"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "t123!@(*#&~@>#€⁄“it"
	task.wait(0.2)
	script.Parent.Parent.LocalMusic.OverloadEnding.BGMusic:Stop()
	script.Parent.OvrldEnding.Text = "t112#*@!&#(@!P#,EP(WQd.sa"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "?d,/"
	task.wait(0.2)
	script.Parent.OvrldEnding.Text = "?d,/"
	task.wait(0.2)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound3:Stop()
	task.wait(0.5)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound4:Stop()
	task.wait(0.5)
	script.Parent.Parent.LocalMusic.OverloadEnding.Sound1:Stop()
	task.wait(4)
	script.Parent.OvrldEnding.Visible = false
end)

script.Parent.MusicPlayer.PlayerUi.AdminUI.AdMarket.MouseButton1Click:Connect(function()
	player.PlayerScripts.Advertiseement.Disabled = false
	script.Parent.MusicPlayer.Visible = false
	script.Parent.Parent.CoreGUI.Enabled = false
	task.wait(190)
	script.Parent.MusicPlayer.Visible = true
	script.Parent.Parent.CoreGUI.Enabled = true
end)

script.Parent.Quests.QuestUI.QuestMenu.ExitFrame.Exit.MouseButton1Click:Connect(function()
	script.Parent.Quests.Visible = false
end)

script.Parent.Tutorial.Welcome.InteractionMenu.Choices.MixOres.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Mix.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)
script.Parent.Tutorial.Welcome.InteractionMenu.Choices.Mine.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Mine.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)
script.Parent.Tutorial.Welcome.InteractionMenu.Choices.CombineOres.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Combine.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)
script.Parent.Tutorial.Welcome.InteractionMenu.Choices.LevelUp.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.LevelUp.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)
script.Parent.Tutorial.Welcome.InteractionMenu.Choices.EarnEco.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.EarnEco.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)
script.Parent.Tutorial.Welcome.InteractionMenu.Choices.WhereAreReactors.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Reactors.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)

script.Parent.Tutorial.Welcome.InteractionMenu.Choices.WhereCaves.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Caves.Visible = true
	script.Parent.Tutorial.Welcome.Visible = false
end)


script.Parent.Menu.UserNotifier.TextLabel.Text = "Hey, "..game.Players.LocalPlayer.DisplayName.."!"

script.Parent.Tutorial.Welcome.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Visible = false
	if script.Parent.Parent:FindFirstChild("Intro") then
		if script.Parent.Parent.Intro:FindFirstChild("Main") then
			if script.Parent.Parent.Intro.Main.Disabled == false then
				script.Parent.Parent.Intro.Intro.Visible = true
			end
		end
	end

	uiClose()
end)

script.Parent.QuestsButton.MouseButton1Click:Connect(function()
	script.Parent.Quests.Visible = true
end)

script.Parent.Tutorial.Caves.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Caves.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)

script.Parent.Tutorial.Mine.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Mine.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)
script.Parent.Tutorial.LevelUp.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.LevelUp.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)
script.Parent.Tutorial.Combine.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Combine.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)
script.Parent.Tutorial.Reactors.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Reactors.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)
script.Parent.Tutorial.Mix.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.Mix.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)
script.Parent.Tutorial.EarnEco.Exit.MouseButton1Click:Connect(function()
	script.Parent.Tutorial.EarnEco.Visible = false
	script.Parent.Tutorial.Welcome.Visible = true
end)

Players.LocalPlayer.FeedbackString.Changed:Connect(function(txt)
	if txt then
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Visible = true
		script.Parent.Replies.InteractionMenu.Disclaimer.Visible = true
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Body.Text = txt
		script.Parent.Feedback.NewMsgs.Visible = true
		script.Parent.Replies.InteractionMenu.NoMsgs.Visible = true
	elseif txt == nil or 0 then
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Visible = false
		script.Parent.Replies.InteractionMenu.Disclaimer.Visible = false
		script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Body.Text = "No message body."
		script.Parent.Feedback.NewMsgs.Visible = false
		script.Parent.Replies.InteractionMenu.NoMsgs.Visible = true
	end
end)

script.Parent.NoHazmat.HazmatAdvise.InteractionMenu.ExitFrame.Ok.MouseButton1Click:Connect(function()
	script.Parent.NoHazmat.Visible = false
end)

script.Parent.Replies.InteractionMenu.RepliesFrame.Reply.Delete.MouseButton1Click:Connect(function()
	ReplicatedStorage.FeedbackDeleteEvent:FireServer(true)
end)

script.Parent.SecretMarketUI.MainContext.Gear.ItemDescription.Buy.MouseButton1Click:Connect(function()
	if selectedgear.Value ~= "None" then
		script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = true
		script.Parent.SecretMarketUI.AreYouSure.Visible = true
	end
end)

script.Parent.SecretMarketUI.ActionBar.Exit.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.Visible = false
end)

script.Parent.SecretMarketUI.MainContext.Gear.ItemDescription.Cancel.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
end)


script.Parent.SecretMarketUI.AreYouSure.Confirmation.InteractionMenu.ChoiceFrame.Confirm.MouseButton1Click:Connect(function()
	PurchaseEvent:FireServer(tools[selectedgear.Value])
	task.wait(0.02)
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = false
end)
script.Parent.SecretMarketUI.AreYouSure.Confirmation.InteractionMenu.ChoiceFrame.Exit.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.AreYouSure.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.ThankYou.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Owned.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.MoreEcoPls.Visible = false
end)
script.Parent.SecretMarketUI.AreYouSure.ThankYou.InteractionMenu.ChoiceFrame.Ok.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.AreYouSure.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.ThankYou.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Owned.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.MoreEcoPls.Visible = false

end)

script.Parent.SecretMarketUI.AreYouSure.Owned.InteractionMenu.ChoiceFrame.Okay.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.AreYouSure.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.ThankYou.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Owned.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.MoreEcoPls.Visible = false
end)
script.Parent.SecretMarketUI.AreYouSure.MoreEcoPls.InteractionMenu.ChoiceFrame.Okay.MouseButton1Click:Connect(function()
	selectedgear.Value = "None"
	script.Parent.SecretMarketUI.AreYouSure.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Confirmation.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.ThankYou.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.Owned.Visible = false
	script.Parent.SecretMarketUI.AreYouSure.MoreEcoPls.Visible = false

end)

script.Parent.Quests.QuestUI.QuestMenu.ExitFrame.TasksCompleted.MouseButton1Click:Connect(function()
	script.Parent.Quests.QuestUI.Visible = false
	script.Parent.Quests.QuestLog.Visible = true
end)

script.Parent.Quests.QuestLog.ExitFrame.rBack.MouseButton1Click:Connect(function()
	script.Parent.Quests.QuestUI.Visible = true
	script.Parent.Quests.QuestLog.Visible = false
end)

--local kickIf = false

--game.Players.LocalPlayer.Idled:Connect(function(time)
--	script.Parent.AFK.Visible = false
--	script.Parent.AFK:TweenPosition(UDim2.new(0.147, 0, 0.136, 0),"Out","Quad",0.28)
--	task.wait(60)
--	kickIf = true
--	script.Parent.Parent.Alert:Play()
--	script.Parent.Parent.Alert.TimePosition = 0.5
--	script.Parent.AFK.Visible = true
--	tweeny(script.Parent.AFK,0)
--	script.Parent.AFK:TweenPosition(UDim2.new(0.147, 0, 0.13, 0),"Out","Quad",0.28)
--	game:GetService("TweenService"):Create(game.Lighting.uiblur,TweenInfo.new(0.35),{Size = 64}):Play()
--	task.wait(550)
--	if kickIf == true then
--		game.Players.LocalPlayer:Kick("Disconnected for being idle")
--	end
--	script.Parent.AFK.Prompt.InteractionMenu.Choices.Okay.MouseButton1Click:Connect(function()
--		kickIf = false
--		script.Parent.AFK:TweenPosition(UDim2.new(0.147, 0, 0.136, 0),"Out","Quad",0.28)
--		tweeny(script.Parent.AFK,1)
--		game:GetService("TweenService"):Create(game.Lighting.uiblur,TweenInfo.new(0.35),{Size = 0}):Play()
--		task.wait(0.3)
--		script.Parent.AFK.Visible = false
--	end)
--	script.Parent.AFK.Prompt.InteractionMenu.Choices.Discon.MouseButton1Click:Connect(function()
--		kickIf = false
--		script.Parent.AFK:TweenPosition(UDim2.new(0.147, 0, 0.136, 0),"Out","Quad",0.28)
--		tweeny(script.Parent.AFK,1)
--		game:GetService("TweenService"):Create(game.Lighting.uiblur,TweenInfo.new(0.35),{Size = 0}):Play()
--		task.wait(0.3)
--		script.Parent.AFK.Visible = false
--		game.Players.LocalPlayer:Kick("No reason provided.")
--	end)
--end)


updateonjoin()
