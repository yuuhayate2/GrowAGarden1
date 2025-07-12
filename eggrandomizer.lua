-- Kuni Hub Full GUI Script (Mobile-Compatible Only)

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

local loadingGui = Instance.new("ScreenGui", PlayerGui)
loadingGui.Name = "KuniHub_Loading"
loadingGui.ResetOnSpawn = false

local bg = Instance.new("Frame", loadingGui)
bg.Size = UDim2.new(0, 300, 0, 150)
bg.Position = UDim2.new(0.5, -150, 0.5, -75)
bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
bg.BorderSizePixel = 0

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "Kuni Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1

local loadingText = Instance.new("TextLabel", bg)
loadingText.Size = UDim2.new(1, 0, 0.2, 0)
loadingText.Position = UDim2.new(0, 0, 0.25, 0)
loadingText.Text = "Loading Egg Predictor"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 18
loadingText.BackgroundTransparency = 1

local progressBar = Instance.new("Frame", bg)
progressBar.Size = UDim2.new(0, 0, 0.15, 0)
progressBar.Position = UDim2.new(0.05, 0, 0.65, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

local progressBg = Instance.new("Frame", bg)
progressBg.Size = UDim2.new(0.9, 0, 0.15, 0)
progressBg.Position = UDim2.new(0.05, 0, 0.65, 0)
progressBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
progressBg.ZIndex = -1

local percent = Instance.new("TextLabel", bg)
percent.Size = UDim2.new(1, 0, 0.2, 0)
percent.Position = UDim2.new(0, 0, 0.83, 0)
percent.Text = "0%"
percent.TextColor3 = Color3.fromRGB(255, 255, 255)
percent.Font = Enum.Font.GothamBold
percent.TextSize = 16
percent.BackgroundTransparency = 1

local function animateLoading()
  for i = 1, 100 do
    progressBar.Size = UDim2.new(i/100 * 0.9, 0, 0.15, 0)
    percent.Text = tostring(i).."%"
    RunService.RenderStepped:Wait()
    task.wait(0.1)
  end
end

coroutine.wrap(animateLoading)()
task.wait(10)
loadingGui:Destroy()

local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "KuniHub_UI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.01, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true

local titleLabel = Instance.new("TextLabel", frame)
titleLabel.Size = UDim2.new(1, -60, 0.25, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Pet Predictor by Kuni"
titleLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local exitBtn = Instance.new("TextButton", frame)
exitBtn.Size = UDim2.new(0, 20, 0, 20)
exitBtn.Position = UDim2.new(1, -22, 0, 2)
exitBtn.Text = "X"
exitBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
exitBtn.TextColor3 = Color3.new(1,1,1)

local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 20, 0, 20)
minBtn.Position = UDim2.new(1, -44, 0, 2)
minBtn.Text = "-"
minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
minBtn.TextColor3 = Color3.new(1,1,1)

local minimizedIcon = Instance.new("TextButton", gui)
minimizedIcon.Size = UDim2.new(0, 120, 0, 30)
minimizedIcon.Position = UDim2.new(0, 10, 1, -40)
minimizedIcon.Text = "K"
minimizedIcon.Visible = false
minimizedIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
minimizedIcon.TextColor3 = Color3.new(1, 1, 1)
minimizedIcon.TextScaled = true

local function animateK()
  local h = 0
  while minimizedIcon.Visible do
    minimizedIcon.TextColor3 = Color3.fromHSV(h, 1, 1)
    h = (h + 0.01) % 1
    RunService.RenderStepped:Wait()
  end
end

local predictBtn = Instance.new("TextButton", frame)
predictBtn.Size = UDim2.new(0.9, 0, 0.3, 0)
predictBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
predictBtn.Text = "Predict Pets"
predictBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
predictBtn.TextColor3 = Color3.new(1, 1, 1)
predictBtn.Font = Enum.Font.GothamBold
predictBtn.TextSize = 18

local debounce = false
predictBtn.MouseButton1Click:Connect(function()
  if debounce then return end
  debounce = true
  predictBtn.Text = "Please wait..."
  randomizeEggs()
  task.wait(2)
  predictBtn.Text = "Predict Pets"
  debounce = false
end)

minBtn.MouseButton1Click:Connect(function()
  frame.Visible = false
  minimizedIcon.Visible = true
  coroutine.wrap(animateK)()
end)

minimizedIcon.MouseButton1Click:Connect(function()
  frame.Visible = true
  minimizedIcon.Visible = false
end)

exitBtn.MouseButton1Click:Connect(function()
  gui:Destroy()
  clearESP()
end)
