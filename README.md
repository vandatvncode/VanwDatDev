<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VanDat Dev - Get Key System</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #0f0f1a; color: #fff; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .container { background: #1a1a2e; padding: 30px; border-radius: 12px; border: 1px solid #7952b3; text-align: center; width: 340px; box-shadow: 0 4px 20px rgba(0,0,0,0.6); }
        h2 { margin-bottom: 10px; color: #a29bfe; }
        p { color: #aaa; font-size: 14px; margin-bottom: 20px; }
        .btn { width: 100%; padding: 12px; margin: 8px 0; border: none; border-radius: 8px; font-weight: bold; background: #6c5ce7; color: white; cursor: pointer; transition: 0.2s; font-size: 15px; }
        .btn:hover { background: #5a4bcf; }
        .btn:disabled { background: #444; cursor: not-allowed; }
        #result { margin-top: 20px; padding: 15px; background: #252542; border-radius: 8px; border: 1px solid #444; word-break: break-all; display: none; }
        .key-text { font-family: monospace; font-size: 18px; color: #00ff88; margin: 10px 0; font-weight: bold; display: block; }
        .status { font-size: 12px; color: #fd79a8; margin-top: 5px; }
    </style>

    <!-- Thư viện Firebase JS SDK -->
    <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.22.1/firebase-database-compat.js"></script>
</head>
<body>

    <div class="container">
        <h2>VanDat Dev Get Key</h2>
        <p>Chọn thời hạn để khởi tạo Key:</p>
        
        <button class="btn" onclick="generateKey(6)">Key 6 Giờ</button>
        <button class="btn" onclick="generateKey(12)">Key 12 Giờ</button>
        <button class="btn" onclick="generateKey(24)">Key 24 Giờ</button>

        <div id="result">
            <span id="statusText" class="status">Đang khởi tạo...</span>
            <div id="keyDisplay"></div>
        </div>
    </div>

    <script>
        // Cấu hình Firebase của bạn
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

        // Khởi tạo Firebase
        firebase.initializeApp(firebaseConfig);
        const database = firebase.database();

        // Hàm tạo và lưu Key
        async function generateKey(hours) {
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(b => b.disabled = true);

            const resultDiv = document.getElementById('result');
            const statusText = document.getElementById('statusText');
            const keyDisplay = document.getElementById('keyDisplay');

            resultDiv.style.display = 'block';
            statusText.innerText = "Đang lưu Key vào Firebase...";
            keyDisplay.innerHTML = "";

            // Tạo mã ngẫu nhiên: VANDAT-XXXX-XXXX
            const rand1 = Math.random().toString(36).substring(2, 6).toUpperCase();
            const rand2 = Math.random().toString(36).substring(2, 6).toUpperCase();
            const generatedKey = `VANDAT-${rand1}-${rand2}`;

            // Thời gian hiện tại và thời gian hết hạn (Unix Timestamp tính bằng giây)
            const now = Math.floor(Date.now() / 1000);
            const expiresAt = now + (hours * 3600);

            try {
                // Lưu thông tin Key vào nhánh /keys/GENERATED_KEY
                await database.ref('keys/' + generatedKey).set({
                    created_at: now,
                    expires_at: expiresAt,
                    hours: hours
                });

                statusText.innerText = "Tạo Key thành công!";
                statusText.style.color = "#00b894";
                keyDisplay.innerHTML = `
                    <span class="key-text">${generatedKey}</span>
                    <small>Thời hạn: ${hours} Giờ</small>
                `;
            } catch (error) {
                console.error(error);
                statusText.innerText = "Lỗi khi lưu Key! (Kiểm tra lại Rules Firebase)";
                statusText.style.color = "#ff7675";
            } finally {
                buttons.forEach(b => b.disabled = false);
            }
        }
    </script>
</body>
</html>

