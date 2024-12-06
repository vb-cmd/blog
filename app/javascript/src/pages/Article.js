import axios from "axios";
import { useEffect, useState } from "react";
import { useParams } from "react-router";
import CommentList from "../components/CommentList";
import Like from "../components/Like";

function Article() {
    const [article, setArticle] = useState({});
    const { id } = useParams();

    useEffect(() => {
        axios.get(`/api/v1/articles/${id}.json`)
            .then((response) => {
                setArticle(response.data)
            })
    }, [id])

    return (
        <>
            <div className="my-2 p-2 border bg-light rounded-1" key={'article'}>
                <h1>{article.title}</h1>
                <p className="text-break">{article.body}</p>
                <p>{article.created_at}</p>
                <p>{article.author}</p>
            </div>

            <Like article_id={id} key={'like'} />

            <CommentList key={'comments'} />
        </>
    )
}

export default Article;