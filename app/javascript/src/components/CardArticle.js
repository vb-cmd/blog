import { Card } from "react-bootstrap";
import { Link } from "react-router";

function CardArticle({ article }) {
    return (
        <Card className="m-1">
            <Card.Body>
                <Card.Title>{article.title}</Card.Title>
                <Card.Text>{article.description}</Card.Text>
                <Link className="btn btn-outline-info" to={`/articles/${article.id}`}>Read more</Link>
            </Card.Body>
            <Card.Footer><em>{article.created_at}</em></Card.Footer>
        </Card>
    )
}

export default CardArticle;