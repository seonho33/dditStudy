/**
 * admin.js (ES5 Safe)
 * - backtick(`) 없음
 * - arrow function 없음
 * - template literal 없음
 *
 */
function _addDaysToTodayISO(days) {
  var d = new Date();
  d.setDate(d.getDate() + Number(days));
  return d.getFullYear() + '-' + _pad2(d.getMonth() + 1) + '-' + _pad2(d.getDate());
}


function _ctx() {
  return window.ctx || '';
}

function _pad2(n) {
  return String(n).padStart ? String(n).padStart(2, '0') : (n < 10 ? '0' + n : '' + n);
}

function _addDaysToToday(days) {
  var d = new Date();
  d.setDate(d.getDate() + Number(days));
  return d.getFullYear() + '.' + _pad2(d.getMonth() + 1) + '.' + _pad2(d.getDate());
}

function _postJson(url, payload) {
  return fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  }).then(function (res) {
    return res.text().then(function (text) {
      var data;
      try {
        data = JSON.parse(text);
      } catch (e) {
        throw new Error('서버 응답이 JSON이 아닙니다: ' + text);
      }
      if (!res.ok) throw new Error(data.message || ('요청 실패(' + res.status + ')'));
      return data;
    });
  });
}

// ==============================
// 검색 필터
// ==============================
function filterRows(input) {
  var val = (input.value || '').toLowerCase();
  var rows = document.querySelectorAll('.row-item');
  for (var i = 0; i < rows.length; i++) {
    var text = (rows[i].innerText || '').toLowerCase();
    rows[i].style.display = (text.indexOf(val) !== -1) ? '' : 'none';
  }
}

// ==============================
// [사장 승인대기] 승인/거절
// ==============================
function procOwner(btn, type) {
  var row = btn.closest ? btn.closest('.row-item') : _closest(btn, 'row-item');
  if (!row) return;

  var idEl = row.querySelector('.info-id');
  var userId = idEl ? (idEl.textContent || '').trim() : '';

  if (!userId) {
    alert('userId를 찾을 수 없습니다.');
    return;
  }

  _postJson(_ctx() + '/AdminOwnerApply.do', {
    action: type,
    userId: userId
  }).then(function (data) {
    if (!data.success) {
      alert(data.message || '처리 실패');
      return;
    }

    // ✅ 전체 회원관리(fragment) 다시 로드해서 아래 목록까지 갱신
    if (typeof loadContent === 'function') {
      var nav = document.querySelector('.nav-item.active');
      loadContent('/admin/member.do', nav);
      return;
    }

    // (fallback) loadContent가 없으면 카드만 제거
    if (row && row.parentNode) row.parentNode.removeChild(row);
    _updateOwnerEmptyState();

  }).catch(function (e) {
    alert('서버 통신 오류: ' + e.message);
  });
}

function _updateOwnerEmptyState() {
  var list = document.getElementById('ownerApplyList');
  if (!list) return;

  var items = list.querySelectorAll('.row-item');
  var visible = 0;
  for (var i = 0; i < items.length; i++) {
    if (items[i].style.display !== 'none') visible++;
  }

  if (visible === 0) {
    list.innerHTML =
      '<div class="empty-state">' +
        '<div class="empty-state-icon"><i class="fa-solid fa-clipboard-check"></i></div>' +
        '<p class="empty-state-text">처리할 승인 요청이 없습니다.</p>' +
      '</div>';
  }
}

// ==============================
// [제재 모달] 열기/닫기
// ==============================
function openBanModal(id) {
  document.getElementById('targetId').value = id;
  var modal = document.getElementById('banModal');
  modal.classList.remove('hidden');
  modal.classList.add('flex');
}

function closeModal() {
  var modal = document.getElementById('banModal');
  modal.classList.add('hidden');
  modal.classList.remove('flex');
}

function toggleDir(val) {
  var dirInput = document.getElementById('reasonDir');
  if (val === 'DIRECT') dirInput.classList.remove('hidden');
  else dirInput.classList.add('hidden');
}

// ==============================
// [제재] BAN 확정 → 서버 업데이트 → UI 반영
// ==============================
function confirmBan() {
  var id = document.getElementById('targetId').value;

  var sel = document.getElementById('reasonSel').value;
  var dir = (document.getElementById('reasonDir').value || '').trim();
  var reason = (sel === 'DIRECT') ? dir : sel;

  var daysEl = document.querySelector('input[name="days"]:checked');
  var days = daysEl ? Number(daysEl.value) : 3;

  if (!id) { alert('대상 아이디가 없습니다.'); return; }
  if (sel === 'DIRECT' && !dir) { alert('사유를 입력해 주세요.'); return; }
  if (!(days === 3 || days === 7 || days === 30)) { alert('기간이 올바르지 않습니다.'); return; }

  // ⭐ 서버로 보낼 endDate (YYYY-MM-DD)
  var endDate = _addDaysToTodayISO(days);

  _postJson(_ctx() + '/AdminBan.do', {
    action: 'BAN',
    userId: id,
    reason: reason,
    endDate: endDate
  }).then(function (data) {
    if (!data.success) {
      alert(data.message || '제재 실패');
      return;
    }

    _setBannedUI(id, reason, days);
    closeModal();
  }).catch(function (e) {
    alert('서버 통신 오류: ' + e.message);
  });
}


