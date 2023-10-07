<?php
header('Content-Type: application/json');

if (isset($_GET['name'])) {
    echo json_encode(['name' => $_GET['name']]);
}