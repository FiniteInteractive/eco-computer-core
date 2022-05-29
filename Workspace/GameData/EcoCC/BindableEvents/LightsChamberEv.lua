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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

for _, part in pairs(CollectionService:GetTagged("LightChamber")) do
-- for loop through every "part" for every hundredth second






end
