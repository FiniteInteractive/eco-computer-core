local sound =  -- Replace nil with Roblox Audio Instance, whether be a child or parent
local intensity = -- 0.001 is low, 0.007 is recommended, 0.1 is okay, 1 is too much

game:GetService("RunService").RenderStepped:connect(function()
	workspace.Camera.CFrame = workspace.Camera.CFrame * CFrame.Angles(0, 
		0, math.rad(math.random(-sound.PlaybackLoudness, 
			sound.PlaybackLoudness) * intensity)) + Vector3.new(
		math.rad(math.random(-sound.PlaybackLoudness * 0.2, sound.PlaybackLoudness * 0.2) * 0.02), 
		math.rad(math.random(-sound.PlaybackLoudness * 0.2, sound.PlaybackLoudness * 0.2) * 0.02), 
		math.rad(math.random(-sound.PlaybackLoudness * 0.2, sound.PlaybackLoudness * 0.2) * 0.02)
	)
end)