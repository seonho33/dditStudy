const cart = (food) => {
	let name = "";
	let price = 0;
	
	if(food == c1){
		name = "동파육";
		price = 10000;
	}else if(food == c2){
		name = "짜장면";
		price = 10000;
	}else if(food == c3){
		name = "짬뽕";
		price = 10000;
	}else if(food == c4){
		name = "탕수육";
		price = 10000;
	}
	
	document.querySelector("#food-name").value = name;
	document.querySelector("#food-price").value = price;
	document.querySelector(".cartData").submit;
}
