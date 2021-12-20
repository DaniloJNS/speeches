# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.integer :type_section, default: 0

      t.timestamps
    end
  end
end
