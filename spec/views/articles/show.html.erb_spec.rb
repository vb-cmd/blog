require 'rails_helper'

RSpec.describe 'articles/show', type: :view do
  let!(:article) { create(:article) }

  before do
    assign(:article, article)
  end

  it 'renders attributes in <div>' do
    render

    [article.title, article.body, article.created_at].each do |attribute|
      expect(rendered).to include(attribute)
    end
  end
end
