class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birth_date, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def full_name
    "#{firstname} #{lastname}"
  end

  def age
    (Date.today - birth_date.to_date).to_i / 365
  end
end
