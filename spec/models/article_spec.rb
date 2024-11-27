require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    def build_article(attributes = {})
      build(:article, **attributes, user: user)
    end

    it 'is valid with valid attributes' do
      article = build_article
      expect(article).to be_valid
    end

    it 'is not valid without a title' do
      article = build_article(title: nil)
      article.valid?
      expect(article.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a body' do
      article = build_article(body: nil)
      article.valid?
      expect(article.errors[:body]).to include("can't be blank")
    end

    it 'is not valid without a published' do
      article = build_article(published: nil)
      article.valid?
      expect(article.errors[:published]).to include('is not included in the list')
    end

    it 'is not valid without a user' do
      article = build(:article, user: nil)
      article.valid?
      expect(article.errors[:user]).to include('must exist')
    end
  end

  describe 'scopes' do
    let!(:articles) { create_list(:article, 5, user: user) }

    it 'returns published articles' do
      expect(Article.all_published).to eq Article.where(published: true)
    end

    it 'returns unpublished articles' do
      expect(Article.all_unpublished).to eq Article.where(published: false)
    end

    it 'returns sorted articles by date' do
      expect(Article.sort_by_date).to eq Article.order(created_at: :desc)
    end
  end

  describe '#description' do
    let(:article) { build(:article, body: Faker::Lorem.paragraph * 10, user: user) }
    it 'returns a truncated description' do
      expect(article.description).to eq article.body.truncate(Article::MAX_DESCRIPTION_LENGTH)
    end
  end
end
