<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>D.D.M - 영달 잭팟 VIP</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.2/dist/confetti.browser.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR:wght@400;700;900&display=swap');
        body { font-family: 'Noto Sans KR', sans-serif; background: #000; min-height: 100vh; margin: 0; padding-bottom: 150px; color: white; overflow-x: hidden; }
        #bg-canvas { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; }
        .b-grade-font { font-family: 'Black Han Sans', sans-serif; }

        /* 슬롯 머신 디자인 */
        .slot-machine { width: 380px; height: 550px; background: #111; border: 10px solid #ff9d00; border-radius: 30px; position: relative; overflow: hidden; box-shadow: 0 0 50px rgba(255, 157, 0, 0.3), inset 0 0 30px rgba(0,0,0,1); cursor: pointer; transition: transform 0.3s ease; }
        .slot-machine:hover { transform: scale(1.02); border-color: #ffed00; }

        .slot-container { display: flex; flex-direction: column; transition: transform 3.5s cubic-bezier(0.15, 0, 0.15, 1); }
        .slot-item { width: 100%; height: 550px; flex-shrink: 0; position: relative; background: #222; }
        .slot-item img { width: 100%; height: 100%; object-fit: cover; filter: brightness(0.7); }

        /* 정보창 그라데이션 보강 */
        .restaurant-info { position: absolute; bottom: 0; left: 0; right: 0; padding: 80px 20px 40px; background: linear-gradient(to top, rgba(0,0,0,1) 30%, transparent 100%); text-align: center; }

        .control-panel { position: fixed; bottom: 0; left: 0; right: 0; background: rgba(10, 10, 10, 0.95); backdrop-filter: blur(20px); border-top: 4px solid #ff7e00; padding: 25px 50px; display: flex; align-items: center; justify-content: space-between; z-index: 100; }
        input[type=range] { accent-color: #ff7e00; cursor: pointer; }
    </style>
</head>
<body>

<canvas id="bg-canvas"></canvas>

<header class="text-center py-12">
    <h1 class="text-7xl b-grade-font text-transparent bg-clip-text bg-gradient-to-b from-yellow-300 via-orange-500 to-orange-800 drop-shadow-2xl">영달 잭팟 룰렛</h1>
    <p class="text-orange-400 mt-4 text-xl font-bold tracking-[0.2em]">오늘의 운세는 어떤 맛집인가요?</p>
</header>

<main id="slots-wrapper" class="flex flex-wrap justify-center gap-16 p-10"></main>

<footer class="control-panel">
    <div class="flex items-center gap-10">
        <div class="flex flex-col">
            <span class="text-orange-500 font-black text-xs mb-2 uppercase tracking-widest">Minimum Star Rating</span>
            <div class="flex items-center gap-6">
                <input type="range" id="star-filter" min="1" max="5" step="1" value="3"
                       oninput="document.getElementById('star-val').innerText = this.value">
                <span id="star-val" class="text-4xl b-grade-font text-white w-14">3</span>
            </div>
        </div>
    </div>
    <div class="flex gap-6">
        <button type="button" onclick="addSlot()"
                class="border-2 border-orange-500 text-orange-500 px-8 py-4 rounded-full font-black text-lg hover:bg-orange-500 hover:text-white transition-all">
            슬롯 추가
        </button>
        <button type="button" onclick="spinAll()"
                class="bg-gradient-to-r from-orange-600 to-yellow-500 text-white px-20 py-4 rounded-full font-black text-3xl shadow-[0_0_30px_rgba(234,88,12,0.5)] active:scale-95 transition-all">
            JACKPOT GO!
        </button>
    </div>
</footer>

<script>
/* =========================================================
   1) DB 데이터 → JS (null-safe / 숫자 안전 변환)
========================================================= */
const restaurants = [
  <c:forEach var="store" items="${storeList}" varStatus="status">
  {
    category: "${store.category}",
    name: "${store.storeName}",
    // ✅ null/빈값이면 Number("") => 0 이니까 NaN 방지하려면 아래처럼 처리
    star: (function(v){ v = (v||"").trim(); return v==="" ? 0 : Number(v); })("${store.rating}"),
    reviewCount: (function(v){ v = (v||"").trim(); return v==="" ? 0 : Number(v); })("${store.reviewCount}"),
    img: "${pageContext.request.contextPath}/images/upload/store/${store.storePicture}"
  }${!status.last ? ',' : ''}
  </c:forEach>
];

// 디버깅(필요 없으면 지워도 됨)
console.log("✅ restaurants length =", restaurants.length);

/* =========================================================
   2) 배경 애니메이션 (distance==0 방어)
========================================================= */
const canvas = document.getElementById('bg-canvas');
const ctx = canvas.getContext('2d');
let points = [];
const mouse = { x: null, y: null, radius: 150 };

function resizeCanvas() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
}
window.addEventListener('resize', () => { resizeCanvas(); init(); });
window.addEventListener('mousemove', (e) => { mouse.x = e.clientX; mouse.y = e.clientY; });
resizeCanvas();

class Point {
  constructor() {
    this.x = Math.random() * canvas.width;
    this.y = Math.random() * canvas.height;
    this.baseX = this.x;
    this.baseY = this.y;
    this.size = Math.random() * 2 + 1;
    this.density = (Math.random() * 30) + 1;
  }
  update() {
    if (mouse.x == null || mouse.y == null) {
      this.x -= (this.x - this.baseX) / 10;
      this.y -= (this.y - this.baseY) / 10;
      return;
    }

    let dx = mouse.x - this.x;
    let dy = mouse.y - this.y;
    let distance = Math.sqrt(dx * dx + dy * dy);

    // ✅ distance==0 방어 + radius 안일때만 밀기
    if (distance > 0 && distance < mouse.radius) {
      let force = (mouse.radius - distance) / mouse.radius;
      this.x -= (dx / distance) * force * this.density;
      this.y -= (dy / distance) * force * this.density;
    } else {
      this.x -= (this.x - this.baseX) / 10;
      this.y -= (this.y - this.baseY) / 10;
    }
  }
  draw() {
    ctx.fillStyle = 'rgba(255, 157, 0, 0.7)';
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    ctx.fill();
  }
}

function init() {
  points = [];
  for (let i = 0; i < 80; i++) points.push(new Point());
}

function animate() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  for (let i = 0; i < points.length; i++) {
    points[i].update();
    points[i].draw();

    for (let j = i; j < points.length; j++) {
      let dx = points[i].x - points[j].x;
      let dy = points[i].y - points[j].y;
      let dist = Math.sqrt(dx * dx + dy * dy);

      if (dist < 120) {
        ctx.strokeStyle = 'rgba(255, 157, 0, ' + (1 - dist / 120) + ')';
        ctx.lineWidth = 0.5;
        ctx.beginPath();
        ctx.moveTo(points[i].x, points[i].y);
        ctx.lineTo(points[j].x, points[j].y);
        ctx.stroke();
      }
    }
  }
  requestAnimationFrame(animate);
}

init();
animate();

/* =========================================================
   3) 룰렛 기능
========================================================= */
function addSlot() {
  const wrapper = document.getElementById('slots-wrapper');
  const slotId = Date.now();

  const categories = [...new Set(restaurants.map(r => r.category))].filter(Boolean);
  let categoryOptions = '<option value="전체">모든 카테고리</option>';
  categories.forEach(cat => {
    categoryOptions += '<option value="' + cat + '">' + cat + '</option>';
  });

  const div = document.createElement('div');
  div.className = "flex flex-col items-center group relative";
  div.innerHTML =
    '<select class="category-select bg-black text-orange-400 border-2 border-orange-900 p-4 px-8 rounded-full mb-6 outline-none font-black text-lg z-10 hover:border-orange-500 transition-all cursor-pointer">' +
      categoryOptions +
    '</select>' +
    '<div class="slot-machine" onclick="spinOne(\'' + slotId + '\')">' +
      '<div class="slot-container" id="container-' + slotId + '">' +
        '<div class="slot-item flex items-center justify-center">' +
          '<i class="fa-solid fa-utensils text-9xl text-orange-600 animate-bounce"></i>' +
        '</div>' +
      '</div>' +
    '</div>' +
    '<button type="button" onclick="this.parentElement.remove()" class="absolute -top-4 -right-4 bg-red-600 w-12 h-12 rounded-full font-black text-white opacity-0 group-hover:opacity-100 transition-opacity shadow-lg">✕</button>';

  wrapper.appendChild(div);
}

function spinOne(id) {
  const container = document.getElementById('container-' + id);
  if (!container) return;

  const minStar = parseInt(document.getElementById('star-filter').value, 10);
  const selectEl = container.closest('.group').querySelector('.category-select');
  const category = selectEl ? selectEl.value : "전체";

  // ✅ NaN 방지 필터 포함
  let filtered = restaurants.filter(r => !isNaN(r.star) && r.star >= minStar);
  if (category !== "전체") filtered = filtered.filter(r => r.category === category);

  if (filtered.length === 0) {
    alert('조건에 맞는 식당이 없습니다!\n(카테고리: ' + category + ', 최소별점: ' + minStar + ')');
    return;
  }

  const cycles = 2;  // ← 핵심 (3 이상은 체감 길어짐)
  const spinCount = Math.max(40, filtered.length * cycles);

  let html = '';

  for (let i = 0; i <= spinCount; i++) {
    const r = filtered[i % filtered.length];
    const safeName = (r.name || "맛집").replace(/'/g, "\\'");
    html +=
      '<div class="slot-item">' +
        '<img src="' + r.img + '" onerror="this.src=\\\'https://via.placeholder.com/380x550/222/ff6b35?text=' + safeName + '\\\'">' +
        '<div class="restaurant-info">' +
          '<div class="text-orange-500 font-black text-sm mb-2 uppercase">[ ' + (r.category || '') + ' ]</div>' +
          '<h3 class="text-4xl b-grade-font mb-3 text-white">' + (r.name || '') + '</h3>' +
          '<div class="flex justify-center items-center gap-3">' +
            '<span class="text-3xl text-yellow-400 font-black">★ ' + (r.star || 0) + '</span>' +
 /*            '<span class="text-gray-400 text-lg font-bold">(' + (r.reviewCount || 0) + '개)</span>' + */
          '</div>' +
        '</div>' +
      '</div>';
  }

  container.innerHTML = html;
  container.style.transition = 'none';
  container.style.transform = 'translateY(0)';

  setTimeout(() => {
    const stopIndex = Math.floor(Math.random() * filtered.length);
    const finalY = (spinCount - filtered.length + stopIndex) * 550;

    container.style.transition = 'transform 4s cubic-bezier(0.1, 0, 0.1, 1)';
    container.style.transform = 'translateY(-' + finalY + 'px)';

    setTimeout(() => {
      const rect = container.getBoundingClientRect();
      if (window.confetti) {
        window.confetti({
          particleCount: 200,
          spread: 90,
          origin: { x: (rect.left + rect.width / 2) / window.innerWidth, y: 0.5 },
          zIndex: 2000
        });
      }
    }, 4000);
  }, 50);
}

function spinAll() {
  document.querySelectorAll('.slot-container').forEach(c => {
    const id = c.id.replace('container-', '');
    spinOne(id);
  });
}

/* ✅ onload 덮임 방지: addEventListener로 */
window.addEventListener('load', () => {
  addSlot();
});
</script>

</body>
</html>
