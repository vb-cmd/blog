class Like < ApplicationRecord
  belongs_to :article, counter_cache: true
  belongs_to :user

  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true

  validate do |like|
    if Like.where(article_id: like.article_id, user_id: like.user_id).exists?
      errors.add(:cant_be_repeated, "can't be repeated")
    end
  end

  after_create do |like|
    sum = like.article.likes_sum + like.rating
    like.article.update(likes_sum: sum)
  end

  after_destroy do |like|
    sum = like.article.likes_sum - like.rating
    like.article.update(likes_sum: sum)
  end
end
