class RegistrationsController < ApplicationController
    before_action :set_registration, only: :update
    before_action :set_pet

    def create
        @vet = User.find_by(name: params[:vet_email])
        if @vet.present?
            @user = @pet.users.find_by(role: 'owner')
            @pet.registrations.create!(user_id: vet.id, registration_date: DateTime.now, requested_registration: true)
            json_response(@current_user, :created)
        else   
            json_response(:unprocessable_entity)
        end
    end

    def update 
        @registration.update(accepted: true)
        head :no_content
    end

    private 
    def set_registration
        @registration = Registration.find(params[:id])
    end

    def set_pet
        @pet = Pet.find(params[:pet_id])
    end

    def registration_params
        params.permit(:requested_registration, :accepted, :registration_date)
    end

end
