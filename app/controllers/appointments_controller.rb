class AppointmentsController < ApplicationController
  before_action :set_registration

  def create
    @appointment = @registration.appointments.create!(appointment_params)
    json_response(@appointment, :created)
  end

  def registrations_appointments
    json_response(@registration.appointments)
  end
  
  private 

  def appointment_params 
    params.permit(:appointment_date)
  end

  def set_registration 
    @registration = Registration.find(params[:registration_id])
  end
end


