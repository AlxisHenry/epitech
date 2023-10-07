<?php

$email = $_POST['email'] ?? null;

$service = explode('@', $email)[1] ?? null;

if (!filter_var($email, FILTER_VALIDATE_EMAIL) || !$service || !in_array($service, ['gmail.com', 'outlook.fr', 'yahoo.fr'])) {
	http_response_code(400);
}
