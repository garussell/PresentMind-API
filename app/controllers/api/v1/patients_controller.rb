class Api::V1::PatientsController < ApplicationController
  before_action :authorize

  def index
    begin
      therapist = Therapist.find(params[:therapist_id])
      patients = therapist.patients
  
      render json: patients, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end  

  def show
    begin
      patient = Patient.find(params[:id])

      render json: patient, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:id])

      if patient.update(patient_params)
        render json: patient, status: :ok
      else
        render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def create
    begin 
      patient = Patient.new(patient_params)

      if patient.save
        render json: patient, status: :created
      else
        render json: { errors: patient.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  def destroy
    begin 
      patient = Patient.find(params[:id])

      if patient
        patient.destroy
        render json: { message: "Patient deleted successfully" }, status: :ok
      else
        render json: { errors: "Patient not found" }, status: :not_found
      end
    rescue StandardError => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  private 

  def patient_params
    params.require(:patient).permit(:name, :email, :dob, :phone, :address, :emergency_contact_name, :emergency_contact_number, :therapist_id)
  end
end
