class Api::V1::JournalEntriesController < ApplicationController
  before_action :authorize

  def index
    begin
      entries = Patient.find(params[:patient_id]).journal_entries
      render json: { journal_entries: entries, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      entry = Patient.find(params[:patient_id]).journal_entries.find(params[:id])
      render json: { journal_entry: entry, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])

      patient.journal_entries.create(journal_entry_params)
      render json: { message: "Journal entry created successfully" }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.journal_entries.find(params[:id])

      entry.update(journal_entry_params)
      render json: { message: "Journal entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.journal_entries.find(params[:id])

      entry.destroy
      render json: { message: "Journal entry deleted successfully" }, status: :ok  
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def journal_entry_params
    params.require(:journal_entry).permit(:title, :content, :date, :patient_id)
  end
end