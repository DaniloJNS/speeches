# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
FactoryBot.create_list(:speech, 3)

FactoryBot.create(:user, user_name: "jota", password: "123123")
