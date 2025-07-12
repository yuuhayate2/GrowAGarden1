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
        g.Name="EggESP";g.Size=UDim2.new(0,100,0,40);g.StudsOffset=Vector3.new(0,2.5,0);g.AlwaysOnTop=true
        local l=Instance.new("TextLabel",g)
        l.Size=UDim2.new(1,0,1,0);l.BackgroundTransparency=1
        l.Text=getRandomPet(m.Name)
        l.TextScaled=true;l.Font=Enum.Font.Gotham;l.TextColor3=Color3.new(1,1,1);l.TextStrokeTransparency=0.2
      end
    end
  end
end

local loadGui=Instance.new("ScreenGui",PlayerGui)
local lf=Instance.new("Frame",loadGui)
lf.Size=UDim2.new(0,360,0,160)
lf.Position=UDim2.new(0.5,-180,0.5,-80)
lf.BackgroundColor3=Color3.fromRGB(20,20,25)

local lt=Instance.new("TextLabel",lf)
lt.Size=UDim2.new(1,0,0.3,0);lt.Position=UDim2.new(0,0,0,5)
lt.BackgroundTransparency=1;lt.Text="Kuni Hub";lt.Font=Enum.Font.GothamBlack;lt.TextSize=26;lt.TextColor3=Color3.new(1,1,1)

local ld=Instance.new("TextLabel",lf)
ld.Size=UDim2.new(1,0,0.3,0);ld.Position=UDim2.new(0,0,0.3,0)
ld.BackgroundTransparency=1;ld.Font=Enum.Font.GothamBold;ld.TextSize=18;ld.TextColor3=Color3.new(1,1,1);ld.Text="Loading Egg Predictor..."

local pb=Instance.new("Frame",lf)
pb.Size=UDim2.new(0.8,0,0.1,0);pb.Position=UDim2.new(0.1,0,0.6,0);pb.BackgroundColor3=Color3.fromRGB(60,60,70)

local pf=Instance.new("Frame",pb)
pf.Size=UDim2.new(0,0,1,0)
pf.BackgroundColor3=Color3.fromRGB(0,170,255)

spawn(function()
  for i=0,100,2 do
    pf.Size=UDim2.new(i/100,0,1,0)
    wait(0.02)
  end
  wait(0.3)
  loadGui:Destroy()

  local gui=Instance.new("ScreenGui",PlayerGui)
  gui.Name="KuniHub";gui.ResetOnSpawn=false

  local fr=Instance.new("Frame",gui)
  fr.Size=UDim2.new(0,280,0,200);fr.Position=UDim2.new(0.02,0,0.3,0)
  fr.BackgroundColor3=Color3.fromRGB(30,30,45);fr.Active=true;fr.Draggable=true

  local tt=Instance.new("TextLabel",fr)
  tt.Size=UDim2.new(1,-60,0,30);tt.Position=UDim2.new(0,5,0,5)
  tt.BackgroundTransparency=1;tt.Text="Pet Predictor by Kuni";tt.Font=Enum.Font.GothamBold;tt.TextSize=18;tt.TextColor3=Color3.fromRGB(0,200,255)

  local xb=Instance.new("TextButton",fr)
  xb.Size=UDim2.new(0,20,0,20);xb.Position=UDim2.new(1,-22,0,5);xb.Text="X"
  xb.BackgroundColor3=Color3.fromRGB(200,30,30);xb.TextColor3=Color3.new(1,1,1)

  local mb=Instance.new("TextButton",fr)
  mb.Size=UDim2.new(0,20,0,20);mb.Position=UDim2.new(1,-44,0,5);mb.Text="-"
  mb.BackgroundColor3=Color3.fromRGB(80,80,100);mb.TextColor3=Color3.new(1,1,1)

  local pb1=Instance.new("TextButton",fr)
  pb1.Size=UDim2.new(0.9,0,0,40);pb1.Position=UDim2.new(0.05,0,0,50)
  pb1.Text="Predict Pets";pb1.Font=Enum.Font.GothamBold;pb1.TextSize=18

  local ib=Instance.new("TextButton",fr)
  ib.Size=UDim2.new(0.9,0,0,30);ib.Position=UDim2.new(0.05,0,0,110)
  ib.Text="Egg Info";ib.Font=Enum.Font.Gotham;ib.TextSize=16;ib.TextColor3=Color3.new(0,0,0)

  local eggGui=Instance.new("ScreenGui",PlayerGui)
  eggGui.Name="EggInfoUI";eggGui.Enabled=false

  local eggFr=Instance.new("Frame",eggGui)
  eggFr.Size=UDim2.new(0,260,0,320);eggFr.Position=UDim2.new(0.5,-130,0.4,-160)
  eggFr.BackgroundColor3=Color3.fromRGB(35,35,45);eggFr.Active=true;eggFr.Draggable=true

  local sc=Instance.new("ScrollingFrame",eggFr)
  sc.Size=UDim2.new(1,-10,1,-10);sc.Position=UDim2.new(0,5,0,5)
  sc.CanvasSize=UDim2.new(0,0,1,0);sc.ScrollBarThickness=6

  local yy=0
  for egg,pets in pairs(eggToPets) do
    local t=Instance.new("TextLabel",sc)
    t.Size=UDim2.new(1,0,0,25);t.Position=UDim2.new(0,0,0,yy)
    t.BackgroundTransparency=1;t.Text=egg
    t.Font=Enum.Font.GothamBold;t.TextColor3=Color3.fromRGB(0,200,255);t.TextSize=16
    yy+=25
    for _,p in ipairs(pets) do
      local tt2=Instance.new("TextLabel",sc)
      tt2.Size=UDim2.new(1,-10,0,20);tt2.Position=UDim2.new(0,5,0,yy)
      tt2.BackgroundTransparency=1;tt2.Text="• "..p.name.." – "..p.chance.."%"
      tt2.Font=Enum.Font.Gotham;tt2.TextColor3=Color3.new(1,1,1);tt2.TextSize=14
      yy+=20
    end
    yy+=10
  end
  sc.CanvasSize=UDim2.new(0,0,0,yy)

  pb1.MouseButton1Click:Connect(function()
    pb1.Text="Please wait...";randomizeEggs();wait(1.5);pb1.Text="Predict Pets"
  end)

  ib.MouseButton1Click:Connect(function()
    eggGui.Enabled=not eggGui.Enabled
  end)

  mb.MouseButton1Click:Connect(function()
    fr.Visible=false
  end)

  xb.MouseButton1Click:Connect(function()
    gui:Destroy();eggGui:Destroy();clearESP()
  end)
end)
