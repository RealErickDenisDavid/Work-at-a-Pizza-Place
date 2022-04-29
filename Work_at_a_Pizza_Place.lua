local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Work at a Pizza Place", "DarkTheme")

-- LocalPlayer

local LocalPlayer = Window:NewTab("LocalPlayer")
local LocalPlayerSelection = LocalPlayer:NewSection("LocalPlayer")

LocalPlayerSelection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

LocalPlayerSelection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

-- Teleport Area

local TeleportArea = Window:NewTab("Teleport Area")
TeleportAreaSelection = TeleportArea:NewSection("Teleport Area")

TeleportAreaSelection:NewButton("Cashier Area", "Teleport to cashier area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(48, 4, 80)
end)

TeleportAreaSelection:NewButton("Cook Area", "Teleport to cook area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42, 4, 61)
end)

TeleportAreaSelection:NewButton("Manager Area", "Teleport to manager area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37, 4, 3)
end)

TeleportAreaSelection:NewButton("Boxer Area", "Teleport to boxer area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42, 4, 61)
end)

TeleportAreaSelection:NewButton("Manager Area", "Teleport to manager area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37, 4, 3)
end)

TeleportAreaSelection:NewButton("Delivery Area", "Teleport to delivery area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(64, 4, -17)
end)

TeleportAreaSelection:NewButton("Supplier Area", "Teleport to supplier area", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 13, -1020)
end)

-- Scripts

local Scripts = Window:NewTab("Scripts")
local ScriptsSelection = Scripts:NewSection("Scripts")

ScriptsSelection:NewButton("Become Manager", "Become manager", function()
    --vars
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local humanoid = player.Character.Humanoid
local mteam = game:GetService("Teams").Manager
local man = mteam:GetPlayers()[1]
--deletes a glitchy chair in the office (optional)
if workspace:FindFirstChild("ExtraChair") and workspace.ExtraChair:FindFirstChild("Seat") then
workspace.ExtraChair.Seat:Destroy()
end

if man then
--check if he's respawning or sitting
local htxt
if man.Character==nil or man.Character:FindFirstChild("HumanoidRootPart")==nil or man.Character:FindFirstChild("Humanoid")==nil then
    htxt = "Failed because manager is respawning"
end
local target = man.Character.HumanoidRootPart
if man.Character.Humanoid.Sit then
    htxt = "Failed because manager is sitting"
end
if htxt then
    local h = Instance.new("Hint",workspace)
    h.Text = htxt
    wait(3)
    h:Destroy()
    return
end
--get in a car
if not workspace.Cars:IsAncestorOf(humanoid.SeatPart) then
    humanoid.Jump=true
    wait(0.1)
    for _,car in ipairs(workspace.Cars:GetChildren()) do
        if car:FindFirstChild("Driver") and car.Driver.Occupant==nil and car:FindFirstChild("Owner") and car.Owner.Value==nil then
            car.Driver:Sit(humanoid)
            wait(0.3)
            if humanoid.SeatPart then
                break
            end
        end
    end
end
local seat = humanoid.SeatPart
local car = seat.Parent
local returncf = CFrame.new(14,-4.5,21)*CFrame.Angles(0,math.pi/2,0)
for j=1,4 do
    --attempt to sit manager
    seat.Anchored=false
    local e = 0
    while car.HoodSeat.Occupant==nil and mteam:GetPlayers()[1] and target.Parent and e<5 do
        local newpos = target.Position+Vector3.new(0,-3,0)+target.CFrame.lookVector*5.5+target.Velocity*.7
        local flatdir = (target.CFrame.lookVector*Vector3.new(1,0,1)).Unit --target's looking direction, flattened
        if not (flatdir.x < 2) then --inf
            flatdir = Vector3.new(1,0,0)
        end
        car:SetPrimaryPartCFrame(CFrame.new(newpos,newpos-flatdir))
        seat.Velocity=Vector3.new()
        local e2=0
        while car.HoodSeat.Occupant==nil and mteam:GetPlayers()[1] and target.Parent and e2<0.7 do
            e2=e2+wait()
        end
        e=e+e2
    end
    --attempt to move manager
    car:SetPrimaryPartCFrame(returncf)
    wait(.1)
    car:SetPrimaryPartCFrame(returncf)
    seat.Anchored=true
    e = 0
    while mteam:GetPlayers()[1] and target.Parent and e<1 do
        e=e+wait()
    end
    car.HoodSeat:ClearAllChildren() --unsits anyone
    e = 0
    while mteam:GetPlayers()[1] and target.Parent and e<0.5 do
        e=e+wait()
    end
    if mteam:GetPlayers()[1]==nil or target.Parent==nil then
        break
    end
end
--reset car
seat.Anchored=false
wait()
car:SetPrimaryPartCFrame(CFrame.new(120,10,-75))
wait()
end

--become manager
humanoid.Jump=true
wait(0.1)
pcall(function() workspace.ManagerChair.Seat:Sit(humanoid) end)
wait(0.3)
humanoid.Jump=true
wait(0.1)
player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame+Vector3.new(5,5,6)
end)

