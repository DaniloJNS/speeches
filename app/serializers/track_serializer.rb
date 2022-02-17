class TrackSerializer < ApplicationSerializer
  attributes :title
  has_many :sections

  def sections
    association_serializer :sections
  end
end
