-- Kuni Hub Full GUI Script (Mobile-Compatible, Smooth Animations, Light-Dark Rounded Theme)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local eggToPets = {
  ["Common Egg"] = {
    {name="Golden Lab", chance=33.33},
    {name="Dog", chance=33.33},
    {name="Bunny", chance=33.34},
  },
  ["Uncommon Egg"] = {
    {name="Black Bunny", chance=25},
    {name="Chicken", chance=25},
    {name="Cat", chance=25},
    {name="Deer", chance=25},
  },
  ["Rare Egg"] = {
    {name="Orange Tabby", chance=33.33},
    {name="Spotted Deer", chance=25},
    {name="Pig", chance=16.67},
    {name="Rooster", chance=16.67},
    {name="Monkey", chance=8.33},
  },
  ["Legendary Egg"] = {
    {name="Cow", chance=42.55},
    {name="Silver Monkey", chance=42.55},
    {name="Sea Otter", chance=10.64},
    {name="Turtle", chance=2.13},
    {name="Polar Bear", chance=2.13},
  },
  ["Mythical Egg"] = {
    {name="Grey Mouse", chance=35.71},
    {name="Brown Mouse", chance=26.79},
    {name="Squirrel", chance=26.79},
    {name="Red Giant Ant", chance=8.93},
    {name="Red Fox", chance=1.79},
  },
  ["Bug Egg"] = {
    {name="Snail", chance=40},
    {name="Giant Ant", chance=30},
    {name="Caterpillar", chance=25},
    {name="Praying Mantis", chance=4},
    {name="Dragonfly", chance=1},
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
  },
  ["Dinosaur Egg"] = {
    {name="Raptor", chance=35},
    {name="Triceratops", chance=32.5},
    {name="Stegosaurus", chance=29},
    {name="Pterodactyl", chance=3},
    {name="Brontosaurus", chance=1},
    {name="T-Rex", chance=0.5},
  },
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
        return p.name.." ("..string.format("%.2f", p.chance).."%)"
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

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "KuniHub"
screenGui.ResetOnSpawn = false

local loadingFrame = Instance.new("Frame", screenGui)
loadingFrame.Size = UDim2.new(0, 300, 0, 140)
loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -70)
loadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadingFrame.BorderSizePixel = 0
loadingFrame.BackgroundTransparency = 0
loadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFrame.ClipsDescendants = true
loadingFrame.ZIndex = 2
loadingFrame.Visible = true
loadingFrame.BackgroundTransparency = 0
loadingFrame.BackgroundColor3 = Color3.fromRGB(35,35,40)
loadingFrame:TweenSizeAndPosition(UDim2.new(0,300,0,140), UDim2.new(0.5,-150,0.5,-70), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.4, true)

local title = Instance.new("TextLabel", loadingFrame)
title.Size = UDim2.new(1, 0, 0.3, 0)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Kuni Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local status = Instance.new("TextLabel", loadingFrame)
status.Size = UDim2.new(1, 0, 0.4, 0)
status.Position = UDim2.new(0, 0, 0.3, -5)
status.BackgroundTransparency = 1
status.Text = "Loading Egg Predictor"
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextScaled = true
status.Font = Enum.Font.Gotham

local barBG = Instance.new("Frame", loadingFrame)
barBG.Size = UDim2.new(0.8, 0, 0.1, 0)
barBG.Position = UDim2.new(0.1, 0, 0.8, 0)
barBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
barBG.BorderSizePixel = 0
barBG.BackgroundTransparency = 0.2
barBG.ClipsDescendants = true
barBG.AnchorPoint = Vector2.new(0,0)
barBG.BackgroundTransparency = 0
barBG.ZIndex = 3

local barFill = Instance.new("Frame", barBG)
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
barFill.BorderSizePixel = 0
barFill.ZIndex = 4

spawn(function()
  for i = 1, 100 do
    barFill.Size = UDim2.new(i/100, 0, 1, 0)
    status.Text = "Loading Egg Predictor" .. string.rep(".", i%4)
    wait(0.1)
  end
  loadingFrame:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
  wait(0.4)
  loadingFrame.Visible = false

  local mainGui = Instance.new("Frame", screenGui)
  mainGui.Size = UDim2.new(0, 280, 0, 150)
  mainGui.Position = UDim2.new(0.5, -140, 0.5, -75)
  mainGui.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
  mainGui.BorderSizePixel = 0
  mainGui.AnchorPoint = Vector2.new(0.5, 0.5)
  mainGui.Active = true
  mainGui.Draggable = true
  mainGui.BackgroundTransparency = 0
  mainGui.ClipsDescendants = true
  mainGui.ZIndex = 1
  mainGui.BackgroundColor3 = Color3.fromRGB(45,45,50)

  local predictBtn = Instance.new("TextButton", mainGui)
  predictBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
  predictBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
  predictBtn.Text = "Predict Pets"
  predictBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
  predictBtn.TextColor3 = Color3.new(1, 1, 1)
  predictBtn.Font = Enum.Font.GothamBold
  predictBtn.TextScaled = true
  predictBtn.BackgroundTransparency = 0
  predictBtn.AutoButtonColor = true
  predictBtn.ZIndex = 2

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
end)