ScriptsSelection:NewButton("0 Gravity Unanchored Things", "Unanchored Things", function()
    spawn(function()
        while true do
            game.Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)*math.huge
            game.Players.LocalPlayer.SimulationRadius = math.pow(math.huge,math.huge)*math.huge
            game:GetService("RunService").Stepped:wait()
        end
    end)
    local function zeroGrav(part)
        if part:FindFirstChild("BodyForce") then return end
        local temp = Instance.new("BodyForce")
        temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
        temp.Parent = part
    end
    for i,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") and v.Anchored == false then
            if not (v:IsDescendantOf(game.Players.LocalPlayer.Character)) then
                zeroGrav(v)
            end
        end
        workspace.DescendantAdded:Connect(function(part)
            if part:IsA("Part") and part.Anchored == false then
                if not (part:IsDescendantOf(game.Players.LocalPlayer.Character)) then
                    zeroGrav(part)
                end
            end
        end)
    end
end)

ScriptsSelection:NewButton("Bring Unanchored Bricks [E]", "Bring Unanchored", function()
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local Folder = Instance.new("Folder", game:GetService("Workspace"))
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    local Updated = Mouse.Hit + Vector3.new(0, 5, 0)
    local NetworkAccess = coroutine.create(function()
        settings().Physics.AllowSleep = false
        while game:GetService("RunService").RenderStepped:Wait() do
            for _, Players in next, game:GetService("Players"):GetPlayers() do
                if Players ~= game:GetService("Players").LocalPlayer then
                    Players.MaximumSimulationRadius = 0 
                    sethiddenproperty(Players, "SimulationRadius", 0) 
                end 
            end
            game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
            setsimulationradius(math.huge) 
        end 
    end) 
    coroutine.resume(NetworkAccess)
    local function ForcePart(v)
        if v:IsA("Part") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
            Mouse.TargetFilter = v
            for _, x in next, v:GetChildren() do
                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                    x:Destroy()
                end
            end
            if v:FindFirstChild("Attachment") then
                v:FindFirstChild("Attachment"):Destroy()
            end
            if v:FindFirstChild("AlignPosition") then
                v:FindFirstChild("AlignPosition"):Destroy()
            end
            if v:FindFirstChild("Torque") then
                v:FindFirstChild("Torque"):Destroy()
            end
            v.CanCollide = false
            local Torque = Instance.new("Torque", v)
            Torque.Torque = Vector3.new(100000, 100000, 100000)
            local AlignPosition = Instance.new("AlignPosition", v)
            local Attachment2 = Instance.new("Attachment", v)
            Torque.Attachment0 = Attachment2
            AlignPosition.MaxForce = 9999999999999999
            AlignPosition.MaxVelocity = math.huge
            AlignPosition.Responsiveness = 200
            AlignPosition.Attachment0 = Attachment2 
            AlignPosition.Attachment1 = Attachment1
        end
    end
    for _, v in next, game:GetService("Workspace"):GetDescendants() do
        ForcePart(v)
    end
    game:GetService("Workspace").DescendantAdded:Connect(function(v)
        ForcePart(v)
    end)
    UserInputService.InputBegan:Connect(function(Key, Chat)
        if Key.KeyCode == Enum.KeyCode.E and not Chat then
        Updated = Mouse.Hit + Vector3.new(0, 5, 0)
        end
    end)
    spawn(function()
        while game:GetService("RunService").RenderStepped:Wait() do
            Attachment1.WorldCFrame = Updated
        end
        end)
    end)        

local Autofarm = Window:NewTab('Autofarm')
AutofarmSelection = Autofarm:NewSection("Autofarm")

AutofarmSelection:NewButton("Autofarm gui", "Open Autofarm gui",function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/9b9d62e9068d795f708c51551d439d21/raw/84a28a8d1fc501b9d200e8a2bd7cc831df0fbacf/gistfile1.txt", true))()
end)

local Settings = Window:NewTab("Settings")
SettingsSelection = Settings:NewSection("Settings")

SettingsSelection:NewKeybind("KeybindText", "Change the Keybind", Enum.KeyCode.V, function()
    Library:ToggleUI()
end)

-- Credits

local Credits = Window:NewTab("Credits")
CreditsSection = Credits:NewSection("Credits")

CreditsSection:NewLabel("Made by Real_PainNonsense & PainExploit Team#")