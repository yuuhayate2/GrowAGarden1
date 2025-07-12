local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local eggToPets = {
  ["Common Egg"]={{name="Golden Lab",chance=33.33},{name="Dog",chance=33.33},{name="Bunny",chance=33.34}},
  ["Uncommon Egg"]={{name="Black Bunny",chance=25},{name="Chicken",chance=25},{name="Cat",chance=25},{name="Deer",chance=25}},
  ["Rare Egg"]={{name="Orange Tabby",chance=33.33},{name="Spotted Deer",chance=25},{name="Pig",chance=16.67},{name="Rooster",chance=16.67},{name="Monkey",chance=8.33}},
  ["Legendary Egg"]={{name="Cow",chance=42.55},{name="Silver Monkey",chance=42.55},{name="Sea Otter",chance=10.64},{name="Turtle",chance=2.13},{name="Polar Bear",chance=2.13}},
  ["Mythical Egg"]={{name="Grey Mouse",chance=35.71},{name="Brown Mouse",chance=26.79},{name="Squirrel",chance=26.79},{name="Red Giant Ant",chance=8.93},{name="Red Fox",chance=1.79}},
  ["Bug Egg"]={{name="Snail",chance=40},{name="Giant Ant",chance=30},{name="Caterpillar",chance=25},{name="Praying Mantis",chance=4},{name="Dragonfly",chance=1}},
  ["Paradise Egg"]={{name="Ostrich",chance=40},{name="Peacock",chance=30},{name="Capybara",chance=21},{name="Scarlet Macaw",chance=8},{name="Mimic Octopus",chance=1}},
  ["Oasis Egg"]={{name="Meerkat",chance=45},{name="Sand Snake",chance=34.5},{name="Axolotl",chance=15},{name="Hyacinth Macaw",chance=5},{name="Fennec Fox",chance=0.5}},
  ["Dinosaur Egg"]={{name="Raptor",chance=35},{name="Triceratops",chance=32.5},{name="Stegosaurus",chance=29},{name="Pterodactyl",chance=3},{name="Brontosaurus",chance=1},{name="T-Rex",chance=0.5}},
}

local function clearESP()
  for _,v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BillboardGui") and v.Name=="EggESP" then v:Destroy() end
  end
end

local function getRandomPet(e)
  local p=eggToPets[e]
  if p then
    local tot=0 for _,x in ipairs(p) do tot+=x.chance end
    local r=math.random()*tot
    local sum=0
    for _,x in ipairs(p) do sum+=x.chance if r<=sum then return x.name.." ("..string.format("%.2f",x.chance).."%)" end end
  end
  return "Unknown"
end

local function randomizeEggs()
  clearESP()
  for _,m in ipairs(workspace:GetDescendants()) do
    if m:IsA("Model") and eggToPets[m.Name] then
      local b=m:FindFirstChildWhichIsA("BasePart")
      if b then
        local g=Instance.new("BillboardGui",b)
        g.Name="EggESP"
        g.Size=UDim2.new(0,100,0,40)
        g.StudsOffset=Vector3.new(0,2.5,0)
        g.AlwaysOnTop=true
        local lb=Instance.new("TextLabel",g)
        lb.Size=UDim2.new(1,0,1,0)
        lb.BackgroundTransparency=1
        lb.Text=getRandomPet(m.Name)
        lb.TextColor3=Color3.new(1,1,1)
        lb.TextStrokeTransparency=0.2
        lb.Font=Enum.Font.FredokaOne
        lb.TextScaled=true
        lb.TextTransparency=1
        TweenService:Create(lb,TweenInfo.new(1),{TextTransparency=0}):Play()
      end
    end
  end
end

local guiLoad = Instance.new("ScreenGui",PlayerGui)
guiLoad.Name="KuniHub_Load"
guiLoad.ResetOnSpawn=false

