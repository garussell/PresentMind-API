require 'rails_helper'

RSpec.describe "Api::V1::MoodEntries", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @mood = create(:mood, patient: @patient)
  end

  describe "moods#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/moods", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:moods)
      expect(response_data[:moods]).to be_an(Array)

      expect(response_data[:moods].first).to have_key(:id)
      expect(response_data[:moods].first[:id]).to be_an(Integer)

      expect(response_data[:moods].first).to have_key(:current_mood_scale)
      expect(response_data[:moods].first[:current_mood_scale].to_i).to be_an(Integer)

      expect(response_data[:moods].first).to have_key(:stress_level_scale)
      expect(response_data[:moods].first[:stress_level_scale].to_i).to be_an(Integer)

      expect(response_data[:moods].first).to have_key(:patient_id)
      expect(response_data[:moods].first[:patient_id]).to be_an(Integer)

      expect(response_data[:moods].first).to have_key(:created_at)
      expect(response_data[:moods].first[:created_at]).to be_a(String)

      expect(response_data[:moods].first).to have_key(:updated_at)
      expect(response_data[:moods].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do  
      get "/api/v1/patients/0/moods", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/#{@patient.id}/moods"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "moods#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:mood)
      expect(response_data[:mood]).to be_a(Hash)

      expect(response_data[:mood]).to have_key(:id)
      expect(response_data[:mood][:id]).to be_an(Integer)

      expect(response_data[:mood]).to have_key(:current_mood_scale)
      expect(response_data[:mood][:current_mood_scale].to_i).to be_an(Integer)

      expect(response_data[:mood]).to have_key(:stress_level_scale)
      expect(response_data[:mood][:stress_level_scale].to_i).to be_an(Integer)

      expect(response_data[:mood]).to have_key(:patient_id)
      expect(response_data[:mood][:patient_id]).to be_an(Integer)

      expect(response_data[:mood]).to have_key(:created_at)
      expect(response_data[:mood][:created_at]).to be_a(String)

      expect(response_data[:mood]).to have_key(:updated_at)
      expect(response_data[:mood][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/moods/#{@mood.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if mood not found" do
      get "/api/v1/patients/#{@patient.id}/moods/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "moods#create", :vcr do
    it "returns http success" do
      initial_count = Mood.count
      post "/api/v1/patients/#{@patient.id}/moods",
          params: { mood: { current_mood_scale: :very_negative, stress_level_scale: :very_stressed } },
          headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(response_data).to be_a(Hash)
      expect(Mood.count).to eq(initial_count + 1)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Mood entry created successfully")
    end

    it "sad path: returns error if no mood params" do
      initial_count = Mood.count   

      post "/api/v1/patients/#{@patient.id}/moods",
          headers: {'Authorization': @valid_token},
          params: { mood: { stress_level_scale: :very_relaxed } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(Mood.count).to eq(initial_count)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors].first).to be_a(String)
      expect(response_data[:errors].first).to eq("Current mood scale can't be blank")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/moods",
          params: { mood: { current_mood_scale: :very_negative, stress_level_scale: :very_stressed } },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/0/moods",
          params: { mood: { current_mood_scale: :very_negative, stress_level_scale: :very_stressed } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "moods#update", :vcr do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}",
          params: { mood: { current_mood_scale: :very_positive, stress_level_scale: :very_relaxed } },
          headers: {'Authorization': @valid_token}
      
      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)  
      
      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Mood entry updated successfully")
      
      expect(@mood.reload.current_mood_scale).to eq("very_positive")
      expect(@mood.reload.stress_level_scale).to eq("very_relaxed")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/moods/#{@mood.id}",
          params: { mood: { current_mood_scale: :very_positive, stress_level_scale: :very_relaxed } },
          headers: {'Authorization': @valid_token}
      
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if mood not found" do
      patch "/api/v1/patients/#{@patient.id}/moods/0",
          params: { mood: { current_mood_scale: :very_positive, stress_level_scale: :very_relaxed } },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}",
          params: { mood: { current_mood_scale: :very_positive, stress_level_scale: :very_relaxed } }
          
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "moods#destroy", :vcr do
    it "returns http success" do
      initial_count = Mood.count

      delete "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}",
          headers: {'Authorization': @valid_token}
      
      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(Mood.count).to eq(initial_count - 1)

      expect(response_data).to be_a(Hash)
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Mood entry deleted successfully")
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/moods/#{@mood.id}",
          headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if mood not found" do
      delete "/api/v1/patients/#{@patient.id}/moods/0",
          headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/#{@patient.id}/moods/#{@mood.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end