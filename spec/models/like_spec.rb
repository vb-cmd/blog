require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:article) { create(:article) }
  let(:user) { create(:user) }

  describe 'validations' do
    let(:build_like) { build(:like, article: article, user: user) }
    let(:users) { create_list(:user, 5) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(build_like).to be_valid
      end

      it 'is not valid without a user' do
        build_like.user = nil
        build_like.valid?
        expect(build_like.errors[:user]).to include('must exist')
      end

      it 'is not valid without an article' do
        build_like.article = nil
        build_like.valid?
        expect(build_like.errors[:article]).to include('must exist')
      end

      it 'is not valid with a duplicate like' do
        create(:like, article: article, user: user)
        build_like.valid?
        expect(build_like.errors[:cant_be_repeated]).to include("can't be repeated")
      end

      it 'should be rated with a value between 1 and 5' do
        build_like.rating = 0
        build_like.valid?
        expect(build_like.errors[:rating]).to include('must be greater than or equal to 1')
        build_like.rating = 6
        build_like.valid?
        expect(build_like.errors[:rating]).to include('must be less than or equal to 5')
      end

      it 'is not valid without a rating' do
        build_like.rating = nil
        build_like.valid?
        expect(build_like.errors[:rating]).to include("can't be blank")
      end

      it 'gets average rating for an article' do
        users.each do |user|
          create(:like, article: article, user: user, rating: 5)
        end

        avarage_rating = article.likes_sum / article.likes_count

        expect(article.average_rating).to eq(avarage_rating)
      end

      it 'gets zero if there are no likes' do
        expect(article.average_rating).to eq(0)
      end

      it 'increments likes_sum and likes_count in an article when a like is created' do
        article.likes.create(user: user, rating: 5)
        expect(article.average_rating).to eq(5)
      end

      it 'decrements likes_sum and likes_count in an article when a like is deleted' do
        article.likes.create(user: user, rating: 5)
        expect(article.likes_count).to eq(1)
        expect(article.likes_sum).to eq(5)

        article.likes.first.destroy
        expect(article.likes_count).to eq(0)
        expect(article.likes_sum).to eq(0)
      end
    end
  end
end
