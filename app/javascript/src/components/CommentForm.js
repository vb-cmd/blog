import { Form, Button } from "react-bootstrap";

function CommentForm({ handleSubmit }) {
    return (
        <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3">
                <Form.Label>Comment</Form.Label>
                <Form.Control as={"textarea"} placeholder="Leave a comment" rows={3} name="comment[body]" />
            </Form.Group>
            <Button variant="primary" type="submit" className="mb-3">
                Send
            </Button>
        </Form>
    );
}

export default CommentForm;