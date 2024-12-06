require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:article) { create(:article) }
  let(:user) { create(:user) }

  describe 'validations' do
    let(:build_comment) { build(:comment, article: article, user: user) }

    it 'is valid with valid attributes' do
      expect(build_comment).to be_valid
    end

    it 'is not valid without a user' do
      build_comment.user = nil
      build_comment.valid?
      expect(build_comment.errors[:user]).to include('must exist')
    end

    it 'is not valid without an article' do
      build_comment.article = nil
      build_comment.valid?
      expect(build_comment.errors[:article]).to include('must exist')
    end

    it 'is not valid without a body' do
      build_comment.body = nil
      build_comment.valid?
      expect(build_comment.errors[:body]).to include("can't be blank")
    end

    it 'is not valid with a body longer than 500 characters' do
      build_comment.body = 'a' * 501
      build_comment.valid?
      expect(build_comment.errors[:body]).to include('is too long (maximum is 500 characters)')
    end

    it 'is not valid without a body' do
      build_comment.body = nil
      build_comment.valid?
      expect(build_comment.errors[:body]).to include("can't be blank")
    end
  end
end
