<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanwDat - Gói License & Mua Key</title>
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

        /* --- TỔNG THỂ TRANG CỬA HÀNG --- */
        .store-page {
            width: 100%;
            max-width: 800px;
            text-align: center;
            margin-top: 20px;
        }
        .store-title { font-size: 2rem; color: #1a1a1a; margin-bottom: 10px; font-weight: bold; }
        .store-subtitle { color: #666; margin-bottom: 30px; font-size: 0.95rem; }
        
        /* Lưới hiển thị danh sách các Gói Key */
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
        
        /* --- ĐỊNH DẠNG CÁC NÚT BẤM VÀ ĐƯỜNG DẪN --- */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        /* Nút đường dẫn tải file hack */
        .download-btn {
            background: #28a745; color: white; text-decoration: none;
            width: 100%; padding: 11px; border-radius: 8px; font-size: 0.95rem;
            font-weight: 600; text-align: center; transition: 0.2s;
            border: 1px solid transparent;
        }
        .download-btn:hover { background: #218838; }

        /* Nút mua kích hoạt QR */
        .buy-btn {
            background: #007bff; color: white; border: none; width: 100%;
            padding: 11px; border-radius: 8px; font-size: 0.95rem; font-weight: 600;
            cursor: pointer; text-align: center; transition: 0.2s;
        }
        .buy-btn:hover { background: #0056b3; }

        /* --- HỆ THỐNG POPUP HIỂN THỊ MÃ QR --- */
        .popup-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.6); display: flex;
            justify-content: center; align-items: center; opacity: 0;
            pointer-events: none; transition: opacity 0.3s ease; z-index: 999;
        }
        .popup-overlay.show { opacity: 1; pointer-events: auto; }
        .popup-box { background: white; padding: 25px; border-radius: 16px; width: 85%; max-width: 360px; text-align: center; color: #333; }
        .qr-code-img { width: 230px; height: 230px; margin: 15px 0; border: 1px solid #eee; padding: 5px; }
        .close-popup-btn { background: #dc3545; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; margin-top: 10px; font-weight: 600; }
    </style>
</head>
<body>

    <!-- TRANG MUA KEY LICENSE LUÔN, KHÔNG CẦN QUA ĐĂNG NHẬP -->
    <div class="store-page">
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
                    <!-- Thay link dán vào href bên dưới để dẫn tới file cài hack của bạn -->
                    <a href="LINK_TAI_HACK_1_NGAY_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack 1 Ngày</a>
                    <button class="buy-btn" onclick="openQrPopup(15000, 'Goi 1 Ngay')">💳 Mua Ngay</button>
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
                    <a href="LINK_TAI_HACK_7_NGAY_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack 7 Ngày</a>
                    <button class="buy-btn" onclick="openQrPopup(70000, 'Goi 7 Ngay')">💳 Mua Ngay</button>
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
                    <a href="LINK_TAI_HACK_30_NGAY_Ở_ĐÂY" class="download-btn" target="_blank">📥 Tải Hack 30 Ngày</a>
                    <button class="buy-btn" onclick="openQrPopup(160000, 'Goi 30 Ngay')">💳 Mua Ngay</button>
                </div>
            </div>
        </div>
    </div>

    <!-- POPUP HIỂN THỊ MÃ QR CHUYỂN KHOẢN AGRIBANK -->
    <div id="qrPopup" class="popup-overlay">
        <div class="popup-box">
            <h3 style="color: #c92a2a;">Cổng Thanh Toán Napas 24/7</h3>
            <p id="qrInfoText" style="font-size: 1.1rem; margin-top: 10px; font-weight: bold; color: #007bff;"></p>
            
            <!-- Chạy API Sinh mã QR tự động dựa theo tài khoản Agribank trên ảnh -->
            <img id="qrImage" class="qr-code-img" src="" alt="Mã QR Agribank">
            
            <p style="font-size: 0.8rem; color: #555; line-height: 1.4; padding: 0 10px;">
                Chủ TK: <b>LO THI NON</b><br>
                Ngân hàng: <b>Agribank</b><br>
                ⚠️ Hãy quét đúng mã QR và giữ nguyên nội dung chuyển khoản để nhận Key tự động!
            </p>
            <button class="close-popup-btn" onclick="closeQrPopup()">Đóng lại</button>
        </div>
    </div>

    <script>
        // CẤU HÌNH THEO ĐÚNG THÔNG TIN ẢNH MÃ QR BẠN CUNG CẤP
        const BANK_ID = "Agribank"; 
        const ACCOUNT_NO = "7905205067987"; 
        const ACCOUNT_NAME = "LO THI NON"; 

        function openQrPopup(amount, packageName) {
            // Tự động sinh nội dung chuyển khoản ngẫu nhiên gọn gàng (Ví dụ: "NgoTranGoi1Ngay842")
            const randomId = Math.floor(100 + Math.random() * 900);
            const description = `NgoTran ${packageName.replace(/\s+/g, '')} ID${randomId}`;

            // Tạo link API tự sinh QR VietQR cho ngân hàng Agribank
            const qrUrl = `https://img.vietqr.io/image/${BANK_ID}-${ACCOUNT_NO}-qr_only.png?amount=${amount}&addInfo=${encodeURIComponent(description)}&accountName=${encodeURIComponent(ACCOUNT_NAME)}`;
            
            document.getElementById("qrImage").src = qrUrl;
            document.getElementById("qrInfoText").innerText = `Số tiền: ${amount.toLocaleString('vi-VN')} VND`;
            
            document.getElementById("qrPopup").classList.add("show");
        }

        function closeQrPopup() {
            document.getElementById("qrPopup").classList.remove("show");
        }
    </script>
</body>
</html>
