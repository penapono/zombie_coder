class CreateItems < ActiveRecord::Migration[5.0]
  def up
    create_table :items do |t|
      t.string :name
      t.integer :ammount, default: 1
      t.integer :points

      t.references :survivor, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :items
  end
end
