require 'rails_helper'

RSpec.describe "Pets", type: :request do
  let!(:pets) { create_list(:pet, 10)}
  let(:pet_id) { pets.first.id}

  describe 'GET /pets' do
    before { get '/pets'}

    it 'returns all pets' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pets/:id' do
    before {get "/pets/#{pet_id}"}

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

  describe 'POST /pets' do
    let(:valid_attributes) { { name: 'Angel', pet_type: 'Dog', pet_breed: 'Bulldog', age: '1'}}

    context 'when the request is valid' do
      before { post '/pets', params: valid_attributes }

      it 'creates a pet' do
        expect(json['name']).to eq('Angel')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/pets', params: { name: 'Lucy' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Pet type can't be blank, Pet breed can't be blank/)
      end
    end
  end
end

