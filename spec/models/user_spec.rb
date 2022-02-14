require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validates' do
    it 'user_name presence' do
      should validate_presence_of(:user_name)
    end
  end
end
