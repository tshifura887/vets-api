class Pet < ApplicationRecord
    has_many :registrations, dependent: :destroy
    has_many :users, through: :registrations
    has_many :appointments, dependent: :destroy
    
    validates :name, presence: true
    validates :pet_type, presence: true
    validates :pet_breed, presence: true
end
