require 'rails_helper'

RSpec.describe 'api/v1/articles/show', type: :view do
  let!(:article) { create(:article) }

  before do
    assign(:article, article)
  end

  it 'renders attributes' do
    render

    [article.title, article.body].each do |attribute|
      expect(rendered).to include(attribute)
    end
  end
end
