class User < ApplicationRecord
  has_many :activitys, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}

  enum role: [:user, :admin]

  has_secure_password

  before_save {self.email = email.downcase}

  def is_user? user
    self == user
  end

end
