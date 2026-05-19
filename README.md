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
    min-height:100vh;
    background:linear-gradient(135deg,#ff758c,#ff7eb3);
    overflow-x:hidden;
    color:white;
}

.container{
    width:100%;
    max-width:1000px;
    margin:auto;
    padding:40px 20px;
    text-align:center;
}

h1{
    font-size:55px;
    margin-bottom:10px;
}

.text{
    font-size:18px;
    opacity:0.9;
    margin-bottom:35px;
}

.gallery{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
}

.card{
    background:rgba(255,255,255,0.12);
    backdrop-filter:blur(10px);
    border-radius:25px;
    overflow:hidden;
    transition:0.4s;
    border:1px solid rgba(255,255,255,0.2);
}

.card:hover{
    transform:translateY(-10px) scale(1.03);
    box-shadow:0 0 30px rgba(255,255,255,0.3);
}

.card img{
    width:100%;
    height:320px;
    object-fit:cover;
}

.card p{
    padding:15px;
    font-size:16px;
}

.btn{
    margin-top:35px;
    padding:14px 35px;
    border:none;
    border-radius:40px;
    background:white;
    color:#ff4f81;
    font-size:17px;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
}

.btn:hover{
    transform:scale(1.08);
}

.heart{
    position:fixed;
    top:-10px;
    color:white;
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

    <h1>Quỳnh Anh 💖</h1>

    <div class="text">
        I Love You So much✨
    </div>

    <div class="gallery">

        <div class="card">
            <a href="https://ibb.co/Xr3GzHDG" target="_blank">
                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">
            </a>
            <p>My favorite person 💕</p>
        </div>

        <div class="card">
            <a href="https://ibb.co/Kx8g83kR" target="_blank">
                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">
            </a>
            <p>Pretty girl ✨</p>
        </div>

        <div class="card">
            <a href="https://ibb.co/7JSHXT8X" target="_blank">
                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">
            </a>
            <p>Cutest smile 🌸</p>
        </div>

        <div class="card">
            <a href="https://ibb.co/tpBbphYd" target="_blank">
                <img src="https://i.ibb.co/ZR6FqsxW/6073.jpg">
            </a>
            <p>Forever 💖</p>
        </div>

    </div>

    <button class="btn" onclick="love()">
        Bấm vào đây 💌
    </button>

</div>

<script>

function love(){
    alert("Anh iu Quỳnh Anh nhiều lém 💖");
}

for(let i=0;i<60;i++){

    let heart=document.createElement("div");

    heart.className="heart";
    heart.innerHTML="❤";

    heart.style.left=Math.random()*100+"vw";
    heart.style.fontSize=(Math.random()*25+10)+"px";
    heart.style.animationDuration=(Math.random()*5+3)+"s";

    document.body.appendChild(heart);
}
</script>

</body>
</html>
