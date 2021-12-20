# frozen_string_literal: true

class UtilityService < ApplicationController
  def self.convert_alphabet(pos)
    ('A'..'Z').each.with_index do |letter, i|
      return letter if i.eql? pos
    end
  end
end
