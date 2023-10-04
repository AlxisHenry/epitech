document.addEventListener("DOMContentLoaded", function () {
	const btn = document.querySelector("button");
	btn.addEventListener("click", function () {
		const input = document.querySelector("input");
		appendInputValue(input.value);
	});
});

function appendInputValue(value) {
	let div = document.createElement("div");
	div.innerHTML = value;
	document.querySelector("section div").appendChild(div);
}