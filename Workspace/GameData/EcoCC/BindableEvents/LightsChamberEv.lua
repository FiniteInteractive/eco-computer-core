self = workspace.GameData.EcoCC
local CollectionService = game:GetService("CollectionService")
local Lights = CollectionService:GetTagged("LightChamber")
local OnCore = workspace:GetAttribute("CoreIsOn")

local lightColours = {
	white = Color3.fromRGB(255,255,255);
	red = Color3.fromRGB(252, 66, 49);
	black = Color3.fromRGB(0,0,0);
}

local avgLight = lightColours.white

local function lights_show(v)
	while true do
		game:GetService("TweenService"):Create(v, TweenInfo.new(math.random(0.85,1.25),Enum.EasingStyle.Linear), {Color = avgLight}):Play()
		game:GetService("TweenService"):Create(v.PointLight, TweenInfo.new(math.random(0.85,1.25),Enum.EasingStyle.Linear), {Color = avgLight}):Play()
		task.wait(1.25)
		game:GetService("TweenService"):Create(v, TweenInfo.new(math.random(0.85,1.25),Enum.EasingStyle.Linear), {Color = Color3.fromRGB(0, 0, 0)}):Play()
		game:GetService("TweenService"):Create(v.PointLight, TweenInfo.new(math.random(0.85,1.25),Enum.EasingStyle.Linear), {Color = Color3.fromRGB(0, 0, 0)}):Play()
		task.wait(1.25)
	end
end


for i,v in pairs (Lights) do
	coroutine.resume(coroutine.create(function() --Coroutine to make sure it doesn't hold up the loop.
			lights_show(v)
	end))
end

workspace.GameData.EcoCC:WaitForChild("ReactorStats",10).CoreTemp.Changed:Connect(function(temp)
	if OnCore == true then
	if temp <= 2300 then
		avgLight = lightColours.white
	elseif temp >= 2301 then -- near melt
		avgLight = lightColours.red
		end
	elseif OnCore == false then
		avgLight = lightColours.black
	end
end)


workspace:GetAttributeChangedSignal("CoreIsOn"):Connect(function(val)
	if val == true then
		avgLight = lightColours.white
	elseif val == false then
		avgLight = lightColours.black
	end
end)