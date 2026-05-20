<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>VanDatDev ⚡</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>

<style>
    
}

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

/* BG */
body::before{
    content:"";
    position:fixed;
    inset:0;
    background:
    radial-gradient(circle at top,#172554,#020617 70%);
    z-index:-3;
}

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

/* USER */
#userTag{
    position:fixed;
    top:18px;
    right:18px;
    background:rgba(15,23,42,.9);
    border:1px solid rgba(59,130,246,.3);
    padding:10px 16px;
    border-radius:18px;
    backdrop-filter:blur(10px);
    font-size:14px;
    font-weight:600;
    color:white;
    z-index:999;
    box-shadow:0 0 20px rgba(59,130,246,.2);
}

/* RESET */
#resetBtn{
    position:fixed;
    top:18px;
    left:18px;
    background:#dc2626;
    border:none;
    color:white;
    padding:10px 16px;
    border-radius:18px;
    cursor:pointer;
    font-weight:600;
    z-index:999;
    display:none;
    box-shadow:0 0 20px rgba(220,38,38,.35);
}

/* ADMIN MENU */
#adminMenu{
    position:fixed;
    inset:0;
    background:rgba(0,0,0,.7);
    display:none;
    align-items:center;
    justify-content:center;
    z-index:9999;
    backdrop-filter:blur(6px);
}

.admin-box{
    width:90%;
    max-width:360px;
    background:#0f172a;
    border:1px solid rgba(59,130,246,.3);
    border-radius:28px;
    padding:25px;
    text-align:center;
    box-shadow:0 0 40px rgba(59,130,246,.2);
    animation:showAdmin .25s;
    max-height:80vh;
    overflow-y:auto;
}

@keyframes showAdmin{
    from{
        opacity:0;
        transform:scale(.9);
    }
    to{
        opacity:1;
        transform:scale(1);
    }
}

.admin-box h2{
    margin-bottom:18px;
    font-size:24px;
}

.admin-box input{
    width:100%;
    padding:14px;
    border:none;
    outline:none;
    border-radius:18px;
    background:#020617;
    color:white;
    border:1px solid rgba(59,130,246,.25);
    margin-top:12px;
}

.admin-buttons{
    margin-top:18px;
    display:flex;
    gap:10px;
}

.admin-buttons button{
    flex:1;
    padding:13px;
    border:none;
    border-radius:18px;
    cursor:pointer;
    color:white;
    font-weight:600;
}

.admin-buttons button:first-child{
    background:#2563eb;
}

.admin-buttons button:last-child{
    background:#dc2626;
}

.panel-title{
    margin-bottom:18px;
    font-size:22px;
}

.panelBtn{
    width:100%;
    margin-top:12px;
    padding:14px;
    border:none;
    border-radius:18px;
    cursor:pointer;
    font-weight:600;
    color:white;
    background:#2563eb;
}

.panelBtn.red{
    background:#dc2626;
}

.panelBtn.orange{
    background:#ea580c;
}

.panelBtn.gray{
    background:#475569;
}

.panelBtn.green{
    background:#16a34a;
}

/* CONTAINER */
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
}

/* LINKS */
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
}

.item:hover{
    transform:scale(1.03);
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

/* IMAGE */
.gallery{
    margin-top:30px;
}

.gallery img{
    width:100%;
    border-radius:25px;
}

/* COMMENT */
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

.reloadText{
    margin-top:10px;
    color:#60a5fa;
    font-size:14px;
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

/* COMMENTS */
#comments{
    margin-top:20px;
    max-height:350px;
    overflow-y:auto;
    padding-right:6px;
}

#comments::-webkit-scrollbar{
    width:6px;
}

#comments::-webkit-scrollbar-thumb{
    background:#2563eb;
    border-radius:20px;
}

.cmt{
    margin-bottom:14px;
    padding:16px;
    border-radius:22px;
    background:rgba(255,255,255,.04);
    text-align:left;
    animation:show .3s;
}

