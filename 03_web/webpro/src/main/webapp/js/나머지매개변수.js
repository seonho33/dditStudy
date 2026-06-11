/**
 * 	
 * 
 */

const sum = (...args) => {
	//args배열 함수호출시 각 개별의 값들을 모아서 가져온다
	let sum = 0;
	args.forEach(function(ar){
		sum += ar;
	})
	return sum;
/*	document.querySelector("#result1").innerHTML = sum;*/
} 


const proc1 = () =>{
	//출력내용을 작성할 변수
	let str = "";
	
	//함수 호출해서 결과값을 res로 받는다
	res = sum(10,20);
	document.querySelector("#result1").innerHTML = res+"<br>";
	str += `sum(10,20) => ${res}<br>`;
	
	res = sum(100,200,300);
	document.querySelector("#result1").innerHTML += res+"<br>";
	str += `sum(100,200,300) => ${res}<br>`;

	document.querySelector("#result1").innerHTML += str;	
}

/* 나머지 매개변수2.html에서 호출하는 함수*/
const proc2 = () => {
	//찾을 단어 입력
	let str = prompt("찾을 문자 입력");
	//받는 배열 
	//찾기실행함수를 호출 - 결과값을 리턴 받는다
	result = searchKey2(str,'Java','JavaScript 기초',	'Java 기초','HTML과 CSS','JS 프로젝트');
	//출력
	document.querySelector("#result2").innerHTML = result;
}

//찾기 실행 함수
const searchKey = (keyword, ...items) =>{
	//keyword : 한개의 값을 받는 매개변수이고 찾고싶은 문자이다..
	//items : 여러개의 값을 받는 매개변수이고 keyword를 찾아야하는 배열집합이다
	//정해져있지 않은 수의 값들은 호출시에 각 개별로 흩어져있는 값들 배열로 모아서 전달받는다
	//items의 배열요소중에서 keyword로 받은 단어 문자를 찾는다...
	arr= [];
	//items의 배열요소중에서 keyword로 받은 단어 문자를 찾는다
/*	items.forEach(function(item,idx){}) */
	items.forEach((item,idx)=>{
		if(item.includes(keyword)){arr.push(item)};		
	})
	
	return arr;
}

//찾기 실행 함수
const searchKey2 = (keyword, ...items) =>{
	//keyword : 한개의 값을 받는 매개변수이고 찾고싶은 문자이다..
	//items : 여러개의 값을 받는 매개변수이고 keyword를 찾아야하는 배열집합이다
	//정해져있지 않은 수의 값들은 호출시에 각 개별로 흩어져있는 값들 배열로 모아서 전달받는다
	//items의 배열요소중에서 keyword로 받은 단어 문자를 찾는다...
	arr= [];
	
	//입력받은 값을 전부 소문자로 변경...
	const lowerK = keyword.toLowerCase();
	
	//items의 배열요소중에서 keyword로 받은 단어 문자를 찾는다
/*	items.forEach(function(item,idx){}) */
	items.forEach((item,idx)=>{
		if(item.toLowerCase().includes(lowerK)){arr.push(item)};		
	})
	
	return arr;
}