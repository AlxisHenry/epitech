<?php include 'functions.php'; ?>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Mini-chat</title>
	<link rel="stylesheet" href="index.css">
	<script src="https://kit.fontawesome.com/45e38e596f.js" crossorigin="anonymous"></script>
</head>

<body>
	<nav>
		<h1>Mini-chat</h1>
	</nav>
	<p class="tutorial">
		You can send a message by pressing <i class="fas fa-paper-plane"></i> or by pressing <kbd>Enter</kbd>.<br>
		You can add a new author by clicking on the <i class="fas fa-plus"></i> button.<br>
		You can remove a author by clicking on the <i class="fas fa-times"></i> button on the top right corner of the chat.<br>
	</p>
	<main><?= createChats() ?></main>
	<script src="./index.js"></script>
</body>