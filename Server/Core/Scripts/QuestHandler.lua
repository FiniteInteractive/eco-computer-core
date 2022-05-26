local QuestModule = require(game.ServerStorage.Modules.QuestModule)
local QuestTemplate = game.ServerStorage.UiElements.QuestTemplate
local dataStore = game:GetService("DataStoreService")
local ds1 = dataStore:GetDataStore("EcoCC_QuestsSystem")
local QuestEvent = game.ReplicatedStorage.RemotesEvents.Quests:WaitForChild("QuestDone")

-- switching to BoolValue

-- i could find one or two ways to improve this basic code
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = player:WaitForChild("leaderstats",15)
	local QuestsFolder = Instance.new("Folder")
	QuestsFolder.Name = "Quests"
	QuestsFolder.Parent = player
	-- after this point
	local IgnitionRctr2 = Instance.new("BoolValue")
	IgnitionRctr2.Name = "IgnitionRctr2"
	IgnitionRctr2.Parent = QuestsFolder
	IgnitionRctr2.Value = ds1:SetAsync(player.UserId) or false
	local Coins = Instance.new("BoolValue")
	Coins.Name = "Coins"
	Coins.Parent = QuestsFolder
	Coins.Value = ds1:SetAsync(player.UserId) or false
	local Vent = Instance.new("BoolValue")
	Vent.Name = "Vent"
	Vent.Parent = QuestsFolder
	Vent.Value = ds1:SetAsync(player.UserId) or false
	local FriendsJoin = Instance.new("BoolValue")
	FriendsJoin.Name = "FriendsJoin"
	FriendsJoin.Parent = QuestsFolder
	FriendsJoin.Value = ds1:SetAsync(player.UserId) or false
	local SecretMarket = Instance.new("BoolValue")
	SecretMarket.Name = "SecretMarket"
	SecretMarket.Parent = QuestsFolder
	SecretMarket.Value = ds1:SetAsync(player.UserId) or false
	local WindMachine = Instance.new("BoolValue")
	WindMachine.Name = "WindMachine"
	WindMachine.Parent = QuestsFolder
	WindMachine.Value = ds1:SetAsync(player.UserId) or false
	local StartReactors = Instance.new("BoolValue")
	StartReactors.Name = "StartReactors"
	StartReactors.Parent = QuestsFolder
	StartReactors.Value = ds1:SetAsync(player.UserId) or false
	local ShutdownReactors = Instance.new("BoolValue")
	ShutdownReactors.Name = "ShutdownReactors"
	ShutdownReactors.Parent = QuestsFolder
	ShutdownReactors.Value = ds1:SetAsync(player.UserId) or false
	local GetIntoMachineYuh = Instance.new("BoolValue")
	GetIntoMachineYuh.Name = "GetIntoMachineYuh"
	GetIntoMachineYuh.Parent = QuestsFolder
	GetIntoMachineYuh.Value = ds1:SetAsync(player.UserId) or false
	local Phantoms = Instance.new("BoolValue")
	Phantoms.Name = "PhntmPickGet"
	Phantoms.Parent = QuestsFolder
	Phantoms.Value = ds1:SetAsync(player.UserId) or false
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
			if Coins.Value == false and player.leaderstats.Eco.Value >= 100 then
				QuestModule.MonitorCurrency(player,100,Reward,{Title,Text,Icon})
			elseif Coins.Value == true then
				return "Is Already Done"
			end
		elseif I == 2 then
			Reward = 25
			Title = "Get blown away using the Wind Machine"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if WindMachine.Value == false then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.WindPlatform,Reward,{Title,Text,Icon})
			elseif WindMachine.Value == true then
				return "Is Already Done"
			end
		elseif I == 3 then
			Reward = 125
			Title = "Prepare Ignition for Reactor 2"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if IgnitionRctr2.Value == false then
				QuestModule.Switch(player,workspace.World.Objects.Facility.Reactor2.ControlRoom.Interactables.Switchables.IgnitePrep,Reward,{Title,Text,Icon})
			elseif IgnitionRctr2.Value == true then
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
			if Phantoms.Value == false then
				QuestModule.MonitorPhantom(player,Reward,{Title,Text,Icon})
			elseif Phantoms.Value == true then
				return "Is Already Done"
			end
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
			if Vent.Value == false then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.VentPlatform,Reward,{Title,Text,Icon})
			elseif Vent.Value == true then
				return "Is Already Done"
			end
			
		elseif I == 7 then
			Reward = 100
			Title = "Get an item from the Secret Market in Vent"
			Text = tostring("Quest Completed. Heres "..Reward.." Eco! If you have already completed this quest, you won't get a reward!")
			Icon = ""
			if SecretMarket.Value == false then
				QuestModule.MonitorTools(player,Reward,{Title,Text,Icon})
			elseif SecretMarket.Value == true then
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
	player.Quests.Changed:Connect(function()
	for _,v in pairs(player.Quests:GetChildren()) do
		if v:IsA("BoolValue") then
			if v == true then
				QuestEvent:FireClient(player,v.Name)
			end
		end
	end
end)

player.Quests.Changed:Connect(function()
	for _,v in pairs(player.Quests:GetChildren()) do
		if v:IsA("BoolValue") then
			ds1:SetAsync(player.UserId)
		end
	end
end)
end)


