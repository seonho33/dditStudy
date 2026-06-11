// assets/js/chatbot.js
(function () {
  // 혹시 중복 로드되면 이벤트 중복 방지
  if (window.__CHATBOT_INIT__) return;
  window.__CHATBOT_INIT__ = true;

  const contextPath = (window.APP && window.APP.contextPath) ? window.APP.contextPath : '';

  const chatModal = document.getElementById('chatModal');
  const chatBtn = document.getElementById('chatBtn');
  const closeChatBtn = document.getElementById('closeChatBtn');
  const sendBtn = document.getElementById('sendBtn');
  const chatInput = document.getElementById('chatInput');
  const chatWindow = document.getElementById('chat-window');
  const loading = document.getElementById('loading');

  if (!chatModal || !chatBtn || !closeChatBtn || !sendBtn || !chatInput || !chatWindow || !loading) {
    console.warn('[CHATBOT] 필요한 DOM 요소가 없습니다. (페이지에 모달 HTML이 있는지 확인)');
    return;
  }

  let initialized = false;

  function resetChat() {
    chatWindow.innerHTML = '';
    initialized = false;
  }

  function addMessage(message, sender) {
    const div = document.createElement('div');
    div.className = 'message ' + sender;
    div.innerHTML = message;
    chatWindow.appendChild(div);
    chatWindow.scrollTop = chatWindow.scrollHeight;
  }

  function openChatModal() {
    chatModal.style.display = 'flex';

    if (!initialized) {
      addMessage(
        "반갑습니다! <b>영달봇</b>입니다 🍊<br>원하시는 메뉴를 입력해주세요!",
        "bot"
      );
      initialized = true;
    }

    setTimeout(() => chatInput.focus(), 100);
  }

  chatBtn.addEventListener('click', openChatModal);

  chatModal.addEventListener('click', (e) => {
    if (e.target === chatModal) {
      chatModal.style.display = 'none';
      resetChat();
    }
  });

  closeChatBtn.addEventListener('click', () => {
    chatModal.style.display = 'none';
    resetChat();
  });

  sendBtn.addEventListener('click', sendMessage);

  function sendMessage() {
    const msg = chatInput.value.trim();
    if (!msg) return;

    const userDiv = document.createElement('div');
    userDiv.className = 'message user';
    userDiv.textContent = msg;
    chatWindow.appendChild(userDiv);

    chatInput.value = '';
    chatWindow.scrollTop = chatWindow.scrollHeight;

    loading.style.display = 'block';

	fetch(contextPath + '/BotAnswer.do', {
	  method: 'POST',
	  headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
	  body: 'keyword=' + encodeURIComponent(msg)
	})
	.then(function(res){
	  var ct = (res.headers.get('content-type') || '').toLowerCase();
	  return res.text().then(function(text){
	    if (!ct.includes('application/json')) {
	      console.error('[CHATBOT] Not JSON response:', ct, text);
	      throw new Error('서버 응답이 JSON이 아님');
	    }
	    return JSON.parse(text);
	  });
	})
	.then(function(data){
	  loading.style.display = 'none';
	  console.log('[CHATBOT] data =', data);

	  var category = (data.category || '');
	  var isIntent = category.endsWith('_선택유도');

	  // ✅ message \n 처리
	  var msgHtml = (data.message || '추천 결과를 가져왔어!').replaceAll('\\n', '<br>');

	  var botDiv = document.createElement('div');
	  botDiv.className = 'message bot';
	  botDiv.innerHTML = msgHtml;
	  chatWindow.appendChild(botDiv);

	  if (Array.isArray(data.items) && data.items.length > 0) {
	    var listDiv = document.createElement('div');
	    listDiv.className = 'message bot';
	    listDiv.innerHTML = renderItems(data.items);
	    chatWindow.appendChild(listDiv);
	  } else {
	    // ✅ 선택유도면 empty 문구 출력 금지
	    if (!isIntent) {
	      var emptyDiv = document.createElement('div');
	      emptyDiv.className = 'message bot';
	      emptyDiv.textContent = '추천 결과가 없어요 😢';
	      chatWindow.appendChild(emptyDiv);
	    }
	  }

	  chatWindow.scrollTop = chatWindow.scrollHeight;
	})

	.catch(function(err){
	  loading.style.display = 'none';
	  console.error('[CHATBOT] 요청 실패:', err);

	  var botDiv = document.createElement('div');
	  botDiv.className = 'message bot';
	  botDiv.textContent = '오류가 발생했습니다. (콘솔/네트워크 응답 확인)';
	  chatWindow.appendChild(botDiv);
	  chatWindow.scrollTop = chatWindow.scrollHeight;
	});

  }
  
  function renderItems(items) {
    return `
      <div style="display:flex; flex-direction:column; gap:10px; margin-top:8px;">
        ${items.map(function(it){
          // ✅ 너 콘솔에 찍힌 키들(STORENAME/STOREADDR/STOREID)까지 모두 대응
          var storeId   = pick(it, 'storeId', 'STORE_ID', 'STOREID');
          var storeName = pick(it, 'storeName', 'STORE_NAME', 'STORENAME');
          var storeAddr = pick(it, 'storeAddr', 'STORE_ADDR', 'STOREADDR');

          // (있으면 표시용)
          var rating    = pick(it, 'rating', 'RATING');
          var category  = pick(it, 'category', 'CATEGORY');

          var title = storeName || '이름없음';
          var sub   = (storeAddr || '') + (rating ? (' · ⭐ ' + rating) : '') + (category ? (' · ' + category) : '');

          // ✅ 이미지는 무조건 storePicture만(없으면 기본)
          var storePic  = pick(it, 'storePicture', 'STORE_PICTURE', 'STOREPICTURE');
          var imgUrl = storePic
            ? (contextPath + '/images/upload/store/' + encodeURIComponent(storePic))
            : (contextPath + '/images/default-store.png');

          var link = storeId
            ? (contextPath + '/storeDetail.do?id=' + encodeURIComponent(storeId))
            : (contextPath + '/storeSearch.do?keyword=' + encodeURIComponent(storeName));

          return `
            <a href="${link}" style="display:block; padding:12px; border:1px solid #ffe0c0; background:#fff7ed; border-radius:14px; text-decoration:none;">
              <img src="${imgUrl}"
                   style="width:100%; height:120px; object-fit:cover; border-radius:12px; margin-bottom:8px;"
                   onerror="this.src='${contextPath}/images/default_profile.png'">
              <div style="font-weight:900; color:#111827;">${escapeHtml(title)}</div>
              <div style="font-size:12px; font-weight:700; color:#6b7280; margin-top:4px;">${escapeHtml(sub)}</div>
            </a>
          `;
        }).join('')}
      </div>
    `;
  }



  function escapeHtml(str) {
    str = (str === null || str === undefined) ? '' : String(str);

    return str
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#039;');
  }

  function pick(it, ...keys) {
    for (const k of keys) {
      if (it && it[k] !== undefined && it[k] !== null && String(it[k]).trim() !== '') return it[k];
    }
    return '';
  }


  chatInput.addEventListener('keydown', (e) => {
    if (e.key === 'Enter') sendMessage();
  });
})();
