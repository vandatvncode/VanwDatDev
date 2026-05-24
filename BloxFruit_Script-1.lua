-- ╔══════════════════════════════════════════════════════════════╗
-- ║          BLOX FRUIT FULL SCRIPT - GUI EDITION               ║
-- ║        Made for educational / learning purposes only        ║
-- ╚══════════════════════════════════════════════════════════════╝

-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- NOTE: Script này chỉ mang tính học thuật / nghiên cứu Lua
--       Không khuyến khích dùng trong game thật để vi phạm ToS
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

local Players        = game:GetService("Players")
local RunService     = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService   = game:GetService("TweenService")
local Workspace      = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid     = Character:WaitForChild("Humanoid")

-- ═══════════════════════════════════════
--            CONFIG / SETTINGS
-- ═══════════════════════════════════════
local Config = {
    -- Auto Farm
    AutoFarm        = false,
    TargetMob       = "Pirate",          -- Tên mob cần farm
    AutoFarmRange   = 50,
    KillAura        = false,
    KillAuraRange   = 30,
    AutoCollectFruit= false,
    AutoQuest       = false,

    -- Player Mods
    WalkSpeed       = 16,
    JumpPower       = 50,
    Fly             = false,
    NoClip          = false,
    InfiniteJump    = false,
    AntiKnockback   = false,
    AutoHeal        = false,
    AutoHealHP      = 30,               -- % HP để tự heal

    -- ESP / Visuals
    PlayerESP       = false,
    MobESP          = false,
    FruitESP        = false,
    ChestESP        = false,
    BossESP         = false,

    -- Teleport
    TeleportToIsland = false,
    SelectedIsland   = "Marine Starter Island",

    -- Devil Fruit
    AutoEatFruit     = false,
    SpamFruitSkill   = false,
    SelectedSkill    = 1,

    -- Misc
    AntiAFK          = true,
    AutoRejoin       = false,
    ServerHop        = false,
    ShowFPS          = false,

    -- FOV
    CustomFOV        = false,
    FOVValue         = 360,   -- Default Roblox FOV

    -- Fly To Target
    FlyToTarget      = false,
    FlyToSpeed       = 9999,
    FlyToTarget_Name = "Pirate",   -- Tên mob/target
}

-- ═══════════════════════════════════════
--            UTILITY FUNCTIONS
-- ═══════════════════════════════════════
_G.FastAttack = true          -- Bật/Tắt (true = bật)
_G.AttackRange = 60           -- Phạm vi tấn công (studs) - càng lớn càng xa
_G.HitRate = 0.1              -- Tốc độ đánh (thấp = càng nhanh). Ví dụ: 0.05 là rất nhanh
_G.Combo = 2                  -- Số hit mỗi lần (tăng cao hơn sẽ mạnh hơn nhưng dễ lag/kick)

local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local plr = Players.LocalPlayer

local Net = require(RS.Modules.Net)
local Combat = require(RS.Modules.CombatUtil)

local hit = Net:RemoteEvent("RegisterHit", true)
local atk = RS.Modules.Net["RE/RegisterAttack"]

local last = 0

task.spawn(function()
    while task.wait() do
        if not _G.FastAttack then continue end

        local char = plr.Character
        if not char then continue end

        local root = char:FindFirstChild("HumanoidRootPart")
        local tool = char:FindFirstChildOfClass("Tool")

        if not (root and tool) then continue end

        if tick() - last < _G.HitRate then continue end
        last = tick()

        local weapon = Combat:GetWeaponName(tool)
        local id = tostring(plr.UserId):sub(2,4)

        local fired = false

        for _, mob in ipairs(workspace.Enemies:GetChildren()) do
            local hrp = mob:FindFirstChild("HumanoidRootPart")
            local hum = mob:FindFirstChild("Humanoid")

            if hrp and hum and hum.Health > 0 then
                if (hrp.Position - root.Position).Magnitude <= _G.AttackRange then
                    
                    if not fired then
                        atk:FireServer()
                        fired = true
                    end

                    for i = 1, _G.Combo do
                        hit:FireServer(hrp, {{mob, hrp}}, nil, nil, id)
                    end

                    Combat:ApplyDamageHighlight(mob, char, weapon, hrp)
                end
            end
        end
    end
end)

print("✅ Fast Attack đã chạy! Chỉnh _G. ở trên để tùy biến.")

local function notify(title, msg, duration)
    duration = duration or 3
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title    = "🍎 " .. title,
        Text     = msg,
        Duration = duration,
    })
end

local function getCharacter()
    Character = LocalPlayer.Character
    if Character then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        Humanoid         = Character:FindFirstChildOfClass("Humanoid")
    end
    return Character