function _setBannedUI(userId, reason, days) {
  var row = document.getElementById('user_row_' + userId);
  var banTxt = document.getElementById('ban_txt_' + userId);
  if (!row || !banTxt) return;

  var dateStr = _addDaysToToday(days);
  banTxt.innerHTML = '사유: ' + reason + ' | 해제일: ' + dateStr + ' (' + days + '일간)';

  row.classList.add('is-banned');

  var actions = row.querySelector('.member-actions');
  if (actions) {
    actions.innerHTML =
      '<button onclick="unban(\'' + userId + '\')" class="btn-unban-solid">' +
        '제재 해제' +
      '</button>';
  }
}

// ==============================
// [해제] UNBAN → 서버 업데이트 → UI 반영
// ==============================
function unban(userId) {
  if (!userId) return;
  if (!confirm('제재를 해제할까요?')) return;

  _postJson(_ctx() + '/AdminBan.do', {
    action: 'UNBAN',
    userId: userId
  }).then(function (data) {
    if (!data.success) {
      alert(data.message || '해제 실패');
      return;
    }
    _setUnbannedUI(userId);
  }).catch(function (e) {
    alert('서버 통신 오류: ' + e.message);
  });
}

function _setUnbannedUI(userId) {
  var row = document.getElementById('user_row_' + userId);
  var banTxt = document.getElementById('ban_txt_' + userId);
  if (!row || !banTxt) return;

  row.classList.remove('is-banned');
  banTxt.innerHTML = '제재 없음';

  var actions = row.querySelector('.member-actions');
  if (actions) {
    actions.innerHTML =
      '<button onclick="openBanModal(\'' + userId + '\')" class="btn-ban btn-ban-trigger">' +
        '제재하기' +
      '</button>';
  }
}

// ==============================
// 구형 브라우저 대비 closest 대체(혹시 필요하면)
// ==============================
function _closest(el, className) {
  while (el) {
    if (el.classList && el.classList.contains(className)) return el;
    el = el.parentNode;
  }
  return null;
}

function toggleCard(card) {
  if (!card || !card.classList.contains('comm-card')) return;
  if (card.classList.contains('is-empty')) return;

  var isOpen = card.classList.contains('is-open');

  // 다른 열린 카드 닫기
  var opens = document.querySelectorAll('.comm-card.is-open');
  for (var i = 0; i < opens.length; i++) {
    if (opens[i] === card) continue;
    opens[i].classList.remove('is-open');
    collapseDetail(opens[i]);
  }

  // 현재 카드 토글
  if (isOpen) {
    card.classList.remove('is-open');
    collapseDetail(card);
  } else {
    card.classList.add('is-open');
    expandDetail(card);
  }
}


// ✅ 회원 제재 관리 정렬 (ES5 Safe)
function sortMembers(type, btnEl) {
  var listBox = document.getElementById('memberListBox');
  if (!listBox) return;

  var btns = document.querySelectorAll('.sort-btn');
  for (var i = 0; i < btns.length; i++) {
    btns[i].classList.remove('is-active');
  }
  if (btnEl) btnEl.classList.add('is-active');

  var nodeList = listBox.querySelectorAll('.row-item');
  var rows = [];
  for (i = 0; i < nodeList.length; i++) rows.push(nodeList[i]);

  for (i = 0; i < rows.length; i++) {
    if (!rows[i].getAttribute('data-origin-index')) {
      rows[i].setAttribute('data-origin-index', String(i));
    }
  }

  function _trim(s){ return (s || '').replace(/^\s+|\s+$/g, ''); }
  function getUserId(row) { var el = row.querySelector('.member-id'); return _trim(el ? el.textContent : ''); }
  function getDivision(row) { if (row.querySelector('.member-owner')) return '점주'; if (row.querySelector('.member-user')) return '일반회원'; return ''; }
  function getName(row) { var el = row.querySelector('.member-name'); return _trim(el ? el.textContent : ''); }

  function cmpStr(a, b) {
    a = a || ''; b = b || '';
    if (a === b) return 0;
    if (a.localeCompare) return a.localeCompare(b, 'ko');
    return (a < b) ? -1 : 1;
  }

  var sorted = rows.slice();

  if (type === 'default') {
    sorted.sort(function (a, b) {
      var ai = Number(a.getAttribute('data-origin-index') || 0);
      var bi = Number(b.getAttribute('data-origin-index') || 0);
      return ai - bi;
    });
  } else if (type === 'division') {
    var order = { '점주': 0, '일반회원': 1, '': 9 };
    sorted.sort(function (a, b) {
      var oa = order[getDivision(a)] != null ? order[getDivision(a)] : 9;
      var ob = order[getDivision(b)] != null ? order[getDivision(b)] : 9;
      if (oa !== ob) return oa - ob;

      var na = cmpStr(getName(a), getName(b));
      if (na !== 0) return na;
      return cmpStr(getUserId(a), getUserId(b));
    });
  } else if (type === 'name') {
    sorted.sort(function (a, b) {
      var na = cmpStr(getName(a), getName(b));
      if (na !== 0) return na;

      var d2 = cmpStr(getDivision(a), getDivision(b));
      if (d2 !== 0) return d2;
      return cmpStr(getUserId(a), getUserId(b));
    });
  }

  for (i = 0; i < sorted.length; i++) listBox.appendChild(sorted[i]);
}

