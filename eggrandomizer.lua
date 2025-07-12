local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local eggToPets = {
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

local function clearESP()
  for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BillboardGui") and v.Name == "EggESP" then
      v:Destroy()
    end
  end
end

local function createESP(part, text)
  local gui = Instance.new("BillboardGui", part)
  gui.Name = "EggESP"
  gui.Size = UDim2.new(0, 100, 0, 40)
  gui.StudsOffset = Vector3.new(0, 2.5, 0)
  gui.AlwaysOnTop = true
  local label = Instance.new("TextLabel", gui)
  label.Size = UDim2.new(1, 0, 1, 0)
  label.BackgroundTransparency = 1
  label.Text = text
  label.TextColor3 = Color3.new(1, 1, 1)
  label.TextStrokeTransparency = 0.2
  label.Font = Enum.Font.Gotham
  label.TextScaled = true
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
loadingGui.Name = "KuniLoading"
loadingGui.ResetOnSpawn = false

local lFrame = Instance.new("Frame", loadingGui)
lFrame.Size = UDim2.new(0, 400, 0, 200)
lFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
lFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
lFrame.BorderSizePixel = 0

local lTitle = Instance.new("TextLabel", lFrame)
lTitle.Size = UDim2.new(1, 0, 0.25, 0)
lTitle.Position = UDim2.new(0, 0, 0, 10)
lTitle.BackgroundTransparency = 1
lTitle.Text = "Kuni Hub"
lTitle.Font = Enum.Font.GothamBlack
lTitle.TextSize = 28
lTitle.TextColor3 = Color3.new(1, 1, 1)

local lText = Instance.new("TextLabel", lFrame)
lText.Size = UDim2.new(1, 0, 0.25, 0)
lText.Position = UDim2.new(0, 0, 0.3, 0)
lText.BackgroundTransparency = 1
lText.Font = Enum.Font.GothamBold
lText.TextSize = 20
lText.TextColor3 = Color3.new(1, 1, 1)
lText.Text = "Loading Egg Predictor..."

local progressBar = Instance.new("Frame", lFrame)
progressBar.Size = UDim2.new(0.8, 0, 0.1, 0)
progressBar.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)

local fill = Instance.new("Frame", progressBar)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)

spawn(function()
  for i = 0, 100, 1 do
    fill.Size = UDim2.new(i/100, 0, 1, 0)
    wait(0.025)
  end
  wait(0.3)
  loadingGui:Destroy()

  local gui = Instance.new("ScreenGui", PlayerGui)
  gui.Name = "KuniHub"
  gui.ResetOnSpawn = false

  local frame = Instance.new("Frame", gui)
  frame.Size = UDim2.new(0, 280, 0, 180)
  frame.Position = UDim2.new(0.01, 0, 0.3, 0)
  frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
  frame.BorderSizePixel = 0
  frame.Active = true
  frame.Draggable = true

  local title = Instance.new("TextLabel", frame)
  title.Size = UDim2.new(1, -60, 0, 25)
  title.Position = UDim2.new(0, 5, 0, 5)
  title.BackgroundTransparency = 1
  title.Text = "Pet Predictor by Kuni"
  title.TextColor3 = Color3.fromRGB(0, 200, 255)
  title.Font = Enum.Font.GothamBold
  title.TextSize = 18
  title.TextXAlignment = Enum.TextXAlignment.Left

  local predictBtn = Instance.new("TextButton", frame)
  predictBtn.Size = UDim2.new(0.9, 0, 0, 40)
  predictBtn.Position = UDim2.new(0.05, 0, 0, 50)
  predictBtn.Text = "Predict Pets"
  predictBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
  predictBtn.TextColor3 = Color3.new(1,1,1)
  predictBtn.Font = Enum.Font.GothamBold
  predictBtn.TextSize = 18

  local infoBtn = Instance.new("TextButton", frame)
  infoBtn.Size = UDim2.new(0.9, 0, 0, 30)
  infoBtn.Position = UDim2.new(0.05, 0, 0, 100)
  infoBtn.Text = "Egg Info"
  infoBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
  infoBtn.TextColor3 = Color3.new(0,0,0)
  infoBtn.Font = Enum.Font.Gotham
  infoBtn.TextSize = 16

  local eggGui = Instance.new("ScreenGui", PlayerGui)
  eggGui.Name = "EggInfoUI"
  eggGui.ResetOnSpawn = false
  eggGui.Enabled = false

  local eggFrame = Instance.new("ScrollingFrame", eggGui)
  eggFrame.Size = UDim2.new(0, 250, 0, 280)
  eggFrame.Position = UDim2.new(0.5, -125, 0.5, -140)
  eggFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
  eggFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
  eggFrame.ScrollBarThickness = 6
  eggFrame.Visible = true

  local y = 10
  for egg, pets in pairs(eggToPets) do
    local title = Instance.new("TextLabel", eggFrame)
    title.Size = UDim2.new(1, -10, 0, 25)
    title.Position = UDim2.new(0, 5, 0, y)
    title.BackgroundTransparency = 1
    title.Text = egg
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    y += 28

    for _, pet in ipairs(pets) do
      local label = Instance.new("TextLabel", eggFrame)
      label.Size = UDim2.new(1, -20, 0, 20)
      label.Position = UDim2.new(0, 10, 0, y)
      label.BackgroundTransparency = 1
      label.Text = "• " .. pet.name .. " – " .. pet.chance .. "%"
      label.Font = Enum.Font.Gotham
      label.TextColor3 = Color3.new(1, 1, 1)
      label.TextSize = 14
      label.TextXAlignment = Enum.TextXAlignment.Left
      y += 22
    end
    y += 8
  end

  predictBtn.MouseButton1Click:Connect(function()
    predictBtn.Text = "Please wait..."
    randomizeEggs()
    wait(2)
    predictBtn.Text = "Predict Pets"
  end)

  infoBtn.MouseButton1Click:Connect(function()
    eggGui.Enabled = not eggGui.Enabled
  end)
end)
