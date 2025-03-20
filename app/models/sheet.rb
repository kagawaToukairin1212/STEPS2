class Sheet < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy
  accepts_nested_attributes_for :goals

  validates :title, presence: true
end
