class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender,
             :latitude, :longitude,
             :infection_flags_count,
             :infected?,
             :items
end
