class PetsController < ApplicationController
    before_action :set_pet, only: [:show]

    def index 
        @pets = current_user.pets 
        json_response(@pets)
    end

    def show 
        json_response(@pet)
    end

    def create  
        @pet = current_user.pets.create!(pet_params)
        json_response(@pet, :created)
    end

    private 
    def set_pet 
        @pet = Pet.find(params[:id])
    end

    def pet_params
        params.permit(:name, :pet_type, :pet_breed, :age)
    end
end