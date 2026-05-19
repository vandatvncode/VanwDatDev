<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quỳnh Anh 💖</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#0f0f0f;
    overflow-x:hidden;
    color:white;
}

/* BACKGROUND */
.bg{
    position:fixed;
    inset:0;
    background:
    linear-gradient(rgba(0,0,0,.6),rgba(0,0,0,.6)),
    url('https://i.ibb.co/ZR6FqsxW/6073.jpg') center/cover;
    filter:blur(10px);
    transform:scale(1.1);
    z-index:-2;
}

.container{
    max-width:1200px;
    margin:auto;
    padding:50px 20px;
}

/* TITLE */
.title{
    text-align:center;
    margin-bottom:50px;
}

.title h1{
    font-size:65px;
    font-weight:700;
}

.title p{
    margin-top:10px;
    color:#ddd;
    font-size:18px;
}

/* GRID */
.gallery{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
    gap:25px;
}

/* CARD */
.card{
    position:relative;
    overflow:hidden;
    border-radius:28px;
    background:rgba(255,255,255,.08);
    backdrop-filter:blur(10px);
    border:1px solid rgba(255,255,255,.1);
    transition:.4s;
    box-shadow:0 0 25px rgba(0,0,0,.35);
}

.card:hover{
    transform:translateY(-10px) scale(1.02);
}

/* IMG */
.card img{
    width:100%;
    height:420px;
    object-fit:cover;
    transition:.5s;
}

.card:hover img{
    transform:scale(1.08);
}

/* TEXT */
.info{
    position:absolute;
    bottom:0;
    width:100%;
    padding:18px;
    background:linear-gradient(transparent,rgba(0,0,0,.9));
}

.info h2{
    font-size:24px;
}

.info p{
    font-size:14px;
    color:#ddd;
    margin-top:5px;
}

/* BTN */
.btn{
    margin:45px auto 0;
    display:block;
    padding:15px 40px;
    border:none;
    border-radius:50px;
    background:linear-gradient(45deg,#ff3c78,#ff7ca8);
    color:white;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    transform:scale(1.08);
    box-shadow:0 0 25px #ff4f81;
}

/* HEART */
.heart{
    position:fixed;
    top:-10px;
    color:#ff6b9c;
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

<div class="bg"></div>

<div class="container">

    <div class="title">
        <h1>Quỳnh Anh 💖</h1>
        <p>My favorite person ✨</p>
    </div>

    <div class="gallery">

        <!-- ẢNH 1 -->
        <div class="card">
            <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">
            <div class="info">
                <h2>Pretty Girl 💕</h2>
                <p>Người anh thích nhất.</p>
            </div>
        </div>

        <!-- ẢNH 2 -->
        <div class="card">
            <img src="https://ibb.co/Xr3GzHDG">
            <div class="info">
                <h2>Cutie 🌸</h2>
                <p>Nụ cười làm anh mê.</p>
            </div>
        </div>

        <!-- ẢNH 3 -->
        <div class="card">
            <img src="https://ibb.co/Kx8g83kR">
            <div class="info">
                <h2>Lovely ✨</h2>
                <p>Đặc biệt nhất với anh.</p>
            </div>
        </div>

        <!-- ẢNH 4 -->
        <div class="card">
            <img src="https://ibb.co/7JSHXT8Xg">
            <div class="info">
                <h2>Mine 💖</h2>
                <p>Always beautiful.</p>
            </div>
        </div>

    </div>

    <button class="btn" onclick="love()">
        Bấm vào đây 💌
    </button>

</div>

<script>

function love(){
    alert("Anh thương Quỳnh Anh nhiều lắm 💖");
}

for(let i=0;i<100;i++){

    let heart=document.createElement("div");

    heart.className="heart";
    heart.innerHTML="❤";

    heart.style.left=Math.random()*100+"vw";
    heart.style.fontSize=(Math.random()*22+10)+"px";
    heart.style.animationDuration=(Math.random()*5+3)+"s";

    document.body.appendChild(heart);
}

</script>

</body>
</html>
