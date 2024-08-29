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

  describe '#place_ships' do
    it 'retries when placing a ship out of bounds or overlapping' do
      # Simulate a series of inputs: out of bounds, overlapping, then valid
      allow(player).to receive(:gets).and_return('5 5 horizontal', '0 0 vertical', '2 2 horizontal')

      expect do
        player.place_ships
      end.to output(
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal', 'vertical', 'diagonal_right', or 'diagonal_left'.\n" \
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Ships cannot overlap, please try again.\n" \
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "S S S - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "Alice, where do you want to place your 4-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n"
      ).to_stdout
    end

    it 'places ships in diagonal orientations correctly' do
      # Simulate inputs for placing ships diagonally
      allow(player).to receive(:gets).and_return('0 0 diagonal_right', '1 1 diagonal_left')

      expect do
        player.place_ships
      end.to output(
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "S - - - -\n" \
        "- S - - -\n" \
        "- - S - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "Alice, where do you want to place your 4-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "S - - - -\n" \
        "- S - - -\n" \
        "S - S - -\n" \
        "- - - S -\n" \
        "- - - - -\n"
      ).to_stdout

      # Validate the ship's positions on the board grid
      expect(player.board.instance_variable_get(:@grid)[0][0]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[1][1]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[2][2]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[1][0]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[2][1]).to eq('S')
      expect(player.board.instance_variable_get(:@grid)[3][2]).to eq('S')
    end

    it 'does not allow placing ships outside the board boundaries' do
      allow(player).to receive(:gets).and_return('6 6 horizontal', '4 4 vertical', '0 0 diagonal_right')

      expect do
        player.place_ships
      end.to output(
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal', 'vertical', 'diagonal_right', or 'diagonal_left'.\n" \
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "Invalid input, must be two numbers between 0 and 4, separated by a space, followed by 'horizontal', 'vertical', 'diagonal_right', or 'diagonal_left'.\n" \
        "Alice, where do you want to place your 3-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n" \
        "S - - - -\n" \
        "- S - - -\n" \
        "- - S - -\n" \
        "- - - - -\n" \
        "- - - - -\n" \
        "Alice, where do you want to place your 4-unit ship? Format: x y orientation (e.g., '0 0 horizontal')\n"
      ).to_stdout
    end
  end
end
