class MovesController < ApplicationController
  before_action :set_move, only: [:show]

  def index
    if params[:search].present?
      @moves = Move.where("ename LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @moves = Move.all.page(params[:page]).per(10)
    end
  end

  def show
    @pokemons = @move.pokemons.page(params[:page]).per(10)
  end

  private

  def set_move
    @move = Move.find(params[:id])
  end
end
