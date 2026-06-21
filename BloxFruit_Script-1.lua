-- ==================== PALOFSC ====================
-- GUI Trade tự động + Freeze 10 giây khi gửi yêu cầu
-- Spam 10 tin nhắn riêng liên tiếp, mỗi lần cách nhau 0.5s

-- BƯỚC 1: KHỞI TẠO DỊCH VỤ VÀ GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeScamGUI"
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 420)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BorderSizePixel = 4
MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
MainFrame.Parent = ScreenGui

-- BƯỚC 2: TIÊU ĐỀ VÀ Ô NHẬP TÊN
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "💀 TRADE SCAM - FREEZE 10S 💀"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextScaled = true
Title.Font = Enum.Font.Bold
Title.Parent = MainFrame

local TargetBox = Instance.new("TextBox")
TargetBox.Size = UDim2.new(0, 280, 0, 40)
TargetBox.Position = UDim2.new(0.5, -140, 0, 65)
TargetBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TargetBox.Text = "Tên nạn nhân"
TargetBox.TextColor3 = Color3.fromRGB(200, 200, 255)
TargetBox.TextScaled = true
TargetBox.Font = Enum.Font.SourceSans
TargetBox.Parent = MainFrame

-- BƯỚC 3: DROPDOWN CHỌN THẺ GIẢ
local CardPool = {
    "⚽ MESSI 99 - SIÊU HIẾM",
    "⚽ RONALDO 98 - HIẾM",
    "⭐ MBAPPE 97 - RẤT TỐT",
    "⭐ NEYMAR 96 - TỐT",
    "🔥 HAALAND 95 - TRUNG BÌNH",
    "🧱 THẺ RÁC - GIÁ TRỊ 0"
}

local DropBtn = Instance.new("TextButton")
DropBtn.Size = UDim2.new(0, 280, 0, 40)
DropBtn.Position = UDim2.new(0.5, -140, 0, 115)
DropBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
DropBtn.Text = "📋 CHỌN THẺ"
DropBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DropBtn.TextScaled = true
DropBtn.Font = Enum.Font.SourceSansBold
DropBtn.Parent = MainFrame

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(0, 280, 0, 130)
DropList.Position = UDim2.new(0.5, -140, 0, 158)
DropList.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
DropList.BorderSizePixel = 1
DropList.Visible = false
DropList.Parent = MainFrame

local SelectedCard = nil
for _, cardName in ipairs(CardPool) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
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

-- BƯỚC 4: NÚT GỬI TRADE (FREEZE 10S + SPAM 10 TIN)
local SendBtn = Instance.new("TextButton")
SendBtn.Size = UDim2.new(0, 220, 0, 50)
SendBtn.Position = UDim2.new(0.5, -110, 0, 310)
SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
SendBtn.Text = "🔥 GỬI TRADE (10S FREEZE)"
SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SendBtn.TextScaled = true
SendBtn.Font = Enum.Font.Bold
SendBtn.Parent = MainFrame

-- BƯỚC 5: NHÃN ĐẾM NGƯỢC
local CountdownLabel = Instance.new("TextLabel")
CountdownLabel.Size = UDim2.new(0, 200, 0, 40)
CountdownLabel.Position = UDim2.new(0.5, -100, 0, 270)
CountdownLabel.BackgroundTransparency = 1
CountdownLabel.Text = "Sẵn sàng"
CountdownLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
CountdownLabel.TextScaled = true
CountdownLabel.Font = Enum.Font.Bold
CountdownLabel.Parent = MainFrame

-- BƯỚC 6: LOG TRẠNG THÁI
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 375)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Nhập tên + chọn thẻ"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
StatusLabel.TextScaled = true
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.Parent = MainFrame

