# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

# Load data from JSON file
pokemon_data = File.read(Rails.root.join('db', 'pokemon.json'))
pokemons = JSON.parse(pokemon_data)

# Create Pokemon records
pokemons.each do |pokemon|
  name_english = pokemon['name']['english']
  types = pokemon['type']
  base_stats = pokemon['base']

  Pokemon.create(
    name_english: name_english,
    pokemon_type: types.join(', '),
    base_hp: base_stats['HP'],
    base_attack: base_stats['Attack'],
    base_defense: base_stats['Defense'],
    base_sp_attack: base_stats['Sp. Attack'],
    base_sp_defense: base_stats['Sp. Defense'],
    base_speed: base_stats['Speed']
  )
end

# Load move data from JSON file
move_data = File.read(Rails.root.join('db', 'moves.json'))
moves = JSON.parse(move_data)

# Create Move records
moves.each do |move|
  Move.create(
    accuracy: move['accuracy'],
    ename: move['ename'],
    power: move['power'],
    pp: move['pp'],
    move_type: move['type'] # Use the custom inheritance column name
  )
end
