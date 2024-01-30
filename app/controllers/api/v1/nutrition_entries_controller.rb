class Api::V1::NutritionEntriesController < ApplicationController
  before_action :authorize

  def index
    begin
      nutrition_entries = Patient.find(params[:patient_id]).nutrition_entries
      render json: { nutrition_entries: nutrition_entries, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      entry = Patient.find(params[:patient_id]).nutrition_entries.find(params[:id])
      render json: { nutrition_entry: entry, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])
      patient.nutrition_entries.create(nutrition_entry_params)

      render json: { message: "Nutrition entry created successfully" }, status: :created
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.nutrition_entries.find(params[:id])

      entry.update(nutrition_entry_params)
      render json: { message: "Nutrition entry updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      entry = patient.nutrition_entries.find(params[:id])

      entry.destroy
      render json: { message: "Nutrition entry deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def nutrition_entry_params
    params.require(:nutrition_entry).permit(:food_item, :calories, :number_of_servings, :healthy, :cups_of_water, :fruits_and_veg_servings, :correct_portion, :date, :patient_id)
  end
end