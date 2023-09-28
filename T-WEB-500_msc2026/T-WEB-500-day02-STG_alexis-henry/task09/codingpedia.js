document.addEventListener("DOMContentLoaded", function() {
	const inputs = document.querySelectorAll('input[name="sex"]');
	inputs.forEach(function(input) {
		input.addEventListener('change', function(e) {
			let label = document.querySelector('label[for="' + e.target.id + '"]');
			label.innerHTML = label.innerHTML + ' (selected)';
			inputs.forEach(function(input2) {
				if (input2.id !== e.target.id) {
					let label2 = document.querySelector('label[for="' + input2.id + '"]');
					label2.innerHTML = label2.innerHTML.replace(' (selected)', '');
				}
			});
		});
	});
	document.querySelector('#date').value = new Date().toISOString().split('T')[0];
});