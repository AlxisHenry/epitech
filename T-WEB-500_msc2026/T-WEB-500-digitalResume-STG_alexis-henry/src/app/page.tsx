"use client";

import React from "react";
import Title from "@/components/Title";
import "@/styles/app.scss";

export default function Home() {
  return (
    <div className="container">
      <Title content="Home" />
      <div className="about-me">
        <p className="text">
          I&apos;m Alexis, junior developer from Strasbourg, France. I&apos;m a developer
          with a passion for exploring new programming languages and
          technologies. I believe that it is essential to have a broad
          understanding of different programming paradigms and practices in
          order to create effective solutions to complex problems. I am always
          eager to learn and improve my skills. My goal is to stay up-to-date
          with the latest trends and best practices in the tech industry, and to
          continuously expand my knowledge and capabilities. So if you&apos;re
          looking for a developer who is not afraid to take on new challenges
          and explore uncharted territory, look no further!
        </p>
        <div className="links">
          <a href="https://github.com/AlxisHenry" target="_blank">
            <img src="/github.svg" alt="github" /> Check out my GitHub !
          </a>
        </div>
      </div>
    </div>
  );
}
