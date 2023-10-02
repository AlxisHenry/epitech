"use client";

import React, { useState } from "react";
import Loader from "@/components/Loader";
import Navbar from "@/components/Navbar";
import Title from "@/components/Title";
import Project from "@/components/Project";
import "@/styles/app.scss";

export default function Projects() {
  const [showLoader, setShowLoader] = useState<boolean>(false);

  const projects = [
    {
      title: "CCI-Appro",
      image: "/logo_ccicampus.jpg",
      link: "https://github.com/CCI-Campus",
      description: "Supplies online store for the Strasbourg CCI Campus.",
    },
    {
      title: "Restiloc",
      image: "/restiloc-logo-full.svg",
      link: "https://github.com/Restiloc",
      description: "Restiloc is a react native application.",
    },
    {
      title: "Portfolio",
      image: "/alexishenry.png",
      link: "https://github.com/AlxisHenry/alexishenry.eu",
      description: "Create a portfolio with Laravel. Using the MVC model.",
    },
    {
      title: "Stock Manager",
      image: "/timken.png",
      link: "https://github.com/AlxisHenry/stock-manager",
      description: "During my internship at Timken, I realized a web interface for manage the stock.",
    },
    {
      title: "URL Shortener",
      image: "/url-shortener.webp",
      link: "https://github.com/AlxisHenry/URL-Shortener",
      description: "Homemade URL Shortener with Laravel.",
    }
  ];

  return (
    <div className="container">
      <Title content="Projects" />
      <div className="projects">
        {projects.map((project, index) => (
          <Project key={index} project={project} />
        ))}
      </div>
    </div>
  );
}
