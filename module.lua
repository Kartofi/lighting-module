local module = {}
local tween = game:GetService("TweenService")

module.Create = function(pos1, pos2, joins, material, color, cloud)
	
	local folder_ = Instance.new("Folder", game.Workspace)
	
	
		folder_.Name = "Lightning-module"
		


	local position = pos1
	local position1 = pos2
	local points = {}
	
	for i=0, joins do
		local off = Vector3.new(math.random(-2,2),math.random(-2,2),math.random(-2,2))
		local part = Instance.new("Part", folder_)
		part.Transparency = 1
		part.Size =Vector3.new(0.5,.5,.5)
		part.Anchored = true
		part.Position = position + (position1 - position).Unit * i * (position - position1).Magnitude / joins + off
		part.CanCollide = false
		table.insert(points , part.Position)


	end
	
	
	local debree_f = Instance.new("Folder", game.Workspace)
	debree_f.Name = "Debrees"
	for i=0, 5 do
		local debree = Instance.new("Part",debree_f)
		debree.Material = Enum.Material.SmoothPlastic
		debree.Color = Color3.new(0.419608, 0.419608, 0.419608)
		debree.Size = Vector3.new(2,2,2)
		debree.CanCollide = true
		debree.CFrame = CFrame.new(pos2, Vector3.new(0,0,0)) * CFrame.new(math.random(-10,10), pos2.Y + 1, math.random(-10,10))

		local ray = workspace:Raycast(debree.Position, Vector3.new(0,-100,0))
		if ray then
			debree.Color = ray.Instance.Color
			debree.Material = ray.Instance.Material
		end

		debree.Velocity = Vector3.new(math.random(0,50), 25, math.random(0,50))
		
	end
	delay(3, function()
		debree_f:Destroy()
	end)
	
	
	for index,_ in pairs(points) do
		if points[index + 1] ~= nil then
			
			local connect = Instance.new("Part",folder_)
			connect.Anchored = true
			connect.Material = material
			connect.Color = color
			connect.Transparency = 1
			connect.CanCollide = false
			connect.Size = Vector3.new(0.5,.5, (points[index + 1] - points[index]).Magnitude)
			connect.CFrame = CFrame.new((points[index + 1] + points[index]) / 2,points[index] )
			tween:Create(connect, TweenInfo.new(0.01), {Transparency = 0}):Play()
			
			
		end
	end
	local explosion = Instance.new("Part", debree_f)
	explosion.Shape = Enum.PartType.Ball
	explosion.Color = color
	explosion.Material = material
	explosion.Position = pos2
	explosion.Size = Vector3.new(5,5,5)
	explosion.Anchored = true
	explosion.CanCollide = false
	tween:Create(explosion, TweenInfo.new(0.1), {Size = Vector3.new(20,20,20)}):Play()
	
	
	
	delay(0.1, function()
		tween:Create(explosion, TweenInfo.new(0.1), {Size = Vector3.new(1,1,1)}):Play()
		tween:Create(explosion, TweenInfo.new(0.1), {Transparency = 1}):Play()
	end)
	delay(0.5, function()
		for _,i in pairs(folder_:GetChildren()) do
			tween:Create(i, TweenInfo.new(1), {Transparency = 1}):Play()
			
		end
		wait(1)
		game:GetService("Debris"):AddItem(folder_, 0)
	end)
	
	
end
return module
