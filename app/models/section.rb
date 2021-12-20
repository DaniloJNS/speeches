# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :track
  has_many :speeches, dependent: :nullify

  enum type_section: { morning: 0, evening: 1 }

  after_create if: :evening? do
    Speech.create(title: 'Almoço', time: 720, section: self, duration: 0)
  end
end
