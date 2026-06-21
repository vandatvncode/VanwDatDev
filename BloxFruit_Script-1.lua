-- ==================== PALOFSC ====================
-- MENU NHỎ - FIX FULL LỖI KHÔNG HIỂN THỊ NÚT
-- Tự động thử nhiều Parent, có nút TEST, bắt lỗi toàn bộ

-- BƯỚC 1: KHỞI TẠO DỊCH VỤ VÀ CHỜ LOAD
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Chờ Player và PlayerGui
repeat task.wait() until LocalPlayer and LocalPlayer.PlayerGui
task.wait(0.5)

-- BƯỚC 2: TẠO SCREENGUI VỚI NHIỀU PARENT DỰ PHÒNG
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeScamGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Thử từng Parent
local parentList = {
    LocalPlayer.PlayerGui,
    game:GetService("CoreGui"),
    game:GetService("StarterGui"),
    game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
}
local guiParented = false
for _, parent in ipairs(parentList) do
    if parent then
        local success, err = pcall(function()
            ScreenGui.Parent = parent
        end)
        if success and ScreenGui.Parent then
            guiParented = true
            break
        end
    end
end

if not guiParented then
    warn("[LỖI] Không thể gán GUI vào bất kỳ parent nào!")
    return
end

-- BƯỚC 3: MAINFRAME - MÀU NỔI BẬT ĐỂ DỄ THẤY
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.02, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = true
MainFrame.ZIndex = 999
MainFrame.Parent = ScreenGui

-- BƯỚC 4: LED VIỀN CHẠY (ĐỂ BIẾT FRAME CÒN SỐNG)
local led = Instance.new("Frame")
led.Size = UDim2.new(1, 0, 0, 2)
led.Position = UDim2.new(0, 0, 1, 0)
led.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
led.BorderSizePixel = 0
led.ZIndex = 1000
led.Parent = MainFrame

task.spawn(function()
    while led and led.Parent do
        for _, c in ipairs({Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255), Color3.fromRGB(255,255,0)}) do
            if not led or not led.Parent then break end
            pcall(function()
                TweenService:Create(led, TweenInfo.new(0.4), {BackgroundColor3 = c}):Play()
            end)
            task.wait(0.4)
        end
    end
end)

-- BƯỚC 5: TIÊU ĐỀ
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "🔥 TRADE XỊN"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextScaled = true
Title.Font = Enum.Font.Bold
Title.ZIndex = 1000
Title.Parent = MainFrame

-- BƯỚC 6: NÚT TEST - LUÔN HIỆN ĐỂ KIỂM TRA
local TestBtn = Instance.new("TextButton")
TestBtn.Size = UDim2.new(0, 100, 0, 25)
TestBtn.Position = UDim2.new(0.5, -50, 0, 5)
TestBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
TestBtn.Text = "🔴 TEST"
TestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TestBtn.TextScaled = true
TestBtn.Font = Enum.Font.Bold
TestBtn.ZIndex = 1001
TestBtn.Visible = true
TestBtn.Parent = MainFrame

TestBtn.MouseButton1Click:Connect(function()
    TestBtn.Text = "✅ OK"
    TestBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    task.wait(0.5)
    TestBtn.Text = "🔴 TEST"
    TestBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    print("[TEST] Nút hoạt động!")
end)

-- BƯỚC 7: Ô NHẬP TÊN
local TargetBox = Instance.new("TextBox")
TargetBox.Size = UDim2.new(0, 280, 0, 30)
TargetBox.Position = UDim2.new(0.5, -140, 0, 45)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
TargetBox.BackgroundTransparency = 0.2
TargetBox.Text = "Tên nạn nhân"
TargetBox.TextColor3 = Color3.fromRGB(200, 200, 255)
TargetBox.TextScaled = true
TargetBox.Font = Enum.Font.SourceSans
TargetBox.ZIndex = 1000
TargetBox.ClipsDescendants = true
TargetBox.Parent = MainFrame

-- BƯỚC 8: DROPDOWN THẺ
local CardPool = {
    "⚽ MESSI 99",
    "⚽ RONALDO 98",
    "⭐ MBAPPE 97",
    "⭐ NEYMAR 96",
    "🔥 HAALAND 95",
    "🧱 THẺ RÁC"
}

