class CreateSurvivors < ActiveRecord::Migration[5.0]
  def up
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :latitude
      t.string :longitude
      t.integer :status

      t.timestamps null: false
    end
  end

  def down
    drop_table :survivors
  end
end
