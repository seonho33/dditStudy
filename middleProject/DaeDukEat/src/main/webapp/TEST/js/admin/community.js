/* ====== endpoints: 너희 서블릿 주소로 맞춰라 ====== */
var API = {
  insertNotice: '/AdminNoticeAction.do',
  updateNotice: '/UpdateNotice.do',
  deleteNotice: '/DeleteNotice.do',
  updateAnswer: '/UpdateAnswer.do'
};

/* ====== 공통: fetch JSON (x-www-form-urlencoded) ====== */
function postForm(url, paramsObj) {
  var body = new URLSearchParams(paramsObj).toString();

  return fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
    body: body
  }).then(function (res) {
    // 서버에서 JSON 안 주면 여기서 터짐 -> 반드시 JSON으로 응답하자
    return res.json().then(function (data) {
      if (!res.ok) throw new Error(data && data.message ? data.message : '요청 실패');
      return data;
    });
  });
}

function getJson(url) {
  return fetch(url, { method: 'GET' }).then(function (res) {
    return res.json().then(function (data) {
      if (!res.ok) throw new Error(data && data.message ? data.message : '요청 실패');
      return data;
    });
  });
}

/* ====== 커뮤니티 fragment 재로딩(너희 SPA 구조용) ====== */
function reloadCommunity() {
  if (!window.COMMUNITY_URL) {
    alert('COMMUNITY_URL이 설정되지 않았습니다. JSP에 window.COMMUNITY_URL 넣어줘.');
    return;
  }

  fetch(window.COMMUNITY_URL, { method: 'GET' })
    .then(function (res) { return res.text(); })
    .then(function (html) {
      // ✅ 너희가 inner content 넣는 컨테이너 id/class에 맞춰 바꿔라
      // 예: <div id="adminContent"></div> 여기에 fragment 넣는 구조라면 그걸로
	var container = document.getElementById('main-content');
    	if (!container) {
        // 페이지 내에서 이 fragment만 교체하고 싶다면 commListArea만 교체하는 방식으로도 가능
        // 근데 가장 확실한 건 "컨텐츠 컨테이너 통째로 교체"
        alert('컨텐츠 컨테이너를 찾지 못했습니다. adminContent/mainContent ID 확인 필요');
        return;
      }
      container.innerHTML = html;
    })
    .catch(function (err) {
      alert(err.message || '화면 갱신 실패');
    });
}

/* ====== 공지 등록: 즉시 DB 반영 ====== */
function publishNotice() {
  var titleEl = document.getElementById('newTitle');
  var contentEl = document.getElementById('newContent');

  var title = titleEl ? titleEl.value.trim() : '';
  var content = contentEl ? contentEl.value.trim() : '';

  if (!title || !content) {
    alert('제목과 내용을 입력해주세요!');
    return;
  }

  var url = (window.CTX || '') + API.insertNotice;

  postForm(url, { noticeTitle: title, noticeContent: content })
    .then(function (data) {
      if (!data || data.success !== true) {
        throw new Error((data && data.message) ? data.message : '등록 실패');
      }
      // 등록 성공 → 커뮤니티 fragment 재로딩
      reloadCommunity();
    })
    .catch(function (err) {
      alert(err.message || '등록 실패');
    });
}

function deleteNotice(btn, pk) {
  if (!confirm('정말 삭제하시겠습니까?')) return;

  var url = (window.CTX || '') + API.deleteNotice + '?no=' + encodeURIComponent(pk);

  fetch(url, { method: 'GET' })
    .then(res => res.json())
    .then(data => {
      if (!data.success) {
        throw new Error(data.message || '삭제 실패');
      }

      // ✅ 여기서 alert
      alert(data.message || '삭제되었습니다.');

      // ✅ 그 다음 화면 갱신
      reloadCommunity();
    })
    .catch(err => {
      alert(err.message || '삭제 실패');
    });
}



