require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let!(:pet) {create(:pet)}
  let(:pet_id) {pet.id}
  let!(:user) { create(:user, role: 'owner')}
  let!(:vet) { create(:user, role: 'vet')}
  let!(:registration) {create(:registration, pet_id: pet.id, user_id: vet.id)}
  let(:registration_id) {registration.id}
  let!(:appointment) { create(:appointment, registration_id: registration.id)}
  let(:id) {appointment.id}

  describe 'POST /pets/:pet_id/registrations/:id/appointments' do
    let(:headers) { valid_headers }
    let(:valid_attributes) {{appointment_date: ''}.to_json}
    before {post "/pets/#{pet_id}/registrations/#{registration_id}/appointments", params: valid_attributes, headers: headers}

    context 'when request is valid' do
      it 'creates an appointment' do
        expect(json['id']).to eq(id)
      end

      it 'returns http status 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