-- BƯỚC 7: HÀM GỬI TRADE VỚI FREEZE 10 GIÂY
local function SendTradeWithFreeze(targetName, cardName)
    if not targetName or targetName == "" or targetName == "Tên nạn nhân" then
        StatusLabel.Text = "⚠️ Nhập tên!"
        return
    end
    if not cardName then
        StatusLabel.Text = "⚠️ Chọn thẻ!"
        return
    end

    -- FREEZE 10 GIÂY - KHÓA TOÀN BỘ GUI
    MainFrame.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    SendBtn.Text = "⛔ ĐANG FREEZE 10S..."
    SendBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    SendBtn.Active = false
    StatusLabel.Text = "⛔ ĐÓNG BĂNG HỆ THỐNG - KHÔNG THỂ THAO TÁC"

    -- ĐẾM NGƯỢC 10 -> 0
    for i = 10, 1, -1 do
        CountdownLabel.Text = "⏳ " .. i .. " giây"
        CountdownLabel.TextColor3 = Color3.fromRGB(255, 255 - (i * 20), 0)
        wait(1)
    end
    CountdownLabel.Text = "✅ ĐÃ HẾT FREEZE"

    -- SPAM 10 TIN NHẮN RIÊNG
    if ChatService and ChatService.SayMessageRequest then
        for i = 1, 10 do
            local msg = "/w " .. targetName .. " TRADE XỊN: " .. cardName .. " - NHANH TAY! (" .. i .. "/10)"
            ChatService.SayMessageRequest:FireServer(msg, "All")
            wait(0.5)
        end
    end

    -- HIỂN THỊ POPUP THÀNH CÔNG
    local popup = Instance.new("TextLabel")
    popup.Size = UDim2.new(0, 350, 0, 70)
    popup.Position = UDim2.new(0.5, -175, 0.5, -35)
    popup.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    popup.Text = "✅ ĐÃ SPAM 10 TIN CHO " .. targetName
    popup.TextColor3 = Color3.fromRGB(255, 255, 255)
    popup.TextScaled = true
    popup.Font = Enum.Font.Bold
    popup.Parent = ScreenGui
    wait(2)
    popup:Destroy()

    -- KẾT THÚC FREEZE - MỞ KHÓA
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    SendBtn.Text = "🔥 GỬI TRADE (10S FREEZE)"
    SendBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    SendBtn.Active = true
    StatusLabel.Text = "✅ Đã gửi 10 tin cho " .. targetName
    CountdownLabel.Text = "Sẵn sàng"
end

-- BƯỚC 8: GÁN SỰ KIỆN CHO NÚT GỬI
SendBtn.MouseButton1Click:Connect(function()
    SendTradeWithFreeze(TargetBox.Text, SelectedCard)
end)

-- BƯỚC 9: THÊM NÚT SPAM 10 TIN KHÔNG FREEZE (TÙY CHỌN)
local QuickSpamBtn = Instance.new("TextButton")
QuickSpamBtn.Size = UDim2.new(0, 150, 0, 35)
QuickSpamBtn.Position = UDim2.new(0.5, -75, 0, 260)
QuickSpamBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
QuickSpamBtn.Text = "📨 SPAM 10 TIN"
QuickSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
QuickSpamBtn.TextScaled = true
QuickSpamBtn.Font = Enum.Font.SourceSans
QuickSpamBtn.Parent = MainFrame

QuickSpamBtn.MouseButton1Click:Connect(function()
    local target = TargetBox.Text
    if not target or target == "" then
        StatusLabel.Text = "⚠️ Nhập tên!"
        return
    end
    local card = SelectedCard or "⚽ MESSI 99 - SIÊU HIẾM"
    StatusLabel.Text = "📨 Đang spam 10 tin..."
    for i = 1, 10 do
        if ChatService and ChatService.SayMessageRequest then
            ChatService.SayMessageRequest:FireServer("/w " .. target .. " TRADE: " .. card .. " - Nhanh! (" .. i .. ")", "All")
        end
        wait(0.3)
    end
    StatusLabel.Text = "✅ Đã spam 10 tin (không freeze)"
end)

print("[PALOFSC] GUI Trade 10s Freeze + Spam 10 tin đã sẵn sàng.")
