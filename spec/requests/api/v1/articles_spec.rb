require 'rails_helper'

RSpec.describe 'api/v1/articles.json', type: :request do
  let!(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:valid_article) { build(:article, user: user) }
  let(:invalid_article) { build(:invalid_article, user: user) }
  let(:valid_attributes) do
    { title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      published: Faker::Boolean.boolean }
  end
  let(:invalid_attributes) { { title: nil, body: nil, published: nil } }

  before do
    sign_in user, scope: :user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_articles_url
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_article_url(article)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new article' do
        post api_v1_articles_url,
             params: { article: valid_attributes }

        expect(Article.count).to eq(1)
        expect(response.body).to include(Article.last.title)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it "doesn't create a new article and render a response with 422 status" do
        post api_v1_articles_url, params: { article: invalid_attributes }
        expect(Article.count).to eq(0)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    let(:valid_title_attribute) { { title: Faker::Lorem.sentence } }
    let(:invalid_title_attribute) { { title: nil } }

    context 'with valid title' do
      it 'renders a response with 200 status' do
        patch api_v1_article_url(article), params: { article: valid_title_attribute }
        article.reload
        expect(article.title).to eq(valid_title_attribute[:title])
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid title' do
      it 'renders a response with 422 status' do
        patch api_v1_article_url(article), params: { article: invalid_attributes }
        expect(response.body).to include("Title can't be blank")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'with valid article' do
      it 'rebders a response with 200 status' do
        delete api_v1_article_url(article)

        expect(Article.count).to eq(0)
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Article was successfully destroyed.')
      end
    end

    context 'with invalid article' do
      it 'renders a response with 422 status' do
        delete api_v1_article_url(id: 'invalid')

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