/* ====== 공지 수정 저장: 즉시 DB 반영 ====== */
function saveNoticeEdit(noticeNo, btn) {
  const titleEl = document.getElementById('editTitle_' + noticeNo);
  const contentEl = document.getElementById('editContent_' + noticeNo);

  const title = titleEl ? titleEl.value.trim() : '';
  const content = contentEl ? contentEl.value.trim() : '';

  if (!title || !content) {
    alert('제목/내용을 입력해주세요.');
    return;
  }

  const url = (window.CTX || '') + API.updateNotice;

  postForm(url, {
    noticeNo: noticeNo,
    noticeTitle: title,
    noticeContent: content
  })
  .then(data => {
    if (!data || data.success !== true) {
      throw new Error((data && data.message) ? data.message : '수정 실패');
    }
    alert(data.message || '수정 완료!');
    reloadCommunity();
  })
  .catch(err => alert(err.message || '수정 실패'));
}


/* ====== QNA 답변 저장: 즉시 DB 반영 ====== */
function saveAnswer(pk) {
  var replyEl = document.getElementById('reply_' + pk);
  var reply = replyEl ? replyEl.value.trim() : '';

  if (!reply) {
    alert('답변을 작성해주세요.');
    return;
  }

  var url = (window.CTX || '') + API.updateAnswer;

  postForm(url, { no: pk, content: reply })
    .then(function (data) {
      if (!data || data.success !== true) {
        throw new Error((data && data.message) ? data.message : '답변 저장 실패');
      }
	  alert(data.message || '답변이 완료되었습니다.');
	  
      reloadCommunity();
    })
    .catch(function (err) {
      alert(err.message || '답변 저장 실패');
    });
}

/* ====== 검색 필터(화면 검색) ====== */
function filterComm(input) {
  var val = (input && input.value ? input.value : '').toLowerCase();
  var items = document.querySelectorAll('.comm-item');

  for (var i = 0; i < items.length; i++) {
    var item = items[i];
    var titleEl = item.querySelector('.comm-title');
    var title = titleEl ? titleEl.innerText.toLowerCase() : '';

    // 공지 내용은 data-content로도 검색 가능하게(서버 렌더링 때 data-content 넣으면)
    var dc = item.getAttribute('data-content') || '';
    dc = dc.toLowerCase();

    // QNA는 comm-text 없을 수도 있으니 안전 처리
    var textEl = item.querySelector('.comm-text');
    var text = textEl ? textEl.innerText.toLowerCase() : '';

    if (title.indexOf(val) !== -1 || text.indexOf(val) !== -1 || dc.indexOf(val) !== -1) {
      item.style.display = '';
    } else {
      item.style.display = 'none';
    }
  }
}


function openNoticeEdit(noticeNo, btn) {
  const card = btn.closest('.comm-card');
  if (!card) return;

  // 카드가 닫혀있으면 먼저 열기 (toggleCard 사용)
  if (!card.classList.contains('is-open')) {
    toggleCard(card);
  }

  const detail = card.querySelector('.notice-detail');
  const titleEl = card.querySelector('.comm-title');
  const textEl  = card.querySelector('.comm-text');

  const oldTitle = titleEl ? titleEl.innerText.trim() : '';
  const oldContent = textEl ? textEl.innerText.trim() : '';

  let editor = detail.querySelector('.notice-editor');

  // ✅ 이미 열려있으면 닫기(스르륵)
  if (editor) {
    closeEditor(editor);   // ✅ remove 말고 애니메이션 닫기
    return;
  }

  // ✅ 새 에디터 만들기
  editor = document.createElement('div');
  editor.className = 'notice-editor mt-4 border-t border-slate-800/50 pt-4';
  editor.innerHTML = `
    <label class="comm-label">Edit Title</label>
    <input id="editTitle_${noticeNo}" class="custom-input mb-3" value="${escapeHtml(oldTitle)}" />

    <label class="comm-label">Edit Content</label>
    <textarea id="editContent_${noticeNo}" class="custom-input mb-3" rows="5">${escapeHtml(oldContent)}</textarea>

    <div class="flex gap-2">
      <button class="flex-1 bg-sky-500 text-black py-3 rounded-xl font-black text-sm hover:bg-sky-400 transition-colors"
              onclick="event.stopPropagation(); saveNoticeEdit('${noticeNo}', this);">
        수정 저장
      </button>
      <button class="flex-1 bg-slate-800 text-slate-200 py-3 rounded-xl font-black text-sm hover:bg-slate-700 transition-colors"
              onclick="event.stopPropagation(); closeEditor(this);">
        취소
      </button>
    </div>
  `;

  detail.appendChild(editor);

    editor.addEventListener('click', function(e){
    e.stopPropagation();
  });

  
  // ✅ 높이 조절은 이 한 줄만 (스르륵 늘어남)
  expandDetail(card);
}

