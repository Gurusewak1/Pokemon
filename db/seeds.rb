require 'json'
require 'faker'

# Clear existing data in the correct order to avoid foreign key constraint issues
PokemonRegion.delete_all
Type.delete_all
Pokemon.delete_all
Move.delete_all
Region.delete_all

# Load data from JSON file
pokemon_data = JSON.parse(File.read(Rails.root.join('db', 'pokemon.json')))
move_data = JSON.parse(File.read(Rails.root.join('db', 'moves.json')))

# Create Pokemon records
pokemon_data.each do |pokemon|
  name_english = pokemon['name']['english']
  types = pokemon['type']
  base_stats = pokemon['base']

  pokemon_record = Pokemon.create!(
    name_english: name_english,
    pokemon_type: types.join(', '),
    base_hp: base_stats['HP'],
    base_attack: base_stats['Attack'],
    base_defense: base_stats['Defense'],
    base_sp_attack: base_stats['Sp. Attack'],
    base_sp_defense: base_stats['Sp. Defense'],
    base_speed: base_stats['Speed']
  )

  types.each do |type_name|
    type = Type.find_or_create_by!(name: type_name)
    pokemon_record.types << type unless pokemon_record.types.include?(type)
  end
end

# Create Move records
move_data.each do |move|
  Move.create!(
    accuracy: move['accuracy'],
    ename: move['ename'],
    power: move['power'],
    pp: move['pp'],
    move_type: move['type']
  )
end

# Predefined list of region names
regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unova', 'Kalos', 'Alola', 'Galar', 'Isle of Armor', 'Crown Tundra']

# Seed Regions with associated Pokémon from JSON data
regions.each do |region_name|
  region = Region.find_or_create_by!(name: region_name) do |region|
    region.description = Faker::Lorem.paragraph(sentence_count: 2)
  end

  # Seed Pokémon for each region from JSON
  pokemon_data.each do |pokemon_attributes|
    pokemon = Pokemon.find_by(name_english: pokemon_attributes['name']['english'])
    region.pokemon_regions.find_or_create_by!(pokemon: pokemon) if pokemon && !region.pokemons.include?(pokemon)
  end
end
