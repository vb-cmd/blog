require 'rails_helper'

RSpec.describe '/', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get root_url
      expect(response).to have_http_status(:success)
    end
  end
end