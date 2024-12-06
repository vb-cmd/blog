import { Form, Button, Alert } from "react-bootstrap";
import { useNavigate } from "react-router";
import { useState } from "react";
import axios from "axios";

function ArticleForm() {
    const navigate = useNavigate();
    const [error, setError] = useState(null);

    const handleSubmit = (event) => {
        event.preventDefault();

        axios.post(`/api/v1/articles.json`, {
            article: {
                title: event.target['article[title]'].value,
                body: event.target['article[body]'].value,
                published: event.target['article[published]'].checked
            }
        }).then((response) => {
            navigate(`/articles/${response.data.id}`)
            setError(null)
        }).catch((error) => {
            setError(error.response.data.messages)
        })
    }

    return (
        <Form onSubmit={handleSubmit}>
            <Form.Text className="text-muted">
                {error && <Alert variant="danger">{error.join(', ')}</Alert>}
            </Form.Text>
            <Form.Group className="mb-3">
                <Form.Label>Title</Form.Label>
                <Form.Control type="text" placeholder="Enter title" name="article[title]" />
            </Form.Group>
            <Form.Group className="mb-3">
                <Form.Label>Content</Form.Label>
                <Form.Control as="textarea" placeholder="Enter content" rows={3} name="article[body]" />
            </Form.Group>

            <Form.Check type="switch" label="Published" checked className="mb-3" name="article[published]" />

            <Button variant="primary" type="submit" className="mb-3">Create</Button>
        </Form>
    );
}

export default ArticleForm;