<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanDat Dev - Premium Get Key System</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #0b0c10;
            --card-bg: rgba(22, 27, 34, 0.75);
            --border-color: rgba(255, 255, 255, 0.1);
            --primary: #6c5ce7;
            --primary-glow: rgba(108, 92, 231, 0.4);
            --accent: #00f2fe;
            --success: #00b894;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            background: var(--bg-color);
            background-image: 
                radial-gradient(circle at 15% 15%, rgba(108, 92, 231, 0.15) 0%, transparent 40%),
                radial-gradient(circle at 85% 85%, rgba(0, 242, 254, 0.15) 0%, transparent 40%);
            color: var(--text-main);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px 30px;
            text-align: center;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5),
                        0 0 30px rgba(108, 92, 231, 0.1);
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, #6c5ce7, #00f2fe, #6c5ce7);
            background-size: 200% 100%;
            animation: moveGradient 4s linear infinite;
        }

        @keyframes moveGradient {
            0% { background-position: 0% 0%; }
            100% { background-position: 200% 0%; }
        }

        .avatar {
            width: 70px;
            height: 70px;
            margin: 0 auto 15px;
            border-radius: 50%;
            background: linear-gradient(135deg, #6c5ce7, #00f2fe);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            box-shadow: 0 0 20px var(--primary-glow);
        }

        h2 {
            font-size: 24px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff 30%, #a29bfe);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }

        p.subtitle {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 28px;
        }

        .btn-group {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn {
            width: 100%;
            padding: 14px 20px;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            font-weight: 700;
            font-size: 15px;
            background: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .btn:hover {
            background: linear-gradient(135deg, rgba(108, 92, 231, 0.2), rgba(0, 242, 254, 0.2));
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(108, 92, 231, 0.25);
        }

        .btn:active { transform: translateY(0); }

        .btn-badge {
            background: rgba(255, 255, 255, 0.1);
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            color: var(--accent);
        }

        #result {
            margin-top: 25px;
            padding: 20px;
            background: rgba(10, 10, 20, 0.6);
            border-radius: 16px;
            border: 1px solid var(--border-color);
            display: none;
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .status {
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
        }

        .key-box {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(0, 0, 0, 0.4);
            border: 1px dashed var(--primary);
            padding: 12px 15px;
            border-radius: 10px;
            margin: 10px 0;
        }

        .key-text {
            font-family: monospace;
            font-size: 16px;
            color: #00ff88;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .copy-btn {
            background: var(--primary);
            border: none;
            color: #fff;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: 0.2s;
        }

        .copy-btn:hover { background: #5a4bcf; }

        /* Style Đồng hồ đếm ngược */
        .countdown-title {
            font-size: 12px;
            color: var(--text-muted);
            margin-top: 12px;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .timer-box {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 5px;
        }

        .time-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 6px 10px;
            min-width: 55px;
        }

        .time-num {
            font-size: 18px;
            font-weight: 800;
            color: var(--accent);
            font-family: monospace;
        }

        .time-label {
            font-size: 10px;
            color: var(--text-muted);
        }
    </style>

    <!-- Firebase SDK -->
    <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-database-compat.js"></script>
</head>
<body>

    <div class="container">
        <div class="avatar">⚡</div>
        <h2>VanDat Dev</h2>
        <p class="subtitle">Hệ thống Get Key tự động & Nhanh chóng</p>
        
        <div class="btn-group">
            <button class="btn" onclick="redirectToGetKey(6)">
                <span>🚀 Key 6 Giờ</span>
                <span class="btn-badge">Nhanh</span>
            </button>
            <button class="btn" onclick="redirectToGetKey(12)">
                <span>⚡ Key 12 Giờ</span>
                <span class="btn-badge">Phổ biến</span>
            </button>
            <button class="btn" onclick="redirectToGetKey(24)">
                <span>👑 Key 24 Giờ</span>
                <span class="btn-badge">VIP</span>
            </button>
        </div>

        <div id="result">
            <span id="statusText" class="status">Đang xử lý...</span>
            <div id="keyDisplay"></div>
        </div>
    </div>

    <script>
        // Cấu hình Firebase
        const firebaseConfig = {
            apiKey: "AIzaSyD-6QDqoZsnldoPrstQIkWLJ1G69JYBChw",
            authDomain: "vd12-c514c.firebaseapp.com",
            databaseURL: "https://vd12-c514c-default-rtdb.asia-southeast1.firebasedatabase.app",
            projectId: "vd12-c514c",
            storageBucket: "vd12-c514c.firebasestorage.app",
            messagingSenderId: "72320018344",
            appId: "1:72320018344:web:c6117ca351357afe135f9d",
            measurementId: "G-9QYCTZXRCM"
        };

        firebase.initializeApp(firebaseConfig);
        const database = firebase.database();

        let timerInterval = null;

        // 3 Link Get Key
        const GET_KEY_URLS = {
            6: "https://link4m.org/H7gGhdD",
            12: "https://link4m.net/jLTZR",
            24: "https://link4m.org/V4FnEAD"
        };

        function redirectToGetKey(hours) {
            const redirectUrl = GET_KEY_URLS[hours] || window.location.href;
            window.location.href = redirectUrl;
        }

        async function createAndSaveKey(hours) {
            const resultDiv = document.getElementById('result');
            const statusText = document.getElementById('statusText');
            const keyDisplay = document.getElementById('keyDisplay');

            resultDiv.style.display = 'block';
            statusText.innerText = "Đang khởi tạo Key...";
            statusText.style.color = "#a29bfe";

            const rand1 = Math.random().toString(36).substring(2, 6).toUpperCase();
            const rand2 = Math.random().toString(36).substring(2, 6).toUpperCase();
            const generatedKey = `VANDAT-${rand1}-${rand2}`;

            const now = Math.floor(Date.now() / 1000);
            const expiresAt = now + (hours * 3600);

            try {
                await database.ref('keys/' + generatedKey).set({
                    created_at: now,
                    expires_at: expiresAt,
                    hours: hours
                });

                statusText.innerText = "🎉 Khởi tạo Key thành công!";
                statusText.style.color = "#00b894";
                
                keyDisplay.innerHTML = `
                    <div class="key-box">
                        <span class="key-text" id="myKey">${generatedKey}</span>
                        <button class="copy-btn" onclick="copyKey()">Sao chép</button>
                    </div>
                    
                    <div class="countdown-title">Thời gian còn lại</div>
                    <div class="timer-box">
                        <div class="time-card">
                            <div class="time-num" id="hours">00</div>
                            <div class="time-label">Giờ</div>
                        </div>
                        <div class="time-card">
                            <div class="time-num" id="minutes">00</div>
                            <div class="time-label">Phút</div>
                        </div>
                        <div class="time-card">
                            <div class="time-num" id="seconds">00</div>
                            <div class="time-label">Giây</div>
                        </div>
                    </div>
                `;

                // Bắt đầu chạy bộ đếm ngược
                startCountdown(expiresAt);

            } catch (error) {
                console.error(error);
                statusText.innerText = "❌ Lỗi khi lưu Key lên Database!";
                statusText.style.color = "#ff7675";
            }
        }

        // Hàm xử lý bộ đếm ngược Giờ:Phút:Giây
        function startCountdown(expiresAt) {
            if (timerInterval) clearInterval(timerInterval);

            function updateTimer() {
                const now = Math.floor(Date.now() / 1000);
                const diff = expiresAt - now;

                if (diff <= 0) {
                    clearInterval(timerInterval);
                    document.getElementById('hours').innerText = "00";
                    document.getElementById('minutes').innerText = "00";
                    document.getElementById('seconds').innerText = "00";
                    document.getElementById('statusText').innerText = "⚠️ Key đã hết hạn!";
                    document.getElementById('statusText').style.color = "#ff7675";
                    return;
                }

                const h = Math.floor(diff / 3600);
                const m = Math.floor((diff % 3600) / 60);
                const s = diff % 60;

                document.getElementById('hours').innerText = h < 10 ? '0' + h : h;
                document.getElementById('minutes').innerText = m < 10 ? '0' + m : m;
                document.getElementById('seconds').innerText = s < 10 ? '0' + s : s;
            }

            updateTimer();
            timerInterval = setInterval(updateTimer, 1000);
        }

        function copyKey() {
            const keyText = document.getElementById('myKey').innerText;
            navigator.clipboard.writeText(keyText);
            const btn = document.querySelector('.copy-btn');
            btn.innerText = "Đã chép!";
            btn.style.background = "#00b894";
            setTimeout(() => {
                btn.innerText = "Sao chép";
                btn.style.background = "#6c5ce7";
            }, 2000);
        }

        window.addEventListener('DOMContentLoaded', () => {
            const urlParams = new URLSearchParams(window.location.search);
            const isCompleted = urlParams.get('completed');
            const hours = parseInt(urlParams.get('hours'));

            if (isCompleted === 'true' && (hours === 6 || hours === 12 || hours === 24)) {
                createAndSaveKey(hours);
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        });
    </script>
</body>
</html>