end

local function getDistance(part1, part2)
    if part1 and part2 then
        return (part1.Position - part2.Position).Magnitude
    end
    return math.huge
end

local function findNearestMob(name, range)
    local nearest, dist = nil, range or Config.AutoFarmRange
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find(name:lower()) then
            local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Root")
            local hum  = obj:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                local d = getDistance(HumanoidRootPart, root)
                if d < dist then
                    nearest, dist = obj, d
                end
            end
        end
    end
    return nearest
end

local function findAllPlayers(range)
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local r = p.Character:FindFirstChild("HumanoidRootPart")
            if r and getDistance(HumanoidRootPart, r) <= range then
                table.insert(list, p)
            end
        end
    end
    return list
end

local function teleportTo(position)
    if HumanoidRootPart then
        HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- ═══════════════════════════════════════
--              ESP MODULE
-- ═══════════════════════════════════════
local ESPObjects = {}

local function createESPBox(obj, color, label)
    if ESPObjects[obj] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name       = "ESP_Label"
    billboard.AlwaysOnTop= true
    billboard.Size       = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset= Vector3.new(0, 3, 0)

    local frame = Instance.new("Frame", billboard)
    frame.BackgroundColor3 = color
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel  = 0
    frame.Size = UDim2.new(1, 0, 1, 0)

    local txt = Instance.new("TextLabel", frame)
    txt.BackgroundTransparency = 1
    txt.Size      = UDim2.new(1,0,1,0)
    txt.Text      = label or obj.Name
    txt.TextColor3= Color3.new(1,1,1)
    txt.TextScaled= true
    txt.Font      = Enum.Font.GothamBold

    local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Root") or obj.PrimaryPart
    if root then
        billboard.Adornee = root
        billboard.Parent  = game.CoreGui
        ESPObjects[obj]   = billboard
    end
end

local function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

local function clearAllESP()
    for obj, gui in pairs(ESPObjects) do
        gui:Destroy()
        ESPObjects[obj] = nil
    end
end

-- ═══════════════════════════════════════
--           FLIGHT MODULE
-- ═══════════════════════════════════════
local flyBodyVelocity, flyBodyGyro
local isFlyActive = false

local function enableFly()
    if isFlyActive then return end
    isFlyActive = true
    local char = getCharacter()
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    hum.PlatformStand = true

    flyBodyVelocity = Instance.new("BodyVelocity")
    flyBodyVelocity.Velocity       = Vector3.new(0,0,0)
    flyBodyVelocity.MaxForce       = Vector3.new(1e9,1e9,1e9)
    flyBodyVelocity.Parent         = hrp

    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque  = Vector3.new(1e9,1e9,1e9)
    flyBodyGyro.D          = 100
    flyBodyGyro.Parent     = hrp

    local speed = 50
    RunService.RenderStepped:Connect(function()
        if not Config.Fly or not isFlyActive then
            if flyBodyVelocity then flyBodyVelocity:Destroy() end
            if flyBodyGyro     then flyBodyGyro:Destroy()     end
            if hum then hum.PlatformStand = false end
            isFlyActive = false
            return
        end
        local cam = Workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end

        flyBodyVelocity.Velocity = dir * speed
        flyBodyGyro.CFrame       = cam.CFrame
    end)
end

local function disableFly()
    Config.Fly  = false
    isFlyActive = false
end

-- ═══════════════════════════════════════
--         FLY TO TARGET MODULE
-- ═══════════════════════════════════════
local flyToConnection

local function startFlyToTarget()
    if flyToConnection then flyToConnection:Disconnect() end

    flyToConnection = RunService.Heartbeat:Connect(function()
        if not Config.FlyToTarget then return end
        local char = getCharacter()
        if not char or not HumanoidRootPart then return end

        local target = findNearestMob(Config.FlyToTarget_Name, 9999)
        if not target then return end

        local root = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Root")
        if not root then return end

        -- Bay mượt về phía target
        local dir = (root.Position - HumanoidRootPart.Position)
        local dist = dir.Magnitude

        if dist > 8 then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end

            -- Tạo BodyVelocity nếu chưa có
            local bv = HumanoidRootPart:FindFirstChild("FlyToTarget_BV")
            if not bv then
                bv = Instance.new("BodyVelocity")
                bv.Name     = "FlyToTarget_BV"
                bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bv.Parent   = HumanoidRootPart
            end
            bv.Velocity = dir.Unit * Config.FlyToSpeed

            -- Hướng mặt về target
            HumanoidRootPart.CFrame = CFrame.lookAt(
                HumanoidRootPart.Position,
                Vector3.new(root.Position.X, HumanoidRootPart.Position.Y, root.Position.Z)
            )
        else
            -- Đến nơi rồi, dừng lại
            local bv = HumanoidRootPart:FindFirstChild("FlyToTarget_BV")
            if bv then bv:Destroy() end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end)
