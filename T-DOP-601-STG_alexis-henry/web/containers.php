<?php

declare(strict_types=1);

header('Content-Type: application/json; charset=utf-8');

include_once __DIR__ . '/autoloader.php';

use App\Component;
use App\Docker;

$docker = Docker::setup();

$containers = "";

foreach ($docker->getContainers() as $container) {
    $containers .= Component::container($container);
}

echo json_encode([
    'containers' => $containers
], JSON_THROW_ON_ERROR);
