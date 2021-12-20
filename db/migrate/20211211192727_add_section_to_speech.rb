# frozen_string_literal: true

class AddSectionToSpeech < ActiveRecord::Migration[6.1]
  def change
    add_reference :speeches, :section, null: false, foreign_key: true
  end
end
