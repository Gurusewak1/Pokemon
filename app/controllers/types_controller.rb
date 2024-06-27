class TypesController < ApplicationController
  def index
    if params[:search].present?
      @types = Type.where("name LIKE ?", "%#{params[:search]}%").page(params[:page]).per(5)
    else
      @types = Type.all.page(params[:page]).per(5)
    end
  end

  def show
    @type = Type.find(params[:id])
    @pokemons = @type.pokemons.page(params[:page]).per(10)
  end
end
