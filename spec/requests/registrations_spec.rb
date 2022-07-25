require 'rails_helper'

RSpec.describe "Registration", type: :request do
    let(:owner) { create(:user, role: 'owner')}
    let(:vet) { create(:user, role: 'vet')}

    let!(:pet) { create(:pet)}
    let!(:registrations) { create_list(:registration, 20, pet_id: pet.id, user_id: owner.id) }

    let(:pet_id) { pet.id}
    let(:id) { registrations.first.id }

    let(:headers) { valid_headers }
    let(:headers) {{ 'Authorization' => token_generator(owner.id)}}

    describe 'post /pets/:pet_id/registrations' do
        let(:valid_attributes) { attributes_for(:pet, vet_name: vet.name, vet_email: vet.email)}

        context 'when request is valid' do
            before { post "/pets/#{pet_id}/registrations", params: valid_attributes, headers: headers}

            it 'creates a new registration' do
                expect(response).to have_http_status(201)
            end

            it 'returns a user' do
                expect(json['id']).to eq(owner.id)
            end
        end

        context 'when request is invalid' do
            before { post "/pets/#{pet_id}/registrations", params: {}, headers: headers}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns validation error' do
                expect(response.body).to match(/Validation failed: Vet can't be blank/)
            end
        end
    end
end