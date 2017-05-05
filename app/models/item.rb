class Item < ActiveRecord::Base
  # Validations
  validates :name,
            :ammount,
            :points,
            :survivor,
            presence: true

  # Associations
  belongs_to :survivor

  # Scopes
  scope :water, (-> { where(name: 'water') })
  scope :food, (-> { where(name: 'food') })
  scope :medication, (-> { where(name: 'medication') })
  scope :ammunition, (-> { where(name: 'ammunition') })

  # CONSTANTS
  INITIAL = {
    water: 4,
    food: 3,
    medication: 2,
    ammunition: 1
  }.freeze
end
