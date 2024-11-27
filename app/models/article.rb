class Article < ApplicationRecord
  MAX_DESCRIPTION_LENGTH = 100

  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :published, inclusion: { in: [true, false] }

  scope :all_published, -> { where(published: true) }
  scope :all_unpublished, -> { where(published: false) }
  scope :sort_by_date, -> { order(created_at: :desc) }

  def description
    body.truncate(MAX_DESCRIPTION_LENGTH)
  end
end
