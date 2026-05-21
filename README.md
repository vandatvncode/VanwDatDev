<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>FF Sensitivity Pro ⚡</title>

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
    max-width:900px;
    margin:auto;
}

.title{
    text-align:center;
    font-size:35px;
    font-weight:700;
    color:#ffcc00;
}

.sub{
    text-align:center;
    color:#999;
    margin-top:5px;
    margin-bottom:30px;
}

.search{
    width:100%;
    padding:15px;
    border:none;
    outline:none;
    border-radius:15px;
    background:#1b1b1b;
    color:white;
    font-size:16px;
    margin-bottom:15px;
}

.search::placeholder{
    color:#777;
}

select{
    width:100%;
    padding:15px;
    border:none;
    outline:none;
    border-radius:15px;
    background:#1b1b1b;
    color:white;
    font-size:16px;
    margin-bottom:25px;
}

.card{
    background:#181818;
    border-radius:20px;
    padding:25px;
    box-shadow:0 0 20px rgba(255,204,0,0.15);
    animation:show .4s ease;
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
    font-weight:500;
    color:#ddd;
}

.value{
    font-weight:700;
    color:#ffcc00;
}

.btn{
    width:100%;
    margin-top:20px;
    padding:15px;
    border:none;
    border-radius:15px;
    background:linear-gradient(45deg,#ffcc00,#ff8800);
    color:black;
    font-size:16px;
    font-weight:700;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    transform:scale(1.02);
}

.footer{
    text-align:center;
    margin-top:25px;
    color:#666;
    font-size:14px;
}

</style>
</head>
<body>

<div class="container">

    <div class="title">🎯 FF SENSITIVITY PRO</div>
    <div class="sub">
        Độ nhạy Free Fire • Full dòng máy ⚡
    </div>

    <input 
    type="text"
    id="searchDevice"
    class="search"
    placeholder="🔍 Nhập tên máy..."
    onkeyup="filterDevices()"
    >

    <select id="device" onchange="showSensitivity()">

        <option value="">-- Chọn dòng máy --</option>

        <optgroup label="🍎 iPhone">
            <option value="iphone6">iPhone 6</option>
            <option value="iphone7">iPhone 7</option>
            <option value="iphone8">iPhone 8</option>
            <option value="iphoneX">iPhone X</option>
            <option value="iphone11">iPhone 11</option>
            <option value="iphone12">iPhone 12</option>
            <option value="iphone13">iPhone 13</option>
            <option value="iphone14">iPhone 14</option>
            <option value="iphone15">iPhone 15</option>
        </optgroup>

        <optgroup label="📱 Samsung">
            <option value="a05">Samsung A05</option>
            <option value="a06">Samsung A06</option>
            <option value="a05s">Samsung A05s</option>
            <option value="a14">Samsung A14</option>
            <option value="a15">Samsung A15</option>
            <option value="a24">Samsung A24</option>
            <option value="a34">Samsung A34</option>
            <option value="a54">Samsung A54</option>
            <option value="s21">Samsung S21</option>
            <option value="s22">Samsung S22</option>
            <option value="s23">Samsung S23</option>
        </optgroup>

        <optgroup label="🔥 Xiaomi / Redmi">
            <option value="redmi9">Redmi 9</option>
            <option value="redmi10">Redmi 10</option>
            <option value="redmi12">Redmi 12</option>
            <option value="note11">Redmi Note 11</option>
            <option value="note12">Redmi Note 12</option>
            <option value="pocoX3">POCO X3</option>
            <option value="pocoF5">POCO F5</option>
        </optgroup>

        <optgroup label="💚 OPPO">
            <option value="oppoA3s">OPPO A3s</option>
            <option value="oppoA5">OPPO A5</option>
            <option value="oppoA15">OPPO A15</option>
            <option value="oppoA57">OPPO A57</option>
            <option value="oppoReno8">OPPO Reno8</option>
        </optgroup>

        <optgroup label="⚡ Realme">
            <option value="realmeC11">Realme C11</option>
            <option value="realmeC35">Realme C35</option>
            <option value="realme8">Realme 8</option>
            <option value="realme11">Realme 11</option>
        </optgroup>

        <optgroup label="🔵 Vivo">
            <option value="vivoY12">Vivo Y12</option>
            <option value="vivoY20">Vivo Y20</option>
            <option value="vivoY22">Vivo Y22</option>
            <option value="vivoV27">Vivo V27</option>
        </optgroup>

        <optgroup label="🎮 ASUS ROG">
            <option value="rog5">ROG Phone 5</option>
            <option value="rog6">ROG Phone 6</option>
            <option value="rog7">ROG Phone 7</option>
        </optgroup>

    </select>

    <div class="card" id="result">

        <div class="row">
            <div class="label">🎯 Tổng Quan</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">🔴 Red Dot</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">🟡 2x Scope</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">🟢 4x Scope</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">🟣 AWM Scope</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">⚡ Free Look</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">🔥 Nút Bắn</div>
            <div class="value">-</div>
        </div>

        <div class="row">
            <div class="label">📡 DPI</div>
            <div class="value">-</div>
        </div>

        <button class="btn" onclick="randomSensitivity()">
            RANDOM ĐỘ NHẠY 🔥
        </button>

    </div>

    <div class="footer">
        Made by VanDatDev ⚡
    </div>

</div>

<script>

const data = {

    iphone11:{
        general:200,
        red:200,
        x2:195,
        x4:185,
        awm:160,
        free:200,
        fire:"58%",
        dpi:800
    },

    iphone12:{
        general:200,
        red:200,
        x2:198,
        x4:188,
        awm:165,
        free:200,
        fire:"60%",
        dpi:820
    },

    iphone13:{
        general:200,
        red:200,
        x2:200,
        x4:190,
        awm:170,
        free:200,
        fire:"62%",
        dpi:850
    },

    iphone14:{
        general:200,
        red:200,
        x2:200,
        x4:192,
        awm:175,
        free:200,
        fire:"64%",
        dpi:880
    },

    iphone15:{
        general:200,
        red:200,
        x2:200,
        x4:195,
        awm:180,
        free:200,
        fire:"66%",
        dpi:900
    },

    a05:{
        general:200,
        red:198,
        x2:190,
        x4:180,
        awm:155,
        free:200,
        fire:"48%",
        dpi:650
    },

    a06:{
        general:198,
        red:195,
        x2:188,
        x4:178,
        awm:152,
        free:198,
        fire:"47%",
        dpi:640
    },

    a54:{
        general:200,
        red:200,
        x2:198,
        x4:190,
        awm:168,
        free:200,
        fire:"56%",
        dpi:780
    },

    s23:{
        general:200,
        red:200,
        x2:200,
        x4:196,
        awm:180,
        free:200,
        fire:"65%",
        dpi:900
    },

    note12:{
        general:200,
        red:200,
        x2:194,
        x4:184,
        awm:160,
        free:200,
        fire:"54%",
        dpi:740
    },

    pocoF5:{
        general:200,
        red:200,
        x2:200,
        x4:192,
        awm:170,
        free:200,
        fire:"61%",
        dpi:850
    },

    oppoReno8:{
        general:200,
        red:198,
        x2:192,
        x4:184,
        awm:160,
        free:200,
        fire:"55%",
        dpi:760
    },

    realme11:{
        general:200,
        red:200,
        x2:194,
        x4:186,
        awm:162,
        free:200,
        fire:"57%",
        dpi:780
    },

    vivoV27:{
        general:200,
        red:198,
        x2:192,
        x4:184,
        awm:160,
        free:200,
        fire:"56%",
        dpi:760
    },

    rog7:{
        general:200,
        red:200,
        x2:200,
        x4:200,
        awm:190,
        free:200,
        fire:"75%",
        dpi:1100
    }

};

function showSensitivity(){

    const device = document.getElementById("device").value;

    if(!device) return;

    const d = data[device];

    document.getElementById("result").innerHTML = `

    <div class="row">
        <div class="label">🎯 Tổng Quan</div>
        <div class="value">${d.general}</div>
    </div>

    <div class="row">
        <div class="label">🔴 Red Dot</div>
        <div class="value">${d.red}</div>
    </div>

    <div class="row">
        <div class="label">🟡 2x Scope</div>
        <div class="value">${d.x2}</div>
    </div>

    <div class="row">
        <div class="label">🟢 4x Scope</div>
        <div class="value">${d.x4}</div>
    </div>

    <div class="row">
        <div class="label">🟣 AWM Scope</div>
        <div class="value">${d.awm}</div>
    </div>

    <div class="row">
        <div class="label">⚡ Free Look</div>
        <div class="value">${d.free}</div>
    </div>

    <div class="row">
        <div class="label">🔥 Nút Bắn</div>
        <div class="value">${d.fire}</div>
    </div>

    <div class="row">
        <div class="label">📡 DPI</div>
        <div class="value">${d.dpi}</div>
    </div>

    <button class="btn" onclick="randomSensitivity()">
        RANDOM ĐỘ NHẠY 🔥
    </button>

    `;
}

function randomSensitivity(){

    const random = () => Math.floor(Math.random() * 51) + 150;

    document.getElementById("result").innerHTML = `

    <div class="row">
        <div class="label">🎯 Tổng Quan</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">🔴 Red Dot</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">🟡 2x Scope</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">🟢 4x Scope</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">🟣 AWM Scope</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">⚡ Free Look</div>
        <div class="value">${random()}</div>
    </div>

    <div class="row">
        <div class="label">🔥 Nút Bắn</div>
        <div class="value">${Math.floor(Math.random()*30)+45}%</div>
    </div>

    <div class="row">
        <div class="label">📡 DPI</div>
        <div class="value">${Math.floor(Math.random()*500)+500}</div>
    </div>

    <button class="btn" onclick="randomSensitivity()">
        RANDOM LẠI 🔥
    </button>

    `;
}

function filterDevices(){

    let input = document.getElementById("searchDevice");
    let filter = input.value.toLowerCase();

    let select = document.getElementById("device");
    let options = select.getElementsByTagName("option");

    for(let i = 0; i < options.length; i++){

        let txt = options[i].textContent || options[i].innerText;

        if(txt.toLowerCase().indexOf(filter) > -1){
            options[i].style.display = "";
        }else{
            options[i].style.display = "none";
        }

    }

}

</script>

</body>
</html>
