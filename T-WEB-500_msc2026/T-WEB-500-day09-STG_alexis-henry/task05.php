<?php

function form_is_submitted(): bool {
	return isset($_POST["submit"]);
}

function whoami() {
	$name = ($_POST["name"] ?? null) === "" ? null : $_POST["name"];
	$age = ($_POST["age"] ?? null) === "" ? null : $_POST["age"];
	$curriculum = ($_POST["curriculum"] ?? null) === "" ? null : $_POST["curriculum"];
	$curriculums = ["pge" => "PGE ( Programme Grande Ecole )", "msc" => "MSc Pro", "coding" => "Coding Academy", "wac" => "Web@cademie"];
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
	if ($curriculum !== null) echo " I'm a student of " . $curriculums[$curriculum] . ".";
	echo "\n";
}
