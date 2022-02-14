require 'rails_helper'
# TODO: Verificar skip_before_action
describe 'authentication' do
  describe 'POST /authenticate' do
    let(:user) { create(:user, user_name: 'fake_user', password: '123123') }

    it 'authenticate the client' do
      post '/api/v1/authenticate', params: { user_name: user.user_name,
                                             password: user.password }

      expect(response).to have_http_status(:created)
      expect(parsed_body.key?(:token)).to eq(true)
    end

    it 'return error when user is missing' do
      post '/api/v1/authenticate', params: { password: '123123' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_body.key?(:error)).to eq true
    end

    it 'return error when password is missing' do
      post '/api/v1/authenticate', params: { user_name: 'AppConsumer' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(parsed_body.key?(:error)).to eq true
    end

    it 'return error when user not exists' do
      post '/api/v1/authenticate', params: { user_name: 'AppConsumer',
                                             password: '123123' }

      expect(response).to have_http_status(:unauthorized)
    end
    it 'return error when wrong password' do
      post '/api/v1/authenticate', params: { user_name: user.user_name,
                                             password: '123456' }

      expect(response).to have_http_status(:unauthorized)
    end
    it 'return locked when 5 attemps with wrong password' do
      5.times do
        post '/api/v1/authenticate', params: { user_name: user.user_name,
                                               password: '123456' }

        expect(response).to have_http_status(:unauthorized)
      end

      post '/api/v1/authenticate', params: { user_name: user.user_name,
                                             password: '123456' }

      expect(response).to have_http_status(:locked)
    end

    it 'return unauthorized when an request has not token' do
      get '/api/v1/speeches'

      expect(response).to have_http_status(:unauthorized)
    end

    it 'return unauthorized when an resquest has invalid token' do
      get '/api/v1/speeches', headers: { 'Authorization' => 'Token blabla' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'return unauthorized when an resuqest has token with invalid signature' do
      create(:user)
      token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxfQ.hlmmE_k9'\
              'jmczoHstsIlE2gDR_NwvZR-7IJiAEQBFblE' # decode { user_id: 1 }

      get '/api/v1/speeches', headers: { 'Authorization' => "Token #{token}" }

      expect(response).to have_http_status(:unauthorized)
    end
    # TODO: O restart do numero tentativas quando autorizado com sucesso
  end
end
