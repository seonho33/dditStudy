const foodPriceCalc = () =>{
	let priceAll = document.querySelectorAll(".cartFoodPrice");
	let numberAll = document.querySelectorAll(".cartFoodNumberInput");
	let cartFoodSumAll = document.querySelectorAll(".cartFoodSum")
	
	numberAll.forEach((number,idx) =>{
		let price = Number(priceAll[idx].innerText);
		let foodNum = Number(number.value)||0;
		let sum = price*foodNum;
		cartFoodSumAll[idx].innerText=sum;
	})
}

const resetFoodCart =() =>{
	document.querySelectorAll(".cartFoodNumberInput").forEach(input =>input.value = 0);
	document.querySelectorAll(".cartFoodSum").forEach(td=>td.textContent="");
	
}