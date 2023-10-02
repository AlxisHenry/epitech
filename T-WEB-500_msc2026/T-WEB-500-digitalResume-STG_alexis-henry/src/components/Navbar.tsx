import NavbarItem from "@/components/NavbarItem";
import "@/styles/components/Navbar.scss";

export default function Navbar() {
  return (
    <nav>
      <div>
        <h1>Alexis Henry</h1>
      </div>
      <div>
        <NavbarItem href="/" content="Home" hideLoader={true} />
        <NavbarItem href="/projects" content="Projects" hideLoader={true} />
        <NavbarItem href="/skills" content="Skills" hideLoader={true} />
        <NavbarItem href="/contact" content="Contact" hideLoader={true} />
      </div>
    </nav>
  );
}