// ✅ 회원 제재 관리 정렬(일자 + 화살표 토글, ES5)  ← 이게 전역에 있어야 함!!
function sortMembers2(key, btn) {
  var listBox = document.getElementById('memberListBox');
  if (!listBox) return;

  var curDir = btn.getAttribute('data-dir') || 'desc';
  var nextDir = (curDir === 'desc') ? 'asc' : 'desc';

  var keys = document.querySelectorAll('.sortkey');
  for (var i = 0; i < keys.length; i++) {
    if (keys[i] !== btn) {
      keys[i].classList.remove('is-active');
      keys[i].setAttribute('data-dir', 'desc');
      var arrow0 = keys[i].querySelector('.sortarrow');
      if (arrow0) arrow0.textContent = '▼';
    }
  }

  btn.classList.add('is-active');
  btn.setAttribute('data-dir', nextDir);
  var arrow = btn.querySelector('.sortarrow');
  if (arrow) arrow.textContent = (nextDir === 'desc') ? '▼' : '▲';

  var nodeList = listBox.querySelectorAll('.row-item');
  var rows = [];
  for (i = 0; i < nodeList.length; i++) rows.push(nodeList[i]);

  for (i = 0; i < rows.length; i++) {
    if (!rows[i].getAttribute('data-origin-index')) {
      rows[i].setAttribute('data-origin-index', String(i));
    }
  }

  function trim(s){ return (s || '').replace(/^\s+|\s+$/g, ''); }
  function getUserId(row){ var el = row.querySelector('.member-id'); return trim(el ? el.textContent : ''); }
  function getDivision(row){ if (row.querySelector('.member-owner')) return '점주'; if (row.querySelector('.member-user')) return '일반회원'; return ''; }
  function getName(row){ var el = row.querySelector('.member-name'); return trim(el ? el.textContent : ''); }
  function cmpStr(a, b){ a = a || ''; b = b || ''; if (a === b) return 0; if (a.localeCompare) return a.localeCompare(b, 'ko'); return (a < b) ? -1 : 1; }

  rows.sort(function(a, b){
    var va, vb;

    if (key === 'division') {
      var order = { '점주': 0, '일반회원': 1, '': 9 };
      va = order[getDivision(a)] != null ? order[getDivision(a)] : 9;
      vb = order[getDivision(b)] != null ? order[getDivision(b)] : 9;

      if (va !== vb) return (nextDir === 'desc') ? (va - vb) : (vb - va);

      var n1 = cmpStr(getName(a), getName(b));
      if (n1 !== 0) return (nextDir === 'desc') ? n1 : -n1;

      var u1 = cmpStr(getUserId(a), getUserId(b));
      return (nextDir === 'desc') ? u1 : -u1;
    }

    if (key === 'name') {
      va = getName(a);
      vb = getName(b);

      var n2 = cmpStr(va, vb);
      if (n2 !== 0) return (nextDir === 'desc') ? n2 : -n2;

      var d2 = cmpStr(getDivision(a), getDivision(b));
      if (d2 !== 0) return (nextDir === 'desc') ? d2 : -d2;

      var u2 = cmpStr(getUserId(a), getUserId(b));
      return (nextDir === 'desc') ? u2 : -u2;
    }

    var ai = Number(a.getAttribute('data-origin-index') || 0);
    var bi = Number(b.getAttribute('data-origin-index') || 0);
    return ai - bi;
  });

  for (i = 0; i < rows.length; i++) listBox.appendChild(rows[i]);
}
