class Registration < ApplicationRecord
  belongs_to :pet
  belongs_to :user
end
