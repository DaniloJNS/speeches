class SectionSerializer < ApplicationSerializer
  attributes :type_section
  has_many :speeches
end
