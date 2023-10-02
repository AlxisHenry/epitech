import { useState } from "react";
import "@/styles/components/Footer.scss";

export default function Footer() {
	const [date] = useState<Date>(new Date());

	return (
		<footer>
			<p>&copy; {date.getFullYear()} - All rights reserved - Alexis HENRY</p>
		</footer>
	)
}