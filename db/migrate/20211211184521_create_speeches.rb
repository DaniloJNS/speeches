class CreateSpeeches < ActiveRecord::Migration[6.1]
  def change
    create_table :speeches do |t|
      t.integer :time, null: false
      t.string :title, null: false
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
