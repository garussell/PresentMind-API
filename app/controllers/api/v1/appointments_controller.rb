class Api::V1::AppointmentsController < ApplicationController
  before_action :authorize

  def index
    begin
      appointments = Patient.find(params[:patient_id]).appointments
      render json: { appointments: appointments, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      patient = Patient.find(params[:patient_id])
      appointment = patient.appointments.find(params[:id])
  
      render json: appointment, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end  
end