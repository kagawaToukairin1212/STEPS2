class Goal < ApplicationRecord
  belongs_to :sheet
  belongs_to :evaluation_department

  validates :value, presence: true
end
