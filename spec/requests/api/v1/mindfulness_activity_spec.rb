require 'rails_helper'

RSpec.describe "Api::V1::MindfulnessActivities", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @mindfulness_activity = create(:mindfulness_activity, patient: @patient)
  end

  describe "mindfulness_activities#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/mindfulness_activities", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:mindfulness_activities)
      expect(response_data[:mindfulness_activities]).to be_an(Array)

      expect(response_data[:mindfulness_activities].first).to have_key(:id)
      expect(response_data[:mindfulness_activities].first[:id]).to be_an(Integer)

      expect(response_data[:mindfulness_activities].first).to have_key(:activity)
      expect(response_data[:mindfulness_activities].first[:activity]).to be_a(String)

      expect(response_data[:mindfulness_activities].first).to have_key(:total_minutes)
      expect(response_data[:mindfulness_activities].first[:total_minutes]).to be_an(Integer)

      expect(response_data[:mindfulness_activities].first).to have_key(:notes)
      expect(response_data[:mindfulness_activities].first[:notes]).to be_a(String)
      
      expect(response_data[:mindfulness_activities].first).to have_key(:date)
      expect(response_data[:mindfulness_activities].first[:date]).to be_a(String)

      expect(response_data[:mindfulness_activities].first).to have_key(:patient_id)
      expect(response_data[:mindfulness_activities].first[:patient_id]).to be_an(Integer)

      expect(response_data[:mindfulness_activities].first).to have_key(:created_at)
      expect(response_data[:mindfulness_activities].first[:created_at]).to be_a(String)

      expect(response_data[:mindfulness_activities].first).to have_key(:updated_at)
      expect(response_data[:mindfulness_activities].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/mindfulness_activities", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/mindfulness_activities"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "mindfulness_activities#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/mindfulness_activities/#{@mindfulness_activity.id}",
          headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:mindfulness_activity)
      expect(response_data[:mindfulness_activity]).to be_a(Hash)

      expect(response_data[:mindfulness_activity]).to have_key(:id)
      expect(response_data[:mindfulness_activity][:id]).to be_an(Integer)

      expect(response_data[:mindfulness_activity]).to have_key(:activity)
      expect(response_data[:mindfulness_activity][:activity]).to be_a(String)

      expect(response_data[:mindfulness_activity]).to have_key(:total_minutes)
      expect(response_data[:mindfulness_activity][:total_minutes]).to be_an(Integer)

      expect(response_data[:mindfulness_activity]).to have_key(:notes)
      expect(response_data[:mindfulness_activity][:notes]).to be_a(String)

      expect(response_data[:mindfulness_activity]).to have_key(:date)
      expect(response_data[:mindfulness_activity][:date]).to be_a(String)

      expect(response_data[:mindfulness_activity]).to have_key(:patient_id)
      expect(response_data[:mindfulness_activity][:patient_id]).to be_an(Integer)

      expect(response_data[:mindfulness_activity]).to have_key(:created_at)
      expect(response_data[:mindfulness_activity][:created_at]).to be_a(String)

      expect(response_data[:mindfulness_activity]).to have_key(:updated_at)
      expect(response_data[:mindfulness_activity][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/mindfulness_activities/#{@mindfulness_activity.id}", 
          headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if activity not found" do
      get "/api/v1/patients/#{@patient.id}/mindfulness_activities/0",
          headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/0/mindfulness_activities/0"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "mindfulness_activities#create", :vcr do
    it "returns http success" do
      initial_count = MindfulnessActivity.count
      post "/api/v1/patients/#{@patient.id}/mindfulness_activities",
          params: { mindfulness_activity: { activity: "meditation", total_minutes: 30, notes: "felt great", date: "2021-01-01" } },
          headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(MindfulnessActivity.count).to eq(initial_count + 1)
      expect(response).to have_http_status(:created)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Mindfulness activity created successfully")
    end

    it "sad path: returns error if missing required fields" do
      initial_count = MindfulnessActivity.count

      post "/api/v1/patients/#{@patient.id}/mindfulness_activities",
          params: { mindfulness_activity: { total_minutes: 30, notes: "felt great", date: "2021-01-01" } },
          headers: {'Authorization': @valid_token}
      
      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(MindfulnessActivity.count).to eq(initial_count)
      expect(response).to have_http_status(:bad_request)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors].first).to be_a(String)
      expect(response_data[:errors].first).to eq("Activity can't be blank")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/none/mindfulness_activities",
          params: { mindfulness_activity: { activity: "meditation", total_minutes: 30, notes: "felt great", date: "2021-01-01" } },
          headers: {'Authorization': @valid_token}
      
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/#{@patient.id}/mindfulness_activities",
          params: { mindfulness_activity: { activity: "meditation", total_minutes: 30, notes: "felt great", date: "2021-01-01" } }
      
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "mindfulness_activities#update", :vcr do
    it "returns http success" do
      initial_activity = @mindfulness_activity.activity
      initial_minutes = @mindfulness_activity.total_minutes

      patch "/api/v1/patients/#{@patient.id}/mindfulness_activities/#{@mindfulness_activity.id}",
          params: { mindfulness_activity: { activity: "Walking Meditation", total_minutes: 15} },
          headers: {'Authorization': @valid_token}
      
      expect(response).to have_http_status(:success)
      expect(@mindfulness_activity.reload.activity).to_not eq(initial_activity)
      expect(@mindfulness_activity.reload.total_minutes).to_not eq(initial_minutes)
      expect(@mindfulness_activity.reload.activity).to eq("Walking Meditation")
      expect(@mindfulness_activity.reload.total_minutes).to eq(15)
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/mindfulness_activities/#{@mindfulness_activity.id}",
          params: { mindfulness_activity: { activity: "Walking Meditation", total_minutes: 15} },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if activity not found" do 
      patch "/api/v1/patients/#{@patient.id}/mindfulness_activities/0",
          params: { mindfulness_activity: { activity: "Walking Meditation", total_minutes: 15} },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/0/mindfulness_activities/0",
          params: { mindfulness_activity: { activity: "Walking Meditation", total_minutes: 15} }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "mindfulness_activities#destroy", :vcr do
    it "returns http success" do
      initial_count = MindfulnessActivity.count
      delete "/api/v1/patients/#{@patient.id}/mindfulness_activities/#{@mindfulness_activity.id}",
          headers: {'Authorization': @valid_token} 
      response_data = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to have_http_status(:ok)
      expect(MindfulnessActivity.count).to eq(initial_count - 1)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Mindfulness activity deleted successfully")
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/mindfulness_activities/#{@mindfulness_activity.id}",
          headers: {'Authorization': @valid_token}
      
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if activity not found" do
      delete "/api/v1/patients/#{@patient.id}/mindfulness_activities/0",
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/#{@patient.id}/mindfulness_activities/#{@mindfulness_activity.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end