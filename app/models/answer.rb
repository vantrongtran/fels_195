class Answer < ApplicationRecord
  has_many :results, dependent: :destroy
  belongs_to :word
end
