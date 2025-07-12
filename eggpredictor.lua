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
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = gui
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Kuni Hub"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Parent = loadingFrame

local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 0.5, 0)
loadingLabel.Position = UDim2.new(0, 0, 0.4, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading Script"
loadingLabel.Font = Enum.Font.Code
loadingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingLabel.TextScaled = true
loadingLabel.Parent = loadingFrame

local progressBarBack = Instance.new("Frame")
progressBarBack.Size = UDim2.new(0.9, 0, 0.08, 0)
progressBarBack.Position = UDim2.new(0.05, 0, 0.8, 0)
progressBarBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
progressBarBack.BorderSizePixel = 0
progressBarBack.Parent = loadingFrame
Instance.new("UICorner", progressBarBack).CornerRadius = UDim.new(0, 6)

local progressBarFill = Instance.new("Frame")
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
progressBarFill.BorderSizePixel = 0
progressBarFill.Parent = progressBarBack
Instance.new("UICorner", progressBarFill).CornerRadius = UDim.new(0, 6)

local dotCount = 0
local percent = 0
local loading = true

spawn(function()
	while loading do
		dotCount = (dotCount + 1) % 4
		loadingLabel.Text = "Loading Script" .. string.rep(".", dotCount)
		wait(0.4)
	end
end)

spawn(function()
	while percent < 100 do
		percent += math.random(2, 5)
		percent = math.clamp(percent, 0, 100)
		TweenService:Create(progressBarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			Size = UDim2.new(percent / 100, 0, 1, 0)
		}):Play()
		wait(0.5)
	end
	loading = false
end)

wait(10)
TweenService:Create(loadingFrame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, -1, 0),
	BackgroundTransparency = 1
}):Play()
wait(1.2)
loadingFrame:Destroy()

local mainGui = Instance.new("Frame")
mainGui.Size = UDim2.new(0, 280, 0, 180)
mainGui.Position = UDim2.new(0.5, 0, 0.5, 0)
mainGui.AnchorPoint = Vector2.new(0.5, 0.5)
mainGui.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
mainGui.Parent = gui
Instance.new("UICorner", mainGui).CornerRadius = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 30)
titleLabel.Position = UDim2.new(0, 10, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Egg Predictor by Kuni"
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.Parent = mainGui

local predictButton = Instance.new("TextButton")
predictButton.Size = UDim2.new(0.9, 0, 0, 40)
predictButton.Position = UDim2.new(0.05, 0, 0.45, 0)
predictButton.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
predictButton.Text = "Predict Pets"
predictButton.TextColor3 = Color3.fromRGB(255, 255, 255)
predictButton.Font = Enum.Font.GothamBold
predictButton.TextSize = 18
predictButton.Parent = mainGui
Instance.new("UICorner", predictButton).CornerRadius = UDim.new(0, 8)

local debounce = false

predictButton.MouseButton1Click:Connect(function()
	if debounce then return end
	debounce = true
	predictButton.Text = "Please wait..."
	for _, v in pairs(Workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Egg") then
			local part = v:FindFirstChildWhichIsA("BasePart")
			if part and not part:FindFirstChild("EggESP") then
				local esp = Instance.new("BillboardGui")
				esp.Name = "EggESP"
				esp.Size = UDim2.new(0, 100, 0, 40)
				esp.AlwaysOnTop = true
				esp.StudsOffset = Vector3.new(0, 3, 0)
				esp.Parent = part

				local label = Instance.new("TextLabel")
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.Text = "Possible Pet"
				label.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextStrokeTransparency = 0.3
				label.Font = Enum.Font.GothamBold
				label.TextScaled = true
				label.Parent = esp
			end
		end
	end
	wait(2)
	predictButton.Text = "Predict Pets"
	debounce = false
end)

local exitBtn = Instance.new("TextButton")
exitBtn.Size = UDim2.new(0, 24, 0, 24)
exitBtn.Position = UDim2.new(1, -28, 0, 4)
exitBtn.Text = "X"
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextSize = 16
exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
exitBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
exitBtn.Parent = mainGui
Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 6)

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -56, 0, 4)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
minimizeBtn.Parent = mainGui
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local minimizedBtn = Instance.new("TextButton")
minimizedBtn.Size = UDim2.new(0, 100, 0, 30)
minimizedBtn.Position = UDim2.new(0, 10, 1, -40)
minimizedBtn.Text = "Kuni"
minimizedBtn.Visible = false
minimizedBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizedBtn.Font = Enum.Font.GothamBlack
minimizedBtn.TextSize = 20
minimizedBtn.Parent = gui
Instance.new("UICorner", minimizedBtn).CornerRadius = UDim.new(0, 10)

minimizeBtn.MouseButton1Click:Connect(function()
	mainGui.Visible = false
	minimizedBtn.Visible = true
end)

minimizedBtn.MouseButton1Click:Connect(function()
	mainGui.Visible = true
	minimizedBtn.Visible = false
end)

exitBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
