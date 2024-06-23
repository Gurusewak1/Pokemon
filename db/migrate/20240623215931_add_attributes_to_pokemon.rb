class AddAttributesToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :name_english, :string
    add_column :pokemons, :type, :string
    add_column :pokemons, :base_hp, :integer
    add_column :pokemons, :base_attack, :integer
    add_column :pokemons, :base_defense, :integer
    add_column :pokemons, :base_sp_attack, :integer
    add_column :pokemons, :base_sp_defense, :integer
    add_column :pokemons, :base_speed, :integer
  end
end
