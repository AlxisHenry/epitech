<?php
include 'pdo_connect.php';

function isValid(string|null $str): bool
{
	return $str !== null && $str !== "";
}

function findForPrice(PDO $pdo, string $price, bool $extractSymbolAndPrice = false): array
{
	$symbol = "=";
	if (substr($price, 0, 1) === ">") {
		$symbol = ">";
	} else if (substr($price, 0, 1) === "<") {
		$symbol = "<";
	}
	if ($symbol !== "=") {
		$price = substr($price, 1);
	}

	if ($extractSymbolAndPrice) {
		return [$symbol, $price];
	}

	$query = $pdo->prepare('SELECT * FROM products WHERE price ' . $symbol . ' ?');
	$query->execute([$price]);
	$products = $query->fetchAll(PDO::FETCH_ASSOC);
	$query->closeCursor();
	return $products;
}

$pdo = pdo();
$search = isset($_GET['search']) ? true : false;
$type = isset($_GET['type']) ? strtolower($_GET['type']) : null;
$brand = isset($_GET['brand']) ? strtolower($_GET['brand']) : null;
$price = isset($_GET['price']) ? strtolower($_GET['price']) : null;
$number = isset($_GET['number']) ? $_GET['number'] : null;

if ($search) {
	$wheres = [];
	$params = [];

	if (isValid($type)) {
		$wheres[] = 'type = ?';
		$params[] = $type;
	}

	if (isValid($brand)) {
		$wheres[] = 'brand = ?';
		$params[] = $brand;
	}

	if (isValid($price)) {
		[$symbol, $price] = findForPrice($pdo, $price, true);
		$wheres[] = 'price ' . $symbol . ' ?';
		$params[] = $price;
	}

	if (isValid($number)) {
		$wheres[] = 'stock >= ?';
		$params[] = $number;
	}

	if (count($wheres) > 0) {
		$query = $pdo->prepare('SELECT type, brand, price, stock as number, stock FROM products WHERE ' . implode(' AND ', $wheres));
		$query->execute($params);
		$products = $query->fetchAll(PDO::FETCH_ASSOC);
		$query->closeCursor();
		echo json_encode($products);
	} else {
		echo json_encode([]);
	}

	die();
}

$typeWarnings = [];

if (isValid($type)) {
	if (!preg_match('/^[a-zA-Z-]+$/', $type)) {
		$typeWarnings[] = [0, 'This type has non-alphabetical characters (different from \'-\').'];
	}
	if (strlen($type) < 3) {
		$typeWarnings[] = [0, 'This type does not have enough characters.'];
	}
	if (strlen($type) > 10) {
		$typeWarnings[] = [0, 'This type has too many characters.'];
	}
	if (count($typeWarnings) === 0) {
		$query = $pdo->prepare('SELECT * FROM products WHERE type = ?');
		$query->execute([$type]);
		$products = $query->fetchAll(PDO::FETCH_ASSOC);
		if (count($products) === 0) {
			$typeWarnings[] = [0, 'This type doesn\'t exist in our shop.'];
		}
		$query->closeCursor();
	}
}

$brandWarnings = [];

if (isValid($brand)) {
	if (!preg_match('/^[a-zA-Z0-9-&]+$/', $brand)) {
		$brandWarnings[] = [0, 'This brand has invalid characters.'];
	}
	if (strlen($brand) < 2) {
		$brandWarnings[] = [0, 'This brand does not have enough characters.'];
	}
	if (strlen($brand) > 20) {
		$brandWarnings[] = [0, 'This brand has too many characters.'];
	}
	if (count($brandWarnings) === 0) {
		$query = $pdo->prepare('SELECT * FROM products WHERE brand = ?');
		$query->execute([$brand]);
		$products = $query->fetchAll(PDO::FETCH_ASSOC);
		if (count($products) === 0) {
			$brandWarnings[] = [0, 'This brand doesn\'t exist in our database.'];
		}
		$query->closeCursor();
	}
}

$priceWarnings = [];

if (isValid($price)) {
	if (!preg_match('/^[0-9><=]+$/', $price)) {
		$priceWarnings[] = [0, 'We cannot define a price - string invalid.'];
	}
	if (strlen($price) < 2) {
		$priceWarnings[] = [0, 'This price does not have enough characters.'];
	}
	if (strlen($price) > 5) {
		$priceWarnings[] = [0, 'This price has too many characters.'];
	}
	if (count($priceWarnings) === 0) {
		if (count(findForPrice($pdo, $price)) === 0) {
			$priceWarnings[] = [0, 'This price doesn\'t exist in our database.'];
		}
	}
}

$numberWarnings = [];

if (isValid($number)) {
	if (!preg_match('/^[0-9]+$/', $number)) {
		$numberWarnings[] = [0, 'Not a positive number.'];
	}
	if (count($numberWarnings) === 0) {
		if (
			(count($brandWarnings) === 0 && isValid($brand)) &&
			(count($typeWarnings) === 0 && isValid($type))
		) {
			$query = $pdo->prepare('SELECT * FROM products WHERE type = ? AND brand = ?');
			$query->execute([$type, $brand]);
			$products = $query->fetchAll(PDO::FETCH_ASSOC);
			$stock = $products[0]['stock'] ?? 0;
			if ($stock < intval($number)) {
				$numberWarnings[] = [0, 'Sorry, we don\'t have enough stock, we only have '.$stock.' products.'];
			}
			$query->closeCursor();
		} else {
			$query = $pdo->prepare('SELECT * FROM products WHERE stock >= ?');
			$query->execute([$number]);
			$products = $query->fetchAll(PDO::FETCH_ASSOC);
			if (count($products) === 0) {
				$numberWarnings[] = [0, 'Sorry, we don\'t have enough stock.'];
			}
			$query->closeCursor();
		}
	}
}

echo json_encode([
	'type' => $typeWarnings,
	'brand' => $brandWarnings,
	'price' => $priceWarnings,
	'number' => $numberWarnings
]);
