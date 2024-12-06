require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/articles.json').to route_to('api/v1/articles#index', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/api/v1/articles/1.json').to route_to('api/v1/articles#show', id: '1', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/articles.json').to route_to('api/v1/articles#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/articles/1.json').to route_to('api/v1/articles#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/articles/1.json').to route_to('api/v1/articles#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/articles/1.json').to route_to('api/v1/articles#destroy', id: '1', format: 'json')
    end
  end
end
