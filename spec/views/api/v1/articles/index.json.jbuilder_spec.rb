require 'rails_helper'

RSpec.describe 'api/v1/articles/index', type: :view do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 2, user: user) }

  before do
    assign(:articles, articles)
  end

  it 'renders a list of articles' do
    render

    articles.each do |article|
      expect(rendered).to include(article.title)
    end
  end
end
