require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let!(:pet) {create(:pet)}
  let(:pet_id) {pet.id}
  let!(:registration) {create(:registration, pet_id: pet.id, user_id: user.id)}
  let(:registration_id) {registration.id}
  let!(:appointment) { create(:appointment, registration_id: registration.id)}
  let(:id) {appointment.id}
  let(:headers) { valid_headers }

  describe 'POST /pets/:pet_id/registrations/:id/appointments' do
    let!(:user) { create(:user, role: 'owner')}
    let(:valid_attributes) {{appointment_date: 2013-02-01}.to_json}
    before {post "/pets/#{pet_id}/registrations/#{registration_id}/appointments", params: valid_attributes, headers: headers}

    context 'when request is valid' do
      it 'returns http status 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
