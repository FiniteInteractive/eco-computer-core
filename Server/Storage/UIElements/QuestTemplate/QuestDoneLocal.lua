local QuestDone = game.ReplicatedStorage.RemotesEvents.Quests.QuestDone
local Player = game.Players.LocalPlayer

local Dictionary = {
	["Coins"] = "Get 100 Eco.";
	["WindMachine"] = "Get blown away in Wind Machine";
	["Vent"] = "Vent!";
	["FriendsJoin"] = "Have a friend join.";
	["SecretMarket"] = "Get an item from the Secret Market in Vent";
	["StartReactors"] = "Prepare Ignition for Reactor 2";
	["ShutdownReactors"] = "null";
	["GetIntoMachineYuh"] = "Get blown away in Wind Machine";
	["PhntmPickGet"] = "Get a Phantom Pick";
}

QuestDone.OnClientEvent:Connect(function(QuestName)
		if script.Parent.Parent.Title.Text == Dictionary[QuestName] then
			script.Parent.Visible = true
			task.wait(5)
			script.Parent.Parent.Parent = Player.PlayerGui.CoreGUI.Quests.QuestLog.QuestsList
		end
end)

