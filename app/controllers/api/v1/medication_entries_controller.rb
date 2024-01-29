class Api::V1::MedicationEntriesController < ApplicationController
  before_action :authorize

  def index
    begin
      entries = Patient.find(params[:patient_id]).medication_entries
      render json: { medication_entries: entries, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin 
      entry = Patient.find(params[:patient_id]).medication_entries.find(params[:id])
      render json: { medication_entry: entry, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])

      patient.medication_entries.create(medication_entry_params)
      render json: { message: "Medication entry created successfully" }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.medication_entries.find(params[:id])

      entry.update(medication_entry_params)
      render json: { message: "Medication entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.medication_entries.find(params[:id])

      entry.destroy
      render json: { message: "Medication entry deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def medication_entry_params
    params.require(:medication_entry).permit(:name, :purpose, :dose, :schedule, :patient_id)
  end
end