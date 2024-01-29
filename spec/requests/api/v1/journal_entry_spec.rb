require 'rails_helper'

RSpec.describe "Api::V1::JournalEntries", type: :request do
  include_context "with valid token"

  before do
    @therapist = create(:therapist)
    @patient = create(:patient, therapist: @therapist)
    @journal_entry = create(:journal_entry, patient: @patient)
  end

  describe "journal_entries#index" do
    it "returns http success" do
      get "/api/v1/patients/#{@patient.id}/journal_entries", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:journal_entries)
      expect(response_data[:journal_entries]).to be_an(Array)

      expect(response_data[:journal_entries].first).to have_key(:id)
      expect(response_data[:journal_entries].first[:id]).to be_an(Integer)

      expect(response_data[:journal_entries].first).to have_key(:title)
      expect(response_data[:journal_entries].first[:title]).to be_a(String)

      expect(response_data[:journal_entries].first).to have_key(:content)
      expect(response_data[:journal_entries].first[:content]).to be_a(String)

      expect(response_data[:journal_entries].first).to have_key(:date)
      expect(response_data[:journal_entries].first[:date]).to be_a(String)

      expect(response_data[:journal_entries].first).to have_key(:patient_id)
      expect(response_data[:journal_entries].first[:patient_id]).to be_an(Integer)

      expect(response_data[:journal_entries].first).to have_key(:created_at)
      expect(response_data[:journal_entries].first[:created_at]).to be_a(String)

      expect(response_data[:journal_entries].first).to have_key(:updated_at)
      expect(response_data[:journal_entries].first[:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do
      get "/api/v1/patients/0/journal_entries", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/1/journal_entries"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "journal_entries#show" do 
    it "returns http success" do  
      get "/api/v1/patients/#{@patient.id}/journal_entries/#{@journal_entry.id}", headers: {'Authorization': @valid_token}
      response_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(response_data).to be_a(Hash)

      expect(response_data).to have_key(:journal_entry)
      expect(response_data[:journal_entry]).to be_a(Hash)

      expect(response_data[:journal_entry]).to have_key(:id)
      expect(response_data[:journal_entry][:id]).to be_an(Integer)

      expect(response_data[:journal_entry]).to have_key(:title)
      expect(response_data[:journal_entry][:title]).to be_a(String)

      expect(response_data[:journal_entry]).to have_key(:content)
      expect(response_data[:journal_entry][:content]).to be_a(String)

      expect(response_data[:journal_entry]).to have_key(:date)
      expect(response_data[:journal_entry][:date]).to be_a(String)

      expect(response_data[:journal_entry]).to have_key(:patient_id)
      expect(response_data[:journal_entry][:patient_id]).to be_an(Integer)

      expect(response_data[:journal_entry]).to have_key(:created_at)
      expect(response_data[:journal_entry][:created_at]).to be_a(String)

      expect(response_data[:journal_entry]).to have_key(:updated_at)
      expect(response_data[:journal_entry][:updated_at]).to be_a(String)
    end

    it "sad path: returns error if patient not found" do  
      get "/api/v1/patients/0/journal_entries/1", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if journal entry not found" do  
      get "/api/v1/patients/1/journal_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      get "/api/v1/patients/1/journal_entries/1"
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "journal_entries#create" do
    it "returns http success" do
      post "/api/v1/patients/#{@patient.id}/journal_entries", 
            headers: {'Authorization': @valid_token}, 
            params: { journal_entry: { title: "New Title", content: "New Content", date: "2021-01-01", patient_id: @patient.id } }
    
      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:created)

      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Journal entry created successfully")
    end

    it "sad path: returns error if patient not found" do
      post "/api/v1/patients/0/journal_entries",
          headers: {'Authorization': @valid_token},
          params: { journal_entry: { title: "New Title", content: "New Content", date: "2021-01-01", patient_id: 0 } }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do 
      post "/api/v1/patients/1/journal_entries",
          params: { journal_entry: { title: "New Title", content: "New Content", date: "2021-01-01", patient_id: 1 } }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "journal_entries#update" do
    it "returns http success" do
      initial_title = @journal_entry.title
      initial_content = @journal_entry.content

      patch "/api/v1/patients/#{@patient.id}/journal_entries/#{@journal_entry.id}",
            headers: {'Authorization': @valid_token},
            params: { journal_entry: { title: "Updated Title", content: "Updated Content"} }

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Journal entry updated successfully")

      expect(@journal_entry.reload.title).not_to eq(initial_title)
      expect(@journal_entry.reload.content).not_to eq(initial_content)
      expect(@journal_entry.reload.title).to eq("Updated Title")
      expect(@journal_entry.reload.content).to eq("Updated Content")
    end

    it "sad path: returns error if patient not found" do
      patch "/api/v1/patients/0/journal_entries/1",
            headers: {'Authorization': @valid_token},
            params: { journal_entry: { title: "Updated Title", content: "Updated Content"} }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if journal entry not found" do
      patch "/api/v1/patients/1/journal_entries/0",
            headers: {'Authorization': @valid_token},
            params: { journal_entry: { title: "Updated Title", content: "Updated Content"} }

      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      patch "/api/v1/patients/1/journal_entries/1",
            params: { journal_entry: { title: "Updated Title", content: "Updated Content"} }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "journal_entries#destroy" do
    it "returns http success" do
      initial_count = JournalEntry.count
      delete "/api/v1/patients/#{@patient.id}/journal_entries/#{@journal_entry.id}", headers: {'Authorization': @valid_token}

      response_data = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:success)
      expect(JournalEntry.count).to eq(initial_count - 1)
      
      expect(response_data).to have_key(:message)
      expect(response_data[:message]).to be_a(String)
      expect(response_data[:message]).to eq("Journal entry deleted successfully")
    end

    it "sad path: returns error if patient not found" do
      delete "/api/v1/patients/0/journal_entries/1", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if journal entry not found" do
      delete "/api/v1/patients/1/journal_entries/0", headers: {'Authorization': @valid_token}
      expect(response).to have_http_status(:not_found)
    end

    it "sad path: returns error if no token" do
      delete "/api/v1/patients/1/journal_entries/1"
      expect(response).to have_http_status(:unauthorized)
    end
  end
end