import { Container, Row, Col } from "react-bootstrap";

function Footer() {
    return (
        <footer className="text-center bg-light">
            <Container>
                <Row>
                    <Col>Copyright {new Date().getFullYear()}</Col>
                    <Col>Created by <a href="https://github.com/">Bakun Vitalii</a></Col>
                </Row>
            </Container>
        </footer>
    );
}

export default Footer;