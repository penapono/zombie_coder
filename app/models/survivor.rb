class Survivor < ActiveRecord::Base
  # Validations
  validates :name,
            :age,
            :gender,
            :latitude,
            :longitude,
            presence: true

  # Associations
  has_many :items, dependent: :destroy

  # Callbacks
  after_create :fill_inventory

  # Methods
  def flag_infected
    increment :infection_flags_count, 1
    save
  end

  def infected?
    infection_flags_count >= 3
  end

  private

  def fill_inventory
    Item::INITIAL.each do |name, points|
      items.create(name: name, points: points, ammount: 1)
    end
  end
end
