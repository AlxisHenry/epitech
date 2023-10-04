document.addEventListener("DOMContentLoaded", function() {
	document.querySelectorAll("p").forEach(function(p) {
		p.addEventListener("mouseover", function() {
			p.classList.add("blue");
		});
		p.addEventListener("mouseout", function() {
			p.classList.remove("blue");
		});
		p.addEventListener("click", function() {
			p.classList.toggle("highlighted");
		});
	});
});