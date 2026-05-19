<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Van Dat Bio</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
}

body{
background:#09090f;
font-family:'DM Sans',sans-serif;
color:white;
display:flex;
justify-content:center;
padding:40px 20px;
}

.bio{
width:100%;
max-width:430px;
display:flex;
flex-direction:column;
gap:18px;
}

/* PROFILE */

.profile{
background:#111118;
border:1px solid #232334;
border-radius:30px;
padding:35px 25px;
text-align:center;
}

.profile img{
width:120px;
height:120px;
border-radius:50%;
object-fit:cover;
border:4px solid #c9a84c;
margin-bottom:18px;
box-shadow:0 0 30px rgba(201,168,76,.35);
}

.profile h1{
font-size:2rem;
margin-bottom:10px;
}

.profile p{
color:#9a9ab0;
line-height:1.7;
font-size:.95rem;
}

/* BUTTON */

.link{
padding:18px 20px;
border-radius:24px;
text-decoration:none;
display:flex;
align-items:center;
gap:15px;
transition:.25s;
color:white;
font-weight:700;
}

.link:hover{
transform:translateY(-4px);
}

.link img{
width:52px;
height:52px;
border-radius:16px;
background:white;
padding:8px;
}

/* COLORS */

.discord{
background:linear-gradient(135deg,#5865F2,#4752C4);
}

.github{
background:linear-gradient(135deg,#1f1f28,#2c2c3d);
}

.client{
background:linear-gradient(135deg,#3b82f6,#2563eb);
}

.website{
background:linear-gradient(135deg,#00b894,#00cec9);
}

.link-title{
font-size:1rem;
}

.link-desc{
font-size:.82rem;
opacity:.8;
font-weight:400;
margin-top:3px;
}

</style>
</head>
<body>

<div class="bio">

<!-- PROFILE -->

<div class="profile">

<img
src="https://i.ibb.co/ZR6FqsxW/6073.jpg"
alt="Van Dat"
>

<h1>
Van Dat
</h1>

<p>
Full Stack Developer 🇻🇳<br>
Minecraft Creator<br>
Premium Website Designer
</p>

</div>

<!-- DISCORD -->

<a
href="https://discord.gg/ahxDyZNgec"
target="_blank"
class="link discord"
>

<img
src="https://cdn-icons-png.flaticon.com/512/2111/2111370.png"
>

<div>

<div class="link-title">
Discord Server
</div>

<div class="link-desc">
Join community
</div>

</div>

</a>

<!-- GITHUB -->

<a
href="https://github.com/vandatvncode"
target="_blank"
class="link github"
>

<img
src="https://cdn-icons-png.flaticon.com/512/25/25231.png"
>

<div>

<div class="link-title">
GitHub
</div>

<div class="link-desc">
View repositories
</div>

</div>

</a>

<!-- CLIENT -->

<a
href="https://www.lunarclient.com/"
target="_blank"
class="link client"
>

<img
src="https://cdn-icons-png.flaticon.com/512/5968/5968705.png"
>

<div>

<div class="link-title">
Lunar Client
</div>

<div class="link-desc">
Best FPS Client
</div>

</div>

</a>

<!-- WEBSITE -->

<a
href="https://google.com/"
target="_blank"
class="link website"
>

<img
src="https://cdn-icons-png.flaticon.com/512/1006/1006771.png"
>

<div>

<div class="link-title">
Website
</div>

<div class="link-desc">
Visit my website
</div>


<!-- NÚT CHA + NÚT CON -->

<style>

.dropdown{
display:flex;
flex-direction:column;
gap:12px;
}

.parent-btn{
background:linear-gradient(135deg,#5865F2,#4752C4);
padding:18px 20px;
border-radius:24px;
display:flex;
align-items:center;
justify-content:space-between;
cursor:pointer;
font-weight:700;
color:white;
}

.child-box{
display:none;
flex-direction:column;
gap:12px;
padding-left:15px;
}

.child-btn{
background:#1a1a24;
border:1px solid #2d2d3d;
padding:16px 18px;
border-radius:18px;
text-decoration:none;
color:white;
font-weight:600;
transition:.25s;
}

.child-btn:hover{
transform:translateX(6px);
border-color:#5865F2;
}

</style>

<!-- DROPDOWN -->

<div class="dropdown">

<!-- NÚT CHA -->

<div class="parent-btn" onclick="toggleMenu()">

<span>
🎮 Minecraft Clients
</span>

<span id="arrow">
▼
</span>

</div>

<!-- NÚT CON -->

<div class="child-box" id="menu">

<a
href="https://www.lunarclient.com/"
target="_blank"
class="child-btn"
>
🌙 Lunar Client
</a>

<a
href="https://feathermc.com/"
target="_blank"
class="child-btn"
>
🪶 Feather Client
</a>

<a
href="https://www.badlion.net/"
target="_blank"
class="child-btn"
>
🛡 Badlion Client
</a>

</div>

</div>

<script>

function toggleMenu(){

const menu =
document.getElementById("menu");

const arrow =
document.getElementById("arrow");

if(menu.style.display==="flex"){

menu.style.display="none";
arrow.innerHTML="▼";

}else{

menu.style.display="flex";
arrow.innerHTML="▲";

}

}

</script>

</div>

</a>

</div>

</body>
</html>
