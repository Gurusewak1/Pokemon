require 'json'
require 'faker'

# Load data from JSON files
pokemon_data = JSON.parse(File.read(Rails.root.join('db', 'pokemon.json')))
move_data = JSON.parse(File.read(Rails.root.join('db', 'moves.json')))

# Create or update Pokemon records
pokemon_data.each do |pokemon|
  name_english = pokemon['name']['english']
  types = pokemon['type']
  base_stats = pokemon['base']

  pokemon_record = Pokemon.find_or_initialize_by(name_english: name_english)
  pokemon_record.assign_attributes(
    pokemon_type: types.join(', '),
    base_hp: base_stats['HP'],
    base_attack: base_stats['Attack'],
    base_defense: base_stats['Defense'],
    base_sp_attack: base_stats['Sp. Attack'],
    base_sp_defense: base_stats['Sp. Defense'],
    base_speed: base_stats['Speed']
  )
  pokemon_record.save if pokemon_record.changed?

  types.each do |type_name|
    type = Type.find_or_create_by(name: type_name)
    pokemon_record.types << type unless pokemon_record.types.exists?(type.id)
  end
end

# Create or update Move records
move_data.each do |move|
  # Skip moves with invalid power values
  next unless move['power'].is_a?(Numeric) || move['power'].nil?

  move_record = Move.find_or_initialize_by(ename: move['ename'])
  move_record.assign_attributes(
    accuracy: move['accuracy'],
    power: move['power'],
    pp: move['pp'],
    move_type: move['type']
  )
  move_record.save if move_record.changed?

  # Here you need to associate moves with pokemons
  # Assuming a simple logic for seeding purposes
  Pokemon.all.sample(10).each do |pokemon|
    pokemon.moves << move_record unless pokemon.moves.exists?(move_record.id)
  end
end

# Predefined list of region names
regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unova', 'Kalos', 'Alola', 'Galar', 'Isle of Armor', 'Crown Tundra']

# Seed Regions with associated Pokémon from JSON data
regions.each do |region_name|
  region = Region.find_or_initialize_by(name: region_name)
  region.assign_attributes(
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
  region.save if region.changed?

  # Seed Pokémon for each region from JSON
  region.pokemons = []
  pokemon_data.each do |pokemon_attributes|
    pokemon = Pokemon.find_by(name_english: pokemon_attributes['name']['english'])
    region.pokemons << pokemon if pokemon && !region.pokemons.exists?(pokemon.id)
  end
end
