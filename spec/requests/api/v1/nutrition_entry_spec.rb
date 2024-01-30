require 'rails_helper'

RSpec.describe "Api::V1::NutritionEntries", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @nutrition_entry = create(:nutrition_entry, patient: @patient)
  end

  describe "nutrition_entries#index", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/nutrition_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:nutrition_entries)
      expect(response_data[:nutrition_entries]).to be_an(Array)

      expect(response_data[:nutrition_entries].first).to have_key(:id)
      expect(response_data[:nutrition_entries].first[:id]).to be_an(Integer)

      expect(response_data[:nutrition_entries].first).to have_key(:food_item)
      expect(response_data[:nutrition_entries].first[:food_item]).to be_a(String)

      expect(response_data[:nutrition_entries].first).to have_key(:calories)
      expect(response_data[:nutrition_entries].first[:calories]).to be_an(Integer) 

      expect(response_data[:nutrition_entries].first).to have_key(:number_of_servings)
      expect(response_data[:nutrition_entries].first[:number_of_servings]).to be_an(Integer)

      expect(response_data[:nutrition_entries].first).to have_key(:healthy)
      expect(response_data[:nutrition_entries].first[:healthy]).to be(true).or be(false)

      expect(response_data[:nutrition_entries].first).to have_key(:cups_of_water)
      expect(response_data[:nutrition_entries].first[:cups_of_water]).to be_an(Integer)

      expect(response_data[:nutrition_entries].first).to have_key(:fruits_and_veg_servings)
      expect(response_data[:nutrition_entries].first[:fruits_and_veg_servings]).to be_an(Integer)

      expect(response_data[:nutrition_entries].first).to have_key(:correct_portion)
      expect(response_data[:nutrition_entries].first[:correct_portion]).to be(true).or be(false)

      expect(response_data[:nutrition_entries].first).to have_key(:date)
      expect(response_data[:nutrition_entries].first[:date]).to be_a(String)

      expect(response_data[:nutrition_entries].first).to have_key(:patient_id)
      expect(response_data[:nutrition_entries].first[:patient_id]).to be_an(Integer)

      expect(response_data[:nutrition_entries].first).to have_key(:created_at)
      expect(response_data[:nutrition_entries].first[:created_at]).to be_a(String)

      expect(response_data[:nutrition_entries].first).to have_key(:updated_at)
      expect(response_data[:nutrition_entries].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/nutrition_entries", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/nutrition_entries"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "nutrition_entries#show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:nutrition_entry)
      expect(response_data[:nutrition_entry]).to be_a(Hash)

      expect(response_data[:nutrition_entry]).to have_key(:id)
      expect(response_data[:nutrition_entry][:id]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:food_item)
      expect(response_data[:nutrition_entry][:food_item]).to be_a(String)
      
      expect(response_data[:nutrition_entry]).to have_key(:calories)
      expect(response_data[:nutrition_entry][:calories]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:number_of_servings)
      expect(response_data[:nutrition_entry][:number_of_servings]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:healthy)
      expect(response_data[:nutrition_entry][:healthy]).to be(true).or be(false)

      expect(response_data[:nutrition_entry]).to have_key(:cups_of_water)
      expect(response_data[:nutrition_entry][:cups_of_water]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:fruits_and_veg_servings)
      expect(response_data[:nutrition_entry][:fruits_and_veg_servings]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:correct_portion)
      expect(response_data[:nutrition_entry][:correct_portion]).to be(true).or be(false)

      expect(response_data[:nutrition_entry]).to have_key(:date)
      expect(response_data[:nutrition_entry][:date]).to be_a(String)

      expect(response_data[:nutrition_entry]).to have_key(:patient_id)
      expect(response_data[:nutrition_entry][:patient_id]).to be_an(Integer)

      expect(response_data[:nutrition_entry]).to have_key(:created_at)
      expect(response_data[:nutrition_entry][:created_at]).to be_a(String)

      expect(response_data[:nutrition_entry]).to have_key(:updated_at)
      expect(response_data[:nutrition_entry][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/nutrition_entries/#{@nutrition_entry.id}", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if nutrition entry not found" do
      get "/api/v1/patients/#{@patient.id}/nutrition_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "nutrition_entries#create", :vcr do
    it "returns http success" do
      initial_count = NutritionEntry.count
      post "/api/v1/patients/#{@patient.id}/nutrition_entries",
          params: { nutrition_entry: { food_item: "apple", calories: 95, number_of_servings: 1, healthy: true, cups_of_water: 1, fruits_and_veg_servings: 1, correct_portion: true, date: "2021-09-01", patient_id: @patient.id } },
          headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)
      expect(response_data).to be_a(Hash)

      expect(NutritionEntry.count).to eq(initial_count + 1)
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Nutrition entry created successfully")
    end

    it "sad path: returns error if missing required fields" do
      initial_count = NutritionEntry.count

      post "/api/v1/patients/#{@patient.id}/nutrition_entries",
          params: { nutrition_entry: { calories: 95, number_of_servings: 1, healthy: true, cups_of_water: 1, fruits_and_veg_servings: 1, correct_portion: true, date: "2021-09-01", patient_id: @patient.id } },
          headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:bad_request)
      expect(NutritionEntry.count).to eq(initial_count)
      expect(response_data).to have_key(:errors)

      expect(response_data[:errors]).to be_an(Array)
      expect(response_data[:errors].first).to be_a(String)
      expect(response_data[:errors].first).to eq("Food item can't be blank")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/nutrition_entries",
          params: { nutrition_entry: { food_item: "apple", calories: 95, number_of_servings: 1, healthy: true, cups_of_water: 1, fruits_and_veg_servings: 1, correct_portion: true, date: "2021-09-01", patient_id: @patient.id } },
          headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      post "/api/v1/patients/0/nutrition_entries",
          params: { nutrition_entry: { food_item: "apple", calories: 95, number_of_servings: 1, healthy: true, cups_of_water: 1, fruits_and_veg_servings: 1, correct_portion: true, date: "2021-09-01", patient_id: @patient.id } }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "nutrition_entries#update", :vcr do
    it "returns http success" do
      patch "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}",
          params: { nutrition_entry: { food_item: "pizza"} },
          headers: {'Authorization': @valid_token}
      
      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Nutrition entry updated successfully")
      expect(@nutrition_entry.reload.food_item).to eq("pizza")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/nutrition_entries/#{@nutrition_entry.id}",
          params: { nutrition_entry: { food_item: "pizza"} },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if nutrition entry not found" do 
      patch "/api/v1/patients/#{@patient.id}/nutrition_entries/0",
          params: { nutrition_entry: { food_item: "pizza"} },
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      patch "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}",
          params: { nutrition_entry: { food_item: "pizza"} }
      
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "nutrition_entries#destroy", :vcr do
    it "returns http success" do
      initial_count = NutritionEntry.count
      delete "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}",
          headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:ok)
      expect(NutritionEntry.count).to eq(initial_count - 1)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Nutrition entry deleted successfully")
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/nutrition_entries/#{@nutrition_entry.id}",
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if nutrition entry not found" do
      delete "/api/v1/patients/#{@patient.id}/nutrition_entries/0",
          headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/#{@patient.id}/nutrition_entries/#{@nutrition_entry.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end