--[[
    SCRIPT HACK ROBLOX SIÊU XỊN - ESP + FOV + AIMBOT + SILENT AIM + TRIGGERBOT
    Menu full chức năng, giao diện đẹp, code tối ưu không lag
    Hỗ trợ: Synapse X, ScriptWare, Krnl, Fluxus, CodeX, v.v.
    Tính năng: ESP 2D Box, Skeleton, Health Bar, Distance, Tracers, Chams,
               Aimbot FOV, Silent Aim, Trigger Bot, Auto Shoot, Wall Check,
               Team Check, Visibility Check, Prediction, Smooth, FOV Circle
]]

-- ==================== DỊCH VỤ ====================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera or workspace:WaitForChild("Camera")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Mouse = LocalPlayer:GetMouse()
local Workspace = workspace

-- ==================== CẤU HÌNH ====================
local Settings = {
    -- ESP
    ESP_Enabled = false,
    ESP_Boxes = false,
    ESP_BoxType = "2D", -- 2D, Corner
    ESP_Skeleton = false,
    ESP_Tracers = true,
    ESP_Names = true,
    ESP_Distance = true,
    ESP_Health = true,
    ESP_HealthBar = true,
    ESP_MaxDistance = 3000,
    ESP_FontSize = 13,
    
    -- Aimbot
    Aimbot_Enabled = false,
    Aimbot_AimPart = "Head",
    Aimbot_FOV = 120,
    Aimbot_Smoothness = 3,
    Aimbot_Prediction = 0.135,
    Aimbot_TeamCheck = true,
    Aimbot_WallCheck = true,
    Aimbot_VisibilityCheck = true,
    Aimbot_TriggerBot = false,
    Aimbot_AutoShoot = false,
    Aimbot_SilentAim = false,
    
    -- Visual
    FOV_Visible = true,
    FOV_Color = Color3.fromRGB(255,255,255),
    FOV_Filled = false,
    FOV_Transparency = 0.2,
    Crosshair = false,
}

-- Biến toàn cục
local ESP_Objects = {}
local FOV_Circle = nil
local CrosshairObj = nil
local Target = nil
local OldTarget = nil

-- ==================== HÀM TIỆN ÍCH ====================
local function CreateDrawing(class, props)
    local drawing = Drawing.new(class)
    for k, v in pairs(props) do
        pcall(function() drawing[k] = v end)
    end
    return drawing
end

local function RemoveESP()
    for _, obj in pairs(ESP_Objects) do
        pcall(function() obj:Remove() end)
    end
    ESP_Objects = {}
end

-- ==================== MENU GIAO DIỆN CAO CẤP ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProHackHub"
ScreenGui.Parent = game.CoreGui or LocalPlayer:FindFirstChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 580, 0, 380)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(255,100,0)
UIStroke.Thickness = 1

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundColor3 = Color3.fromRGB(20,20,20)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local UICornerH = Instance.new("UICorner", Header)
UICornerH.CornerRadius = UDim.new(0, 8)

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(1,-80,1,0)
HeaderTitle.Position = UDim2.new(0,15,0,0)
HeaderTitle.Text = "PRO HACK HUB  |  ESP + AIMBOT  |  v2.0"
HeaderTitle.TextColor3 = Color3.fromRGB(255,120,0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextSize = 15
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0.5,-15)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
CloseBtn.BorderSizePixel = 0
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = Header
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,130,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,18)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

-- Content
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1,-130,1,-40)
Content.Position = UDim2.new(0,130,0,40)
Content.BackgroundColor3 = Color3.fromRGB(15,15,15)
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.CanvasSize = UDim2.new(0,0,0,650)
Content.Parent = MainFrame

-- Tabs
local Tabs = {}
local ContentFrames = {}

local function SwitchTab(name)
    for _, btn in pairs(Tabs) do
        btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
        btn.TextColor3 = Color3.fromRGB(180,180,180)
    end
    Tabs[name].BackgroundColor3 = Color3.fromRGB(255,100,0)
    Tabs[name].TextColor3 = Color3.fromRGB(255,255,255)
    for _, frame in pairs(ContentFrames) do
        frame.Visible = false
    end
    ContentFrames[name].Visible = true
end