local frame = Instance.new("Frame",guiLoad)
frame.Size=UDim2.new(0,400,0,200)
frame.Position=UDim2.new(0.5,-200,0.5,-100)
frame.BackgroundColor3=Color3.fromRGB(40,40,60)
frame.BorderSizePixel=0
frame.AnchorPoint=Vector2.new(0.5,0.5)
frame.BackgroundTransparency=0
frame.ClipsDescendants=true
frame.Visible=true
frame.Size=UDim2.new(0,0,0,0)

TweenService:Create(frame,TweenInfo.new(0.5),{Size=UDim2.new(0,400,0,200)}):Play()

local title = Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0.25,0)
title.Position=UDim2.new(0,0,0,10)
title.BackgroundTransparency=1
title.Text="Kuni Hub"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.FredokaOne
title.TextScaled=true

local subtext = Instance.new("TextLabel",frame)
subtext.Size=UDim2.new(1,0,0.2,0)
subtext.Position=UDim2.new(0,0,0.3,0)
subtext.BackgroundTransparency=1
subtext.Text="Loading Egg Predictor"
subtext.TextColor3=Color3.new(1,1,1)
subtext.Font=Enum.Font.GothamBold
subtext.TextScaled=true

local dots=""
task.spawn(function()
  while guiLoad.Parent do
    dots=dots=="..." and "" or dots.."."
    subtext.Text="Loading Egg Predictor"..dots
    wait(0.5)
  end
end)

local progress = Instance.new("Frame",frame)
progress.Size=UDim2.new(0.8,0,0.15,0)
progress.Position=UDim2.new(0.1,0,0.75,0)
progress.BackgroundColor3=Color3.fromRGB(60,60,90)
progress.BorderSizePixel=0

local bar = Instance.new("Frame",progress)
bar.Size=UDim2.new(0,0,1,0)
bar.BackgroundColor3=Color3.fromRGB(0,200,255)
bar.BorderSizePixel=0

local percent = Instance.new("TextLabel",frame)
percent.Size=UDim2.new(1,0,0.1,0)
percent.Position=UDim2.new(0,0,0.9,0)
percent.BackgroundTransparency=1
percent.Font=Enum.Font.Gotham
percent.TextColor3=Color3.new(1,1,1)
percent.TextScaled=true

task.spawn(function()
  for i=1,100 do
    bar.Size=UDim2.new(i/100,0,1,0)
    percent.Text=i.."%"
    wait(0.1)
  end
  guiLoad:Destroy()
  -- (CONTINUES...)
end)

wait(1)

local mainGui = Instance.new("ScreenGui", PlayerGui)
mainGui.Name = "KuniHub_GUI"
mainGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 260, 0, 200)
mainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundTransparency = 0
mainFrame.ClipsDescendants = true
mainFrame.AutoLocalize = false

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, -50, 0, 30)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.Text = "Kuni Hub"
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextSize = 22
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14

local miniButton = Instance.new("TextButton", mainFrame)
miniButton.Size = UDim2.new(0, 25, 0, 25)
miniButton.Position = UDim2.new(1, -60, 0, 5)
miniButton.Text = "-"
miniButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
miniButton.TextColor3 = Color3.new(0, 0, 0)
miniButton.Font = Enum.Font.GothamBold
miniButton.TextSize = 14

local predictButton = Instance.new("TextButton", mainFrame)
predictButton.Size = UDim2.new(0.9, 0, 0.25, 0)
predictButton.Position = UDim2.new(0.05, 0, 0.35, 0)
predictButton.Text = "Predict Pets"
predictButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
predictButton.TextColor3 = Color3.new(1, 1, 1)
predictButton.Font = Enum.Font.FredokaOne
predictButton.TextSize = 20
local debounce = false

predictButton.MouseButton1Click:Connect(function()
  if debounce then return end
  debounce = true
  predictButton.Text = "Loading..."
  randomizeEggs()
  wait(2)
  predictButton.Text = "Predict Pets"
  debounce = false
end)

