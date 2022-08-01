class AppointmentsController < ApplicationController

  def create
    @registration = Registration.find(params[:registration_id])
    @appointment = @registration.appointments.create!(appointment_params)
    json_response(@appointment, :created)
  end

  private 

  def appointment_params 
    params.permit(:appointment_date)
  end
end


