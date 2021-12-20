# frozen_string_literal: true

require 'rails_helper'

describe Section do
  context 'belong_to' do
    it 'track must be exists' do
      should belong_to(:track)
    end
  end
  context 'has_many' do
    it 'speeches' do
      should have_many(:speeches)
    end
  end
end
