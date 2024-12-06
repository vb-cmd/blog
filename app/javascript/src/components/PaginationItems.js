import { Pagination } from "react-bootstrap";

function PaginationItems({ pageData, setPage }) {
    const navigation = [
        { page: 1, label: 'First' },
        { page: pageData.prev, label: 'Previous' },
        { page: null, label: pageData.current },
        { page: pageData.next, label: 'Next' },
        { page: pageData.total_pages, label: 'Last' },
    ];

    return (
        <Pagination>
            {navigation.map((item) => <Pagination.Item disabled={item.page === null} onClick={() => setPage(item.page)}>{item.label}</Pagination.Item>)}
        </Pagination>
    );
}

export default PaginationItems;