--[[
    Script Hack Roblox - ESP + FOV + AIMBOT + MENU ĐIỀU KHIỂN
    Tương thích: Synapse X, ScriptWare, Krnl, Fluxus, v.v.
    Chú thích toàn bộ bằng tiếng Việt.
]]

-- ==================== DỊCH VỤ ====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Mouse = LocalPlayer:GetMouse()

-- ==================== CÀI ĐẶT ====================
local Settings = {
    ESP = {
        Enabled = false,
        Boxes = false,
        Tracers = true,
        Names = true,
        Distance = true,
        Health = true,
        MaxDistance = 2000,
        PlayerColor = Color3.fromRGB(255, 0, 0),
        TeamColor = Color3.fromRGB(0, 255, 0),
    },
    Aimbot = {
        Enabled = false,
        AimPart = "Head", -- Head, HumanoidRootPart, UpperTorso
        FOV = 100, -- Kích thước vòng tròn FOV
        FOVColor = Color3.fromRGB(255, 255, 255),
        FOVFilled = false,
        FOVTransparency = 0.3,
        Smoothness = 5,
        Prediction = 0.15,
        TriggerBot = false,
        AutoShoot = false,
        TeamCheck = true,
        WallCheck = true,
    },
    Visuals = {
        FOVCircle = true,
        Crosshair = false,
    }
}

-- ==================== MENU ĐIỀU KHIỂN ====================
local Menu = {
    Open = true,
    Draggable = nil,
    Components = {},
}

-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ESP_AIM_MENU"
ScreenGui.Parent = game.CoreGui or LocalPlayer:FindFirstChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Cửa sổ chính
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui

-- Bo góc
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 6)

-- Tiêu đề
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local UICorner2 = Instance.new("UICorner", TitleBar)
UICorner2.CornerRadius = UDim.new(0, 6)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -60, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "ESP + AIMBOT FOV • v1.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab buttons
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 25)
TabFrame.Position = UDim2.new(0, 0, 0, 30)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, 0, 1, -55)
ContentFrame.Position = UDim2.new(0, 0, 0, 55)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 3
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
ContentFrame.Parent = MainFrame

-- Hàm tạo tab
local Tabs = {}
local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    if #Tabs == 1 then
        btn.Position = UDim2.new(0.5, 0, 0, 0)
    end
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = TabFrame
    table.insert(Tabs, btn)
    return btn
end

-- Hàm tạo toggle
function CreateToggle(text, default, callback, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 22)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = ContentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -35, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 30, 0, 18)
    btn.Position = UDim2.new(1, -30, 0.5, -9)
    btn.Text = default and "✔" or ""
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = frame

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "✔" or ""
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 60)
        if callback then callback(state) end
    end)
    return state
end

-- Hàm tạo slider
function CreateSlider(text, min, max, default, callback, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = ContentFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 15)
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 8)
    bar.Position = UDim2.new(0, 0, 0, 17)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local fill = Instance.new("Frame")
    local frac = (default - min) / (max - min)
    fill.Size = UDim2.new(frac, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0, 10, 0, 16)
    drag.Position = UDim2.new(frac, -5, 0, -4)
    drag.Text = ""
    drag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    drag.BorderSizePixel = 0
    drag.Parent = bar

    local dragging = false
    drag.MouseButton1Down:Connect(function()
        dragging = true
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local absX = bar.AbsolutePosition.X
            local absW = bar.AbsoluteSize.X
            local mx = math.clamp(input.Position.X, absX, absX + absW)
            local pct = (mx - absX) / absW
            local val = math.floor(min + (max - min) * pct)
            label.Text = text .. ": " .. tostring(val)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            drag.Position = UDim2.new(pct, -5, 0, -4)
            if callback then callback(val) end
        end
    end)
end

-- Hàm kéo menu
local dragging = false
local dragStart = nil
local startPos = nil
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==================== TẠO NỘI DUNG TAB ====================
CreateTab("ESP")
CreateTab("AIMBOT")

