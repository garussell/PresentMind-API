require 'rails_helper'

RSpec.describe "Api::V1::SleepEntries", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @sleep_entry = create(:sleep_entry, patient: @patient)
  end

  describe "sleep_entries#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/sleep_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to have_key(:sleep_entries)
      expect(response_data[:sleep_entries]).to be_an(Array)

      expect(response_data[:sleep_entries].first).to have_key(:bed_time)
      expect(response_data[:sleep_entries].first[:bed_time]).to be_a(String)

      expect(response_data[:sleep_entries].first).to have_key(:quality_rating)
      expect(response_data[:sleep_entries].first[:quality_rating].to_i).to be_an(Integer)

      expect(response_data[:sleep_entries].first).to have_key(:total_hours)
      expect(response_data[:sleep_entries].first[:total_hours]).to be_an(Integer)

      expect(response_data[:sleep_entries].first).to have_key(:dream)
      expect(response_data[:sleep_entries].first[:dream]).to be(true).or be(false)

      expect(response_data[:sleep_entries].first).to have_key(:notes)
      expect(response_data[:sleep_entries].first[:notes]).to be_a(String)

      expect(response_data[:sleep_entries].first).to have_key(:date)
      expect(response_data[:sleep_entries].first[:date]).to be_a(String)

      expect(response_data[:sleep_entries].first).to have_key(:patient_id)
      expect(response_data[:sleep_entries].first[:patient_id]).to be_an(Integer)

      expect(response_data[:sleep_entries].first).to have_key(:created_at)
      expect(response_data[:sleep_entries].first[:created_at]).to be_a(String)

      expect(response_data[:sleep_entries].first).to have_key(:updated_at)
      expect(response_data[:sleep_entries].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/sleep_entries", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/0/sleep_entries"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "sleep_entries#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:sleep_entry)
      expect(response_data[:sleep_entry]).to be_a(Hash)

      expect(response_data[:sleep_entry]).to have_key(:bed_time)
      expect(response_data[:sleep_entry][:bed_time]).to be_a(String)

      expect(response_data[:sleep_entry]).to have_key(:quality_rating)
      expect(response_data[:sleep_entry][:quality_rating].to_i).to be_an(Integer)

      expect(response_data[:sleep_entry]).to have_key(:total_hours)
      expect(response_data[:sleep_entry][:total_hours]).to be_an(Integer)

      expect(response_data[:sleep_entry]).to have_key(:dream)
      expect(response_data[:sleep_entry][:dream]).to be(true).or be(false)

      expect(response_data[:sleep_entry]).to have_key(:notes)
      expect(response_data[:sleep_entry][:notes]).to be_a(String)

      expect(response_data[:sleep_entry]).to have_key(:date)
      expect(response_data[:sleep_entry][:date]).to be_a(String)
      
      expect(response_data[:sleep_entry]).to have_key(:patient_id)
      expect(response_data[:sleep_entry][:patient_id]).to be_an(Integer)

      expect(response_data[:sleep_entry]).to have_key(:created_at)
      expect(response_data[:sleep_entry][:created_at]).to be_a(String)
      
      expect(response_data[:sleep_entry]).to have_key(:updated_at)
      expect(response_data[:sleep_entry][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/sleep_entries/#{@sleep_entry.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if sleep_entry not found" do
      get "/api/v1/patients/#{@patient.id}/sleep_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "sleep_entries#create", :vcr do
    it "returns http success" do
      initial_count = SleepEntry.count
      post "/api/v1/patients/#{@patient.id}/sleep_entries", 
          headers: {'Authorization': @valid_token}, 
          params: { sleep_entry: { bed_time: "2021-08-01 22:00:00", quality_rating: :poor, total_hours: 8, dream: true, notes: "I had a dream", date: "2021-08-01", patient_id: @patient.id } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Sleep entry created successfully")
      expect(SleepEntry.count).to eq(initial_count + 1)
    end

    it "sad path: returns error if missing required fields" do
      initial_count = SleepEntry.count

      post "/api/v1/patients/#{@patient.id}/sleep_entries",
          headers: {'Authorization': @valid_token},
          params: { sleep_entry: { quality_rating: :poor, total_hours: 8, dream: true, notes: "I had a dream" } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors]).to eq(["Bed time can't be blank", "Date can't be blank"])
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/sleep_entries",
          headers: {'Authorization': @valid_token},
          params: { sleep_entry: { bed_time: "2021-08-01 22:00:00", quality_rating: :poor, total_hours: 8, dream: true, notes: "I had a dream", date: "2021-08-01", patient_id: @patient.id } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/#{@patient.id}/sleep_entries",
          params: { sleep_entry: { bed_time: "2021-08-01 22:00:00", quality_rating: :poor, total_hours: 8, dream: true, notes: "I had a dream", date: "2021-08-01", patient_id: @patient.id } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "sleep_entries#update", :vcr do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}",
          headers: {'Authorization': @valid_token},
          params: { sleep_entry: { quality_rating: :good } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response_data).to have_key(:message)

      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Sleep entry updated successfully")
      expect(@sleep_entry.reload.quality_rating).to eq("good")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/sleep_entries/#{@sleep_entry.id}",
          headers: {'Authorization': @valid_token},
          params: { sleep_entry: { quality_rating: :good } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if sleep_entry not found" do
      patch "/api/v1/patients/#{@patient.id}/sleep_entries/0",
          headers: {'Authorization': @valid_token},
          params: { quality_rating: :good }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}",
          params: { sleep_entry: { quality_rating: :good } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "sleep_entries#destroy", :vcr do
    it "returns http success" do
      initial_count = SleepEntry.count
      delete "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}",
          headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Sleep entry deleted successfully")
      expect(SleepEntry.count).to eq(initial_count - 1)
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/sleep_entries/#{@sleep_entry.id}",
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if sleep_entry not found" do
      delete "/api/v1/patients/#{@patient.id}/sleep_entries/0",
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/#{@patient.id}/sleep_entries/#{@sleep_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end