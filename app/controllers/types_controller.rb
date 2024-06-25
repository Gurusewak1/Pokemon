class TypesController < ApplicationController
  def index
    if params[:search].present?
      @types = Type.where("name LIKE ?", "%#{params[:search]}%")
    else
      @types = Type.all
    end
  end

  def show
    @type = Type.find(params[:id])
    @pokemons = @type.pokemons
  end
end
