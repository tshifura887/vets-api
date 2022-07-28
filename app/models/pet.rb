class Pet < ApplicationRecord
    has_many :users, through: :registrations
    validates :name, presence: true
    validates :pet_type, presence: true
    validates :pet_breed, presence: true
end
