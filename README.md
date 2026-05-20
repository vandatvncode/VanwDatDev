<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>VanDatDev ⚡</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#050816;
    color:white;
    overflow-x:hidden;
}

/* BACKGROUND */
body::before{
    content:"";
    position:fixed;
    inset:0;

    background:
    radial-gradient(circle at top,#172554,#020617 70%);

    z-index:-3;
}

/* GLOW */
body::after{
    content:"";
    position:fixed;
    width:500px;
    height:500px;

    background:#2563eb;
    border-radius:50%;

    filter:blur(150px);

    opacity:.25;

    top:-150px;
    left:-150px;

    z-index:-2;
}

/* CONTAINER */
.container{
    width:100%;
    max-width:480px;
    margin:auto;
    padding:25px 18px 50px;
}

/* PROFILE */
.profile{
    background:rgba(15,23,42,.78);

    border:1px solid rgba(59,130,246,.25);

    border-radius:38px;

    padding:32px 22px;

    text-align:center;

    backdrop-filter:blur(12px);

    box-shadow:0 0 40px rgba(59,130,246,.12);
}

/* AVATAR */
.avatar{
    width:145px;
    height:145px;

    border-radius:50%;

    object-fit:cover;

    border:5px solid #a855f7;

    box-shadow:
    0 0 15px #9333ea,
    0 0 35px #9333ea;
}

/* NAME */
.name{
    margin-top:18px;

    font-size:38px;
    font-weight:700;

    color:white;
}

/* BIO */
.bio{
    margin-top:12px;

    display:inline-block;

    padding:10px 20px;

    border-radius:50px;

    background:rgba(255,255,255,.05);

    border:1px solid rgba(255,255,255,.08);

    color:#ddd;

    font-size:14px;
}

/* SOCIAL */
.socials{
    display:flex;
    justify-content:center;
    gap:18px;

    margin-top:28px;
}

.social{
    width:65px;
    height:65px;

    border-radius:22px;

    display:flex;
    align-items:center;
    justify-content:center;

    background:rgba(255,255,255,.05);

    border:1px solid rgba(255,255,255,.08);

    color:white;

    font-size:28px;

    text-decoration:none;

    transition:.3s;
}

.social:hover{
    transform:translateY(-6px);

    box-shadow:0 0 25px rgba(59,130,246,.35);
}

/* LINKS */
.links{
    margin-top:35px;

    display:flex;
    flex-direction:column;

    gap:22px;
}

/* ITEM */
.item{
    display:flex;
    align-items:center;
    gap:18px;

    padding:18px;

    border-radius:28px;

    background:rgba(15,23,42,.75);

    border:1px solid rgba(59,130,246,.2);

    text-decoration:none;

    color:white;

    transition:.35s;

    box-shadow:0 0 25px rgba(59,130,246,.1);
}

.item:hover{
    transform:scale(1.03);

    border-color:#3b82f6;
}

/* IMG */
.item img{
    width:72px;
    height:72px;

    border-radius:18px;

    object-fit:cover;

    border:2px solid rgba(255,255,255,.1);
}

/* TEXT */
.item span{
    font-size:18px;
    font-weight:600;
}

/* BANNER */
.banner{
    margin-top:32px;

    overflow:hidden;

    border-radius:30px;

    border:1px solid rgba(255,255,255,.08);

    box-shadow:0 0 35px rgba(0,0,0,.35);
}

.banner img{
    width:100%;
    display:block;
}

/* BOX */
.comment-box{
    margin-top:28px;

    padding:22px;

    border-radius:30px;

    background:rgba(15,23,42,.75);

    border:1px solid rgba(59,130,246,.2);
}

/* TITLE */
.comment-title{
    font-size:30px;
    font-weight:700;
}

/* INPUT */
.input-group{
    margin-top:18px;

    display:flex;
    gap:10px;
}

.input-group input{
    flex:1;

    padding:15px;

    border:none;

    border-radius:20px;

    background:#020617;

    color:white;

    outline:none;

    border:1px solid rgba(59,130,246,.2);
}

.input-group button{
    padding:0 22px;

    border:none;

    border-radius:18px;

    background:#2563eb;

    color:white;

    font-weight:600;

    cursor:pointer;
}

/* COMMENT */
.cmt{
    margin-top:18px;

    padding:16px;

    border-radius:22px;

    background:rgba(255,255,255,.04);

    text-align:left;
}

.cmt-name{
    font-weight:700;
    margin-bottom:8px;
}

/* FOOTER */
.footer{
    text-align:center;

    margin-top:30px;

    color:#aaa;

    font-size:14px;
}

/* FLOAT */
.float{
    position:fixed;

    top:-10px;

    color:#3b82f6;

    animation:fall linear infinite;

    pointer-events:none;
}

@keyframes fall{
    to{
        transform:translateY(110vh);
        opacity:0;
    }
}

</style>
</head>

<body>

<div class="container">

    <div class="profile">

        <!-- AVATAR -->
        <img class="avatar"
        src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

        <!-- NAME -->
        <div class="name">
            VanDatDev ⚡
        </div>

        <!-- BIO -->
        <div class="bio">
            ✨ chia sẻ script · gaming profile ✨
        </div>

        <!-- SOCIAL -->
        <div class="socials">

            <a href="#" class="social">
                <i class="fab fa-tiktok"></i>
            </a>

            <a href="#" class="social">
                <i class="fab fa-discord"></i>
            </a>

            <a href="#" class="social">
                <i class="fab fa-facebook-f"></i>
            </a>

        </div>

        <!-- LINKS -->
        <div class="links">

            <a href="#" class="item">

                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

                <span>
                    🍎 Share script free fire 🍏
                </span>

            </a>

            <a href="#" class="item">

                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

                <span>
                    ⚡ Tổng hợp client mới nhất
                </span>

            </a>

            <a href="#" class="item">

                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

                <span>
                    😎 Liên hệ admin nếu có lỗi
                </span>

            </a>

            <a href="#" class="item">

                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

                <span>
                    💻 Hướng dẫn làm script
                </span>

            </a>

        </div>

        <!-- IMAGE -->
        <div class="banner">

            <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

        </div>

        <!-- COMMENT -->
        <div class="comment-box">

            <div class="comment-title">
                💬 Bình luận cộng đồng
            </div>

            <div class="input-group">

                <input type="text"
                id="commentInput"
                placeholder="Viết bình luận...">

                <button onclick="sendComment()">
                    Gửi
                </button>

            </div>

            <div id="comments">

                <div class="cmt">

                    <div class="cmt-name">
                        👤 Khách
                    </div>

                    <div>
                        web đẹp vc 😭
                    </div>

                </div>

            </div>

        </div>

        <!-- ADMIN MESSAGE -->
        <div class="comment-box">

            <div class="comment-title">
                📩 Nhắn Tin Cho Admin
            </div>

            <div class="input-group">

                <input type="text"
                id="msgInput"
                placeholder="Nhập tin nhắn cho admin...">

                <button onclick="sendMsg()">
                    Gửi
                </button>

            </div>

            <div id="messages"></div>

        </div>

        <!-- FOOTER -->
        <div class="footer">
            © 2026 VanDatDev ⚡
        </div>

    </div>

</div>

<script>

/* FLOAT EFFECT */
for(let i=0;i<70;i++){

    let icon=document.createElement("div");

    icon.className="float";

    icon.innerHTML="⚡";

    icon.style.left=Math.random()*100+"vw";

    icon.style.fontSize=(Math.random()*18+10)+"px";

    icon.style.animationDuration=(Math.random()*5+3)+"s";

    document.body.appendChild(icon);
}

/* COMMENT */
function sendComment(){

    let input=document.getElementById("commentInput");

    let text=input.value;

    if(text.trim()==="") return;

    let div=document.createElement("div");

    div.className="cmt";

    div.innerHTML=`
        <div class="cmt-name">
            👤 Khách
        </div>

        <div>
            ${text}
        </div>
    `;

    document.getElementById("comments").prepend(div);

    input.value="";
}

/* MESSAGE ADMIN */
function sendMsg(){

    let input=document.getElementById("msgInput");

    let text=input.value;

    if(text.trim()==="") return;

    let div=document.createElement("div");

    div.className="cmt";

    div.innerHTML=`
        <div class="cmt-name">
            📩 Bạn đã gửi
        </div>

        <div>
            ${text}
        </div>
    `;

    document.getElementById("messages").prepend(div);

    input.value="";

    alert("Đã gửi tin nhắn cho admin ⚡");
}

</script>

</body>
</html>
