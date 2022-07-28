class PetsController < ApplicationController

    def index
        pets = current_user.pets.all
        render json: pets.to_json
    end 

    def create 
        pet = current_user.pets.create!(pet_params)
        json_response(pet, :created)  
    end

    def show 
        pet = Pet.find(params[:id])
        json_response(pet)
    end

    private 

    def pet_params
        params.permit(:name, :pet_type, :pet_breed, :age)
    end

end