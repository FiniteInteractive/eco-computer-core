task.wait(0.5)
local starterGui = game:GetService('StarterGui')
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game.ReplicatedStorage
local HapticService = game:GetService("HapticService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GUI = script.Parent
local player = Players.LocalPlayer
local tutorialwillbevisibleafter = false
local TweenService = game:GetService("TweenService")
local starterplayer = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local URGH = script.Parent.PreLoading.LoadingTab.Loadin
local meltcheckconnect
local CP = game.ContentProvider
local UiTransition = require(ReplicatedStorage.Modules.UiTransitions)
local DisableIntro = false
local DontShowMapChooser = false
local ErrSound = script.Parent.Parent:WaitForChild("Error")
local HoverSound = script.Parent.Parent:WaitForChild("Hover")
local ClickSound = script.Parent.Parent:WaitForChild("Click")

script.Parent.Parent:WaitForChild("LocalMusic").PreloadingAndShopTheme:Play()
starterGui:SetCore("TopbarEnabled", false)
starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
script.Parent.Enabled = true
player:WaitForChild("IsBanned",5).Changed:Connect(function(bool)
	if bool == true then
		script.Parent.Parent.Intro:Destroy()
	elseif bool == false then
		return "cool beans"
	end
end)
if player:WaitForChild("IsBanned",5) == true then
	script.Parent.Parent.Intro:Destroy()
end
task.wait(0.5)
script.Parent.Parent:WaitForChild("Chat",5).Enabled = false

-- FADE OUT for preloading
local function tweeny(frame, transparency)
	if script.Parent.Parent.CoreGUI.IsAnimationsReduced.Value == false then
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

starterGui:SetCore("TopbarEnabled", false)
game.SoundService.SongsCanMute.Volume = 0
script.Parent.Parent.LocalMusic.Outside.Day:Pause()
script.Parent.Parent.LocalMusic.Outside.NightChristmas:Pause()
script.Parent.Parent.LocalMusic.Outside.Night:Pause()
script.Parent.Parent.CoreGUI.AmbienceOptimizeCore.Disabled = false
script.Parent.Parent.CoreGUI.ClientHandler.Disabled = false

function nopreloadaesthetic()
	script.Parent.Parent.LocalMusic.PreloadingAndShopTheme:Stop()
	Players.LocalPlayer.PlayerScripts.Cutscenes.Intro.Disabled = false
	script.Parent.PreLoading.Load1.Visible = false
	script.Parent.PreLoading.Load2.Visible = false
	script.Parent.PreLoading.Load3.Visible = false
end



script.Parent.PreLoading.Skip.Skip.MouseButton1Click:Connect(function()
	script.Parent.Skipped.Value = true
	script.Parent.PreLoading.Skip.Visible = false
end)

script.Parent.PreLoading.Skip.Wait.MouseButton1Click:Connect(function()
	script.Parent.PreLoading.Skip.Visible = false
end)

game.ReplicatedStorage.RemotesEvents.GuiEvents.TutorialUi.OnClientEvent:Connect(function()
	tutorialwillbevisibleafter = true	
	script.Parent.Parent.CoreGUI.Tutorial.Visible = false
end)

script.Parent.Enabled = true
if DisableIntro == true and DontShowMapChooser == false then
	starterGui:SetCore("TopbarEnabled", true)
	script.Parent.Enabled = false
	script.Parent.rep:Destroy()
	script.Parent.Parent.CoreGUI.ClientHandler.Disabled = false
	script.Parent.Parent.CoreGUI.AmbienceOptimizeCore.Disabled = false
	script.Parent.Parent.CoreGUI.Level.Visible = true
	script.Parent.Parent.LocalMusic.Outside.Day:Play()
	script.Parent.Parent.LocalMusic.Outside.NightChristmas:Play()
	script.Parent.Parent.LocalMusic.Outside.Night:Play()
	player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = false
	script.Parent.Parent.CoreGUI.HeyHey.Visible = true
	script.Parent.Parent.CoreGUI.MenuButton.Visible = true
	script.Parent.Parent.CoreGUI.QuestsButton.Visible = true
	task.wait(0.01)
	script.Parent:Destroy()
elseif DisableIntro == true and DontShowMapChooser == true then
	starterGui:SetCore("TopbarEnabled", true)
	script.Parent.Enabled = false
	script.Parent.rep:Destroy()
	script.Parent.Parent.CoreGUI.ClientHandler.Disabled = false
	script.Parent.Parent.CoreGUI.AmbienceOptimizeCore.Disabled = false
	script.Parent.Parent.CoreGUI.Level.Visible = true
	script.Parent.Parent.LocalMusic.Outside.Day:Play()
	script.Parent.Parent.LocalMusic.Outside.NightChristmas:Play()
	script.Parent.Parent.LocalMusic.Outside.Night:Play()
	script.Parent.Parent.CoreGUI.MenuButton.Visible = true
	script.Parent.Parent.CoreGUI.QuestsButton.Visible = true
	task.wait(0.01)
	script.Parent:Destroy()
else
	starterGui:SetCore("TopbarEnabled", false)
	task.wait(0.01)
	print("Ready - Reverb Studio ReEngine Framework")
	task.wait(0.01)
	spawn(function()
		workspace.GameData.EcoCC.CaveRegenInProg.Changed:Connect(function(val)
			if val == false then
				game:GetService('ContentProvider'):PreloadAsync({game:GetService('Workspace')})
			elseif val == true then
				URGH.Text = "Generating ores..."
			end
		end)
		if workspace.GameData.EcoCC.CaveRegenInProg.Value == true then
			URGH.Text = "Generating ores..."
		elseif workspace.GameData.EcoCC.CaveRegenInProg.Value == false then
			game:GetService('ContentProvider'):PreloadAsync({game:GetService('Workspace')})
		end
	end)

	function visibleornot(visible)
		if visible == true then
			script.Parent.Intro.Play.Visible = true
			script.Parent.Intro.Settings.Visible = true
			script.Parent.Intro.Logo.Visible = true
			script.Parent.Intro.DisasterState.Visible = false
			script.Parent.Intro.LoadSlide.Visible = true
		elseif visible == false then
			script.Parent.Intro.Play.Visible = false
			script.Parent.Intro.Settings.Visible = false
			script.Parent.Intro.Logo.Visible = false
			script.Parent.Intro.DisasterState.Visible = false
			script.Parent.Intro.LoadSlide.Visible = false
		end
	end


	meltcheckconnect = game:GetService('RunService').Heartbeat:Connect(function() 
		if script.Parent.Parent.CoreGUI.MeltdownOrOtherState.Value == true or workspace.GameData.EcoCC.ReactorStats.IsDisaster.Value == true then
			script.Parent.Intro.DisasterState.Visible = true
			script.Parent.SetContinousMusicOff.Disabled = false
		else
			return "No Disasters At the Moment"
		end
	end)
	
	local function endIntro()
		script.Parent.Parent:WaitForChild("Chat",5).Enabled = true
		starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
		TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(0.75),{Size = 18}):Play()
		Players.LocalPlayer.PlayerScripts.Cutscenes.Intro.Stop.Value = true
		tweeny(script.Parent.Intro.PickRandom, 0)
		player.PlayerScripts.ChoosersPoosers.ExpOutdoors.Disabled = false
		TweenService:Create(script.Parent.Menu,TweenInfo.new(1.5),{Volume = 0}):Play()
		visibleornot(false)
		TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(0.75),{Size = 0}):Play()
		script.Parent.Menu.Script.Disabled = true
		task.wait(2)
		script.Parent.Parent.CoreGUI.HeyHey.Visible = true
		script.Parent.Parent.CoreGUI.MenuButton.Visible = true
		tweeny(script.Parent.Intro.PickRandom, 1)	
		tweeny(script.Parent.Intro.PickRandom.PickRandom, 1)	
		task.wait(0.02)
		starterGui:SetCore("TopbarEnabled", true)
		task.wait(1.2)
		if tutorialwillbevisibleafter == true then
			script.Parent.Parent.CoreGUI.Tutorial.Visible = true
		end
		game.SoundService.SongsCanMute.Volume = 1.985
		script.Parent.Parent.CoreGUI.Level.Visible = true
		script.Parent.Parent.CoreGUI.QuestsButton.Visible = true
		script.Parent.Intro.Visible = false	
		visibleornot(false)
		script.Parent.Enabled = false
	end
	
	workspace.GameData.EcoCC.CaveRegenInProg.Changed:Connect(function(val)
		if val == false then
			script.Parent.Intro.Regen.Visible = false
			script.Parent.Intro.Play.Visible = true
		elseif val == true then
			script.Parent.Intro.Regen.Visible = true
			script.Parent.Intro.Play.Visible = false
		end
	end)
	-- At the very bottom
	-- Loading --
	do
		repeat URGH.Text = '('..CP.RequestQueueSize..') loaded' task.wait(1.4) until CP.RequestQueueSize <= 0 or script.Parent.Skipped.Value == true
		if script.Parent.Skipped.Value == false then
			if workspace.GameData.EcoCC.ReactorStats.IsDisaster.Value == true then
				script.Parent.Intro.DisasterState.Visible = true
				script.Parent.Parent.CoreGUI.Countdown.Visible = true
			end
			if workspace.GameData.EcoCC.CaveRegenInProg.Value == true then
				game:GetService('ContentProvider'):PreloadAsync({game:GetService('Workspace').World.Objects.Facility.Cave.OreLoc.Ores})
				repeat URGH.Text = 'Generating ores... ('..CP.RequestQueueSize..') loaded' task.wait(1.4) until CP.RequestQueueSize <= 0 or script.Parent.Skipped.Value == true
			end
			script.Parent.rep.Disabled = true
			if script.Parent:FindFirstChild("rep") then
				script.Parent.rep:Destroy()
			end
			URGH.Text = "Finished! Enjoy!"
			game.ReplicatedStorage.Components.Objects.Lobby:Clone().Parent = game.workspace.World.Objects.Facility.TemporaryShow
			task.wait(0.1)
			nopreloadaesthetic()
			script.Parent.DoubleClick.Disabled = false
			script.Parent.Parent.CoreGUI.Cine.Visible = true
			TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(1),{Size = 24}):Play()
			task.wait(0.5)
			script.Parent.Menu.Script.Disabled = false
			tweeny(script.Parent.PreLoading, 1)
			script.Parent.FirstCollab1.Visible = true
			script.Parent.PreLoading.Visible = false
			task.wait(1)
			script.Parent.FirstCollab1.Frame:TweenSize(UDim2.new(0.001, 0,1.119, 0))
			task.wait(1.25)
			TweenService:Create(script.Parent.FirstCollab1.RGP1,TweenInfo.new(0.5),{TextTransparency = 0}):Play()
			task.wait(2)
			TweenService:Create(script.Parent.FirstCollab1.RGP2,TweenInfo.new(0.5),{TextTransparency = 0}):Play()
			task.wait(2)
			TweenService:Create(script.Parent.FirstCollab1.RGP3,TweenInfo.new(0.5),{TextTransparency = 0}):Play()
			task.wait(5)
			script.Parent.FirstCollab1.Frame:TweenSize(UDim2.new(0, 3,0, 0))
			TweenService:Create(script.Parent.FirstCollab1.RGP1,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
			TweenService:Create(script.Parent.FirstCollab1.RGP2,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
			TweenService:Create(script.Parent.FirstCollab1.RGP3,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
			task.wait(1)
			script.Parent.Parent.CoreGUI.Cine.Visible = false
			script.Parent.FirstCollab1.Visible = false
			script.Parent.Intro.Visible = true
			task.wait(0.3)
			TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(1),{Size = 0}):Play()
			tweeny(script.Parent.Intro.Play,0)
			script.Parent.Intro.Play:TweenPosition(UDim2.new(0.057, 0,0.362,0),"Out","Sine",0.3)
			task.wait(0.01)
			tweeny(script.Parent.Intro.Settings,0)
			script.Parent.Intro.LoadSlide.Visible = true
			script.Parent.Intro.Settings:TweenPosition(UDim2.new(0.057, 0,0.444,0),"Out","Sine",0.3)
			script.Parent.Intro.LoadSlide:TweenPosition(UDim2.new(-0.001, 0,-0.12, 0),"Out","Sine",0.3)
			TweenService:Create(script.Parent.Intro.Logo,TweenInfo.new(0.5),{ImageTransparency = 0}):Play()
			TweenService:Create(script.Parent.Intro.LoadSlide,TweenInfo.new(0.5),{BackgroundTransparency = 0}):Play()
		elseif script.Parent.Skipped.Value == true then
			script.Parent.Parent.LocalMusic.PreloadingAndShopTheme:Stop()
			script.Parent.Parent.CoreGUI.AmbienceOptimizeCore.Disabled = false
			script.Parent.Parent.CoreGUI.ClientHandler.Disabled = false
			script.Parent.rep.Disabled = true
			meltcheckconnect:Disconnect()
			nopreloadaesthetic()
			task.wait(1)
			TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(1.2),{Size = 24}):Play()
			script.Parent.Menu.Script.Disabled = false
			tweeny(script.Parent.PreLoading, 1)
			script.Parent.PreLoading.Visible = false
			script.Parent.Intro.Visible = true
			task.wait(0.01)
			TweenService:Create(game.Lighting.uiBlur,TweenInfo.new(2.5),{Size = 0}):Play()
			tweeny(script.Parent.Intro.Play,0)
			script.Parent.Intro.Play:TweenPosition(UDim2.new(0.057, 0,0.362,0),"Out","Sine",0.3)
			task.wait(0.01)
			tweeny(script.Parent.Intro.Settings,0)
			script.Parent.Intro.LoadSlide.Visible = true
			script.Parent.Intro.Settings:TweenPosition(UDim2.new(0.057, 0,0.444,0),"Out","Sine",0.3)
			script.Parent.Intro.LoadSlide:TweenPosition(UDim2.new(-0.001, 0,-0.12, 0),"Out","Sine",0.3)
			TweenService:Create(script.Parent.Intro.Logo,TweenInfo.new(0.5),{ImageTransparency = 0}):Play()
			TweenService:Create(script.Parent.Intro.LoadSlide,TweenInfo.new(0.5),{BackgroundTransparency = 0}):Play()
		end
	end

	script.Parent.Intro.Settings.MouseEnter:Connect(function()
		HoverSound:Play()
	end)
	
	
	script.Parent.Intro.Play.MouseEnter:Connect(function()
		HoverSound:Play()
	end)
	
	script.Parent.Intro.Play.MouseButton1Click:Connect(function()
		script.Parent.Parent.Click:Play()
		script.Parent.Intro.PickRandom.Visible = true
		script.Parent.Parent.CoreGUI.Settings.Visible = false
		meltcheckconnect:Disconnect()
		UiTransition.Transition("CircleGrow", 1, 1, Color3.fromRGB(24, 24, 37),endIntro)
	end)

	script.Parent.Intro.Settings.MouseButton1Click:Connect(function()
		script.Parent.Intro.Visible = false
		script.Parent.Parent.Click:Play()
		script.Parent.Parent.CoreGUI.Settings.Visible = true
		script.Parent.Parent.CoreGUI.Settings:TweenPosition(UDim2.new(0.147, 0, 0.13, 0),"Out","Quad",0.4)
		tweeny(script.Parent.Parent.CoreGUI.Settings,0)
	end)
end