local eggInfoButton = Instance.new("TextButton", mainFrame)
eggInfoButton.Size = UDim2.new(0.9, 0, 0.2, 0)
eggInfoButton.Position = UDim2.new(0.05, 0, 0.65, 0)
eggInfoButton.Text = "Egg Info"
eggInfoButton.BackgroundColor3 = Color3.fromRGB(255, 204, 0)
eggInfoButton.TextColor3 = Color3.new(0, 0, 0)
eggInfoButton.Font = Enum.Font.FredokaOne
eggInfoButton.TextSize = 18

local miniIcon = Instance.new("TextButton", mainGui)
miniIcon.Size = UDim2.new(0, 140, 0, 30)
miniIcon.Position = UDim2.new(0, 10, 1, -40)
miniIcon.Text = "K"
miniIcon.Visible = false
miniIcon.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
miniIcon.TextColor3 = Color3.new(1, 1, 1)
miniIcon.Font = Enum.Font.FredokaOne
miniIcon.TextScaled = true
miniIcon.Draggable = true

spawn(function()
  local h = 0
  while miniIcon and miniIcon.Parent do
    miniIcon.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
    h = (h + 0.01) % 1
    wait()
  end
end)

miniButton.MouseButton1Click:Connect(function()
  mainFrame.Visible = false
  miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
  mainFrame.Visible = true
  miniIcon.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
  mainGui:Destroy()
  clearESP()
end)

local eggGui = Instance.new("ScreenGui", PlayerGui)
eggGui.Name = "EggInfoGUI"
eggGui.ResetOnSpawn = false
eggGui.Enabled = false

local eggFrame = Instance.new("Frame", eggGui)
eggFrame.Size = UDim2.new(0, 300, 0, 350)
eggFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
eggFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
eggFrame.Active = true
eggFrame.Draggable = true

local eggCorner = Instance.new("UICorner", eggFrame)
eggCorner.CornerRadius = UDim.new(0, 12)

local eggTitle = Instance.new("TextLabel", eggFrame)
eggTitle.Size = UDim2.new(1, 0, 0, 30)
eggTitle.Position = UDim2.new(0, 0, 0, 0)
eggTitle.Text = "Egg Info"
eggTitle.TextColor3 = Color3.new(0, 0, 0)
eggTitle.Font = Enum.Font.FredokaOne
eggTitle.TextSize = 22
eggTitle.BackgroundTransparency = 1

local eggScroll = Instance.new("ScrollingFrame", eggFrame)
eggScroll.Size = UDim2.new(1, -20, 1, -40)
eggScroll.Position = UDim2.new(0, 10, 0, 35)
eggScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
eggScroll.ScrollBarThickness = 6
eggScroll.BackgroundTransparency = 1
eggScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local eggLayout = Instance.new("UIListLayout", eggScroll)
eggLayout.Padding = UDim.new(0, 8)
eggLayout.SortOrder = Enum.SortOrder.LayoutOrder

for eggName, pets in pairs(eggToPets) do
  local section = Instance.new("TextLabel", eggScroll)
  section.Size = UDim2.new(1, 0, 0, 28)
  section.Text = eggName
  section.TextColor3 = Color3.fromRGB(0, 170, 255)
  section.Font = Enum.Font.FredokaOne
  section.TextSize = 20
  section.BackgroundTransparency = 1
  for _, pet in ipairs(pets) do
    local petLabel = Instance.new("TextLabel", eggScroll)
    petLabel.Size = UDim2.new(1, 0, 0, 20)
    petLabel.Text = "• " .. pet.name .. " – " .. tostring(pet.chance) .. "%"
    petLabel.TextColor3 = Color3.new(0, 0, 0)
    petLabel.Font = Enum.Font.Gotham
    petLabel.TextSize = 16
    petLabel.BackgroundTransparency = 1
    petLabel.TextXAlignment = Enum.TextXAlignment.Left
  end
end

eggInfoButton.MouseButton1Click:Connect(function()
  eggGui.Enabled = not eggGui.Enabled
end)
