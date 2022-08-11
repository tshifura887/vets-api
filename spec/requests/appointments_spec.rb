require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let!(:pet) {create(:pet)}
  let(:pet_id) {pet.id}
  let!(:user) { create(:user, role: 'owner')}
  let!(:registration) {create(:registration, pet_id: pet.id, user_id: user.id)}
  let(:registration_id) {registration.id}
  let!(:appointment) { create(:appointment, registration_id: registration.id)}
  let(:id) {appointment.id}
  let(:headers) { valid_headers }

  describe "GET /appointments/:registration_id" do
    before { get "/appointments/#{registration_id}", params: {}, headers: headers}

    it 'returns all pets' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(200)
    end
  end

  describe 'POST /pets/:pet_id/registrations/:id/appointments' do
    let(:valid_attributes) {{appointment_date: 2013-02-01}.to_json}
    before {post "/pets/#{pet_id}/registrations/#{registration_id}/appointments", params: valid_attributes, headers: headers}

    context 'when request is valid' do
      it 'returns http status 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
