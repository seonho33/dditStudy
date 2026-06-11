/**
 * 
 */

//댓글 삭제하기
const fn_replyDeleteServer =async() =>{
	
	try{
		resp = await fetch(`${mypath}/ReplyDete.do?renum=${idx}`);
		
		data = await resp.json();
		
		console.log(data);
		
		if(data.flag == "ok"){
			//target을 기준으로 .reply-body를 검색
			//검색된 .reply-body 를 삭제
			target.closest(".reply-body").remove();
			
		}
		
	}catch(err){
		console.log(err);
	}
	
	
}


//조회수 증가하기
const fn_hitUpdateServer = async() =>{

	try{
		resp = await fetch(`${mypath}/HitUpdate.do?num=${idx}`)
		
		if(resp.ok) data = await resp.json();
		
		//data 받아서 출력
		//출력은 아니고 화면의 조회수 부분을 갱신
		//화면에 보이는 현재의 조회수 값을 가져와서 +1 하고
		//화면을 다시 갱신
		if(data.flag == "ok"){
			vcard = target.closest(".card");
			hitValue = Number(vcard.querySelector(".hi").innerText.trim()) +1;

			vcard.querySelector(".hi").innerText = hitValue;
		}
		
		
	}catch(err){
		console.log(err)
	}	
}


const fn_replyInsertServer = async() =>{
	
	try{
		resp = await fetch(`${mypath}/ReplyInsert.do`,{
			method : "post",
			headers: {"content-type" : "application/json;charset = utf-8"},
			body : JSON.stringify(reply)
	})
	
	datas = await resp.json();
	console.log(datas);
	
	//성공하면 댓글리스트 출력
	if(datas['flag']=="ok")	fn_replyListServer();
	else alert("댓글등록실패")

		}catch(err){
		
	}
}



//댓글 리스트 가져오기
const fn_replyListServer = async()=>{
	
	try{
		resp=await fetch(`${mypath}/ReplyList.do?bonum=${idx}`);
		
		datas = await resp.json()
		
		console.log(datas)
		//출력
		const replyList = datas.replyData;
		const rcode = replyList.map(rlist=>{
			
			//내 글에 수정 삭제 버튼 표시하기
			let btns = "";
			//현재 로그인한 사람과 글 작성자가 같은지 확인
			if(uvo != null && uvo.mem_name == rlist.name){
				btns = `<input type="button" data-idx="${rlist.renum}" data-name="re_delete"
						class="action" value="댓글삭제">
						<input type="button" data-idx="${rlist.renum}" data-name="re_modify"
						class="action" value="댓글수정">`
			}	
			
			return `
			<div class="reply-body">
				<div class="p12">
					<p class="p1">
						작성자:<span class="wr">${rlist.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						날짜 :<span class="da">${rlist.redate}</span>
					</p>
					<p class="p2">
						${btns}
					</p>
				</div>
				<pre class="p3 rcont">${rlist.cont}</pre>
			</div>`
		}).join("")
		
		
		//rcode를
		const card = target.closest('.card');
		
		//card 내부에 card-body rcode 추가
		const cdbody = card.querySelector(".card-body")

				//card영역에 기존에 이미 출력되어 있는 reply-body를 제거한다
		replyBody = card.querySelectorAll(".reply-body");
		replyBody.forEach(reply =>{
			reply.remove();
		})
		cdbody.insertAdjacentHTML('beforeend',rcode);
			
		
	}catch(err){
		console.log(err);
	}
	
}

//게시글 저장하기
const fn_boardInsertServer = async () =>{
	
	alert("글저장")
	//post 방식으로 비동기 전송
	resp = await fetch(`${mypath}/BoardWrite.do`,{
			method : "post",
			headers : {"content-type" : "application/json;charset=utf-8"},
			body : JSON.stringify(wbody)
		})
		console.log(wbody)
	
		//저장 성공시 응답결과 데이터를 json 직렬화 데이터를 역직렬화 하여
		//script 객체로 변겨한다
		datas = await resp.json();
		console.log(datas);
		//응답결과를 출력 - 성공 또는 실패
		//성공시 리스트 출력
		//fn_pageListServer();
		if(datas['flag']=="ok") fn_pageListServer();
		else alert("저장실패")
		
}



//게시글 리스트 가져오기
//post 방식으로 BoardList.do를 실행
const fn_pageListServer= async ()=>{
	
	//ff 의 데이터 가져오기 페이지, stype, sword
	const vform = new FormData(vff);
	fdata = Object.fromEntries(vform);
	
	console.log(fdata);
	
	
	resp = await fetch(`${mypath}/BoardList.do`,{
		method : "post",
		headers : {"content-type" : "application/json;charset=utf-8"},
		body : 	JSON.stringify(fdata)
	})
	
	//boardlist -> 
	//결과를 json() 으로 받아서
	//여기서 출력 형태를 만든다
	//어디다 출력?
	//board.jsp의 accordion 영역에 출력해야함
	//board.jsp의 pagelist 영역에 출력
	dataMap = await resp.json(); // ("datas",list)--게시글 3개 , ("pglist",pglist)--pg 리스트
	
	const boardList = dataMap.datas;
	
	const pglist = dataMap.pglist;
	
//	boardList.map(function(blist,index){
//	})

	listboard = boardList.map(blist=>{
		//내 글에 수정 삭제 버튼 표시하기
		let btns = "";
		
		if(uvo != null && uvo.mem_name == blist.writer){
			btns = `<input type="button" data-idx="" data-name="${blist.num}"
					class="action" value="삭제">
					<input type="button" data-idx="" data-name="${blist.num}"
					class="action" value="수정">`
		}	
		return `
				<div class="card">
					<div class="card-header">
						<a class="btn action subject" data-idx="${blist.num}" data-name="subject"
							data-bs-toggle="collapse" href="#collapse${blist.num}">
							${blist.subject} </a>
					</div>
					<div id="collapse${blist.num}" class="collapse"
						data-bs-parent="#accordion">
						<div class="card-body">
							<div class="p12">
								<p class="p1">
									작성자:<span class="wr">${blist.writer}</span>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 이메일:<span class="em">${blist.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									조회수:<span class="hi">${blist.hit}</span>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 날짜 :<span class="da">${blist.wdate}</span>
								</p>
								<p class="p2">
								${btns}
								</p>
							</div>
							<pre class="wp3 p3"></pre>
							<p class="p4">
								<textarea rows="" cols="50"></textarea>
								<input type="button" data-idx="${blist.num}" data-name="reply" class="action"
									value="등록">
							</p>
						</div>
					</div>
				</div>
		`	
	}).join("");
	
	
	document.querySelector("#accordion").innerHTML = listboard;
	document.querySelector("#pagelist").innerHTML = pglist;

}