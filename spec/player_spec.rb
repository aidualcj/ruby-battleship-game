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
      # Simulate incorrect input format, out-of-bounds input, and then a valid input
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
  end
end
