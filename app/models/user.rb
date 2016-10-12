class User < ApplicationRecord
  has_many :activitys, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
