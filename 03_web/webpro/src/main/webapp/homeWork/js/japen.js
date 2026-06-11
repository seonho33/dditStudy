const cart = (food) => {
	let name = "";
	let price = 0;
	
	if(food == j1){
		name = "돈부리";
		price = 10000;
	}else if(food == j2){
		name = "돈코츠라멘";
		price = 10000;
	}else if(food == j3){
		name = "초밥";
		price = 10000;
	}
	
	document.querySelector("#food-name").value = name;
	document.querySelector("#food-price").value = price;
	document.querySelector(".cartData").submit;
}