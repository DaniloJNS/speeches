class ConferenceSerializer < ActiveModel::Serializer
  has_many :tracks

  def tracks
    instance_seriazable = GeneralSerializer.new(object)
    reflection = ConferenceSerializer._reflections.detect { |r| r.first == :tracks }
    association = reflection.second.build_association instance_seriazable, include_data_settings: true
    association.serializable_hash({ keys: true }, :json)
  end
end
