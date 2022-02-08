require 'rails_helper'

describe AuthenticationTokenService do
  describe '.call' do
    let(:token) { AuthenticationTokenService.call(1) }

    it 'return an authentication token' do
      decoded_token = JWT.decode token,
                                 described_class::HMAC_SECRET,
                                 true,
                                 { algoritm: described_class::ALGORITM_TYPE }

      decoded_token.map!(&:symbolize_keys)

      expect(decoded_token).to eq([{ user_id: 1 }, { alg: 'HS256' }])
    end

    it 'decode an authentication token' do
      expect(AuthenticationTokenService.decode(token)).to eq({ user_id: 1 })
    end
  end
end
