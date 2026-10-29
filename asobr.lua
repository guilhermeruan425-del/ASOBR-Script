-- ASOBR Custom Mobile GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove GUI antiga se existir
if PlayerGui:FindFirstChild("ASOBRHub") then
    PlayerGui.ASOBRHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ASOBRHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 280, 0, 380)
Main.Position = UDim2.new(0.5, -140, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 12, 8)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 200, 50)
UIStroke.Thickness = 2
UIStroke.Parent = Main

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 20, 10)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ASOBR Hub"
Title.TextColor3 = Color3.fromRGB(255, 210, 60)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -70, 0.5, -16)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 20)
MinBtn.Text = "–"
MinBtn.TextColor3 = Color3.fromRGB(255, 210, 60)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- Content Frame
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -16, 1, -50)
Content.Position = UDim2.new(0, 8, 0, 45)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Color3.fromRGB(255, 200, 50)
Content.CanvasSize = UDim2.new(0, 0, 0, 520)
Content.Parent = Main

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = Content

-- Helper: Create Button
local function CreateButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = color or Color3.fromRGB(35, 30, 15)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 220, 80)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = true
    btn.Parent = Content

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 70, 30)
    stroke.Thickness = 1
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateLabel(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 200, 50)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Content
    return lbl
end

-- ==================== FEATURES ====================

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
CreateButton("404 Sword (Spawner)", Color3.fromRGB(40, 35, 15), function()
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

CreateButton("Auto Avenge Sword", Color3.fromRGB(40, 35, 15), function()
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

CreateButton("Toggle Auto Kill Boss", Color3.fromRGB(50, 25, 10), function()
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

CreateButton("Instant Kill All Bosses", Color3.fromRGB(60, 20, 15), function()
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

CreateButton("Print Current Bosses", Color3.fromRGB(30, 30, 20), function()
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

CreateButton("Toggle Speed Hack", Color3.fromRGB(25, 40, 25), function()
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

-- Minimize / Close logic
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Content.Visible = false
        Main.Size = UDim2.new(0, 280, 0, 40)
        MinBtn.Text = "+"
    else
        Content.Visible = true
        Main.Size = UDim2.new(0, 280, 0, 380)
        MinBtn.Text = "–"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("✅ ASOBR Custom Mobile GUI loaded!")
