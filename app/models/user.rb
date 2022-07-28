class User < ApplicationRecord
    has_secure_password

    has_many :pets, through: :registrations
    
    has_many :registrations
    has_many :pets, through: :registrations
    validates_presence_of :name, :email, :password_digest, :role
end
