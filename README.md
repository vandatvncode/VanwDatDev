<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanwDat - Bio & API Login</title>
    
    <!-- TẢI THƯ VIỆN ĐĂNG NHẬP CỦA GOOGLE -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #0f2027 0%, #203a43 50%, #2c5364 100%);
            color: white;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 20px;
        }
        .bio-container {
            text-align: center;
            width: 100%;
            max-width: 400px;
            background: rgba(255, 255, 255, 0.08);
            padding: 30px 20px;
            border-radius: 24px;
            backdrop-filter: blur(12px);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid #00f2fe;
            object-fit: cover;
            margin-bottom: 15px;
            box-shadow: 0 0 15px rgba(0, 242, 254, 0.5);
        }
        .name {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .bio-text {
            font-size: 0.95rem;
            color: #b0bec5;
            margin-bottom: 30px;
        }
        .links-wrapper {
            display: flex;
            flex-direction: column;
            gap: 16px;
            margin-bottom: 30px;
        }
        .bio-btn {
            background-color: white;
            color: #0f2027;
            text-decoration: none;
            padding: 14px 20px;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.2s ease-in-out;
            display: block;
        }
        .bio-btn:hover {
            background-color: #00f2fe;
            color: white;
        }
        .login-section {
            border-top: 1px solid rgba(255, 255, 255, 0.15);
            padding-top: 25px;
            display: flex;
            flex-direction: column;
            gap: 15px;
            align-items: center;
        }
        .login-title {
            font-size: 0.9rem;
            color: #90a4ae;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        #googleBtn {
            min-height: 40px;
            width: 100%;
            max-width: 280px;
            display: flex;
            justify-content: center;
        }

        /* --- POPUP ĐĂNG NHẬP THÔNG TIN MUA KEY --- */
        .popup-overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex; justify-content: center; align-items: center;
            opacity: 0; pointer-events: none;
            transition: opacity 0.3s ease;
            z-index: 999;
        }
        .popup-overlay.show { opacity: 1; pointer-events: auto; }
        .popup-box {
            background: #1a1a1a; padding: 25px; border-radius: 16px;
            width: 85%; max-width: 350px; text-align: center;
            border: 1px solid #333;
        }
        .popup-box h3 { margin-bottom: 15px; color: #00f2fe; }
        .input-group { margin-bottom: 15px; text-align: left; }
        .input-group label { display: block; font-size: 0.85rem; color: #aaa; margin-bottom: 5px; }
        .input-group input {
            width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #444;
            background: #2a2a2a; color: white; font-size: 0.95rem;
        }
        .submit-btn {
            background: #00f2fe; color: #0f2027; border: none; padding: 10px 20px;
            font-weight: bold; border-radius: 8px; cursor: pointer; width: 100%; margin-top: 10px;
        }

        /* --- VÙNG UP ẢNH (MẶC ĐỊNH ẨN) --- */
        #adminUploadSection {
            display: none; /* Mặc định ẩn, chỉ email của bạn mới hiện */
            margin-top: 20px;
            padding: 15px;
            background: rgba(228, 63, 90, 0.15);
            border: 2px dashed #e43f5a;
            border-radius: 12px;
            text-align: center;
        }
        #adminUploadSection p { font-size: 0.85rem; margin-bottom: 10px; color: #ff4757; font-weight: bold;}
    </style>
</head>
<body>

    <div class="bio-container">
        <img class="avatar" src="https://picsum.photos/200" alt="Avatar">
        <div class="name">@VanwDat</div>
        <div class="bio-text">Welcome to my bio webpage 🌐</div>

        <div class="links-wrapper">
            <a href="#" class="bio-btn" target="_blank">Kết nối Facebook</a>
            <a href="#" class="bio-btn" target="_blank">Theo dõi TikTok</a>
        </div>

        <!-- VÙNG UP ẢNH DÀNH RIÊNG CHO QUANGVANDAT7812@GMAIL.COM -->
        <div id="adminUploadSection">
            <p>🛠️ MENU ADMIN (Chỉ bạn nhìn thấy)</p>
            <input type="file" id="imageUpload" accept="image/*">
        </div>

        <div class="login-section">
            <div class="login-title">Xác thực tài khoản</div>
            <div id="googleBtn"></div>
        </div>
    </div>

    <!-- POPUP ĐIỀN TÊN VÀ MẬT KHẨU MUA KEY -->
    <div id="keyLoginPopup" class="popup-overlay">
        <div class="popup-box">
            <h3>Xác Nhận Vào Trang Mua Key</h3>
            <p style="font-size: 0.85rem; color: #ccc; margin-bottom: 15px;">Vui lòng điền tài khoản cấp quyền để tiếp tục</p>
            
            <div class="input-group">
                <label>Tên đăng nhập / Nickname</label>
                <input type="text" id="keyUsername" placeholder="Nhập tên của bạn...">
            </div>
            <div class="input-group">
                <label>Mật khẩu mật</label>
                <input type="password" id="keyPassword" placeholder="Nhập mật khẩu...">
            </div>
            
            <button class="submit-btn" onclick="verifyKeyLogin()">Vào trang mua key</button>
        </div>
    </div>

    <script>
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

        // XỬ LÝ KHI ĐĂNG NHẬP GOOGLE XONG
        function handleGoogleResponse(response) {
            const responsePayload = parseJwt(response.credential);
            const userEmail = responsePayload.email.toLowerCase(); // Chuyển về chữ thường để so sánh chính xác

            // 1. Kiểm tra nếu đúng email của bạn thì mở tính năng up ảnh
            if (userEmail === "quangvandat7812@gmail.com") {
                document.getElementById("adminUploadSection").style.display = "block";
                alert("Xin chào Admin VanwDat! Hệ thống đã mở chức năng Up ảnh.");
            }

            // 2. Tự động bật popup điền tên và mật khẩu mua key lên
            document.getElementById("keyLoginPopup").classList.add("show");
        }

        // HÀM KIỂM TRA THÔNG TIN KHI ẤN NÚT TRÊN POPUP MUA KEY
        function verifyKeyLogin() {
            const user = document.getElementById("keyUsername").value;
            const pass = document.getElementById("keyPassword").value;

            if (user.trim() === "" || pass.trim() === "") {
                alert("Vui lòng nhập đầy đủ Tên và Mật khẩu!");
                return;
            }

            // Ví dụ đặt mật khẩu cố định, sau này bạn có thể đổi theo ý mình
            if (pass === "123456") { 
                alert("Xác thực thành công! Đang chuyển hướng đến trang mua key...");
                // Bạn có thể đổi đường link dưới đây sang link trang mua key thật của bạn
                window.location.href = "https://facebook.com"; 
            } else {
                alert("Mật khẩu truy cập trang mua key chưa chính xác!");
            }
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
