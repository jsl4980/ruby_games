class TicTacToesController < ApplicationController

  def index
  end

  def new
    @tic_tac_toe = TicTacToe.new
  end

  def create
    @tic_tac_toe = TicTacToe.create(t_params)
  end

  def show
    @tic_tac_toe = TicTacToe.find(params[:id])
  end

  def pick
    @tic_tac_toe = TicTacToe.find(params[:id])
    @tic_tac_toe.mark(params[:x], params[:y])
    @tic_tac_toe.reload
  end

  private
  def t_params
    params.require(:tic_tac_toe).permit(:player1, :player2)
  end

end
