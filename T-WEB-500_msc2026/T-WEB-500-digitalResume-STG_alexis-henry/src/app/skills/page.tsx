"use client";

import React, { useState } from "react";
import Title from "@/components/Title";
import Skill from "@/components/Skill";
import "@/styles/app.scss";

export default function Skills() {
  const [showLoader, setShowLoader] = useState<boolean>(false);

  const skills = [
    {
      title: "HTML",
      image: "/ball.png",
      description: "HTML is a markup language for creating web pages.",
    },
    {
      title: "CSS",
      image: "/ball.png",
      description:  "CSS is a style sheet language used for describing the presentation of a document.",
    },
    {
      title: "JavaScript",
      image: "/ball.png",
      description: "JavaScript is a programming language that conforms to the ECMAScript specification.",
    },
    {
      title: "TypeScript",
      image: "/ball.png",
      description: "TypeScript is a programming language developed and maintained by Microsoft.",
    },
    {
      title: "React",
      image: "/ball.png",
      description: "React is a JavaScript library for building user interfaces.",
    },
    {
      title: "Next.js",
      image: "/ball.png",
      description: "Next.js is a React framework for production.",
    },
    {
      title: "Node.js",
      image: "/ball.png",
      description: "Node.js is an open-source, cross-platform, back-end JavaScript runtime environment.",
    },
    {
      title: "Express",
      image: "/ball.png",
      description: "Express is a minimal and flexible Node.js web application framework.",
    },
  ];

  return (
    <div className="container">
      <Title content="Skills" />
      <div className="skills">
        {skills.map((skill, index) => (
          <Skill skill={skill} key={index} />
        ))}
      </div>
    </div>
  );
}
