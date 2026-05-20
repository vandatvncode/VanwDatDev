<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>For You 💖</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    font-family:Poppins;
    box-sizing:border-box;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    overflow:hidden;
    background: linear-gradient(135deg,#ff6b6b,#ffb6c1,#6a5acd);
}

/* CARD */
.card{
    width:90%;
    max-width:420px;
    padding:25px;
    border-radius:20px;
    background: rgba(0,0,0,0.35);
    backdrop-filter: blur(10px);
    text-align:center;
    color:white;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
}

/* AVATAR */
#avatar{
    width:120px;
    height:120px;
    border-radius:50%;
    object-fit:cover;
    border:3px solid white;
    margin-bottom:15px;
    box-shadow:0 0 20px #fff;
    animation: glow 2s infinite alternate;
}

@keyframes glow{
    from{box-shadow:0 0 10px #fff;}
    to{box-shadow:0 0 25px #ff4d6d;}
}

/* INPUT */
input{
    width:100%;
    padding:10px;
    margin-top:10px;
    border:none;
    border-radius:10px;
    outline:none;
}

/* BUTTON */
button{
    margin-top:12px;
    padding:10px 15px;
    border:none;
    border-radius:50px;
    background:white;
    color:#ff4d6d;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    transform:scale(1.05);
}

/* MESSAGE */
.message{
    display:none;
    margin-top:15px;
    line-height:1.6;
}

/* HEART */
.heart{
    position:absolute;
    top:-10px;
    color:red;
    animation: fall 6s linear infinite;
}

@keyframes fall{
    0%{transform:translateY(-10px);opacity:1;}
    100%{transform:translateY(110vh);opacity:0;}
}

/* FIREWORK */
.firework{
    position:absolute;
    width:6px;
    height:6px;
    background:white;
    border-radius:50%;
    animation: explode 1s ease-out forwards;
}

@keyframes explode{
    0%{transform:scale(1);opacity:1;}
    100%{transform:scale(25);opacity:0;}
}
</style>
</head>

<body>

<div class="card">

    <!-- ẢNH CRUSH -->
    <img id="avatar" src="LINK_ẢNH_CỦA_BẠN">

    <h2>💖 Gửi người tớ thương</h2>

    <input id="name" placeholder="Tên người ấy 💌">
    <input id="pass" placeholder="Mật khẩu 🔐">

    <button onclick="openLetter()">Mở thư 💞</button>

    <button onclick="toggleMusic()">🎵 Nhạc</button>

    <div class="message" id="msg">
        <h3 id="loveName"></h3>
        <p>
            Cậu biết không... 💖<br><br>
            Tớ thích cậu nhiều hơn những gì tớ dám nói.<br>
            Nếu cậu đang đọc cái này,<br>
            nghĩa là cậu đặc biệt lắm 🫶
        </p>
    </div>
</div>

<!-- NHẠC -->
<audio id="music" loop>
    <source src="https://cdn.pixabay.com/download/audio/2022/03/15/audio_5c6b6f2d6d.mp3?filename=soft-piano-ambient-110397.mp3">
</audio>

<script>
let music = document.getElementById("music");

// mở thư
function openLetter(){
    let name = document.getElementById("name").value;
    let pass = document.getElementById("pass").value;

    if(pass !== "yeuem"){
        alert("Sai mật khẩu 😏");
        return;
    }

    document.getElementById("loveName").innerText = "Gửi " + name + " 💖";
    document.getElementById("msg").style.display = "block";

    firework();
}

// nhạc
function toggleMusic(){
    if(music.paused) music.play();
    else music.pause();
}

// tim rơi
function createHeart(){
    const heart = document.createElement("div");
    heart.classList.add("heart");
    heart.innerHTML = "❤️";
    heart.style.left = Math.random() * window.innerWidth + "px";
    heart.style.fontSize = (10 + Math.random()*20) + "px";
    heart.style.animationDuration = (3 + Math.random()*3) + "s";
    document.body.appendChild(heart);

    setTimeout(()=>heart.remove(),6000);
}
setInterval(createHeart,200);

// pháo hoa
function firework(){
    for(let i=0;i<25;i++){
        const fw = document.createElement("div");
        fw.classList.add("firework");
        fw.style.left = Math.random()*window.innerWidth + "px";
        fw.style.top = Math.random()*window.innerHeight + "px";
        document.body.appendChild(fw);

        setTimeout(()=>fw.remove(),1000);
    }
}
</script>

</body>
</html>
