class Registration < ApplicationRecord
  belongs_to :pet
  belongs_to :user
  has_many :appointments, dependent: :destroy

  
end
