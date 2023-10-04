<?php

function dog_bark(int $woof_nb) {
	echo trim(str_repeat($woof_nb > 1 ? "woof " : "woof", $woof_nb >= 0 ? $woof_nb : 0)) . "\n";
}