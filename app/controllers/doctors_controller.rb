class DoctorsController < ApplicationController
  def index
    doctors = Doctor.all # For simplicity, returning all. In real app, filter by availability.
    render json: doctors
  end
end
