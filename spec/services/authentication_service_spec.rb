require 'rails_helper'

describe AuthenticationService do
  context '#call' do
    let(:user) { create(:user) }
    let(:chave) { "attempts:#{user.id}:usuario" }

    it 'incress a attemps' do
      described_class.call user.id

      expect($redis.get(chave)).to eq('1')
    end
    it 'lock a user when attemps greater than limit' do
      described_class::ATTEMPS_LIMIT.times do
        described_class.call user.id
      end

      expect($redis.get(chave)).to eq('locked')
    end
  end
  # context '#restart' do
  #   it '' do
  #   end
  # end
end
