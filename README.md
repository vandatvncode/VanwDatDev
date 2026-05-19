<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>For Quỳnh Anh 💖</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#ff9a9e,#fad0c4);
    overflow:hidden;
}

.card{
    width:350px;
    padding:25px;
    border-radius:25px;
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(10px);
    text-align:center;
    color:white;
    box-shadow:0 10px 30px rgba(0,0,0,0.2);
}

.card img{
    width:150px;
    height:150px;
    object-fit:cover;
    border-radius:20px;
    border:4px solid white;
    margin-bottom:15px;
    animation:float 3s ease-in-out infinite;
}

h1{
    font-size:32px;
}

p{
    margin-top:12px;
    line-height:1.6;
    font-size:17px;
}

button{
    margin-top:20px;
    padding:12px 25px;
    border:none;
    border-radius:30px;
    background:white;
    color:#ff4b7d;
    font-weight:bold;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    transform:scale(1.1);
    background:#ff4b7d;
    color:white;
}

@keyframes float{
    0%{transform:translateY(0);}
    50%{transform:translateY(-8px);}
    100%{transform:translateY(0);}
}

.heart{
    position:absolute;
    color:white;
    animation:fall linear infinite;
}

@keyframes fall{
    to{
        transform:translateY(110vh);
    }
}
</style>
</head>

<body>

<div class="card">

    <!-- ẢNH -->
    <img src="https://i.pinimg.com/736x/6e/78/91/6e789174e0bfb60ff6bbf0f9e4d4cb6c.jpg">

    <h1>Quỳnh Anh 💖</h1>

    <p>
        Chúc em luôn vui vẻ, đáng yêu<br>
        và hạnh phúc mỗi ngày ✨
    </p>

    <button onclick="love()">
        Bấm vào đây 💌
    </button>

</div>

<script>
function love(){
    alert("Anh thương Quỳnh Anh nhiều lắm 💖");
}

for(let i=0;i<35;i++){
    let heart=document.createElement("div");
    heart.className="heart";
    heart.innerHTML="❤";

    heart.style.left=Math.random()*100+"vw";
    heart.style.fontSize=(Math.random()*20+15)+"px";
    heart.style.animationDuration=(Math.random()*5+3)+"s";
    heart.style.top="-20px";

    document.body.appendChild(heart);
}
</script>

</body>
</html>
