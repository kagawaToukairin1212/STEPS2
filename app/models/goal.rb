class Goal < ApplicationRecord
  belongs_to :sheet
  belongs_to :evaluation_department
  has_many :evaluation_scores, dependent: :destroy # 1つのGoalに複数のスコア

  validates :value, presence: true
end
