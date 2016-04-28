class AddStateToTicTacToe < ActiveRecord::Migration
  def change
    add_column :tic_tac_toes, :game_state, :string, default: ''
    TicTacToe.all.each do |t|
      state = t.game_won? ? 'won' : 'tie'
      t.update_attributes(game_state: state)
    end
  end
end
