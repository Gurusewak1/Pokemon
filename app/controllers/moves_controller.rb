class MovesController < ApplicationController
  before_action :set_move, only: [:show]

  def index
    if params[:search].present?
      @moves = Move.where("ename LIKE ?", "%#{params[:search]}%")
    else
      @moves = Move.all
    end
  end

  def show
    @pokemons = @move.pokemons
  end

  private

  def set_move
    @move = Move.find(params[:id])
  end
end