local function AddTab(name, y)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(1,0,0,35)
    btn.Position = UDim2.new(0,0,0,y)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180,180,180)
    btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    btn.Parent = Sidebar
    btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    Tabs[name] = btn

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1,0,1,0)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 2
    frame.CanvasSize = UDim2.new(0,0,0,650)
    frame.Visible = false
    frame.Parent = Content
    ContentFrames[name] = frame
    return frame
end

-- Components
local function AddToggle(parent, text, default, callback, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-16,0,28)
    frame.Position = UDim2.new(0,8,0,y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-44,1,0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220,220,220)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local state = default
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,38,0,20)
    btn.Position = UDim2.new(1,-38,0.5,-10)
    btn.Text = state and "ON" or "OFF"
    btn.TextColor3 = state and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(60,60,60)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = frame
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.TextColor3 = state and Color3.fromRGB(0,0,0) or Color3.fromRGB(255,255,255)
        btn.BackgroundColor3 = state and Color3.fromRGB(0,255,0) or Color3.fromRGB(60,60,60)
        if callback then callback(state) end
    end)
    return frame
end

local function AddSlider(parent, text, min, max, default, callback, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-16,0,42)
    frame.Position = UDim2.new(0,8,0,y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,16)
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(200,200,200)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,0,8)
    bar.Position = UDim2.new(0,0,0,20)
    bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local fill = Instance.new("Frame")
    local frac = (default-min)/(max-min)
    fill.Size = UDim2.new(frac,0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(255,100,0)
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local drag = Instance.new("TextButton")
    drag.Size = UDim2.new(0,12,0,18)
    drag.Position = UDim2.new(frac,-6,0,-5)
    drag.Text = ""
    drag.BackgroundColor3 = Color3.fromRGB(255,255,255)
    drag.BorderSizePixel = 0
    drag.Parent = bar

    local dragging = false
    drag.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local absX = bar.AbsolutePosition.X
            local absW = bar.AbsoluteSize.X
            local mx = math.clamp(i.Position.X, absX, absX+absW)
            local pct = (mx-absX)/absW
            local val = math.floor(min + (max-min)*pct)
            label.Text = text .. ": " .. tostring(val)
            fill.Size = UDim2.new(pct,0,1,0)
            drag.Position = UDim2.new(pct,-6,0,-5)
            if callback then callback(val) end
        end
    end)
    return frame
end

-- Kéo menu
local dragMenu = false
local dragStart = nil
local startPos = nil
Header.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragMenu = true
        dragStart = i.Position
        startPos = MainFrame.Position
    end
end)
Header.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragMenu = false end
end)
UserInputService.InputChanged:Connect(function(i)
    if dragMenu and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
    end
end)

-- ==================== XÂY DỰNG MENU ====================
local espTab = AddTab("ESP", 0)
local aimTab = AddTab("AIMBOT", 35)
local visTab = AddTab("VISUAL", 70)
local cfgTab = AddTab("CONFIG", 105)

-- ESP Tab
local y = 5
AddToggle(espTab, "Bật ESP", false, function(v) Settings.ESP_Enabled = v end, y); y=y+32
AddToggle(espTab, "Hiển Thị Khung (2D Box)", false, function(v) Settings.ESP_Boxes = v end, y); y=y+32
AddToggle(espTab, "Hiển Thị Khung Xương (Skeleton)", false, function(v) Settings.ESP_Skeleton = v end, y); y=y+32
AddToggle(espTab, "Đường Dò (Tracers)", true, function(v) Settings.ESP_Tracers = v end, y); y=y+32
AddToggle(espTab, "Hiển Thị Tên", true, function(v) Settings.ESP_Names = v end, y); y=y+32
AddToggle(espTab, "Khoảng Cách", true, function(v) Settings.ESP_Distance = v end, y); y=y+32
AddToggle(espTab, "Thanh Máu (Health Bar)", true, function(v) Settings.ESP_HealthBar = v end, y); y=y+32
AddToggle(espTab, "Số Máu", true, function(v) Settings.ESP_Health = v end, y); y=y+32
AddSlider(espTab, "Khoảng Cách Tối Đa", 100, 10000, 3000, function(v) Settings.ESP_MaxDistance = v end, y); y=y+48

