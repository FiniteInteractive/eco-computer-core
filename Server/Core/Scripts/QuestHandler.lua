local QuestModule = require(game.ServerStorage.Modules.QuestModule)
local QuestTemplate = game.ServerStorage.UiElements.QuestTemplate
local dataStore = game:GetService("DataStoreService")
local ds1 = dataStore:GetDataStore("EcoCC_QuestsSystem")
local QuestEvent = game.ReplicatedStorage.RemotesEvents.Quests:WaitForChild("QuestDone")

local QuestsData = {
	IgnitionRectr2 = 0;
	Coins = 0;
	Vent = 0;
	FriendsJoin = 0;
	SecretMarket = 0;
	WindMachine = 0;
	StartReactors = 0;
	ShutdownReactors = 0;
	GetIntoMachineYuh = 0;
	PhntmPickGet = 0;
}

-- 1 is true, 0 is false.

-- i could find one or two ways to improve this basic code
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = player:WaitForChild("leaderstats",9)
	local QuestsFolder = Instance.new("Folder")
	QuestsFolder.Name = "Quests"
	QuestsFolder.Parent = player
	-- after this point
	local IgnitionRctr2 = Instance.new("NumberValue")
	IgnitionRctr2.Name = "IgnitionRctr2"
	IgnitionRctr2.Parent = QuestsFolder
	IgnitionRctr2.Value = ds1:SetAsync(player.UserId, QuestsData.IgnitionRectr2) or 0
	local Coins = Instance.new("NumberValue")
	Coins.Name = "Coins"
	Coins.Parent = QuestsFolder
	Coins.Value = ds1:SetAsync(player.UserId, QuestsData.Coins) or 0
	local Vent = Instance.new("NumberValue")
	Vent.Name = "Vent"
	Vent.Parent = QuestsFolder
	Vent.Value = ds1:SetAsync(player.UserId, QuestsData.Vent) or 0
	local FriendsJoin = Instance.new("NumberValue")
	FriendsJoin.Name = "FriendsJoin"
	FriendsJoin.Parent = QuestsFolder
	FriendsJoin.Value = ds1:SetAsync(player.UserId, QuestsData.FriendsJoin) or 0
	local SecretMarket = Instance.new("NumberValue")
	SecretMarket.Name = "SecretMarket"
	SecretMarket.Parent = QuestsFolder
	SecretMarket.Value = ds1:SetAsync(player.UserId, QuestsData.SecretMarket) or 0
	local WindMachine = Instance.new("NumberValue")
	WindMachine.Name = "WindMachine"
	WindMachine.Parent = QuestsFolder
	WindMachine.Value = ds1:SetAsync(player.UserId, QuestsData.WindMachine) or 0
	local StartReactors = Instance.new("NumberValue")
	StartReactors.Name = "StartReactors"
	StartReactors.Parent = QuestsFolder
	StartReactors.Value = ds1:SetAsync(player.UserId, QuestsData.StartReactors) or 0
	local ShutdownReactors = Instance.new("NumberValue")
	ShutdownReactors.Name = "ShutdownReactors"
	ShutdownReactors.Parent = QuestsFolder
	ShutdownReactors.Value = ds1:SetAsync(player.UserId, QuestsData.ShutdownReactors) or 0
	local GetIntoMachineYuh = Instance.new("NumberValue")
	GetIntoMachineYuh.Name = "GetIntoMachineYuh"
	GetIntoMachineYuh.Parent = QuestsFolder
	GetIntoMachineYuh.Value = ds1:SetAsync(player.UserId, QuestsData.GetIntoMachineYuh) or 0
	local Phantoms = Instance.new("NumberValue")
	Phantoms.Name = "PhntmPickGet"
	Phantoms.Parent = QuestsFolder
	Phantoms.Value = ds1:SetAsync(player.UserId, QuestsData.PhntmPickGet) or 0
	-- end --
	local eco = leaderstats.Eco
	for I=1,8 do
		local clone = QuestTemplate:Clone()
		local Title = ""
		local Text = ""
		local Icon = ""
		local Reward = 0
		if I == 1 then
			Reward = 15
			Title = "Get 100 Eco."
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if Coins.Value == 0 and player.leaderstats.Eco.Value >= 100 then
				QuestModule.MonitorCurrency(player,100,Reward,{Title,Text,Icon})
			elseif Coins.Value == 1 then
				return "Is Already Done"
			end
		elseif I == 2 then
			Reward = 25
			Title = "Get blown away using the Wind Machine"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if WindMachine.Value == 0 then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.WindPlatform,Reward,{Title,Text,Icon})
			elseif WindMachine.Value == 1 then
				return "Is Already Done"
			end
		elseif I == 3 then
			Reward = 125
			Title = "Prepare Ignition for Reactor 2"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if IgnitionRctr2.Value == 0 then
				QuestModule.Switch(player,workspace.World.Objects.Facility.Reactor2.ControlRoom.Interactables.Switchables.IgnitePrep,Reward,{Title,Text,Icon})
			elseif IgnitionRctr2.Value == 1 then
				return "Is Already Done"
			end
			--elseif I == 4 then
			--	Reward = 50
			--	Title = "Combine Ores"
			--	Text = tostring("Quest Completed. Heres "..Reward.." Eco!")
			--	Icon = ""
			--QuestModule.Switch(player,workspace.IgnitePrep,Reward,{Title,Text,Icon})
		elseif I == 4 then
			Reward = 250
			Title = "Get a Phantom Pick"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if Phantoms.Value == 0 then
				QuestModule.MonitorPhantom(player,Reward,{Title,Text,Icon})
			elseif Phantoms.Value == 1 then
				return "Is Already Done"
			end
			--elseif I == 5 then
			--	Reward = 150
			--	Title = "Be the one to Start the Reactors"
			--	Text = tostring("Quest Completed. Heres "..Reward.." Eco!")
			--	Icon = ""
			--	--QuestModule.Switch(player,workspace.IgnitePrep,Reward,{Title,Text,Icon})
			--elseif I == 6 then
			--	Reward = 150
			--	Title = "Be the one to Shutdown the Reactors"
			--	Text = tostring("Quest Completed. Heres "..Reward.." Eco!")
			--	Icon = ""
			--	--QuestModule.Switch(player,workspace.IgnitePrep,Reward,{Title,Text,Icon})
		elseif I == 5 then
			Reward = 35
			Title = "Get into the Mutation Machine in Research Lab"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if GetIntoMachineYuh.Value == 0 then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.MutationMachIn,Reward,{Title,Text,Icon})
			elseif GetIntoMachineYuh.Value == 1 then
				return "Is Already Done"
			end
			
		elseif I == 6 then
			Reward = 15
			Title = "Vent!"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if Vent.Value == 0 then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.VentPlatform,Reward,{Title,Text,Icon})
			elseif Vent.Value == 1 then
				return "Is Already Done"
			end
			
		elseif I == 7 then
			Reward = 100
			Title = "Get an item from the Secret Market in Vent"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if SecretMarket.Value == 0 then
				QuestModule.MonitorTools(player,Reward,{Title,Text,Icon})
			elseif SecretMarket.Value == 1 then
				return "Is Already Done"
			end
		else
			Reward = 499
			Title = "Have a friend join."
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			QuestModule.MonitorFriends(player,Reward,{Title,Text,Icon})
		end
		clone.Title.Text = Title
		clone.Reward.Text = tostring(Reward.." Eco")
		clone.Parent = player.PlayerGui:WaitForChild("CoreGUI").Quests.QuestUI.QuestMenu.QuestsList
		task.wait(0.05)
	end
	if player.Quests.IgnitionRctr2.Value == 1 then
		QuestEvent:FireClient(player,"Prepare Ignition for Reactor 2")
		end
	if player.Quests.Coins.Value == 1 then
		QuestEvent:FireClient(player,"Get 100 Eco.")
	end
	if player.Quests.WindMachine.Value == 1 then
		QuestEvent:FireClient(player,"Get blown away using the Wind Machine")
	end
	if player.Quests.Vent.Value == 1 then
		QuestEvent:FireClient(player,"Vent!")
	end
	if player.Quests.GetIntoMachineYuh.Value == 1 then
		QuestEvent:FireClient(player,"Get into the Mutation Machine in Research Lab")
	end
	if player.Quests.PhntmPickGet.Value == 1 then
		QuestEvent:FireClient(player,"Find Three Phantoms")
	end
	if player.Quests.FriendsJoin.Value == 1 then
		QuestEvent:FireClient(player,"Have a friend join.")
	end
	if player.Quests.SecretMarket.Value == 1 then
		QuestEvent:FireClient(player,"Get an item from the Secret Market in Vent")
	end
	IgnitionRctr2.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.IgnitionRectr2)
	end)
	Coins.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.Coins)
	end)
	WindMachine.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.WindMachine)
	end)
	Vent.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.Vent)
	end)
	GetIntoMachineYuh.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.GetIntoMachineYuh)
	end)
	Phantoms.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.PhntmPickGet)
	end)
	FriendsJoin.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.FriendsJoin)
	end)
	SecretMarket.Changed:Connect(function()
		ds1:SetAsync(player.UserId, QuestsData.SecretMarket)
	end)
end)


