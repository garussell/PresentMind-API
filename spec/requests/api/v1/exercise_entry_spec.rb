require 'rails_helper'

RSpec.describe "Api::V1::ExerciseEntries", type: :request do
  include_context "with valid token"

  before do 
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @exercise_entry = create(:exercise_entry, patient: @patient)
  end

  describe "exercise_entries#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/exercise_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:exercise_entries)
      expect(response_data[:exercise_entries]).to be_an(Array)

      expect(response_data[:exercise_entries].first).to have_key(:id)
      expect(response_data[:exercise_entries].first[:id]).to be_an(Integer)

      expect(response_data[:exercise_entries].first).to have_key(:goal)
      expect(response_data[:exercise_entries].first[:goal]).to be_a(String)

      expect(response_data[:exercise_entries].first).to have_key(:exercise_type)
      expect(response_data[:exercise_entries].first[:exercise_type]).to be_a(String)

      expect(response_data[:exercise_entries].first).to have_key(:total_minutes)
      expect(response_data[:exercise_entries].first[:total_minutes]).to be_an(Integer)

      expect(response_data[:exercise_entries].first).to have_key(:date)
      expect(response_data[:exercise_entries].first[:date]).to be_a(String)

      expect(response_data[:exercise_entries].first).to have_key(:patient_id)
      expect(response_data[:exercise_entries].first[:patient_id]).to be_an(Integer)

      expect(response_data[:exercise_entries].first).to have_key(:created_at)
      expect(response_data[:exercise_entries].first[:created_at]).to be_a(String)

      expect(response_data[:exercise_entries].first).to have_key(:updated_at)
      expect(response_data[:exercise_entries].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/exercise_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_a(String)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/1/exercise_entries"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "exercise_entries#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/exercise_entries/#{@exercise_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:exercise_entry)
      expect(response_data[:exercise_entry]).to be_a(Hash)

      expect(response_data[:exercise_entry]).to have_key(:id)
      expect(response_data[:exercise_entry][:id]).to be_an(Integer)

      expect(response_data[:exercise_entry]).to have_key(:goal)
      expect(response_data[:exercise_entry][:goal]).to be_a(String)

      expect(response_data[:exercise_entry]).to have_key(:exercise_type)
      expect(response_data[:exercise_entry][:exercise_type]).to be_a(String)

      expect(response_data[:exercise_entry]).to have_key(:total_minutes)
      expect(response_data[:exercise_entry][:total_minutes]).to be_an(Integer)

      expect(response_data[:exercise_entry]).to have_key(:date)
      expect(response_data[:exercise_entry][:date]).to be_a(String)

      expect(response_data[:exercise_entry]).to have_key(:patient_id)
      expect(response_data[:exercise_entry][:patient_id]).to be_an(Integer)

      expect(response_data[:exercise_entry]).to have_key(:created_at)
      expect(response_data[:exercise_entry][:created_at]).to be_a(String)

      expect(response_data[:exercise_entry]).to have_key(:updated_at)
      expect(response_data[:exercise_entry][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/exercise_entries/#{@exercise_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_a(String)
    end

    it "sad path: returns error if exercise entry not found" do 
      get "/api/v1/patients/#{@patient.id}/exercise_entries/0", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:not_found)
      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_a(String)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/1/exercise_entries/1"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "exercise_entries#create", :vcr do
    it "returns http success" do
      initial_count = ExerciseEntry.count
      post "/api/v1/patients/#{@patient.id}/exercise_entries",
            params: { exercise_entry: { goal: "Get swole", exercise_type: "strength", total_minutes: 60, date: "2021-07-01", patient_id: @patient.id } },
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)
      expect(ExerciseEntry.count).to eq(initial_count + 1)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Exercise entry created successfully")
    end

    it "sad path: returns error if missing required fields" do
      initial_count = ExerciseEntry.count
      
      post "/api/v1/patients/#{@patient.id}/exercise_entries",
            params: { exercise_entry: { exercise_type: "strength", total_minutes: 60, date: "2021-07-01" } },
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(ExerciseEntry.count).to eq(initial_count)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors].first).to be_a(String)
      expect(response_data[:errors].first).to eq("Goal can't be blank")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/exercise_entries",
            params: { exercise_entry: { goal: "Get swole", exercise_type: "strength", total_minutes: 60, date: "2021-07-01", patient_id: 0 } },
            headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      post "/api/v1/patients/1/exercise_entries",
          params: { exercise_entry: { goal: "Get swole", exercise_type: "strength", total_minutes: 60, date: "2021-07-01", patient_id: 1 } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "exercise_entries#update", :vcr do
    it "returns http success" do
      initial_goal = @exercise_entry.goal
      patch "/api/v1/patients/#{@patient.id}/exercise_entries/#{@exercise_entry.id}",
            params: { exercise_entry: { goal: "Increase noodle capacity" }},
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)

      expect(@exercise_entry.reload.goal).to_not eq(initial_goal)
      expect(@exercise_entry.reload.goal).to eq("Increase noodle capacity")

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Exercise entry updated successfully")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/exercise_entries/#{@exercise_entry.id}",
            params: { exercise_entry: { goal: "Increase noodle capacity" }},
            headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if exercise entry not found" do
      patch "/api/v1/patients/#{@patient.id}/exercise_entries/0",
            params: { exercise_entry: { goal: "Increase noodle capacity" }},
            headers: {'Authorization': @valid_token}
        
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "exercise_entries#destroy", :vcr do
    it "returns http success" do
      initial_count = ExerciseEntry.count
      delete "/api/v1/patients/#{@patient.id}/exercise_entries/#{@exercise_entry.id}",
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(ExerciseEntry.count).to eq(initial_count - 1)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Exercise entry deleted successfully")
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/exercise_entries/#{@exercise_entry.id}",
            headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if exercise entry not found" do
      delete "/api/v1/patients/#{@patient.id}/exercise_entries/0",
            headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      delete "/api/v1/patients/#{@patient.id}/exercise_entries/#{@exercise_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end