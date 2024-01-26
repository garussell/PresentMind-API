require 'rails_helper'

RSpec.describe "Api::V1::Appointments", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @appointment = create(:appointment, patient: @patient)
  end

  describe "appointments#index" do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/appointments", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:appointments)
      expect(response_data[:appointments]).to be_an(Array)  

      expect(response_data[:appointments].first).to have_key(:id)
      expect(response_data[:appointments].first[:id]).to be_an(Integer)

      expect(response_data[:appointments].first).to have_key(:title)
      expect(response_data[:appointments].first[:title]).to be_a(String)

      expect(response_data[:appointments].first).to have_key(:description)
      expect(response_data[:appointments].first[:description]).to be_a(String)

      expect(response_data[:appointments].first).to have_key(:start_time)
      expect(response_data[:appointments].first[:start_time]).to be_a(String)

      expect(response_data[:appointments].first).to have_key(:end_time)
      expect(response_data[:appointments].first[:end_time]).to be_a(String)

      expect(response_data[:appointments].first).to have_key(:patient_id)
      expect(response_data[:appointments].first[:patient_id]).to be_an(Integer)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/appointments", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/1/appointments"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "appointments#show" do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/appointments/#{@appointment.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:id)
      expect(response_data[:id]).to be_an(Integer)

      expect(response_data).to have_key(:title)
      expect(response_data[:title]).to be_a(String)

      expect(response_data).to have_key(:description)
      expect(response_data[:description]).to be_a(String)

      expect(response_data).to have_key(:start_time)
      expect(response_data[:start_time]).to be_a(String)

      expect(response_data).to have_key(:end_time)
      expect(response_data[:end_time]).to be_a(String)

      expect(response_data).to have_key(:patient_id)
      expect(response_data[:patient_id]).to be_an(Integer)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/appointments/#{@appointment.id}", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if appointment not found" do 
      get "/api/v1/patients/#{@patient.id}/appointments/0", headers: {'Authorization': @valid_token}
    
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/1/appointments/1"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end