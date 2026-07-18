<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanwDat - Bio & API Login</title>
    
    <!-- TẢI THƯ VIỆN ĐĂNG NHẬP CỦA GOOGLE -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>

    <style>
        /* RESET & NỀN BACKGROUND */
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

        /* KHUNG CHỨA BIO CHÍNH */
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

        /* ẢNH ĐẠI DIỆN VÀ THÔNG TIN */
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
            letter-spacing: 0.5px;
        }
        .bio-text {
            font-size: 0.95rem;
            color: #b0bec5;
            margin-bottom: 30px;
        }

        /* KHU VỰC CÁC NÚT LIÊN KẾT (BIO LINKS) */
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: all 0.2s ease-in-out;
            display: block;
        }
        .bio-btn:active, .bio-btn:hover {
            transform: translateY(-2px);
            background-color: #00f2fe;
            color: white;
            box-shadow: 0 6px 20px rgba(0, 242, 254, 0.4);
        }

        /* PHẦN ĐĂNG NHẬP API */
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
            margin-bottom: 5px;
        }
        #googleBtnWrapper {
            width: 100%;
            max-width: 280px;
        }
        .fb-login-btn {
            background-color: #1877f2;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 0.95rem;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
            max-width: 280px;
            box-shadow: 0 4px 10px rgba(24, 119, 242, 0.3);
            transition: background 0.2s;
        }
        .fb-login-btn:hover {
            background-color: #145dbf;
        }
    </style>
</head>
<body>

    <!-- KHỞI TẠO SDK FACEBOOK -->
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/vi_VN/sdk.js"></script>
    <script>
        window.fbAsyncInit = function() {
            FB.init({
                appId      : 'YOUR_FACEBOOK_APP_ID', /* Thay bằng mã Facebook App ID của bạn khi có */
                cookie     : true,
                xfbml      : true,
                version    : 'v18.0'
            });
        };

        function loginWithFacebook() {
            FB.login(function(response) {
                if (response.status === 'connected') {
                    FB.api('/me', {fields: 'name,email'}, function(userInfo) {
                        alert('Xin chào ' + userInfo.name + '! Đăng nhập Facebook thành công.');
                    });
                } else {
                    alert('Đăng nhập Facebook không thành công.');
                }
            }, {scope: 'public_profile,email'});
        }
    </script>

    <!-- GIAO DIỆN CHÍNH -->
    <div class="bio-container">
        <!-- Ảnh avatar mẫu, bạn có thể đổi link ảnh của bạn vào đây -->
        <img class="avatar" src="https://picsum.photos/200" alt="Avatar">

        <div class="name">@VanwDat</div>
        <div class="bio-text">Welcome to my bio webpage 🌐</div>

        <!-- CÁC NÚT MẠNG XÃ HỘI -->
        <div class="links-wrapper">
            <!-- Thay dấu # bằng đường link trang cá nhân của bạn -->
            <a href="#" class="bio-btn" target="_blank">Kết nối Facebook</a>
            <a href="#" class="bio-btn" target="_blank">Theo dõi TikTok</a>
            <a href="#" class="bio-btn" target="_blank">Trò chuyện Zalo</a>
        </div>

        <!-- KHU VỰC ĐĂNG NHẬP ĐƯỢC KẾT NỐI API -->
        <div class="login-section">
            <div class="login-title">Khu vực xác thực tài khoản</div>

            <!-- GOOGLE SIGN-IN BUTTON (ĐÃ CHÈN ID CỦA BẠN) -->
            <div id="googleBtnWrapper">
                <div id="g_id_onload"
                     data-client_id="696207475546-6epgds0be08avj2ua9uldasrt2ibs1sd.apps.googleusercontent.com" 
                     data-context="signin"
                     data-ux_mode="popup"
                     data-callback="handleGoogleResponse"
                     data-auto_prompt="false">
                </div>
                <div class="g_id_signin"
                     data-type="standard"
                     data-shape="rectangular"
                     data-theme="filled_blue"
                     data-text="signin_with"
                     data-size="large"
                     data-logo_alignment="left"
                     data-width="280">
                </div>
            </div>

            <!-- FACEBOOK BUTTON -->
            <button class="fb-login-btn" onclick="loginWithFacebook()">
                Tiếp tục với Facebook
            </button>
        </div>
    </div>

    <!-- XỬ LÝ KẾT QUẢ ĐĂNG NHẬP GOOGLE -->
    <script>
        function handleGoogleResponse(response) {
            // Giải mã JWT để lấy thông tin tài khoản Google
            const responsePayload = parseJwt(response.credential);
            
            alert('Xin chào ' + responsePayload.name + '!\nEmail: ' + responsePayload.email + '\nĐăng nhập Google thành công.');
            console.log(responsePayload);
        }

        // Hàm hỗ trợ đọc chuỗi mã hóa thông tin từ Google trả về
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
