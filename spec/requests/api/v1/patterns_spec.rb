require 'rails_helper'

RSpec.describe "Api::V1::Patterns", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @pattern = create(:pattern, patient: @patient)
  end
  
  describe "index", :vcr do
    it "returns http success" do
      appointments = create_list(:appointment, 20, patient: @patient)
      exercise_entries = create_list(:exercise_entry, 20, patient: @patient)
      journal_entries = create_list(:journal_entry, 20, patient: @patient)
      medication_entries = create_list(:medication_entry, 20, patient: @patient)
      mindfulness_activities = create_list(:mindfulness_activity, 20, patient: @patient)
      nutrition_entries = create_list(:nutrition_entry, 20, patient: @patient)
      sleep_entries = create_list(:sleep_entry, 20, patient: @patient)
      social_interactions = create_list(:social_interaction, 20, patient: @patient)

      get "/api/v1/patients/#{@patient.id}/patterns", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:success)
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data).to have_key(:pattern_id)
      expect(response_data[:pattern_id]).to be_a(Integer)

      expect(response_data).to have_key(:pattern) 
      expect(response_data[:pattern]).to be_a(Hash)

      expect(response_data[:pattern]).to have_key(:appointments)
      expect(response_data[:pattern][:appointments]).to be_a(Hash)

      expect(response_data[:pattern][:appointments]).to have_key(:average_mood_before_appointment)
      expect(response_data[:pattern][:appointments][:average_mood_before_appointment]).to be_a(Float)

      expect(response_data[:pattern][:appointments]).to have_key(:average_mood_after_appointment)
      expect(response_data[:pattern][:appointments][:average_mood_after_appointment]).to be_a(Float)

      expect(response_data[:pattern][:appointments]).to have_key(:average_stress_before_appointment)
      expect(response_data[:pattern][:appointments][:average_stress_before_appointment]).to be_a(Float)

      expect(response_data[:pattern][:appointments]).to have_key(:average_stress_after_appointment)
      expect(response_data[:pattern][:appointments][:average_stress_after_appointment]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:exercise_entries)
      expect(response_data[:pattern][:exercise_entries]).to be_a(Hash)
      
      expect(response_data[:pattern][:exercise_entries]).to have_key(:average_mood_before_exercise)
      expect(response_data[:pattern][:exercise_entries][:average_mood_before_exercise]).to be_a(Float)

      expect(response_data[:pattern][:exercise_entries]).to have_key(:average_mood_after_exercise)
      expect(response_data[:pattern][:exercise_entries][:average_mood_after_exercise]).to be_a(Float)

      expect(response_data[:pattern][:exercise_entries]).to have_key(:average_stress_before_exercise)
      expect(response_data[:pattern][:exercise_entries][:average_stress_before_exercise]).to be_a(Float)

      expect(response_data[:pattern][:exercise_entries]).to have_key(:average_stress_after_exercise)
      expect(response_data[:pattern][:exercise_entries][:average_stress_after_exercise]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:journal_entries)
      expect(response_data[:pattern][:journal_entries]).to be_a(Hash)

      expect(response_data[:pattern][:journal_entries]).to have_key(:average_mood_before_journal)
      expect(response_data[:pattern][:journal_entries][:average_mood_before_journal]).to be_a(Float)

      expect(response_data[:pattern][:journal_entries]).to have_key(:average_mood_after_journal)
      expect(response_data[:pattern][:journal_entries][:average_mood_after_journal]).to be_a(Float)
      
      expect(response_data[:pattern][:journal_entries]).to have_key(:average_stress_before_journal)
      expect(response_data[:pattern][:journal_entries][:average_stress_before_journal]).to be_a(Float)

      expect(response_data[:pattern][:journal_entries]).to have_key(:average_stress_after_journal)
      expect(response_data[:pattern][:journal_entries][:average_stress_after_journal]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:medication_entries)
      expect(response_data[:pattern][:medication_entries]).to be_a(Hash)

      expect(response_data[:pattern][:medication_entries]).to have_key(:average_mood_before_medication)
      expect(response_data[:pattern][:medication_entries][:average_mood_before_medication]).to be_a(Float)

      expect(response_data[:pattern][:medication_entries]).to have_key(:average_mood_after_medication)
      expect(response_data[:pattern][:medication_entries][:average_mood_after_medication]).to be_a(Float)

      expect(response_data[:pattern][:medication_entries]).to have_key(:average_stress_before_medication)
      expect(response_data[:pattern][:medication_entries][:average_stress_before_medication]).to be_a(Float)

      expect(response_data[:pattern][:medication_entries]).to have_key(:average_stress_after_medication)
      expect(response_data[:pattern][:medication_entries][:average_stress_after_medication]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:mindfulness_activities)
      expect(response_data[:pattern][:mindfulness_activities]).to be_a(Hash)

      expect(response_data[:pattern][:mindfulness_activities]).to have_key(:average_mood_before_mindfulness_activity)
      expect(response_data[:pattern][:mindfulness_activities][:average_mood_before_mindfulness_activity]).to be_a(Float)

      expect(response_data[:pattern][:mindfulness_activities]).to have_key(:average_mood_after_mindfulness_activity)
      expect(response_data[:pattern][:mindfulness_activities][:average_mood_after_mindfulness_activity]).to be_a(Float)

      expect(response_data[:pattern][:mindfulness_activities]).to have_key(:average_stress_before_mindfulness_activity)
      expect(response_data[:pattern][:mindfulness_activities][:average_stress_before_mindfulness_activity]).to be_a(Float)

      expect(response_data[:pattern][:mindfulness_activities]).to have_key(:average_stress_after_mindfulness_activity)
      expect(response_data[:pattern][:mindfulness_activities][:average_stress_after_mindfulness_activity]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:nutrition_entries)
      expect(response_data[:pattern][:nutrition_entries]).to be_a(Hash)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_before_nutrition)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_before_nutrition]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_after_nutrition)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_after_nutrition]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_after_incorrect_portion_unhealthy)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_after_incorrect_portion_unhealthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_after_incorrect_portion_healthy)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_after_incorrect_portion_healthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_after_correct_portion_unhealthy)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_after_correct_portion_unhealthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_mood_after_correct_portion_healthy)
      expect(response_data[:pattern][:nutrition_entries][:average_mood_after_correct_portion_healthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_before_nutrition)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_before_nutrition]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_after_nutrition)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_after_nutrition]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_after_incorrect_portion_unhealthy)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_after_incorrect_portion_unhealthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_after_incorrect_portion_healthy)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_after_incorrect_portion_healthy]).to be_a(Float)

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_after_correct_portion_unhealthy)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_after_correct_portion_unhealthy]).to be_a(Float) 

      expect(response_data[:pattern][:nutrition_entries]).to have_key(:average_stress_after_correct_portion_healthy)
      expect(response_data[:pattern][:nutrition_entries][:average_stress_after_correct_portion_healthy]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:sleep_entries)
      expect(response_data[:pattern][:sleep_entries]).to be_a(Hash)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_before_sleep)
      expect(response_data[:pattern][:sleep_entries][:average_mood_before_sleep]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_after_sleep)
      expect(response_data[:pattern][:sleep_entries][:average_mood_after_sleep]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_after_dreams)
      expect(response_data[:pattern][:sleep_entries][:average_mood_after_dreams]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_after_no_dreams)
      expect(response_data[:pattern][:sleep_entries][:average_mood_after_no_dreams]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_less_than_8_hours)
      expect(response_data[:pattern][:sleep_entries][:average_mood_less_than_8_hours]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_mood_8_hours)
      expect(response_data[:pattern][:sleep_entries][:average_mood_8_hours]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_stress_before_sleep)
      expect(response_data[:pattern][:sleep_entries][:average_stress_before_sleep]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_stress_after_sleep)
      expect(response_data[:pattern][:sleep_entries][:average_stress_after_sleep]).to be_a(Float)

      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_stress_after_dreams)
      expect(response_data[:pattern][:sleep_entries][:average_stress_after_dreams]).to be_a(Float)
      
      expect(response_data[:pattern][:sleep_entries]).to have_key(:average_stress_after_no_dreams)
      expect(response_data[:pattern][:sleep_entries][:average_stress_after_no_dreams]).to be_a(Float)

      expect(response_data[:pattern]).to have_key(:social_interactions)
      expect(response_data[:pattern][:social_interactions]).to be_a(Hash)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_before_social_interaction)
      expect(response_data[:pattern][:social_interactions][:average_mood_before_social_interaction]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_after_social_interaction)
      expect(response_data[:pattern][:social_interactions][:average_mood_after_social_interaction]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_after_social_with_alcohol_no_drugs)
      expect(response_data[:pattern][:social_interactions][:average_mood_after_social_with_alcohol_no_drugs]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_after_social_with_drugs_no_alcohol)
      expect(response_data[:pattern][:social_interactions][:average_mood_after_social_with_drugs_no_alcohol]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_after_social_with_alcohol_and_drugs)
      expect(response_data[:pattern][:social_interactions][:average_mood_after_social_with_alcohol_and_drugs]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_mood_after_social_with_no_alcohol_no_drugs)
      expect(response_data[:pattern][:social_interactions][:average_mood_after_social_with_no_alcohol_no_drugs]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_before_social_interaction)
      expect(response_data[:pattern][:social_interactions][:average_stress_before_social_interaction]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_after_social_interaction)
      expect(response_data[:pattern][:social_interactions][:average_stress_after_social_interaction]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_after_social_with_alcohol_no_drugs)
      expect(response_data[:pattern][:social_interactions][:average_stress_after_social_with_alcohol_no_drugs]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_after_social_with_drugs_no_alcohol)
      expect(response_data[:pattern][:social_interactions][:average_stress_after_social_with_drugs_no_alcohol]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_after_social_with_alcohol_and_drugs)
      expect(response_data[:pattern][:social_interactions][:average_stress_after_social_with_alcohol_and_drugs]).to be_a(Float)

      expect(response_data[:pattern][:social_interactions]).to have_key(:average_stress_after_social_with_no_alcohol_no_drugs)
      expect(response_data[:pattern][:social_interactions][:average_stress_after_social_with_no_alcohol_no_drugs]).to be_a(Float)
    end
  end

  describe "index sad path", :vcr do
    it "returns http not found" do
      get "/api/v1/patients/#{@patient.id}/patterns", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data[:error]).to eq("No entries found for patient")
    end

    it "throws an error if the patient does not exist" do
      get "/api/v1/patients/0/patterns", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response_data[:error]).to eq("Couldn't find Patient with 'id'=0")
    end

    it "throws an error if not authorized" do
      get "/api/v1/patients/0/patterns"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end