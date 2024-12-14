class EvaluationScore < ApplicationRecord
  belongs_to :sheet
  belongs_to :evaluation_department
end
