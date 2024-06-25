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
  pokemon_record.update!(
    pokemon_type: types.join(', '),
    base_hp: base_stats['HP'],
    base_attack: base_stats['Attack'],
    base_defense: base_stats['Defense'],
    base_sp_attack: base_stats['Sp. Attack'],
    base_sp_defense: base_stats['Sp. Defense'],
    base_speed: base_stats['Speed']
  )

  # Clear existing types to avoid duplicates
  pokemon_record.types.clear
  types.each do |type_name|
    type = Type.find_or_create_by(name: type_name)
    pokemon_record.types << type unless pokemon_record.types.include?(type)
  end
end

# Create or update Move records
move_data.each do |move|
  next unless move['power'].is_a?(Numeric) || move['power'].nil?

  move_record = Move.find_or_initialize_by(ename: move['ename'])
  accuracy = move['accuracy'].is_a?(Numeric) ? move['accuracy'] : 100 # Default accuracy
  pp = move['pp'].is_a?(Numeric) ? move['pp'] : 10 # Default pp
  move_record.update!(
    accuracy: accuracy,
    power: move['power'],
    pp: pp,
    move_type: move['type']
  )

  # Associate moves with Pokemon
  Pokemon.all.sample(10).each do |pokemon|
    PokemonMove.find_or_create_by(pokemon: pokemon, move: move_record)
  end
end

# Predefined list of region names
regions = ['Kanto', 'Johto', 'Hoenn', 'Sinnoh', 'Unova', 'Kalos', 'Alola', 'Galar', 'Isle of Armor', 'Crown Tundra']

# Seed Regions with associated Pokémon from JSON data
regions.each do |region_name|
  region = Region.find_or_create_by!(name: region_name) do |region|
    region.description = Faker::Lorem.paragraph(sentence_count: 2)
  end

  region.pokemons.clear
  pokemon_data.each do |pokemon_attributes|
    pokemon = Pokemon.find_by(name_english: pokemon_attributes['name']['english'])
    region.pokemons << pokemon if pokemon && !region.pokemons.include?(pokemon)
  end
end
