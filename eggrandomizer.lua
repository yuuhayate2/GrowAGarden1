-- Kuni Hub | Smooth Pet Predictor GUI Only

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

local gui = Instance.new("ScreenGui", PlayerGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 140)
frame.Position = UDim2.new(0.01, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.25, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Kuni Hub - Pet Predictor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20

local predictBtn = Instance.new("TextButton", frame)
predictBtn.Size = UDim2.new(0.9, 0, 0.35, 0)
predictBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
predictBtn.Text = "Predict Pets"
predictBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
predictBtn.TextColor3 = Color3.new(1, 1, 1)
predictBtn.Font = Enum.Font.GothamBold
predictBtn.TextSize = 18
predictBtn.AutoButtonColor = false

local debounce = false
predictBtn.MouseButton1Click:Connect(function()
  if debounce then return end
  debounce = true
  predictBtn.Text = "Predicting..."
  TweenService:Create(predictBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(0, 120, 200)}):Play()
  randomizeEggs()
  task.wait(2)
  TweenService:Create(predictBtn, TweenInfo.new(0.5), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
  predictBtn.Text = "Predict Pets"
  debounce = false
end)

local loadingScreen = Instance.new("ScreenGui", PlayerGui)
local lf = Instance.new("Frame", loadingScreen)
lf.Size = UDim2.new(0, 400, 0, 200)
lf.Position = UDim2.new(0.5, -200, 0.5, -100)
lf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

local titleText = Instance.new("TextLabel", lf)
titleText.Size = UDim2.new(1, 0, 0.3, 0)
titleText.Position = UDim2.new(0, 0, 0.1, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Kuni Hub"
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 32
titleText.TextColor3 = Color3.new(1, 1, 1)

titleText2 = Instance.new("TextLabel", lf)
titleText2.Size = UDim2.new(1, 0, 0.2, 0)
titleText2.Position = UDim2.new(0, 0, 0.4, 0)
titleText2.BackgroundTransparency = 1
titleText2.Text = "Loading Egg Predictor"
titleText2.Font = Enum.Font.Gotham
titleText2.TextSize = 24
titleText2.TextColor3 = Color3.new(1, 1, 1)

local bar = Instance.new("Frame", lf)
bar.Size = UDim2.new(0.8, 0, 0.1, 0)
bar.Position = UDim2.new(0.1, 0, 0.75, 0)
bar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local percent = Instance.new("TextLabel", lf)
percent.Size = UDim2.new(1, 0, 0.1, 0)
percent.Position = UDim2.new(0, 0, 0.87, 0)
percent.BackgroundTransparency = 1
percent.TextColor3 = Color3.new(1, 1, 1)
percent.Text = "0%"
percent.Font = Enum.Font.GothamBold
percent.TextSize = 20

spawn(function()
  local duration = 10
  local start = tick()
  while tick() - start < duration do
    local progress = (tick() - start) / duration
    fill.Size = UDim2.new(progress, 0, 1, 0)
    percent.Text = tostring(math.floor(progress * 100)).."%"
    RunService.RenderStepped:Wait()
  end
  fill.Size = UDim2.new(1, 0, 1, 0)
  percent.Text = "100%"
  task.wait(0.5)
  TweenService:Create(loadingScreen, TweenInfo.new(1), {ResetOnSpawn = false}):Play()
  loadingScreen:Destroy()
end)

frame.Visible = false
task.delay(10.5, function()
  TweenService:Create(frame, TweenInfo.new(0.5), {Position = UDim2.new(0.01, 0, 0.3, 0)}):Play()
  frame.Visible = true
end)
