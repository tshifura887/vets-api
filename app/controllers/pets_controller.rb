class PetsController < ApplicationController
    before_action :set_pet, only: [:show, :destroy]
    def index
        @pets = current_user.pets.all
        json_response(@pets) 
    end 

    def create
        user = User.find_by(role: 'owner')

        if user.present?
            @pet = current_user.pets.create!(pet_params)
            json_response(@pet, :created)
        else  
            json_response(:unprocessable_entity)
        end
    end

    def show 
        json_response(@pet)
    end

    def destroy 
        @pet.destroy
        head :no_content
    end

    private 

    def pet_params
        params.permit(:name, :pet_type, :pet_breed, :age)
    end

    def set_pet 
        @pet = Pet.find(params[:id])
    end

end