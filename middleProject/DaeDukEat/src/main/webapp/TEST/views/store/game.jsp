<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Crossy Road</title>
<style>
  @import url("https://fonts.googleapis.com/css?family=Press+Start+2P");

  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    overflow: hidden;
    background: #000;
    font-family: "Press Start 2P", cursive;
  }

  canvas { display: block; }

  #score {
    position: absolute;
    top: 20px;
    left: 24px;
    font-size: 22px;
    color: #fff;
    text-shadow: 0 0 8px rgba(0,0,0,0.7), 2px 2px 0 #000;
    z-index: 10;
    pointer-events: none;
  }

  /* ---- RESULT OVERLAY ---- */
  #result-container {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    visibility: hidden;
    z-index: 20;
    background: rgba(0,0,0,0.52);
  }
  #result {
    background: linear-gradient(145deg, #1e1e2e, #2a2a3d);
    border: 2px solid #555;
    border-radius: 18px;
    padding: 40px 50px 36px;
    text-align: center;
    box-shadow: 0 12px 40px rgba(0,0,0,0.6);
  }
  #result h1 {
    color: #f44;
    font-size: 24px;
    margin-bottom: 18px;
    text-shadow: 0 0 12px rgba(255,60,60,0.5);
  }
  #result p {
    color: #ccc;
    font-size: 14px;
    margin-bottom: 24px;
  }
  #result #final-score {
    color: #f5a623;
    font-size: 20px;
  }
  #retry {
    font-family: "Press Start 2P", cursive;
    background: linear-gradient(135deg, #e94560, #c73652);
    color: #fff;
    border: none;
    border-radius: 10px;
    padding: 14px 40px;
    font-size: 16px;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(233,69,96,0.4);
    transition: transform 0.12s, box-shadow 0.12s;
  }
  #retry:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(233,69,96,0.55);
  }

  /* ---- 복귀 버튼 행 ---- */
  .btn-row {
    display: flex;
    justify-content: center;
    gap: 14px;
  }

  #backBtn {
    font-family: "Press Start 2P", cursive;
    background: linear-gradient(135deg, #DC143C, #8B0000);
    color: #fff;
    border: none;
    border-radius: 10px;
    padding: 14px 32px;
    font-size: 15px;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(139,0,0,0.4);
    transition: transform 0.12s, box-shadow 0.12s;
  }
  #backBtn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(139,0,0,0.55);
  }

  /* ---- KEYBOARD HINT (bottom-left) ---- */
  #hint {
    position: absolute;
    bottom: 22px;
    left: 24px;
    color: rgba(255,255,255,0.55);
    font-size: 10px;
    line-height: 1.8;
    pointer-events: none;
    z-index: 10;
  }
  #hint kbd {
    display: inline-block;
    background: rgba(255,255,255,0.1);
    border: 1px solid rgba(255,255,255,0.22);
    border-radius: 4px;
    padding: 2px 7px;
    color: #fff;
    font-family: "Press Start 2P", cursive;
    font-size: 9px;
  }
</style>
</head>
<body>

<canvas id="gameCanvas"></canvas>
<div id="score">0</div>

<div id="result-container">
  <div id="result">
    <h1>Game Over</h1>
    <p>Your score: <span id="final-score">0</span></p>
    <div class="btn-row">
      <button id="retry">Retry</button>
      <button id="backBtn">← 발렌타인</button>
    </div>
  </div>
</div>

<div id="hint">
  <kbd>↑</kbd> Forward &nbsp;
  <kbd>↓</kbd> Back &nbsp;
  <kbd>←</kbd><kbd>→</kbd> Strafe
</div>

<!-- Three.js r128 CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>

