<?php

function calc_average(array $numbers) {
	if (count($numbers) <= 0) return 0;
	$sum = 0;
	foreach ($numbers as $number) {
		$sum += $number;
	}
	return round($sum / count($numbers), 1);
}