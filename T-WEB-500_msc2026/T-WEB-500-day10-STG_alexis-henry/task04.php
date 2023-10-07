<?php
include 'pdo_connect.php';

function isValid(string|null $str): bool
{
    return $str !== null && $str !== "";
}

$pdo = pdo();
$type = isset($_GET['type']) ? strtolower($_GET['type']) : null;
$brand = isset($_GET['brand']) ? strtolower($_GET['brand']) : null;

$typeWarnings = [];

if (!isValid($type)) {
    $typeWarnings[] = [0, 'No type sent yet!'];
} else {
    if (!preg_match('/^[a-zA-Z-]+$/', $type)) {
        $typeWarnings[] = [0, 'This type has non-alphabetical characters (different from \'-\').'];
    }
    if (strlen($type) < 3) {
        $typeWarnings[] = [0, 'This type does not have enough characters.'];
    }
    if (strlen($type) > 10) {
        $typeWarnings[] = [0, 'This type has too many characters.'];
    }
}

if (count($typeWarnings) === 0) {
    $query = $pdo->prepare('SELECT * FROM products WHERE type = ?');
    $query->execute([$type]);
    $products = $query->fetchAll(PDO::FETCH_ASSOC);

    if (count($products) === 0) {
        $typeWarnings[] = [1, 'This type doesn’t exist in our shop.'];
    } else {
        $typeWarnings[] = [0, 'This type exists in databases.'];
    }

    $query->closeCursor();
}

$brandWarnings = [];

if (!isValid($brand)) {
    $brandWarnings[] = [0, 'No brand sent yet!'];
} else {
    if (!preg_match('/^[a-zA-Z0-9-&]+$/', $brand)) {
        $brandWarnings[] = [0, 'This brand has invalid characters.'];
    }
    if (strlen($brand) < 2) {
        $brandWarnings[] = [0, 'This brand does not have enough characters.'];
    }
    if (strlen($brand) > 20) {
        $brandWarnings[] = [0, 'This brand has too many characters.'];
    }
}

if (count($brandWarnings) === 0) {
    $query = $pdo->prepare('SELECT * FROM products WHERE brand = ?');
    $query->execute([$brand]);
    $products = $query->fetchAll(PDO::FETCH_ASSOC);
    if (count($products) > 0) {
        $brandWarnings[] = [0, 'This brand already exists in databases.'];
    } else {
        if (isValid($type)) {
            $brandWarnings[] = [1, 'This brand is valid for the type ' . $type];
        }
    }
    $query->closeCursor();
}

echo json_encode([
    'type' => $typeWarnings,
    'brand' => $brandWarnings,
]);
