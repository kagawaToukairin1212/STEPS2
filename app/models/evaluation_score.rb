class EvaluationScore < ApplicationRecord
  belongs_to :goal # Goalに関連付け

  validates :result, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
