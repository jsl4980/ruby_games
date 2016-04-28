class AddCurrentPlayerMarkerToTtt < ActiveRecord::Migration
  def change
    add_column :tic_tac_toes, :current_player, :string
    add_column :tic_tac_toes, :current_marker, :string
  end
end
