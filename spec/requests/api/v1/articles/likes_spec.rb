require 'rails_helper'

RSpec.describe 'api/v1/articles/:article_id/likes', type: :request do
  let!(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  before do
    sign_in user, scope: :user
  end
  
  describe 'access to likes' do
    before do
      sign_out user, scope: :user
    end

    it 'checking authentication' do
      get api_v1_article_likes_url(article)
      expect(response).to have_http_status(:ok)

      post api_v1_article_likes_url(article), params: { like: { rating: 5 } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /index' do
    it 'renders the average rating of an article' do
      get api_v1_article_likes_url(article)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(article.average_rating.to_s)
    end
  end

  describe 'POST /create' do
    it 'renders a successful response' do
      post api_v1_article_likes_url(article), params: { like: { rating: 5 } }

      article.reload

      expect(response.body).to include(article.average_rating.to_s)
      expect(response).to have_http_status(:created)
    end

    it 'returns the same average rating when user has already liked' do
      article.likes.create(user: user, rating: 5)

      post api_v1_article_likes_url(article), params: { like: { rating: 5 } }

      expect(response.body).to include(article.average_rating.to_s)
      expect(response).to have_http_status(:ok)
    end

    it 'returns error if rating is not between 1 and 5' do
      post api_v1_article_likes_url(article), params: { like: { rating: 6 } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('Rating must be less than or equal to 5')
    end
  end
end