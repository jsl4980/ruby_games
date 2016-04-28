class AddBoardAndPlayerToTtt < ActiveRecord::Migration
  def change
    add_column :tic_tac_toes, :board, :string
    add_column :tic_tac_toes, :player1, :string
    add_column :tic_tac_toes, :player2, :string, default: ''
  end
end