local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(0, 280, 0, 30)
DropBtn.Position = UDim2.new(0.5, -140, 0, 83)
DropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
DropBtn.Text = "📋 CHỌN THẺ"
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropBtn.TextScaled = true
DropBtn.Font = Enum.Font.SourceSansBold
DropBtn.ZIndex = 1000
DropBtn.Parent = MainFrame

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(0, 280, 0, 100)
DropList.Position = UDim2.new(0.5, -140, 0, 117)
DropList.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
DropList.BorderSizePixel = 1
DropList.BorderColor3 = Color3.fromRGB(0, 255, 200)
DropList.Visible = false
DropList.ZIndex = 1001
DropList.CanvasSize = UDim2.new(0, 0, 0, #CardPool * 30)
DropList.Parent = MainFrame

local SelectedCard = nil
for _, cardName in ipairs(CardPool) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    btn.Text = cardName
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.SourceSans
    btn.ZIndex = 1002
    btn.Parent = DropList
    btn.MouseButton1Click:Connect(function()
        SelectedCard = cardName
        DropBtn.Text = "✅ " .. cardName
        DropList.Visible = false
    end)
end

DropBtn.MouseButton1Click:Connect(function()
    DropList.Visible = not DropList.Visible
end)

-- BƯỚC 9: NÚT GỬI CHÍNH
local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0, 200, 0, 40)
SendBtn.Position = UDim2.new(0.5, -100, 0, 235)
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
SendBtn.Text = "🚀 GỬI (10S)"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.TextScaled = true
SendBtn.Font = Enum.Font.Bold
SendBtn.ZIndex = 1000
SendBtn.Visible = true
SendBtn.Parent = MainFrame

-- BƯỚC 10: ĐẾM NGƯỢC + STATUS
local CountdownLabel = Instance.new("TextLabel")
CountdownLabel.Size = UDim2.new(0, 120, 0, 25)
CountdownLabel.Position = UDim2.new(0.5, -60, 0, 200)
CountdownLabel.BackgroundTransparency = 1
CountdownLabel.Text = "✅ SẴN"
CountdownLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
CountdownLabel.TextScaled = true
CountdownLabel.Font = Enum.Font.Bold
CountdownLabel.ZIndex = 1000
CountdownLabel.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 290, 0, 30)
StatusLabel.Position = UDim2.new(0.5, -145, 0, 285)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Sẵn sàng"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.ZIndex = 1000
StatusLabel.Parent = MainFrame

-- BƯỚC 11: NÚT SPAM NHANH
local QuickBtn = Instance.new("TextButton")
QuickBtn.Size = UDim2.new(0, 130, 0, 30)
QuickBtn.Position = UDim2.new(0.5, -135, 0, 325)
QuickBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
QuickBtn.Text = "📨 SPAM 10"
QuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
QuickBtn.TextScaled = true
QuickBtn.Font = Enum.Font.SourceSans
QuickBtn.ZIndex = 1000
QuickBtn.Visible = true
QuickBtn.Parent = MainFrame

-- BƯỚC 12: NÚT AUTO ACCEPT
local ToggleAutoBtn = Instance.new("TextButton")
ToggleAutoBtn.Size = UDim2.new(0, 130, 0, 30)
ToggleAutoBtn.Position = UDim2.new(0.5, 5, 0, 325)
ToggleAutoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
ToggleAutoBtn.Text = "🔄 AUTO"
ToggleAutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoBtn.TextScaled = true
ToggleAutoBtn.Font = Enum.Font.SourceSans
ToggleAutoBtn.ZIndex = 1000
ToggleAutoBtn.Visible = true
ToggleAutoBtn.Parent = MainFrame

-- BƯỚC 13: NÚT ĐÓNG GUI
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 25)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.Bold
CloseBtn.ZIndex = 1001
CloseBtn.Visible = true
CloseBtn.Parent = MainFrame

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[GUI] Đã đóng.")
end)

-- BƯỚC 14: BIẾN AUTO ACCEPT
local isFreezing = false
local autoAcceptConnection = nil
local autoManual = false

local function StartAutoAccept()
    if autoAcceptConnection then return end
    autoAcceptConnection = RunService.Heartbeat:Connect(function()
        if not isFreezing and not autoManual then return end
        pcall(function()
            for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
                if gui:IsA("ScreenGui") then
                    for _, child in ipairs(gui:GetDescendants()) do
                        if child:IsA("TextButton") and child.Visible then
                            local text = child.Text or ""
                            local lower = text:lower()
                            if lower:find("accept") or lower:find("chấp nhận") or lower:find("đồng ý") or lower:find("ok") then
                                pcall(function()
                                    child:FireServer()
                                    child:FireClick()
                                    child.MouseButton1Click:Fire()
                                end)
                                StatusLabel.Text = "✅ ACCEPT!"
                            end
                        end
                        if child:IsA("RemoteEvent") then
                            local name = child.Name:lower()
                            if name:find("accept") or name:find("trade") then
                                pcall(function()
                                    child:FireServer()
                                end)
                            end
                        end
                    end
                end
            end
        end)
    end)
