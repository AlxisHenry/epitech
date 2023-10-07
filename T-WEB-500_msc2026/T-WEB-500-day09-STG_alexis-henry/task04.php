<?php

function whoami() {
	$name = $_POST["name"] ?? null;
	$age = $_POST["age"] ?? null;
	if ($age !== null && !is_numeric($age)) $age = null;
	if ($name === null && $age !== null) {
		echo "Hi, I have no name and I'm $age years old.";
	} else if ($name !== null && $age === null) {
		echo "Hi, my name is $name.";
	} else if ($name !== null && $age !== null) {
		echo "Hi, my name is $name and I'm $age years old.";
	} else {
		echo "Hi, I have no name.";
	}
	echo "\n";
}