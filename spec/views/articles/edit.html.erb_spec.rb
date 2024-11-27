require 'rails_helper'

RSpec.describe 'articles/edit', type: :view do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  before(:each) do
    assign(:article, article)
  end

  it 'renders the edit article form' do
    render

    expect(rendered).to match(/Editing article/)

    %w[title body published]
      .map { |attribute| "article[#{attribute}]" }
      .each do |attribute|
      expect(rendered).to include(attribute)
    end
  end
end
