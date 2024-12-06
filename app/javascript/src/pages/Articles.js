import { useEffect, useState } from "react";
import CardArticle from "../components/CardArticle";
import axios from "axios";
import PaginationItems from "../components/PaginationItems";

function Articles() {
    const [articles, setArticles] = useState([]);
    const [pagination, setPagination] = useState({});
    const [page, setPage] = useState(1);

    useEffect(() => {
        axios.get("/api/v1/articles.json", {
            params: {
                page: page
            }
        })
            .then((response) => {
                setArticles(response.data.data)
                setPagination(response.data.pagination)
            })
    }, [page])

    return (
        <>
            <div className="my-3">
                {articles.map((article) => <CardArticle key={article.id} article={article} />)}
            </div>

            <PaginationItems pageData={pagination} setPage={setPage} />
        </>
    );
}

export default Articles