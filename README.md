<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanwDat - Gói License & Mua Key</title>
    
    <!-- TẢI THƯ VIỆN ĐĂNG NHẬP CỦA GOOGLE -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>

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

        /* --- 1. GIAO DIỆN KHUNG BIO VÀ ĐĂNG NHẬP --- */
        .bio-page {
            width: 100%;
            max-width: 400px;
            background: linear-gradient(135deg, #0f2027, #203a43);
            color: white;
            padding: 30px 20px;
            border-radius: 24px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        }
        .avatar { width: 100px; height: 100px; border-radius: 50%; border: 3px solid #00f2fe; margin-bottom: 15px; }
        .bio-btn {
            background-color: white; color: #0f2027; text-decoration: none;
            padding: 14px 20px; border-radius: 50px; font-size: 1rem; font-weight: 600;
            display: block; margin-top: 15px; transition: 0.2s;
        }
        .bio-btn:hover { background-color: #00f2fe; color: white; }
        .login-section { border-top: 1px solid rgba(255,255,255,0.15); padding-top: 25px; margin-top: 25px; }
        #googleBtn { display: flex; justify-content: center; margin-top: 10px; }
        #adminUploadSection { display: none; margin-top: 20px; padding: 15px; border: 2px dashed #ff4757; border-radius: 12px; }

        /* --- 2. GIAO DIỆN TRANG MUA KEY (MẶC ĐỊNH ẨN) --- */
        .store-page {
            display: none; /* Hiện lên sau khi đăng nhập thành công */
            width: 100%;
            max-width: 800px;
            text-align: center;
        }
        .store-title { font-size: 2rem; color: #1a1a1a; margin-bottom: 10px; font-weight: bold; }
        .store-subtitle { color: #666; margin-bottom: 30px; }
        
        /* Lưới hiển thị các gói Key */
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
        }
        .card-tag { position: absolute; top: 15px; right: 15px; background: #f0f2f5; font-size: 0.75rem; padding: 4px 8px; border-radius: 4px; color: #666; }
        .card-duration { font-size: 1.2rem; font-weight: bold; margin-bottom: 10px; color: #1a1a1a; }
        .card-price { font-size: 1.6rem; font-weight: 800; color: #007bff; margin-bottom: 15px; }
        .card-price span { font-size: 0.9rem; font-weight: normal; color: #666; }
        .card-features { list-style: none; margin-bottom: 25px; font-size: 0.9rem; color: #555; }
        .card-features li { margin-bottom: 8px; }
        .card-features li::before { content: "✓ "; color: #28a745; font-weight: bold; }
        .buy-btn {
            background: #007bff; color: white; border: none; width: 100%;
            padding: 12px; border-radius: 8px; font-size: 1rem; font-weight: 600;
            cursor: pointer; text-align: center; transition: 0.2s;
        }
        .buy-btn:hover { background: #0056b3; }

        /* --- 3. HỆ THỐNG POPUP (CHUNG) --- */
        .popup-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.6); display: flex;
            justify-content: center; align-items: center; opacity: 0;
            pointer-events: none; transition: opacity 0.3s ease; z-index: 999;
        }
        .popup-overlay.show { opacity: 1; pointer-events: auto; }
        .popup-box { background: white; padding: 25px; border-radius: 16px; width: 85%; max-width: 360px; text-align: center; color: #333; }
        
        /* Phong cách riêng cho Popup Đăng nhập cấp quyền (Nền tối) */
        #keyLoginPopup .popup-box { background: #1a1a1a; color: white; border: 1px solid #333; }
        #keyLoginPopup h3 { color: #00f2fe; margin-bottom: 15px; }
        .input-group { margin-bottom: 15px; text-align: left; }
        .input-group label { display: block; font-size: 0.85rem; color: #aaa; margin-bottom: 5px; }
        .input-group input { width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #444; background: #2a2a2a; color: white; }
        .submit-btn { background: #00f2fe; color: #0f2027; border: none; padding: 10px; font-weight: bold; border-radius: 8px; width: 100%; cursor: pointer; }

        /* Phong cách Popup QR CODE */
        .qr-code-img { width: 220px; height: 220px; margin: 15px 0; border: 1px solid #eee; padding: 5px; }
        .close-popup-btn { background: #dc3545; color: white; border: none; padding: 8px 16px; border-radius: 6px; cursor: pointer; margin-top: 10px; }
    </style>
</head>
<body>

    <!-- ==================== TRANG 1: GIAO DIỆN BIO HOÀN CHỈNH ==================== -->
    <div id="bioPage" class="bio-page">
        <img class="avatar" src="https://picsum.photos/200" alt="Avatar">
        <div style="font-size: 1.5rem; font-weight: bold; margin-bottom: 8px;">@VanwDat</div>
        <p style="color: #b0bec5; font-size: 0.95rem;">Welcome to my website 🌐</p>

        <div class="links-wrapper">
            <a href="#" class="bio-btn" target="_blank">Kết nối Facebook</a>
            <a href="#" class="bio-btn" target="_blank">Theo dõi TikTok</a>
        </div>

        <div id="adminUploadSection">
            <p style="color: #ff4757; font-weight: bold; font-size: 0.85rem; margin-bottom: 5px;">🛠️ MENU ADMIN</p>
            <input type="file" accept="image/*">
        </div>

        <div class="login-section">
            <p style="font-size: 0.9rem; color: #90a4ae; text-transform: uppercase;">Xác thực truy cập cửa hàng</p>
            <div id="googleBtn"></div>
        </div>
    </div>


    <!-- ==================== TRANG 2: TRANG MUA KEY LICENSE (GIỐNG ẢNH MẪU) ==================== -->
    <div id="storePage" class="store-page">
        <h1 class="store-title">VanwDat Mods Khiến Bạn Rỉ Nước</h1>
        <p class="store-subtitle">Hệ thống cấp khóa tự động 24/7. Chọn gói phù hợp nhất với nhu cầu sử dụng.</p>

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
                <button class="buy-btn" onclick="openQrPopup(15000, 'Goi 1 Ngay')">🛒 Mua Ngay</button>
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
                <button class="buy-btn" onclick="openQrPopup(70000, 'Goi 7 Ngay')">🛒 Mua Ngay</button>
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
                <button class="buy-btn" onclick="openQrPopup(160000, 'Goi 30 Ngay')">🛒 Mua Ngay</button>
            </div>
        </div>
    </div>


    <!-- ==================== POPUP 1: ĐIỀN TÊN VÀ MẬT KHẨU MUA KEY ==================== -->
    <div id="keyLoginPopup" class="popup-overlay">
        <div class="popup-box">
            <h3>Xác Nhận Vào Cửa Hàng</h3>
            <p style="font-size: 0.85rem; color: #ccc; margin-bottom: 15px;">Điền mật khẩu cấp quyền mua key</p>
            <div class="input-group">
                <label>Tên người mua / Nickname</label>
                <input type="text" id="keyUsername" placeholder="Nhập tên...">
            </div>
            <div class="input-group">
                <label>Mật khẩu</label>
                <input type="password" id="keyPassword" placeholder="Nhập mật khẩu (Mẫu: 123456)...">
            </div>
            <button class="submit-btn" onclick="verifyKeyLogin()">Vào Xem Bảng Giá</button>
        </div>
    </div>


    <!-- ==================== POPUP 2: HIỂN THỊ MÃ QR CHUYỂN KHOẢN TỰ ĐỘNG ==================== -->
    <div id="qrPopup" class="popup-overlay">
        <div class="popup-box">
            <h3 style="color: #28a745;">Thanh Toán Hoá Đơn</h3>
            <p id="qrInfoText" style="font-size: 0.9rem; margin-top: 5px; font-weight: 600;"></p>
            
            <!-- Ảnh QR tự động tạo từ API VietQR -->
            <img id="qrImage" class="qr-code-img" src="" alt="Mã QR Thanh Toán">
            
            <p style="font-size: 0.8rem; color: #666; margin-bottom: 10px;">⚠️ Vui lòng quét mã đúng số tiền và <b>giữ nguyên nội dung chuyển khoản</b> để hệ thống duyệt tự động.</p>
            <button class="close-popup-btn" onclick="closeQrPopup()">Đóng lại</button>
        </div>
    </div>


    <!-- ==================== ĐOẠN XỬ LÝ SỰ KIỆN JAVASCRIPT ==================== -->
    <script>
        // CẤU HÌNH THÔNG TIN NGÂN HÀNG CỦA BẠN Ở ĐÂY ĐỂ ĐỔI QR
        const BANK_ID = "MB"; // Tên viết tắt ngân hàng (Ví dụ: MB, Vietcombank, Techcombank, ACB...)
        const ACCOUNT_NO = "0999999999"; // Số tài khoản ngân hàng thật của bạn
        const ACCOUNT_NAME = "NGUYEN VAN DAT"; // Tên chủ tài khoản ghi hoa không dấu

        window.onload = function () {
            google.accounts.id.initialize({
                client_id: "696207475546-6epgds0be08avj2ua9uldasrt2ibs1sd.apps.googleusercontent.com",
                callback: handleGoogleResponse
            });
            google.accounts.id.renderButton(
                document.getElementById("googleBtn"),
                { theme: "filled_blue", size: "large", text: "signin_with", shape: "rectangular", width: 280 }
            );
        }

        // 1. Sau khi Đăng nhập Google thành công
        function handleGoogleResponse(response) {
            const responsePayload = parseJwt(response.credential);
            const userEmail = responsePayload.email.toLowerCase();

            if (userEmail === "quangvandat7812@gmail.com") {
                document.getElementById("adminUploadSection").style.display = "block";
            }
            // Hiện popup đòi tài khoản mật khẩu
            document.getElementById("keyLoginPopup").classList.add("show");
        }

        // 2. Xác thực thông tin mật khẩu để mở trang mua key
        function verifyKeyLogin() {
            const user = document.getElementById("keyUsername").value;
            const pass = document.getElementById("keyPassword").value;

            if (user.trim() === "" || pass.trim() === "") {
                alert("Vui lòng nhập đầy đủ thông tin!");
                return;
            }

            if (pass === "123456") { // Mật khẩu mẫu
                // Ẩn trang Bio ban đầu và ẩn luôn popup đăng nhập
                document.getElementById("bioPage").style.display = "none";
                document.getElementById("keyLoginPopup").classList.remove("show");
                
                // Hiện trang mua bán Key ra giống ảnh mẫu của bạn
                document.getElementById("storePage").style.display = "block";
            } else {
                alert("Mật khẩu truy cập không chính xác!");
            }
        }

        // 3. Hàm gọi khi người dùng bấm nút "Mua Ngay" -> Tạo mã QR ngân hàng tự động
        function openQrPopup(amount, packageName) {
            const username = document.getElementById("keyUsername").value || "KhaCH";
            // Nội dung chuyển khoản tự động không dấu (Ví dụ: "VanwDat Mua Goi 1 Ngay Nick Nam")
            const description = `VanwDat Mua ${packageName} ${username}`.replace(/[^a-zA-Z0-9 ]/g, ""); 

            // Sử dụng API mở miễn phí của VietQR để tự tạo link ảnh QR
            const qrUrl = `https://img.vietqr.io/image/${BANK_ID}-${ACCOUNT_NO}-qr_only.png?amount=${amount}&addInfo=${encodeURIComponent(description)}&accountName=${encodeURIComponent(ACCOUNT_NAME)}`;
            
            // Đưa link ảnh vào thẻ img và hiển thị text thông báo
            document.getElementById("qrImage").src = qrUrl;
            document.getElementById("qrInfoText").innerText = `Số tiền: ${amount.toLocaleString('vi-VN')} VND`;
            
            // Mở popup QR lên
            document.getElementById("qrPopup").classList.add("show");
        }

        function closeQrPopup() {
            document.getElementById("qrPopup").classList.remove("show");
        }

        function parseJwt (token) {
            var base64Url = token.split('.')[1];
            var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
            var jsonPayload = decodeURIComponent(window.atob(base64).split('').map(function(c) {
                return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
            }).join(''));
            return JSON.parse(jsonPayload);
        }
    </script>
</body>
</html>
