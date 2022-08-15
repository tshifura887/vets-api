class RegistrationsController < ApplicationController
    before_action :set_registration, only: [:update, :destroy, :show]

    def show 
        json_response(@registration)
    end

    def create
        @pet = Pet.find(params[:pet_id])
        @vet = User.find_by(name: params[:vet_name])
        if @vet.present?
            @user = @pet.users.find_by(role: 'owner')
            @pet.registrations.create!(user_id: @vet.id, registered: true, vet: params[:vet_name])
            json_response(@current_user, :created)
        else   
            json_response(:unprocessable_entity)
        end
    end

    def update
        @registration.update(accepted: true, registration_date: DateTime.now)
        head :no_content
    end

    def destroy 
        @registration.destroy 
        head :no_content
    end

    # def pets_registrations
    #     pet = Pet.find(params[:pet_id])
    #     json_response(pet.registrations)
    # end

    private 
    def set_registration
        @registration = Registration.find(params[:id])
    end

end
