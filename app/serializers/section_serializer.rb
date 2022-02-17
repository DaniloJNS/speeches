class SectionSerializer < ActiveModel::Serializer
  attributes :type_section
  has_many :speeches
end
