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

.container{
    width:100%;
    max-width:480px;
    margin:auto;
    padding:25px 18px 50px;
}

.profile{
    background:rgba(15,23,42,.78);
    border:1px solid rgba(59,130,246,.25);
    border-radius:38px;
    padding:32px 22px;
    text-align:center;
    backdrop-filter:blur(12px);
    box-shadow:0 0 40px rgba(59,130,246,.12);
}

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

.name{
    margin-top:18px;
    font-size:38px;
    font-weight:700;
}

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

.links{
    margin-top:35px;
    display:flex;
    flex-direction:column;
    gap:22px;
}

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

.item img{
    width:72px;
    height:72px;
    border-radius:18px;
    object-fit:cover;
}

.item span{
    font-size:18px;
    font-weight:600;
}

.gallery{
    margin-top:30px;
}

.gallery img{
    width:100%;
    border-radius:25px;
    border:2px solid rgba(255,255,255,.08);
}

.comment-box{
    margin-top:28px;
    padding:22px;
    border-radius:30px;
    background:rgba(15,23,42,.75);
    border:1px solid rgba(59,130,246,.2);
}

.comment-title{
    font-size:28px;
    font-weight:700;
}

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

.footer{
    text-align:center;
    margin-top:30px;
    color:#aaa;
    font-size:14px;
}

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

<img class="avatar"
src="https://i.ibb.co/fzPg5PYx/ảnh2.jpg">

<div class="name">
VanDatDev ⚡
</div>

<div class="bio">
✨ gaming profile · share script ✨
</div>

<div class="socials">

<a href="https://tiktok.com"
target="_blank"
class="social">
<i class="fab fa-tiktok"></i>
</a>

<a href="https://discord.gg/ahxDyZNgec"
target="_blank"
class="social">
<i class="fab fa-discord"></i>
</a>

<a href="https://facebook.com"
target="_blank"
class="social">
<i class="fab fa-facebook-f"></i>
</a>

</div>

<div class="links">

<a href="https://discord.gg/ahxDyZNgec"
target="_blank"
class="item">

<img src="https://i.ibb.co/4wLrTx5H/ảnh1.jpg">

<span>
🍎 Share Script Free Fire 🍏
</span>

</a>

<a href="https://youtube.com"
target="_blank"
class="item">

<img src="https://i.ibb.co/0RtJsTmC/ảnh3.jpg">

<span>
⚡ Tổng Hợp Client Mới Nhất
</span>

</a>

<a href="https://facebook.com"
target="_blank"
class="item">

<img src="https://i.ibb.co/kg0gQZnr/ảnh4.jpg">

<span>
😎 Liên Hệ Admin Nếu Có Lỗi
</span>

</a>

</div>

<!-- ONLY IMAGE 4 -->
<div class="gallery">

<img src="https://i.ibb.co/kg0gQZnr/ảnh4.jpg">

</div>

<!-- COMMENT -->
<div class="comment-box">

<div class="comment-title">
💬 Bình luận
</div>

<!-- COUNTDOWN -->
<div id="cooldownText"
style="
margin-top:10px;
color:#60a5fa;
font-size:14px;">
⏳ Có thể gửi ngay
</div>

<!-- NAME -->
<div class="input-group"
id="nameBox">

<input type="text"
id="commentName"
placeholder="Đặt tên của bạn (không bắt buộc)...">

<button onclick="saveCommentName()">
Lưu
</button>

</div>

<!-- COMMENT -->
<div class="input-group">

<input type="text"
id="commentInput"
placeholder="Viết bình luận...">

<button id="sendBtn"
onclick="sendComment()">
Gửi
</button>

</div>

<div id="comments"></div>

</div>

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

/* LOAD NAME */
let savedCommentName=
localStorage.getItem("commentUserName");

/* LOAD COMMENTS */
let savedComments=
JSON.parse(localStorage.getItem("comments")) || [];

/* SHOW COMMENTS */
function renderComments(){

document.getElementById("comments").innerHTML="";

savedComments.forEach(c=>{

let div=document.createElement("div");

div.className="cmt";

div.innerHTML=`
<div class="cmt-name">
👤 ${c.name}
</div>

<div>
${c.text}
</div>
`;

document.getElementById("comments")
.appendChild(div);

});

}

/* FIRST LOAD */
renderComments();

/* AUTO RELOAD COMMENTS EVERY 30S */
setInterval(()=>{

savedComments=
JSON.parse(localStorage.getItem("comments")) || [];

renderComments();

},30000);

/* AUTO LOAD NAME */
if(savedCommentName){

document.getElementById("commentName").value=
savedCommentName;

document.getElementById("nameBox")
.style.display="none";
}

/* SAVE NAME */
function saveCommentName(){

let name=
document.getElementById("commentName").value;

if(name.trim()===""){

localStorage.removeItem("commentUserName");

alert("Đã chuyển về khách 😎");

return;
}

localStorage.setItem("commentUserName",name);

document.getElementById("nameBox")
.style.display="none";

alert("Đã lưu tên 🔥");
}

/* COOLDOWN */
let cooldown=false;
let countdown=30;
let timer;

/* SEND COMMENT */
function sendComment(){

if(cooldown){

alert("Đợi cooldown xong 😎");

return;
}

let text=
document.getElementById("commentInput").value;

if(text.trim()==="") return;

let name=
localStorage.getItem("commentUserName");

if(!name || name.trim()===""){

name="Khách";
}

savedComments.unshift({
name:name,
text:text
});

localStorage.setItem(
"comments",
JSON.stringify(savedComments)
);

renderComments();

document.getElementById("commentInput").value="";

/* START COOLDOWN */
cooldown=true;
countdown=30;

document.getElementById("sendBtn")
.disabled=true;

timer=setInterval(()=>{

document.getElementById("cooldownText")
.innerHTML=
`⏳ Tải lại bình luận sau ${countdown}s`;

countdown--;

if(countdown<0){

clearInterval(timer);

cooldown=false;

document.getElementById("sendBtn")
.disabled=false;

document.getElementById("cooldownText")
.innerHTML=
"✅ Có thể gửi lại";

}

},1000);

}

</script>

</body>
</html>
