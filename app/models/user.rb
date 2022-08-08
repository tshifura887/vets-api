class User < ApplicationRecord
    has_secure_password

    has_many :registrations, dependent: :destroy
    has_many :pets, through: :registrations

    validates_presence_of :name,:email, :password_digest, :role
    validates :email, uniqueness: true
end
