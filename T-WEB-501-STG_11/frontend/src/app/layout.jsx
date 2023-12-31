import "JQ/styles/globals.css";
import { Inter } from "next/font/google";

const inter = Inter({ subsets: ["latin"] });

export const metadata = {
  title: "JobQuest",
  description: "JobQuest is a interactive job board.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className} theme="">
        {children}
      </body>
    </html>
  );
}
