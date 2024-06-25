namespace :db do
    desc 'Fetch Pokémon types from API'
    task fetch_types: :environment do
      require 'net/http'
      require 'json'
  
      url = 'https://pokeapi.co/api/v2/type'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      types = JSON.parse(response)['results']
  
      types.each do |type|
        Type.find_or_create_by(name: type['name'])
      end
    end
  end
  