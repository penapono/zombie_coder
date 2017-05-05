class Survivor < ActiveRecord::Base
  # Validations
  validates :name,
            :age,
            :gender,
            :latitude,
            :longitude,
            presence: true
end
