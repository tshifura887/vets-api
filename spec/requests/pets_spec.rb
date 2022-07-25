require 'rails_helper'

RSpec.describe "Pets", type: :request do
  let(:user) { create(:user, role: 'owner')}
  let!(:pets) { create_list(:pet, 10)}
  let(:pet_id) { pets.first.id}
  let(:headers) { valid_headers }

  describe 'GET /pets' do
    before { get '/pets', params: {}, headers: headers}

    it 'returns all pets' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pets/:id' do
    before {get "/pets/#{pet_id}", params: {}, headers: headers}

    context 'when record exits' do
        
      it 'returns a pet' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(pet_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when record does not exist' do
      let(:pet_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pet/)
      end
    end
  end
end

