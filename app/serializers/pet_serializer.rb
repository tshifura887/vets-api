class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :pet_type, :pet_breed, :created_at, :updated_at
  has_many :registrations
  has_many :appointments
end
