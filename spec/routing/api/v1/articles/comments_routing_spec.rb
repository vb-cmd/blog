require 'rails_helper'

RSpec.describe Api::V1::Articles::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/articles/1/comments.json').to route_to('api/v1/articles/comments#index', article_id: '1',
                                                                                                    format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/articles/1/comments.json').to route_to('api/v1/articles/comments#create', article_id: '1',
                                                                                                      format: 'json')
    end
  end
end
