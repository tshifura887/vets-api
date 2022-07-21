class PetsController < ApplicationController
    before_action :set_pet, only: [:show]

    def index 
        @pets = Pet.all  
        json_response(@pets)
    end

    def show 
        json_response(@pet)
    end

    def create  
        @pet = Pet.create!(pet_params)
    end

    private 
    def set_pet 
        @pet = Pet.find(params[:id])
    end

    def pet_params
        params.permit(:name, :pet_type, :pet_breed)
    end
end