end

local function stopFlyToTarget()
    Config.FlyToTarget = false
    if flyToConnection then flyToConnection:Disconnect() end
    local char = getCharacter()
    if char then
        local bv = HumanoidRootPart and HumanoidRootPart:FindFirstChild("FlyToTarget_BV")
        if bv then bv:Destroy() end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

startFlyToTarget()

-- ═══════════════════════════════════════
--          NOCLIP MODULE
-- ═══════════════════════════════════════
RunService.Stepped:Connect(function()
    if Config.NoClip then
        local char = getCharacter()
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
--         INFINITE JUMP MODULE
-- ═══════════════════════════════════════
UserInputService.JumpRequest:Connect(function()
    if Config.InfiniteJump then
        local char = getCharacter()
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

-- ═══════════════════════════════════════
--           AUTO FARM MODULE
-- ═══════════════════════════════════════
local autoFarmConnection

local function startAutoFarm()
    autoFarmConnection = RunService.Heartbeat:Connect(function()
        if not Config.AutoFarm then return end
        local char = getCharacter()
        if not char or not HumanoidRootPart then return end

        local mob = findNearestMob(Config.TargetMob, Config.AutoFarmRange)
        if mob then
            local root = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Root")
            if root then
                -- Teleport behind mob
                HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, 3)
                -- Auto attack (fire remote)
                local remote = ReplicatedStorage:FindFirstChild("Remotes")
                if remote then
                    local attack = remote:FindFirstChild("KeySystem")
                    if attack then
                        attack:FireServer()
                    end
                end
            end
        end
    end)
end

startAutoFarm()

-- ═══════════════════════════════════════
--          KILL AURA MODULE
-- ═══════════════════════════════════════
RunService.Heartbeat:Connect(function()
    if not Config.KillAura then return end
    local char = getCharacter()
    if not char then return end

    for _, mob in ipairs(Workspace:GetDescendants()) do
        if mob:IsA("Model") then
            local hum  = mob:FindFirstChildOfClass("Humanoid")
            local root = mob:FindFirstChild("HumanoidRootPart") or mob:FindFirstChild("Root")
            if hum and hum.Health > 0 and root and mob ~= char then
                local dist = getDistance(HumanoidRootPart, root)
                if dist <= Config.KillAuraRange then
                    hum.Health = 0  -- Simulate damage
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
--           AUTO HEAL MODULE
-- ═══════════════════════════════════════
RunService.Heartbeat:Connect(function()
    if not Config.AutoHeal then return end
    local char = getCharacter()
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        local hpPercent = (hum.Health / hum.MaxHealth) * 100
        if hpPercent <= Config.AutoHealHP then
            -- Use food item if exists
            local backpack = LocalPlayer.Backpack
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool.Name:lower():find("food") or tool.Name:lower():find("meat") then
                    tool.Parent = char
                    local activate = tool:FindFirstChildOfClass("LocalScript") or tool:FindFirstChild("Activate")
                    if tool:FindFirstChildWhichIsA("Tool") then
                        tool:Activate()
                    end
                    break
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
--             ANTI AFK MODULE
-- ═══════════════════════════════════════
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    end
end)

-- ═══════════════════════════════════════
--             SPEED / JUMP MODULE
-- ═══════════════════════════════════════
local function applyMovementStats()
    local char = getCharacter()
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed  = Config.WalkSpeed
            hum.JumpPower  = Config.JumpPower
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    char:WaitForChild("Humanoid")
    char:WaitForChild("HumanoidRootPart")
    HumanoidRootPart = char.HumanoidRootPart
    Humanoid         = char.Humanoid
    applyMovementStats()
end)

RunService.Heartbeat:Connect(applyMovementStats)

-- ═══════════════════════════════════════
--           ISLANDS DATA
-- ═══════════════════════════════════════
local Islands = {
    ["Marine Starter Island"] = Vector3.new(977.8, 5.7, 1818.7),
    ["Pirate Starter Island"]  = Vector3.new(-1329.3, 5.7, -3107.5),
    ["Middle Town"]            = Vector3.new(928.5, 14.5, 681.6),
    ["Jungle"]                 = Vector3.new(-700.2, 82.8, -4332.1),
    ["Pirate Village"]         = Vector3.new(-2124.0, 9.5, -3050.0),
    ["Desert"]                 = Vector3.new(924.0, 125.8, 4369.4),
    ["Snow Island"]            = Vector3.new(1183.5, 183.7, -1428.3),
    ["Sky Islands"]            = Vector3.new(-4864.3, 872.1, -1662.8),
    ["Prison"]                 = Vector3.new(4739.7, 15.0, -2803.0),
    ["Colosseum"]              = Vector3.new(745.9, 20.0, 2046.9),
    ["Magma Village"]          = Vector3.new(-4793.1, 13.5, -2898.1),
    ["Underwater City"]        = Vector3.new(-5145.1, -157.0, -3563.7),
    ["Fountain City"]          = Vector3.new(5025.3, 4.0, -4934.0),
    -- Sea 2
    ["Kingdom of Rose"]        = Vector3.new(801.0, 5.5, -2986.8),
    ["Green Zone"]             = Vector3.new(-2060.2, 88.2, -4318.2),
    ["Graveyard"]              = Vector3.new(5151.3, 4.5, -4808.8),
    ["Ice Castle"]             = Vector3.new(-4843.4, 1.2, -4948.5),
    ["Forgotten Island"]       = Vector3.new(-5067.1, 8.0, -5225.0),
    -- Sea 3
    ["Port Town"]              = Vector3.new(-14.0, 15.0, -6270.0),
    ["Hydra Island"]           = Vector3.new(-4760.0, 10.0, -9016.0),
    ["Great Tree"]             = Vector3.new(-9098.0, 102.0, -8019.0),
    ["Floating Turtle"]        = Vector3.new(-12793.0, 200.0, -5900.0),
}

-- ═══════════════════════════════════════
--           BOSS LIST
-- ═══════════════════════════════════════
local Bosses = {
    "Saber Expert", "Don Krieg", "Arlong", "Wysper", "Thunder God",
    "Cyborg", "Beautiful Pirate", "Darkbeard", "Rip_Indra", "Swan",
    "Smoke Admiral", "Magma Admiral", "Diamond", "Military Detective",
    "Soul Reaper", "Tide Keeper", "Stone", "Island Empress",
    "Cursed Captain", "Longma", "Cake Queen", "Kilo Admiral",
}

-- ═══════════════════════════════════════
--        TELEPORT TO ISLAND
-- ═══════════════════════════════════════
local function tpIsland(name)
    local pos = Islands[name]
    if pos then
        teleportTo(pos)
        notify("Teleport", "Đã teleport đến " .. name)
    else
        notify("Lỗi", "Không tìm thấy đảo: " .. name)
    end
end

-- ═══════════════════════════════════════
--           ESP LOOP
-- ═══════════════════════════════════════
RunService.RenderStepped:Connect(function()
    -- Player ESP
    if Config.PlayerESP then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                createESPBox(p.Character, Color3.fromRGB(255, 50, 50), p.Name)
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then removeESP(p.Character) end
        end
    end

    -- Mob ESP
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") then
            local hum = obj:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 and not Players:FindFirstChild(obj.Name) then
                if Config.MobESP then
                    -- Check if boss
                    local isBoss = false
                    for _, b in ipairs(Bosses) do
                        if obj.Name:lower():find(b:lower()) then isBoss = true break end
                    end
                    if isBoss and Config.BossESP then
                        createESPBox(obj, Color3.fromRGB(255, 165, 0), "⚔️ BOSS: " .. obj.Name)
                    elseif not isBoss then
                        createESPBox(obj, Color3.fromRGB(50, 255, 100), obj.Name)
                    end
                else
                    removeESP(obj)
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
--      AUTO COLLECT FRUIT LOOP
-- ═══════════════════════════════════════
RunService.Heartbeat:Connect(function()
    if not Config.AutoCollectFruit then return end
    local char = getCharacter()
    if not char then return end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("fruit") then
            local root = obj:FindFirstChild("Handle") or obj.PrimaryPart
            if root then
                local dist = getDistance(HumanoidRootPart, root)
                if dist <= 200 then
                    teleportTo(root.Position)
                    task.wait(0.5)
                    -- Touch to collect
                    local touch = obj:FindFirstChild("TouchInterest")
                    if touch then
                        firetouchinterest(HumanoidRootPart, obj.PrimaryPart or root, 0)
                    end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════
--           GUI CREATION
-- ═══════════════════════════════════════

-- Remove existing GUI
local oldGui = game.CoreGui:FindFirstChild("BloxFruitHub")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "BloxFruitHub"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent         = game.CoreGui

-- ── Main Frame ──────────────────────────────────────────────
local MainFrame = Instance.new("Frame")
MainFrame.Name               = "MainFrame"
MainFrame.Size               = UDim2.new(0, 560, 0, 420)
MainFrame.Position           = UDim2.new(0.5, -280, 0.5, -210)
MainFrame.BackgroundColor3   = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel    = 0
MainFrame.Active             = true
MainFrame.Draggable          = true
MainFrame.Parent             = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Gradient border effect
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color     = Color3.fromRGB(255, 100, 0)
stroke.Thickness = 1.5

-- ── Title Bar ────────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Size             = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
TitleBar.BorderSizePixel  = 0
TitleBar.Parent           = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

-- Fix bottom corners of title bar
local titleFix = Instance.new("Frame")
titleFix.Size             = UDim2.new(1,0,0.5,0)
titleFix.Position         = UDim2.new(0,0,0.5,0)
titleFix.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
titleFix.BorderSizePixel  = 0
titleFix.Parent           = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size                  = UDim2.new(1, -50, 1, 0)
TitleLabel.Position              = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency= 1
TitleLabel.Text                  = "🍎 Blox Fruit Hub  |  Full Script"
TitleLabel.TextColor3            = Color3.new(1, 1, 1)
TitleLabel.TextSize              = 15
TitleLabel.Font                  = Enum.Font.GothamBold
TitleLabel.TextXAlignment        = Enum.TextXAlignment.Left
TitleLabel.Parent                = TitleBar

-- Close button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size                  = UDim2.new(0, 30, 0, 30)
CloseBtn.Position              = UDim2.new(1, -36, 0, 5)
CloseBtn.BackgroundColor3      = Color3.fromRGB(200, 50, 50)
CloseBtn.Text                  = "✕"
CloseBtn.TextColor3            = Color3.new(1,1,1)
CloseBtn.TextSize              = 14
CloseBtn.Font                  = Enum.Font.GothamBold
CloseBtn.BorderSizePixel       = 0
CloseBtn.Parent                = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size             = UDim2.new(0, 30, 0, 30)
MinBtn.Position         = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 0)
MinBtn.Text             = "–"
MinBtn.TextColor3       = Color3.new(1,1,1)
MinBtn.TextSize         = 16
MinBtn.Font             = Enum.Font.GothamBold
MinBtn.BorderSizePixel  = 0
MinBtn.Parent           = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 560, 0, 40)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 560, 0, 420)}):Play()
    end
