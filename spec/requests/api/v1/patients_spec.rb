require 'rails_helper'

RSpec.describe "Api::V1::Patients", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
  end

  describe "show", :vcr do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}", headers: {'Authorization': @valid_token}
      
      expect(response).to have_http_status(:success)
      
      data = JSON.parse(response.body)
      expect(data).to be_a(Hash)

      expect(data).to have_key("id")
      expect(data["id"]).to eq(@patient.id)

      expect(data).to have_key("name")
      expect(data["name"]).to eq(@patient.name)

      expect(data).to have_key("email")
      expect(data["email"]).to eq(@patient.email)
      
      expect(data).to have_key("dob")
      expect(data["dob"]).to be_a(String)

      expect(data).to have_key("phone")
      expect(data["phone"]).to eq(@patient.phone)

      expect(data).to have_key("address")
      expect(data["address"]).to eq(@patient.address)

      expect(data).to have_key("emergency_contact_name")
      expect(data["emergency_contact_name"]).to eq(@patient.emergency_contact_name)

      expect(data).to have_key("emergency_contact_number")
      expect(data["emergency_contact_number"]).to eq(@patient.emergency_contact_number)
      
      expect(data).to have_key("therapist_id")
      expect(data["therapist_id"]).to eq(@patient.therapist_id)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0", headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      get "/api/v1/patients/#{@patient.id}"

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "update", :vcr do
    it "updates a patient" do
      patch "/api/v1/patients/#{@patient.id}", 
        headers: {'Authorization': @valid_token},
        params: { patient: { name: "New Name" } }   
  
      expect(response).to have_http_status(:success)
      
      data = JSON.parse(response.body)
      expect(data).to be_a(Hash)

      expect(data).to have_key("id")
      expect(data["id"]).to eq(@patient.id)

      expect(data).to have_key("name")
      expect(data["name"]).to eq("New Name")
      expect(data["name"]).not_to eq(@patient.name)
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0", 
        headers: {'Authorization': @valid_token},
        params: { patient: { name: "New Name" } }   

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: patient not updated if invalid params" do
      patch "/api/v1/patients/#{@patient.id}", 
        headers: {'Authorization': @valid_token},
        params: { patient: { name: "" } }   

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "create", :vcr do
    it "creates a patient" do
      post "/api/v1/patients", 
        headers: {'Authorization': @valid_token},
        params: { patient: { name: "New Name", email: "new@email.com", dob: "1999-01-01", phone: "000-000-0000", address: "123 No St", "emergency_contact_name": "New Name", "emergency_contact_number": "000-000-000", "therapist_id": @therapist.id } }

      expect(response).to have_http_status(:created)
     
      data = JSON.parse(response.body)
      expect(data).to be_a(Hash)
      
      expect(data).to have_key("id")
      expect(data["id"]).to be_a(Integer)
      
      expect(data).to have_key("name")
      expect(data["name"]).to eq("New Name")
      
      expect(data).to have_key("email")
      expect(data["email"]).to eq("new@email.com")

      expect(data).to have_key("dob")
      expect(data["dob"]).to eq("1999-01-01")

      expect(data).to have_key("phone")
      expect(data["phone"]).to eq("000-000-0000")

      expect(data).to have_key("address")
      expect(data["address"]).to eq("123 No St")

      expect(data).to have_key("emergency_contact_name")
      expect(data["emergency_contact_name"]).to eq("New Name")

      expect(data).to have_key("emergency_contact_number")
      expect(data["emergency_contact_number"]).to eq("000-000-000")

      expect(data).to have_key("therapist_id")
      expect(data["therapist_id"]).to eq(@therapist.id)
    end

    it "sad path: patient not created if invalid params" do
      post "/api/v1/patients", 
        headers: {'Authorization': @valid_token},
        params: { patient: { name: "", email: "new@email.com", dob: "1999-01-01", phone: "000-000-0000", address: "123 No St", "emergency_contact_name": "New Name", "emergency_contact_number": "000-000-000", "therapist_id": @therapist.id } }

        expect(response).to have_http_status(:unprocessable_entity)

        data = JSON.parse(response.body)
        expect(data).to be_a(Hash)

        expect(data).to have_key("errors")
        expect(data["errors"]).to eq(["Name can't be blank"])
    end
  end

  describe "destroy", :vcr do
    it "deletes a patient" do
      delete "/api/v1/patients/#{@patient.id}", 
        headers: {'Authorization': @valid_token}

      expect(response).to have_http_status(:success)

      data = JSON.parse(response.body)
      expect(data).to be_a(Hash)

      expect(data).to have_key("message")
      expect(data["message"]).to eq("Patient deleted successfully")
    end
  end
end
