<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>For You 💖</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Poppins}

body{
height:100vh;
display:flex;
justify-content:center;
align-items:center;
overflow:hidden;
background:linear-gradient(135deg,#ff4d6d,#ffb6c1,#6a5acd);
}

.card{
width:90%;
max-width:420px;
padding:25px;
border-radius:20px;
background:rgba(0,0,0,0.35);
backdrop-filter:blur(10px);
text-align:center;
color:white;
box-shadow:0 0 30px rgba(255,255,255,0.2);
}

#avatar{
width:130px;
height:130px;
border-radius:50%;
object-fit:cover;
border:3px solid white;
margin-bottom:10px;
box-shadow:0 0 20px #ff4d6d;
}

input{
width:100%;
padding:10px;
margin-top:8px;
border:none;
border-radius:10px;
outline:none;
}

button{
margin-top:10px;
padding:10px;
border:none;
border-radius:50px;
background:white;
color:#ff4d6d;
font-weight:bold;
cursor:pointer;
transition:0.3s;
}

button:hover{transform:scale(1.05)}

#msg{
display:none;
margin-top:15px;
line-height:1.6;
animation:fade 1s ease;
}

@keyframes fade{
from{opacity:0;transform:translateY(10px)}
to{opacity:1;transform:translateY(0)}
}

.heart{
position:absolute;
top:-10px;
color:#ff4d6d;
animation:fall 6s linear infinite;
}

@keyframes fall{
0%{transform:translateY(-10px);opacity:1}
100%{transform:translateY(110vh);opacity:0}
}

.glow{
animation:glow 2s infinite alternate;
}

@keyframes glow{
from{box-shadow:0 0 10px #fff}
to{box-shadow:0 0 30px #ff4d6d}
}
</style>
</head>

<body>

<div class="card">

<img id="avatar" class="glow" src="https://i.ibb.co/4wLrTx5H.jpg">

<h2>💖 Gửi người thương</h2>

<input id="name" placeholder="Tên người ấy">
<input id="pass" placeholder="Mật khẩu">

<button onclick="openLove()">Mở thư 💌</button>

<div id="msg">
<h3 id="txt"></h3>
<p>
💞 Có những người xuất hiện không phải để ở lại thoáng qua,<br>
mà là để làm tim mình “bận rộn cả một thời gian dài”.<br><br>

Nếu cậu đọc được cái này…<br>
thì chắc là cậu quan trọng hơn tớ nghĩ rồi 💖
</p>
</div>

</div>

<audio id="music" loop>
<source src="https://cdn.pixabay.com/download/audio/2022/03/15/audio_5c6b6f2d6d.mp3">
</audio>

<script>
let music=document.getElementById("music");

function openLove(){
let name=document.getElementById("name").value;
let pass=document.getElementById("pass").value;

if(pass!=="yeuem"){
alert("Sai mật khẩu rồi 😏");
return;
}

document.getElementById("txt").innerText="Gửi "+name+" 💖";
document.getElementById("msg").style.display="block";

music.play();
}

// tim bay sến
setInterval(()=>{
let h=document.createElement("div");
h.innerHTML="💖";
h.className="heart";
h.style.left=Math.random()*window.innerWidth+"px";
h.style.fontSize=(10+Math.random()*20)+"px";
document.body.appendChild(h);

setTimeout(()=>h.remove(),6000);
},200);
</script>

</body>
</html>
