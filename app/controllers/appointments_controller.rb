class AppointmentsController < ApplicationController

  def create
    appointment = Appointment.new(appointment_params)
    appointment.status = 'scheduled'
    if appointment.save
      render json: appointment, status: :created
    else
      render json: appointment.errors, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:doctor_id, :patient_id, :appointment_time)
  end
end
