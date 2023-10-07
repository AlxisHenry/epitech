<?php

function pdo()
{
	$dbname = 'task10';
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
