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

  scope :infected, (-> { where("infection_flags_count >= 3") })
  scope :non_infected, (-> { where("infection_flags_count < 3") })

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

  # Classes Methods
  def self.total_infected
    total = Survivor.all.count
    infected_total = Survivor.infected.count

    rate = (Float(infected_total) / total) * 100

    rate.round(2)
  end

  def self.total_infected_str
    "#{Survivor.total_infected}%"
  end

  def self.total_non_infected
    total = Survivor.all.count
    non_infected_total = Survivor.non_infected.count

    rate = (Float(non_infected_total) / total) * 100

    rate.round(2)
  end

  def self.total_non_infected_str
    "#{Survivor.total_non_infected}%"
  end

  private

  def fill_inventory
    Item::INITIAL.each do |name, points|
      items.create(name: name, points: points, ammount: 1)
    end
  end
end
