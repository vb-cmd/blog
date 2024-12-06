json.data do
  json.array! @articles, partial: 'article', as: :article
end
json.pagination do
  json.current @articles.current_page
  json.next @articles.next_page
  json.prev @articles.prev_page
  json.total_pages @articles.total_pages
end
