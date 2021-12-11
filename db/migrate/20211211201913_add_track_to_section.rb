class AddTrackToSection < ActiveRecord::Migration[6.1]
  def change
    add_reference :sections, :track, null: false, foreign_key: true
  end
end
