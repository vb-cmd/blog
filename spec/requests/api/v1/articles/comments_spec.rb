require 'rails_helper'

RSpec.describe 'api/v1/articles/:article_id/comments', type: :request do
  let!(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  before do
    sign_in user, scope: :user
  end

end