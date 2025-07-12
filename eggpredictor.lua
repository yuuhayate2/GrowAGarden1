-- Kuni Hub Final GUI Script (Mobile + PC Smooth Version with ESP)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")

local gui = Instance.new("ScreenGui")
gui.Name = "KuniHub"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 320, 0, 180)
loadingFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.BorderSizePixel = 0
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.Parent = gui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Kuni Hub"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.TextScaled = true
title.Parent = loadingFrame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 0.5, 0)
loadingLabel.Position = UDim2.new(0, 0, 0.4, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading Script"
loadingLabel.Font = Enum.Font.Code
loadingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
loadingLabel.TextScaled = true
loadingLabel.Parent = loadingFrame

local dotCount = 0
task.spawn(function()
	while loadingLabel and loadingLabel.Parent do
		dotCount = (dotCount + 1) % 4
		loadingLabel.Text = "Loading Script" .. string.rep(".", dotCount)
		wait(0.5)
	end
end)

wait(10)
TweenService:Create(loadingFrame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -160, -1, 0),
	BackgroundTransparency = 1
}):Play()
wait(1.2)
loadingFrame:Destroy()

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 160)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -80)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0.25, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Egg Predictor by Kuni"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
titleLabel.TextScaled = true

local predictBtn = Instance.new("TextButton", mainFrame)
predictBtn.Size = UDim2.new(0.9, 0, 0.35, 0)
predictBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
predictBtn.Text = "Predict Pets"
predictBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
predictBtn.TextColor3 = Color3.new(1, 1, 1)
predictBtn.Font = Enum.Font.GothamBold
predictBtn.TextScaled = true
Instance.new("UICorner", predictBtn).CornerRadius = UDim.new(0, 10)

local exitBtn = Instance.new("TextButton", mainFrame)
exitBtn.Size = UDim2.new(0, 24, 0, 24)
exitBtn.Position = UDim2.new(1, -28, 0, 4)
exitBtn.Text = "X"
exitBtn.BackgroundColor3 = Color3.fromRGB(120, 20, 20)
exitBtn.TextColor3 = Color3.new(1,1,1)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextScaled = true
Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(1, 0)

local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -56, 0, 4)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextScaled = true
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 90, 0, 34)
miniIcon.Position = UDim2.new(0, 10, 1, -44)
miniIcon.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
miniIcon.Text = "Kuni"
miniIcon.Visible = false
miniIcon.TextColor3 = Color3.new(1, 1, 1)
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextScaled = true
Instance.new("UICorner", miniIcon).CornerRadius = UDim.new(0, 10)

RunService.RenderStepped:Connect(function()
	local t = tick() % 1
	miniIcon.TextColor3 = Color3.fromHSV(t, 1, 1)
end)

exitBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	miniIcon.Visible = false
end)

miniIcon.Draggable = true
miniIcon.Active = true

wait(0.5)
mainFrame.Visible = true
TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, -140, 0.5, -80)
}):Play()

local eggToPets = {
	["Common Egg"] = {
		{name="Golden Lab", chance=33.33},
		{name="Dog", chance=33.33},
		{name="Bunny", chance=33.34},
	},
	["Paradise Egg"] = {
		{name="Ostrich", chance=40},
		{name="Peacock", chance=30},
		{name="Capybara", chance=21},
		{name="Scarlet Macaw", chance=8},
		{name="Mimic Octopus", chance=1},
	},
	["Oasis Egg"] = {
		{name="Meerkat", chance=45},
		{name="Sand Snake", chance=34.5},
		{name="Axolotl", chance=15},
		{name="Hyacinth Macaw", chance=5},
		{name="Fennec Fox", chance=0.5},
	}
}

local espList = {}
local function clearESP()
	for _, g in ipairs(espList) do if g and g.Parent then g:Destroy() end end
	espList = {}
end

local function createESP(part, petDisplay)
	if part and not part:FindFirstChild("EggESP") then
		local gui = Instance.new("BillboardGui", part)
		gui.Name = "EggESP"
		gui.Size = UDim2.new(0, 100, 0, 40)
		gui.StudsOffset = Vector3.new(0, 2.5, 0)
		gui.AlwaysOnTop = true

		local lb = Instance.new("TextLabel", gui)
		lb.Size = UDim2.new(1, 0, 1, 0)
		lb.BackgroundTransparency = 1
		lb.Text = petDisplay
		lb.TextColor3 = Color3.new(1,1,1)
		lb.TextStrokeTransparency = 0.2
		lb.Font = Enum.Font.Gotham
		lb.TextScaled = true
		lb.TextTransparency = 1

		TweenService:Create(lb, TweenInfo.new(1), {TextTransparency = 0}):Play()
		table.insert(espList, gui)
	end
end

local function getRandomPet(eggName)
	local pool = eggToPets[eggName]
	if pool then
		local total, cum = 0, 0
		for _, p in ipairs(pool) do total += p.chance end
		local r = math.random() * total
		for _, p in ipairs(pool) do
			cum += p.chance
			if r <= cum then
				return p.name .. " (" .. string.format("%.2f", p.chance) .. "%)"
			end
		end
	end
	return "Unknown"
end

local function randomizeEggs()
	clearESP()
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and eggToPets[obj.Name] then
			local part = obj:FindFirstChildWhichIsA("BasePart")
			if part then createESP(part, getRandomPet(obj.Name)) end
		end
	end
end

local debounce = false
predictBtn.MouseButton1Click:Connect(function()
	if debounce then return end
	debounce = true
	predictBtn.Text = "Please wait..."
	randomizeEggs()
	wait(2)
	predictBtn.Text = "Predict Pets"
	debounce = false
end)
