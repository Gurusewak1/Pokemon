class MovesController < ApplicationController
  before_action :set_move, only: [:show]

  def index
    @moves = Move.all
  end

  def show
    @move = Move.find(params[:id])
  end

  private

  def set_move
    @move = Move.find(params[:id])
  end
end
