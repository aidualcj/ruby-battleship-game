require 'player'
require 'board'
require 'ship'

RSpec.describe Player do
  let(:player) { Player.new("Alice") }
  let(:opponent_board) { Board.new }
  let(:ship) { Ship.new(3) }

  before do
    opponent_board.place_ship(ship, 0, 0, :horizontal)
  end

  describe '#take_turn' do
    it 'allows the player to retry if the input is invalid or the shot is out of bounds' do
      allow(player).to receive(:gets).and_return('23', '5 5', '0 0')

      expect do
        player.take_turn(opponent_board)
      end.to output(
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Invalid input, must be two numbers between 0 and 4, separated by a space.\n" \
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Shot out of bounds, try again.\n" \
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Hit !\n"
      ).to_stdout
    end

    it 'provides a hint after three consecutive misses' do
      allow(player).to receive(:gets).and_return('4 4', '3 3', '2 2')
      allow(player).to receive(:give_hint)

      expect(player).to receive(:give_hint).once

      3.times { player.take_turn(opponent_board) }
    end

    it 'does not give a hint if less than three consecutive misses occur' do
      allow(player).to receive(:gets).and_return('4 4', '3 3', '0 0')
      allow(player).to receive(:give_hint)

      expect(player).not_to receive(:give_hint)

      3.times { player.take_turn(opponent_board) }
    end
  end

  describe '#place_ships' do
    it 'retries when placing a ship out of bounds or overlapping' do
      allow(player).to receive(:gets).and_return(
        '5 5 horizontal',  # Out of bounds
        '0 2 diagonal_left', # Valid placement
        '0 0 vertical',    # Overlap
        '0 4 diagonal_left' # Another valid placement
      )

      expect do
        player.place_ships
      end.to output(
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Ship out of bounds, please try again.\n" \
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "- - S - -\n" \
        "- S - - -\n" \
        "S - - - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "Alice, where do you want to place your 4-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Ships cannot overlap, please try again.\n" \
        "Alice, where do you want to place your 4-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "- - S - S\n" \
        "- S - S -\n" \
        "S - S - -\n" \
        "- S - - -\n" \
        "- - - - -\n"
      ).to_stdout
    end
  end
end
