require 'rails_helper'

RSpec.describe "Users API", type: :request do

  describe 'POST /signup' do
    context 'when role is owner' do
      let(:user) { build(:user, role: 'owner') }
      let(:headers) { valid_headers.except('Authorization') }
      let(:valid_attributes) do
        attributes_for(:user, password_confirmation: user.password, role: user.role)
      end

      context 'when valid request' do
        before { post '/signup', params: valid_attributes.to_json, headers: headers }
  
        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end
  
        it 'returns success message' do
          expect(json['message']).to match(/Account created successfully/)
        end
  
        it 'returns an authentication token' do
          expect(json['auth_token']).not_to be_nil
        end
      end
  
      context 'when invalid request' do
        before { post '/signup', params: {}, headers: headers }
  
        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end
  
        it 'returns failure message' do
          expect(json['message'])
            .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
        end
      end
    end

    context 'when role is owner' do
      let(:user) { build(:user, role: 'vet') }
      let(:headers) { valid_headers.except('Authorization') }
      let(:valid_attributes) do
        attributes_for(:user, password_confirmation: user.password, role: user.role)
      end

      context 'when valid request' do
        before { post '/signup', params: valid_attributes.to_json, headers: headers }
  
        it 'creates a new user' do
          expect(response).to have_http_status(201)
        end
  
        it 'returns success message' do
          expect(json['message']).to match(/Account created successfully/)
        end
  
        it 'returns an authentication token' do
          expect(json['auth_token']).not_to be_nil
        end
      end
  
      context 'when invalid request' do
        before { post '/signup', params: {}, headers: headers }
  
        it 'does not create a new user' do
          expect(response).to have_http_status(422)
        end
  
        it 'returns failure message' do
          expect(json['message'])
            .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
        end
      end
    end
  end

  describe 'GET /user/user_id' do

    context 'when role is owner' do
      let(:user) { create(:user, role: 'owner')}
      let(:user_id) { user.id}
      let(:headers) { valid_headers}
      before {get "/users/#{user_id}", params: {}, headers: headers}

      context 'when the record exists' do
        it 'returns the user' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(user_id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:user_id) { 0 }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find User with 'id'=0/)
        end
      end
    end

    context 'when role is vet' do
      describe 'GET /users/:id' do
        let(:user) { create(:user, role: 'vet')}
        let(:user_id) { user.id}
        let(:headers) { valid_headers}
        before {get "/users/#{user_id}", params: {}, headers: headers}
    
        context 'when the record exists' do
          it 'returns the user' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(user_id)
          end
    
          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end
        end
    
        context 'when the record does not exist' do
          let(:user_id) { 0 }
    
          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
    
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find User with 'id'=0/)
          end
        end
      end
    end
  end

  describe 'DELETE /users/:id' do

    context 'when role is owner' do
      let(:user) { create(:user, role: 'owner')}
      let(:user_id) { user.id}
      let(:headers) { valid_headers}
      before {delete "/users/#{user_id}", params: {}, headers: headers}

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when role is vet' do
      let(:user) { create(:user, role: 'vet')}
      let(:user_id) { user.id}
      let(:headers) { valid_headers}
      before {delete "/users/#{user_id}", params: {}, headers: headers}

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