-- Aimbot Tab
y = 5
AddToggle(aimTab, "Bật Aimbot", false, function(v) Settings.Aimbot_Enabled = v end, y); y=y+32
AddToggle(aimTab, "Silent Aim (Ẩn)", false, function(v) Settings.Aimbot_SilentAim = v end, y); y=y+32
AddToggle(aimTab, "Tự Động Bắn (Auto Shoot)", false, function(v) Settings.Aimbot_AutoShoot = v end, y); y=y+32
AddToggle(aimTab, "Trigger Bot (Giữ E)", false, function(v) Settings.Aimbot_TriggerBot = v end, y); y=y+32
AddToggle(aimTab, "Kiểm Tra Đồng Đội", true, function(v) Settings.Aimbot_TeamCheck = v end, y); y=y+32
AddToggle(aimTab, "Kiểm Tra Tường", true, function(v) Settings.Aimbot_WallCheck = v end, y); y=y+32
AddToggle(aimTab, "Kiểm Tra Nhìn Thấy", true, function(v) Settings.Aimbot_VisibilityCheck = v end, y); y=y+32
AddSlider(aimTab, "Kích Thước FOV", 20, 400, 120, function(v) Settings.Aimbot_FOV = v end, y); y=y+48
AddSlider(aimTab, "Độ Mượt (Smooth)", 1, 20, 3, function(v) Settings.Aimbot_Smoothness = v end, y); y=y+48
AddSlider(aimTab, "Dự Đoán (Prediction)", 0, 1, 0.135, function(v) Settings.Aimbot_Prediction = v end, y); y=y+48

-- Visual Tab
y = 5
AddToggle(visTab, "Vòng Tròn FOV", true, function(v) Settings.FOV_Visible = v end, y); y=y+32
AddToggle(visTab, "Tô Màu FOV", false, function(v) Settings.FOV_Filled = v end, y); y=y+32
AddToggle(visTab, "Tâm Ngắm (Crosshair)", false, function(v) Settings.Crosshair = v end, y); y=y+32

-- Config Tab
y = 5
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(1,-16,0,35)
SaveBtn.Position = UDim2.new(0,8,0,y)
SaveBtn.Text = "💾 LƯU CẤU HÌNH"
SaveBtn.TextColor3 = Color3.fromRGB(255,255,255)
SaveBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
SaveBtn.BorderSizePixel = 0
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 13
SaveBtn.Parent = cfgTab

local LoadBtn = Instance.new("TextButton")
LoadBtn.Size = UDim2.new(1,-16,0,35)
LoadBtn.Position = UDim2.new(0,8,0,y+40)
LoadBtn.Text = "📂 TẢI CẤU HÌNH"
LoadBtn.TextColor3 = Color3.fromRGB(255,255,255)
LoadBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
LoadBtn.BorderSizePixel = 0
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.TextSize = 13
LoadBtn.Parent = cfgTab

-- Chọn tab đầu
SwitchTab("ESP")

-- ==================== ESP LOGIC ====================
local function GetBonePosition(model, boneName)
    local bone = model:FindFirstChild(boneName)
    if bone then
        return bone.Position
    end
    return nil
end

