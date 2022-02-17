# frozen_string_literal: true

class Conference < ApplicationRecord
  has_many :tracks, dependent: :nullify
  # has_many :sections, through: :tracks
end
