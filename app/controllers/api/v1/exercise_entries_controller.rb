class Api::V1::ExerciseEntriesController < ApplicationController
  before_action :authorize

  def index
    begin
      entries = Patient.find(params[:patient_id]).exercise_entries
      render json: { exercise_entries: entries, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin 
      entry = Patient.find(params[:patient_id]).exercise_entries.find(params[:id])
      render json: { exercise_entry: entry, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin 
      patient = Patient.find(params[:patient_id])
      exercise = patient.exercise_entries.create(exercise_entry_params)

      if exercise.save
        render json: { message: "Exercise entry created successfully" }, status: :created
      else
        render json: { errors: exercise.errors.full_messages }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update  
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.exercise_entries.find(params[:id])

      entry.update(exercise_entry_params)
      render json: { message: "Exercise entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.exercise_entries.find(params[:id])

      entry.destroy
      render json: { message: "Exercise entry deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def exercise_entry_params
    params.require(:exercise_entry).permit(:goal, :exercise_type, :total_minutes, :date, :patient_id)
  end
end