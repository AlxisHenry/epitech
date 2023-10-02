import "@/styles/components/ContactForm.scss";
import { useState } from "react";

export default function ContactForm() {
	const [messageSent, setMessageSent] = useState<boolean>(false);

	const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
		setMessageSent(true)
	}

  return (
		messageSent ? (
			<div className="message-sent">
				<p>Your message has been sent !</p>
			</div>
		) : (
			<form name="contact" method="POST" data-netlify="true" onSubmit={handleSubmit}>
      <div className="part">
        <label>
          Name
          <input type="text" name="name" placeholder="John Doe" required />
        </label>
        <label>
          Email
          <input type="email" name="email" placeholder="john.doe@example.com" required />
        </label>
      </div>
			<label>
          Object
          <input type="text" name="object" placeholder="Object" required />
        </label>
      <label>
        Message<textarea required placeholder="Your message" name="message"></textarea>
      </label>
      <button type="submit">Send</button>
    </form>
		)
	)
}