function escapeHtml(str) {
  if (str === null || str === undefined) str = '';
  str = String(str);

  return str
    .split('&').join('&amp;')
    .split('<').join('&lt;')
    .split('>').join('&gt;')
    .split('"').join('&quot;')
    .split("'").join('&#039;');
}

function closeEditor(btnOrEditor) {
  var editor = null;

  if (btnOrEditor && btnOrEditor.classList && btnOrEditor.classList.contains('notice-editor')) {
    editor = btnOrEditor;
  } else if (btnOrEditor && btnOrEditor.closest) {
    editor = btnOrEditor.closest('.notice-editor');
  }
  if (!editor) return;

  var card = editor.closest('.comm-card');
  if (!card) { editor.remove(); return; }

  var detail = card.querySelector('.comm-detail');
  if (!detail) { editor.remove(); return; }

  // ✅ 현재 높이 고정(현재 열린 높이)
  detail.style.maxHeight = detail.scrollHeight + 'px';

  // ✅ editor를 제거했을 때의 목표 높이를 "미리 계산"하기 위해,
  // editor를 잠깐 display:none 처리해서 scrollHeight를 구한 뒤 다시 복구
  var prevDisplay = editor.style.display;
  editor.style.display = 'none';
  var target = detail.scrollHeight;  // editor 없는 높이
  editor.style.display = prevDisplay;

  // ✅ 한 프레임 뒤 목표 높이로 줄이기(부모 max-height transition만 사용)
  requestAnimationFrame(function () {
    detail.style.maxHeight = target + 'px';
  });

  // ✅ transition 끝나면 editor 제거 + maxHeight를 최종값으로 한 번 더 고정
  var done = false;
  function onEnd(e) {
    if (done) return;
    if (e.propertyName !== 'max-height') return;
    done = true;

    detail.removeEventListener('transitionend', onEnd);

    editor.remove();
    // 제거 후 혹시 높이가 살짝 달라지면 최종 보정
    detail.style.maxHeight = detail.scrollHeight + 'px';
  }

  detail.addEventListener('transitionend', onEnd);
}




function expandDetail(card) {
  var detail = card.querySelector('.comm-detail');
  if (!detail) return;

  detail.style.overflow = 'hidden';
  detail.style.maxHeight = '0px';

  requestAnimationFrame(function () {
    detail.style.maxHeight = detail.scrollHeight + 'px';
  });
}


function collapseDetail(card) {
  var detail = card.querySelector('.comm-detail');
  if (!detail) return;

  detail.style.overflow = 'hidden';
  // 현재 높이 고정 -> 0으로
  detail.style.maxHeight = detail.scrollHeight + 'px';
  requestAnimationFrame(function () {
    detail.style.maxHeight = '0px';
  });
}


function toggleCard(card) {
  if (!card || !card.classList.contains('comm-card')) return;
  if (card.classList.contains('is-empty')) return;

  const isOpen = card.classList.contains('is-open');

  // 다른 열린 카드 닫기
  document.querySelectorAll('.comm-card.is-open').forEach(openCard => {
    if (openCard === card) return;
    openCard.classList.remove('is-open');
    collapseDetail(openCard);
  });

  // 현재 카드 토글
  if (isOpen) {
    card.classList.remove('is-open');
    collapseDetail(card);
  } else {
    card.classList.add('is-open');
    expandDetail(card);
  }
}