@keyframes show{
    from{
        opacity:0;
        transform:translateY(10px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.cmt-name{
    font-weight:700;
    margin-bottom:8px;
    color:#60a5fa;
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
    .subMenu{
    display:none;
    flex-direction:column;
    gap:10px;
    margin-top:10px;
    margin-left:20px;
    animation: fade .3s ease;
}

.subBtn{
    padding:12px;
    border-radius:18px;
    background:#1e293b;
    color:white;
    text-decoration:none;
    font-size:14px;
    border:1px solid rgba(255,255,255,.08);
}

@keyframes fade{
    from{opacity:0; transform:translateY(-5px);}
    to{opacity:1; transform:translateY(0);}
}

</style>
</head>

<body>

<button id="resetBtn"
onclick="showAdminMenu()">
ADMIN
</button>

<div id="userTag">
👤 Khách
</div>

<div class="links">

<!-- MENU 1 -->
<div class="item"
onclick="toggleMenu('hackMenu')">

<img src="https://i.ibb.co/4wLrTx5H/ảnh1.jpg">

<span>🍎 Share Script Free Fire 🍏</span>

</div>

<div class="subMenu" id="hackMenu">

<a href="https://google.com" target="_blank" class="subBtn">
🔥 AIMLOCK VIP
</a>

<a href="https://youtube.com" target="_blank" class="subBtn">
⚡ PANEL HEADSHOT
</a>

<a href="https://discord.gg/ahxDyZNgec" target="_blank" class="subBtn">
👑 JOIN DISCORD
</a>

</div>

<!-- MENU 2 -->
<div class="item"
onclick="toggleMenu('clientMenu')">

<img src="https://i.ibb.co/0RtJsTmC/ảnh3.jpg">

<span>⚡ Tổng Hợp Client Mới Nhất</span>

</div>

<div class="subMenu" id="clientMenu">

<a href="https://youtube.com" target="_blank" class="subBtn">
💻 CLIENT IOS
</a>

<a href="https://google.com" target="_blank" class="subBtn">
🎮 CLIENT ANDROID
</a>

<a href="https://discord.gg/ahxDyZNgec" target="_blank" class="subBtn">
📦 FULL PACK CLIENT
</a>

</div>

<!-- MENU 3 -->
<div class="item"
onclick="toggleMenu('contactMenu')">

<img src="https://i.ibb.co/kg0gQZnr/ảnh4.jpg">

<span>😎 Liên Hệ Admin Nếu Có Lỗi</span>

</div>

<div class="subMenu" id="contactMenu">

<a href="https://facebook.com" target="_blank" class="subBtn">
📩 FACEBOOK ADMIN
</a>

<a href="https://discord.gg/ahxDyZNgec" target="_blank" class="subBtn">
💬 DISCORD SUPPORT
</a>

<a href="https://tiktok.com" target="_blank" class="subBtn">
🎥 TIKTOK ADMIN
</a>

</div>

</div>
<!-- ADMIN MENU -->
<div id="adminMenu">

<div class="admin-box">

<h2>🔒 ADMIN PANEL</h2>

<!-- LOGIN -->
<div id="adminLogin">

<input type="password"
id="adminPass"
placeholder="Nhập mật khẩu admin...">

<div class="admin-buttons">

<button onclick="checkAdminPass()">
Đăng nhập
</button>

<button onclick="closeAdminMenu()">
Đóng
</button>

</div>

</div>

<!-- PANEL -->
<div id="adminPanel"
style="display:none;">

<h3 class="panel-title">
⚙️ Tùy Chọn Admin
</h3>

<!-- TITLE -->
<input type="text"
id="newTitle"
placeholder="Đổi title web...">

<button class="panelBtn"
onclick="changeTitle()">
Đổi Title
</button>

<!-- XÓA TÊN -->
<input type="text"
id="removeName"
placeholder="Tên cần xoá...">

<button class="panelBtn red"
onclick="removePlayerName()">
Xoá Tên Người Chơi
</button>

<!-- RESET COMMENT -->
<button class="panelBtn orange"
onclick="resetComments()">
Reset Bình Luận
</button>

<!-- RESET ALL -->
<button class="panelBtn red"
onclick="resetAllData()">
Reset Toàn Bộ
</button>

<!-- SHOW USED -->
<button class="panelBtn green"
onclick="showUsedNames()">
Hiện Tên Đã Dùng
</button>

<!-- CLOSE -->
<button class="panelBtn gray"
onclick="closeAdminMenu()">
Đóng Panel
</button>

</div>

</div>

</div>

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

<!-- MENU CHA 1 -->
<div class="item" onclick="toggleMenu('hackMenu')">
<img src="https://i.ibb.co/4wLrTx5H/ảnh1.jpg">
<span>🍎 Share Script Free Fire 🍏</span>
</div>

<div class="subMenu" id="hackMenu">
<a href="https://google.com" target="_blank" class="subBtn">🔥 AIMLOCK VIP</a>
<a href="https://youtube.com" target="_blank" class="subBtn">⚡ PANEL HEADSHOT</a>
<a href="https://discord.gg/ahxDyZNgec" target="_blank" class="subBtn">👑 JOIN DISCORD</a>
</div>

<!-- MENU CHA 2 -->
<div class="item" onclick="toggleMenu('clientMenu')">
<img src="https://i.ibb.co/0RtJsTmC/ảnh3.jpg">
<span>⚡ Tổng Hợp Client Mới Nhất</span>
</div>

<div class="subMenu" id="clientMenu">
<a href="#" class="subBtn">💻 CLIENT IOS</a>
<a href="#" class="subBtn">🎮 CLIENT ANDROID</a>
<a href="#" class="subBtn">📦 FULL PACK CLIENT</a>
</div>

<!-- MENU CHA 3 -->
<div class="item" onclick="toggleMenu('contactMenu')">
<img src="https://i.ibb.co/kg0gQZnr/ảnh4.jpg">
<span>😎 Liên Hệ Admin</span>
</div>

<div class="subMenu" id="contactMenu">
<a href="https://facebook.com" target="_blank" class="subBtn">📩 FACEBOOK</a>
<a href="https://discord.gg/ahxDyZNgec" target="_blank" class="subBtn">💬 DISCORD</a>
<a href="https://tiktok.com" target="_blank" class="subBtn">🎥 TIKTOK</a>
</div>

</div>

<div class="gallery">
<img src="https://i.ibb.co/kg0gQZnr/ảnh4.jpg">
</div>

<div class="comment-box">

<div class="comment-title">
💬 Bình luận
</div>

<div class="reloadText">
🔄 Tải lại bình luận sau:
<span id="timer">30</span>s
</div>

<!-- NAME -->
<div class="input-group" id="nameBox">

<input type="text"
id="commentName"
placeholder="Đặt tên của bạn...">

<button onclick="saveCommentName()">
Lưu
</button>

</div>

<!-- COMMENT -->
<div class="input-group">

<input type="text"
id="commentInput"
placeholder="Viết bình luận...">

<button onclick="sendComment()">
Gửi
</button>

</div>

<div id="comments"></div>

</div>

<div class="footer">
© 2026 VanDatDev ⚡
</div>

</div>

<script>

/* ADMIN */
const ADMIN_NAME = "VanwDatdz";
const ADMIN_PASSWORD = "vandat";

/* FLOAT */
for(let i=0;i<70;i++){

let icon=document.createElement("div");

icon.className="float";

icon.innerHTML="⚡";

icon.style.left=Math.random()*100+"vw";

icon.style.fontSize=(Math.random()*18+10)+"px";

icon.style.animationDuration=(Math.random()*5+3)+"s";

document.body.appendChild(icon);
}

/* DATA */
let comments =
JSON.parse(localStorage.getItem("comments")) || [];

let usedNames =
JSON.parse(localStorage.getItem("usedNames")) || [];

let savedName =
localStorage.getItem("deviceName");

/* LOAD NAME */
if(savedName){

document.getElementById("commentName").value =
savedName;

document.getElementById("nameBox")
.style.display="none";
}

/* USER TAG */
function updateUserTag(){

let name =
localStorage.getItem("deviceName");

if(!name){

name="Khách";
}

document.getElementById("userTag")
.innerHTML=`👤 ${name}`;

if(name === ADMIN_NAME){

document.getElementById("resetBtn")
.style.display="block";

}else{

document.getElementById("resetBtn")
.style.display="none";

}

}

updateUserTag();

/* SAVE NAME */
function saveCommentName(){

if(localStorage.getItem("lockedName")){

alert("Thiết bị này đã đặt tên rồi 😎");

return;
}

let name =
document.getElementById("commentName").value;

if(name.trim()===""){

alert("Nhập tên trước 😎");

return;
}

if(usedNames.includes(name)){

alert("Tên này đã có người dùng 😭");

return;
}

usedNames.push(name);

localStorage.setItem(
"usedNames",
JSON.stringify(usedNames)
);

localStorage.setItem("deviceName",name);
localStorage.setItem("lockedName","true");

document.getElementById("nameBox")
.style.display="none";

updateUserTag();

alert("Đã lưu tên 🔥");
}

/* RENDER COMMENTS */
function renderComments(){

let commentsBox =
document.getElementById("comments");

commentsBox.innerHTML="";

comments.forEach(c=>{

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

commentsBox.appendChild(div);

});

}

renderComments();

/* SEND */
function sendComment(){

let text =
document.getElementById("commentInput").value;

if(text.trim()==="") return;

let name =
localStorage.getItem("deviceName");

if(!name){

name="Khách";
}

comments.unshift({

name:name,
text:text

});

localStorage.setItem(
"comments",
JSON.stringify(comments)
);

document.getElementById("commentInput").value="";

renderComments();
}

/* TIMER */
let time = 30;

setInterval(()=>{

time--;

document.getElementById("timer")
.innerText=time;

if(time <= 0){

comments =
JSON.parse(localStorage.getItem("comments")) || [];

renderComments();

time = 30;

}

},1000);

/* OPEN ADMIN */
function showAdminMenu(){

document.getElementById("adminMenu")
.style.display="flex";

}

/* CLOSE */
function closeAdminMenu(){

document.getElementById("adminMenu")
.style.display="none";

}

/* LOGIN */
function checkAdminPass(){

let pass =
document.getElementById("adminPass").value;

if(pass !== ADMIN_PASSWORD){

alert("Sai mật khẩu 😎");

return;
}

document.getElementById("adminLogin")
.style.display="none";

document.getElementById("adminPanel")
.style.display="block";

}

/* CHANGE TITLE */
function changeTitle(){

let title =
document.getElementById("newTitle").value;

if(title.trim()===""){

alert("Nhập title 😎");

return;
}

document.title = title;

alert("Đã đổi title 🔥");
}

/* REMOVE NAME */
function removePlayerName(){

let target =
document.getElementById("removeName").value;

if(target.trim()===""){

alert("Nhập tên cần xoá 😎");

return;
}

usedNames =
usedNames.filter(name => name !== target);

localStorage.setItem(
"usedNames",
JSON.stringify(usedNames)
);

alert("Đã xoá tên 🔥");
}

/* RESET COMMENT */
function resetComments(){

localStorage.removeItem("comments");

alert("Đã reset bình luận 🔥");

location.reload();
}

/* RESET ALL */
function resetAllData(){

localStorage.clear();

alert("Đã reset toàn bộ 🔥");

location.reload();
}

/* SHOW USED */
function showUsedNames(){

let data =
JSON.parse(localStorage.getItem("usedNames")) || [];

if(data.length === 0){

alert("Chưa có tên nào 😎");

return;
}

alert(
"📋 Tên đã dùng:\n\n" +
data.join("\n")
);

}
    function toggleMenu(id){
    let el = document.getElementById(id);

    if(el.style.display === "flex"){
        el.style.display = "none";
    }else{
        el.style.display = "flex";
    }
    }

</script>

</body>
</html>
