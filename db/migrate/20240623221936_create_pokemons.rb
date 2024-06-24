class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name_english
      t.string :pokemon_type
      t.integer :base_hp
      t.integer :base_attack
      t.integer :base_defense
      t.integer :base_sp_attack
      t.integer :base_sp_defense
      t.integer :base_speed

      t.timestamps
    end
  end
end
