local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Brainrot script - Parsh", "DarkTheme")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

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
local playerEspEnabled = false
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
local autoUpgrade = false
local fastRespawn = false
local speedValue = 50
local connections = {}

print("NOT: Script yüklendi! UI için Kavo menüyü aç, anti-ban ile dene.")

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == "Kick" or method == "FireServer" and (tostring(self):find("AntiCheat") or tostring(self):find("Detect")) then
        print("NOT: Anti-cheat bypass aktif, kick engellendi!")
        return
    end
    if method == "Teleport" or method == "SetPrimaryPartCFrame" then
        args[1] = args[1] + Vector3.new(math.random(-1,1), 0, math.random(-1,1)) -- Anti-TP detect
    end
    return oldNamecall(self, unpack(args))
end)
setreadonly(mt, true)

spawn(function()
    while wait(math.random(30, 60)) do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)
        wait(0.1)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        VirtualInputManager:SendMouseMoveEvent(math.random(-10,10), math.random(-10,10))
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
        print("NOT: Protected Noclip aktif! Duvar geçmek için toggle açık tut.")
    else
        if connections.noclip then connections.noclip:Disconnect() end
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
        print("NOT: Noclip kapatıldı.")
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
                                    wait(math.random(0.5,2))
                                    local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent") or ReplicatedStorage:FindFirstChild("StealRemote")
                                    if stealEvent then
                                        stealEvent:FireServer(brainrot)
                                        print("NOT: Underground'dan " .. brainrot.Name .. " çalındı!")
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
                                wait(math.random(0.5,2))
                                local stealEvent = ReplicatedStorage:FindFirstChild("StealEvent") or ReplicatedStorage:FindFirstChild("StealRemote")
                                if stealEvent then
                                    stealEvent:FireServer(obj)
                                    print("NOT: Conveyor'dan " .. obj.Name .. " çalındı!")
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
        print("NOT: Invisible Underground aktif! Toggle açık tut, çalma yap.")
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
        print("NOT: Invisible Underground kapatıldı.")
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
        print("NOT: Inf Rizz/Cash aktif! Sınırsız para.")
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
        print("NOT: Auto Rebirth Multi aktif! x10 boost.")
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
        print("NOT: Server Hop aktif! Ban yersen server değiştir.")
    end
end

local function toggleMutationDetect(state)
    mutationDetect = state
    if state then
        spawn(function()
            while mutationDetect do
                for _, brainrot in pairs(workspace:GetDescendants()) do
                    if brainrot.Name:match("Brainrot") and brainrot:FindFirstChild("Mutation") then
                        game.StarterGui:SetCore("SendNotification", {Title = "Mutation Alert!", Text = "Mutasyonlu Brainrot: " .. brainrot.Name})
                    end
                end
                wait(2)
            end
        end)
        print("NOT: Mutation Detect aktif! Mutasyon bildirir.")
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
        print("NOT: Secret Spawner aktif! Secret spawnla.")
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
        print("NOT: Web Slinger aktif! F ile fling yap.")
    else
        if connections.web then connections.web:Disconnect() end
        print("NOT: Web Slinger kapatıldı.")
    end
end

local function toggleInfJump(state)
    infJump = state
    if state then
        connections.infJump = UserInputService.JumpRequest:Connect(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
        print("NOT: Inf Jump aktif! Sürekli zıpla.")
    else
        if connections.infJump then connections.infJump:Disconnect() end
        print("NOT: Inf Jump kapatıldı.")
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
        print("NOT: Glide aktif! Yavaş düş.")
    else
        humanoid.PlatformStand = false
        print("NOT: Glide kapatıldı.")
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
        print("NOT: Keypad Auto aktif! Keypad kır.")
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
        print("NOT: Auto Event aktif! Eventlere katıl.")
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
        print("NOT: Godmode aktif! Ölümsüz ve anti-ragdoll.")
    else
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        print("NOT: Godmode kapatıldı.")
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
                                wait(math.random(0.5,1))
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
                wait(math.random(1,3))
            end
        end)
        print("NOT: Auto Steal aktif! Brainrot çalıyor, ban riskine dikkat.")
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
                wait(math.random(1,2))
            end
        end)
        print("NOT: Auto Collect aktif! Para toplar.")
    end
end

local function toggleAutoLock(state)
    autoLock = state
    if state then
        spawn(function()
            while autoLock do
                wait(math.random(20,30))
                pcall(function()
                    local lockEvent = ReplicatedStorage:FindFirstChild("LockBase")
                    if lockEvent then
                        lockEvent:FireServer()
                    end
                end)
            end
        end)
        print("NOT: Auto Lock aktif! Base kilitlenir.")
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
                wait(math.random(3,5))
            end
        end)
        print("NOT: Auto Buy aktif! Secret alır.")
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
                wait(math.random(5,10))
            end
        end)
        print("NOT: Auto Rebirth aktif! Rebirth yapar.")
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
        print("NOT: Fly aktif! WASD ile uç, ban riskine dikkat.")
    else
        if connections.fly then connections.fly:Disconnect() end
        if rootPart:FindFirstChild("BodyGyro") then rootPart.BodyGyro:Destroy() end
        if rootPart:FindFirstChild("BodyVelocity") then rootPart.BodyVelocity:Destroy() end
        print("NOT: Fly kapatıldı.")
    end
end

