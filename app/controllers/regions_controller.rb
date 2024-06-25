class RegionsController < ApplicationController
    before_action :set_region, only: [:show]
  
    def index
      @regions = if params[:category_id].present? && params[:search].present?
                   category = Category.find(params[:category_id])
                   category.regions.where('name LIKE ?', "%#{params[:search]}%")
                 elsif params[:category_id].present?
                   category = Category.find(params[:category_id])
                   category.regions
                 elsif params[:search].present?
                   Region.where('name LIKE ?', "%#{params[:search]}%")
                 else
                   Region.all
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
  