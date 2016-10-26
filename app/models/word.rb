class Word < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :content, presence: true, length: {maximum: 100}
  validate :validate_answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :search, ->keyword {where "content LIKE ?", "%#{keyword}%"}

  def validate_answers
    if answers.size < Settings.minimum_answer
      errors.add :answers, I18n.t("answer_must_more_one")
    end
    if answers.reject{|answer| !answer.is_correct?}.count == 0
      errors.add :answers, I18n.t("word_must_has_correct_answer")
    end
  end
end
