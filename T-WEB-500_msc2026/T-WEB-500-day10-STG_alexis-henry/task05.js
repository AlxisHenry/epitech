document.addEventListener('DOMContentLoaded', () => {
	const form = document.querySelector('form')

	const brandDiv = document.createElement('div')
	brandDiv.classList.add('brand')
	document.querySelector('.form-group:nth-child(2)').appendChild(brandDiv)

	const typeDiv = document.createElement('div')
	typeDiv.classList.add('type')
	document.querySelector('.form-group').appendChild(typeDiv)

	const priceDiv = document.createElement('div')
	priceDiv.classList.add('price')
	document.querySelector('.form-group:nth-child(3)').appendChild(priceDiv)

	const numberDiv = document.createElement('div')
	numberDiv.classList.add('number')
	document.querySelector('.form-group:nth-child(4)').appendChild(numberDiv)

	form.addEventListener('keyup', (e) => {
		e.preventDefault()
		fetchDatabase(brandDiv, typeDiv, priceDiv, numberDiv)
	})

	form.addEventListener('change', (e) => {
		e.preventDefault()
		fetchDatabase(brandDiv, typeDiv, priceDiv, numberDiv)
	})

	form; addEventListener('submit', (e) => {
		e.preventDefault()
		search()
	})
})

function fetchDatabase(brandDiv, typeDiv, priceDiv, numberDiv) {
	let brand = document.querySelector('input[name="brand"]').value,
		type = document.querySelector('input[name="type"]').value,
		price = document.querySelector('input[name="price"]').value,
		number = document.querySelector('input[name="number"]').value
	fetch(`task05.php?${new URLSearchParams({ brand, type, price, number })}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		}
	}).then(response => response.json())
		.then(data => {
			console.log(data)
			if (data.length === 0) return
			let divs = [brandDiv, typeDiv, priceDiv, numberDiv];
			for (let div of divs) {
				div.innerHTML = ''
			}
			let errorFound = false
			for (let key in data) {
				if (data[key].length === 0) continue
				errorFound = true
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
					} else if (key === "price") {
						div.classList.add(value[0] === 0 ? 'alert-danger' : 'alert-success')
						priceDiv.appendChild(div)
					} else if (key === "number") {
						div.classList.add(value[0] === 0 ? 'alert-danger' : 'alert-success')
						numberDiv.appendChild(div)
					}
				}
			}
			document.querySelector('.search').disabled = errorFound
		})
		.catch(error => {
			console.log(error)
		})
}

function search() {
	const body = document.querySelector('tbody')
	body.innerHTML = ''
	showLoader(document.querySelector('tbody'), false)
	let brand = document.querySelector('input[name="brand"]').value,
		type = document.querySelector('input[name="type"]').value,
		price = document.querySelector('input[name="price"]').value,
		number = document.querySelector('input[name="number"]').value
	fetch(`task05.php?search=true&${new URLSearchParams({ brand, type, price, number })}`, {
		method: 'GET',
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		}
	}).then(response => response.json())
		.then(data => {
			let rows = [];
			for (let row of data) {
				let tr = document.createElement('tr')
				for (let key of Object.keys(row)) {
					let td = document.createElement('td')
					td.textContent = row[key]
					tr.appendChild(td)
				}
				rows.push(tr)
			}
			setTimeout(() => {
				hideLoader(false)
				for (let row of rows) {
					body.appendChild(row)
				}
			}, 100)
		})
		.catch(error => {
			console.log(error)
		})
}
