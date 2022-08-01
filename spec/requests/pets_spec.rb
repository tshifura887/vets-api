require 'rails_helper'

RSpec.describe "Pets API", type: :request do
  let!(:pet) { create(:pet, user_id: user.id)}
  let(:pet_id) { pet.id}
  let(:headers) { valid_headers }

  describe 'GET /pets' do
    let!(:registration) { create(:registration, pet_id: pet.id, user_id: user.id)}
    context 'when role is owner' do
      let!(:user) { create(:user, role: 'owner')}
      before { get '/pets', params: {}, headers: headers}

      it 'returns all pets' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when role is vet' do
      let!(:user) { create(:user, role: 'vet')}
      before { get '/pets', params: {}, headers: headers}

      it 'returns all pets' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /pets' do
    let!(:user) { create(:user, role: 'owner')}
    let(:valid_attributes) { { name: 'Leo', pet_type: 'Dog', pet_breed: 'bull'}.to_json }

    context 'when the request is valid' do
      before { post '/pets', params: valid_attributes, headers: headers }

      it 'creates a pet' do
        expect(json['name']).to eq('Leo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }
      before { post '/pets', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank, Pet type can't be blank, Pet breed can't be blank/)
      end
    end
  end

  describe 'GET /pets/:pet_id' do
    context 'when role is owner' do
      let!(:user) { create(:user, role: 'owner')}
      before { get "/pets/#{pet_id}", params: {}, headers: headers}

      context 'when the record exists' do
        it 'returns the pet' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(pet_id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:pet_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Pet with 'id'=100/)
        end
      end
    end

    context 'when role is vet' do
      let!(:user) { create(:user, role: 'vet')}
      before { get "/pets/#{pet_id}", params: {}, headers: headers}

      context 'when the record exists' do
        it 'returns the pet' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(pet_id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:pet_id) { 100 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find Pet with 'id'=100/)
        end
      end
    end
  end
end