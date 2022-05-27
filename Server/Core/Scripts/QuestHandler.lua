local QuestModule = require(game.ServerStorage.Modules.QuestModule)
local QuestTemplate = game.ServerStorage.UiElements.QuestTemplate
local dataStore = game:GetService("DataStoreService")
local QuestData = dataStore:GetDataStore("EcoCCQuestStore")
local QuestEvent = game.ReplicatedStorage.RemotesEvents.Quests:WaitForChild("QuestDone")


-- Building from scratch again...
-- Part of code forked from Tech with Mike

local function onPlayerJoin(player)  -- Runs when players join

	local leaderstats = player:WaitForChild("leaderstats",9)
	local QuestsFolder = Instance.new("Folder")
	QuestsFolder.Name = "Quests"
	QuestsFolder.Parent = player

	local IgnitionRctr2 = Instance.new("BoolValue")
	IgnitionRctr2.Name = "IgnitionRctr2"
	IgnitionRctr2.Parent = QuestsFolder
	local Coins = Instance.new("BoolValue")
	Coins.Name = "Coins"
	Coins.Parent = QuestsFolder
	local Vent = Instance.new("BoolValue")
	Vent.Name = "Vent"
	Vent.Parent = QuestsFolder
	local FriendsJoin = Instance.new("BoolValue")
	FriendsJoin.Name = "FriendsJoin"
	FriendsJoin.Parent = QuestsFolder
	local SecretMarket = Instance.new("BoolValue")
	SecretMarket.Name = "SecretMarket"
	SecretMarket.Parent = QuestsFolder
	local WindMachine = Instance.new("BoolValue")
	WindMachine.Name = "WindMachine"
	WindMachine.Parent = QuestsFolder
	local StartReactors = Instance.new("BoolValue")
	StartReactors.Name = "StartReactors"
	StartReactors.Parent = QuestsFolder
	local ShutdownReactors = Instance.new("BoolValue")
	ShutdownReactors.Name = "ShutdownReactors"
	ShutdownReactors.Parent = QuestsFolder
	local GetIntoMachineYuh = Instance.new("BoolValue")
	GetIntoMachineYuh.Name = "GetIntoMachineYuh"
	GetIntoMachineYuh.Parent = QuestsFolder
	local Phantoms = Instance.new("BoolValue")
	Phantoms.Name = "PhntmPickGet"
	Phantoms.Parent = QuestsFolder


	local playerUserId = "Player_" .. player.UserId  --Gets player ID
	local data = QuestData:GetAsync(playerUserId)  --Checks if player has stored data

	if data then
		Coins.Value = data['Coins']
		Vent.Value = data['Vent']
		FriendsJoin.Value = data['FriendsJoin']
		SecretMarket.Value = data['SecretMarket']
		WindMachine.Value = data['WindMachine']
		StartReactors.Value = data['StartReactors']	
		ShutdownReactors.Value = data['ShutdownReactors']
		GetIntoMachineYuh.Value = data['GetIntoMachineYuh']
		Phantoms.Value = data['PhntmPickGet']
	else
		-- Data store is working, but no current data for this player
		Coins.Value = false
		Vent.Value = false
		FriendsJoin.Value = false
		SecretMarket.Value = false
		WindMachine.Value = false
		StartReactors.Value = false
		ShutdownReactors.Value = false
		GetIntoMachineYuh.Value = false
		Phantoms.Value = false
	end

	local eco = leaderstats:WaitForChild("Eco",9)
	for I=1,8 do
		local clone = QuestTemplate:Clone()
		local Title = ""
		local Text = ""
		local Icon = ""
		local Reward = 0
		if I == 1 then
			Reward = 15
			Title = "Get 100 Eco."
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if Coins.Value == false or player[eco].Value <= 99 then
				QuestModule.MonitorCurrency(player,100,Reward,{Title,Text,Icon})
			elseif Coins.Value == true then
				return "Is Already Done"
			end
		elseif I == 2 then
			Reward = 25
			Title = "Get blown away in Wind Machine"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if WindMachine.Value == false then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.WindPlatform,Reward,{Title,Text,Icon})
			elseif WindMachine.Value == true then
				return "Is Already Done"
			end
		elseif I == 3 then
			Reward = 125
			Title = "Prepare Ignition for Reactor 2"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if IgnitionRctr2.Value == false then
				QuestModule.Switch(player,workspace.World.Objects.Facility.Reactor2.ControlRoom.Interactables.Switchables.IgnitePrep,Reward,{Title,Text,Icon})
			elseif IgnitionRctr2.Value == true then
				return "Is Already Done"
			end

		elseif I == 4 then
			Reward = 250
			Title = "Get a Phantom Pick"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if Phantoms.Value == false then
				QuestModule.MonitorPhantom(player,Reward,{Title,Text,Icon})
			elseif Phantoms.Value == true then
				return "Is Already Done"
			end
		elseif I == 5 then
			Reward = 35
			Title = "Get into the Mutation Machine in Research Lab"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if GetIntoMachineYuh.Value == false then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.MutationMachIn,Reward,{Title,Text,Icon})
			elseif GetIntoMachineYuh.Value == true then
				return "Is Already Done"
			end

		elseif I == 6 then
			Reward = 15
			Title = "Vent!"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if Vent.Value == false then
				QuestModule.FindPart(player,workspace.World.Objects.Miscellaneous.VentPlatform,Reward,{Title,Text,Icon})
			elseif Vent.Value == true then
				return "Is Already Done"
			end

		elseif I == 7 then
			Reward = 100
			Title = "Get an item from the Secret Market in Vent"
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			if SecretMarket.Value == false then
				QuestModule.MonitorTools(player,Reward,{Title,Text,Icon})
			elseif SecretMarket.Value == true then
				return "Is Already Done"
			end
		else
			Reward = 499
			Title = "Have a friend join."
			Text = tostring("Quest Completed. You have earned "..Reward.." Eco!")
			Icon = ""
			QuestModule.MonitorFriends(player,Reward,{Title,Text,Icon})
		end
		clone.Title.Text = Title
		clone.Reward.Text = tostring(Reward.." Eco")
		clone.Parent = player.PlayerGui:WaitForChild("CoreGUI",6).Quests.QuestUI.QuestMenu.QuestsList
		task.wait(0.05)
	end

	-- first check
	for _,v in pairs(player.Quests:GetDescendants()) do
		if v:IsA("BoolValue") then
			QuestData:SetAsync(data, v.Value)
			if v.Value == true then
				QuestData:SetAsync(data, v.Value)
				print(tostring(v).." may be done")
				QuestEvent:FireClient(data, v.Name)
			end
		end
	end

	-- continous check
	for _,v in pairs(player.Quests:GetDescendants()) do
		v.Changed:Connect(function()
			if v:IsA("BoolValue") then
				QuestData:SetAsync(data, v.Value)
				if v.Value == true then
					QuestData:SetAsync(data, v.Value)
					print(tostring(v).." may be done")					
					QuestEvent:FireClient(data,v.Name)
				end
			end
		end)
	end
end

local function create_table(player)
	local player_stats = {}
	for _, stat in pairs(player.leaderstats:GetChildren()) do
		player_stats[stat.Name] = stat.Value
	end
	return player_stats
end

local function onPlayerExit(player)  --Runs when players exit

	local player_stats = create_table(player)
	local success, err = pcall(function()
		local playerUserId = "Player_" .. player.UserId
		QuestData:SetAsync(playerUserId, player_stats) --Saves player data
	end)

	if not success then
		warn('Could not save data for player ' .. player.Name .. ': ' .. 'because' .. err)
	end
end

game.Players.PlayerAdded:Connect(onPlayerJoin)
game.Players.PlayerRemoving:Connect(onPlayerExit)