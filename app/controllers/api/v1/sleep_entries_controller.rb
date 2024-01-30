class Api::V1::SleepEntriesController < ApplicationController
  before_action :authorize

  def index
    begin
      sleep_entries = Patient.find(params[:patient_id]).sleep_entries
      render json: { sleep_entries: sleep_entries, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      entry = Patient.find(params[:patient_id]).sleep_entries.find(params[:id])
      render json: { sleep_entry: entry, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])
      sleep_entry = patient.sleep_entries.create(sleep_entry_params)

      if sleep_entry.save
        render json: { message: "Sleep entry created successfully" }, status: :created 
      else
        render json: { errors: sleep_entry.errors.full_messages }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.sleep_entries.find(params[:id])

      entry.update(sleep_entry_params)
      render json: { message: "Sleep entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.sleep_entries.find(params[:id])

      entry.destroy
      render json: { message: "Sleep entry deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def sleep_entry_params
    params.require(:sleep_entry).permit(:bed_time, :quality_rating, :total_hours, :dream, :notes, :date, :patient_id)
  end
end