local function DrawESP(player)
    local character = player.Character
    if not character then return nil end
    
    local head = character:FindFirstChild("Head")
    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not head or not root or not humanoid or humanoid.Health <= 0 then return nil end

    local dist = (Camera.CFrame.Position - head.Position).Magnitude
    if dist > Settings.ESP_MaxDistance then return nil end

    local headPos, onScreen = Camera:WorldToViewportPoint(head.Position)
    if not onScreen then return nil end

    local rootPos = Camera:WorldToViewportPoint(root.Position)
    local color = Settings.ESP_PlayerColor or Color3.fromRGB(255,0,0)
    if player.Team == LocalPlayer.Team and LocalPlayer.Team ~= nil then
        color = Settings.ESP_TeamColor or Color3.fromRGB(0,255,0)
    end

    local objects = {}

    -- 2D Box
    if Settings.ESP_Boxes then
        local boxH = (headPos.Y - rootPos.Y) * 1.8
        local boxW = boxH * 0.5
        local box = CreateDrawing("Square", {
            Color = color, Thickness = 1.5, Filled = false,
            Size = Vector2.new(boxW, boxH),
            Position = Vector2.new(headPos.X-boxW/2, headPos.Y-boxH*0.6),
            Visible = true
        })
        table.insert(objects, box)
    end

    -- Skeleton
    if Settings.ESP_Skeleton then
        local bones = {
            {"Head","UpperTorso"}, {"UpperTorso","LowerTorso"},
            {"UpperTorso","RightUpperArm"}, {"RightUpperArm","RightLowerArm"}, {"RightLowerArm","RightHand"},
            {"UpperTorso","LeftUpperArm"}, {"LeftUpperArm","LeftLowerArm"}, {"LeftLowerArm","LeftHand"},
            {"LowerTorso","RightUpperLeg"}, {"RightUpperLeg","RightLowerLeg"}, {"RightLowerLeg","RightFoot"},
            {"LowerTorso","LeftUpperLeg"}, {"LeftUpperLeg","LeftLowerLeg"}, {"LeftLowerLeg","LeftFoot"},
        }
        for _, pair in pairs(bones) do
            local p1 = GetBonePosition(character, pair[1])
            local p2 = GetBonePosition(character, pair[2])
            if p1 and p2 then
                local s1 = Camera:WorldToViewportPoint(p1)
                local s2 = Camera:WorldToViewportPoint(p2)
                if s1.Z > 0 and s2.Z > 0 then
                    local line = CreateDrawing("Line", {
                        Color = color, Thickness = 1,
                        From = Vector2.new(s1.X, s1.Y),
                        To = Vector2.new(s2.X, s2.Y),
                        Visible = true
                    })
                    table.insert(objects, line)
                end
            end
        end
    end

    -- Tracer
    if Settings.ESP_Tracers then
        local tracer = CreateDrawing("Line", {
            Color = color, Thickness = 1,
            From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y),
            To = Vector2.new(rootPos.X, rootPos.Y),
            Visible = true
        })
        table.insert(objects, tracer)
    end

    -- Name
    if Settings.ESP_Names then
        local name = CreateDrawing("Text", {
            Color = Color3.fromRGB(255,255,255), Text = player.Name,
            Position = Vector2.new(headPos.X, headPos.Y-40),
            Size = Settings.ESP_FontSize, Center = true, Outline = true, Visible = true
        })
        table.insert(objects, name)
    end

    -- Distance
    if Settings.ESP_Distance then
        local dt = CreateDrawing("Text", {
            Color = Color3.fromRGB(200,200,200), Text = math.floor(dist).."m",
            Position = Vector2.new(headPos.X, headPos.Y+15),
            Size = 12, Center = true, Outline = true, Visible = true
        })
        table.insert(objects, dt)
    end

    -- Health Bar
    if Settings.ESP_HealthBar then
        local h = humanoid.Health / humanoid.MaxHealth
        local bw, bh = 50, 4
        local bx, by = headPos.X-bw/2, headPos.Y-30
        table.insert(objects, CreateDrawing("Square", {
            Color=Color3.fromRGB(0,0,0), Filled=true,
            Size=Vector2.new(bw,bh), Position=Vector2.new(bx,by), Visible=true
        }))
        table.insert(objects, CreateDrawing("Square", {
            Color=Color3.fromRGB(255*(1-h), 255*h, 0), Filled=true,
            Size=Vector2.new(bw*h, bh), Position=Vector2.new(bx,by), Visible=true
        }))
    end

    -- Health text
    if Settings.ESP_Health then
        table.insert(objects, CreateDrawing("Text", {
            Color=Color3.fromRGB(255,255,255), Text=math.floor(humanoid.Health).."/"..humanoid.MaxHealth,
            Position=Vector2.new(headPos.X, headPos.Y-20), Size=11, Center=true, Outline=true, Visible=true
        }))
    end

    return objects
end

-- ==================== AIMBOT LOGIC ====================
local function GetClosestTarget()
    local closest = nil
    local closestDist = Settings.Aimbot_FOV
    local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local hum = char:FindFirstChild("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        if Settings.Aimbot_TeamCheck and player.Team == LocalPlayer.Team and LocalPlayer.Team ~= nil then continue end

        local aimPart = char:FindFirstChild(Settings.Aimbot_AimPart) or char:FindFirstChild("Head")
        if not aimPart then continue end

        -- Wall Check
        if Settings.Aimbot_WallCheck then
            local ray = Ray.new(Camera.CFrame.Position, (aimPart.Position - Camera.CFrame.Position).Unit * 500)
            local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character})
            if hit and hit:IsDescendantOf(char) then
                -- nhìn thấy
            else
                if Settings.Aimbot_VisibilityCheck then continue end
            end
        end

        local screenPos, onScreen = Camera:WorldToViewportPoint(aimPart.Position)
        if not onScreen then continue end

        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
        if dist < closes
