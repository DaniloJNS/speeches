# frozen_string_literal: true
#
require 'rails_helper'

describe Track do
  context 'belong_to' do
    it 'conference must be exists' do
      should belong_to(:conference)
    end
  end
  context 'has_many' do
    it 'sections' do
      should have_many(:sections)
    end
  end
end
