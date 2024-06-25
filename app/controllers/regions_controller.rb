class RegionsController < ApplicationController
    before_action :set_region, only: [:show]
  
    def index
      @regions = Region.all
      @items = Item.page(params[:page]).per(10)

    end
  
    def show
      @pokemons = @region.pokemons
    end
  
    private
  
    def set_region
      @region = Region.find(params[:id])
    end
  end
  