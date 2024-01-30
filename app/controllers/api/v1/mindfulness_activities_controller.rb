class Api::V1::MindfulnessActivitiesController < ApplicationController
  before_action :authorize

  def index
    begin
      activities = Patient.find(params[:patient_id]).mindfulness_activities
      render json: { mindfulness_activities: activities, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      activity = Patient.find(params[:patient_id]).mindfulness_activities.find(params[:id])
      render json: { mindfulness_activity: activity, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])
      mindfulness = patient.mindfulness_activities.create(mindfulness_activity_params)

      if mindfulness.save
        render json: { message: "Mindfulness activity created successfully" }, status: :created
      else
        render json: { errors: mindfulness.errors.full_messages }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin
      patient = Patient.find(params[:patient_id]) 
      activity = patient.mindfulness_activities.find(params[:id])

      activity.update(mindfulness_activity_params)
      render json: { message: "Mindfulness activity updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      activity = patient.mindfulness_activities.find(params[:id])

      activity.destroy
      render json: { message: "Mindfulness activity deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def mindfulness_activity_params
    params.require(:mindfulness_activity).permit(:activity, :total_minutes, :notes, :date, :patient_id)
  end
end