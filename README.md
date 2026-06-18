<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProWeb Full - Mạng Xã Hội Thu Nhỏ</title>
    <style>
        :root {
            --bg: #0a0a0a;
            --bg2: #111;
            --card: #1a1a1a;
            --text: #fff;
            --text2: #b0b0b0;
            --accent: #ff6a00;
            --accent2: #ee0979;
            --gradient: linear-gradient(135deg, #ff6a00, #ee0979);
            --border: 1px solid rgba(255,255,255,0.08);
            --radius: 16px;
            --shadow: 0 20px 60px rgba(0,0,0,0.5);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        /* ===== BACKGROUND PARTICLES ===== */
        #particles {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        /* ===== LOADING ===== */
        #loadingScreen {
            position: fixed;
            inset: 0;
            background: var(--bg);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s;
        }
        .loader {
            width: 50px; height: 50px;
            border: 3px solid rgba(255,255,255,0.1);
            border-top-color: var(--accent);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* ===== AUTH MODAL ===== */
        #authModal {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .auth-container {
            width: 400px;
            perspective: 1000px;
        }
        .auth-card-wrapper {
            position: relative;
            min-height: 500px;
            transition: transform 0.6s;
            transform-style: preserve-3d;
        }
        .auth-card-wrapper.flipped { transform: rotateY(180deg); }
        .auth-card-front, .auth-card-back {
            position: absolute;
            width: 100%;
            backface-visibility: hidden;
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            padding: 40px 30px;
            box-shadow: var(--shadow);
        }
        .auth-card-back { transform: rotateY(180deg); }
        .auth-card h2 {
            text-align: center;
            font-size: 28px;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }
        .auth-card p { text-align: center; color: var(--text2); font-size: 14px; margin-bottom: 25px; }
        .auth-card input {
            width: 100%;
            padding: 14px;
            background: #111;
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 10px;
            color: var(--text);
            font-size: 15px;
            margin-bottom: 15px;
            outline: none;
        }
        .auth-card input:focus { border-color: var(--accent); }
        .btn {
            width: 100%;
            padding: 14px;
            background: var(--gradient);
            border: none;
            color: #fff;
            border-radius: 10px;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover { opacity: 0.9; }
        .switch-text { text-align: center; margin-top: 15px; color: var(--text2); font-size: 14px; }
        .switch-text a { color: var(--accent); cursor: pointer; }

        /* ===== MAIN APP ===== */
        #mainApp {
            display: none;
            position: relative;
            z-index: 1;
        }

        /* ===== NAVBAR ===== */
        nav {
            position: sticky;
            top: 0;
            background: rgba(10,10,10,0.9);
            backdrop-filter: blur(20px);
            border-bottom: var(--border);
            padding: 0 30px;
            z-index: 100;
        }
        nav .nav-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 65px;
        }
        .nav-logo {
            font-size: 24px;
            font-weight: 900;
            background: var(--gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .nav-search {
            display: flex;
            gap: 10px;
            flex: 1;
            max-width: 400px;
            margin: 0 30px;
        }
        .nav-search input {
            flex: 1;
            padding: 10px 16px;
            background: #111;
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 50px;
            color: var(--text);
            outline: none;
        }
        .nav-search button {
            padding: 10px 20px;
            background: var(--gradient);
            border: none;
            color: #fff;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
        }
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .nav-actions span { cursor: pointer; font-size: 20px; }
        .avatar {
            width: 40px; height: 40px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            cursor: pointer;
        }

        /* ===== LAYOUT ===== */
        .main-layout {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 250px 1fr 300px;
            gap: 30px;
            padding: 30px;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            position: sticky;
            top: 95px;
            height: fit-content;
        }
        .sidebar-card {
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 20px;
        }
        .sidebar-card h3 {
            font-size: 16px;
            margin-bottom: 15px;
        }
        .sidebar-menu {
            list-style: none;
        }
        .sidebar-menu li {
            padding: 12px 15px;
            border-radius: 10px;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
        }
        .sidebar-menu li:hover, .sidebar-menu li.active {
            background: rgba(255,106,0,0.15);
            color: var(--accent);
        }

        /* ===== POST CREATOR ===== */
        .post-creator {
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 30px;
        }
        .post-creator textarea {
            width: 100%;
            height: 100px;
            background: #111;
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 10px;
            color: var(--text);
            padding: 15px;
            font-size: 15px;
            resize: vertical;
            outline: none;
            font-family: inherit;
        }
        .post-creator textarea:focus { border-color: var(--accent); }
        .post-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }
        .post-actions .icons { display: flex; gap: 15px; }
        .post-actions .icons span { cursor: pointer; font-size: 20px; opacity: 0.7; transition: 0.3s; }
        .post-actions .icons span:hover { opacity: 1; color: var(--accent); }
        .post-actions button {
            padding: 10px 30px;
            background: var(--gradient);
            border: none;
            color: #fff;
            border-radius: 50px;
            font-weight: 700;
            cursor: pointer;
        }

        /* ===== POSTS ===== */
        .post {
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 20px;
        }
        .post-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }
        .post-avatar {
            width: 45px; height: 45px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
        }
        .post-user { font-weight: 600; }
        .post-time { color: var(--text2); font-size: 12px; }
        .post-content { margin-bottom: 15px; line-height: 1.6; }
        .post-image {
            width: 100%;
            border-radius: 10px;
            margin-bottom: 15px;
            max-height: 400px;
            object-fit: cover;
        }
        .post-footer {
            display: flex;
            gap: 30px;
            border-top: 1px solid rgba(255,255,255,0.05);
            padding-top: 15px;
        }
        .post-footer span {
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            color: var(--text2);
        }
        .post-footer span:hover { color: var(--accent); }
        .post-footer span.liked { color: #ff1744; }

        /* ===== RIGHT SIDEBAR ===== */
        .right-sidebar {
            position: sticky;
            top: 95px;
            height: fit-content;
        }
        .right-card {
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            padding: 25px;
            margin-bottom: 20px;
        }
        .right-card h3 { margin-bottom: 15px; font-size: 16px; }
        .trend-item {
            padding: 10px 0;
            border-bottom: 1px solid rgba(255,255,255,0.05);
            cursor: pointer;
        }
        .trend-item:hover { color: var(--accent); }
        .trend-tag { font-weight: 600; }
        .trend-count { color: var(--text2); font-size: 12px; }

        /* ===== CHAT WIDGET ===== */
        #chatWidget {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 350px;
            background: var(--card);
            border: var(--border);
            border-radius: var(--radius);
            overflow: hidden;
            z-index: 500;
            display: none;
            box-shadow: var(--shadow);
        }
        #chatWidget.open { display: block; }
        .chat-header {
            background: var(--gradient);
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }
        .chat-messages {
            height: 300px;
            overflow-y: auto;
            padding: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .chat-msg {
            padding: 10px 15px;
            border-radius: 15px;
            max-width: 80%;
            font-size: 14px;
        }
        .chat-msg.me {
            background: var(--gradient);
            align-self: flex-end;
        }
        .chat-msg.other {
            background: #222;
            align-self: flex-start;
        }
        .chat-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid rgba(255,255,255,0.1);
        }
        .chat-input input {
            flex: 1;
            padding: 10px;
            background: #111;
            border: none;
            border-radius: 50px;
            color: var(--text);
            outline: none;
        }
        .chat-input button {
            padding: 10px 15px;
            background: var(--gradient);
            border: none;
            color: #fff;
            border-radius: 50px;
            margin-left: 10px;
            cursor: pointer;
        }

        /* ===== TOAST ===== */
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 10px;
            color: #fff;
            font-weight: 600;
            z-index: 9999;
            animation: slideIn 0.3s ease;
        }
        .toast.success { background: #00c853; }
        .toast.error { background: #ff1744; }
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1024px) {
            .main-layout {
                grid-template-columns: 1fr;
                padding: 20px;
            }
            .sidebar, .right-sidebar { display: none; }
            .nav-search { display: none; }
        }
    </style>
</head>
<body>

    <!-- LOADING -->
    <div id="loadingScreen"><div class="loader"></div></div>

    <!-- PARTICLES -->
    <canvas id="particles"></canvas>

    <!-- AUTH MODAL -->
    <div id="authModal">
        <div class="auth-container">
            <div class="auth-card-wrapper" id="authCardWrapper">
                <div class="auth-card-front auth-card">
                    <h2>ProWeb</h2>
                    <p>Đăng nhập tài khoản</p>
                    <input type="text" id="loginUser" placeholder="Tên đăng nhập...">
                    <input type="password" id="loginPass" placeholder="Mật khẩu...">
                    <button class="btn" onclick="login()">🚀 ĐĂNG NHẬP</button>
                    <div class="switch-text">Chưa có tài khoản? <a onclick="flipAuth()">Đăng ký</a></div>
                </div>
                <div class="auth-card-back auth-card">
                    <h2>ProWeb</h2>
                    <p>Tạo tài khoản mới</p>
                    <input type="text" id="regUser" placeholder="Tên đăng nhập...">
                    <input type="email" id="regEmail" placeholder="Email...">
                    <input type="password" id="regPass" placeholder="Mật khẩu...">
                    <input type="password" id="regPassConfirm" placeholder="Xác nhận mật khẩu...">
                    <button class="btn" onclick="register()">✨ ĐĂNG KÝ</button>
                    <div class="switch-text">Đã có tài khoản? <a onclick="flipAuth()">Đăng nhập</a></div>
                </div>
            </div>
        </div>
    </div>

    <!-- MAIN APP -->
    <div id="mainApp">
        <!-- NAVBAR -->
        <nav>
            <div class="nav-inner">
                <div class="nav-logo">ProWeb</div>
                <div class="nav-search">
                    <input type="text" placeholder="Tìm kiếm bài viết, người dùng..." id="searchInput">
                    <button onclick="searchPosts()">🔍</button>
                </div>
                <div class="nav-actions">
                    <span title="Tin nhắn" onclick="toggleChat()">💬</span>
                    <span title="Thông báo">🔔</span>
                    <div class="avatar" id="navAvatar" title="Tài khoản"></div>
                </div>
            </div>
        </nav>

        <!-- MAIN LAYOUT -->
        <div class="main-layout">
            <!-- LEFT SIDEBAR -->
            <aside class="sidebar">
                <div class="sidebar-card">
                    <ul class="sidebar-menu">
                        <li class="active">🏠 Trang Chủ</li>
                        <li>🔍 Khám Phá</li>
                        <li>📊 Thịnh Hành</li>
                        <li>💾 Đã Lưu</li>
                        <li>⚙️ Cài Đặt</li>
                    </ul>
                </div>
                <div class="sidebar-card">
                    <h3>🔥 Chủ Đề Hot</h3>
                    <div class="trend-item"><span class="trend-tag">#CôngNghệ</span><br><span class="trend-count">2.5K bài viết</span></div>
                    <div class="trend-item"><span class="trend-tag">#ThiếtKế</span><br><span class="trend-count">1.8K bài viết</span></div>
                    <div class="trend-item"><span class="trend-tag">#LậpTrình</span><br><span class="trend-count">3.2K bài viết</span></div>
                </div>
            </aside>

            <!-- MAIN CONTENT -->
            <main>
                <!-- POST CREATOR -->
                <div class="post-creator">
                    <textarea id="postContent" placeholder="Bạn đang nghĩ gì?..."></textarea>
                    <div class="post-actions">
                        <div class="icons">
                            <span title="Thêm ảnh" onclick="document.getElementById('imageUpload').click()">🖼️</span>
                            <input type="file" id="imageUpload" accept="image/*" style="display:none" onchange="previewImage(event)">
                            <span title="Thêm video">🎬</span>
                            <span title="Gắn thẻ">🏷️</span>
                            <span title="Cảm xúc">😊</span>
                        </div>
                        <button onclick="createPost()">ĐĂNG</button>
                    </div>
                    <img id="imagePreview" style="display:none; max-width:100%; border-radius:10px; margin-top:15px;">
                </div>

                <!-- POSTS CONTAINER -->
                <div id="postsContainer"></div>
            </main>

            <!-- RIGHT SIDEBAR -->
            <aside class="right-sidebar">
                <div class="right-card">
                    <h3>👥 Người Dùng Nổi Bật</h3>
                    <div id="topUsers"></div>
                </div>
                <div class="right-card">
                    <h3>📈 Xu Hướng</h3>
                    <div class="trend-item"><span class="trend-tag">#AI</span><br><span class="trend-count">5.1K bài viết</span></div>
                    <div class="trend-item"><span class="trend-tag">#WebDev</span><br><span class="trend-count">4.3K bài viết</span></div>
                    <div class="trend-item"><span class="trend-tag">#MobileApp</span><br><span class="trend-count">3.7K bài viết</span></div>
                </div>
            </aside>
        </div>
    </div>

    <!-- CHAT WIDGET -->
    <div id="chatWidget">
        <div class="chat-header" onclick="toggleChat()">
            <span>💬 Tin Nhắn</span>
            <span>✕</span>
        </div>
        <div class="chat-messages" id="chatMessages"></div>
        <div class="chat-input">
            <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="if(event.key==='Enter')sendMessage()">
            <button onclick="sendMessage()">Gửi</button>
        </div>
    </div>

    <script>
        // ===== GLOBAL STATE =====
        let currentUser = null;
        let posts = JSON.parse(localStorage.getItem('proweb_posts') || '[]');
        let chatMessages = JSON.parse(localStorage.getItem('proweb_chat') || '[]');

        // ===== PARTICLES =====
        const canvas = document.getElementById('particles');
        const ctx = canvas.getContext('2d');
        const particlesArr = [];
        function resizeCanvas() {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
