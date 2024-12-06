import { Badge, Button, ButtonGroup, Stack } from "react-bootstrap";
import BootstrapIcon from "./BootstrapIcon";
import axios from "axios";
import { useEffect, useState } from "react";

function Like({ article_id }) {
    const [likesCount, setLikesCount] = useState(0);

    useEffect(() => {
        axios.get(`/api/v1/articles/${article_id}/likes.json`)
            .then((response) => {
                setLikesCount(response.data.rating)
            })
    }, [article_id])

    const handleSubmit = (rating) => {
        axios.post(`/api/v1/articles/${article_id}/likes.json`, {
            like: { rating: rating }
        }).then((response) => {
            setLikesCount(response.data.rating)
        })
    }

    return (
        <Stack gap={1} className="rating my-1" direction="horizontal">
            <div className="rounded-3 border border-success bg-primary p-1 h-100 text-white">Rating <Badge bg="secondary">{likesCount}</Badge></div>

            <ButtonGroup className="rating-stars">
                {[1, 2, 3, 4, 5].map((value) =>
                    <Button variant="secondary" className="bg-transparent border-opacity-25 border-danger" key={value} onClick={() => handleSubmit(value)}>
                        <BootstrapIcon name={'star-fill'} /> {value}
                    </Button>)}
            </ButtonGroup>
        </Stack>

    )
}

export default Like;