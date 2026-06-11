jsonform = async function() {
	
	//form 태그를 검색
	formvo = document.querySelector("#폼아이디");
	fdata = new FormData(formvo);
	wbody = Object.fromEntries
	reso = await fetch(`서블릿(컨트롤러) 위치`,{
		method	: "post",
		headers : {"content-type" : "application/json;charset=utf-8"},
		body	: JSON.stringify(wbody)	
	})
	}
	
	
		
	document.querySelector("#send").addEventListener('click',function(){
		
		wform = document.querySelector("#wform");
		wdata = new FormData(wform);
		
		wbody = Object.fromEntries(wdata);
		console.log(wbody)
		
		//서버로 전송 - board.js 에서 fetch전송 -db저장
		fn_boardInsertServer();
		
		
		//입력한 데이터지우고 form 초기화
		wform.reset();
		
		//모델창 닫기
		btsWmodal.hide();
		
		//모달이 닫힐때 포커스 문제 해결
		 document.querySelector('#wModal').addEventListener('hide.bs.modal', function(){
			 document.querySelectorAll('#wModal *').forEach( m =>  m.blur());
		 });
	 })	 
		 
		 
		 //댓글리스트 = 게시글 제목 클릭시 또는 댓글쓰기 후 저장성공하면..
		 //게시글 수정, 게시글 삭제, 댓글 삭제, 댓글수정
		 //댓글 등록 - 이런 이벤트는 #accordion 를 이용해서 위임방식으로 처리
	 document.querySelector("#accordion").addEventListener('click',function(e){
			
			target = e.target;
			
			//이벤트 대상 중에서 class가 action인 요소 찾기
			const evAction = target.closest('.action');
			//class가 action 이 아닌 요소는 이벤트 대상에서 제외한다
			if(!evAction) return;
			
			eventName = target.dataset.name.trim();
			idx=target.dataset.idx.trim();
			
			console.log(eventName, idx);
			
			if(eventName =="delete"){
//				alert(idx + "번글 삭제");
			}else if(eventName =="modify"){
//				alert(idx + "번글 수정");
			}else if(eventName =="reply"){
//				alert(idx + "번글 댓글달기");
			}else if(eventName =="subject"){
//				alert(idx + "번글 댓글 리스트 가져오기");

//				서버로 전송 - idx 값이 필요
				fn_replyListServer();

			}
		
	})
	
}