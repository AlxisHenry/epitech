document.addEventListener('DOMContentLoaded', () => {
	const form = document.querySelector('form')
	const brandDiv = document.createElement('div')
	brandDiv.classList.add('brand')
	document.querySelector('.form-group:nth-child(2)').appendChild(brandDiv)
	const typeDiv = document.createElement('div')
	typeDiv.classList.add('type')
	document.querySelector('.form-group').appendChild(typeDiv)

	form.addEventListener('keyup', (e) => {
		e.preventDefault()
		fetchDatabase(brandDiv, typeDiv)
	})

	fetchDatabase(brandDiv, typeDiv)
})

function fetchDatabase(brandDiv, typeDiv) {
	let brand = document.querySelector('input[name="brand"]').value,
		type = document.querySelector('input[name="type"]').value
	fetch(`task04.php?${new URLSearchParams({ brand, type })}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		}
	}).then(response => response.json())
		.then(data => {
			if (data.length === 0) return
			brandDiv.innerHTML = ''
			typeDiv.innerHTML = ''
			for (let key in data) {
				for (let value of data[key]) {
					let div = document.createElement('div')
					div.role = 'alert'
					div.classList.add('alert', 'mt-4')
					div.textContent = value[1]
					if (key === "brand") {
						div.classList.add(value[0] === 0 ? 'alert-danger' : 'alert-success')
						brandDiv.appendChild(div)
					} else if (key === "type") {
						div.classList.add(value[0] === 0 ? 'alert-danger' : 'alert-success')
						typeDiv.appendChild(div)
					}
				}
			}
		})
		.catch(error => {
			console.log(error)
		})
}
