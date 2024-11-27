require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  it 'renders must have the attrebute #app' do
    render

    expect(rendered).to include('<div id="app"></div>')
  end
end
