class Track < ApplicationRecord
  belongs_to :conference
  has_many :sections, validate: { lenght: 2 }
end
