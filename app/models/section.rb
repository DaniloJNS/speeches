class Section < ApplicationRecord
  belongs_to :track
  has_many :speeches

  enum type_section: { morning: 0, evening: 1 }
end
