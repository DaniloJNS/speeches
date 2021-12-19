FactoryBot.define do
  factory :track do
    sequence(:title) { |n| "Track #{convert_alphabet n}" }
    conference
  end
end

def convert_alphabet pos
  ('A'..'Z').each.with_index do |letter, i|
    return letter if i.eql? pos - 1
  end
end
