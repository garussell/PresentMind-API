class Api::V1::PatternsController < ApplicationController
  before_action :authorize

  def index
    begin
      patient = Patient.find(params[:patient_id])
      pattern = patient.patterns.first

      if available_entries?(patient)
        serialized_stats = PatternSerializer.create_stats(patient, pattern)
        render json: serialized_stats, status: :ok
      else
        render json: {error: "No entries found for patient"}, status: :not_found
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    end
  end

  private

  def available_entries?(patient)
    appointment_stats_available = patient.appointments.present? 
    exercise_stats_available = patient.exercise_entries.present? 
    journal_stats_available = patient.journal_entries.present? 
    medication_stats_available = patient.medication_entries.present? 
    mindfulness_stats_available = patient.mindfulness_activities.present? 
    nutrition_stats_available = patient.nutrition_entries.present? 
    sleep_entry_stats_available = patient.sleep_entries.present? 
    social_interaction_stats_available = patient.social_interactions.present? 
  
    appointment_stats_available || exercise_stats_available || journal_stats_available || medication_stats_available || mindfulness_stats_available || nutrition_stats_available || sleep_entry_stats_available || social_interaction_stats_available
  end
end