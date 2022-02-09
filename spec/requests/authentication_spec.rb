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

    # TODO: O restart do numero tentativas quando autorizado com sucesso
  end
end
