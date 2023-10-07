<?php

function render_body(string $page) {
	if (in_array($page, ["sql", "php", "home"])) {
		return file_get_contents("./$page.html");
	} else {
		return "<p>Unknown page</p>";
	}
}