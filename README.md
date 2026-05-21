<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FF Sensitivity AI ⚡</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#0f0f0f;
    color:white;
    min-height:100vh;
    padding:20px;
}

.container{
    max-width:1000px;
    margin:auto;
}

.title{
    text-align:center;
    font-size:38px;
    font-weight:700;
    color:#ffcc00;
}

.sub{
    text-align:center;
    color:#888;
    margin-top:5px;
    margin-bottom:25px;
}

.search{
    width:100%;
    padding:16px;
    border:none;
    outline:none;
    border-radius:16px;
    background:#1b1b1b;
    color:white;
    font-size:16px;
    margin-bottom:20px;
}

.search::placeholder{
    color:#666;
}

.device-list{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
    gap:14px;
}

.device{
    background:#1b1b1b;
    border-radius:18px;
    padding:16px;
    cursor:pointer;
    transition:.3s;
    border:1px solid transparent;
}

.device:hover{
    transform:translateY(-4px);
    border-color:#ffcc00;
}

.device-name{
    font-size:16px;
    font-weight:600;
}

.device-brand{
    color:#888;
    margin-top:4px;
    font-size:13px;
}

.card{
    margin-top:25px;
    background:#181818;
    border-radius:22px;
    padding:24px;
    display:none;
    animation:show .3s ease;
    box-shadow:0 0 25px rgba(255,204,0,.12);
}

@keyframes show{
    from{
        opacity:0;
        transform:translateY(20px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.row{
    display:flex;
    justify-content:space-between;
    align-items:center;
    background:#232323;
    padding:14px;
    border-radius:14px;
    margin:12px 0;
}

.label{
    color:#ddd;
    font-weight:500;
}

.value{
    color:#ffcc00;
    font-weight:700;
}

.footer{
    text-align:center;
    margin-top:25px;
    color:#666;
    font-size:14px;
}

.badge{
    display:inline-block;
    background:#ffcc00;
    color:black;
    padding:5px 10px;
    border-radius:999px;
    font-size:12px;
    font-weight:700;
    margin-top:10px;
}

</style>
</head>
<body>

<div class="container">

    <div class="title">🎯 FF SENSITIVITY AI</div>

    <div class="sub">
        Nhập bất kỳ dòng máy nào để hiện độ nhạy ⚡
    </div>

    <input 
    type="text"
    id="searchInput"
    class="search"
    placeholder="🔍 Ví dụ: iPhone 17 Plus, Samsung A99 Ultra..."
    onkeyup="filterDevices()"
    >

    <div class="device-list" id="deviceList"></div>

    <div class="card" id="result"></div>

    <div class="footer">
        Made by VanDatDev ⚡
    </div>

</div>

<script>

const devices = [

{
name:"iPhone 15 Pro Max",
brand:"Apple"
},

{
name:"iPhone 14 Pro Max",
brand:"Apple"
},

{
name:"Samsung S23 Ultra",
brand:"Samsung"
},

{
name:"Samsung A54",
brand:"Samsung"
},

{
name:"Samsung A24",
brand:"Samsung"
},

{
name:"Redmi Note 12",
brand:"Xiaomi"
},

{
name:"POCO F5",
brand:"Xiaomi"
},

{
name:"ROG Phone 7",
brand:"ASUS"
},

{
name:"OPPO Reno8",
brand:"OPPO"
},

{
name:"Realme 11 Pro",
brand:"Realme"
},

{
name:"Vivo V27",
brand:"Vivo"
},

{
name:"iPad Pro M4",
brand:"Apple"
},

{
name:"Galaxy Tab S9",
brand:"Samsung"
},

{
name:"Black Shark 5",
brand:"Black Shark"
},

{
name:"Red Magic 9 Pro",
brand:"Nubia"
}

];

const deviceList = document.getElementById("deviceList");

function renderDevices(list){

    deviceList.innerHTML = "";

    list.forEach(device=>{

        deviceList.innerHTML += `

        <div class="device"
        onclick='createCustomDevice("${device.name}")'>

            <div class="device-name">
                ${device.name}
            </div>

            <div class="device-brand">
                ${device.brand}
            </div>

        </div>

        `;

    });

}

renderDevices(devices);

function filterDevices(){

    const input = document.getElementById("searchInput").value.toLowerCase();

    const filtered = devices.filter(device =>
        device.name.toLowerCase().includes(input)
    );

    renderDevices(filtered);

    if(filtered.length === 0 && input.trim() !== ""){

        deviceList.innerHTML = `

        <div class="device"
        onclick="createCustomDevice('${input}')">

            <div class="device-name">
                🔍 ${input}
            </div>

            <div class="device-brand">
                Bấm để tạo độ nhạy AI
            </div>

            <div class="badge">
                AI GENERATED
            </div>

        </div>

        `;

    }

}

function createCustomDevice(name){

    const lower = name.toLowerCase();

    let base = 190;
    let dpi = 700;
    let fire = 50;

    if(lower.includes("iphone")){

        base = 200;
        dpi = 900;
        fire = 65;

    }else if(
        lower.includes("rog") ||
        lower.includes("red magic") ||
        lower.includes("black shark")
    ){

        base = 200;
        dpi = 1100;
        fire = 75;

    }else if(
        lower.includes("samsung") ||
        lower.includes("xiaomi") ||
        lower.includes("poco")
    ){

        base = 198;
        dpi = 850;
        fire = 60;

    }

    const device = {

        name:name.toUpperCase(),

        general:base,

        red:base,

        x2:base - 5,

        x4:base - 10,

        awm:base - 25,

        free:200,

        fire:fire + "%",

        dpi:dpi

    };

    showDevice(device);

}

function showDevice(device){

    document.getElementById("result").style.display = "block";

    document.getElementById("result").innerHTML = `

    <div class="row">
        <div class="label">📱 Thiết bị</div>
        <div class="value">${device.name}</div>
    </div>

    <div class="row">
        <div class="label">🎯 Tổng Quan</div>
        <div class="value">${device.general}</div>
    </div>

    <div class="row">
        <div class="label">🔴 Red Dot</div>
        <div class="value">${device.red}</div>
    </div>

    <div class="row">
        <div class="label">🟡 2x Scope</div>
        <div class="value">${device.x2}</div>
    </div>

    <div class="row">
        <div class="label">🟢 4x Scope</div>
        <div class="value">${device.x4}</div>
    </div>

    <div class="row">
        <div class="label">🟣 AWM Scope</div>
        <div class="value">${device.awm}</div>
    </div>

    <div class="row">
        <div class="label">⚡ Free Look</div>
        <div class="value">${device.free}</div>
    </div>

    <div class="row">
        <div class="label">🔥 Nút Bắn</div>
        <div class="value">${device.fire}</div>
    </div>

    <div class="row">
        <div class="label">📡 DPI</div>
        <div class="value">${device.dpi}</div>
    </div>

    <div class="badge">
        AI SENSITIVITY SYSTEM ⚡
    </div>

    `;

}

</script>

</body>
</html>
