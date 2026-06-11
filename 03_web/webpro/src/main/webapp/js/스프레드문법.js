window.onload= () =>{
	//클릭할 버튼 찾기..
	let clickB = document.querySelector("#btn1");
	
	//이벤트 핸들러 작성
/* 	click8.onclick=()=>{} */

	const arr=[];
	
	const maxNum = (...args) =>{
		
		let vmax = args[0];
		
		for(i=1; i<args.length;i++){
			if(vmax<args[i]){
				vmax=args[i];
			}
		}
		return vmax;
	}
	
	clickB.addEventListener("click",()=>{
		
		while(true){
			//수 입력
			su = prompt("수 입력");
			
			//취소버튼 누르면 종료
			if(su==null||su=="")break;
			
			//배열에 저장
			arr.push(su);
		}
		//arr 배열 요소중 가장 큰 값 구하기
		console.log(arr);
		maxArr = maxNum(...arr);
		document.querySelector("#result1").innerHTML = maxArr; 
	})
}