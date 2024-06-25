class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  def index
    @pokemons = Pokemon.all
    @items = Item.page(params[:page]).per(10)

  end

  def show
    @moves = @pokemon.moves_by_type
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
