class CreateRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :regions do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :regions, :name, unique: true  # Add uniqueness constraint to the name column
  end
end
