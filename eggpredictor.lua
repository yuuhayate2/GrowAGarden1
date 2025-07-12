local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local gui = Instance.new("ScreenGui", Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "KuniHub"
gui.ResetOnSpawn = false

-- Loading Screen
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(0, 320, 0, 180)
loadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
loadingFrame.BorderSizePixel = 0
Instance.new("UICorner", loadingFrame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", loadingFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Text = "Kuni Hub"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.BackgroundTransparency = 1

local loadingText = Instance.new("TextLabel", loadingFrame)
loadingText.Size = UDim2.new(1, 0, 0.4, 0)
loadingText.Position = UDim2.new(0, 0, 0.4, 0)
loadingText.Text = "Loading Egg Predictor"
loadingText.Font = Enum.Font.Code
loadingText.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingText.TextScaled = true
loadingText.BackgroundTransparency = 1

local barBack = Instance.new("Frame", loadingFrame)
barBack.Size = UDim2.new(0.9, 0, 0.08, 0)
barBack.Position = UDim2.new(0.05, 0, 0.8, 0)
barBack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
barBack.BorderSizePixel = 0
Instance.new("UICorner", barBack).CornerRadius = UDim.new(0, 6)

local barFill = Instance.new("Frame", barBack)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
barFill.BorderSizePixel = 0
Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 6)

local dot = 0
local percent = 0
local loading = true

spawn(function()
	while loading do
		dot = (dot + 1) % 4
		loadingText.Text = "Loading Egg Predictor" .. string.rep(".", dot)
		wait(0.4)
	end
end)

spawn(function()
	while percent < 100 do
		percent += math.random(2, 5)
		percent = math.clamp(percent, 0, 100)
		TweenService:Create(barFill, TweenInfo.new(0.3), {
			Size = UDim2.new(percent / 100, 0, 1, 0)
		}):Play()
		wait(0.5)
	end
	loading = false
end)

wait(10)
TweenService:Create(loadingFrame, TweenInfo.new(1), {Position = UDim2.new(0.5, 0, -1, 0)}):Play()
wait(1.2)
loadingFrame:Destroy()

-- Main GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 300, 0, 200)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local titleGui = Instance.new("TextLabel", main)
titleGui.Text = "Pet Predictor"
titleGui.Size = UDim2.new(1, -20, 0, 30)
titleGui.Position = UDim2.new(0, 10, 0, 10)
titleGui.Font = Enum.Font.GothamSemibold
titleGui.TextSize = 20
titleGui.TextColor3 = Color3.fromRGB(255, 255, 255)
titleGui.BackgroundTransparency = 1

local predict = Instance.new("TextButton", main)
predict.Size = UDim2.new(0.9, 0, 0, 40)
predict.Position = UDim2.new(0.05, 0, 0.5, 0)
predict.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
predict.Text = "Predict Pets"
predict.TextColor3 = Color3.fromRGB(255, 255, 255)
predict.Font = Enum.Font.GothamBold
predict.TextSize = 18
Instance.new("UICorner", predict).CornerRadius = UDim.new(0, 8)

local debounce = false

predict.MouseButton1Click:Connect(function()
	if debounce then return end
	debounce = true
	predict.Text = "Scanning..."

	for _, v in pairs(Workspace:GetDescendants()) do
		if v:IsA("Model") and v:FindFirstChild("Egg") then
			local part = v:FindFirstChildWhichIsA("BasePart")
			if part and not part:FindFirstChild("ESP") then
				local gui = Instance.new("BillboardGui", part)
				gui.Name = "ESP"
				gui.Size = UDim2.new(0, 100, 0, 40)
				gui.StudsOffset = Vector3.new(0, 3, 0)
				gui.AlwaysOnTop = true

				local label = Instance.new("TextLabel", gui)
				label.Size = UDim2.new(1, 0, 1, 0)
				label.BackgroundTransparency = 1
				label.TextColor3 = Color3.fromRGB(255, 255, 255)
				label.TextStrokeTransparency = 0.3
				label.TextScaled = true
				label.Font = Enum.Font.GothamBold
				label.Text = "Mimic Octopus 1%\nQueen Bee 2%\nFennec Fox 3%"
			end
		end
	end

	wait(2)
	predict.Text = "Predict Pets"
	debounce = false
end)