end

local function StopAutoAccept()
    if autoAcceptConnection then
        autoAcceptConnection:Disconnect()
        autoAcceptConnection = nil
    end
end

-- BƯỚC 15: HÀM GỬI TRADE
local function SendTradeWithFreeze(targetName, cardName)
    if not targetName or targetName == "" or targetName == "Tên nạn nhân" then
        StatusLabel.Text = "⚠️ Nhập tên!"
        return
    end
    if not cardName then
        StatusLabel.Text = "⚠️ Chọn thẻ!"
        return
    end

    isFreezing = true
    StartAutoAccept()
    
    MainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    SendBtn.Text = "⛔ FREEZE"
    SendBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    SendBtn.Active = false
    StatusLabel.Text = "⛔ Đóng băng + Auto Accept"

    for i = 10, 1, -1 do
        CountdownLabel.Text = "⏳ " .. i .. "s"
        CountdownLabel.TextColor3 = Color3.fromRGB(255, 255 - (i * 20), 0)
        task.wait(1)
    end
    CountdownLabel.Text = "✅ HẾT"

    if ChatService and ChatService.SayMessageRequest then
        for i = 1, 10 do
            local msg = "/w " .. targetName .. " TRADE: " .. cardName .. " (" .. i .. "/10)"
            pcall(function()
                ChatService.SayMessageRequest:FireServer(msg, "All")
            end)
            task.wait(0.3)
        end
    end

    isFreezing = false
    if not autoManual then StopAutoAccept() end

    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    SendBtn.Text = "🚀 GỬI (10S)"
    SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    SendBtn.Active = true
    StatusLabel.Text = "✅ Đã gửi 10 tin cho " .. targetName
    CountdownLabel.Text = "✅ SẴN"
end

SendBtn.MouseButton1Click:Connect(function()
    SendTradeWithFreeze(TargetBox.Text, SelectedCard)
end)

-- BƯỚC 16: SỰ KIỆN NÚT SPAM
QuickBtn.MouseButton1Click:Connect(function()
    local target = TargetBox.Text
    if not target or target == "" then
        StatusLabel.Text = "⚠️ Nhập tên!"
        return
    end
    local card = SelectedCard or "⚽ MESSI 99"
    StatusLabel.Text = "📨 Đang spam..."
    for i = 1, 10 do
        if ChatService and ChatService.SayMessageRequest then
            pcall(function()
                ChatService.SayMessageRequest:FireServer("/w " .. target .. " TRADE: " .. card .. " (" .. i .. ")", "All")
            end)
        end
        task.wait(0.3)
    end
    StatusLabel.Text = "✅ Spam 10 tin xong"
end)

-- BƯỚC 17: SỰ KIỆN NÚT AUTO
ToggleAutoBtn.MouseButton1Click:Connect(function()
    autoManual = not autoManual
    if autoManual then
        StartAutoAccept()
        ToggleAutoBtn.Text = "✅ AUTO"
        ToggleAutoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        StatusLabel.Text = "✅ Auto Accept BẬT"
    else
        StopAutoAccept()
        ToggleAutoBtn.Text = "🔄 AUTO"
        ToggleAutoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
        StatusLabel.Text = "⏹️ Auto Accept TẮT"
    end
end)

-- BƯỚC 18: IN LOG VÀ HIỂN THỊ THÔNG BÁO
print("[PALOFSC] MENU NHỎ - FIX FULL - Đã sẵn sàng!")
print("[PALOFSC] Bấm nút TEST để kiểm tra. Nếu không thấy, kiểm tra Console F9.")

-- Tạo popup thông báo đã load
task.spawn(function()
    local notify = Instance.new("TextLabel")
    notify.Size = UDim2.new(0, 300, 0, 40)
    notify.Position = UDim2.new(0.5, -150, 0.1, 0)
    notify.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    notify.Text = "✅ GUI ĐÃ LOAD - Bấm TEST"
    notify.TextColor3 = Color3.fromRGB(255, 255, 255)
    notify.TextScaled = true
    notify.Font = Enum.Font.Bold
    notify.ZIndex = 2000
    notify.Parent = ScreenGui
    task.wait(2)
    notify:Destroy()
end)
