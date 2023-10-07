const DELAY_BETWEEN_LOADS = 4000;

document.addEventListener('DOMContentLoaded', () => {
	document.querySelectorAll('.messages').forEach(chat => {
		chat.scrollTop = chat.scrollHeight;
	});
	document.querySelector('.fa-plus').addEventListener('click', () => {
		let authorName = prompt("Enter the name of the author");
		if (authorName.length > 0) {
			fetch('ajax.php', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
					'Accept': 'application/json'
				},
				body: JSON.stringify({
					action: 'addAuthor',
					author: authorName
				})
			}).then(response => response.json())
				.then(data => {
					if (data.status === 'ok') {
						location.reload();
					} else {
						alert("This author already exists!");
					}
				})
		} else {
			alert("You must enter the name of the author!")
		}
	});

	const chats = document.querySelectorAll('.chat');

	chats.forEach(chat => {
		const button = chat.querySelector('form button');
		chat.querySelector('form').addEventListener('keyup', () => {
			if (chat.querySelector('form textarea').value.length > 0) {
				button.classList.remove('disabled');
			} else {
				button.classList.add('disabled');
			}
		})
		button.addEventListener('click', (e) => {
			e.preventDefault();
			if (button.classList.contains('disabled')) return;
			const content = chat.querySelector('textarea').value;
			if (content.length > 0) {
				const author = chat.querySelector('.top .author span').innerHTML;
				fetch('ajax.php', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
						'Accept': 'application/json'
					},
					body: JSON.stringify({
						action: 'add',
						author: author,
						content: content
					})
				}).then(response => response.json())
					.then(data => {
						if (data.status === 'ok') {
							addMessageToChat(chat, data.message);
							chat.querySelector('textarea').value = '';
							button.classList.add('disabled');
						}
					});
			} else {
				alert("You must enter your name and message!")
			}
		});
		chat.querySelector('textarea').addEventListener('keyup', (e) => {
			if (e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				button.click();
			}
		});
		chat.querySelector('.fa-times').addEventListener('click', () => {
			let confirm = window.confirm("Are you sure you want to delete this chat?");
			if (confirm) {
				fetch('ajax.php', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
						'Accept': 'application/json'
					},
					body: JSON.stringify({
						action: 'delete',
						author: chat.dataset.author
					})
				}).then(response => response.json())
					.then(data => {
						if (data.status === 'ok') {
							location.reload();
						}
					});
			}
		});
	});

	setInterval(() => {
		chats.forEach(chat => {
			let bubbles = chat.querySelectorAll('.messages .bubble');
			let lastId = bubbles.length === 0 ? 0 : (bubbles[bubbles.length - 1].dataset.id || 0);
			let author = chat.querySelector('.top .author span').innerHTML;
			loadLatestMessages(chat, author, lastId);
		});
	}, DELAY_BETWEEN_LOADS);

});

function addMessageToChat(chat, message) {
	chat.querySelector('.messages').insertAdjacentHTML('beforeend', message);
	chat.querySelector('.messages').scrollTop = chat.querySelector('.messages').scrollHeight;
}

function loadLatestMessages(chat, author, lastId) {
	fetch('ajax.php', {
		method: 'POST',
		headers: {
			'Accept': 'application/json'
		},
		body: JSON.stringify({
			action: 'loadLatestMessages',
			lastId: lastId,
			author: author
		})
	}).then(response => response.json())
		.then(data => {
			if (data.status === 'ok') {
				data.messages.forEach(message => {
					addMessageToChat(chat, message);
				});
			}
		});
}