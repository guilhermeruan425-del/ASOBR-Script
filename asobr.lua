-- ASOBR Modern GUI with Background
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

if PlayerGui:FindFirstChild("ASOBRHub") then
    PlayerGui.ASOBRHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ASOBRHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Window
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 340, 0, 420)
Main.Position = UDim2.new(0.5, -170, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(10, 8, 5)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 200, 50)
MainStroke.Thickness = 2
MainStroke.Parent = Main

-- Background Image
local BgImage = Instance.new("ImageLabel")
BgImage.Name = "Background"
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1
BgImage.Image = "rbxassetid://87580233845899"
BgImage.ImageTransparency = 0.55
BgImage.ScaleType = Enum.ScaleType.Crop
BgImage.Parent = Main

local BgCorner = Instance.new("UICorner")
BgCorner.CornerRadius = UDim.new(0, 12)
BgCorner.Parent = BgImage

-- Dark overlay for readability
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.45
Overlay.BorderSizePixel = 0
Overlay.Parent = Main

local OverlayCorner = Instance.new("UICorner")
OverlayCorner.CornerRadius = UDim.new(0, 12)
OverlayCorner.Parent = Overlay

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 12, 8)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 5
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 14, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ASOBR Hub"
Title.TextColor3 = Color3.fromRGB(255, 210, 60)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 6
Title.Parent = TitleBar

-- Minimize
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -68, 0.5, -15)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 20)
MinBtn.Text = "–"
MinBtn.TextColor3 = Color3.fromRGB(255, 210, 60)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 18
MinBtn.ZIndex = 6
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Close
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 25, 25)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.ZIndex = 6
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Content
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 50)
Content.CanvasSize = UDim2.new(0, 0, 0, 520)
Content.ZIndex = 5
Content.Parent = Main

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = Content

-- Helpers
local function CreateLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 200, 50)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 6
    lbl.Parent = Content
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 12)
    btn.BackgroundTransparency = 0.25
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 220, 80)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.ZIndex = 6
    btn.Parent = Content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 180, 40)
    stroke.Thickness = 1
    stroke.Transparency = 0.6
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(callback)
end

-- Features
local allowed_bosses = {
    "Sans", "HardModeSans", "FellSans", "OuterSans", "SwapSans", "KillerSans",
    "DustSans", "AssuredPrey", "HorrorSans", "InsanitySans", "SuddenChangesSans",
    "NightmareSans", "DioSans", "GalaxySans", "NIGHTDUST????", "ChickenInsanitySans",
    "EchotaleSans", "ErrorSans", "InkSans", "WikiSans", "LastBreathSans",
    "Error404Sans", "Fatal_Error_Sans", "[WEAK] BUTTERFLY404", "Fatal_Error_Sans_Phase2",
    "LastBreathSansPhase2", "LastBreathSansPhase3", "VhsSans", "DustDustSans",
    "DustDustSansPhase2", "Fatal_Error", "ErrorDust", "DustDust"
}

CreateLabel("TELEPORTS")
CreateButton("404 Sword (Spawner)", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local sword = workspace:FindFirstChild("404Sword")
        if hrp and sword then
            local cf = sword:IsA("BasePart") and sword.CFrame or sword:GetPivot()
            hrp.CFrame = cf + Vector3.new(0, 5, 0)
        end
    end)
end)

CreateButton("Auto Avenge Sword", function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local sword = nil
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("avenge") and (obj:IsA("BasePart") or obj:IsA("Model")) then
                sword = obj
                break
            end
        end
        if not sword then return end

        local cf = sword:IsA("BasePart") and sword.CFrame or sword:GetPivot()
        hrp.CFrame = cf + Vector3.new(0, 3, 0)
        task.wait(0.4)

        local cd = sword:FindFirstChildOfClass("ClickDetector") or sword:FindFirstChild("ClickDetector", true)
        if cd then fireclickdetector(cd) end
    end)
end)

CreateLabel("COMBAT")
local autoKill = false
local autoConn = nil

CreateButton("Toggle Auto Kill Boss", function()
    autoKill = not autoKill
    local folder = workspace:FindFirstChild("Boss")
    if not folder then return end

    if autoKill then
        autoConn = folder.ChildAdded:Connect(function(child)
            task.delay(0.5, function()
                if autoKill and child and child.Parent and table.find(allowed_bosses, child.Name) then
                    local hum = child:FindFirstChildOfClass("Humanoid")
                    if hum then hum.Health = 0 end
                end
            end)
        end)
    else
        if autoConn then autoConn:Disconnect() autoConn = nil end
    end
end)

CreateButton("Instant Kill All Bosses", function()
    local folder = workspace:FindFirstChild("Boss")
    if not folder then return end
    for _, child in ipairs(folder:GetChildren()) do
        if table.find(allowed_bosses, child.Name) then
            local hum = child:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                hum.Health = 0
            end
        end
    end
end)

CreateButton("Print Current Bosses", function()
    local folder = workspace:FindFirstChild("Boss")
    if not folder then print("No Boss folder") return end
    print("===== Current Bosses =====")
    for _, b in ipairs(folder:GetChildren()) do
        print(b.Name)
    end
    print("==========================")
end)

CreateLabel("PLAYER")
local speedOn = false
local speedVal = 50

CreateButton("Toggle Speed Hack", function()
    speedOn = not speedOn
    if speedOn then
        task.spawn(function()
            while speedOn do
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then hum.WalkSpeed = speedVal end
                end
                task.wait(0.1)
            end
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = 16 end
            end
        end)
    end
end)

-- Minimize / Close
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Content.Visible = false
        Overlay.Visible = false
        BgImage.Visible = false
        Main.Size = UDim2.new(0, 340, 0, 38)
        MinBtn.Text = "+"
    else
        Content.Visible = true
        Overlay.Visible = true
        BgImage.Visible = true
        Main.Size = UDim2.new(0, 340, 0, 420)
        MinBtn.Text = "–"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("✅ ASOBR GUI with background loaded!")
