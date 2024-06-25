namespace :db do
    desc 'Load Pokémon from JSON file'
    task load_pokemons: :environment do
      file = File.read(Rails.root.join('db', 'pokemon.json'))
      pokemons = JSON.parse(file)
  
      pokemons.each do |p|
        pokemon = Pokemon.create!(
          name_english: p['name']['english'],
          pokemon_type: p['type'].join(', ')
        )
  
        p['type'].each do |type_name|
          type = Type.find_or_create_by(name: type_name)
          pokemon.types << type unless pokemon.types.include?(type)
        end
      end
    end
  end
  