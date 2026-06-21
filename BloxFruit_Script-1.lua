-- ==================== PALOFSC ====================
-- MENU NHỎ GỌN - Kéo được + Auto Accept khi Freeze 10s
-- Thiết kế mini, không chiếm màn hình, dễ sử dụng

-- BƯỚC 1: KHỞI TẠO DỊCH VỤ
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- BƯỚC 2: TẠO SCREENGUI NHỎ
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeScamGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer.PlayerGui

-- BƯỚC 3: MAINFRAME NHỎ (300x380)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 200)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- BƯỚC 4: LED NHỎ PHÍA DƯỚI
local led = Instance.new("Frame")
led.Size = UDim2.new(1, 0, 0, 2)
led.Position = UDim2.new(0, 0, 1, 0)
led.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
led.BorderSizePixel = 0
led.Parent = MainFrame
task.spawn(function()
    while led.Parent do
        for _, c in ipairs({Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0), Color3.fromRGB(0,0,255), Color3.fromRGB(255,255,0)}) do
            if not led.Parent then break end
            TweenService:Create(led, TweenInfo.new(0.4), {BackgroundColor3 = c}):Play()
            wait(0.4)
        end
    end
end)

-- BƯỚC 5: TIÊU ĐỀ NGẮN
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "🔥 TRADE XỊN"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextScaled = true
Title.Font = Enum.Font.Bold
Title.Parent = MainFrame

-- BƯỚC 6: Ô NHẬP TÊN (THU GỌN)
local TargetBox = Instance.new("TextBox")
TargetBox.Size = UDim2.new(0, 260, 0, 30)
TargetBox.Position = UDim2.new(0.5, -130, 0, 40)
TargetBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TargetBox.BackgroundTransparency = 0.3
TargetBox.Text = "Tên nạn nhân"
TargetBox.TextColor3 = Color3.fromRGB(200, 200, 255)
TargetBox.TextScaled = true
TargetBox.Font = Enum.Font.SourceSans
TargetBox.Parent = MainFrame

-- BƯỚC 7: DROPDOWN THẺ (THU GỌN)
local CardPool = {
    "⚽ MESSI 99",
    "⚽ RONALDO 98",
    "⭐ MBAPPE 97",
    "⭐ NEYMAR 96",
    "🔥 HAALAND 95",
    "🧱 THẺ RÁC"
}

local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(0, 260, 0, 30)
DropBtn.Position = UDim2.new(0.5, -130, 0, 78)
DropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
DropBtn.Text = "📋 CHỌN THẺ"
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropBtn.TextScaled = true
DropBtn.Font = Enum.Font.SourceSansBold
DropBtn.Parent = MainFrame

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(0, 260, 0, 100)
DropList.Position = UDim2.new(0.5, -130, 0, 112)
DropList.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
DropList.BorderSizePixel = 1
DropList.BorderColor3 = Color3.fromRGB(0, 255, 200)
DropList.Visible = false
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

-- BƯỚC 8: NÚT GỬI (NHỎ)
local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0, 180, 0, 40)
SendBtn.Position = UDim2.new(0.5, -90, 0, 225)
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
SendBtn.Text = "🚀 GỬI (10S)"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.TextScaled = true
SendBtn.Font = Enum.Font.Bold
SendBtn.Parent = MainFrame

-- BƯỚC 9: ĐẾM NGƯỢC + STATUS (NHỎ)
local CountdownLabel = Instance.new("TextLabel")
CountdownLabel.Size = UDim2.new(0, 120, 0, 25)
CountdownLabel.Position = UDim2.new(0.5, -60, 0, 195)
CountdownLabel.BackgroundTransparency = 1
CountdownLabel.Text = "✅ SẴN"
CountdownLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
CountdownLabel.TextScaled = true
CountdownLabel.Font = Enum.Font.Bold
CountdownLabel.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0, 280, 0, 25)
StatusLabel.Position = UDim2.new(0.5, -140, 0, 275)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Sẵn sàng"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = MainFrame

-- BƯỚC 10: NÚT SPAM NHANH (NHỎ)
local QuickBtn = Instance.new("TextButton")
QuickBtn.Size = UDim2.new(0, 120, 0, 30)
QuickBtn.Position = UDim2.new(0.5, -130, 0, 310)
QuickBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
QuickBtn.Text = "📨 SPAM 10"
QuickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
QuickBtn.TextScaled = true
QuickBtn.Font = Enum.Font.SourceSans
QuickBtn.Parent = MainFrame

-- BƯỚC 11: NÚT AUTO ACCEPT (NHỎ)
local ToggleAutoBtn = Instance.new("TextButton")
ToggleAutoBtn.Size = UDim2.new(0, 120, 0, 30)
ToggleAutoBtn.Position = UDim2.new(0.5, 10, 0, 310)
ToggleAutoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
ToggleAutoBtn.Text = "🔄 AUTO"
ToggleAutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoBtn.TextScaled = true
ToggleAutoBtn.Font = Enum.Font.SourceSans
ToggleAutoBtn.Parent = MainFrame

-- BƯỚC 12: BIẾN AUTO ACCEPT
local isFreezing = false
local autoAcceptConnection = nil
local autoManual = false

local function StartAutoAccept()
    if autoAcceptConnection then return end
    autoAcceptConnection = RunService.Heartbeat:Connect(function()
        if not isFreezing and not autoManual then return end
        for _, gui in ipairs(LocalPlayer.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") then
                for _, child in ipairs(gui:GetDescendants()) do
                    if child:IsA("TextButton") and child.Visible then
                        local text = child.Text or ""
                        if text:lower():find("accept") or text:lower():find("chấp nhận") or text:lower():find("đồng ý") then
                            child:FireServer()
                            child:FireClick()
                            child.MouseButton1Click:Fire()
                            StatusLabel.Text = "✅ ACCEPT!"
                        end
                    end
                    if child:IsA("RemoteEvent") and child.Name:lower():find("accept") then
                        child:FireServer()
                    end
                end
            end
        end
    end)
end

local function StopAutoAccept()
    if autoAcceptConnection then
        autoAcceptConnection:Disconnect()
        autoAcceptConnection = nil
    end
end

-- BƯỚC 13: HÀM GỬI TRADE
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
        wait(1)
    end
    CountdownLabel.Text = "✅ HẾT"

    if ChatService and ChatService.SayMessageRequest then
        for i = 1, 10 do
            local msg = "/w " .. targetName .. " TRADE: " .. cardName .. " (" .. i .. "/10)"
            ChatService.SayMessageRequest:FireServer(msg, "All")
            wait(0.3)
        end
    end

    isFreezing = false
    if not autoManual then StopAutoAccept() end

    MainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
    SendBtn.Text = "🚀 GỬI (10S)"
    SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    SendBtn.Active = true
    StatusLabel.Text = "✅ Đã gửi 10 tin cho " .. targetName
    CountdownLabel.Text = "✅ SẴN"
end

SendBtn.MouseButton1Click:Connect(function()
    SendTradeWithFreeze(TargetBox.Text, SelectedCard)
end)

-- BƯỚC 14: SỰ KIỆN CHO NÚT SPAM
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
            ChatService.SayMessageRequest:FireServer("/w " .. target .. " TRADE: " .. card .. " (" .. i .. ")", "All")
        end
        wait(0.3)
    end
    StatusLabel.Text = "✅ Spam 10 tin xong"
end)

-- BƯỚC 15: SỰ KIỆN CHO NÚT AUTO
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

print("[PALOFSC] Menu nhỏ - Kéo được - Auto Accept - Đã sẵn sàng!")
