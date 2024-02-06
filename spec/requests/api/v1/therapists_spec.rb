require 'rails_helper'

RSpec.describe "Api::V1::Therapists", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient1 = create(:patient, therapist: @therapist)
    @patient2 = create(:patient, therapist: @therapist)

    appointments = create_list(:appointment, 20, patient: @patient1)
    exercise_entries = create_list(:exercise_entry, 20, patient: @patient1)
    journal_entries = create_list(:journal_entry, 20, patient: @patient1)
    medication_entries = create_list(:medication_entry, 20, patient: @patient1)
    mindfulness_activities = create_list(:mindfulness_activity, 20, patient: @patient1)
    nutrition_entries = create_list(:nutrition_entry, 20, patient: @patient1)
    sleep_entries = create_list(:sleep_entry, 20, patient: @patient1)
    social_interactions = create_list(:social_interaction, 20, patient: @patient1)

    appointments = create_list(:appointment, 20, patient: @patient2)
    exercise_entries = create_list(:exercise_entry, 20, patient: @patient2)
    journal_entries = create_list(:journal_entry, 20, patient: @patient2)
    medication_entries = create_list(:medication_entry, 20, patient: @patient2)
    mindfulness_activities = create_list(:mindfulness_activity, 20, patient: @patient2)
    nutrition_entries = create_list(:nutrition_entry, 20, patient: @patient2)
    sleep_entries = create_list(:sleep_entry, 20, patient: @patient2)
    social_interactions = create_list(:social_interaction, 20, patient: @patient2)

    @pattern1 = create(:pattern, patient: @patient1)
    @pattern2 = create(:pattern, patient: @patient2)
  end

  describe "therapists#index", :vcr do
    it "returns http success" do
      get "/api/v1/therapists", headers: {'Authorization': @valid_token}
      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(response_body).to be_a(Array)

      expect(response_body[0]).to have_key("id")
      expect(response_body[0]["id"]).to eq(@therapist.id)

      expect(response_body[0]).to have_key("name")
      expect(response_body[0]["name"]).to eq(@therapist.name)
      expect(response_body[0]["name"]).to be_a(String)

      expect(response_body[0]).to have_key("email")
      expect(response_body[0]["email"]).to eq(@therapist.email)
      expect(response_body[0]["email"]).to be_a(String)

      expect(response_body[0]).to have_key("office_number")
      expect(response_body[0]["office_number"]).to eq(@therapist.office_number)
      expect(response_body[0]["office_number"]).to be_a(String)

      expect(response_body[0]).to have_key("specialization")
      expect(response_body[0]["specialization"]).to eq(@therapist.specialization)
      expect(response_body[0]["specialization"]).to be_a(String)

      expect(response_body[0]).to have_key("years_in_practice")
      expect(response_body[0]["years_in_practice"]).to eq(@therapist.years_in_practice)
      expect(response_body[0]["years_in_practice"]).to be_a(Integer)

      expect(response_body[0]).to have_key("credentials")
      expect(response_body[0]["credentials"]).to eq(@therapist.credentials)
      expect(response_body[0]["credentials"]).to be_a(String)
      
      expect(response_body[0]).to have_key("bio")
      expect(response_body[0]["bio"]).to eq(@therapist.bio)
      expect(response_body[0]["bio"]).to be_a(String)

      expect(response_body[0]).to have_key("created_at")
      expect(response_body[0]["created_at"]).to be_a(String)
      
      expect(response_body[0]).to have_key("updated_at")
      expect(response_body[0]["updated_at"]).to be_a(String)
    end
  end

  describe "therapists#show", :vcr do
    it "returns http success" do
      get "/api/v1/therapists/#{@therapist.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:id)
      expect(response_data[:id]).to be_a(Integer)

      expect(response_data).to have_key(:name)
      expect(response_data[:name]).to be_a(String)

      expect(response_data).to have_key(:email)
      expect(response_data[:email]).to be_a(String)

      expect(response_data).to have_key(:office_number)
      expect(response_data[:office_number]).to be_a(String)

      expect(response_data).to have_key(:specialization)
      expect(response_data[:specialization]).to be_a(String)

      expect(response_data).to have_key(:years_in_practice)
      expect(response_data[:years_in_practice]).to be_a(Integer)

      expect(response_data).to have_key(:credentials)
      expect(response_data[:credentials]).to be_a(String)

      expect(response_data).to have_key(:bio)
      expect(response_data[:bio]).to be_a(String)

      expect(response_data).to have_key(:created_at)
      expect(response_data[:created_at]).to be_a(String)

      expect(response_data).to have_key(:updated_at)
      expect(response_data[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if therapist not found" do
      get "/api/v1/therapists/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/therapists/#{@therapist.id}"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "therapists#create", :vcr do
    it "creates a therapist" do
      initial_count = Therapist.count

      post "/api/v1/therapists",
        params: { therapist: { name: "Dr. John Doe", email: "fake@email.com", office_number: "123", specialization: "Counseling", years_in_practice: 10, credentials: "PhD", bio: "I am a therapist." } },
        headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)

      expect(response_data).to have_key(:id)
      expect(response_data[:id]).to be_a(Integer)

      expect(response_data).to have_key(:name)
      expect(response_data[:name]).to be_a(String)

      expect(response_data).to have_key(:email)
      expect(response_data[:email]).to be_a(String)

      expect(response_data).to have_key(:office_number)
      expect(response_data[:office_number]).to be_a(String)

      expect(response_data).to have_key(:specialization)
      expect(response_data[:specialization]).to be_a(String)

      expect(response_data).to have_key(:years_in_practice)
      expect(response_data[:years_in_practice]).to be_a(Integer)

      expect(response_data).to have_key(:credentials)
      expect(response_data[:credentials]).to be_a(String)
      
      expect(response_data).to have_key(:bio)
      expect(response_data[:bio]).to be_a(String)

      expect(response_data).to have_key(:created_at)
      expect(response_data[:created_at]).to be_a(String)

      expect(response_data).to have_key(:updated_at)
      expect(response_data[:updated_at]).to be_a(String)

      expect(Therapist.count).to eq(initial_count + 1)
    end

    it "sad path: therapist not created if invalid params" do
      initial_count = Therapist.count

      post "/api/v1/therapists",
        params: { therapist: { name: "", email: "", office_number: "", specialization: "", years_in_practice: "", credentials: "", bio: "" } },
        headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:unprocessable_entity)

      expect(response_data).to have_key(:errors)
      expect(response_data[:errors]).to be_a(Array)
      expect(response_data[:errors].length).to eq(7)

      expect(Therapist.count).to eq(initial_count)

      expect(response_data[:errors]).to include("Name can't be blank")
      expect(response_data[:errors]).to include("Email can't be blank")
      expect(response_data[:errors]).to include("Office number can't be blank")
      expect(response_data[:errors]).to include("Specialization can't be blank")
      expect(response_data[:errors]).to include("Years in practice can't be blank")
      expect(response_data[:errors]).to include("Credentials can't be blank")
      expect(response_data[:errors]).to include("Bio can't be blank")
    end

    it "sad path: returns error if no token" do
      post "/api/v1/therapists",
          params: { therapist: { name: "Dr. John Doe", email: "fake@email.com", office_number: "123", specialization: "Counseling", years_in_practice: 10, credentials: "PhD", bio: "I am a therapist." } }
      
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "therapists#update", :vcr do
    it "updates a therapist" do
      expect(@therapist.name).to_not eq("Dr. John Doe")

      patch "/api/v1/therapists/#{@therapist.id}",
          headers: {'Authorization': @valid_token},
          params: { therapist: { name: "Dr. Jane Doe" } }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)

      expect(response_data).to have_key(:name)
      expect(response_data[:name]).to eq("Dr. Jane Doe")
    end

    it "sad path: returns error if therapist not found" do
      patch "/api/v1/therapists/0",
          headers: {'Authorization': @valid_token},
          params: { therapist: { name: "Dr. Jane Doe" } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/therapists/#{@therapist.id}",
          params: { therapist: { name: "Dr. Jane Doe" } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "therapists#destroy", :vcr do
    it "deletes a therapist" do
      initial_count = Therapist.count

      delete "/api/v1/therapists/#{@therapist.id}",
          headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)

      expect(Therapist.count).to eq(initial_count - 1)
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to eq("Therapist deleted successfully")
    end

    it "sad path: returns error if therapist not found" do
      delete "/api/v1/therapists/0",
          headers: {'Authorization': @valid_token}  

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/therapists/0"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end