end)

-- ── Tab Container ─────────────────────────────────────────────
local TabBar = Instance.new("Frame")
TabBar.Size             = UDim2.new(0, 120, 1, -50)
TabBar.Position         = UDim2.new(0, 0, 0, 45)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 33)
TabBar.BorderSizePixel  = 0
TabBar.Parent           = MainFrame

local tabList = Instance.new("UIListLayout", TabBar)
tabList.Padding        = UDim.new(0, 4)
tabList.SortOrder      = Enum.SortOrder.LayoutOrder
tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
Instance.new("UIPadding", TabBar).PaddingTop = UDim.new(0, 8)

local ContentArea = Instance.new("Frame")
ContentArea.Size             = UDim2.new(1, -128, 1, -50)
ContentArea.Position         = UDim2.new(0, 124, 0, 45)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent           = MainFrame

-- ── Helper: Make Tab ──────────────────────────────────────────
local tabs = {}
local pages = {}
local activeTab = nil

local function makeTab(icon, label, order)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(0, 108, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 48)
    btn.Text             = icon .. " " .. label
    btn.TextColor3       = Color3.fromRGB(180, 180, 200)
    btn.TextSize         = 12
    btn.Font             = Enum.Font.GothamSemibold
    btn.BorderSizePixel  = 0
    btn.LayoutOrder      = order
    btn.Parent           = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size                  = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency= 1
    page.ScrollBarThickness    = 3
    page.ScrollBarImageColor3  = Color3.fromRGB(255, 90, 0)
    page.BorderSizePixel       = 0
    page.Visible               = false
    page.Parent                = ContentArea
    local listLayout = Instance.new("UIListLayout", page)
    listLayout.Padding    = UDim.new(0, 6)
    listLayout.SortOrder  = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", page).PaddingTop = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        if activeTab then
            tabs[activeTab].BackgroundColor3 = Color3.fromRGB(30, 30, 48)
            tabs[activeTab].TextColor3       = Color3.fromRGB(180, 180, 200)
            pages[activeTab].Visible         = false
        end
        activeTab                = label
        btn.BackgroundColor3     = Color3.fromRGB(255, 90, 0)
        btn.TextColor3           = Color3.new(1,1,1)
        page.Visible             = true
    end)

    tabs[label]  = btn
    pages[label] = page
    return page
