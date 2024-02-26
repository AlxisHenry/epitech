<?php

function autoloader($class)
{
    $class = str_replace('App\\', '', $class);
    $file = __DIR__ . '/app/' . str_replace('\\', '/', $class) . '.php';
    if (file_exists($file)) {
        require $file;
    }
}

spl_autoload_register('autoloader');
