class RemoveTimestampsFromObjects < ActiveRecord::Migration[5.0]
  def up
    remove_column :survivors, :created_at
    remove_column :survivors, :updated_at
    remove_column :items, :created_at
    remove_column :items, :updated_at
  end

  def down
    add_column :survivors, :created_at, :datetime
    add_column :survivors, :updated_at, :datetime
    add_column :items, :created_at, :datetime
    add_column :items, :updated_at, :datetime
  end
end
