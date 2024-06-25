class PokemonRegion < ApplicationRecord
  belongs_to :pokemon
  belongs_to :region

  validates :pokemon_id, uniqueness: { scope: :region_id }
end
