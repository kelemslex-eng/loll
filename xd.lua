```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Brainrot script - Parsh", "DarkTheme")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local autoSteal = false
local autoCollect = false
local autoLock = false
local autoBuy = false
local autoRebirth = false
local espEnabled = false
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local godEnabled = false
local invisibleUnderground = false
local infRizz = false
local autoRebirthMulti = false
local serverHop = false
local mutationDetect = false
local secretSpawner = false
local webSlinger = false
local infJump = false
local glide = false
local keypadAuto = false
local autoEvent = false
local speedValue = 50
local connections = {}

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "FireServer" and (tostring(self):find("AntiCheat") or tostring(self):find("Detect")) then
        return
    end
    if self == humanoid and method == "ChangeState" then
        return
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

spawn(function()
    while wait(math.random(30, 60)) do
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.W, false, game)
        wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end
end)

local function toggleProtectedNoclip(state)
    noclipEnabled = state
    if state then
        connections.noclip = RunService.Stepped:Connect(function()
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    else
        if connections.noclip then connections.noclip:Disconnect() end
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

local function toggleInvisibleUnderground(state)
    invisibleUnderground = state
    if state then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                part.CanCollide = false
                if part:FindFirstChild("Shadow") then part.Shadow:Destroy() end
            elseif part:IsA("Decal") or part:IsA("Texture") then
                part.Transparency = 1
            end
        end
        toggleProtectedNoclip(true)
        spawn(function()
            while invisibleUnderground do
                pcall(function()
                    for _, base in pairs(workspace:GetChildren()) do
                        if base.Name:match("Base") or base.Name:match("Plot") then
                            for _, brainrot in pairs(base:GetChildren()) do
                                if string.lower(brainrot.Name):find("brainrot") or brainrot.Name:match("Secret") or brainrot.Name:match("God") then
                                    local underPos = brainrot.Position + Vector3.new(math.random(-5,5), -50, math.random(-5,5))
                                    local tween = TweenService:Create(rootPart, TweenInfo.new(math.random(1,2), Enum.EasingStyle.Quad), {CFrame = CFrame.new(underPos)})
                                    tween:Play()
                                    tween.Completed:Wait()
                                    wait(math.random(0.5,1.5))
                                    local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent") or ReplicatedStorage:FindFirstChild("StealRemote")
                                    if stealEvent then
                                        hookmetamethod(game, "__namecall", function() return stealEvent:FireServer(brainrot) end)
                                    elseif brainrot:FindFirstChild("ClickDetector") then
                                        fireclickdetector(brainrot.ClickDetector)
                                    end
                                    local collectEvent = ReplicatedStorage:FindFirstChild("CollectCashEvent") or ReplicatedStorage:FindFirstChild("CollectEvent")
                                    if collectEvent then collectEvent:FireServer() end
                                    local upTween = TweenService:Create(rootPart, TweenInfo.new(0.5), {CFrame = brainrot.CFrame * CFrame.new(0, 10, math.random(-3,3))})
                                    upTween:Play()
                                    upTween.Completed:Wait()
                                end
                            end
                        end
                    end
                    local conveyor = workspace:FindFirstChild("ConveyorBelt") or workspace:FindFirstChild("Conveyor")
                    if conveyor then
                        for _, obj in pairs(conveyor:GetChildren()) do
                            if obj.Name:match("Brainrot") then
                                local underPos = obj.Position + Vector3.new(math.random(-5,5), -50, math.random(-5,5))
                                local tween = TweenService:Create(rootPart, TweenInfo.new(math.random(1,2), Enum.EasingStyle.Quad), {CFrame = CFrame.new(underPos)})
                                tween:Play()
                                tween.Completed:Wait()
                                wait(math.random(0.5,1.5))
                                local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent") or ReplicatedStorage:FindFirstChild("StealRemote")
                                if stealEvent then
                                    hookmetamethod(game, "__namecall", function() return stealEvent:FireServer(obj) end)
                                elseif obj:FindFirstChild("ClickDetector") then
                                    fireclickdetector(obj.ClickDetector)
                                end
                            end
                        end
                    end
                end)
                wait(math.random(3,6))
            end
        end)
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.CanCollide = true
            elseif part:IsA("Decal") or part:IsA("Texture") then
                part.Transparency = 0
            end
        end
        toggleProtectedNoclip(false)
    end
end

local function toggleInfRizz(state)
    infRizz = state
    if state then
        spawn(function()
            while infRizz do
                pcall(function()
                    player.leaderstats.Rizz.Value = math.huge
                    player.leaderstats.Cash.Value = math.huge
                end)
                wait(1)
            end
        end)
    end
end

local function toggleAutoRebirthMulti(state)
    autoRebirthMulti = state
    if state then
        spawn(function()
            while autoRebirthMulti do
                pcall(function()
                    if ReplicatedStorage.RebirthEvent then
                        ReplicatedStorage.RebirthEvent:FireServer(10)
                    end
                end)
                wait(5)
            end
        end)
    end
end

local function toggleServerHop(state)
    serverHop = state
    if state then
        spawn(function()
            while serverHop do
                local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                for _, v in pairs(servers.data) do
                    if v.playing < v.maxPlayers and v.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
                        break
                    end
                end
                wait(60)
            end
        end)
    end
end

local function toggleMutationDetect(state)
    mutationDetect = state
    if state then
        spawn(function()
            while mutationDetect do
                for _, brainrot in pairs(workspace:GetDescendants()) do
                    if brainrot.Name:match("Brainrot") and brainrot:FindFirstChild("Mutation") then
                        game.StarterGui:SetCore("SendNotification", {Title = "Mutation Alert!", Text = "Mutasyonlu Brainrot Bulundu: " .. brainrot.Name})
                    end
                end
                wait(2)
            end
        end)
    end
end

local function toggleSecretSpawner(state)
    secretSpawner = state
    if state then
        spawn(function()
            while secretSpawner do
                pcall(function()
                    if ReplicatedStorage.BuyItem then
                        ReplicatedStorage.BuyItem:FireServer("SecretBrainrot", math.huge)
                    end
                end)
                wait(10)
            end
        end)
    end
end

local function toggleWebSlinger(state)
    webSlinger = state
    if state then
        connections.web = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.F then
                local mouse = player:GetMouse()
                local target = mouse.Target
                if target and target.Parent:FindFirstChild("Humanoid") then
                    local bv = Instance.new("BodyVelocity", target.Parent.HumanoidRootPart)
                    bv.Velocity = Vector3.new(math.random(-100,100), 100, math.random(-100,100))
                    wait(0.5)
                    bv:Destroy()
                end
            end
        end)
    else
        if connections.web then connections.web:Disconnect() end
    end
end

local function toggleInfJump(state)
    infJump = state
    if state then
        connections.infJump = UserInputService.JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    else
        if connections.infJump then connections.infJump:Disconnect() end
    end
end

local function toggleGlide(state)
    glide = state
    if state then
        spawn(function()
            while glide do
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                humanoid.UseJumpPower = false
                humanoid.PlatformStand = true
                wait(0.1)
            end
        end)
    else
        humanoid.PlatformStand = false
    end
end

local function toggleKeypadAuto(state)
    keypadAuto = state
    if state then
        spawn(function()
            while keypadAuto do
                for _, keypad in pairs(workspace:GetDescendants()) do
                    if keypad.Name == "Keypad" then
                        keypad:FireServer("Crack")
                    end
                end
                wait(3)
            end
        end)
    end
end

local function toggleAutoEvent(state)
    autoEvent = state
    if state then
        spawn(function()
            while autoEvent do
                pcall(function()
                    local events = workspace:FindFirstChild("Events")
                    if events then
                        for _, event in pairs(events:GetChildren()) do
                            if event.Name:match("Shamrock") or event.Name:match("Meteor") or event.Name:match("Galactic") then
                                rootPart.CFrame = event.CFrame
                                local joinEvent = ReplicatedStorage:FindFirstChild("JoinEvent")
                                if joinEvent then
                                    joinEvent:FireServer(event.Name)
                                end
                            end
                        end
                    end
                end)
                wait(10)
            end
        end)
    end
end

local function toggleGodmode(state)
    godEnabled = state
    if state then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid.HealthChanged:Connect(function()
            humanoid.Health = math.huge
        end)
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
    end
end

local function toggleAutoSteal(state)
    autoSteal = state
    if state then
        spawn(function()
            while autoSteal do
                pcall(function()
                    local conveyor = workspace:FindFirstChild("ConveyorBelt") or workspace:FindFirstChild("Conveyor")
                    if conveyor then
                        for _, brainrot in pairs(conveyor:GetChildren()) do
                            if brainrot:IsA("BasePart") and brainrot.Name:match("Brainrot") then
                                rootPart.CFrame = brainrot.CFrame * CFrame.new(0, 0, -5)
                                wait(0.1)
                                local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent")
                                if stealEvent then
                                    stealEvent:FireServer(brainrot)
                                elseif brainrot:FindFirstChild("ClickDetector") then
                                    fireclickdetector(brainrot.ClickDetector)
                                end
                            end
                        end
                    end
                    for _, base in pairs(workspace:GetChildren()) do
                        if base.Name:match("Base") or base.Name:match("Plot") then
                            if not base:FindFirstChild("Locked") then
                                for _, brainrot in pairs(base:GetChildren()) do
                                    if brainrot.Name:match("Brainrot") then
                                        rootPart.CFrame = brainrot.CFrame
                                        local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent")
                                        if stealEvent then
                                            stealEvent:FireServer(brainrot)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                wait(math.random(1, 3))
            end
        end)
    end
end

local function toggleAutoCollect(state)
    autoCollect = state
    if state then
        spawn(function()
            while autoCollect do
                pcall(function()
                    local collectEvent = ReplicatedStorage:FindFirstChild("CollectCashEvent") or ReplicatedStorage:FindFirstChild("CollectEvent")
                    if collectEvent then
                        collectEvent:FireServer()
                    end
                    local cashPad = workspace:FindFirstChild("CashPad") or workspace:FindFirstChild("Collect")
                    if cashPad then
                        rootPart.CFrame = cashPad.CFrame
                    end
                end)
                wait(2)
            end
        end)
    end
end

local function toggleAutoLock(state)
    autoLock = state
    if state then
        spawn(function()
            while autoLock do
                wait(30)
                pcall(function()
                    local lockEvent = ReplicatedStorage:FindFirstChild("LockBase")
                    if lockEvent then
                        lockEvent:FireServer()
                    end
                end)
            end
        end)
    end
end

local function toggleAutoBuy(state)
    autoBuy = state
    if state then
        spawn(function()
            while autoBuy do
                pcall(function()
                    local buyEvent = ReplicatedStorage:FindFirstChild("BuyItem")
                    if buyEvent then
                        buyEvent:FireServer("Secret")
                    end
                end)
                wait(5)
            end
        end)
    end
end

local function toggleAutoRebirth(state)
    autoRebirth = state
    if state then
        spawn(function()
            while autoRebirth do
                pcall(function()
                    local rebirthEvent = ReplicatedStorage:FindFirstChild("RebirthEvent")
                    if rebirthEvent then
                        rebirthEvent:FireServer()
                    end
                end)
                wait(10)
            end
        end)
    end
end

local function toggleFly(state)
    flyEnabled = state
    if state then
        local bg = Instance.new("BodyGyro", rootPart)
        bg.MaxTorque = Vector3.new(400000, 400000, 400000)
        bg.P = 20000
        local bv = Instance.new("BodyVelocity", rootPart)
        bv.MaxForce = Vector3.new(400000, 400000, 400000)
        bv.Velocity = Vector3.new(0, 0, 0)
        connections.fly = RunService.Heartbeat:Connect(function()
            local cam = workspace.CurrentCamera
            local move = humanoid.MoveDirection
            bv.Velocity = (cam.CFrame:VectorToWorldSpace(move) * 50) + Vector3.new(0, (UserInputService:IsKeyDown(Enum.KeyCode.Space) and 50 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and 50 or 0), 0)
        end)
    else
        if connections.fly then connections.fly:Disconnect() end
        if rootPart:FindFirstChild("BodyGyro") then rootPart.BodyGyro:Destroy() end
        if rootPart:FindFirstChild("BodyVelocity") then rootPart.BodyVelocity:Destroy() end
    end
end

local function toggleSpeed(state)
    speedEnabled = state
    if state then
        humanoid.WalkSpeed = speedValue
    else
        humanoid.WalkSpeed = 16
    end
end

local function toggleESP(state)
    espEnabled = state
    if state then
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("brainrot") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESP"
                highlight.Parent = obj
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.4
            end
        end
    else
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:FindFirstChild("ESP") then obj.ESP:Destroy() end
        end
    end
end

local MainTab = Window:NewTab("Ana Özellikler")
local MainSection = MainTab:NewSection("Auto Farm & Steal")
MainSection:NewToggle("Auto Steal Brainrots", "Otomatik brainrot çal (conveyor/base)", toggleAutoSteal)
MainSection:NewToggle("Auto Collect Cash", "Otomatik para topla", toggleAutoCollect)
MainSection:NewToggle("Auto Lock Base", "Base'i otomatik kilitle", toggleAutoLock)
MainSection:NewToggle("Auto Buy Secrets", "Secret brainrot al", toggleAutoBuy)
MainSection:NewToggle("Auto Rebirth", "Otomatik rebirth yap", toggleAutoRebirth)
MainSection:NewToggle("Invisible + Underground Steal", "Görünmez ol + Yerin altına git ve çal", toggleInvisibleUnderground)

local AdvancedTab = Window:NewTab("Advanced Hacks")
local AdvancedSection = AdvancedTab:NewSection("Yeni Özellikler")
AdvancedSection:NewToggle("Infinite Rizz/Cash", "Sınırsız para", toggleInfRizz)
AdvancedSection:NewToggle("Auto Rebirth Multipliers", "Auto rebirth + multiplier boost", toggleAutoRebirthMulti)
AdvancedSection:NewToggle("Server Hop", "Full server'a atla", toggleServerHop)
AdvancedSection:NewToggle("Mutation Detection", "Mutasyon alert", toggleMutationDetect)
AdvancedSection:NewToggle("Secret Spawner", "Secret brainrot spawn", toggleSecretSpawner)
AdvancedSection:NewToggle("Web Slinger/Fling", "Troll fling (F tuşu)", toggleWebSlinger)
AdvancedSection:NewToggle("Infinite Jump", "Sonsuz zıpla", toggleInfJump)
AdvancedSection:NewToggle("Glide Mode", "Yavaş düşüş", toggleGlide)
AdvancedSection:NewToggle("Keypad Automation", "Base keypad crack", toggleKeypadAuto)
AdvancedSection:NewToggle("Auto Event Join", "Events'e otomatik katıl", toggleAutoEvent)

local ESPTab = Window:NewTab("ESP")
local ESPSection = ESPTab:NewSection("Visual")
ESPSection:NewToggle("ESP Brainrots", "Brainrot'ları glow göster", toggleESP)

local MoveTab = Window:NewTab("Movement")
local MoveSection = MoveTab:NewSection("Hacks")
MoveSection:NewToggle("Fly", "Uçma (WASD + Space/Shift)", toggleFly)
MoveSection:NewSlider("Speed", "Hız ayarla (16-100)", 500, 16, function(s) speedValue = s toggleSpeed(speedEnabled) end)
MoveSection:NewToggle("Speed Boost", "Hızlı koş", toggleSpeed)
MoveSection:NewToggle("Protected Noclip", "Duvar geç (korumalı)", toggleProtectedNoclip)

local GodTab = Window:NewTab("Godmode")
local GodSection = GodTab:NewSection("Anti-Yakalama")
GodSection:NewToggle("Godmode", "Ölümsüz + anti-ragdoll", toggleGodmode)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if speedEnabled then humanoid.WalkSpeed = speedValue end
    if noclipEnabled then toggleProtectedNoclip(true) end
    if invisibleUnderground then toggleInvisibleUnderground(true) end
    if godEnabled then toggleGodmode(true) end
end)
```