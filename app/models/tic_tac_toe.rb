class TicTacToe < ActiveRecord::Base

  def initialize(params={})
    super
    self.board = [[nil, nil, nil],
                  [nil, nil, nil],
                  [nil, nil, nil]].to_json
    self.current_player = player1
    self.current_marker = 'X'
  end

  def mark(x, y)
    b = parsed_board
    b[y.to_i][x.to_i] = self.current_marker
    self.board = b.to_json
    self.save
    process_turn
  end

  def process_turn
    self.update_attributes(game_state: 'won') if self.game_won?
    self.update_attributes(game_state: 'tie') if self.board_full? && !self.game_won?
    swap_current_player if self.game_state.blank?
  end

  def game_over?
    !self.game_state.blank?
  end

  def game_won?
    b = parsed_board
    # Horizontal
    return true if b.reject{|a| a.any?(&:nil?)}.any?{ |a| a.uniq.length == 1 }
    # Vertical
    return true if b.transpose.reject{|a| a.any?(&:nil?)}.any?{ |a| a.uniq.length == 1 }
    # Diagonal
    return true if !b[0][0].nil? && b[0][0] == b[1][1] && b[0][0] == b[2][2]
    # Other Diagonal
    return true if !b[0][2].nil? && b[0][2] == b[1][1] && b[0][2] == b[2][0]
    false
  end

  def board_full?
    !parsed_board.flatten.any?(&:nil?)
  end

  def parsed_board
    JSON.parse(self.board)
  end
  private

  def swap_current_player
    if self.current_player == player1
      self.update_attributes(current_player: player2, current_marker: 'O')
    else
      self.update_attributes(current_player: player1, current_marker: 'X')
    end
  end
end
