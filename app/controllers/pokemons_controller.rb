class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  def index
    @pokemons = Pokemon.all
  end

  def show
    @moves = @pokemon.moves_by_type
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
