require 'board'
require 'ship'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:small_ship) { Ship.new(3) }
  let(:large_ship) { Ship.new(4) }

  before do
    board.place_ship(small_ship, 0, 0, :horizontal)
  end

  describe '#shoot' do
    it 'returns "Hit !" if a ship is hit' do
      expect(board.shoot(0, 0)).to eq('Hit !')
    end

    it 'returns "Miss..." if no ship is hit' do
      expect(board.shoot(4, 4)).to eq('Miss...')
    end

    it 'returns "You sank a ship !" if a ship is sunk' do
      board.shoot(0, 0)
      board.shoot(0, 1)
      expect(board.shoot(0, 2)).to eq('You sank a ship !')
    end

    it 'confirms all ships are sunk' do
      board.shoot(0, 0)
      board.shoot(0, 1)
      board.shoot(0, 2)
      board.shoot(1, 0)
      board.shoot(2, 0)
      board.shoot(3, 0)
      expect(board.all_ships_sunk?).to be true
    end
  end

  describe '#place_ship' do
    it 'does not allow placing a ship out of bounds' do
      expect do
        board.place_ship(Ship.new(3), 3, 3, :horizontal)
      end.to output("Ship out of bounds, please try again.\n").to_stdout
    end

    it 'does not allow placing overlapping ships' do
      expect do
        board.place_ship(Ship.new(3), 0, 0, :vertical)
      end.to output("Ships cannot overlap, please try again.\n").to_stdout
    end

    it 'allows placing a ship diagonally to the right' do
      board = Board.new
      expect do
        board.place_ship(Ship.new(3), 0, 0, :diagonal_right)
      end.to change { board.instance_variable_get(:@grid).flatten.count('S') }.by(3)
    end

    it 'allows placing a ship diagonally to the left' do
      board = Board.new
      expect do
        board.place_ship(Ship.new(3), 2, 2, :diagonal_left)
      end.to change { board.instance_variable_get(:@grid).flatten.count('S') }.by(3)
    end
  end
end
