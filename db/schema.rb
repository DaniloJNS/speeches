# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_211_211_204_032) do
  create_table 'conferences', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'sections', force: :cascade do |t|
    t.integer 'type_section', default: 0
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'track_id', null: false
    t.index ['track_id'], name: 'index_sections_on_track_id'
  end

  create_table 'speeches', force: :cascade do |t|
    t.integer 'time', null: false
    t.string 'title', null: false
    t.integer 'duration', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'section_id', null: false
    t.index ['section_id'], name: 'index_speeches_on_section_id'
  end

  create_table 'tracks', force: :cascade do |t|
    t.string 'title', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'conference_id', null: false
    t.index ['conference_id'], name: 'index_tracks_on_conference_id'
  end

  add_foreign_key 'sections', 'tracks'
  add_foreign_key 'speeches', 'sections'
  add_foreign_key 'tracks', 'conferences'
end
