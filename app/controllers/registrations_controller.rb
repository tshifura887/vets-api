class RegistrationsController < ApplicationController
    before_action :set_registration, only: :update

    def create
        
        @pet = Pet.find(params[:pet_id])
        @vet = User.find_by(name: params[:vet_name])
        if @vet.present?
            @user = @pet.users.find_by(role: 'owner')
            @pet.registrations.create!(user_id: @vet.id, registered: true)
            json_response(@current_user, :created)
        else   
            json_response(:unprocessable_entity)
        end
    end

    def update
        @registration.update(accepted: true, registration_date: DateTime.now)
    end

    private 
    def set_registration
        @registration = Registration.find(params[:id])
    end

    def registration_params
        params.permit(:requested, :accepted, :registration_date)
    end
end