end

-- ── Helper: Make Toggle ───────────────────────────────────────
local function makeToggle(parent, label, configKey, order, callback)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1, -12, 0, 34)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 44)
    row.BorderSizePixel  = 0
    row.LayoutOrder      = order
    row.Parent           = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

    local lbl = Instance.new("TextLabel")
    lbl.Size                   = UDim2.new(1, -60, 1, 0)
    lbl.Position               = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = label
    lbl.TextColor3             = Color3.fromRGB(210, 210, 225)
    lbl.TextSize               = 12
    lbl.Font                   = Enum.Font.Gotham
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.Parent                 = row

    local toggleBg = Instance.new("Frame")
    toggleBg.Size             = UDim2.new(0, 42, 0, 22)
    toggleBg.Position         = UDim2.new(1, -50, 0.5, -11)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBg.BorderSizePixel  = 0
    toggleBg.Parent           = row
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 18, 0, 18)
    knob.Position         = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.new(1,1,1)
    knob.BorderSizePixel  = 0
    knob.Parent           = toggleBg
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = Config[configKey] or false

    local function updateVisual()
        if state then
            TweenService:Create(toggleBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(255, 90, 0)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(0, 22, 0.5, -9)}):Play()
        else
            TweenService:Create(toggleBg, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.15), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        end
    end

    updateVisual()

    local clickBtn = Instance.new("TextButton")
    clickBtn.Size                  = UDim2.new(1,0,1,0)
    clickBtn.BackgroundTransparency= 1
    clickBtn.Text                  = ""
    clickBtn.Parent                = row

    clickBtn.MouseButton1Click:Connect(function()
        state          = not state
        Config[configKey] = state
        updateVisual()
        if callback then callback(state) end
    end)

    return row
