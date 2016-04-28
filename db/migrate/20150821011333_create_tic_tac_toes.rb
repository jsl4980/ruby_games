class CreateTicTacToes < ActiveRecord::Migration
  def change
    create_table :tic_tac_toes do |t|

      t.timestamps
    end
  end
end
