require 'rails_helper'

RSpec.describe "Api::V1::MedicationEntries", type: :request do
  include_context "with valid token"   

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @medication_entry = create(:medication_entry, patient: @patient)
  end

  describe "medication_entries#index" do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/medication_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:medication_entries)
      expect(response_data[:medication_entries]).to be_an(Array)

      expect(response_data[:medication_entries].first).to have_key(:id)
      expect(response_data[:medication_entries].first[:id]).to be_an(Integer)

      expect(response_data[:medication_entries].first).to have_key(:name)
      expect(response_data[:medication_entries].first[:name]).to be_a(String)

      expect(response_data[:medication_entries].first).to have_key(:purpose)
      expect(response_data[:medication_entries].first[:purpose]).to be_a(String)

      expect(response_data[:medication_entries].first).to have_key(:dose)
      expect(response_data[:medication_entries].first[:dose]).to be_a(String)

      expect(response_data[:medication_entries].first).to have_key(:schedule)
      expect(response_data[:medication_entries].first[:schedule]).to be_a(String)

      expect(response_data[:medication_entries].first).to have_key(:patient_id)
      expect(response_data[:medication_entries].first[:patient_id]).to be_an(Integer)

      expect(response_data[:medication_entries].first).to have_key(:created_at)
      expect(response_data[:medication_entries].first[:created_at]).to be_a(String)

      expect(response_data[:medication_entries].first).to have_key(:updated_at)
      expect(response_data[:medication_entries].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/medication_entries", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/medication_entries"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "medication_entries#show" do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:medication_entry)
      expect(response_data[:medication_entry]).to be_a(Hash)

      expect(response_data[:medication_entry]).to have_key(:id)
      expect(response_data[:medication_entry][:id]).to be_an(Integer)

      expect(response_data[:medication_entry]).to have_key(:name)
      expect(response_data[:medication_entry][:name]).to be_a(String)

      expect(response_data[:medication_entry]).to have_key(:dose)
      expect(response_data[:medication_entry][:dose]).to be_a(String)

      expect(response_data[:medication_entry]).to have_key(:purpose)
      expect(response_data[:medication_entry][:purpose]).to be_a(String)

      expect(response_data[:medication_entry]).to have_key(:schedule)
      expect(response_data[:medication_entry][:schedule]).to be_a(String)

      expect(response_data[:medication_entry]).to have_key(:patient_id)
      expect(response_data[:medication_entry][:patient_id]).to be_an(Integer)

      expect(response_data[:medication_entry]).to have_key(:created_at)
      expect(response_data[:medication_entry][:created_at]).to be_a(String)

      expect(response_data[:medication_entry]).to have_key(:updated_at)
      expect(response_data[:medication_entry][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/medication_entries/#{@medication_entry.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if medication entry not found" do
      get "/api/v1/patients/#{@patient.id}/medication_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "medication_entries#create" do
    it "returns http success" do
      initial_count = MedicationEntry.count
      post "/api/v1/patients/#{@patient.id}/medication_entries",
            params: { medication_entry: { name: "medication", dose: "10mg", purpose: "to focus better", schedule: "daily" } },
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)
      expect(MedicationEntry.count).to eq(initial_count + 1)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Medication entry created successfully")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/medication_entries",
          params: { medication_entry: { name: "medication", dose: "10mg", purpose: "to focus better", schedule: "daily" } },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/#{@patient.id}/medication_entries",
          params: { medication_entry: { name: "medication", dose: "10mg", purpose: "to focus better", schedule: "daily" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "medication_entries#update" do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}",
            params: { medication_entry: { name: "medicationUpdate", dose: "100mg", purpose: "to focus better", schedule: "daily" } },
            headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Medication entry updated successfully")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/medication_entries/#{@medication_entry.id}",
          params: { medication_entry: { name: "medicationUpdate", dose: "100mg", purpose: "to focus better", schedule: "daily" } },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if medication entry not found" do
      patch "/api/v1/patients/#{@patient.id}/medication_entries/0",
          params: { medication_entry: { name: "medicationUpdate", dose: "100mg", purpose: "to focus better", schedule: "daily" } },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}",
          params: { medication_entry: { name: "medicationUpdate", dose: "100mg", purpose: "to focus better", schedule: "daily" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "medication_entries#destroy" do
    it "returns http success" do
      initial_count = MedicationEntry.count
      delete "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}", headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(MedicationEntry.count).to eq(initial_count - 1)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Medication entry deleted successfully")
    end

    it "sad path: returns error if patient not found" do  
      delete "/api/v1/patients/0/medication_entries/#{@medication_entry.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if medication entry not found" do 
      delete "/api/v1/patients/#{@patient.id}/medication_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      delete "/api/v1/patients/#{@patient.id}/medication_entries/#{@medication_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end