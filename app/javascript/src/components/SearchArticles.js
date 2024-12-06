import axios from "axios";
import { useState } from "react";
import { Container, Form, ListGroup } from "react-bootstrap";
import { Link } from "react-router";

function SearchArticles() {
  const [items, setItems] = useState([]);
  const [error, setError] = useState(null);

  const handleSearch = (event) => {
    const query = event.target.value;

    axios.get('/api/v1/articles/search.json', {
      params: {
        query: query
      }
    }).then((response) => {
      setItems(response.data)
    }).catch((error) => {
      setError(error.response.data.messages)
    })
  }

  return (
    <Container className="my-1">
      <Form.Control
        type="search"
        placeholder="Search"
        className="me-2"
        aria-label="Search"
        onChange={handleSearch}
      />

      {error && <Alert variant="danger">{error}</Alert>}

      <ListGroup>
        {items.map((item) => (
          <ListGroup.Item key={item.id}>
            <Link to={`/articles/${item.id}`}>{item.title}</Link>
          </ListGroup.Item>
        ))}
      </ListGroup>
    </Container>
  );
}

export default SearchArticles;