-- Tab ESP
CreateToggle("Bật ESP", false, function(v) Settings.ESP.Enabled = v end, 10)
CreateToggle("Hiển Thị Khung (Box)", false, function(v) Settings.ESP.Boxes = v end, 40)
CreateToggle("Hiển Thị Đường Dò (Tracer)", true, function(v) Settings.ESP.Tracers = v end, 70)
CreateToggle("Hiển Thị Tên", true, function(v) Settings.ESP.Names = v end, 100)
CreateToggle("Hiển Thị Khoảng Cách", true, function(v) Settings.ESP.Distance = v end, 130)
CreateToggle("Hiển Thị Máu", true, function(v) Settings.ESP.Health = v end, 160)
CreateSlider("Khoảng Cách Tối Đa", 100, 5000, 2000, function(v) Settings.ESP.MaxDistance = v end, 190)

-- Tab Aimbot
CreateToggle("Bật Aimbot", false, function(v) Settings.Aimbot.Enabled = v end, 10)
CreateSlider("Kích Thước FOV", 30, 300, 100, function(v) Settings.Aimbot.FOV = v end, 40)
CreateSlider("Độ Mượt (Smooth)", 1, 20, 5, function(v) Settings.Aimbot.Smoothness = v end, 75)
CreateToggle("Kiểm Tra Đồng Đội", true, function(v) Settings.Aimbot.TeamCheck = v end, 110)
CreateToggle("Kiểm Tra Tường", true, function(v) Settings.Aimbot.WallCheck = v end, 140)
CreateToggle("Tự Động Bắn", false, function(v) Settings.Aimbot.AutoShoot = v end, 170)

-- ==================== ESP DRAWING ====================
local ESPObjects = {}
local function CreateDrawing(class, props)
    local obj = Drawing.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    return obj
end

local function UpdateESP()
    -- Xóa ESP cũ
    for _, obj in pairs(ESPObjects) do
        if obj.Remove then obj:Remove() end
    end
    ESPObjects = {}

    if not Settings.ESP.Enabled then return end

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local character = player.Character
        if not character then continue end
        local head = character:FindFirstChild("Head")
        local root = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not head or not root or not humanoid then continue end

        -- Kiểm tra khoảng cách
        local dist = (Camera.CFrame.Position - head.Position).Magnitude
        if dist > Settings.ESP.MaxDistance then continue end

        local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
        local rootPos = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then continue end

        -- Màu sắc theo team
        local color = Settings.ESP.PlayerColor
        if player.Team == LocalPlayer.Team and LocalPlayer.Team ~= nil then
            color = Settings.ESP.TeamColor
        end

        -- Box ESP
        if Settings.ESP.Boxes then
            local boxSize = Vector2.new(40, 60)
            local box = CreateDrawing("Square", {
                Color = color,
                Thickness = 1.5,
                Size = boxSize,
                Position = Vector2.new(headPos.X - boxSize.X/2, headPos.Y - boxSize.Y/2),
                Visible = true,
            })
            table.insert(ESPObjects, box)
        end

        -- Tracer
        if Settings.ESP.Tracers then
            local tracer = CreateDrawing("Line", {
                Color = color,
                Thickness = 1,
                From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y),
                To = Vector2.new(rootPos.X, rootPos.Y),
                Visible = true,
            })
            table.insert(ESPObjects, tracer)
        end

        -- Tên
        if Settings.ESP.Names then
            local nameText = CreateDrawing("Text", {
                Color = color,
                Text = player.Name,
                Position = Vector2.new(headPos.X, headPos.Y - 40),
                Size = 14,
                Center = true,
                Outline = true,
                Visible = true,
            })
            table.insert(ESPObjects, nameText)
        end

        -- Khoảng cách
        if Settings.ESP.Distance then
            local distText = CreateDrawing("Text", {
                Color = Color3.fromRGB(255, 255, 255),
                Text = math.floor(dist) .. "m",
                Position = Vector2.new(headPos.X, headPos.Y + 15),
                Size = 12,
                Center = true,
                Outline = true,
                Visible = true,
            })
            table.insert(ESPObjects, distText)
        end

        -- Thanh máu
        if Settings.ESP.Health then
            local health = humanoid.Health / humanoid.MaxHealth
            local barWidth = 40
            local barHeight = 4
            local barX = headPos.X - barWidth/2
            local barY = headPos.Y - 35

            local bgBar = CreateDrawing("Square", {
                Color = Color3.fromRGB(0, 0, 0),
                Thickness = 1,
                Size = Vector2.new(barWidth, barHeight),
                Position = Vector2.new(barX, barY),
                Filled = true,
                Visible = true,
            })
            table.insert(ESPObjects, bgBar)

            local healthColor = Color3.fromRGB(255 * (1 - health), 255 * health, 0)
            local healthBar = CreateDrawing("Square", {
                Color = healthColor,
                Thickness = 1,
                Size = Vector2.new(barWidth * health, barHeight),
                Position = Vector2.new(barX, barY),
                Filled = true,
                Visible = true,
            })
            table.insert(ESPObjects, healthBar)
        end
    end
