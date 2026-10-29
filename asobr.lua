local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Advanced Soul Ops Boss Rush Script GUI",
    LoadingTitle = "Loading Advanced Soul Ops Boss Rush",
    LoadingSubtitle = "Updated with Fatal_Error + DustDust + Avenge Sword",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "ASOBR_Config"
    }
})

local allowed_bosses = {
    "Sans", "HardModeSans", "FellSans", "OuterSans", "SwapSans", "KillerSans",
    "DustSans", "AssuredPrey", "HorrorSans", "InsanitySans", "SuddenChangesSans",
    "NightmareSans", "DioSans", "GalaxySans", "NIGHTDUST????", "ChickenInsanitySans",
    "EchotaleSans", "ErrorSans", "InkSans", "WikiSans", "LastBreathSans",
    "Error404Sans", "Fatal_Error_Sans", "[WEAK] BUTTERFLY404", "Fatal_Error_Sans_Phase2",
    "LastBreathSansPhase2", "LastBreathSansPhase3", "VhsSans", "DustDustSans",
    "DustDustSansPhase2", "Fatal_Error", "ErrorDust", "DustDust"
}

-- Speed Variables
local speedValue = 50
local speedEnabled = false
local speedCoroutine = nil

-- Teleports Tab
local TeleportsTab = Window:CreateTab("Teleports", 4483362458)
TeleportsTab:CreateSection("Locations")

TeleportsTab:CreateButton({
    Name = "Teleport to 404Sword (Boss Spawner)",
    Callback = function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            if not character then 
                Rayfield:Notify({Title = "Error", Content = "Character not found!", Duration = 3})
                return 
            end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            local sword = workspace:FindFirstChild("404Sword")
            if not sword then
                Rayfield:Notify({Title = "Error", Content = "404Sword not found!", Duration = 4})
                return
            end
            local targetCFrame = sword:IsA("BasePart") and sword.CFrame or sword:GetPivot()
            humanoidRootPart.CFrame = targetCFrame + Vector3.new(0, 5, 0)
            Rayfield:Notify({Title = "Success", Content = "Teleported to 404Sword!", Duration = 3.5})
        end)
    end,
})

-- NOVO: Auto Avenge Sans Sword
TeleportsTab:CreateButton({
    Name = "Auto Avenge Sans Sword",
    Callback = function()
        pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            if not character then
                Rayfield:Notify({Title = "Error", Content = "Character not found!", Duration = 3})
                return
            end

            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local possibleNames = {
                "AvengeSword", "AvengeSansSword", "Avenge_Sword", "SwordAvenge",
                "Avenge", "AvengeSans", "AvengeSansSword", "Avenge_Sword"
            }

            local sword = nil
            for _, name in ipairs(possibleNames) do
                sword = workspace:FindFirstChild(name, true)
                if sword then break end
            end

            -- Busca mais ampla caso não ache pelo nome
            if not sword then
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:IsA("ClickDetector") then
                        local parent = obj.Parent
                        if parent and (parent.Name:lower():find("avenge") or parent.Name:lower():find("sword")) then
                            sword = parent
                            break
                        end
                    end
                end
            end

            if not sword then
                Rayfield:Notify({Title = "Error", Content = "Espada do Avenge Sans não encontrada!", Duration = 4})
                return
            end

            local targetCFrame
            if sword:IsA("BasePart") then
                targetCFrame = sword.CFrame
            elseif sword:IsA("Model") then
                targetCFrame = sword:GetPivot()
            else
                targetCFrame = sword.CFrame or (sword.Parent and sword.Parent.CFrame)
            end

            hrp.CFrame = targetCFrame + Vector3.new(0, 3, 0)
            Rayfield:Notify({Title = "Success", Content = "Teleportado para a espada!", Duration = 2})

            task.wait(0.45)

            local clickDetector = sword:FindFirstChildOfClass("ClickDetector") 
                or sword:FindFirstChild("ClickDetector", true)
                or (sword.Parent and sword.Parent:FindFirstChildOfClass("ClickDetector"))

            if clickDetector then
                fireclickdetector(clickDetector)
                Rayfield:Notify({Title = "Success", Content = "Clicou na espada do Avenge Sans!", Duration = 3})
            else
                Rayfield:Notify({Title = "Error", Content = "ClickDetector não encontrado!", Duration = 3})
            end
        end)
    end,
})

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", 4483362458)
CombatTab:CreateSection("Bosses")

local autoKillConnection
local isAutoEnabled = false

CombatTab:CreateToggle({
    Name = "Auto Kill Boss",
    CurrentValue = false,
    Flag = "AutoKillBoss",
    Callback = function(Value)
        pcall(function()
            local boss_folder = workspace:FindFirstChild("Boss")
            if not boss_folder then
                Rayfield:Notify({Title = "Error", Content = "Boss folder not found!", Duration = 4})
                return
            end
            if Value then
                isAutoEnabled = true
                autoKillConnection = boss_folder.ChildAdded:Connect(function(child)
                    task.delay(0.5, function()
                        if not isAutoEnabled or not child or not child.Parent then return end
                        if table.find(allowed_bosses, child.Name) then
                            local humanoid = child:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid.Health = 0
                            end
                        end
                    end)
                end)
                Rayfield:Notify({Title = "Success", Content = "Auto Kill Boss enabled!", Duration = 4})
            else
                isAutoEnabled = false
                if autoKillConnection then
                    autoKillConnection:Disconnect()
                    autoKillConnection = nil
                end
                Rayfield:Notify({Title = "Info", Content = "Auto Kill Boss disabled.", Duration = 2.5})
            end
        end)
    end,
})

CombatTab:CreateButton({
    Name = "Instant Kill All Bosses",
    Callback = function()
        pcall(function()
            local boss_folder = workspace:FindFirstChild("Boss")
            if not boss_folder then
                Rayfield:Notify({Title = "Error", Content = "Boss folder not found!", Duration = 4})
                return
            end
            local killed = {}
            for _, child in ipairs(boss_folder:GetChildren()) do
                if table.find(allowed_bosses, child.Name) then
                    local humanoid = child:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid.Health = 0
                        table.insert(killed, child.Name)
                    end
                end
            end
            if #killed > 0 then
                Rayfield:Notify({Title = "Success", Content = "Killed: " .. table.concat(killed, ", "), Duration = 4})
            else
                Rayfield:Notify({Title = "Error", Content = "No matching bosses found!", Duration = 5})
            end
        end)
    end,
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)
PlayerTab:CreateSection("Movement")

PlayerTab:CreateToggle({
    Name = "Speed Hack",
    CurrentValue = false,
    Flag = "SpeedHack",
    Callback = function(Value)
        speedEnabled = Value
        local player = game.Players.LocalPlayer
        if Value then
            speedCoroutine = task.spawn(function()
                while task.wait(0.1) do
                    if not speedEnabled then break end
                    local character = player.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.WalkSpeed = speedValue
                        end
                    end
                end
            end)
        else
            if speedCoroutine then
                task.cancel(speedCoroutine)
                speedCoroutine = nil
            end
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end
    end,
})

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " Speed",
    CurrentValue = 50,
    Flag = "WalkSpeed",
    Callback = function(Value)
        speedValue = Value
        if speedEnabled then
            local character = game.Players.LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = Value
                end
            end
        end
    end,
})

print("✅ ASOBR GUI loaded with Fatal_Error + DustDust + Auto Avenge Sword!")
