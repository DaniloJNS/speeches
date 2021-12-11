# frozen_string_literal: true
#
require 'rails_helper'

describe Speech do
  context 'belong_to' do
    it 'section must be exists' do
      should belong_to(:section)
    end
  end
end
