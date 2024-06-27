class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show]

  def index
    @types = Type.all  

    if params[:type].present?
      type_name = params[:type]
      @pokemons = Pokemon.joins(:types)
                         .where(types: { name: type_name })
                         .where("name_english LIKE ?", "%#{params[:search]}%")
                         .page(params[:page]).per(10)
    elsif params[:search].present?
      @pokemons = Pokemon.where("name_english LIKE ?", "%#{params[:search]}%")
                         .page(params[:page]).per(10)
    else
      @pokemons = Pokemon.page(params[:page]).per(10)
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
