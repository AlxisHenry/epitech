<?php

function get_shortest(array $strings) {
	$shortest = null;
	foreach ($strings as $string) {
		if ($shortest === null || (strlen($string) < strlen($shortest))) {
			$shortest = $string;
		}
	}
	return $shortest;
} 