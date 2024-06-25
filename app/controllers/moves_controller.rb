class MovesController < ApplicationController
  before_action :set_move, only: [:show]

  def index
    @moves = Move.all
    @items = Item.page(params[:page]).per(10)

  end

  def show
    @pokemons = @move.pokemons
  end

  private

  def set_move
    @move = Move.find(params[:id])
  end
end
