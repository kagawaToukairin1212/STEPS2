class Sheet < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy
  
  validates :title, presence: true
end
