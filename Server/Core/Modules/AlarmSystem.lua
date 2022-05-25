local alarm = {}
local WarningLights ={}

function alarm.on(alarmtype)
	local WarningLights ={}
	if alarmtype == "red" then
	for i,v in pairs(workspace.Alarms:GetChildren())do if v.Name=="Alarm"then table.insert(WarningLights,v)end end
		for i,WarningLight in pairs(WarningLights)do  

			WarningLight.LightPart.SpotLight3.Enabled = true
			WarningLight.LightPart.Beam3.Enabled = true
			WarningLight.Motor.HingeConstraint.AngularVelocity = 5
			WarningLight.LightPart.Material = "Neon"
			WarningLight.LightPart.BrickColor = BrickColor.new("Bright red")
	end
	end
end

function alarm.off(alarmtype)
	local WarningLights ={}
	if alarmtype == "red" then
		for i,v in pairs(workspace.Alarms:GetChildren())do if v.Name=="Alarm"then table.insert(WarningLights,v)end end
		for i,WarningLight in pairs(WarningLights)do  
			WarningLight.LightPart.SpotLight3.Enabled = false
			WarningLight.LightPart.Beam3.Enabled = false
			WarningLight.Motor.HingeConstraint.AngularVelocity = 0
			WarningLight.LightPart.Material = "SmoothPlastic"
			WarningLight.LightPart.BrickColor = BrickColor.new("Black")
		end
	end
end

return alarm
