document.addEventListener('DOMContentLoaded', function () {
	let modalElement = document.getElementById('myModal');
	let modal = new bootstrap.Modal(modalElement);

	let alertElement = document.createElement('div');
	alertElement.className = 'alert alert-success mt-2';
	alertElement.setAttribute('role', 'alert');
	alertElement.textContent = 'This is a Bootstrap alert created with JavaScript!';
	document.querySelector('.container').appendChild(alertElement);

	let showModalButton = document.getElementById('showModalBtn');
	showModalButton.addEventListener('click', function () {
		modal.show();
	});
});

function showLoader(element = document.querySelector('form'), hideButton = true) {
	if (hideButton) document.querySelector('.btn-load').style.display = 'none';
	element.insertAdjacentHTML('beforeend', `<div class="spinner-border mt-4" role="status">
		<span class="visually-hidden">Loading...</span>
	</div>`);
}

function hideLoader(hideButton = true) {
	if (hideButton) document.querySelector('.btn-load').style.display = 'block';
	document.querySelector('.spinner-border')?.remove();
}

function clearAlert() {
	document.querySelector('.ajax')?.remove();
}

function showAlert(data = null, error = false) {
	let alert = ""
	if (error || data === null) {
		alert = `<div class="alert alert-danger ajax mt-4" role="alert">
			An error occured
		</div>`
	} else {
		alert = `<div class="alert alert-success ajax mt-4" role="alert">
			${data}
		</div>`
	}
	setTimeout(() => {
		hideLoader();
		document.querySelector('form').insertAdjacentHTML('beforeend', alert);
	}, 100)
}