class Pet < ApplicationRecord

    validates :name, presence: true
    validates :pet_type, presence: true
    validates :pet_breed, presence: true
end