local function toggleSpeed(state)
    speedEnabled = state
    if state then
        humanoid.WalkSpeed = speedValue
        print("NOT: Speed Boost aktif! Hız " .. speedValue .. ".")
    else
        humanoid.WalkSpeed = 16
        print("NOT: Speed Boost kapatıldı.")
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
        print("NOT: ESP aktif! Brainrot glow.")
    else
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:FindFirstChild("ESP") then obj.ESP:Destroy() end
        end
        print("NOT: ESP kapatıldı.")
    end
end

local function togglePlayerESP(state)
    playerEspEnabled = state
    if state then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local highlight = Instance.new("Highlight", plr.Character)
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.5
            end
        end
        print("NOT: Player ESP aktif! Oyuncular kırmızı glow.")
    else
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("Highlight") then
                plr.Character.Highlight:Destroy()
            end
        end
        print("NOT: Player ESP kapatıldı.")
    end
end

local function toggleAutoUpgrade(state)
    autoUpgrade = state
    if state then
        spawn(function()
            while autoUpgrade do
                pcall(function()
                    local upgradeEvent = ReplicatedStorage:FindFirstChild("UpgradeBase")
                    if upgradeEvent then
                        upgradeEvent:FireServer()
                    end
                end)
                wait(math.random(3,5))
            end
        end)
        print("NOT: Auto Upgrade aktif! Base yükseltir.")
    end
end

local function toggleFastRespawn(state)
    fastRespawn = state
    if state then
        spawn(function()
            while fastRespawn do
                if humanoid.Health <= 0 then
                    local respawnEvent = ReplicatedStorage:FindFirstChild("Respawn")
                    if respawnEvent then
                        respawnEvent:FireServer()
                    end
                end
                wait(0.1)
            end
        end)
        print("NOT: Fast Respawn aktif! Ölünce doğar.")
    end
end

local MainTab = Window:NewTab("🚀 Ana Özellikler")
local MainSection = MainTab:NewSection("Auto Farm & Steal")
MainSection:NewToggle("Auto Steal Brainrots", "Otomatik çalma", toggleAutoSteal)
MainSection:NewToggle("Auto Collect Cash", "Para topla", toggleAutoCollect)
MainSection:NewToggle("Auto Lock Base", "Base kilitle", toggleAutoLock)
MainSection:NewToggle("Auto Buy Secrets", "Secret al", toggleAutoBuy)
MainSection:NewToggle("Auto Rebirth", "Rebirth yap", toggleAutoRebirth)
MainSection:NewToggle("Invisible + Underground Steal", "Görünmez çalma", toggleInvisibleUnderground)
MainSection:NewToggle("Auto Upgrade", "Base yükselt", toggleAutoUpgrade)
MainSection:NewToggle("Fast Respawn", "Hızlı doğuş", toggleFastRespawn)

local AdvancedTab = Window:NewTab("🔥 Advanced Hacks")
local AdvancedSection = AdvancedTab:NewSection("Ek Özellikler")
AdvancedSection:NewToggle("Infinite Rizz/Cash", "Sınırsız para", toggleInfRizz)
AdvancedSection:NewToggle("Auto Rebirth Multipliers", "Rebirth boost", toggleAutoRebirthMulti)
AdvancedSection:NewToggle("Server Hop", "Server değiştir", toggleServerHop)
AdvancedSection:NewToggle("Mutation Detection", "Mutasyon alert", toggleMutationDetect)
AdvancedSection:NewToggle("Secret Spawner", "Secret spawn", toggleSecretSpawner)
AdvancedSection:NewToggle("Web Slinger/Fling", "Fling (F)", toggleWebSlinger)
AdvancedSection:NewToggle("Infinite Jump", "Sonsuz zıpla", toggleInfJump)
AdvancedSection:NewToggle("Glide Mode", "Yavaş düş", toggleGlide)
AdvancedSection:NewToggle("Keypad Automation", "Keypad kır", toggleKeypadAuto)
AdvancedSection:NewToggle("Auto Event Join", "Event katıl", toggleAutoEvent)

local ESPTab = Window:NewTab("👁️ ESP")
local ESPSection = ESPTab:NewSection("Visual")
ESPSection:NewToggle("ESP Brainrots", "Brainrot glow", toggleESP)
ESPSection:NewToggle("Player ESP", "Oyuncu glow", togglePlayerESP)

local MoveTab = Window:NewTab("✈️ Movement")
local MoveSection = MoveTab:NewSection("Hareket")
MoveSection:NewToggle("Fly", "Uçma", toggleFly)
MoveSection:NewSlider("Speed", "Hız (16-100)", 500, 16, function(s) speedValue = s; toggleSpeed(speedEnabled) end)
MoveSection:NewToggle("Speed Boost", "Hız artışı", function(state) toggleSpeed(state) end)
MoveSection:NewToggle("Protected Noclip", "Duvar geç", toggleProtectedNoclip)

local GodTab = Window:NewTab("🛡️ Godmode")
local GodSection = GodTab:NewSection("Koruma")
GodSection:NewToggle("Godmode", "Ölümsüz", toggleGodmode)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    if speedEnabled then humanoid.WalkSpeed = speedValue end
    if noclipEnabled then toggleProtectedNoclip(true) end
    if invisibleUnderground then toggleInvisibleUnderground(true) end
    if godEnabled then toggleGodmode(true) end
    print("NOT: Karakter yenilendi, özellikler geri yüklendi.")
end)

print("NOT: Anti-ban eklendi! Ban yersen F9'dan hatayı at, çözerim kanka!")