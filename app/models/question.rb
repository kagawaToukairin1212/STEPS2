class Question < ApplicationRecord
  belongs_to :user
  has_many :question_responses, dependent: :destroy

  enum status: { unresolved: 0, resolved: 1 } # 未解決: 0, 解決済み: 1

  scope :unresolved, -> { where(status: 0) }
  scope :resolved, -> { where(status: 1) }
end
