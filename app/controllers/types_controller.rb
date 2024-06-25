class TypesController < ApplicationController
  def index
    @types = Type.all
    @items = Item.page(params[:page]).per(10)

  end

  def show
    @type = Type.find(params[:id])
    @pokemons = @type.pokemons
  end
end
