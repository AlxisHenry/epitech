import "@/styles/components/NavbarItem.scss";
import { useEffect, useState } from "react";

export default function NavbarItem(props: { href: string; content: string, hideLoader: boolean }) {
  const [underlineWidth, setUnderlineWidth] = useState<number>(0);
  const [isActive, setIsActive] = useState<boolean>(false);

  useEffect(() => {
    setIsActive(window.location.pathname === props.href);
    setUnderlineWidth(isActive ? 100 : 0);
  }, [isActive]);

  return (
    <a
      className="navbar-item"
      href={props.href}
      onMouseEnter={
        isActive ? (): void => {} : (): void => setUnderlineWidth(100)
      }
      onMouseLeave={
        isActive ? (): void => {} : (): void => setUnderlineWidth(0)
      }
    >
      <p>{props.content}</p>
      <div className="underline" style={{ width: `${underlineWidth}%` }}></div>
    </a>
  );
}
