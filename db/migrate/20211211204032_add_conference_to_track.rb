# frozen_string_literal: true

class AddConferenceToTrack < ActiveRecord::Migration[6.1]
  def change
    add_reference :tracks, :conference, null: false, foreign_key: true
  end
end