<script>
(function () {
  "use strict";

  // ============================================================
  // CONSTANTS
  // ============================================================
  const minTileIndex = -8;
  const maxTileIndex =  8;
  const tilesPerRow  = maxTileIndex - minTileIndex + 1; // 17
  const tileSize     = 42;

  // ============================================================
  // CANVAS / RENDERER
  // ============================================================
  const canvas   = document.getElementById("gameCanvas");
  const renderer = new THREE.WebGLRenderer({ canvas, antialias: true, alpha: true });
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(window.innerWidth, window.innerHeight);
  renderer.shadowMap.enabled = true;

  window.addEventListener("resize", () => {
    renderer.setSize(window.innerWidth, window.innerHeight);
    updateCamera();
  });

  // ============================================================
  // CAMERA  (orthographic, isometric-ish)
  // ============================================================
  let camera;
  function createCamera() {
    const size      = 300;
    const viewRatio = window.innerWidth / window.innerHeight;
    const width     = viewRatio < 1 ? size : size * viewRatio;
    const height    = viewRatio < 1 ? size / viewRatio : size;

    camera = new THREE.OrthographicCamera(
      width / -2, width / 2,
      height / 2, height / -2,
      100, 900
    );
    camera.up.set(0, 0, 1);
    camera.position.set(300, -300, 300);
    camera.lookAt(0, 0, 0);
  }
  createCamera();

  function updateCamera() {
    const size      = 300;
    const viewRatio = window.innerWidth / window.innerHeight;
    const width     = viewRatio < 1 ? size : size * viewRatio;
    const height    = viewRatio < 1 ? size / viewRatio : size;
    camera.left   = width  / -2;
    camera.right  = width  /  2;
    camera.top    = height /  2;
    camera.bottom = height / -2;
    camera.updateProjectionMatrix();
  }

  // ============================================================
  // SCENE + LIGHTS
  // ============================================================
  const scene = new THREE.Scene();

  const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
  scene.add(ambientLight);

  const dirLight = new THREE.DirectionalLight(0xffffff, 0.8);
  dirLight.position.set(-100, -100, 200);
  dirLight.up.set(0, 0, 1);
  dirLight.castShadow = true;
  dirLight.shadow.mapSize.width  = 2048;
  dirLight.shadow.mapSize.height = 2048;
  dirLight.shadow.camera.up.set(0, 0, 1);
  dirLight.shadow.camera.left   = -400;
  dirLight.shadow.camera.right  =  400;
  dirLight.shadow.camera.top    =  400;
  dirLight.shadow.camera.bottom = -400;
  dirLight.shadow.camera.near   =  50;
  dirLight.shadow.camera.far    = 400;
  scene.add(dirLight);

  // ============================================================
  // TEXTURE HELPERS (canvas-painted)
  // ============================================================
  function Texture(w, h, rects) {
    const c   = document.createElement("canvas");
    c.width   = w; c.height = h;
    const ctx = c.getContext("2d");
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(0, 0, w, h);
    ctx.fillStyle = "rgba(0,0,0,0.6)";
    rects.forEach(r => ctx.fillRect(r.x, r.y, r.w, r.h));
    return new THREE.CanvasTexture(c);
  }

  const carFrontTex        = Texture(40, 80, [{ x:0,  y:10, w:30, h:60 }]);
  const carBackTex         = Texture(40, 80, [{ x:10, y:10, w:30, h:60 }]);
  const carRightTex        = Texture(110,40, [{ x:10, y:0,  w:50, h:30 },{ x:70, y:0,  w:30, h:30 }]);
  const carLeftTex         = Texture(110,40, [{ x:10, y:10, w:50, h:30 },{ x:70, y:10, w:30, h:30 }]);
  const truckFrontTex      = Texture(30, 30, [{ x:5,  y:0,  w:10, h:30 }]);
  const truckRightTex      = Texture(25, 30, [{ x:15, y:5,  w:10, h:10 }]);
  const truckLeftTex       = Texture(25, 30, [{ x:15, y:15, w:10, h:10 }]);

  // ============================================================
  // WHEEL
  // ============================================================
  function Wheel(x) {
    const m = new THREE.Mesh(
      new THREE.BoxGeometry(12, 33, 12),
      new THREE.MeshLambertMaterial({ color: 0x333333, flatShading: true })
    );
    m.position.set(x, 0, 6);
    return m;
  }

  // ============================================================
  // CAR
  // ============================================================
  function Car(initialTileIndex, direction, color) {
    const g = new THREE.Group();
    g.position.x = initialTileIndex * tileSize;
    if (!direction) g.rotation.z = Math.PI;

    // Body
    const body = new THREE.Mesh(
      new THREE.BoxGeometry(60, 30, 15),
      new THREE.MeshLambertMaterial({ color, flatShading: true })
    );
    body.position.z = 12;
    body.castShadow = true;
    body.receiveShadow = true;
    g.add(body);

    // Cabin (windshield textures)
    const cabin = new THREE.Mesh(
      new THREE.BoxGeometry(33, 24, 12),
      [
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true, map: carBackTex  }),  // +x (back)
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true, map: carFrontTex }),  // -x (front)
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true, map: carRightTex }),  // +y
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true, map: carLeftTex  }),  // -y
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true }),                    // top
        new THREE.MeshPhongMaterial({ color: 0xcccccc, flatShading: true })                     // bottom
      ]
    );
    cabin.position.set(-6, 0, 25.5);
    cabin.castShadow = true;
    cabin.receiveShadow = true;
    g.add(cabin);

    g.add(Wheel( 18));
    g.add(Wheel(-18));
    return g;
  }

  // ============================================================
  // TRUCK
  // ============================================================
  function Truck(initialTileIndex, direction, color) {
    const g = new THREE.Group();
    g.position.x = initialTileIndex * tileSize;
    if (!direction) g.rotation.z = Math.PI;

    // Cargo box
    const cargo = new THREE.Mesh(
      new THREE.BoxGeometry(70, 35, 35),
      new THREE.MeshLambertMaterial({ color: 0xb4c6fc, flatShading: true })
    );
    cargo.position.set(-15, 0, 25);
    cargo.castShadow = true;
    cargo.receiveShadow = true;
    g.add(cargo);

    // Cabin
    const cabin = new THREE.Mesh(
      new THREE.BoxGeometry(30, 30, 30),
      [
        new THREE.MeshLambertMaterial({ color, flatShading: true, map: truckFrontTex }),
        new THREE.MeshLambertMaterial({ color, flatShading: true }),
        new THREE.MeshLambertMaterial({ color, flatShading: true, map: truckLeftTex  }),
        new THREE.MeshLambertMaterial({ color, flatShading: true, map: truckRightTex }),
        new THREE.MeshPhongMaterial({ color, flatShading: true }),
        new THREE.MeshPhongMaterial({ color, flatShading: true })
      ]
    );
    cabin.position.set(35, 0, 20);
    cabin.castShadow = true;
    cabin.receiveShadow = true;
    g.add(cabin);

    g.add(Wheel( 37));
    g.add(Wheel(  5));
    g.add(Wheel(-35));
    return g;
  }

  // ============================================================
  // GRASS ROW
  // ============================================================
  function Grass(rowIndex) {
    const g = new THREE.Group();
    g.position.y = rowIndex * tileSize;

    function section(color, offsetX) {
      const m = new THREE.Mesh(
        new THREE.BoxGeometry(tilesPerRow * tileSize, tileSize, 3),
        new THREE.MeshLambertMaterial({ color })
      );
      m.position.x = offsetX || 0;
      m.receiveShadow = true;
      return m;
    }
    g.add(section(0xbaf455,  0));
    g.add(section(0x99c846, -tilesPerRow * tileSize));
    g.add(section(0x99c846,  tilesPerRow * tileSize));
    return g;
  }

  // ============================================================
  // ROAD ROW
  // ============================================================
  function Road(rowIndex) {
    const g = new THREE.Group();
    g.position.y = rowIndex * tileSize;

    function section(color, offsetX) {
      const m = new THREE.Mesh(
        new THREE.PlaneGeometry(tilesPerRow * tileSize, tileSize),
        new THREE.MeshLambertMaterial({ color })
      );
      m.position.x = offsetX || 0;
      m.receiveShadow = true;
      return m;
    }
    g.add(section(0x454a59,  0));
    g.add(section(0x393d49, -tilesPerRow * tileSize));
    g.add(section(0x393d49,  tilesPerRow * tileSize));
    return g;
  }

  // ============================================================
  // TREE
  // ============================================================
  function Tree(tileIndex, height) {
    const g = new THREE.Group();
    g.position.x = tileIndex * tileSize;

    const trunk = new THREE.Mesh(
      new THREE.BoxGeometry(15, 15, 20),
      new THREE.MeshLambertMaterial({ color: 0x4d2926, flatShading: true })
    );
    trunk.position.z = 10;
    g.add(trunk);

    const crown = new THREE.Mesh(
      new THREE.BoxGeometry(30, 30, height),
      new THREE.MeshLambertMaterial({ color: 0x7aa21d, flatShading: true })
    );
    crown.position.z = height / 2 + 20;
    crown.castShadow  = true;
    crown.receiveShadow = true;
    g.add(crown);
    return g;
  }

  // ============================================================
  // PLAYER (frog)
  // ============================================================
  const playerContainer = new THREE.Group();
  const playerInner     = new THREE.Group();
  playerContainer.add(playerInner);
  scene.add(playerContainer);

  (function buildPlayer() {
    const body = new THREE.Mesh(
      new THREE.BoxGeometry(15, 15, 20),
      new THREE.MeshLambertMaterial({ color: 0xffffff, flatShading: true })
    );
    body.position.z = 10;
    body.castShadow = true;
    body.receiveShadow = true;
    playerInner.add(body);

    const cap = new THREE.Mesh(
      new THREE.BoxGeometry(2, 4, 2),
      new THREE.MeshLambertMaterial({ color: 0xf0619a, flatShading: true })
    );
    cap.position.z = 21;
    cap.castShadow = true;
    playerInner.add(cap);
  })();

  // Camera & dirLight follow player
  playerContainer.add(camera);
  dirLight.target = playerContainer;
  playerContainer.add(dirLight);

  // ============================================================
  // MAP & METADATA
  // ============================================================
  const metadata = [];   // row descriptions (index 0 = row 1 ahead of start)
  const mapGroup = new THREE.Group();
  scene.add(mapGroup);

  // ---- random helpers ----
  function rand(arr) { return arr[Math.floor(Math.random() * arr.length)]; }
  function randInt(a, b) { return a + Math.floor(Math.random() * (b - a + 1)); }

  // ---- row generators ----
  function genForest() {
    const used  = new Set();
    const trees = [];
    for (let i = 0; i < 4; i++) {
      let t;
      do { t = randInt(minTileIndex, maxTileIndex); } while (used.has(t));
      used.add(t);
      trees.push({ tileIndex: t, height: rand([20, 45, 60]) });
    }
    return { type: "forest", trees };
  }

  function genCarLane() {
    const direction = rand([true, false]);
    const speed     = rand([125, 156, 188]);
    const used      = new Set();
    const vehicles  = [];
    for (let i = 0; i < 3; i++) {
      let t;
      do { t = randInt(minTileIndex, maxTileIndex); } while (used.has(t));
      used.add(t - 1); used.add(t); used.add(t + 1);
      vehicles.push({ initialTileIndex: t, color: rand([0xa52523, 0xbdb638, 0x78b14b]), ref: null });
    }
    return { type: "car", direction, speed, vehicles };
  }

  function genTruckLane() {
    const direction = rand([true, false]);
    const speed     = rand([125, 156, 188]);
    const used      = new Set();
    const vehicles  = [];
    for (let i = 0; i < 2; i++) {
      let t;
      do { t = randInt(minTileIndex, maxTileIndex); } while (used.has(t));
      used.add(t-2); used.add(t-1); used.add(t); used.add(t+1); used.add(t+2);
      vehicles.push({ initialTileIndex: t, color: rand([0xa52523, 0xbdb638, 0x78b14b]), ref: null });
    }
    return { type: "truck", direction, speed, vehicles };
  }

  function genRow() { return rand(["car","truck","forest"]) === "forest" ? genForest() : (rand(["car","truck"]) === "car" ? genCarLane() : genTruckLane()); }

  // ---- build Three.js objects for rows ----
  function addRows(count) {
    const startIdx = metadata.length;
    for (let i = 0; i < count; i++) {
      const data     = genRow();
      const rowIndex = startIdx + i + 1;   // 1-based forward row
      metadata.push(data);

      if (data.type === "forest") {
        const row = Grass(rowIndex);
        data.trees.forEach(t => row.add(Tree(t.tileIndex, t.height)));
        mapGroup.add(row);
      } else {
        // car or truck → road
        const row = Road(rowIndex);
        data.vehicles.forEach(v => {
          const mesh = data.type === "car"
            ? Car(v.initialTileIndex, data.direction, v.color)
            : Truck(v.initialTileIndex, data.direction, v.color);
          v.ref = mesh;
          row.add(mesh);
        });
        mapGroup.add(row);
      }
    }
  }

  function initMap() {
    metadata.length = 0;
    mapGroup.remove(...[...mapGroup.children]);   // clear scene objects

    // Starting grass rows (behind player)
    for (let r = 0; r > -10; r--) mapGroup.add(Grass(r));

    // First 20 rows ahead
    addRows(20);
  }

  // ============================================================
  // PLAYER STATE + MOVEMENT
  // ============================================================
  const pos       = { currentRow: 0, currentTile: 0 };
  const moveQueue = [];

  function initPlayer() {
    playerContainer.position.set(0, 0, 0);
    playerInner.position.z = 0;
    playerInner.rotation.z = 0;
    pos.currentRow  = 0;
    pos.currentTile = 0;
    moveQueue.length = 0;
  }

  // Validation ------------------------------------------------
  function calcFinal(startRow, startTile, moves) {
    let r = startRow, t = startTile;
    moves.forEach(d => {
      if (d === "forward")  r++;
      if (d === "backward") r--;
      if (d === "left")     t--;
      if (d === "right")    t++;
    });
    return { rowIndex: r, tileIndex: t };
  }

  function isValidMove(dir) {
    const fin = calcFinal(pos.currentRow, pos.currentTile, [...moveQueue, dir]);
    if (fin.rowIndex === -1) return false;
    if (fin.tileIndex < minTileIndex || fin.tileIndex > maxTileIndex) return false;

    // tree collision check
    const row = metadata[fin.rowIndex - 1];
    if (row && row.type === "forest" && row.trees.some(t => t.tileIndex === fin.tileIndex)) return false;
    return true;
  }

  function queueMove(dir) {
    if (isValidMove(dir)) moveQueue.push(dir);
  }

  // ============================================================
  // ANIMATION CLOCKS
  // ============================================================
  const moveClock     = new THREE.Clock(false);
  const vehicleClock  = new THREE.Clock();
  const STEP_TIME     = 0.2; // seconds per hop

  // ============================================================
  // ANIMATE PLAYER (one tile hop at a time)
  // ============================================================
  function animatePlayer() {
    if (!moveQueue.length) return;
    if (!moveClock.running) moveClock.start();

    const progress = Math.min(1, moveClock.getElapsedTime() / STEP_TIME);

    // --- position lerp ---
    const sx = pos.currentTile * tileSize;
    const sy = pos.currentRow  * tileSize;
    let ex = sx, ey = sy;
    if (moveQueue[0] === "left")     ex -= tileSize;
    if (moveQueue[0] === "right")    ex += tileSize;
    if (moveQueue[0] === "forward")  ey += tileSize;
    if (moveQueue[0] === "backward") ey -= tileSize;

    playerContainer.position.x = THREE.MathUtils.lerp(sx, ex, progress);
    playerContainer.position.y = THREE.MathUtils.lerp(sy, ey, progress);
    playerInner.position.z     = Math.sin(progress * Math.PI) * 8;   // hop arc

    // --- rotation lerp ---
    const rotMap = { forward: 0, left: Math.PI/2, right: -Math.PI/2, backward: Math.PI };
    playerInner.rotation.z = THREE.MathUtils.lerp(
      playerInner.rotation.z,
      rotMap[moveQueue[0]],
      progress
    );

    // --- step complete ---
    if (progress >= 1) {
      const dir = moveQueue.shift();
      if (dir === "forward")  pos.currentRow++;
      if (dir === "backward") pos.currentRow--;
      if (dir === "left")     pos.currentTile--;
      if (dir === "right")    pos.currentTile++;

      // load more rows when approaching the frontier
      if (pos.currentRow > metadata.length - 10) addRows(20);

      // update score display
      scoreDOM.innerText = Math.max(0, pos.currentRow).toString();

      moveClock.stop();
    }
  }

  // ============================================================
  // ANIMATE VEHICLES
  // ============================================================
  function animateVehicles() {
    const delta = vehicleClock.getDelta();
    const beg   = (minTileIndex - 2) * tileSize;
    const end   = (maxTileIndex + 2) * tileSize;

    metadata.forEach(row => {
      if (row.type !== "car" && row.type !== "truck") return;
      row.vehicles.forEach(v => {
        if (!v.ref) return;
        if (row.direction) {
          v.ref.position.x = v.ref.position.x > end  ? beg : v.ref.position.x + row.speed * delta;
        } else {
          v.ref.position.x = v.ref.position.x < beg  ? end : v.ref.position.x - row.speed * delta;
        }
      });
    });
  }

  // ============================================================
  // HIT TEST  (bounding-box collision with vehicles)
  // ============================================================
  function hitTest() {
    const row = metadata[pos.currentRow - 1];
    if (!row || (row.type !== "car" && row.type !== "truck")) return;

    const pBox = new THREE.Box3().setFromObject(playerContainer);
    for (const v of row.vehicles) {
      if (!v.ref) continue;
      const vBox = new THREE.Box3().setFromObject(v.ref);
      if (pBox.intersectsBox(vBox)) {
        gameOver();
        return;
      }
    }
  }

  // ============================================================
  // GAME OVER / RETRY
  // ============================================================
  let dead = false;

  function gameOver() {
    if (dead) return;
    dead = true;
    finalScoreDOM.innerText = Math.max(0, pos.currentRow).toString();
    resultContainer.style.visibility = "visible";
  }

  function initGame() {
    dead = false;
    initPlayer();
    initMap();
    scoreDOM.innerText = "0";
    resultContainer.style.visibility = "hidden";
  }

  // ============================================================
  // KEYBOARD
  // ============================================================
  window.addEventListener("keydown", e => {
    if (dead) return;
    if (e.key === "ArrowUp")    { e.preventDefault(); queueMove("forward");  }
    if (e.key === "ArrowDown")  { e.preventDefault(); queueMove("backward"); }
    if (e.key === "ArrowLeft")  { e.preventDefault(); queueMove("left");     }
    if (e.key === "ArrowRight") { e.preventDefault(); queueMove("right");    }
  });

  // ============================================================
  // DOM REFS
  // ============================================================
  const scoreDOM         = document.getElementById("score");
  const resultContainer  = document.getElementById("result-container");
  const finalScoreDOM    = document.getElementById("final-score");

  document.getElementById("retry").addEventListener("click", initGame);

  // ★ 발렌타인 페이지로 복귀 ★
  document.getElementById("backBtn").addEventListener("click", function() {
    window.location.href = "팝업이벤트.jsp";
  });

  // ============================================================
  // BOOT
  // ============================================================
  initGame();

  // ============================================================
  // RENDER LOOP
  // ============================================================
  renderer.setAnimationLoop(function () {
    animateVehicles();
    animatePlayer();
    if (!dead) hitTest();
    renderer.render(scene, camera);
  });

})();
</script>
</body>
</html>