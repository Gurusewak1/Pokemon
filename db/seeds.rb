require 'json'
require 'faker'

# Load data from JSON file
pokemon_data = JSON.parse(File.read(Rails.root.join('db', 'pokemon.json')))
move_data = JSON.parse(File.read(Rails.root.join('db', 'moves.json')))

# Create Pokemon records
pokemon_data.each do |pokemon|
  name_english = pokemon['name']['english']
  types = pokemon['type']
  base_stats = pokemon['base']

  Pokemon.create!(
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

# Create Move records
move_data.each do |move|
  Move.create!(
    accuracy: move['accuracy'],
    ename: move['ename'],
    power: move['power'],
    pp: move['pp'],
    move_type: move['type'] # Use the custom inheritance column name
  )
end

# Predefined list of region names
regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unova', 'Kalos', 'Alola', 'Galar', 'Isle of Armor', 'Crown Tundra']

# Seed Regions with associated Pokémon from JSON data
regions.each do |region_name|
  region = Region.create!(
    name: region_name,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )

  # Seed Pokémon for each region from JSON
  pokemon_data.each do |pokemon_attributes|
    pokemon = Pokemon.find_by(name_english: pokemon_attributes['name']['english'])
    region.pokemons << pokemon if pokemon
  end
end