require 'rails_helper'

RSpec.describe "Api::V1::Appointments", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @appointment = create(:appointment, patient: @patient)
  end

  describe "appointments#index", :vcr do
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

  describe "appointments#show", :vcr do
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

  describe "appointments#create", :vcr do
    it "returns http success" do
      initial_count = @patient.appointments.count

      post "/api/v1/patients/#{@patient.id}/appointments", params: { appointment: { title: "Test", description: "Test", start_time: "2021-09-01 12:00:00", end_time: "2021-09-01 13:00:00", patient_id: @patient.id, mood_before: "mb_very_negative", mood_after: "ma_slightly_negative", stress_before: "sb_very_stressed", stress_after: "sa_very_relaxed"  } }, headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Appointment created successfully")

      expect(@patient.appointments.count).to eq(initial_count + 1)
    end

    it "sad path: returns error if missing attribute" do
      initial_count = @patient.appointments.count

      post "/api/v1/patients/#{@patient.id}/appointments", params: { appointment: { description: "Test", start_time: "2021-09-01 12:00:00", end_time: "2021-09-01 13:00:00", patient_id: @patient.id, mood_before: "mb_very_negative", mood_after: "ma_slightly_negative", stress_before: "sb_very_stressed", stress_after: "sa_very_relaxed" } }, headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:bad_request)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors].first).to eq("Title can't be blank")

      expect(@patient.appointments.count).to eq(initial_count)
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/appointments", params: { appointment: { title: "Test", description: "Test", start_time: "2021-09-01 12:00:00", end_time: "2021-09-01 13:00:00", patient_id: @patient.id } }, headers: {'Authorization': @valid_token}
    
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/#{@patient.id}/appointments", params: { appointment: { title: "Test", description: "Test", start_time: "2021-09-01 12:00:00", end_time: "2021-09-01 13:00:00", patient_id: @patient.id } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "appointments#update", :vcr do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/appointments/#{@appointment.id}",
            params: { appointment: { title: "UpdatedTitle", mood_before: "mb_very_negative", mood_after: "ma_slightly_negative", stress_before: "sb_very_stressed", stress_after: "sa_very_relaxed" } },
            headers: { 'Authorization': @valid_token }
            
      expect(response).to have_http_status(:success)
      expect(@appointment.reload.title).to eq("UpdatedTitle")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/appointments/1",
            params: { appointment: { title: "UpdatedTitle" } },
            headers: { 'Authorization': @valid_token }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if appointment not found" do
      patch "/api/v1/patients/#{@patient.id}/appointments/0",
            params: { appointment: { title: "UpdatedTitle" } },
            headers: { 'Authorization': @valid_token }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      patch "/api/v1/patients/#{@patient.id}/appointments/#{@appointment.id}",
            params: { appointment: { title: "UpdatedTitle" } }
    
      expect(response).to have_http_status(:unauthorized)      
    end
  end

  describe "appointments#destroy", :vcr do
    it "returns http success" do
      delete "/api/v1/patients/#{@patient.id}/appointments/#{@appointment.id}",
            headers: { 'Authorization': @valid_token }

      expect(response).to have_http_status(:success)
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/appointments/1",
            headers: { 'Authorization': @valid_token }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if appointment not found" do
      delete "/api/v1/patients/#{@patient.id}/appointments/0",
            headers: { 'Authorization': @valid_token }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      delete "/api/v1/patients/#{@patient.id}/appointments/#{@appointment.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end