# frozen_string_literal: true

require 'rails_helper'

describe Conference do
  context 'has_many' do
    it 'tracks' do
      should have_many(:tracks)
    end
  end
end
