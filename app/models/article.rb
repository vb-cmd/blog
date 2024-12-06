class Article < ApplicationRecord
  MAX_DESCRIPTION_LENGTH = 100
  SEPARATOR = '...'.freeze

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :published, inclusion: { in: [true, false] }

  scope :all_published, -> { where(published: true) }
  scope :all_unpublished, -> { where(published: false) }
  scope :latest, ->(page, per_page) { order(created_at: :desc).page(page).per(per_page) }
  scope :search, ->(params_query) { ransack(params_query).result.select(:id, :title).limit(10) }

  def newest_comments
    comments.includes(:user).order(created_at: :desc)
  end

  def description
    body.truncate(MAX_DESCRIPTION_LENGTH, separator: SEPARATOR)
  end

  def average_rating
    return 0 unless [likes_sum, likes_count].any?(&:positive?)

    likes_sum / likes_count
  end

  def can_like?(user)
    !likes.where(user: user).exists?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id published title]
  end
end
