<?php


function pdo()
{
	$dbname = 'task06';
	$username = 'alexis';
	$password = 'alexis';

	$pdo = null;
	try {
		$pdo = new PDO("mysql:host=localhost;dbname=$dbname;charset=utf8", $username, $password);
	} catch (PDOException $e) {
		echo "Ошибка при подключении к базе данных";
	}

	return $pdo;
}

function day(string $date): string
{
	$formattedDate = date('d/m/Y', strtotime($date));
	return "<div class='date'>$formattedDate</div>";
}

function message(int $id, bool $side, string $author, string $content, string $created_at): string
{
	$formattedDate = date('H:i', strtotime($created_at));
	$side = $side ? 'right' : '';
	return "<div class='bubble $side' data-id='$id'>
		<div class='author'>$author</div>
		<div class='content'>$content</div>
		<div class='created_at'>$formattedDate</div>
	</div>";
}

function getDistinctDates(): array
{
	$pdo = pdo();
	$statement = $pdo->prepare('SELECT DISTINCT DATE(created_at) AS date FROM messages ORDER BY date ASC');
	$statement->execute();
	$dates = $statement->fetchAll(PDO::FETCH_ASSOC);
	return $dates;
}

function retrieveMessages(string $date): array
{
	$pdo = pdo();
	$statement = $pdo->prepare('SELECT
		messages.id AS id,
		authors.name AS author,
		messages.content AS content,
		messages.created_at AS created_at
	 FROM messages 
	 INNER JOIN authors ON messages.author_id = authors.id
	 WHERE DATE(messages.created_at) = :date ORDER BY created_at ASC');
	$statement->execute(['date' => $date]);
	$messages = $statement->fetchAll(PDO::FETCH_ASSOC);
	return $messages;
}

function createChat(string $author): string
{
	$messages = '';

	$dates = getDistinctDates();

	$today = date('Y-m-d');
	$todayExists = false;

	foreach ($dates as $date) {
		if ($date['date'] === $today) {
			$todayExists = true;
			break;
		}
	}

	foreach ($dates as $date) {
		$messages .= day($date['date']);
		foreach (retrieveMessages($date['date']) as $message) {
			$side = $message['author'] === $author;
			$messages .= message($message['id'], $side, $message['author'], $message['content'], $message['created_at']);
		}
	}

	if ($todayExists === false) {
		$messages .= day($today);
	}

	return "<div class='chat' data-author='$author'>
		<div class='top'>
			<div class='author'><div class='active'></div><span>$author</span></div>
			<div><i class='fas fa-times'></i></div>
		</div>
		<div class='messages'>$messages</div>
		<form id='form-chat'>
			<div class='form-group'>
				<textarea name='message' id='message' cols='30' rows='10' placeholder='Enter your message...'></textarea>
				<button type='button' class='disabled'>
					<i class='fas fa-paper-plane'></i>
				</button>
			</div>
		</form>
	</div>";
}

function createChats(): string
{
	$pdo = pdo();
	$statement = $pdo->prepare('SELECT name AS author FROM authors');
	$statement->execute();
	$authors = $statement->fetchAll(PDO::FETCH_ASSOC);
	$chats = '';
	foreach ($authors as $author) {
		$chats .= createChat($author['author']);
	}
	return $chats;
}

function loadComments(): string
{
	$pdo = pdo();
	$statement = $pdo->prepare('SELECT * FROM comments;');
	$statement->execute();
	$messages = $statement->fetchAll(PDO::FETCH_ASSOC);
	$comments = '';
	foreach ($messages as $message) {
		$comments .= message($message['id'], false, $message['author'], $message['content'], $message['created_at']);
	}
	return $comments;
}