class Api::V1::MoodsController < ApplicationController
  before_action :authorize

  def index
    begin
      moods = Patient.find(params[:patient_id]).moods
      render json: { moods: moods, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      mood = Patient.find(params[:patient_id]).moods.find(params[:id])
      render json: { mood: mood, status: :ok }
    rescue ActiveRecord::RecordNotFound => e 
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])
      patient.moods.create(mood_params)

      render json: { message: "Mood entry created successfully" }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin 
      patient = Patient.find(params[:patient_id])
      mood = patient.moods.find(params[:id])

      mood.update(mood_params)
      render json: { message: "Mood entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      mood = patient.moods.find(params[:id])

      mood.destroy
      render json: { message: "Mood entry deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def mood_params
    params.require(:mood).permit(:current_mood_scale, :stress_level_scale, :patient_id)
  end
end