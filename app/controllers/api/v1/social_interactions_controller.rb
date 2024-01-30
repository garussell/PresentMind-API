class Api::V1::SocialInteractionsController < ApplicationController
  before_action :authorize

  def index
    begin
      social_interactions = Patient.find(params[:patient_id]).social_interactions
      render json: { social_interactions: social_interactions, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def show
    begin
      interaction = Patient.find(params[:patient_id]).social_interactions.find(params[:id]) 
      render json: { social_interaction: interaction, status: :ok }
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def create
    begin
      patient = Patient.find(params[:patient_id])
      social = patient.social_interactions.create(social_interaction_params)

      if social.save
        render json: { message: "Social interaction created successfully" }, status: :created
      else
        render json: { errors: social.errors.full_messages }, status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound => e 
      render json: { errors: e.message }, status: :not_found
    end
  end

  def edit; end

  def update
    begin 
      patient = Patient.find(params[:patient_id])
      interaction = patient.social_interactions.find(params[:id])

      interaction.update(social_interaction_params) 
      render json: { message: "Social interaction updated successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  def destroy
    begin
      patient = Patient.find(params[:patient_id])
      interaction = patient.social_interactions.find(params[:id])

      interaction.destroy  
      render json: { message: "Social interaction deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :not_found
    end
  end

  private

  def social_interaction_params
    params.require(:social_interaction).permit(:event_name, :activity_type, :social_rating, :location, :duration_in_minutes, :date, :alcohol_use, :drug_use, :patient_id)
  end
end