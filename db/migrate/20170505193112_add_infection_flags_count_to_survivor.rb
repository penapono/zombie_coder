class AddInfectionFlagsCountToSurvivor < ActiveRecord::Migration[5.0]
  def self.up
    add_column :survivors, :infection_flags_count, :integer, default: 0
  end

  def self.down
    remove_column :survivors, :infection_flags_count
  end
end
