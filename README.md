<!DOCTYPE html>
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
            margin-top: 10px;
        }
        .store-title { font-size: 2rem; color: #1a1a1a; margin-bottom: 10px; font-weight: bold; }
        .store-subtitle { color: #666; margin-bottom: 25px; font-size: 0.95rem; }
        
        /* --- THANH DANH MỤC (TABS) --- */
        .category-tabs {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-bottom: 25px;
            background: #e9ecef;
            padding: 6px;
            border-radius: 12px;
        }
        .tab-btn {
            flex: 1;
            padding: 12px;
            font-size: 0.95rem;
            font-weight: bold;
            border: none;
            background: transparent;
            color: #495057;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.2s;
        }
        .tab-btn.active {
            background: white;
            color: #007bff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .price-grid {
            display: none;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            padding: 10px;
        }
        .price-grid.active {
            display: grid;
        }

        .center-grid {
            justify-content: center;
        }

        .card {
            background: white; border-radius: 16px; padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: left;
            position: relative; border: 1px solid #eaeaea;
            display: flex; flex-direction: column;
        }
        
        /* Nhãn hiển thị số lượng tồn kho */
        .card-tag { 
            position: absolute; 
            top: 15px; 
            right: 15px; 
            background: #ffeaa7; 
            font-size: 0.75rem; 
            padding: 4px 8px; 
            border-radius: 4px; 
            color: #d63031; 
            font-weight: bold; 
        }
        .card-tag.blue { background: #e3f2fd; color: #0d47a1; }
        
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

        /* --- TRANG TẠO MÃ QR THANH TOÁN --- */
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

    <!-- GIAO DIỆN CHÍNH BẢNG GIÁ -->
    <div id="mainStore" class="store-page">
        <h1 class="store-title">NgoTran Mods System</h1>
        <p class="store-subtitle">Hệ thống tự động 24/7. Vui lòng chọn danh mục bạn muốn mua bên dưới.</p>

        <!-- THANH CHỌN DANH MỤC -->
        <div class="category-tabs">
            <button class="tab-btn active" onclick="switchCategory('mod-key', this)">📦 Gói Ngo Tran Mods</button>
            <button class="tab-btn" onclick="switchCategory('gps-file', this)">📍 Gói File Định Vị Free Fire</button>
        </div>

        <!-- DANH MỤC 1: MUA KEY NGO TRAN MODS -->
        <div id="cat-mod-key" class="price-grid active">
            <!-- Gói 1 ngày -->
            <div class="card">
                <span class="card-tag blue">Còn lại: 5</span>
                <div class="card-duration">1 Ngày</div>
                <div class="card-price">15.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Hỗ Trợ Đăng Nhập Cực Nhanh</li>
                    <li>Update Miễn Phí Suốt Gói</li>
                    <li>Chống khóa tài khoản cực mạnh</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(15000, '1 Ngày', 'Key Ngo Tran Mods')">💳 Mua Ngay</button>
                </div>
            </div>
            <!-- Gói 7 ngày -->
            <div class="card">
                <span class="card-tag blue">Còn lại: 3</span>
                <div class="card-duration">7 Ngày</div>
                <div class="card-price">70.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Hỗ Trợ Đăng Nhập Cực Nhanh</li>
                    <li>Update Miễn Phí Suốt Gói</li>
                    <li>Reset ID Thiết Bị 1 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(70000, '7 Ngày', 'Key Ngo Tran Mods')">💳 Mua Ngay</button>
                </div>
            </div>
            <!-- Gói 30 ngày -->
            <div class="card">
                <span class="card-tag blue">Còn lại: 6</span>
                <div class="card-duration">30 Ngày</div>
                <div class="card-price">160.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Hỗ Trợ Ẩn Root / Không Root</li>
                    <li>Update Miễn Phí Suốt Gói</li>
                    <li>Reset ID Thiết Bị 3 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="goToInvoice(160000, '30 Ngày', 'Key Ngo Tran Mods')">💳 Mua Ngay</button>
                </div>
            </div>
        </div>

        <!-- DANH MỤC 2: MUA FILE ĐỊNH VỊ (SÚNG & NHÂN VẬT) - ĐÃ XÓA NÚT TẢI FILE -->
        <div id="cat-gps-file" class="price-grid center-grid">
            <!-- Gói Định Vị Súng -->
            <div class="card">
                <span class="card-tag">Còn lại: 99999</span>
                <div class="card-duration">Định Vị Súng VIP</div>
                <div class="card-price">30.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Hiện vị trí súng thính, súng hiếm</li>
                    <li>Hiển thị rõ ràng qua tường/vật cản</li>
                    <li>Hỗ trợ quét vị trí realtime 100%</li>
                    <li>File OB cực nhẹ, an toàn tuyệt đối</li>
                </ul>
                <div class="action-buttons">
                    <button class="buy-btn" onclick="goToInvoice(30000, 'Vĩnh Viễn', 'Dinh Vi Sung')">💳 Mua Ngay</button>
                </div>
            </div>
            <!-- Gói Định Vị Full Nhân Vật -->
            <div class="card">
                <span class="card-tag">Còn lại: 999</span>
                <div class="card-duration">Định Vị Full Nhân Vật</div>
                <div class="card-price">20.000 <span>VND</span></div>
                <ul class="card-features">
                    <li>Hiện người màu hồng (Hologram Pink)</li>
                    <li>Thấy địch từ xa xuyên vật cản</li>
                    <li>Hỗ trợ tâm ngắm chuẩn xác hơn</li>
                    <li>Cài đặt dễ dàng bằng tệp OBB/Data</li>
                </ul>
                <div class="action-buttons">
                    <button class="buy-btn" onclick="goToInvoice(20000, 'Vĩnh Viễn', 'Dinh Vi Full Nhan Vat')">💳 Mua Ngay</button>
                </div>
            </div>
        </div>
    </div>

    <!-- GIAO DIỆN CỔNG THANH TOÁN QR -->
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
            ⚠️ Chú ý: Giữ nguyên nội dung chuyển khoản được ghi ở trên để Admin kiểm tra và kích hoạt đơn hàng tự động nhanh nhất!
        </p>
        
        <button class="back-btn" onclick="backToStore()">⬅️ Quay lại trang bảng giá</button>
    </div>

    <script>
        const BANK_ID = "Agribank";
        const ACCOUNT_NO = "7905205067987";
        const ACCOUNT_NAME = "LO THI NON";

        let currentAmount = 0;
        let currentDuration = "";
        let currentItemName = "";
        let updateInterval = null;
        let countdownInterval = null;
        let timeLeft = 30;

        function switchCategory(catId, element) {
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.price-grid').forEach(grid => grid.classList.remove('active'));
            
            element.classList.add('active');
            document.getElementById('cat-' + catId).classList.add('active');
        }

        function goToInvoice(amount, duration, itemName) {
            currentAmount = amount;
            currentDuration = duration;
            currentItemName = itemName;

            document.getElementById("mainStore").style.display = "none";
            document.getElementById("invoicePage").style.display = "block";
            
            generateNewQR();
            
            clearInterval(updateInterval);
            updateInterval = setInterval(generateNewQR, 30000);
            
            clearInterval(countdownInterval);
            timeLeft = 30;
            document.getElementById("refreshTimer").innerText = `Mã số tự động làm mới sau: ${timeLeft}s`;
            countdownInterval = setInterval(() => {
                timeLeft--;
                if (timeLeft <= 0) timeLeft = 30;
                document.getElementById("refreshTimer").innerText = `Mã số tự động làm mới sau: ${timeLeft}s`;
            }, 1000);
        }

        function generateNewQR() {
            const randomCode = Math.floor(1000000 + Math.random() * 9000000);
            const content = `Mua ${currentItemName} ${currentDuration} ${randomCode}`;
            
            const qrUrl = `https://img.vietqr.io/image/${BANK_ID}-${ACCOUNT_NO}-qr_only.png?amount=${currentAmount}&addInfo=${encodeURIComponent(content)}&accountName=${encodeURIComponent(ACCOUNT_NAME)}`;
            
            document.getElementById("invoiceQr").src = qrUrl;
            document.getElementById("invoiceAmount").innerText = `${currentAmount.toLocaleString('vi-VN')} VND`;
            document.getElementById("invoiceContent").innerText = content;
        }

        function backToStore() {
            clearInterval(updateInterval);
            clearInterval(countdownInterval);
            document.getElementById("invoicePage").style.display = "none";
            document.getElementById("mainStore").style.display = "block";
        }
    </script>
</body>
</html>
