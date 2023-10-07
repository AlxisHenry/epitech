<?php

function dynamic_body() {
	$page = $_GET["page"] ?? null;
	return $page ? file_get_contents("./$page.html") : "<p>Unknown page</p>";
}