<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Gaming Profile ⚡</title>

<link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@500;700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background:#05060f;
    color:white;
    font-family:'Poppins',sans-serif;
    overflow-x:hidden;
}

/* BACKGROUND EFFECT */
.bg{
    position:fixed;
    inset:0;
    background:
    radial-gradient(circle at 20% 20%, #7c3aed55, transparent 40%),
    radial-gradient(circle at 80% 30%, #22d3ee55, transparent 40%),
    radial-gradient(circle at 50% 80%, #2563eb55, transparent 40%);
    z-index:-2;
}

/* GRID */
.grid{
    position:fixed;
    inset:0;
    background-image:
    linear-gradient(rgba(255,255,255,.05) 1px, transparent 1px),
    linear-gradient(90deg, rgba(255,255,255,.05) 1px, transparent 1px);
    background-size:45px 45px;
    z-index:-1;
}

/* CONTAINER */
.container{
    max-width:500px;
    margin:auto;
    padding:40px 20px;
    text-align:center;
}

/* CARD */
.card{
    background:rgba(255,255,255,0.06);
    border:1px solid rgba(255,255,255,0.1);
    backdrop-filter:blur(12px);
    border-radius:30px;
    padding:25px;
    box-shadow:0 0 40px rgba(0,0,0,0.4);
}

/* AVATAR */
.avatar{
    width:140px;
    height:140px;
    border-radius:50%;
    object-fit:cover;
    border:4px solid #22d3ee;
    box-shadow:0 0 25px #22d3ee;
}

/* NAME */
h1{
    margin-top:15px;
    font-family:'Orbitron',sans-serif;
    font-size:32px;
}

/* TAG */
.tag{
    display:inline-block;
    margin-top:10px;
    padding:6px 15px;
    border-radius:20px;
    background:#22d3ee22;
    border:1px solid #22d3ee55;
    font-size:13px;
}

/* INFO */
.info{
    margin-top:18px;
    font-size:14px;
    color:#ccc;
    line-height:1.6;
}

/* BUTTON */
.btn{
    margin-top:22px;
    padding:12px 25px;
    border:none;
    border-radius:25px;
    background:linear-gradient(45deg,#22d3ee,#3b82f6);
    color:white;
    font-weight:700;
    cursor:pointer;
    transition:0.3s;
}

.btn:hover{
    transform:scale(1.08);
    box-shadow:0 0 20px #22d3ee;
}

/* STATS */
.stats{
    display:flex;
    justify-content:space-between;
    margin-top:25px;
    gap:10px;
}

.box{
    flex:1;
    padding:12px;
    border-radius:18px;
    background:rgba(255,255,255,0.05);
    border:1px solid rgba(255,255,255,0.08);
}

.box h2{
    font-size:18px;
    color:#22d3ee;
}

.box p{
    font-size:12px;
    color:#aaa;
}

/* FLOAT HEART */
.heart{
    position:fixed;
    top:-10px;
    color:#22d3ee;
    animation:fall linear infinite;
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
<div class="grid"></div>

<div class="container">

    <div class="card">

        <img class="avatar"
        src="https://i.ibb.co/ZR6FqsxW/6073.jpg">

        <h1>YOUR NAME ⚡</h1>

        <div class="tag">GAMER PROFILE</div>

        <div class="info">
            Welcome to my gaming profile 🔥<br>
            I play chill, I play fun, I play life 🎮
        </div>

        <button class="btn" onclick="clickMe()">
            Click Me ⚡
        </button>

        <div class="stats">

            <div class="box">
                <h2>999+</h2>
                <p>Wins</p>
            </div>

            <div class="box">
                <h2>Pro</h2>
                <p>Rank</p>
            </div>

            <div class="box">
                <h2>24/7</h2>
                <p>Online</p>
            </div>

        </div>

    </div>

</div>

<script>

function clickMe(){
    alert("GG 😎 bạn đã bấm nút gaming!");
}

for(let i=0;i<60;i++){

    let heart=document.createElement("div");

    heart.className="heart";
    heart.innerHTML="⚡";

    heart.style.left=Math.random()*100+"vw";
    heart.style.fontSize=(Math.random()*18+10)+"px";
    heart.style.animationDuration=(Math.random()*5+3)+"s";

    document.body.appendChild(heart);
}

</script>

</body>
</html>
