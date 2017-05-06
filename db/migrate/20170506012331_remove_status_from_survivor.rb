class RemoveStatusFromSurvivor < ActiveRecord::Migration[5.0]
  def up
    remove_column :survivors, :status
  end

  def down
    add_column :survivors, :status, :integer
  end
end
