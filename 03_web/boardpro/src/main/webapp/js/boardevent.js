/**
 * 
 */
let currentPage =1;



let reply = {}; //나중에 필요에 따라 속성을 추가가능 댓글 등록시

boardPro = function() {
	
	//form 태그를 검색
	vff=document.querySelector("#ff");
	
	//submit 이벤트는 언제 실행되냐? -> 검색버튼, 페이지번호, 이전 다음 클릭할 때 발생
	//submit이벤트를 실행하기 위해서 - vff.requestSubmit()을 호출해야한다..
	vff.addEventListener('submit',function(e){
		
		//고유의 submit 기능을 제거 - submit 입력시 페이지가 바뀌지 않도록 함
		e.preventDefault();arguments
		
		//비동기 요청전송 - fetch실행 - 외부 script 파일 board.js 로 작성
		fn_pageListServer(); //BoardList.do를 호출한다
	
	})
	
	//검색버튼 이벤트 클릭 - submit 이벤트 요청
	
	document.querySelector("#search").addEventListener('click',function(e){
		
		currentPage =1;
		
		vff.page.value = currentPage;
		
		
		vff.requestSubmit()
		
	})

	document.querySelector("#stype").addEventListener('change',function(){
		if(this.value=="")
			document.querySelector("#sword").value = "";
		
	})
	
	//이전 다음 페이지번호 이벤트 클릭(위임방식) - submit 이벤트 요청
	document.querySelector("#pagelist").addEventListener('click',function(e){
		//어떤 요소가 이벤트를 발생시켰는지 판단하기 위함..
		target = e.target;
		
		//page 번호들 - next, prev 에서 사용
		let pages = document.querySelectorAll(".pageno")
		
		if(target.id=="prev"){
			//submit 이벤트 요청 - 준비작업 필요
			currentPage = parseInt(pages[0].textContent)-1;
			vff.page.value= currentPage;
			vff.requestSubmit()
			
		}else if(target.id=="next"){
			//submit 이벤트 요청 - 준비작업 필요
			currentPage = parseInt(pages[pages.length-1].textContent) +1;
			vff.page.value = currentPage;
			vff.requestSubmit()
			
		}else if(target.classList.contains("pageno")){
			//submit 이벤트 요청 - 준비작업 필요
			
			currentPage = Number(target.textContent);
			//=currentPage = parseInt(target.textContent);
			vff.page.value = currentPage;
			
			vff.requestSubmit()
			
		}
	})
	
	//글쓰기버튼 클릭-이벤트
	document.querySelector("#writebtn").addEventListener('click',function(){
		
		if(uvo==null){
			alert("로그인이 필요합니다");
			return;
		}
		//글쓰기 모델창 검색
		wmodal = document.querySelector("#wModal")
		
		//모델 객체 생성
		btsWmodal = new bootstrap.Modal(wmodal);
		
		//모델창 띄우기
		btsWmodal.show();
		
		//현재 로그인 한 사람의 이름을 모델창에 출력
		wmodal.querySelector("#writer").value = uvo.mem_name;
		
		wmodal.querySelector("#writer").readOnly = true;
	})
	
	//글 쓰기 모델창에서 데이터 입력후 전송버튼 클릭
	document.querySelector("#send").addEventListener('click',function(){
		//입력한 값을 가져온다 -writer, subject, password, mail, content
		
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
		 //댓글 등록 - 이런 이벤트는 #accordion 를 이용해서 버블링 위임방식으로 처리
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
				alert(idx + "번글 댓글달기");
//				등록버튼을 기준으로 textarea에 입력한 값을 가져온다
				tvalue = target.previousElementSibling.value;
				if(!tvalue){
					alert("댓글 내용을 입력하세요")
					return;
				}
				//서버로 전송 - replytab테이블에 저장할 내용
				//renum,bonum,name,cont,redate
				
				reply.bonum = idx;			//게시판글번호
				reply.name = uvo['mem_name']; //
				reply.cont = tvalue;
				
				//서버로 전송 -board.js의 fetch
				fn_replyInsertServer();//성공하면 댓글 리스트 다시출력
				
			}else if(eventName =="subject"){
//				alert(idx + "번글 댓글 리스트 가져오기");
//				서버로 전송 - idx 값이 필요
				fn_replyListServer();

				//조회수 증가
				if(target.getAttribute("aria-expanded")==="true"){
					fn_hitUpdateServer();
				}
			}else if(eventName =="re_delete"){
				
				fn_replyDeleteServer();
			}
		
	})
	
}