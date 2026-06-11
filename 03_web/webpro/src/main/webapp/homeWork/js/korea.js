document.addEventListener('DOMContentLoaded', () => {
const cart = (food) => {
	let name = "";
	let price = 0;
	
	if(food == "k1"){
		name = "김치찌개";
		price = 10000;
	}else if(food == "k2"){
		name = "불고기";
		price = 10000;
	}else if(food == "k3"){
		name = "비빔밥";
		price = 10000;
	}else if(food == "k4"){
		name = "제육볶음";
		price = 10000;
	}
	
	document.querySelector("#food-name").value = name;
	document.querySelector("#food-price").value = price;
	document.querySelector(".cartData").submit;
	
/*	const shoppingcartObj = document.querySelector("#shopcart-iframe");
	shoppingcartObj.src = `/webpro/homeWork/main/shopcart.jsp?name=${name}&price=${price}`;*/
	}
});