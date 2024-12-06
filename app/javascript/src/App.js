import { BrowserRouter, Route, Routes } from "react-router";
import { Container, Stack } from "react-bootstrap";
import { StrictMode } from "react";

import Articles from "./pages/Articles";
import Article from "./pages/Article";
import Header from "./layout/Header";
import Footer from "./layout/Footer";
import Home from "./pages/Home";
import ArticleForm from "./pages/ArticleForm";
import SearchArticles from "./components/SearchArticles";

function App() {
    return (
        <StrictMode>
            <BrowserRouter>
                <Stack gap={1} >
                    <Header />
                    <SearchArticles />
                    <Container fluid="sm">
                        <Routes>
                            <Route index element={<Home />} />
                            <Route path="articles">
                                <Route index element={<Articles />} />
                                <Route path=":id" element={<Article />} />
                                <Route path="new" element={<ArticleForm />} />
                            </Route>
                        </Routes>
                    </Container>
                    <Footer />
                </Stack>
            </BrowserRouter>
        </StrictMode>
    );
}

export default App;