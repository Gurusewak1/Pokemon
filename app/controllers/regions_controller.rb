class RegionsController < ApplicationController
  before_action :set_region, only: [:show]

  def index
    @regions = if params[:search]
                 Region.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(5)
               else
                 Region.all.page(params[:page]).per(5)
               end
  end

  def show
    @region = Region.find(params[:id])
    @pokemons = @region.pokemons.page(params[:page]).per(10)
  end

  private

  def set_region
    @region = Region.find(params[:id])
  end
end
