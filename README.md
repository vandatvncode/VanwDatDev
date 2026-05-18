<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Get Key System</title>

<style>
body{
  background:#0f0f14;
  color:white;
  font-family:Arial;
  display:flex;
  justify-content:center;
  align-items:center;
  height:100vh;
}

.box{
  background:#181820;
  padding:30px;
  border-radius:20px;
  width:320px;
  text-align:center;
  border:1px solid #2a2a3a;
}

input{
  width:100%;
  padding:12px;
  margin-top:15px;
  border:none;
  border-radius:10px;
  background:#101018;
  color:white;
}

button{
  width:100%;
  padding:12px;
  margin-top:15px;
  border:none;
  border-radius:10px;
  background:#4f8ef7;
  color:white;
  font-weight:bold;
  cursor:pointer;
}

#content{
  display:none;
  margin-top:20px;
  color:#3dd68c;
}
</style>
</head>
<body>

<div class="box">

<h2>GET KEY SYSTEM</h2>

<p id="keyText"></p>

<input type="text" id="keyInput" placeholder="Nhập key">

<button onclick="checkKey()">
Xác Nhận
</button>

<div id="content">
✅ Key hợp lệ trong 1 ngày
</div>

</div>

<script>

let savedKey = localStorage.getItem("myKey");
let expire = localStorage.getItem("expireTime");

if(!savedKey || Date.now() > expire){

  savedKey = "VD-" + Math.random().toString(36).substring(2,10).toUpperCase();

  expire = Date.now() + 86400000;

  localStorage.setItem("myKey", savedKey);
  localStorage.setItem("expireTime", expire);

}

document.getElementById("keyText").innerHTML =
"Key hôm nay:<br><b>" + savedKey + "</b>";

function checkKey(){

  let input = document.getElementById("keyInput").value;

  if(Date.now() > expire){

    alert("Key đã hết hạn!");

    return;

  }

  if(input === savedKey){

    document.getElementById("content").style.display = "block";

  }else{

    alert("Sai key!");

  }

}

</script>

</body>
</html>
