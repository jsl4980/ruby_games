require 'rails_helper'

RSpec.describe TicTacToe, type: :model do
  let(:board) { [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]] }
  let(:p1) { 'Player 1' }
  let(:p2) { 'Player 2' }
  let(:g) { TicTacToe.create(player1: p1, player2: p2) }

  describe '#new' do
    it 'makes a new board' do
      expect(g.board).to eq board.to_json
      expect(g.player1).to eq p1
      expect(g.player2).to eq p2
    end
  end

  describe '#mark' do
    it 'marks the spot on the board' do
      g.mark(1, 1)
      expect(g.board).to eq [[nil, nil, nil], [nil, 'X', nil], [nil, nil, nil]].to_json
    end

    it 'marks the spot with the correct marker' do
      b = board
      expect(g.board).to eq b.to_json
      g.mark(0, 0)
      b[0][0] = 'X'
      expect(g.board).to eq b.to_json
      g.mark(1, 1)
      b[1][1] = 'O'
      expect(g.board).to eq b.to_json
      g.mark(2, 2)
      b[2][2] = 'X'
      expect(g.board).to eq b.to_json
    end
  end

  describe '#swap_current_player' do
    it 'initializes current player to the first player' do
      expect(g.current_player).to eq p1
    end

    it 'swaps current player' do
      expect(g.current_player).to eq p1
      g.send(:swap_current_player)
      expect(g.current_player).to eq p2
      g.send(:swap_current_player)
      expect(g.current_player).to eq p1
    end
  end

  describe '#process_turn' do
    it 'swaps player when game is not over' do
      expect(g).to receive(:swap_current_player)
      g.process_turn
      expect(g.game_state).to eq ''
    end

    it 'does not swap player when game won' do
      allow(g).to receive(:game_won?).and_return true
      expect(g).to_not receive(:swap_current_player)
      g.process_turn
      expect(g.game_state).to eq 'won'
    end

    it 'does not swap player when game won' do
      allow(g).to receive(:board_full?).and_return true
      expect(g).to_not receive(:swap_current_player)
      g.process_turn
      expect(g.game_state).to eq 'tie'
    end

    it 'does marks game won when a player wins' do
      g.board = [['X', 'X', 'O'], ['O', 'X', 'X'], ['O', 'X', 'O']]
      g.process_turn
      expect(g.game_state).to eq 'won' 
    end
  end

  describe '#board_full?' do
    [
        [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
        [['O', nil, nil], [nil, nil, nil], [nil, nil, 'X']],
        [['O', 'X', 'O'], ['X', nil, 'X'], ['O', 'X', 'O']]
    ].each do |board|
      it 'returns no for not full' do
        g.board = board.to_json
        expect(g.board_full?).to eq false
      end
    end

    it 'returns yes when board is full' do
      g.board = [['O', 'X', 'O'], ['X', 'O', 'X'], ['O', 'X', 'O']].to_json
      expect(g.board_full?).to eq true
    end
  end

  describe '#game_won?' do
    context 'not won' do
      [
          [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]],
          [['O', 'O', nil], [nil, nil, nil], ['O', 'X', 'O']],
          [['O', 'X', 'O'], ['X', nil, 'X'], ['O', 'X', 'O']],
          [['O', 'X', 'O'], ['X', 'O', 'X'], ['X', 'O', 'X']]
      ].each do |board|
        it "returns true for losing board: #{board}" do
          g.board = board.to_json
          expect(g.game_won?).to eq false
        end
      end
    end

    context 'yes won' do
      [
          [[nil, nil, nil], [nil, nil, nil], ['O', 'O', 'O']],
          [['X', nil, 'X'], [nil, nil, nil], ['O', 'O', 'O']],
          [[nil, 'X', nil], [nil, 'X', nil], [nil, 'X', nil]],
          [['X', 'X', 'O'], ['O', 'X', 'X'], ['O', 'X', 'O']],
          [['X', nil, nil], [nil, 'X', nil], [nil, nil, 'X']],
          [[nil, nil, 'O'], [nil, 'O', nil], ['O', nil, 'X']]
      ].each do |board|
        it "returns true for winning board: #{board}" do
          g.board = board.to_json
          expect(g.game_won?).to eq true
        end
      end

    end
  end
end
