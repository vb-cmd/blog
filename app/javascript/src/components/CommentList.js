import { useEffect, useState } from "react";
import { useParams } from "react-router";
import CommentForm from "./CommentForm";
import axios from "axios";
import Comment from "./Comment";
import { Alert } from "react-bootstrap";

function CommentList() {
    const [comments, setComments] = useState([]);
    const [error, setError] = useState(null);
    const { id } = useParams();

    useEffect(() => {
        axios.get(`/api/v1/articles/${id}/comments.json`)
            .then((response) => {
                setComments(response.data)
                setError(null)
            }).catch((error) => {
                setError(error.response.data.messages)
            })
    }, [])

    const handleSubmit = (event) => {
        event.preventDefault();

        axios.post(`/api/v1/articles/${id}/comments.json`, {
            comment: { body: event.target['comment[body]'].value }
        })
            .then((response) => {
                setComments([response.data, ...comments])
                setError(null)
            }).catch((error) => {
                setError(error.response.data.messages)
            })

        event.target.reset();
    }

    return (
        <div className="p-2 rounded-3 border border-info bg-light">
            {error && <Alert variant="danger">{error}</Alert>}

            <CommentForm handleSubmit={handleSubmit} />

            {comments.length > 0 && <>
                <h2 className="text-center text-info">Comments:</h2>
                <div className="m-1">
                    {comments.map((comment) => <Comment key={comment.id} comment={comment} />)}
                </div>
            </>}
        </div>
    );
}

export default CommentList;