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

  # Classes Methods
  def self.average_resource
    {
      water: water.average(:ammount),
      food: food.average(:ammount),
      medication: medication.average(:ammount),
      ammunition: ammunition.average(:ammount)
    }
  end

  def self.lost_points
    sum = 0

    where(survivor: Survivor.infected).each do |item|
      sum += item.ammount * item.points
    end

    sum
  end
end
