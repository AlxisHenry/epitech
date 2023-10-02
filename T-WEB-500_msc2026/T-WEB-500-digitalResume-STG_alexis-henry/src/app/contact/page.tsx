"use client";

import React, { useState } from "react";
import Title from "@/components/Title";
import ContactForm from "@/components/ContactForm";
import "@/styles/app.scss";

export default function Contact() {
  const [showLoader, setShowLoader] = useState<boolean>(false);

  return (
    <div className="container">
      <Title content="Contact" />
      <ContactForm />
    </div>
  );
}
