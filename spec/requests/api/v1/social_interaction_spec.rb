require 'rails_helper'

RSpec.describe "Api::V1::SocialInteractions", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @social_interaction = create(:social_interaction, patient: @patient)
  end

  describe "social_interactions#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/social_interactions", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:social_interactions)
      expect(response_data[:social_interactions]).to be_an(Array)

      expect(response_data[:social_interactions].first).to have_key(:event_name)
      expect(response_data[:social_interactions].first[:event_name]).to be_a(String)

      expect(response_data[:social_interactions].first).to have_key(:activity_type)
      expect(response_data[:social_interactions].first[:activity_type].to_i).to be_an(Integer)

      expect(response_data[:social_interactions].first).to have_key(:social_rating)
      expect(response_data[:social_interactions].first[:social_rating].to_i).to be_an(Integer)

      expect(response_data[:social_interactions].first).to have_key(:location)
      expect(response_data[:social_interactions].first[:location]).to be_a(String)

      expect(response_data[:social_interactions].first).to have_key(:duration_in_minutes)
      expect(response_data[:social_interactions].first[:duration_in_minutes]).to be_an(Integer)

      expect(response_data[:social_interactions].first).to have_key(:date)
      expect(response_data[:social_interactions].first[:date]).to be_a(String)

      expect(response_data[:social_interactions].first).to have_key(:alcohol_use)
      expect(response_data[:social_interactions].first[:alcohol_use]).to be(true).or be(false)

      expect(response_data[:social_interactions].first).to have_key(:drug_use)
      expect(response_data[:social_interactions].first[:drug_use]).to be(true).or be(false)

      expect(response_data[:social_interactions].first).to have_key(:patient_id)
      expect(response_data[:social_interactions].first[:patient_id]).to be_an(Integer)

      expect(response_data[:social_interactions].first).to have_key(:created_at)
      expect(response_data[:social_interactions].first[:created_at]).to be_a(String)

      expect(response_data[:social_interactions].first).to have_key(:updated_at)
      expect(response_data[:social_interactions].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/social_interactions", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/social_interactions"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "social_interactions#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/social_interactions/#{@social_interaction.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:social_interaction)
      expect(response_data[:social_interaction]).to be_a(Hash)

      expect(response_data[:social_interaction]).to have_key(:event_name)
      expect(response_data[:social_interaction][:event_name]).to be_a(String)

      expect(response_data[:social_interaction]).to have_key(:activity_type)
      expect(response_data[:social_interaction][:activity_type].to_i).to be_an(Integer)

      expect(response_data[:social_interaction]).to have_key(:social_rating)
      expect(response_data[:social_interaction][:social_rating].to_i).to be_an(Integer)

      expect(response_data[:social_interaction]).to have_key(:location)
      expect(response_data[:social_interaction][:location]).to be_a(String)

      expect(response_data[:social_interaction]).to have_key(:duration_in_minutes)
      expect(response_data[:social_interaction][:duration_in_minutes]).to be_an(Integer)

      expect(response_data[:social_interaction]).to have_key(:date)
      expect(response_data[:social_interaction][:date]).to be_a(String)

      expect(response_data[:social_interaction]).to have_key(:alcohol_use)
      expect(response_data[:social_interaction][:alcohol_use]).to be(true).or be(false)

      expect(response_data[:social_interaction]).to have_key(:drug_use)
      expect(response_data[:social_interaction][:drug_use]).to be(true).or be(false)

      expect(response_data[:social_interaction]).to have_key(:patient_id)
      expect(response_data[:social_interaction][:patient_id]).to be_an(Integer)

      expect(response_data[:social_interaction]).to have_key(:created_at)
      expect(response_data[:social_interaction][:created_at]).to be_a(String)

      expect(response_data[:social_interaction]).to have_key(:updated_at)
      expect(response_data[:social_interaction][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/social_interactions/#{@social_interaction.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if social_interaction not found" do
      get "/api/v1/patients/#{@patient.id}/social_interactions/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/1/social_interactions/1"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "social_interactions#create", :vcr do
    it "returns http success" do
      initial_count = SocialInteraction.count 

      post "/api/v1/patients/#{@patient.id}/social_interactions", 
          headers: {'Authorization': @valid_token}, 
          params: { social_interaction: { event_name: "Test Event", activity_type: :alone, social_rating: :poor, location: "Test Location", duration_in_minutes: 60, date: "2021-01-01", alcohol_use: false, drug_use: false, patient_id: 1 } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Social interaction created successfully")
      expect(SocialInteraction.count).to eq(initial_count + 1)
    end

    it "sad path: returns error if invalid params" do
      initial_count = SocialInteraction.count

      post "/api/v1/patients/#{@patient.id}/social_interactions", 
          headers: {'Authorization': @valid_token}, 
          params: { social_interaction: { activity_type: :alone, social_rating: :poor, location: "Test Location", duration_in_minutes: 60, date: "2021-01-01", alcohol_use: false, drug_use: false, patient_id: 1 } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors].first).to be_a(String)
      expect(response_data[:errors].first).to eq("Event name can't be blank")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/social_interactions", 
          headers: {'Authorization': @valid_token}, 
          params: { social_interaction: { event_name: "Test Event", activity_type: 1, social_rating: 5, location: "Test Location", duration_in_minutes: 60, date: "2021-01-01", alcohol_use: false, drug_use: false, patient_id: 1 } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/#{@patient.id}/social_interactions", 
          params: { social_interaction: { event_name: "Test Event", activity_type: 1, social_rating: 5, location: "Test Location", duration_in_minutes: 60, date: "2021-01-01", alcohol_use: false, drug_use: false, patient_id: 1 } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "social_interactions#update", :vcr do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/social_interactions/#{@social_interaction.id}",
          headers: {'Authorization': @valid_token},
          params: { social_interaction: { event_name: "Updated Event" } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Social interaction updated successfully")
      expect(SocialInteraction.find(@social_interaction.id).event_name).to eq("Updated Event")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/social_interactions/#{@social_interaction.id}",
          headers: {'Authorization': @valid_token},
          params: { social_interaction: { event_name: "Updated Event" } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if social_interaction not found" do
      patch "/api/v1/patients/#{@patient.id}/social_interactions/0",
          headers: {'Authorization': @valid_token},
          params: { social_interaction: { event_name: "Updated Event" } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/#{@patient.id}/social_interactions/#{@social_interaction.id}",
          params: { social_interaction: { event_name: "Updated Event" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "social_interactions#destroy", :vcr do
    it "returns http success" do
      initial_count = SocialInteraction.count
      delete "/api/v1/patients/#{@patient.id}/social_interactions/#{@social_interaction.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(response_data).to have_key(:message)

      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Social interaction deleted successfully")
      expect(SocialInteraction.count).to eq(initial_count - 1)
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/social_interactions/#{@social_interaction.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if social_interaction not found" do
      delete "/api/v1/patients/#{@patient.id}/social_interactions/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/#{@patient.id}/social_interactions/#{@social_interaction.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end