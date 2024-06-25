class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  def index
    @types = Type.all  # Fetch all types for the dropdown

    @pokemons = if params[:type].present?
      type_name = params[:type]
      Pokemon.joins(:types).where(types: { name: type_name })
             .where("name_english LIKE ?", "%#{params[:search]}%")
    elsif params[:search].present?
      Pokemon.where("name_english LIKE ?", "%#{params[:search]}%")
    else
      Pokemon.all
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @moves = @pokemon.moves_by_type
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
  end
end
