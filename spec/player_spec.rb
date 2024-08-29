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
      # Simulate invalid input followed by a valid input
      allow(player).to receive(:gets).and_return('a b', '5 5', '0 0')

      expect do
        player.take_turn(opponent_board)
      end.to output(
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Invalid input, coordinates must be numbers between 0 and 4.\n" \
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Invalid input, coordinates must be numbers between 0 and 4.\n" \
        "Alice, choose coordinates to shoot (e.g., 0 0):\n" \
        "Hit !\n"
      ).to_stdout
    end
  end
end
