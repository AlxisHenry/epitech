<?php

function calc(string $operator, int $nbr1, int $nbr2) {
	if (!in_array($operator, ['+', '-', '*', '/', '%'])) return "Unknown operator";
	if ($operator == '/' && $nbr2 == 0) return "Cannot divide by 0";
	$result = 0;
	eval('$result = ' . $nbr1 . $operator . $nbr2 . ';');
	return $result;
}