end

-- ── Helper: Make Slider ───────────────────────────────────────
local function makeSlider(parent, label, configKey, minV, maxV, order, callback)
    local row = Instance.new("Frame")
    row.Size             = UDim2.new(1, -12, 0, 50)
    row.BackgroundColor3 = Color3.fromRGB(28, 28, 44)
    row.BorderSizePixel  = 0
    row.LayoutOrder      = order
    row.Parent           = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

    local lbl = Instance.new("TextLabel")
    lbl.Size                   = UDim2.new(1, -50, 0, 20)
    lbl.Position               = UDim2.new(0, 10, 0, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = label .. ": " .. tostring(Config[configKey])
    lbl.TextColor3             = Color3.fromRGB(210, 210, 225)
    lbl.TextSize               = 12
    lbl.Font                   = Enum.Font.Gotham
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.Parent                 = row

    local track = Instance.new("Frame")
    track.Size             = UDim2.new(1, -20, 0, 6)
    track.Position         = UDim2.new(0, 10, 0, 32)
    track.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    track.BorderSizePixel  = 0
    track.Parent           = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size             = UDim2.new((Config[configKey] - minV) / (maxV - minV), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
    fill.BorderSizePixel  = 0
    fill.Parent           = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    track.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel   = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local value = math.floor(minV + (maxV - minV) * rel)
            Config[configKey]   = value
            fill.Size           = UDim2.new(rel, 0, 1, 0)
            lbl.Text            = label .. ": " .. tostring(value)
            if callback then callback(value) end
        end
    end)
end

-- ── Helper: Make Button ───────────────────────────────────────
local function makeButton(parent, label, order, callback)
    local btn = Instance.new("TextButton")
    btn.Size             = UDim2.new(1, -12, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(255, 90, 0)
    btn.Text             = label
    btn.TextColor3       = Color3.new(1,1,1)
    btn.TextSize         = 12
    btn.Font             = Enum.Font.GothamBold
    btn.BorderSizePixel  = 0
    btn.LayoutOrder      = order
    btn.Parent           = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)

    btn.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(220, 70, 0)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 90, 0)}):Play()
    end)
    return btn
end

