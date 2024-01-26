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

  def create
    begin
      patient = Patient.find(params[:patient_id])

      patient.appointments.create(appointment_params)
      render json: { message: "Appointment created successfully" }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin 
      patient = Patient.find(params[:patient_id])
      appointment = patient.appointments.find(params[:id])
      
      appointment.update(appointment_params)
      render json: { message: "Appointment updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      appointment = patient.appointments.find(params[:id])

      appointment.destroy
      render json: { message: "Appointment deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :description, :start_time, :end_time, :patient_id)
  end
end