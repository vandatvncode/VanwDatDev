<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NgoTran License System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f9;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 20px;
        }

        /* --- TRANG CHỦ BẢNG GIÁ --- */
        .store-page {
            width: 100%;
            max-width: 800px;
            text-align: center;
            margin-top: 20px;
        }
        .store-title { font-size: 2rem; color: #1a1a1a; margin-bottom: 10px; font-weight: bold; }
        .store-subtitle { color: #666; margin-bottom: 30px; font-size: 0.95rem; }
        
        .price-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            padding: 10px;
        }
        .card {
            background: white; border-radius: 16px; padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: left;
            position: relative; border: 1px solid #eaeaea;
            display: flex; flex-direction: column;
        }
        .card-tag { position: absolute; top: 15px; right: 15px; background: #f0f2f5; font-size: 0.75rem; padding: 4px 8px; border-radius: 4px; color: #666; }
        .card-duration { font-size: 1.2rem; font-weight: bold; margin-bottom: 10px; color: #1a1a1a; }
        .card-price { font-size: 1.6rem; font-weight: 800; color: #007bff; margin-bottom: 15px; }
        .card-price span { font-size: 0.9rem; font-weight: normal; color: #666; }
        .card-features { list-style: none; margin-bottom: 20px; font-size: 0.9rem; color: #555; flex-grow: 1; }
        .card-features li { margin-bottom: 8px; }
        .card-features li::before { content: "✓ "; color: #28a745; font-weight: bold; }
        
        .action-buttons { display: flex; flex-direction: column; gap: 10px; }
        
        .download-btn {
            background: #28a745; color: white; text-decoration: none;
            width: 100%; padding: 11px; border-radius: 8px; font-size: 0.95rem;
            font-weight: 600; text-align: center; transition: 0.2s;
        }
        .download-btn:hover { background: #218838; }

        .buy-btn {
            background: #007bff; color: white; border: none; width: 100%;
            padding: 11px; border-radius: 8px; font-size: 0.95rem; font-weight: 600;
            cursor: pointer; text-align: center; transition: 0.2s;
        }
        .buy-btn:hover { background: #0056b3; }

        /* --- TRANG TẠO MÃ QR THANH TOÁN TOÀN MÀN HÌNH --- */
        .invoice-page {
            display: none;
            width: 100%;
            max-width: 500px;
            background: white;
            border-radius: 20px;
            padding: 30px 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
            margin-top: 10px;
        }
        .invoice-header { font-size: 1.4rem; font-weight: bold; color: #c92a2a; margin-bottom: 5px; }
        .qr-wrapper {
            background: #f8f9fa; border: 1px solid #eee; padding: 15px;
            border-radius: 12px; margin: 20px auto; width: fit-content;
        }
        .qr-code-img { width: 240px; height: 240px; display: block; }
        
        .info-box {
            text-align: left; background: #f8f9fa; padding: 15px;
            border-radius: 10px; margin-bottom: 20px; font-size: 0.95rem; border-left: 4px solid #007bff;
        }
        .info-row { display: flex; justify-content: space-between; margin-bottom: 8px; border-bottom: 1px dashed #eee; padding-bottom: 4px; }
        .info-row span:last-child { font-weight: bold; color: #1a1a1a; }
        .content-highlight { color: #d63031 !important; font-size: 1rem; background: #ffeaa7; padding: 2px 6px; border-radius: 4px; }
        
        .timer-text { font-size: 0.85rem; color: #666; margin-bottom: 15px; font-style: italic; }
        .back-btn {
            background: #6c757d; color: white; border: none; padding: 11px;
            border-radius: 8px; width: 100%; font-size: 0.95rem; font-weight: 600; cursor: pointer;
        }
    </style>
</head>
<body>

    <!-- GIAO DIỆN CHÍNH: BẢNG GIÁ MUA KEY -->
    <div id="mainStore" class="store-page">
        <h1 class="store-title">NgoTran Mods Khiến Bạn Rỉ Nước</h1>
        <p class="store-subtitle">Hệ thống tự động 24/7. Chọn gói phù hợp nhất với nhu cầu sử dụng của bạn.</p>

        <div class="price-grid">
            <!-- Gói 1 ngày -->
            <div class="card">
                <span class="card-tag">1 Thiết bị</span>
                <div class="card-duration">1 Ngày</div>
                <div class="card-price">15.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Hỗ Trợ Đăng Nhập</li>
                    <li>Update Miễn Phí</li>
                    <li>AntiBan cực mạnh</li>
                </ul>
                <div class="action-buttons">
                    <a href="LINK_TAI_HACK_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(15000, 1)">💳 Mua Ngay</button>
                </div>
            </div>

            <!-- Gói 7 ngày -->
            <div class="card">
                <span class="card-tag">1 Thiết bị</span>
                <div class="card-duration">7 Ngày</div>
                <div class="card-price">70.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Hỗ Trợ Đăng Nhập</li>
                    <li>Update Miễn Phí</li>
                    <li>Reset Key 1 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="LINK_TAI_HACK_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(70000, 7)">💳 Mua Ngay</button>
                </div>
            </div>

            <!-- Gói 30 ngày -->
            <div class="card">
                <span class="card-tag">1 Thiết bị</span>
                <div class="card-duration">30 Ngày</div>
                <div class="card-price">160.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Hỗ Trợ Ấn Root</li>
                    <li>Update Miễn Phí</li>
                    <li>Reset Key 3 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="LINK_TAI_HACK_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(160000, 30)">💳 Mua Ngay</button>
                </div>
            </div>
        </div>
    </div>

    <!-- GIAO DIỆN CHUYỂN SANG TRANG TẠO QR KHI NHẤN MUA -->
    <div id="invoicePage" class="invoice-page">
        <div class="invoice-header">CỔNG THANH TOÁN QUÉT MÃ VIETQR</div>
        <p style="color: #666; font-size: 0.85rem;">Vui lòng mở App ngân hàng bất kỳ để quét mã thanh toán 24/7</p>
        
        <div class="qr-wrapper">
            <img id="invoiceQr" class="qr-code-img" src="" alt="Mã QR Agribank">
        </div>

        <p id="refreshTimer" class="timer-text">Mã số tự động làm mới sau: 30s</p>

        <div class="info-box">
            <div class="info-row"><span>Ngân hàng:</span><span>Agribank</span></div>
            <div class="info-row"><span>Chủ tài khoản:</span><span>LO THI NON</span></div>
            <div class="info-row"><span>Số tài khoản:</span><span>7905205067987</span></div>
            <div class="info-row"><span>Số tiền:</span><span id="invoiceAmount" style="color:#007bff;">0 VND</span></div>
            <div class="info-row"><span>Nội dung bắt buộc:</span><span id="invoiceContent" class="content-highlight"></span></div>
        </div>

        <p style="font-size: 0.8rem; color: #e43f5a; margin-bottom: 20px; font-weight: bold; text-align: left; line-height: 1.4;">
            ⚠️ Chú ý: Giữ nguyên nội dung chuyển khoản được ghi ở trên để Admin kiểm tra và kích hoạt key tự động nhanh nhất!
        </p>
        
        <button class="back-btn" onclick="backToStore()">⬅️ Quay lại trang bảng giá</button>
    </div>

    <script>
        // Thông tin cố định lấy từ ảnh ngân hàng Agribank của bạn
        const BANK_ID = "Agribank";
        const ACCOUNT_NO = "7905205067987";
        const ACCOUNT_NAME = "LO THI NON";

        let currentAmount = 0;
        let currentDays = 0;
        let updateInterval = null;
        let countdownInterval = null;
        let timeLeft = 30;

        // Hàm chuyển sang giao diện hóa đơn QR
        function goToInvoice(amount, days) {
            currentAmount = amount;
            currentDays = days;

            // Ẩn trang bảng giá, hiện trang hóa đơn QR
            document.getElementById("mainStore").style.display = "none";
            document.getElementById("invoicePage").style.display = "block";

            // Tạo mã lần đầu tiên
            generateNewQR();

            // Thiết lập vòng lặp cứ mỗi 30 giây đổi mã số một lần
            clearInterval(updateInterval);
            updateInterval = setInterval(generateNewQR, 30000);

            // Thiết lập đồng hồ đếm ngược hiển thị giây trên màn hình
            clearInterval(countdownInterval);
            timeLeft = 30;
            document.getElementById("refreshTimer").innerText = `Mã số tự động làm mới sau: ${timeLeft}s`;
            countdownInterval = setInterval(() => {
                timeLeft--;
                if (timeLeft <= 0) timeLeft = 30;
                document.getElementById("refreshTimer").innerText = `Mã số tự động làm mới sau: ${timeLeft}s`;
            }, 1000);
        }

        // Hàm sinh mã QR kèm nội dung mới ngẫu nhiên đuôi
        function generateNewQR() {
            // Tạo mã số ngẫu nhiên có 7 chữ số (ví dụ: 8086786)
            const randomCode = Math.floor(1000000 + Math.random() * 9000000);
            
            // Cấu trúc nội dung chuẩn: Mua Key [X] day [Mã số]
            const content = `Mua Key ${currentDays} day ${randomCode}`;

            // Tạo link API đúng theo chuẩn của VietQR
            const qrUrl = `https://img.vietqr.io/image/${BANK_ID}-${ACCOUNT_NO}-qr_only.png?amount=${currentAmount}&addInfo=${encodeURIComponent(content)}&accountName=${encodeURIComponent(ACCOUNT_NAME)}`;
            
            // Cập nhật giao diện hình ảnh và văn bản hiển thị
            document.getElementById("invoiceQr").src = qrUrl;
            document.getElementById("invoiceAmount").innerText = `${currentAmount.toLocaleString('vi-VN')} VND`;
            document.getElementById("invoiceContent").innerText = content;
        }

        // Hàm quay trở lại danh sách bảng giá ban đầu
        function backToStore() {
            clearInterval(updateInterval);
            clearInterval(countdownInterval);
            document.getElementById("invoicePage").style.display = "none";
            document.getElementById("mainStore").style.display = "block";
        }
    </script>
</body>
</html>
