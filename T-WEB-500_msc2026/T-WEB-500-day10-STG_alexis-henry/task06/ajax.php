<?php

header('Content-Type: application/json');

include_once 'functions.php';

$data = file_get_contents('php://input');
$data = json_decode($data, true);

$action = $data['action'] ?? null;
$author = $data['author'] ?? null;
$content = $data['content'] ?? null;

if ($action === "add") {
	if ($author && $content) {
		$pdo = pdo();
		$statement = $pdo->prepare("SELECT `id` FROM `authors` WHERE `name` = :name");
		$statement->execute(["name" => $author]);
		$authorId = $statement->fetch(PDO::FETCH_ASSOC)['id'];
		$statement->closeCursor();
		$statement = $pdo->prepare("INSERT INTO `messages` (`content`, `author_id`, `created_at`) VALUES (:content, :author_id, NOW())");
		$statement->execute(["content" => $content, "author_id" => $authorId]);
		$statement->closeCursor();
		echo json_encode(['status' => 'ok', 'message' => message($pdo->lastInsertId(), true, $author, $content, date('Y-m-d H:i:s'))]);
	} else {
		echo json_encode(['status' => 'error']);
	}
} else if ($action === "addAuthor") {
	if ($author) {
		$pdo = pdo();
		$statement = $pdo->prepare("INSERT INTO `authors` (`name`, `created_at`) VALUES (:name, NOW())");
		$statement->execute(["name" => $author]);
		$statement->closeCursor();
		echo json_encode(['status' => 'ok']);
	} else {
		echo json_encode(['status' => 'error']);
	}
} else if ($action === "loadLatestMessages") {
	$lastMessageId = $data['lastId'] ?? null;
	if ($lastMessageId !== "" && $lastMessageId !== null) {
		$pdo = pdo();
		$statement = $pdo->prepare("SELECT 
			messages.id AS id,
			authors.name AS author,
			messages.content AS content,
			messages.created_at AS created_at
		FROM `messages` 
		INNER JOIN `authors` ON `messages`.`author_id` = `authors`.`id`
		WHERE `messages`.`id` > :message_id
			AND `authors`.`name` != :author 
		ORDER BY `created_at` DESC");
		$statement->execute(["message_id" => $data['lastId'], "author" => $author]);
		$messages = $statement->fetchAll(PDO::FETCH_ASSOC);
		$statement->closeCursor();
		echo json_encode(['status' => 'ok', 'messages' => array_map(function ($message) {
			return message($message['id'], false, $message['author'], $message['content'], $message['created_at']);
		}, $messages)]);
	} else {
		echo json_encode(['status' => 'error']);
	}
} else if ($action === "delete") {
	$pdo = pdo();
	$statement = $pdo->prepare("SELECT id FROM authors WHERE name = :name");
	$statement->execute(["name" => $author]);
	$authorId = $statement->fetch(PDO::FETCH_ASSOC)['id'];
	$statement->closeCursor();
	$statement = $pdo->prepare("DELETE FROM messages WHERE author_id = :author_id");
	$statement->execute(["author_id" => $authorId]);
	$statement->closeCursor();
	$statement = $pdo->prepare("DELETE FROM authors WHERE id = :author_id");
	$statement->execute(["author_id" => $authorId]);
	$statement->closeCursor();
	echo json_encode(['status' => 'ok']);
} else {
	echo json_encode(['status' => 'error']);
}
