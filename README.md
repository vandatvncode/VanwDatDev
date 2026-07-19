<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NgoTran License System - Admin Approval Version</title>
    <!-- Tích hợp Firebase SDK -->
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.10.1/firebase-database.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #121212;
            color: #eee;
            min-height: 100vh;
            padding-bottom: 80px;
        }

        /* --- THANH TRÊN CÙNG (TOP HEADER) --- */
        .top-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #1e1e1e;
            padding: 15px 20px;
            border-bottom: 1px solid #2d2d2d;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .user-balance {
            font-weight: bold;
            color: #2ed573;
            background: rgba(46, 213, 115, 0.1);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.95rem;
            display: none;
        }
        .nav-right-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            font-size: 0.9rem;
        }

        /* --- KHUNG CHỨA NỘI DUNG (PAGE CONTAINER) --- */
        .page-content {
            padding: 20px;
            max-width: 800px;
            margin: 0 auto;
            display: none;
        }
        .page-content.active {
            display: block;
        }

        .section-title { font-size: 1.8rem; color: #fff; margin-bottom: 5px; text-align: center; font-weight: bold;}
        .section-subtitle { color: #aaa; margin-bottom: 20px; font-size: 0.9rem; text-align: center; }

        /* --- THANH CHỌN DANH MỤC (TABS) --- */
        .category-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            background: #1e1e1e;
            padding: 5px;
            border-radius: 10px;
        }
        .tab-btn {
            flex: 1; padding: 10px; font-size: 0.9rem; font-weight: bold;
            border: none; background: transparent; color: #aaa; border-radius: 6px; cursor: pointer;
        }
        .tab-btn.active { background: #2d2d2d; color: #007bff; }

        .price-grid {
            display: none;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        .price-grid.active { display: grid; }

        /* --- THẺ SẢN PHẨM (CARD) --- */
        .card {
            background: #1e1e1e; border-radius: 12px; padding: 20px;
            border: 1px solid #2d2d2d; position: relative; display: flex; flex-direction: column;
            overflow: hidden;
        }
        .card-img {
            width: 100%; height: 130px; object-fit: cover; border-radius: 8px; margin-bottom: 12px;
            border: 1px solid #2d2d2d; display: block;
        }
        .card-tag { position: absolute; top: 12px; right: 12px; background: #ff4757; font-size: 0.7rem; padding: 3px 6px; border-radius: 4px; color: white; font-weight: bold; }
        .card-tag.blue { background: #1e90ff; }
        .card-duration { font-size: 1.1rem; font-weight: bold; margin-bottom: 8px; color: #fff; }
        .card-price { font-size: 1.4rem; font-weight: 800; color: #007bff; margin-bottom: 12px; }
        .card-features { list-style: none; margin-bottom: 15px; font-size: 0.85rem; color: #ccc; flex-grow: 1; }
        .card-features li { margin-bottom: 6px; }
        .card-features li::before { content: "✓ "; color: #2ed573; font-weight: bold; }
        
        .action-buttons { display: flex; flex-direction: column; gap: 8px; }
        .download-btn { background: #2ed573; color: white; text-decoration: none; padding: 10px; border-radius: 6px; font-size: 0.9rem; font-weight: 600; text-align: center; }
        .buy-btn { background: #007bff; color: white; border: none; padding: 10px; border-radius: 6px; font-size: 0.9rem; font-weight: 600; cursor: pointer; }

        .admin-edit-card-btn {
            display: none; background: #ff9f43; color: #000; font-weight: bold; border: none;
            padding: 6px; margin-top: 8px; border-radius: 4px; cursor: pointer; font-size: 0.8rem;
        }

        /* --- TRANG NẠP TIỀN --- */
        .deposit-box { background: #1e1e1e; padding: 20px; border-radius: 12px; border: 1px solid #2d2d2d; margin-bottom: 20px; }
        .promo-banner { background: linear-gradient(45deg, #ff4757, #ff6b81); color: white; padding: 10px; border-radius: 6px; font-weight: bold; font-size: 0.9rem; margin-bottom: 15px; text-align: center; }
        .input-group { margin-bottom: 15px; text-align: left; }
        .input-group label { display: block; font-size: 0.85rem; color: #aaa; margin-bottom: 5px; }
        .input-group input, .input-group select { width: 100%; padding: 10px; background: #2d2d2d; border: 1px solid #3d3d3d; color: white; border-radius: 6px; outline: none; }
        
        /* --- HOÁ ĐƠN THANH TOÁN --- */
        .invoice-page { display: none; width: 100%; max-width: 450px; background: #1e1e1e; border-radius: 16px; padding: 25px 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); text-align: center; margin: 10px auto; border: 1px solid #2d2d2d; }
        .qr-wrapper { background: white; padding: 10px; border-radius: 8px; margin: 15px auto; width: fit-content; }
        .qr-code-img { width: 200px; height: 200px; display: block; }
        .info-box { text-align: left; background: #2d2d2d; padding: 12px; border-radius: 8px; margin-bottom: 15px; font-size: 0.9rem; }
        .info-row { display: flex; justify-content: space-between; margin-bottom: 6px; }
        .content-highlight { color: #ff4757; font-weight: bold; background: #fff2f2; padding: 1px 5px; border-radius: 3px; }

        /* --- DANH SÁCH ĐÃ MUA --- */
        .history-item { background: #1e1e1e; padding: 15px; border-radius: 8px; border: 1px solid #2d2d2d; margin-bottom: 10px; text-align: left; }
        .history-header { display: flex; justify-content: space-between; font-weight: bold; border-bottom: 1px solid #2d2d2d; padding-bottom: 5px; margin-bottom: 8px; }
        .key-display { background: #2d2d2d; padding: 8px; border-radius: 4px; font-family: monospace; color: #ffbc00; font-size: 1rem; margin-top: 5px; word-break: break-all; display: block;}

        /* --- QUẢN LÝ ADMIN PANEL --- */
        .admin-section { background: #222; border: 2px dashed #ff9f43; padding: 20px; border-radius: 12px; margin-top: 25px; }
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 15px; font-size: 0.85rem; margin-bottom: 20px; }
        .admin-table th, .admin-table td { border: 1px solid #3d3d3d; padding: 8px; text-align: left; }
        .admin-table th { background: #2d2d2d; color: #ff9f43; }
        .admin-inline-input { width: 100%; background: #333; color: #fff; border: 1px solid #444; padding: 4px; border-radius: 4px; }
        
        /* Danh sách hàng chờ duyệt */
        .request-card { background: #1a1a1a; border: 1px solid #3d3d3d; border-radius: 8px; padding: 15px; margin-top: 12px; font-size: 0.9rem; }
        .request-buttons { display: flex; gap: 10px; margin-top: 12px; }
        .approve-btn { background: #2ed573; color: white; border: none; padding: 8px 15px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .reject-btn { background: #ff4757; color: white; border: none; padding: 8px 15px; border-radius: 4px; font-weight: bold; cursor: pointer; }
        .admin-highlight-code { background: #2d2d2d; padding: 6px 10px; color: #ffbc00; border-radius: 4px; font-family: monospace; display: inline-block; font-size: 0.95rem; font-weight: bold; border: 1px solid #444; margin-top: 4px; }

        /* --- POPUP ĐĂNG NHẬP / ĐĂNG KÝ --- */
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); justify-content: center; align-items: center; z-index: 1000; }
        .modal-box { background: #1e1e1e; border-radius: 12px; padding: 25px; width: 90%; max-width: 380px; border: 1px solid #2d2d2d; text-align: center; }
        .auth-toggle-link { color: #007bff; cursor: pointer; text-decoration: underline; font-size: 0.85rem; margin-top: 10px; display: inline-block;}

        /* --- THANH ĐIỀU HƯỚNG DƯỚI --- */
        .bottom-nav {
            position: fixed; bottom: 0; left: 0; width: 100%; height: 65px;
            background: #161616; border-top: 1px solid #252525;
            display: flex; justify-content: space-around; align-items: center; z-index: 999;
        }
        .nav-item {
            flex: 1; display: flex; flex-direction: column; align-items: center;
            justify-content: center; color: #888; text-decoration: none; cursor: pointer; font-size: 0.75rem;
        }
        .nav-item svg { width: 22px; height: 22px; fill: currentColor; margin-bottom: 3px; }
        .nav-item.active { color: #fff; }
        
        .nav-item.center-nav { position: relative; top: -12px; }
        .nav-item.center-nav .icon-bg {
            background: #ff4757; width: 50px; height: 50px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 4px 15px rgba(255, 71, 87, 0.4); color: white;
        }
        .nav-item.center-nav span { margin-top: 15px; color: #ff4757; font-weight: bold;}
        .nav-item.center-nav.active span { color: #fff; }
    </style>
</head>
<body>

    <!-- THANH TRÊN CÙNG -->
    <div class="top-header">
        <div class="user-balance" id="balanceWrapper">Số dư: <span id="displayBalance">0</span> VND</div>
        <button id="authHeaderBtn" class="nav-right-btn" onclick="openAuthModal()">Đăng nhập / Đăng ký</button>
    </div>

    <!-- 1. TRANG CHỦ & DANH MỤC -->
    <div id="page-home" class="page-content active">
        <h1 class="store-title section-title">NgoTran Mods Shop</h1>
        <p class="store-subtitle section-subtitle">Hệ thống phân phối tự động key và file hack uy tín 24/7</p>

        <div class="category-tabs">
            <button class="tab-btn active" onclick="switchCategory('mod-key', this)">📦 Gói Ngo Tran Mods</button>
            <button class="tab-btn" onclick="switchCategory('gps-file', this)">📍 Gói File Định Vị Free Fire</button>
        </div>

        <div id="cat-mod-key" class="price-grid active">
            <div class="card" id="prod-card-0">
                <span class="card-tag blue" id="prod-stock-0">Còn lại: 5</span>
                <div class="card-duration" id="prod-title-0">Key Ngô Trân - 1 Ngày</div>
                <div class="card-price"><span id="prod-price-0">15.000</span> <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Update Miễn Phí Suốt Gói</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="buyProduct(0)">💳 Mua Bằng Số Dư</button>
                    <button class="admin-edit-card-btn" onclick="switchPage('admin')">⚙️ Sửa nhanh gói này</button>
                </div>
            </div>
            <div class="card" id="prod-card-1">
                <span class="card-tag blue" id="prod-stock-1">Còn lại: 3</span>
                <div class="card-duration" id="prod-title-1">Key Ngô Trân - 7 Ngày</div>
                <div class="card-price"><span id="prod-price-1">70.000</span> <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Reset ID Thiết Bị 1 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="buyProduct(1)">💳 Mua Bằng Số Dư</button>
                    <button class="admin-edit-card-btn" onclick="switchPage('admin')">⚙️ Sửa nhanh gói này</button>
                </div>
            </div>
            <div class="card" id="prod-card-2">
                <span class="card-tag blue" id="prod-stock-2">Còn lại: 6</span>
                <div class="card-duration" id="prod-title-2">Key Ngô Trân - 30 Ngày</div>
                <div class="card-price"><span id="prod-price-2">160.000</span> <span>VND</span></div>
                <ul class="card-features">
                    <li>Menu Mod VIP Full chức năng</li>
                    <li>Reset ID Thiết Bị 3 Lần</li>
                </ul>
                <div class="action-buttons">
                    <a href="https://zufile.com/download/lMGQkcehkz" class="download-btn" target="_blank">📥 Tải Hack</a>
                    <button class="buy-btn" onclick="buyProduct(2)">💳 Mua Bằng Số Dư</button>
                    <button class="admin-edit-card-btn" onclick="switchPage('admin')">⚙️ Sửa nhanh gói này</button>
                </div>
            </div>
        </div>

        <div id="cat-gps-file" class="price-grid">
            <div class="card" id="prod-card-3">
                <img class="card-img" id="prod-img-3" src="https://ibb.co/FMT8pzk" alt="Định vị súng">
                <span class="card-tag" id="prod-stock-3">Còn lại: 99999</span>
                <div class="card-duration" id="prod-title-3">Định Vị Súng VIP</div>
                <div class="card-price"><span id="prod-price-3">30.000</span> <span>VND</span></div>
                <ul class="card-features">
                    <li>Hiện vị trí súng thính, súng hiếm</li>
                    <li>Hiển thị rõ ràng xuyên tường</li>
                </ul>
                <div class="action-buttons">
                    <button class="buy-btn" onclick="buyProduct(3)">💳 Mua Bằng Số Dư</button>
                    <button class="admin-edit-card-btn" onclick="switchPage('admin')">⚙️ Sửa nhanh gói này</button>
                </div>
            </div>
            <div class="card" id="prod-card-4">
                <img class="card-img" id="prod-img-4" src="https://ibb.co/YTNgBTNG" alt="Định vị nhân vật">
                <span class="card-tag" id="prod-stock-4">Còn lại: 999</span>
                <div class="card-duration" id="prod-title-4">Định Vị Full Nhân Vật</div>
                <div class="card-price"><span id="prod-price-4">20.000</span> <span>VND</span></div>
                <ul class="card-features">
                    <li>Hiện người màu hồng Hologram</li>
                    <li>Thấy địch từ xa xuyên vật cản</li>
                </ul>
                <div class="action-buttons">
                    <button class="buy-btn" onclick="buyProduct(4)">💳 Mua Bằng Số Dư</button>
                    <button class="admin-edit-card-btn" onclick="switchPage('admin')">⚙️ Sửa nhanh gói này</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 2. TRANG NẠP TIỀN -->
    <div id="page-deposit" class="page-content">
        <h2 class="section-title">Nạp Tiền Vào Tài Khoản</h2>
        <p class="section-subtitle">Tạo lệnh yêu cầu nạp tiền gửi tới Ban Quản Trị duyệt</p>
        
        <div class="deposit-box">
            <div class="promo-banner">🔥 SỰ KIỆN KHUYẾN MÃI: X2 THỰC NHẬN KHI NẠP QUA BANK & THÈ CÀO!</div>
            
            <div class="input-group">
                <label>Chọn phương thức nạp:</label>
                <select id="depositMethod" onchange="toggleDepositFields()">
                    <option value="bank">Chuyển khoản Ngân Hàng (Duyệt tay x2)</option>
                    <option value="card">Nạp Thẻ Cào Điện Thoại (Duyệt tay x2)</option>
                </select>
            </div>

            <div id="bankFields">
                <div class="input-group">
                    <label>Nhập số tiền đã/sẽ chuyển (VND):</label>
                    <input type="number" id="bankAmount" placeholder="Ví dụ: 50000" value="50000">
                </div>
                <button class="buy-btn" style="background:#ff4757;" onclick="generateDepositQR()">Tạo Mã QR & Gửi Lệnh Duyệt</button>
            </div>

            <div id="cardFields" style="display:none;">
                <div class="input-group">
                    <label>Loại thẻ:</label>
                    <select id="cardType"><option>Viettel</option><option>Mobifone</option><option>Vinaphone</option></select>
                </div>
                <div class="input-group">
                    <label>Mệnh giá:</label>
                    <select id="cardValue"><option value="20000">20.000 VND (Nhận 40.000đ)</option><option value="50000">50.000 VND (Nhận 100.000đ)</option><option value="100000">100.000 VND (Nhận 200.000đ)</option></select>
                </div>
                <div class="input-group">
                    <label>Mã thẻ (Mật khẩu thẻ):</label>
                    <input type="text" id="cardPin" placeholder="Nhập mã số sau lớp bạc">
                </div>
                <div class="input-group">
                    <label>Số Seri:</label>
                    <input type="text" id="cardSeri" placeholder="Nhập số seri in trên thẻ">
                </div>
                <button class="buy-btn" style="background:#ff4757;" onclick="submitCardRequest()">Gửi Thẻ Lên Hàng Chờ Duyệt</button>
            </div>
        </div>

        <div id="depositInvoice" class="invoice-page">
            <div class="invoice-header" style="color:#2ed573; font-weight: bold;">VUI LÒNG CHUYỂN KHOẢN ĐÚNG THÔNG TIN</div>
            <div class="qr-wrapper"><img id="depositQrImg" class="qr-code-img" src=""></div>
            <div class="info-box">
                <div class="info-row"><span>Ngân hàng:</span><span>Agribank</span></div>
                <div class="info-row"><span>Chủ TK:</span><span>LO THI NON</span></div>
                <div class="info-row"><span>Số TK:</span><span>7905205067987</span></div>
                <div class="info-row"><span>Số tiền chuyển:</span><span id="depShowAmt" style="color:#2ed573; font-weight:bold;">0đ</span></div>
                <div class="info-row" style="border: 1px dashed #ff4757; padding: 5px; margin-top:5px;">
                    <span>Nội dung bắt buộc:</span><span id="depShowMemo" class="content-highlight"></span>
                </div>
            </div>
            <p style="font-size:0.85rem; color:#ff9f43; font-weight:bold; margin-top:10px;">⚠️ ĐÃ KHỞI TẠO LỆNH CHỜ! Hãy chuyển khoản đúng nội dung trên, Admin sẽ check lịch sử và duyệt cộng tiền sau 1-3 phút.</p>
        </div>
    </div>

    <!-- 3. TRANG LỊCH SỬ ĐÃ MUA -->
    <div id="page-history" class="page-content">
        <h2 class="section-title">Kho Hàng Đã Mua</h2>
        <p class="section-subtitle">Toàn bộ kho Key và Link tải file của bạn</p>
        <div id="historyList">
            <p style="text-align:center; color:#666; padding:20px;">Vui lòng đăng nhập để kiểm tra kho hàng.</p>
        </div>
    </div>

    <!-- 4. TRANG QUẢN TRỊ ADMIN -->
    <div id="page-admin" class="page-content">
        <!-- DANH SÁCH DUYỆT NẠP TIỀN -->
        <div class="admin-section" style="border-color: #2ed573; margin-top: 0; margin-bottom: 25px;">
            <h2 style="color: #2ed573; margin-bottom: 5px;">📥 DANH SÁCH DUYỆT NẠP TIỀN (BANK & CARD)</h2>
            <p style="color: #aaa; font-size: 0.85rem; margin-bottom: 10px;">Hiển thị toàn bộ các lệnh nạp tiền người dùng gửi lên.</p>
            <div id="adminRequestList">
                <p style="color: #666; text-align: center; padding: 15px;">Hiện tại không có yêu cầu nạp tiền nào đang chờ xử lý.</p>
            </div>
        </div>

        <!-- QUẢN LÝ SẢN PHẨM -->
        <div class="admin-section">
            <h2 style="color: #ff9f43; margin-bottom: 5px;">📦 QUẢN LÝ KHO SẢN PHẨM</h2>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Tên Sản Phẩm</th>
                        <th>Giá Tiền (VND)</th>
                        <th>Số Lượng Tồn</th>
                        <th>Ảnh Minh Họa (Dán Link)</th>
                    </tr>
                </thead>
                <tbody id="adminTableBody"></tbody>
            </table>
            <button class="buy-btn" style="background: #2ed573; margin-top: 15px; width: 100%;" onclick="saveAdminChanges()">💾 Lưu Cập Nhật Hệ Thống</button>
        </div>
    </div>

    <!-- POPUP ĐĂNG NHẬP -->
    <div id="authModal" class="modal-overlay">
        <div class="modal-box">
            <h3 id="authModalTitle" style="margin-bottom:15px; color:#fff;">ĐĂNG NHẬP HỆ THỐNG</h3>
            <div class="input-group">
                <label>Địa chỉ Email:</label>
                <input type="email" id="authEmail" placeholder="Nhập email tài khoản">
            </div>
            <div class="input-group">
                <label>Mật khẩu:</label>
                <input type="password" id="authPassword" placeholder="Nhập mật khẩu">
            </div>
            <button id="authPrimaryBtn" class="buy-btn" style="width:100%; margin-bottom:10px;" onclick="handleAuthSubmit()">Đăng nhập</button>
            <button class="buy-btn" style="width:100%; background:#7f8c8d; margin-bottom:10px;" onclick="closeAuthModal()">Hủy</button>
            <div style="text-align:center;">
                <span id="authToggleText" class="auth-toggle-link" onclick="toggleAuthMode()">Chưa có tài khoản? Đăng ký ngay</span>
            </div>
        </div>
    </div>

    <!-- THANH ĐIỀU HƯỚNG DƯỚI -->
    <div class="bottom-nav">
        <div class="nav-item active" onclick="switchPage('home', this)">
            <svg viewBox="0 0 24 24"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
            <span>Trang chủ</span>
        </div>
        <div class="nav-item" onclick="switchPage('home', this)">
            <svg viewBox="0 0 24 24"><path d="M4 11h5V5H4v6zm0 7h5v-6H4v6zm7 0h5v-6h-5v6zm0-13v6h5V5h-5z"/></svg>
            <span>Danh mục</span>
        </div>
        <div class="nav-item center-nav" onclick="switchPage('deposit', this)">
            <div class="icon-bg">
                <svg viewBox="0 0 24 24" style="fill:white; width:26px; height:26px;"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 13h-2v-2h2v2zm0-4h-2V7h2v4z"/></svg>
            </div>
            <span>Nạp tiền</span>
        </div>
        <div class="nav-item" onclick="switchPage('history', this)">
            <svg viewBox="0 0 24 24"><path d="M19 6h-2c0-2.76-2.24-5-5-5S7 3.24 7 6H5c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm-7-3c1.66 0 3 1.34 3 3H9c0-1.66 1.34-3 3-3zm7 17H5V8h14v12z"/></svg>
            <span>Đã mua</span>
        </div>
        <div id="navAdminTab" class="nav-item" onclick="handleAuthNavClick()">
            <svg viewBox="0 0 24 24"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>
            <span id="navLoginText">Đăng nhập</span>
        </div>
    </div>

    <script>
        // CẤU HÌNH LIÊN KẾT FIREBASE REALTIME DATABASE 
        const firebaseConfig = {
            apiKey: "AIzaSyAsYourRealApiKeyHere_XYZ",
            authDomain: "ngotran-mods-shop.firebaseapp.com",
            databaseURL: "https://ngotran-mods-shop-default-rtdb.firebaseio.com",
            projectId: "ngotran-mods-shop",
            storageBucket: "ngotran-mods-shop.appspot.com",
            messagingSenderId: "1234567890",
            appId: "1:12345:web:abcdef"
        };
        firebase.initializeApp(firebaseConfig);
        const auth = firebase.auth();
        const database = firebase.database();

        let defaultProducts = [
            { id: 0, title: "Key Ngô Trân - 1 Ngày", price: 15000, stock: 5, img: "", type: "key" },
            { id: 1, title: "Key Ngô Trân - 7 Ngày", price: 70000, stock: 3, img: "", type: "key" },
            { id: 2, title: "Key Ngô Trân - 30 Ngày", price: 160000, stock: 6, img: "", type: "key" },
            { id: 3, title: "Định Vị Súng VIP", price: 30000, stock: 99999, img: "https://ibb.co/FMT8pzk", type: "file" },
            { id: 4, title: "Định Vị Full Nhân Vật", price: 20000, stock: 999, img: "https://ibb.co/YTNgBTNG", type: "file" }
        ];

        let currentUser = null;
        let isRegisterMode = false;
        let products = defaultProducts;

        // Đồng bộ dữ liệu sản phẩm
        database.ref('products').on('value', (snapshot) => {
            if(snapshot.exists()) {
                products = snapshot.val();
                applyProductsToUI();
                renderAdminTable();
            } else {
                database.ref('products').set(defaultProducts);
            }
        });

        // ĐỒNG BỘ AUTHENTICATION & PHÂN QUYỀN ADMIN
        auth.onAuthStateChanged((user) => {
            if (user) {
                currentUser = user;
                document.getElementById('balanceWrapper').style.display = 'block';
                document.getElementById('authHeaderBtn').innerText = "Đăng xuất";
                
                if(user.email === "quangvandat7812@gmail.com") {
                    document.getElementById('navLoginText').innerText = "Admin Panel";
                    document.querySelectorAll('.admin-edit-card-btn').forEach(btn => btn.style.display = 'block');
                    listenDepositRequests();
                } else {
                    document.getElementById('navLoginText').innerText = "Tài khoản";
                }

                database.ref('users/' + user.uid).on('value', (snapshot) => {
                    const data = snapshot.val() || { balance: 0, history: [] };
                    document.getElementById('displayBalance').innerText = (data.balance || 0).toLocaleString('vi-VN');
                    renderHistory(data.history || []);
                });

            } else {
                currentUser = null;
                document.getElementById('balanceWrapper').style.display = 'none';
                document.getElementById('authHeaderBtn').innerText = "Đăng nhập / Đăng ký";
                document.getElementById('navLoginText').innerText = "Đăng nhập";
                document.querySelectorAll('.admin-edit-card-btn').forEach(btn => btn.style.display = 'none');
                document.getElementById('historyList').innerHTML = `<p style="text-align:center; color:#666; padding:20px;">Vui lòng đăng nhập để xem kho hàng.</p>`;
            }
        });

        function applyProductsToUI() {
            products.forEach(p => {
                if(document.getElementById(`prod-title-${p.id}`)) document.getElementById(`prod-title-${p.id}`).innerText = p.title;
                if(document.getElementById(`prod-price-${p.id}`)) document.getElementById(`prod-price-${p.id}`).innerText = p.price.toLocaleString('vi-VN');
                if(document.getElementById(`prod-stock-${p.id}`)) document.getElementById(`prod-stock-${p.id}`).innerText = `Còn lại: ${p.stock}`;
                if(p.img && document.getElementById(`prod-img-${p.id}`)) document.getElementById(`prod-img-${p.id}`).src = p.img;
            });
        }

        /* --- SỬ LÝ ĐĂNG NHẬP / ĐĂNG KÝ --- */
        function openAuthModal() {
            if(currentUser) { if(confirm("Bạn muốn đăng xuất khỏi hệ thống tài khoản?")) auth.signOut(); } 
            else { document.getElementById('authModal').style.display = 'flex'; }
        }
        function closeAuthModal() { document.getElementById('authModal').style.display = 'none'; }
        
        function toggleAuthMode() {
            isRegisterMode = !isRegisterMode;
            document.getElementById('authModalTitle').innerText = isRegisterMode ? "ĐĂNG KÝ THÀNH VIÊN" : "ĐĂNG NHẬP HỆ THỐNG";
            document.getElementById('authPrimaryBtn').innerText = isRegisterMode ? "Tạo tài khoản" : "Đăng nhập";
            document.getElementById('authToggleText').innerText = isRegisterMode ? "Đã có tài khoản? Đăng nhập ngay" : "Chưa có tài khoản? Đăng ký ngay";
        }

        function handleAuthSubmit() {
            const email = document.getElementById('authEmail').value.trim();
            const pass = document.getElementById('authPassword').value;
            if(!email || !pass) { alert("Vui lòng điền đầy đủ thông tin!"); return; }

            if(isRegisterMode) {
                auth.createUserWithEmailAndPassword(email, pass).then((userCredential) => {
                    database.ref('users/' + userCredential.user.uid).set({ email: email, balance: 0, history: [] });
                    alert("🎉 Đăng ký tài khoản thành công!"); closeAuthModal();
                }).catch(err => alert("Lỗi: " + err.message));
            } else {
                auth.signInWithEmailAndPassword(email, pass).then(() => {
                    alert("🎉 Đăng nhập thành công!"); closeAuthModal();
                }).catch(err => alert("Lỗi: " + err.message));
            }
        }

        function handleAuthNavClick() {
            if(currentUser && currentUser.email === "quangvandat7812@gmail.com") { switchPage('admin', document.getElementById('navAdminTab')); } 
            else { openAuthModal(); }
        }

        function switchPage(pageId, element) {
            document.querySelectorAll('.page-content').forEach(p => p.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
            document.getElementById('page-' + pageId).classList.add('active');
            if(element) element.classList.add('active');
        }

        function switchCategory(catId, element) {
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.price-grid').forEach(grid => grid.classList.remove('active'));
            element.classList.add('active'); document.getElementById('cat-' + catId).classList.add('active');
        }

        /* --- XỬ LÝ MUA HÀNG --- */
        function buyProduct(prodId) {
            if(!currentUser) { alert("⚠️ Vui lòng đăng nhập trước khi mua!"); openAuthModal(); return; }
            let p = products.find(item => item.id === prodId);
            if(!p || p.stock <= 0) { alert("Sản phẩm hết hàng!"); return; }

            const userRef = database.ref('users/' + currentUser.uid);
            userRef.get().then((snapshot) => {
                const userData = snapshot.val() || { balance: 0, history: [] };
                if (userData.balance < p.price) { alert(`❌ Số dư không đủ!`); return; }

                let finalBalance = userData.balance - p.price;
                let currentHistory = userData.history || [];
                let itemData = p.type === 'key' ? `NGOTRAN-035236857${Math.floor(100000 + Math.random() * 900000)}` : `https://zufile.com/download/VadKvFcgUX`;

                currentHistory.unshift({ name: p.title, price: p.price, type: p.type, data: itemData, date: new Date().toLocaleString('vi-VN') });
                userRef.update({ balance: finalBalance, history: currentHistory });
                database.ref('products/' + prodId).update({ stock: p.stock - 1 });
                alert(`🎉 Mua thành công! Kiểm tra trong mục "Đã mua".`);
            });
        }

        function renderHistory(historyArray) {
            const container = document.getElementById('historyList');
            if (!historyArray || historyArray.length === 0) {
                container.innerHTML = `<p style="text-align:center; color:#666; padding:20px;">Bạn chưa mua hàng.</p>`; return;
            }
            container.innerHTML = historyArray.map(item => `
                <div class="history-item">
                    <div class="history-header"><span>📦 ${item.name}</span><span style="color:#ffbc00;">-${item.price.toLocaleString()}đ</span></div>
                    <div style="font-size:0.8rem; color:#888;">Thời gian: ${item.date}</div>
                    <strong class="key-display">${item.data}</strong>
                </div>
            `).join('');
        }

        /* --- GIAO DIỆN NẠP TIỀN USER --- */
        function toggleDepositFields() {
            const method = document.getElementById('depositMethod').value;
            document.getElementById('bankFields').style.display = method === 'bank' ? 'block' : 'none';
            document.getElementById('cardFields').style.display = method === 'card' ? 'block' : 'none';
            document.getElementById('depositInvoice').style.display = 'none';
        }

        function generateDepositQR() {
            if(!currentUser) { alert("Vui lòng đăng nhập!"); openAuthModal(); return; }
            const amt = parseInt(document.getElementById('bankAmount').value);
            if (!amt || amt < 10000) { alert('Tối thiểu 10.000đ'); return; }
            
            const userShortId = currentUser.uid.substring(0, 6).toUpperCase();
            const memo = `NAP ${userShortId}`;

            database.ref('deposit_requests').push({
                uid: currentUser.uid,
                email: currentUser.email,
                type: 'BANK',
                amount: amt,
                bonusAmount: amt * 2,
                details: `Nội dung chuyển khoản: ${memo}`,
                card_pin: '', // Bank không có mã thẻ
                date: new Date().toLocaleString('vi-VN')
            });

            const qrUrl = `https://img.vietqr.io/image/Agribank-7905205067987-qr_only.png?amount=${amt}&addInfo=${encodeURIComponent(memo)}&accountName=LO%20THI%20NON`;
            document.getElementById('depositQrImg').src = qrUrl;
            document.getElementById('depShowAmt').innerText = `${amt.toLocaleString()} VND`;
            document.getElementById('depShowMemo').innerText = memo;
            document.getElementById('depositInvoice').style.display = 'block';
        }

        function submitCardRequest() {
            if(!currentUser) { alert("Vui lòng đăng nhập!"); openAuthModal(); return; }
            const type = document.getElementById('cardType').value;
            const val = parseInt(document.getElementById('cardValue').value);
            const pin = document.getElementById('cardPin').value.trim();
            const seri = document.getElementById('cardSeri').value.trim();

            if(!pin || !seri) { alert("Vui lòng nhập đủ Mã thẻ và Seri!"); return; }

            database.ref('deposit_requests').push({
                uid: currentUser.uid,
                email: currentUser.email,
                type: 'CARD',
                amount: val,
                bonusAmount: val * 2,
                details: `Loại thẻ: ${type} | SERI: ${seri}`,
                card_pin: pin, // Lưu riêng mã thẻ (mật khẩu) để Admin thấy
                date: new Date().toLocaleString('vi-VN')
            });

            alert("📥 Gửi thông tin thẻ cào lên hàng chờ thành công! Vui lòng đợi Admin kiểm tra thẻ và duyệt.");
            document.getElementById('cardPin').value = "";
            document.getElementById('cardSeri').value = "";
        }

        /* --- GIAO DIỆN XỬ LÝ LỆNH NẠP CHO ADMIN --- */
        function listenDepositRequests() {
            database.ref('deposit_requests').on('value', (snapshot) => {
                const container = document.getElementById('adminRequestList');
                if(!container) return;

                if(!snapshot.exists()) {
                    container.innerHTML = `<p style="color: #666; text-align: center; padding: 15px;">Hiện tại không có yêu cầu nạp tiền nào đang chờ xử lý.</p>`;
                    return;
                }

                let html = "";
                snapshot.forEach((childSnapshot) => {
                    const reqId = childSnapshot.key;
                    const req = childSnapshot.val();
                    
                    // Kiểm tra nếu là thẻ cào thì hiển thị thêm Mật khẩu thẻ nổi bật
                    let pinHtml = "";
                    if (req.type === 'CARD' && req.card_pin) {
                        pinHtml = `<div style="margin-top: 5px; color: #ffbc00;">🔑 <strong>Mật khẩu thẻ (PIN):</strong> <span class="admin-highlight-code">${req.card_pin}</span></div>`;
                    }

                    html += `
                        <div class="request-card" id="req-${reqId}">
                            <div style="display:flex; justify-content:space-between; font-weight:bold;">
                                <span style="color:#ff9f43;">[NẠP ${req.type}] - Thành viên: ${req.email}</span>
                                <span style="color:#2ed573;">Thực nhận X2: +${req.bonusAmount.toLocaleString()}đ</span>
                            </div>
                            <div style="margin: 5px 0; color: #ccc;"><strong>Thông tin gửi:</strong> ${req.details}</div>
                            ${pinHtml}
                            <div style="font-size:0.8rem; color:#777; margin-top:5px;">Gửi lúc: ${req.date}</div>
                            <div class="request-buttons">
                                <button class="approve-btn" onclick="approveDeposit('${reqId}', '${req.uid}', ${req.bonusAmount})">✅ Duyệt (Cộng tiền)</button>
                                <button class="reject-btn" onclick="rejectDeposit('${reqId}')">❌ Hủy bỏ</button>
                            </div>
                        </div>
                    `;
                });
                container.innerHTML = html;
            });
        }

        function approveDeposit(reqId, userUid, bonusAmt) {
            if(!confirm("Bạn có chắc chắn đã nhận được tiền/thẻ này và muốn cộng tiền cho khách?")) return;

            const userBalRef = database.ref(`users/${userUid}/balance`);
            userBalRef.get().then((snapshot) => {
                let currentBalance = snapshot.exists() ? snapshot.val() : 0;
                let newBalance = currentBalance + bonusAmt;

                database.ref(`users/${userUid}`).update({ balance: newBalance }).then(() => {
                    database.ref(`deposit_requests/${reqId}`).remove();
                    alert("Duyệt nạp tiền thành công! Người dùng đã được cộng tiền.");
                });
            });
        }

        function rejectDeposit(reqId) {
            if(!confirm("Bạn muốn hủy bỏ và xóa yêu cầu nạp này?")) return;
            database.ref(`deposit_requests/${reqId}`).remove().then(() => {
                alert("Đã hủy bỏ yêu cầu thành công.");
            });
        }

        /* --- QUẢN LÝ THAY ĐỔI CỦA ADMIN --- */
        function renderAdminTable() {
            const tbody = document.getElementById('adminTableBody');
            if(!tbody) return;
            tbody.innerHTML = products.map(p => `
                <tr>
                    <td><input type="text" id="adm-title-${p.id}" class="admin-inline-input" value="${p.title}"></td>
                    <td><input type="number" id="adm-price-${p.id}" class="admin-inline-input" value="${p.price}"></td>
                    <td><input type="number" id="adm-stock-${p.id}" class="admin-inline-input" value="${p.stock}"></td>
                    <td>
                        ${p.type === 'file' ? `<input type="text" id="adm-img-${p.id}" class="admin-inline-input" value="${p.img}">` : `<span style="color:#666;">Không dùng ảnh</span>`}
                    </td>
                </tr>
            `).join('');
        }

        function saveAdminChanges() {
            if(!currentUser || currentUser.email !== "quangvandat7812@gmail.com") { alert("Từ chối truy cập!"); return; }
            let updatedProducts = [];
            products.forEach(p => {
                let uProd = {
                    id: p.id,
                    title: document.getElementById(`adm-title-${p.id}`).value,
                    price: parseInt(document.getElementById(`adm-price-${p.id}`).value),
                    stock: parseInt(document.getElementById(`adm-stock-${p.id}`).value),
                    type: p.type,
                    img: p.type === 'file' ? document.getElementById(`adm-img-${p.id}`).value : ""
                };
                updatedProducts.push(uProd);
            });
            database.ref('products').set(updatedProducts).then(() => {
                alert("💾 Đã cập nhật giá tiền & kho hàng thành công!");
                switchPage('home', document.querySelectorAll('.nav-item')[0]);
            });
        }
    </script>
</body>
</html>
