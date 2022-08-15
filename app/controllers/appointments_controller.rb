class AppointmentsController < ApplicationController
  before_action :set_pet

  def create
    @appointment = @pet.appointments.create!(appointment_params)
    json_response(@appointment, :created)
  end
  
  private 

  def appointment_params 
    params.permit(:appointment_date)
  end

  def set_pet 
    @pet = Pet.find(params[:pet_id])
  end
end


