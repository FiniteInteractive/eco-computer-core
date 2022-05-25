--[[
Deliver
Eco Computer Core
by gloopyreverb
]]

-- The purpose of this script is to "Disabled = false" scripts needed to deliver a spell.

self = workspace.GameData.EcoCC

if workspace.World.Objects.Facility.LabAreas.OreExperiments.HolePutIn2.SubstancePutIn.Value == "Heating" then
	workspace.GameData.EcoCC.ReactorStats.CoreTemp.HeatingSpell.Disabled = false
end
script.Disabled = true