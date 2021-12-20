# frozen_string_literal: true

class CreateConferences < ActiveRecord::Migration[6.1]
  def change
    create_table :conferences, &:timestamps
  end
end