-- ── Helper: Section Label ──────────────────────────────────────
local function makeSection(parent, text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size                   = UDim2.new(1, -12, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text                   = "── " .. text .. " ──"
    lbl.TextColor3             = Color3.fromRGB(255, 90, 0)
    lbl.TextSize               = 11
    lbl.Font                   = Enum.Font.GothamBold
    lbl.TextXAlignment         = Enum.TextXAlignment.Left
    lbl.LayoutOrder            = order
    lbl.Parent                 = parent
end

-- ════════════════════════════════════════
--         BUILD TABS & CONTENT
-- ════════════════════════════════════════

-- ── Tab: AUTO FARM ─────────────────────────────────────────────
local farmPage = makeTab("⚔️", "Auto Farm", 1)
makeSection(farmPage, "Farming", 1)
makeToggle(farmPage, "Auto Farm", "AutoFarm", 2)
makeToggle(farmPage, "Kill Aura", "KillAura", 3)
makeToggle(farmPage, "Auto Quest", "AutoQuest", 4)
makeToggle(farmPage, "Auto Collect Fruit", "AutoCollectFruit", 5)
makeSlider(farmPage, "Farm Range", "AutoFarmRange", 10, 200, 6)
makeSlider(farmPage, "Kill Aura Range", "KillAuraRange", 5, 100, 7)
makeSection(farmPage, "Target Mob", 8)
makeButton(farmPage, "Set Target: Pirate", 9, function()
    Config.TargetMob = "Pirate"
    notify("Auto Farm", "Target đặt thành: Pirate")
end)
makeButton(farmPage, "Set Target: Marine", 10, function()
    Config.TargetMob = "Marine"
    notify("Auto Farm", "Target đặt thành: Marine")
end)
makeButton(farmPage, "Set Target: Bandit", 11, function()
    Config.TargetMob = "Bandit"
    notify("Auto Farm", "Target đặt thành: Bandit")
end)

-- ── Tab: PLAYER ────────────────────────────────────────────────
local playerPage = makeTab("🏃", "Player", 2)
makeSection(playerPage, "Movement", 1)
makeSlider(playerPage, "Walk Speed", "WalkSpeed", 16, 500, 2)
makeSlider(playerPage, "Jump Power", "JumpPower", 50, 500, 3)
makeToggle(playerPage, "Fly", "Fly", 4, function(v)
    if v then enableFly() else disableFly() end
end)
makeToggle(playerPage, "No Clip", "NoClip", 5)
makeToggle(playerPage, "Infinite Jump", "InfiniteJump", 6)
makeToggle(playerPage, "Anti Knockback", "AntiKnockback", 7)
makeSection(playerPage, "Combat & Survival", 8)
makeToggle(playerPage, "Auto Heal", "AutoHeal", 9)
makeSlider(playerPage, "Heal at HP%", "AutoHealHP", 5, 90, 10)
makeButton(playerPage, "Reset Stats", 11, function()
    Config.WalkSpeed = 16
    Config.JumpPower = 50
    notify("Player", "Đã reset stats về mặc định")
end)
makeSection(playerPage, "Fly To Target", 12)
makeToggle(playerPage, "Fly To Target", "FlyToTarget", 13, function(v)
    if v then
        startFlyToTarget()
        notify("Fly To Target", "Đang bay tới: " .. Config.FlyToTarget_Name)
    else
        stopFlyToTarget()
        notify("Fly To Target", "Đã tắt")
    end
end)
makeSlider(playerPage, "Fly Speed", "FlyToSpeed", 20, 300, 14)
makeButton(playerPage, "Target: Pirate", 15, function()
    Config.FlyToTarget_Name = "Pirate"
    notify("Fly To Target", "Target: Pirate")
end)
makeButton(playerPage, "Target: Marine", 16, function()
    Config.FlyToTarget_Name = "Marine"
    notify("Fly To Target", "Target: Marine")
end)
makeButton(playerPage, "Target: Boss", 17, function()
    Config.FlyToTarget_Name = "Darkbeard"
    notify("Fly To Target", "Target: Darkbeard Boss")
end)

-- ── Tab: ESP ───────────────────────────────────────────────────
local espPage = makeTab("👁️", "ESP", 3)
makeSection(espPage, "ESP Options", 1)
makeToggle(espPage, "Player ESP", "PlayerESP", 2)
makeToggle(espPage, "Mob ESP", "MobESP", 3)
makeToggle(espPage, "Fruit ESP", "FruitESP", 4)
makeToggle(espPage, "Chest ESP", "ChestESP", 5)
makeToggle(espPage, "Boss ESP", "BossESP", 6)
makeSection(espPage, "Actions", 7)
makeButton(espPage, "Clear All ESP", 8, function()
    clearAllESP()
    notify("ESP", "Đã xoá tất cả ESP")
end)

-- ── Tab: TELEPORT ──────────────────────────────────────────────
local tpPage = makeTab("🌀", "Teleport", 4)
makeSection(tpPage, "Sea 1", 1)
local sea1Islands = {
    "Marine Starter Island", "Pirate Starter Island", "Middle Town",
    "Jungle", "Pirate Village", "Desert", "Snow Island",
    "Sky Islands", "Prison", "Colosseum", "Magma Village",
    "Underwater City", "Fountain City"
}
for i, island in ipairs(sea1Islands) do
    makeButton(tpPage, island, i + 1, function()
        tpIsland(island)
    end)
end
makeSection(tpPage, "Sea 2", #sea1Islands + 2)
local sea2Islands = {
    "Kingdom of Rose", "Green Zone", "Graveyard",
    "Ice Castle", "Forgotten Island"
}
for i, island in ipairs(sea2Islands) do
    makeButton(tpPage, island, #sea1Islands + i + 2, function()
        tpIsland(island)
    end)
end
makeSection(tpPage, "Sea 3", #sea1Islands + #sea2Islands + 3)
local sea3Islands = {
    "Port Town", "Hydra Island", "Great Tree", "Floating Turtle"
}
for i, island in ipairs(sea3Islands) do
    makeButton(tpPage, island, #sea1Islands + #sea2Islands + i + 3, function()
        tpIsland(island)
    end)
end

-- ── Tab: MISC ──────────────────────────────────────────────────
local miscPage = makeTab("⚙️", "Misc", 5)
makeSection(miscPage, "Quality of Life", 1)
makeToggle(miscPage, "Anti AFK", "AntiAFK", 2)
makeToggle(miscPage, "Show FPS", "ShowFPS", 3)
makeSection(miscPage, "FOV (Field of View)", 4)
makeToggle(miscPage, "Custom FOV", "CustomFOV", 5, function(v)
    if not v then
        Workspace.CurrentCamera.FieldOfView = 70
    end
end)
makeSlider(miscPage, "FOV Value", "FOVValue", 30, 120, 6, function(v)
    if Config.CustomFOV then
        Workspace.CurrentCamera.FieldOfView = v
    end
end)
makeSection(miscPage, "Devil Fruit", 7)
makeToggle(miscPage, "Auto Eat Fruit", "AutoEatFruit", 5)
makeToggle(miscPage, "Spam Fruit Skill", "SpamFruitSkill", 6)
makeSection(miscPage, "Server", 7)
makeButton(miscPage, "Rejoin Server", 8, function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
makeButton(miscPage, "Copy Server ID", 9, function()
    setclipboard(game.JobId)
    notify("Server", "Đã copy Server ID!")
end)
makeSection(miscPage, "Script Info", 10)
makeButton(miscPage, "ℹ️  Blox Fruit Hub v3.0", 11, function()
    notify("Info", "Blox Fruit Hub v3.0 — Educational Use Only")
end)

-- ── Activate first tab ─────────────────────────────────────────
tabs["Auto Farm"]:Fire("MouseButton1Click")  -- fallback
do
    activeTab = "Auto Farm"
    tabs["Auto Farm"].BackgroundColor3 = Color3.fromRGB(255, 90, 0)
    tabs["Auto Farm"].TextColor3       = Color3.new(1,1,1)
    pages["Auto Farm"].Visible         = true
end

-- ── Open/Close Keybind ─────────────────────────────────────────
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ── FPS Counter ────────────────────────────────────────────────
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size                   = UDim2.new(0, 80, 0, 20)
fpsLabel.Position               = UDim2.new(1, -85, 1, -25)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3             = Color3.fromRGB(255, 200, 50)
fpsLabel.TextSize               = 12
fpsLabel.Font                   = Enum.Font.GothamBold
fpsLabel.Text                   = ""
fpsLabel.TextXAlignment         = Enum.TextXAlignment.Right
fpsLabel.Parent                 = MainFrame

local lastTime = tick()
local frames   = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastTime >= 1 then
        if Config.ShowFPS then
            fpsLabel.Text = "FPS: " .. frames
        else
            fpsLabel.Text = ""
        end
        frames, lastTime = 0, tick()
    end
end)

-- ═══════════════════════════════════════
--           FOV MODULE
-- ═══════════════════════════════════════
RunService.RenderStepped:Connect(function()
    local cam = Workspace.CurrentCamera
    if Config.CustomFOV then
        cam.FieldOfView = Config.FOVValue
    else
        cam.FieldOfView = 360
    end
end)

-- ── Startup Notification ───────────────────────────────────────
notify("Blox Fruit Hub", "Script loaded! Nhấn RightShift để ẩn/hiện GUI", 5)

print([[
╔══════════════════════════════════════════╗
║   🍎 BLOX FRUIT HUB v3.0 — LOADED!      ║
║   RightShift   = Toggle GUI              ║
║   WASD/Space   = Fly controls (khi bật)  ║
╚══════════════════════════════════════════╝
]])
