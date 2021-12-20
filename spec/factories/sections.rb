# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    type_section { 'evening' }
    track

    trait :morning do
      type_section { 'morning' }
    end
  end
end
