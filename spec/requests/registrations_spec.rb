require 'rails_helper'

RSpec.describe "Registrations", type: :request do
    let!(:pet) { create(:pet)}
    let(:pet_id) { pet.id}
    let(:headers) { valid_headers}

    describe 'post /pets/:pet_id/registrations' do
        let!(:user) { create(:user, role: 'owner')}
        let!(:vet) { create(:user, role: 'vet')}
        let!(:registration) { create(:registration, pet_id: pet.id, user_id: user.id)}
        let(:id) { registration.id}
     
        context 'when request is valid' do
            let(:valid_attributes) { attributes_for(:pet, vet_name: vet.name)}
            before { post "/pets/#{pet_id}/registrations", params: valid_attributes.to_json, headers: headers}

            it 'creates a new registration' do
                expect(response).to have_http_status(201)
            end

            it 'returns a user' do
                expect(json['id']).to eq(user.id)
            end
        end

        context 'when request is invalid' do
            before { post "/pets/#{pet_id}/registrations", params: {}, headers: headers}

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns validation error' do
                expect(response.body).to match(/unprocessable_entity/)
            end
        end
    end

    describe 'PUT /pets/:pet_id/registrations/:id' do
        let!(:user) { create(:user, role: 'vet')}
        let!(:registration) { create(:registration, pet_id: pet.id, user_id: user.id)}
        let(:id) { registration.id}

        before { put "/pets/#{pet_id}/registrations/#{id}", headers: headers}

        context 'when registration exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when registration does not exist' do
            let(:id) {0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Registration with 'id'=0/)
            end
        end
    end
end