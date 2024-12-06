import { Container, Nav, Navbar } from "react-bootstrap";
import { Link } from "react-router";

function Header() {
    return (
        <header className="bg-light w-100">
            <Navbar expand="sm">
                <Container>
                    <Navbar.Brand>Blog</Navbar.Brand>
                    <Navbar.Toggle aria-controls="basic-navbar-nav" />
                    <Navbar.Collapse id="basic-navbar-nav">
                        <Nav className="me-auto">
                            <Link className="nav-link" to={"/"}>Home</Link>
                            <Link className="nav-link" to={"/articles"}>Articles</Link>
                            <Link className="nav-link" to={"/articles/new"}>Add Article</Link>
                        </Nav>
                    </Navbar.Collapse>
                </Container>
            </Navbar>
        </header>
    );
}

export default Header;