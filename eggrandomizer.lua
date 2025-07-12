local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "KuniHub"
gui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(0, 300, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
loadingFrame.BackgroundTransparency = 0.2
loadingFrame.BorderSizePixel = 0
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.ZIndex = 2
loadingFrame.ClipsDescendants = true
loadingFrame:TweenSize(UDim2.new(0, 300, 0, 150), "Out", "Quart", 0.4, true)
loadingFrame.Visible = true

Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loadingFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Kuni Hub"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.TextScaled = true

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.Size = UDim2.new(1, 0, 0.5, 0)
loadingLabel.Position = UDim2.new(0, 0, 0.4, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading Script"
loadingLabel.Font = Enum.Font.Code
loadingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
loadingLabel.TextScaled = true

local dotCount = 0
task.spawn(function()
	while loadingLabel and loadingLabel.Parent do
		dotCount = (dotCount + 1) % 4
		loadingLabel.Text = "Loading Script" .. string.rep(".", dotCount)
		wait(0.5)
	end
end)

wait(10)
loadingFrame:TweenPosition(UDim2.new(0.5, -150, -0.5, -75), "Out", "Quad", 1, true)
wait(1)
loadingFrame:Destroy()

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 260, 0, 140)
mainFrame.Position = UDim2.new(0.02, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

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
predictBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
predictBtn.TextColor3 = Color3.new(1, 1, 1)
predictBtn.Font = Enum.Font.GothamBold
predictBtn.TextScaled = true

Instance.new("UICorner", predictBtn).CornerRadius = UDim.new(0, 8)

local debounce = false
predictBtn.MouseButton1Click:Connect(function()
	if debounce then return end
	debounce = true
	predictBtn.Text = "Please wait..."
	wait(2)
	predictBtn.Text = "Predict Pets"
	debounce = false
end)

local exitBtn = Instance.new("TextButton", mainFrame)
exitBtn.Size = UDim2.new(0, 24, 0, 24)
exitBtn.Position = UDim2.new(1, -28, 0, 4)
exitBtn.Text = "X"
exitBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
exitBtn.TextColor3 = Color3.new(1,1,1)
exitBtn.Font = Enum.Font.GothamBold
exitBtn.TextScaled = true

Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(1, 0)

local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -56, 0, 4)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextScaled = true

Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 80, 0, 30)
miniIcon.Position = UDim2.new(0.02, 0, 1, -40)
miniIcon.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
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
