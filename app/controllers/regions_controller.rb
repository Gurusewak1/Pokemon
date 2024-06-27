class RegionsController < ApplicationController
    before_action :set_region, only: [:show]
  
    def index
      @regions = if params[:search]
                   Region.where('name LIKE ?', "%#{params[:search]}%")
                 else
                   Region.all.page(params[:page]).per(5)
                 end
    end
  
    def show
      @pokemons = @region.pokemons
    end
  
    private
  
    def set_region
      @region = Region.find(params[:id])
    end
  end
  