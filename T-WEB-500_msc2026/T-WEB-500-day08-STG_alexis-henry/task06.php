<?php

function sequence(int $n) {
	if ($n < 0) return;
	
    $prev = "1";
	echo $prev . PHP_EOL;

    for ($i = 1; $i <= $n; $i++) {
        $count = 1;
        $current = "";
        $len = strlen($prev);

        for ($j = 1; $j < $len; $j++) {
            if ($prev[$j] == $prev[$j - 1]) {
                $count++;
            } else {
                $current .= $count . $prev[$j - 1];
                $count = 1;
            }
        }

        $current .= $count . $prev[$len - 1];
        echo $current . PHP_EOL;
        $prev = $current;
	}
}