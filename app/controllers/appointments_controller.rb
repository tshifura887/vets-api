class AppointmentsController < ApplicationController

    def create 
        def create
            pet = Pet.find(params[:id])
            if (pet.present? && User.find_by(email: params[:vet_email]))
              vet = User.find_by(email: params[:vet_email])
              registration = pet.registrations.find_by(user_id: vet.id)
              registration.appointments.create!(date: params[:date].to_datetime)
              json_response(pet.owner, status =  :created)
            else
              json_response({message: Message.appointment_unsuccesfull},:unprocessable_entity )
            end
        end
    end
end