end

-- ==================== AIMBOT FOV ====================
local FOVCircle = nil
local function CreateFOVCircle()
    if FOVCircle then
        FOVCircle:Remove()
        FOVCircle = nil
    end
    if Settings.Visuals.FOVCircle and Settings.Aimbot.Enabled then
        FOVCircle = CreateDrawing("Circle", {
            Color = Settings.Aimbot.FOVColor,
            Thickness = 1.5,
            Radius = Settings.Aimbot.FOV,
            Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2),
            Filled = Settings.Aimbot.FOVFilled,
            Transparency = Settings.Aimbot.FOVTransparency,
            Visible = true,
        })
    end
end

local function GetClosestTarget()
    local closest = nil
    local closestDist = Settings.Aimbot.FOV
    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local character = player.Character
        if not character then continue end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        if Settings.Aimbot.TeamCheck and player.Team == LocalPlayer.Team and LocalPlayer.Team ~= nil then continue end

        local aimPart = character:FindFirstChild(Settings.Aimbot.AimPart)
        if not aimPart then
            aimPart = character:FindFirstChild("Head")
        end
        if not aimPart then continue end

        -- Wall check
        if Settings.Aimbot.WallCheck then
            local ray = Ray.new(Camera.CFrame.Position, (aimPart.Position - Camera.CFrame.Position).Unit * 500)
            local hit = workspace:FindPartOnRay(ray, LocalPlayer.Character)
            if hit and hit:IsDescendantOf(character) == false then
                continue
            end
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        if dist < closestDist then
            closestDist = dist
            closest = {player = player, part = aimPart, screenPos = screenPos}
        end
    end
    return closest
end

local function AimbotUpdate()
    if not Settings.Aimbot.Enabled then return end
    local target = GetClosestTarget()
    if not target then return end

    -- Di chuyển chuột mượt
    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local targetPos = Vector2.new(target.screenPos.X, target.screenPos.Y)
    local delta = targetPos - mousePos
    local smooth = Settings.Aimbot.Smoothness / 10

    mousemoverel(delta.X * smooth, delta.Y * smooth)

    -- Tự động bắn
    if Settings.Aimbot.AutoShoot then
        mouse1press()
        task.wait(0.05)
        mouse1release()
    end
end

-- ==================== VÒNG LẶP CHÍNH ====================
RunService.RenderStepped:Connect(function()
    UpdateESP()
    CreateFOVCircle()
    AimbotUpdate()
end)

-- ==================== KEYBINDS ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        Menu.Open = not Menu.Open
        MainFrame.Visible = Menu.Open
    end
    -- Giữ phím E để bắn trigger bot
    if input.KeyCode == Enum.KeyCode.E then
        Settings.Aimbot.TriggerBot = true
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        Settings.Aimbot.TriggerBot = false
    end
end)

print("[ESP+AIMBOT] Script đã tải! Nhấn RightControl để ẩn/hiện menu.")
