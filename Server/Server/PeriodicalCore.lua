self = workspace.GameData.EcoCC
replicatedstorage = game.ReplicatedStorage
audiosfx = self.SFX
facility = workspace.World.Objects.Facility
importantfacilityarea = facility.ImportantFacilityAreas
core = importantfacilityarea.PrimaryReactorArea.PrimaryChamber
ChamberRoof = workspace.World.Objects.Miscellaneous.TheRoofOfTheChamber
ctrlroom = importantfacilityarea.PrimaryReactorArea.ControlRoom
music = require(replicatedstorage.Lib.Music)
notification = require(game.ReplicatedStorage.Modules.NotificationStyle)

while true do
	wait(math.random(120,250))
	ctrlroom.Screens.Indicators.White_Venting.Indicate.Material = Enum.Material.Neon
	core.Core.Ventilation.Vent.Union.Smoke.Enabled = true
	ChamberRoof.DrainingWashing:Play()
	task.wait(4)
	core.Core.Ventilation.Vent.Union.Smoke.Enabled = false
	task.wait(12)
	ChamberRoof.Cleaning:Play()
	core.Core.Ventilation.Vent.Union.Smoke.Enabled = true
	core.Core.Ventilation.Vent2.Union.Smoke.Enabled = true
	task.wait(12)
	ctrlroom.Screens.Indicators.White_Venting.Indicate.Material = Enum.Material.Metal
	core.Core.Ventilation.Vent.Union.Smoke.Enabled = false
	core.Core.Ventilation.Vent2.Union.Smoke.Enabled = false
end