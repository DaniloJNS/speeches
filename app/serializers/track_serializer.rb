class TrackSerializer < ActiveModel::Serializer
  attributes :title
  has_many :sections

  def sections
    instance_seriazable = GeneralSerializer.new(object)
    reflection = TrackSerializer._reflections.detect { |r| r.first == :sections }
    association = reflection.second.build_association instance_seriazable, include_data_settings: true
    association.serializable_hash({ keys: true }, :json)
  end
end
