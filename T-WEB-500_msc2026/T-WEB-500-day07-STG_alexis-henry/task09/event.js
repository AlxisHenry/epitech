document.addEventListener("DOMContentLoaded", function() {
	const btn = document.querySelector("button");
	btn.addEventListener("click", function() {
		document.querySelectorAll("p").forEach(function(p) {
			p.remove();
		});
	});
});