"use client"

import "./globals.css";
import { Inter } from "next/font/google";
import Loader from "@/components/Loader";
import Navbar from "@/components/Navbar";
import { useState } from "react";
import Footer from "@/components/Footer";

const inter = Inter({ subsets: ["latin"] });

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const [showLoader, setShowLoader] = useState<boolean>(true);

  return (
    <html lang="en">
      <body className={inter.className}>
        {showLoader ? (
          <Loader setShowLoader={setShowLoader} />
        ) : (
          <>
            <Navbar />
            {children}
            <Footer />
          </>
        )}
      </body>
    </html>
  );
}
