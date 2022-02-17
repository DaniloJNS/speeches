class ConferenceSerializer < ApplicationSerializer
  has_many :tracks

  def tracks
    association_serializer :tracks
  end
end
