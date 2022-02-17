class ApplicationSerializer < ActiveModel::Serializer
  class MissingSymbol < StandardError; end
  attr_accessor :reflection_name

  def association_serializer(reflection_name)
    return raise MissingSymbol unless reflection_name.is_a? Symbol

    @reflection_name = reflection_name
    serializer
  end

  def serializer
    association.serializable_hash({ keys: true }, :json)
  end

  def instance_seriazable
    @instance_seriazable ||= GeneralSerializer.new(object)
  end

  def reflection
    serializer_class._reflections.detect { |r| r.first == reflection_name }
  end

  def association
    reflection.second.build_association instance_seriazable,
                                        include_data_settings: true
  end
end
